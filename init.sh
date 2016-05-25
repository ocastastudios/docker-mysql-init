#!/bin/sh
sleep 5
mysql -u $ROOT_USER -p$ROOT_PASSWORD -h $SERVER -e "CREATE DATABASE $NEW_DATABASE;"
mysql -u $ROOT_USER -p$ROOT_PASSWORD -h $SERVER -e "grant usage on *.* to $NEW_USER identified by '$NEW_PASSWORD';"
mysql -u $ROOT_USER -p$ROOT_PASSWORD -h $SERVER -e "grant all privileges on $NEW_DATABASE.* to $NEW_USER;"
