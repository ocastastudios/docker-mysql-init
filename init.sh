#!/bin/sh
mysql -u $ROOT_USER -p$ROOT_PASSWORD -h $SERVER --connect_timeout 10 -e "CREATE DATABASE $NEW_DATABASE;"
mysql -u $ROOT_USER -p$ROOT_PASSWORD -h $SERVER --connect_timeout 10 -e "grant usage on *.* to $NEW_USER identified by '$NEW_PASSWORD';"
mysql -u $ROOT_USER -p$ROOT_PASSWORD -h $SERVER --connect_timeout 10 -e "grant all privileges on $NEW_DATABASE.* to $NEW_USER;"
