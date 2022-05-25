# Awesome File System

A simple filesystem application.

You can see a example deployed on: https://awesomefilesystem.herokuapp.com

* Ruby version
    - 3.1.2
* Rails version
    - 7.0.3
* Database
    - The project is default configured with **postgresql** database and **gem pg**
    - You can change the database adapter on **database.yml**. Remember to add the required dependencies

* Database configuration:

    ````
    $ rake db:create
    $ rake db:migrate

* How to run the test suite
    ````
    $ rspec
