# Caravan Development Enviroment
This is a localized, docker centric container setup that is heavily inspired by laradock. The idea is to help Perl developers create magic with Mojolicious web framework while at the same time offering some sane additional infastructure bits that you would commonly see in today modern ecosystem.

This is a labour or love and evergreen in nature and will keep adding new pieces as my projects evolve.

## Local Setup

1. Clone this repo to your local machine
2. Change to the root directory and execute `./caravan`
  a. Caravan will also prompt you to generate a Mojolicious application if it does not find one
3. Edit /etc/hosts and add the following domains mapped to `127.0.0.0.1`:
    - caravan.local
    - s3.caravan.local
    - minion.caravan.local
    - pgadmin.caravan.local
    - mail.caravan.local
4. Spin up docker and go grab a coffee, this can take a bit:
```bash
$ cd docker && docker-compose up -d
```
5. Once docker complete you should have all the containers loaded up and ready for you to make some magic.

## URL's of interest
Once your `/etc/hosts` file is set up you are ready to access the enviroment once it up and running. Below is a table with description of each of the URL's available. To faciliate the more modern web development realities, HTTPS is enabled by default and all the magic is already done for you in the nginx container with generated Let's Encrypt free SSL certificates.

<table>
 <tr>
  <th>URL</th>
  <th>Description</th>
 </tr>
 <tr>
  <td><a href="https://caravan.local" target="_blank">https://caravan.local</a></td>
  <td>Main site for your application. All static files go into the <b>public</b> folder while your application is served via the <b>/api</b> subdirectory</td>
 </tr>
 <tr>
  <td><a href="https://mail.caravan.local" target="_blank">https://mail.caravan.local</a></td>
  <td>Local mailtrap with a web interface to help see the emails the application generates</td>
 </tr>
 <tr>
  <td><a href="https://minion.caravan.local/minion" target="_blank">https://minion.caravan.local/minion</a></td>
  <td>Stand-alone minion queue on a postgres database for best performance</td>
 </tr>
 <tr>
  <td><a href="https://pgadmin.caravan.local" target="_blank">https://pgadmin.caravan.local</a></td>
  <td>Postgres web administration tool for easy viewing of the databases</td>
 </tr>
 <tr>
  <td><a href="https://s3.caravan.local" target="_blank">https://s3.caravan.local</a></td>
  <td>AWS S3 Storage (minio) clone for your heavier digital binaries that you may not want being served by the webserver</td>
 </tr>
 <tr>
  <td><a href="https://rendertron.caravan.local" target="_blank">https://rendertron.caravan.local (<b>coming soon</b>)</a></td>
  <td>A dedicated prerender service to generate web crawler compatible HTML for Javascript first sites that generate all thier HTML client side.</td>
 </tr>
</table>

## Administration and Usage
This development enviroment comes already with a postgres database server cooked in and available to your application. It is used by Minion to store jobs when needed so it makes it easy for developers to focus on creating great things instead of chasing down databases. This section will dive a bit deeper into each container to help you understand how it is configured which may or may not be easily deciphered from the ```docker-compose.yml``` and ```.env``` files.

### Main site (https://caravan.local)
This site is served from the ```/api``` directory, via a nginx reverse_proxy. It is already configured to strip away the top level directory from the asking URL to ensure that it maps nicely to your application routes. You should not experience any issues but please log an issue if you do.

There is already a few modules loaded in this application container to ensure that is compatible with the Caravan ecosystem. You are more than able to add more but below is a list of itemized modules that have been installed;

* App::cpanminus
* Mojolicious (of course)
* Cpanel::JSON::XS
* DBI
* EV
* Future::AsyncAwait
* IO::Socket::Socks
* Net::SSLeay
* IO::Socket::SSL
* Net::DNS::Native
* Role::Tiny
* SQL::Abstract
* Minion
* Mojo::Pg (DBD::Pg included)
* Mojo::SQLite (DBD::SQLite included)
* Email::Send::SMTP
* Amazon::S3

**Note:** Keep in mind these are heavy packages (close to 82 modules installed in total) so do not be surprised if when you try to install modules they are already present. 

To add more modules you will need to bash into in container with the following command;
```bash
docker-compose exec application bash
```
you will be greated with a user prompt where you have access to add any modules you like via cpanm. Since this is docker you will be running at root to make things easier in the install. 

**Permissions:** When creating files in the container with the aforementioned method in your ```app``` directory. Any files created will have elevated permissions (since you are running at root in the container ) which will give you some headaches. If you need to add files in your application directory it is advisable to not do it this way. Use the file system you see in your file explorer since this is already mapped correct into the container and will have the same permission and owned by you in case you want to delete or move them around in the future.

#### Static Assets and Application serving
The only real oddity here is that your application ```app``` folder does not contain the typical ```public``` directory. This is actually on purpose since we are using nginx as a reverse proxy and the public folder was promoted to as a sibling of the ```app``` folder to be both location and visually distinct. The reason this is done is to allow for modern day generation tools like VueJS, React, Angular, to have a discreet folder to do its work that is not in the perl focused ```app``` folder. Many of these tools default to looking for a ```public``` folder at the root of the project so it makes it easier and it just works to do it like this. This can be configured via the nginx sites/default.conf file. 

The application itself is located in the ```app/script``` folder which was generated by  Mojolicious comes with a default large application setup. This application is mapped to the ```/api``` directory to support a common web architecture setup where front end frameworks will call an api for data which is then rendered client side. This is known as a Javascript first application approach and commonly used by emerging websites since it lessens the burden on infastructure since most of the heavy lifting in rendering is done on the client side. This has it pro's and it's cons and if you are concerned about Search Engine Optimization (SEO) then you may want to consider a pre-rendering service to help make these Javascript first sites more accessible to the crawlers. It is on the roadmap to add **Rendertron** as a supporting image to allow for developers to test out how thier sites behave with crawlers and to ease the setup with common webservers like nginx.



## Default Password
Throughout the development enviroment there are logins to various tools and/or databases. To simplify all the username/keys and passwords are the same as shown below:

field    | value
-----    | -----
Username | `admin@caravan.local`
Password | `hush-hush`






