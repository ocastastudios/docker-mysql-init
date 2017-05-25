#!/bin/bash
#
set -euo pipefail

# usage: file_env VAR [DEFAULT]
#    ie: file_env 'XYZ_PASSWORD' 'example'
# (will allow for "$XYZ_PASSWORD_FILE" to fill in the value of
#  "$XYZ_PASSWORD" from a file, especially for Docker's secrets feature)
file_env() {
	local var="$1"
	local fileVar="${var}_FILE"
	local def="${2:-}"
	if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
		echo >&2 "error: both $var and $fileVar are set (but are exclusive)"
		exit 1
	fi
	local val="$def"
	if [ "${!var:-}" ]; then
		val="${!var}"
        export "$var"="$val"
	elif [ "${!fileVar:-}" ]; then
		val="$(< "${!fileVar}")"
        export "$var"="$val"
	fi
	unset "$fileVar"
}


envs=(
	ROOT_USER
    ROOT_PASSWORD
	DB_HOST
	NEW_DATABASE
	NEW_USER
	NEW_PASSWORD
)

for e in "${envs[@]}"; do
	file_env "$e"
done

export 
if [ -z ${ROOT_USER+x} ]; then echo "ROOT_USER is unset"; exit 1; fi
if [ -z ${ROOT_PASSWORD+x} ]; then echo "ROOT_PASSWORD is unset"; exit 1; fi
if [ -z ${DB_HOST+x} ]; then echo "DB_HOST is unset"; exit 1; fi
if [ -z ${NEW_USER+x} ]; then echo "NEW_USER is unset"; exit 1; fi
if [ -z ${NEW_PASSWORD+x} ]; then echo "NEW_PASSWORD is unset"; exit 1; fi

echo 'Waiting, to give containers time to link...'
sleep 10
echo 'Creating database...'
mysql -u $ROOT_USER -p$ROOT_PASSWORD -h $DB_HOST --connect_timeout 10 -e "CREATE DATABASE $NEW_DATABASE;"
echo 'Done.'
echo 'Creating user...'
mysql -u $ROOT_USER -p$ROOT_PASSWORD -h $DB_HOST --connect_timeout 10 -e "grant usage on *.* to $NEW_USER identified by '$NEW_PASSWORD';"
echo 'Done.'
echo 'Granting user privileges...'
mysql -u $ROOT_USER -p$ROOT_PASSWORD -h $DB_HOST --connect_timeout 10 -e "grant all privileges on $NEW_DATABASE.* to $NEW_USER;"
echo 'All done.'
