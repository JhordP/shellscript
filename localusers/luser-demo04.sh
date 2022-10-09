#!/bin/bash

#This script creates an account on the local system.
#You will be prompted for the account nme and password.

#Cleans the console
clear
#Ask for the username.
read -p "Enter the username to create: " USER_NAME

#Ask for the real name.
read -p "Enter your name: " COMMENT

#Ask for the password
read -p "Set the password for this account: " PASSW

#Create the user.
useradd -c "${COMMENT}" -m ${USER_NAME}

#Set the password for the user.
echo ${PASSW} | passwd --stdin ${USER_NAME}

#Force password change on first login
passwd -e ${USER_NAME}

