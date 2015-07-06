# How to Run the Application in Docker

## Scripted Process

### Prerequisites
1. CentOS 6.6 host server (other Red Hat derivatives may also work, but have not been tested).
2. Server must allow outbound TCP traffic on ports 22, 80 and 443 and accept return traffic 

### Steps

To setup the application in a Docker container take the following steps:

1. Copy the entire [bin](bin) and [prototype](prototype) directories to the home directory on the host machine where you want to run the prototype inside docker.
   
   Running `ls -l` should give you something like:
   
```
        total 28
        drwxrwxr-x 2 ec2-user ec2-user  4096 Jul  2 19:49 bin
        drwxrwxr-x 4 ec2-user ec2-user  4096 Jul  2 19:13 prototype
```
   
2. From your home directory run
   
```
        chmod 755 bin/*.sh
```

3. Install docker, start docker, and build your Docker image from a 
   standard CentOS 6.6 Docker image by running the following command,
   where `branch_name` is `master`, `test`, or `integration` (if you
   don't specify a branch, it will default to `master`):
```
        sudo ./bin/build-prototype.sh [--branch branch_name]
```
4. Run `sudo docker images`.
   
   This should yield a list of (at least) the following 2 images (prototype/latest and centos/6.6), that looks something like:
```
       REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
       prototype           latest              be86e9e1fcf2        18 minutes ago      700.2 MB
       <none>              <none>              2775af3998b2        25 minutes ago      700.2 MB
       centos              6.6                 8b44529354f3        10 weeks ago        202.6 MB
```
5. Now start you container from the newly created image:
```
      sudo ./bin/start-prototype.sh
```
6. You should now have the prototype running in Docker. 
   You can test by running 
```
      curl -l localhost -o home-page.html
```
   This will save the application home page HTML document in file home-page.html. The contents of this file should start with something like:
```
      <!DOCTYPE html>
      <html lang="en">
      <head>
          <meta charset="utf-8">
          <meta http-equiv="X-UA-Compatible" content="IE=edge">
          <meta name="viewport" content="width=device-width, initial-scale=1">
          ...
          <title>Drug Reaction Finder</title>
          ...
      </head>
      ...
      </html>
```

### Notes

* The container uses a mounted volume. You can find the location of the volume by running:
```
    container_id=`sudo docker ps -q`; sudo docker inspect $container_id | grep "\"/var/www/gsa-ads\": \""
```
   This returns a list that contains the mappings of the directory, that our container hosts the application code in (`/var/www/gsa-ads`), to a directory local to the host (e.g. 
```
   /var/lib/docker/vfs/dir/54f07f93b31e3bd1d15c6823fd6321b5806649fd89b88c6305c750043b750b4b
```
* You can make changes to the application's code by modifying the files in the directory local to the host. Some changes may require a restart of the container using `sudo docker restart $container_id`


## Manual Process

**These steps** are a reflection of the automated process, but are **untested** when used manually in other host operating systems.

### Prequisites

1. Docker is already installed on your host server and the docker daemon is already running
2. You can use docker as an unprivileged user or know ho to run the below commands as a privileged user.

### Steps

1. Create a git clone locally (or download the repository as a zip file)
2. Copy the `src/main/docker/prototype` directory to a local directory.
3. Copy the `src/main/chef` and `src/main/php` directories into the local copy of the `prototype` directory.
4. Run `docker build --tag=prototype --rm=true --force-rm=true "/path/to/the/local/prototype/directory"`
5. Run `docker run -p 80:80 -d prototype`.
   Replace 80:80 with <your host HTTP port>:80, if your host is not accepting HTTP traffic on port 80.


