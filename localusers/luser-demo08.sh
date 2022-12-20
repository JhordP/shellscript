#!/bin/bash
# This script shows the Input/Output redirection.

# Redirecting STDOUT (Standard Output) to a file.

FILE="/tmp/data";
head -n 1 /etc/passwd > ${FILE}; #The data is overwritten each time.
echo 'One "Greater Than" sign:'; cat ${FILE}

# Redirecting STDIN (Standart Input) to a program.
read LINE < ${FILE}; #Puts the file content as the input for the read command.
echo "Line contains: ${LINE}";

# Redirecting more data to a file by STDOUT.
tail -n 2 /etc/passwd >> ${FILE} #Double "greater than" sign appends the data to the actual file data.
echo 'Two "Greater Than" sign:'; cat ${FILE}
echo "It appends the last two lines to the file.";

# Redirect STDIN to a program, using File Descriptor Zero (FD0)
read LINE 0< ${FILE};
echo;
echo "LINE CONTAINS: ${LINE}";

# Redirect STDOUT to a file using File Descriptor One (FD1), overwritting the file.
head -n3 /etc/passwd 1> ${FILE};
echo;
echo "Contents of ${FILE}:";
cat ${FILE};

# Redirect STDERR to a file using FD2.
ERR_FILE="/tmp/data.err";
head -n3 /etc/passwd /fakefile 2> ${ERR_FILE};

# Redirect both STDOUT and STDERR to a file turning Error to Output.
head -n3 /etc/passwd /fakefile &> ${FILE}; #New Syntax
head -3 /etc/passwd /fakefile > ${FILE} 2>&1; #Old Syntax
echo;
echo "Contets of ${FILE}:";
cat ${FILE};

# Redirect STDOUT and STDERR trough a pipe turning Error to Output.
echo;
head -n3 /etc/passwd /fakefile 2>&1 | cat -n; #New Syntax
head -3 /etc/passwd /fakefile |& cat -n; #Old Syntax

# Redirect STDOUT to STDERR
echo "This is an error! it goes to STDERR." >&2; #No need of typing 1>&2 (FD1 turning to FD2) because default ">" redirection is STDOUT or FD1.

# Discard STDOUT
echo;
echo "Discarding STDOUT:"
head -n3 /etc/passwd /fakefile > /dev/null;

# Discard STDERR
echo;
echo "Discarding STDERR:";
head -n3 /etc/passwd /fakefile 2> /dev/null;

# Discard both STDOUT and STDERR
head -n3 /etc/passwd /fakefile &> /dev/null;

# Clean up temp files created in this script
rm ${FILE} ${ERR_FILE} > /dev/null 2>&1 #Sent it to null device since... we dont really care if remove fails since it's a temp file anyway.
