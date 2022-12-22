#!/bin/bash

# SUDO verification
if [[ ${UID} -ne 0 ]]
then
    echo "Error: Admin privileges verification failed. This script should be executed as an administrator." >&2;
    exit 1;
fi

# USAGE
if [[ ${#} -lt 1 ]]
then
    echo "Error: Bad use. No arguments provided." >&2; echo "USAGE: ${0} ACCOUNTNAME [COMMENTS...]";
    exit 2;
fi

# STORE ACCOUNT NAME
ACCOUNTNAME="${1}";
shift;

# STORE ACCOUNT DATA
if [[ ${#} -eq 0 ]]
then
    echo "No comments were provided on the user account.";
else
    while [[ ${#} -gt 0 ]]
    do
      if [[ ${ACC_COMMENT} = "" ]]
      then
          ACC_COMMENT=${1};
      else
          ACC_COMMENT="${ACC_COMMENT} ${1}";
      fi
      shift;
    done
fi
#echo "${ACCOUNTNAME}" > userdata.log;
#echo "${ACC_COMMENT}" >> userdata.log;

# CREATE THE ACCOUNT
useradd -c "${ACC_COMMENT}" ${ACCOUNTNAME} 2> createuser.log
if [[ ${?} -ne 0 ]]
then
    echo "Error: The user account could not be created." >&2;
    exit 3;
fi

# ASSIGN A AUTOMATICALLY GENERATED PASSWORD
SPECIAL_C="$( echo "!@#$%^&*()_-+=" | shuf | fold -c1 | head -1 )";
PASSWORD="$( date +%N | sha1sum | head -c 6)${RANDOM}${SPECIAL_C}";
echo ${PASSWORD} | passwd --stdin ${ACCOUNTNAME} >> createuser.log 2>&1;

if [[ ${?} -ne 0 ]]
then
    echo "Error: The automatic password could not be assigned for the user ${ACCOUNTNAME}" >&2;
    exit 4;
fi
passwd -e ${ACCOUNTNAME} >> createuser.log 2>&1;

# DISPLAY DATA
echo;
echo "Description (optional): ${ACC_COMMENT}";
echo "Username: ${ACCOUNTNAME}";
echo "Password: ${PASSWORD}";
echo "Hostname: ${HOSTNAME}";








