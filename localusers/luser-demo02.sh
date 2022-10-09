#!/bin/bash

#Display the UID and Username of the user excecuting this script.
#Display if the user is the root user or not.

#Display the UID:
echo "Your UID is ${UID}"; #UID is a pre-assigned ID variable given by Bash.

#Display the username:
USER_NAME=$(id -un); #To use the output of a command in a variable, you have to specify the command inside parentheses.
echo "Your username is ${USER_NAME}";

#Display if the user is the root user or not.
if [[ ${UID} -eq 0 ]] 
then
  echo "You are root.";
else
  echo "You are NOT root.";
fi
