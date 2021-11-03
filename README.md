# additional_apache_configs
## What is .htaccess? 
- It is a configuration file used by apache-based web servers.  

Configuration files configure the initial settings of a program, or in this case the server. This means that the .htaccess file can be used to make the server behave in a certain way. Each function is basically just a line of text, or code, which tells the server what to do. You can add or change functionality by adding or changing the code in the .htaccess file.

## What can you use .htaccess for?  
There are a lot of possibilities with .htaccess, you can, for example, use it to:  
- Protect your site with a password.
- Create a custom-made error page.
- Redirect visitors to another page.

# Submission
You will commit the following files:  
- User directory which contains
  - public_html/index.html file
  - public_html/Dev/index.html file
  - public_html/Dev/.htaccess file
- vHost directory which contains
  - site1.conf vHost file
  - site2.conf vHost file
  - site3.conf vHost file
- Dockerfile 

# Password Protected Dev Folder
We can place a .htaccess file into a folder we wish to protect via a password.  For the first part of this assignment you are required to create such a .htaccess file and place it into a folder that you wish to password protect. Follow the following steps:
- Create a user 
- Create a `public_html` directory in the users working tree
- Write a simple index.html file to place inside your users `public_html` directory
- Create a directory called `Dev` inside the `public_html` directory (full path would be /home/user/public_html/Dev)
- Write a simple index.html file that contains some potentially confidential information i.e. A list of internal department phone numbers
- Place a .htaccess file in the `Dev` directory which requires a password to view the contents of the directory
- Test your .htaccess file locally

# Hosting Multiple Domains
Apache vHost files allow us to serve multiple websites/web applications from one server. One way is with [Name Based](https://httpd.apache.org/docs/2.4/vhosts/name-based.html) routing, whcih the server relies on the client to report the hostname as part of the HTTP headers. Using this technique, many different hosts can share the same IP address. A second option is [IP Based](https://httpd.apache.org/docs/2.4/vhosts/ip-based.html) routing IP-based is a method to apply different directives based on the IP address and port a request is received on. Most commonly, this is used to serve different websites on different ports or interfaces.

For the next part of the assignment we are going to host multiple websites with one instance of Apache. 
This stage will require you to create the following:
- Three index.html file's one for each domain
- Create 3 directory under `/var/www/html` to host your 3 websites and place your index.html files in the corresponding directories. 
- Three vHost files:
  - site1.conf
    - Using the domain name site1.internal
    - Update DocumentRoot
    - Add an Alias Directive for the user you created in the previous step
  - site2.conf
    - Using the domain name site2.internal
    - Update DocumentRoot
  - site3.conf
    - Using the domain name site3.internal
    - Update DocumentRoot
- Update the `/etc/hosts` file and add the 3 domain's listed above
  - The /etc/hosts file contains the Internet Protocol (IP) host names and addresses for the local host and other hosts in the Internet network. This file is used to resolve a name into an address (that is, to translate a host name into its Internet address).
- Test your sites by running: `curl site.internal`

Normally you would update the /etc/hosts file when setting up a server. Since we are using Docker we can specify a flag which will add hosts to the `/etc/hosts` file when we run a container. 

# Dockerfile
The last step is to create a Dockerfile which copies the files listed above into the correct locations on the file system and you should be able to do the following:
- Build your docker image
- Run your docker image 
- Test via CLI or browser

Normally you would update the /etc/hosts file when setting up a server, as we did in a previous step. However, Docker has provided a flag that will update the `/etc/hosts` file when a container is run. 

Example docker command with `--add-host` flag:
```
docker run --rm -it --add-host="site1.internal:127.0.0.1" -p 8080:80 docker_image /bin/bash
```
Hint: You can specify multiple `--add-host` flags 

