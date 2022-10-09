#!/bin/bash
#This script creates a user in the local system

# Make sure the script is being executed with superuser privileges.
if [[ ${UID} -ne 0 ]]
then
   echo "Access denied. This script should be used by an Admin."
   exit 1;
else
   echo "System Admin recognized."
fi

# Get the username (login).
read -p "New User's username: " USER_NAME

# Get the real name (contents for the description field).
read -p "New User's real name: " COMMENT

# Get the password.
read -p "New User's Password: " PASSWD

# Create the user with the password.
useradd -c "${COMMENT}" ${USER_NAME}

# Check to see if the useradd command succeeded.
if [[ ${?} != 0 ]]
then
   echo "Error: The user could not be created succesfully.";
   exit $?;
else
   echo "User account ${USER_NAME} created succesfully.";
fi

# Set the password.
echo $PASSWD | passwd --stdin $USER_NAME

# Check to see if the passwd command succeeded.
if [[ ${?} != 0 ]]
then
   echo "Error: The password could not be created succesfully.";
   exit $?;
else
   echo "The password was set.";
fi

# Force password change on first login.
passwd -e $USER_NAME

# Display the username, password, and the host where the user was created.
echo "Username: ${USER_NAME} - Password: ${PASSWD} - Hostname: ${HOSTNAME}";
