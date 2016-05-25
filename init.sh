#!/bin/sh
echo 'Creating database...'
mysql -u $ROOT_USER -p$ROOT_PASSWORD -h $SERVER --connect_timeout 10 -e "CREATE DATABASE $NEW_DATABASE;"
echo 'Done.'
echo 'Creating user...'
mysql -u $ROOT_USER -p$ROOT_PASSWORD -h $SERVER --connect_timeout 10 -e "grant usage on *.* to $NEW_USER identified by '$NEW_PASSWORD';"
echo 'Done.'
echo 'Granting user privileges...'
mysql -u $ROOT_USER -p$ROOT_PASSWORD -h $SERVER --connect_timeout 10 -e "grant all privileges on $NEW_DATABASE.* to $NEW_USER;"
echo 'All done.'
