#!/bin/bash

# This script generates a list of random passwords.

# A random number as a password
PASSWORD="${RANDOM}";
echo "${PASSWORD}";

# Three random numbers together.
PASSWORD="${RANDOM}${RANDOM}${RANDOM}";
echo "${PASSWORD}";

# Use the date/time as a password.
PASSWORD="$( date +%s )";
echo "${PASSWORD}";

# Use nanoseconds to act like it was a randomizer.
PASSWORD=$( date +%s%N );
echo "${PASSWORD}";

# Use a shorter way of the checksum of the command
PASSWORD=$( date +%s | sha1sum | head -c 6 );
echo "${PASSWORD}";

# Append a special charracter to the password.
SPECIAL_CHAR=$( echo "!@#$%^&*()-_+=" | fold -w1 | shuf | head -c 1 );
PASSWORD="$( date +%N | sha1sum | head -c 6 )${SPECIAL_CHAR}";
echo "${PASSWORD}";
