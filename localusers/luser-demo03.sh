#!/bin/bash

#Display the UID and username of the user executing this script
#Display if the user is the vagrant user or not.

#Disply the UID
echo "Your UID is ${UID}";

#Only display if the UID does NOT match 1000(is not vagrant user)
UID_TESTING="1000";
if [[ "${UID}" -ne "${UID_TESTING}" ]]
then
   echo "Your UID does not match ${UID_TESTING}.";
#   exit 1;
fi


#Display the usernme.
USER_NAME="$(id -u -n)";
#Test if the command succeded.
if [[ "${?}" -ne 0 ]] #The special var $? stores the exit status of the mos recently executed command.
then
   echo "The id command did not execute succesfully.";
   exit 1;
fi

echo "Your username is ${USER_NAME}";

# You can use a string test conditional.
USER_TESTING="vagrant";

if [[ ${USER_NAME} = ${USER_TESTING} ]]
then
   echo "Your username matches ${USER_TESTING}";
fi

#Test for != (Not Equal) for the string

if [[ ${USER_NAME} != ${USER_TESTING} ]]
then
    echo "Your username does not match ${USER_TESTING}";
    exit 1
fi

exit 0
