#!/bin/bash

# This script tisplays various information to the screen

# Display "Hello"
echo "Hello";
###

#Assign a value to a variable
WORD="script";

#Display that value using the variable.
echo "$WORD";
echo '$WORD'; #If you use ONE quotation mark instead of 2, it will not use the variable.

#Use the variable with simple text combined.
echo "This is a shell $WORD";

#Displays the contects of the variable using an alternative syntax.
echo "This is a shell ${WORD} with alt. syntax";

#To append text right after the var without spaces you have to use the alt. syntax.
echo "Shell ${WORD}ing"; #without it the var name would be WORDing.
###

#Lets create another var.
ENDING='ed';

#Combile the two variables.
echo "This is ${WORD}${ENDING}";

#Reassign a var:
ENDING='ing';
echo "This is ${WORD}${ENDING}";
#Hello, from the main OS.
