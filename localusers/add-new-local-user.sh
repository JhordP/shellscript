#!/bin/bash
###Jhordany Polanco###
##THIS SCRIPT CREATES AN USER ON THE LOCAL SYSTEM AND PROVIDE A RANDOM PASSWORD TO IT.##

echo "Validating access..."; #sleep 1.5s;

#Validate root privileges.
if [[ ${UID} -ne 0 ]]
then
	echo "Access Denied. Program was not executed as an system administrator.";
	exit 1;
else
	echo "Accessed by admin account successfully.";
fi

#Confirm that the user provides an username as an argument.
if [[ ${#} -lt 1 ]]
then
	echo "Incorrect use of the script.";
	echo "Usage: ${0} USERNAME [COMMENTS...]";
	exit 2;
fi

#Creates the username and add the comments if there are any.
ACC_USERNAME=${1};
if [[ ${#} -eq 1 ]]
then
	echo "No comments were inserted on the username account."
else
	shift #We don't need the Username on the first argument anymore since is on the ACC_USERNAME var.
	while [[ ${#} -gt 0 ]]
	do
		ACC_COMMENT="$ACC_COMMENT ${1}";
		shift
	done
fi

useradd -c "${ACC_COMMENT}" ${ACC_USERNAME};

if [[ ${?} -ne 0 ]]
then
	echo "An error has ocurred creating the user account.";
	exit 3;
fi

#Creates a random password for the user account.
SPECIAL_C=$( echo "!@#$%^&*()_-+=" | fold -w1 | shuf | head -1);
ACC_PASSWORD="$( date +%N | sha1sum | head -c 10 )${SPECIAL_C}";
echo "${ACC_PASSWORD}" | passwd --stdin ${ACC_USERNAME};

if [[ ${?} -ne 0 ]]
then
	echo "An error has ocurred providing the random password to the user account".
	exit 4;
fi

#Expire the password on first login.
passwd -e ${ACC_USERNAME};

#Show Account Information:
echo "USER DESCRIPTION: ${ACC_COMMENT}"; echo;
echo "USER LOGIN: ${ACC_USERNAME}"; echo;
echo "PASSWORD: ${ACC_PASSWORD}"; echo;
echo "HOSTNAME: ${HOSTNAME}"; echo;
