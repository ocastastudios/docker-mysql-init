# Inititialize a Database

Docker image to run once to create a new database with a new user.

Environment variables:

    - DB_HOST
    - ROOT_USER
    - ROOT_PASSWORD
    - NEW_DATABASE
    - NEW_USER
    - NEW_PASSWORD

E.g.

    docker run -e DB_HOST=mariadb -e ROOT_USER=root -e ROOT_PASSWORD=mypass -e NEW_DATABASE=newdb1 -e NEW_USER=newuser1 -e NEW_PASSWORD=password --link mariadb -d ocasta/mysql-init

Note
----

The Database hostname is now expected in the environment variable DB_HOST rather than SERVER
