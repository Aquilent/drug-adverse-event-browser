# How to run the Application in a Docker container
To run the application in a Docker container take the following steps:

1. Copy the entire bin and prototype directory to the home directory on 
   the host machine where you want to run ythe prototype inside docker.
2. From your home directory run `chmod 755 bin/*.sh`
3. Install docker, start docker, and build your Docker image from a 
   standard CentOS 6.6 Docker image by running `sudo ./bin/build-prototype.sh`. 
4. Run "sudo docker images". 
   This should yield a list of (at leats) the following 2 images:
    `    REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
    prototype           latest              be86e9e1fcf2        18 minutes ago      700.2 MB
    <none>              <none>              2775af3998b2        25 minutes ago      700.2 MB
    centos              6.6                 8b44529354f3        10 weeks ago        202.6 MB`
5. Now start you container from the newly created image:
     `sudo docker -d -p 80:80 prototype`
6. You should now have the prototype running in Docker. 
   You can test by running `curl -l localhost`
   This will return the HTML document for the home page. E.g.
       `    <!--<meta name="description" content="Could the medicine you are taking cause an 
                adverse reaction? Find out using our Possible Drug Reaction Finde
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navb
            <p>Prescription and over-the-counter (OTC) drugs can sometimes cause a problem when taken alone or with other drugs. These are reported as
</html>[ec2-user@ip-172-100-150-99 ~]$ </script>r include individual files as needed -->ript>="openFDA logo" /></a>quilent logo" /></a><br />`

**NOTE**: These steps assume you are using Red Hat derivative, specifically CentOS, as the host machine. 
