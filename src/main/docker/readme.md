# How to run the Application in a Docker container
To run the application in a Docker container take the following steps:

1. Copy the entire bin and prototype directory to the home directory on 
   the host machine where you want to run ythe prototype inside docker.

   Running `ls -l` should give you something like:
```
        total 28
        drwxrwxr-x 2 ec2-user ec2-user  4096 Jul  2 19:49 bin
        drwxrwxr-x 4 ec2-user ec2-user  4096 Jul  2 19:13 prototype
```   
   
2. From your home directory run
```
        chmod 755 bin/*.sh`
```
3. Install docker, start docker, and build your Docker image from a 
   standard CentOS 6.6 Docker image by running
```
        sudo ./bin/build-prototype.sh`. 
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
      curl -l localhost -o home-page.html`
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
          <meta name="title" content="Drug Adverse Event Browser">
          ....
      </head>
      ...
      </html>
```

**NOTE**: These steps assume you are using Red Hat derivative, specifically CentOS 6.6, as the host machine. 
