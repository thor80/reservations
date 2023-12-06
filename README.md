# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  
  3.0.4

* Database creation

  To delete database
    ```sh
    rails db:drop
    ```
  To create database
    ```sh
    rails db:migrate
    ```

* Before running the server for first time

    ```sh
    rails assets:clobber
    bundle install
    yarn install
    rails server
    ```
* Files that are upload on the profile are stored in 
    ```sh
    app/public/uploads/{id_user}/name_of_the_image.jpg
    ```
