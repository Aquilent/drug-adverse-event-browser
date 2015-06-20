#!/bin/bash

function Common_convertPath {
  local path=$1
  path1=`echo $path | sed 's@\\\@\/@g'`
  path2=`echo $path1 | sed 's@^\([a-zA-Z]\):@\/\1@g'`
  echo $path2
}

BRANCH_HOME=`Common_convertPath ${BRANCH_HOME}`

echo BRANCH_HOME=${BRANCH_HOME}

SCRIPTS="create-stack.cmd"
SCRIPTS="${SCRIPTS} create-stack.sh"
SCRIPTS="${SCRIPTS} putty-ssh-jumpbox.cmd"
SCRIPTS="${SCRIPTS} setenv.cmd-template"
SCRIPTS="${SCRIPTS} upload-certificates.cmd"

ARCHIVE_NAME="gsa-ads"
ARCHIVE_BASE="${BRANCH_HOME}/target"
ARCHIVE_HOME="${ARCHIVE_BASE}/${ARCHIVE_NAME}"
ARCHIVE_FILENAME="${BRANCH_HOME}/target/${ARCHIVE_NAME}.tar.gz"

mkdir -p "${ARCHIVE_HOME}"
if [ -d "${ARCHIVE_HOME}" ]; then
    rm -rf "${ARCHIVE_HOME}"
fi
rm -f "${ARCHIVE_FILENAME}"
mkdir -p "${ARCHIVE_HOME}"

echo "---- Creating scripts directory ------"
mkdir -p "${ARCHIVE_HOME}/bin"

for file in ${SCRIPTS}; do
    #echo "Adding ${file}"
    cp -f "${BRANCH_HOME}/bin/${file}" "${ARCHIVE_HOME}/bin/${file}"
done

echo "---- Creating main source directory ------"
mkdir -p "${ARCHIVE_HOME}/src"
cp -rf "${BRANCH_HOME}/src/main" "${ARCHIVE_HOME}/src"

echo "---- Creating configration directory ------"
mkdir -p "${ARCHIVE_HOME}/config"
mv -f "${ARCHIVE_HOME}/src/main/stack-configuration-template.ini" "${ARCHIVE_HOME}/config/"


tar -zcvf "${ARCHIVE_FILENAME}" --directory="${ARCHIVE_BASE}" "${ARCHIVE_NAME}"

rm -rf "${ARCHIVE_HOME}"

