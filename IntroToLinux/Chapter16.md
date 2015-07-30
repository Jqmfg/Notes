# Chapter 16: Advanced Bash Scripting

### INTRODUCTION
___

By the end of this chapter, you should be able to:
  * Manipulate strings to perform actions such as comparison and sorting.
  * Use boolean expressions when working with multiple data types including strings or numbers, as well as files.
  * Use case statements to handle command line options.
  * Use looping constructs to execute one or more lines of code repetitively.
  * Debug scripts using set ` -x ` and set ` +x `.
  * Create temporary files and directories.
  * Create and use random numbers.

### SECTION 1: STRING MANIPULATION
___

A string variable contains a sequence of text characters.
It can include letters, numbers, symbols, and punctuation marks.
Some examples include:
  * "abcde"
  * "123"
  * "abcde 123"
  * "abcde-123"
  * "&abcde=%123"

String operators include those that do comparison, sorting, and finding the length.
The following table demonstrates the use of some basic string operations.

Operator | Meaning
- | -
` [[ strin1 > string2 ]] ` | Compares the sorting order of string1 and string2
` [[ string1 == string2 ]] ` | compares the characters in string1 with the characters in string2
` myLen1=${#string1} ` | Saves the length of string1 in the variable myLen1.

At times, you may not need to compare or use an entire string.
To extract the first character of a string, we can specify ` ${string:0:1} `.
Here, 0 is the offset of the stri;ng (i.e. which character to begin from) where the extraction needs to start and 1 is the number of characters to be extracted.
To extract all characters in a string after a dot (` . `), use the expression ` ${string#*.} `.

### SECTION 2: BOOLEAN EXPRESSIONS
___

Boolean expressions evaluate to either true or false.
Results are obtained using the various boolean operators listed in the following table.

Operator | Operation | Meaning
- | - | -
` && ` | AND | The action will be performed only if both the conditions evaluate to true.
<code>&#124;&#124;</code> | OR | The action will be performed if any one of the conditions evaluates to true.
` ! ` | NOT | The action will be performed only if the condition evaluates to false.

Note that if you have multiple conditions string together with the ` && ` operator, processing stops as soon as the condition evaluates to false.
For example, if you have ` A && B && C ` and A is true but B is false, then C will never be evaluated.
Likewise, if you use the ` || ` operator, processing stops as soon as anything is true.
For example, if you have ` A || B || C ` and A is false and B is true, you will never execute C.

Boolean expressions return either true or false.
We can use such expressions when working with multiple data types including strings or numbers as well as within files.
For example, to check if a file exists, use the conditional test ` [ -e <filename> ] `.
Similarly, to check if the value of ` number1 ` is greater than the value of ` number2 `, use the conditional test ` [ $number1 -gt $number2 ] `.
The operator ` -gt ` returns true if ` number1 ` is greater than ` number2 `.

### SECTION 3: THE CASE STATEMENT
___

The case statement is used in scenarios where the actual value of a variable can lead to different execution paths.
case statements are often used to handle command-line options.
The following are some of the advantages of use the case statement:
  * It is easier to read and write.
  * It is a good alternative to nested, multi-level if-then-else-fi code blocks.
  * It enables you to compare a variable against several values at once.
  * It reduces the complexity of a program.

The following is the basic structure of a case statement:
```bash
case expression in
  pattern1) execute commands ;;
  pattern2) execute commands ;;
  pattern3) execute commands ;;
  pattern4) execute commands ;;
  * ) execute default commands ;;
esac
```

Another example of a case statement is the following which prompts the user to type in a letter and identifies if it is a vowel or consonant:
```bash
#!/bin/bash
# Prompt user to enter a character
echo "Please enter a letter:"
read charac
case "$charac" in
  "a"|"A") echo "You have typed a vowel!" ;;
  "e"|"E") echo "You have typed a vowel!" ;;
  "i"|"I") echo "You have typed a vowel!" ;;
  "o"|"O") echo "You have typed a vowel!" ;;
  "u"|"U") echo "You have typed a vowel!" ;;
  *) echo "You have typed a consonant!" ;;
esac
exit 0
```

### SECTION 4: LOOPING CONSTRUCTS
___

By using looping constructs, you can execute one or more lines of code repetitively.
Usually, you do this until a conditional test return either true or false as is required.
Three types of loops are often used in most programming languages:
  * ` for `
  * ` while `
  * ` until `

All of these loops are easily used for repeating a set of statements until the exit condition is true.

The for loop operates on each element of a list of items.
The syntax for the for loop is:
```bash
for variable-name in list
do
  #execute one iteration for each item in the list until the list is finished
done
```
In this case, ` variable-name ` and ` list ` are substituted by you as appropriate.
As with other looping constructs, the statements that are repeated should be enclosed by ` do ` and ` done `.
The following example demonstrates how to count the numbers from 1 to 4 in order and can be extrapolated to any length of numbers.
```bash
#!/bin/sh
#
sum=0
for i in 1 2 3 4
do
  sum=$(($sum+$i))
done
echo "The sum of $i numbers is: $sum"
```

The while loop repeats a set of statements as long as the control command returns true.
The syntax is:
```bash
while condition is true
do
  #Commands for execution
done
```
The set of commands that need to be repeated should be enclosed between ` do ` and ` done `.
You can use any command or operator as the condition.
Often, it is enclosed within square brackets(` [] `).
The following example calculates the factorial of a number:
```bash
#!/bin/bash
#
echo "Enter the number"
read no
fact=1
i=1
while[ $i -le $no ]
do
  fact=$(($fact * $i))
  i=$(($i + 1))
done
echo "The factorial of $no is $fact"
```
The until loop repeats a set of statements as long as the control command is false.
Thus it is essentially the opposite of the while loop.
The syntax is:
```bash
until condition is false
do
  #Commands for execution
done
```
Similar to the while loop, the set of commands that need to be repeated should be enclosed between do and done.
you can use any command or operator as the condition.
The following example demonstrates how to display the odd numbers from 1 to 10.
```bash
#!/bin/bash
#
echo "NUMBER"
mn=1
mx=10
until [ $mn -gt $mx ]
do
  echo "$mn"
  mn=$(($mn + 2))
done
```
This will print out:
```
NUMBER
1
3
5
7
9
```

SECTION 5: SCRIPT DEBUGGING
___

While working with scripts and commands, you may run into errors.
These may be due to an error in the script, such as incorrect syntax, or other ingredients such as a missing file or insufficient permission to do an operation.
These errors may be reported with a specific error code, but often just yield incorrect or confusing output.
How do you got about identifying and fixing an error.
Debugging helps you troubleshoot and resolve such errors and is one of the most important tasks a syadmin performs.

Before fixing a bug, it is vital to know its source.
In bash shell scripting, you can run a script in debug mode by using ` bash -x ./script_file `.
Debug mode helps identify the error because:
  * It traces and prefixes each command with the ` + ` character.
  * It displays each command before executing it.
  * It can debug only selected parts of the script (if desired) with:
  ```bash
  set -x # turns on debugging
  ...
  set +x # turns off debugging
  ```

In UNIX/Linux, all programs that run are given three open file streams when they are started as listed in the followin g table:
File stream | Description | File Descriptor
- | - | -
stdin | Standard input, by default the keybaord/terminal for programs run from the command line | 0
stdout | Standard output, by default the screen for programs run from the command line | 1
stderr | Standard error where output messages are shown or saved | 2
using redirection we can save the stdout and stderr output streams to one file or two separate files for later analysis after a program or command is executed.
The following is an example of a buggy shell script:
```bash
#!/bin/sh
#
sum=0
for i in 1 2 3 4
do
  sum=(()$sum+$i))
done
echo "The sum of $i numbers is: $sum"
ls error
```
The following is an example output from the script being executed and having the errors redirected to the file ` error.txt `.
```bash
$ ls error.txt
ls: cannot access error.txt: No such file or directory
$ bash sample.sh 2> error.txt
$ ls error.txt
error.txt
$ cat error.txt
sample.sh: line 6: syntax error near unexpected token '('
sample.sh: line 6: ' sum=(($sum+$i))'
sample.sh: line 7: syntax error near unexpected token 'done'
sample.sh: line 7: 'done'
```
Using ` cat ` to display the contents of ` error.txt ` shows the errors of executing the buggy shell script (for further debugging.)

### SECTION 6: SOME ADDITIONAL USEFUL TECHNIQUES
___

Consider a situation where you want to retrieve 100 records from a file with 10,000 records.
You will need a place to store the extracted information, perhaps in a temporary file, while you do further processing on it.
Temporary files (and directories) are meant to store data for a short time.
Usually one arranges it so that these files disappear when the program using them terminates.
While you can also use touch to create a temporary file, this may make it easy for hackers to gain access to your data.
The best practice is to create random and unpredictable filenames for temporary storage.
One way to do this is with the mktemp utility as in the following examples.
The ` XXXXXXXX ` is replaced by mktemp with random characters to ensure the name of the file cannot be easily predicted and is only known within your program.

Command | Usage
- | -
` TEMP=$(mktemp /tmp/tempfile.XXXXXXXX) ` | To create a temporary file
` TEMPDIR=$(mktempt -d /temp/tempdir.XXXXXXXX) ` | To create a temporary directory

There is also a danger with using symbolic links that can be negated by using mktemp.
If someone creates a symbolic link from a known temporary file used by root the the /etc/passwd file like ` $ ln -s /etc/passwd /tmp/tmpfile `, there could be a big problem if the script has a line in it like ` echo $VAR > /tmp/tempfile `.
The password file will be overwritten by the temporary file contents.
To prevent such a situation, make sure you randomize your temporary filenames by replacing the above line with the following lines:
```bash
TEMP=$(mktemp /tmp/tempfile.XXXXXXXX)
echo $VAR > $TEMP
```

Certain commands like find will produce voluminous amounts of output which can overwhelm the console.
To avoid this, we can redirect the large output to a special file (a device node) called ` /dev/null `.
This file is also called the bit bucket or black hole.
It discards all data that gets written to it and never returns a failure on write operations.
Using the proper redirection operators, it can make the output disappear from commands that would normally generate output to stdout and/or stderr like ` $ find / > /dev/null `.
In the previous command, the entire standard output stream is ignored, but any errors will still appear on the console.

It is often useful to generate random numbers and other random data when performing tasks such as:
  * Performing security-related tasks.
  * Reinitializing storage devices.
  * Erasing and/or obscuring existing data.
  * Generating meaningless data to be used for tests.

Such random numbers can be generated by using the ` $RANDOM ` environment variable which is derived from the Linux kernel's built-in random number generator, or by the OpenSSL library function which uses the FIPS140 algorithm to generate random numbers for encryption.
To read more about FIPS140, see http://en.wikipedia.org/wiki/FIPS_140-2.
The following example shows you how to easily use the environmental variable method to generate random numbers:
```bash
$ echo $RANDOM
19561
$ echo $RANDOM
12887
$ echo $RANDOM
19622
```

Some servers have hardware random number generators that take as input different types of noise signals, such as thermal noise and photoelectric effect.
A transducer converts this noise into an electric signal, which is again converted into a digital number by an A-D converter.
This number is considered random.
However, most common computers do not contain such specialized hardware and instead rely on events created during booting to create the raw data needed.
Regardless of which of these two sources is used, the system maintains a so-called entropy pool of these digital numbers/random bits.
Random numbers are created from this entropy pool.
The Linux kernel offers the ` /dev/random ` and ` /dev/urandom ` device nodes which draw on the entropy pool to provide random numbers which are drawn from the estimated number of bits of noise in the entropy pool.
` /dev/random ` is used where very high quality randomness is required such as one-time pad or key generation, but it is relatively slow to provide values.
` /dev/urandom ` is faster and suitable (good enough) for most cryptographic purposes.
Furthermore, when the entropy pool is empty, ` /dev/random ` is blocked and does not generate any number until additional environmental noise (network traffic, mouse movement, etc.) is gathered, whereas ` /dev/urandom ` reuses the internal pool to produce pseudo-random bits.

### SUMMARY
___

  * You can manipulate strings to perform actions such as comparison, sorting, and finding length.
  * You can use boolean expressions when working with multiple data types including strings or numbers, as well as files.
  * The output of a boolean expression is either true or false.
  * Operators used in boolean expressions include ` && ` (AND), ` || ` (OR), and ` ! ` (NOT) operators.
  * We looked at the advantages of using the case statement in scenarios where the value of a variable can lead to different execution paths.
  * Script debugging methods help troubleshoot and resolve errors.
  * The standard and error outputs form a script or shell commands can easily be redirected into the same file or separate files to aid in debugging and saving results.
  * Linux allows you to create temporary files and directories which store data for a short duration, both saving space and increasing security.
  * Linux provides several different ways of generating random numbers, which are widely used.
