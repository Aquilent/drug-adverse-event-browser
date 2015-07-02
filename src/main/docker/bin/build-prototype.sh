#!/bin/sh

if [ "${BUILD_HOME}" == "" ]; then 
    BUILD_HOME=`pwd`
fi

NAME="prototype"
BRANCH=master
BOOTSTRAP_HOME=

function setup_ssh_agent {
    eval `ssh-agent -s`> /dev/null
}

function kill_ssh_agent {
    if [ ${SSH_AGENT_PID+1} == 1 ]; then
       ssh-add -D
       ssh-agent -k > /dev/null 2>&1
       unset SSH_AGENT_PID
       unset SSH_AUTH_SOCK
    fi
}

function get_parameters {
    while test $# -gt 0; do
        case $1 in
          --certificate|-c)     shift; CERTIFICATE="$1"; echo "Using certificate'${CERTIFICATE}'" ;;
          --branch|-b)          shift; BRANCH="$1"; echo "Using branch '${BRANCH}'" ;;
          --build-only)         BUILD_ONLY=true ;;
          --name|-n)            shift; NAME="$1" ;;
          *)                    echo "Do not recognize argument '$1'. Ignoring." ;;
        esac
        shift
    done
}

function validate {
    if [ ! -d "$BUILD_HOME/${NAME}/" ]; then
        echo "Docker directory '${NAME}' does not exist in '$BUILD_HOME'"
        exit 1
    elif [ ! -f "$BUILD_HOME/${NAME}/Dockerfile" ]; then
        echo "Docker build file 'Dockerfile' does not exist in '$BUILD_HOME/${NAME}'"
        exit 2
    elif [ ! -f "$BUILD_HOME/${NAME}/chef-config.json" ]; then
        echo "Chef config file 'chef-config.json' does not exist in '$BUILD_HOME/${NAME}'"
        exit 3
    fi
}

function initialize {
    get_parameters "$@"
    validate
    yum install -y docker unzip wget git
}

function install_docker {
    local running=`service docker status | grep "running"`
    if [ "${running}" != "" ]; then
        service docker stop
    fi
    service docker start
}

function install_chef_repos {
    local url=ssh://git@github.com/Aquilent/drug-adverse-event-browser.git

    if [ "${CERTIFICATE}" != "" ]; then
        setup_ssh_agent
        ssh-add -t 120 "${CERTIFICATE}"
    fi

    mkdir -p /tmp/gsa-ads
    pushd /tmp/gsa-ads

    if  [ -d ./drug-adverse-event-browser ]; then
       rm -rf ./drug-adverse-event-browser
    fi

    echo "Cloning $url;"
    git clone --branch $BRANCH $url

    if [ "${CERTIFICATE}" != "" ]; then
        kill_ssh_agent
    fi
    if [ -d "$BUILD_HOME/${NAME}/chef" ]; then
        echo "Removing old prototype Chef scripts"
        rm -rf "$BUILD_HOME/${NAME}/chef"
    fi
    if [ -d "$BUILD_HOME/${NAME}/php" ]; then
        echo "Removing old prototype PHP scripts"
        rm -rf "$BUILD_HOME/${NAME}/php"
    fi

    echo "Installing prototype Chef scripts"
    ls -al ./drug-adverse-event-browser/src/main
    mv -f ./drug-adverse-event-browser/src/main/chef/ "$BUILD_HOME/${NAME}/"
    mv -f ./drug-adverse-event-browser/src/main/php/ "$BUILD_HOME/${NAME}/"
    popd
    if  [ -d ./drug-adverse-event-browser ]; then
       rm -rf ./drug-adverse-event-browser
    fi
}

function build_image {
    echo "Build '${NAME}'' in $BUILD_HOME"
    docker build --tag=${NAME} --rm=true --force-rm=true "$BUILD_HOME/${NAME}"
}


initialize "$@"

if [ "${BUILD_ONLY}" == "" ]; then
    install_docker
    install_chef_repos
fi

build_image
