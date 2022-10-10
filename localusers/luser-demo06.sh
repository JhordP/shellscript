#!/bin/bash

# This script generates a random password for each user specified on the command line

# Display what the user typed on the command line
echo "You executed this command: ${0}";

# Display the path and filename of the script.
echo "You used $( dirname ${0}) as the path to the $(basename ${0}) script.";

# Tell them how many arguments they passed in.
# (Inside the script they are parameters, outside they are arguments)
echo "You supplied $# argument(s) on the command line.";

# Make user they at least supplied one argument.
if [[ "${#}" -lt 1 ]]
then
	echo "Usage: ${0} USER_NAME [USER_NAME(S)...]";
	exit 1;
fi

# Generate and display a password for each parameter.
for USER_NAME in "${@}"
do
	SPECIAL_CHARS=$( echo "!@#$%^&*()_-+=" | fold -w1 | shuf | tail -n 1 )
	PASSWORD="$( date +%N | sha1sum | head -c 6 )${SPECIAL_CHARS}${RANDOM}";
	echo "USERNAME: ${USER_NAME}"; echo "PASSWORD: $PASSWORD"; echo;
done
