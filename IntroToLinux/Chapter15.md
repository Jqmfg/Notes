# Chapter 15: Bash Shell Scripting

### INTRODUCTION
___

By the end of this chapter, you should be able to:
  * Explain the features and capabilities of bash shell scripting.
  * Know the basic syntax of scripting statements.
  * Be familiar with various methods and constructs used.
  * Know how to test for properties and existence of files and other objects.
  * Use conditional statements such as if-then-else blocks.
  * Perform arithmetic operations using scripting language.

### SECTION 1: FEATURES AND CAPABILITIES
___

Suppose you want to look up a filename, check if the associated file exists, and then respond accordingly, displaying an error message confirming or denying the file's existence.
If you only need to do it once, then you can just type a sequence of commands at a terminal.
However, if you need to do this multiple times, automation is the way to go.
In order to automate sets of commands, you'll need to learn how to write shell scripts, the most common of which are used with bash.

A shell is a command line interpreter which provides the user interface for terminal windows.
It can also be used to run scripts, even in non-interactive sessions without a terminal window, as if the commands were being directly typed in.
For example, typing ` $ FIND . -NAME "*.c" -ls ` at the command line accomplishes the same things as executing a script file containing the lines
```
#!/bin/bash
find . -name "*.c" -ls
```
The ` #!/bin/bash ` in the first line should be recognized by anyone who has developed any kind of script in UNIX environments.
The first line of the scripts that starts with ` #! ` contains the full path to the command interpreter (in this case ` /bin/bash `) that is to be used on the file.
You have a few choices depending on which scripting langauage you use.

The command interpreter is tasked with executing statements that follow it in the script.
Commonly used interpreters include:
  * ` /usr/bin/perl `
  * ` /bin/bash `
  * ` /bin/csh `
  * ` /usr/bin/python `
  * ` /bin/sh `

Typing a long sequence of commands at a terminal window can be complicated, time consuming, and error prone.
By deploying shell scripts, using the command-line becomes an efficient and quick way to launch complex sequences of steps.
The fact that shell scripts are saved in a file also makes it easy to use them to create new script variations and share standard procedures with several users.
Linux provides a wide choice of shells; exactly what is available on the system is listed in ` /etc/shells `.
Typical choices include:
  * ` /bin/sh `
  * ` /bin/bash `
  * ` /bin/tcsh `
  * ` /bin/csh `
  * ` /bin/ksh `

Most Linux users use the default bash shell, but those with long UNIX backgrounds with other shells may want to override the default.

For the first exercise, we will write a simple bash script that displays a two-line message on the screen.
You can type:
```
$ cat > exscript.sh
#!/bin/bash
echo "HELLO"
echo "WORLD"
```
then press ` ENTER ` and ` CTRL+D ` to save the file, or just create ` exscript.sh ` in your favorite text editor.
Then, type ` $ chmod +x exscript.sh ` to make the file executable.
The ` chmod +x ` makes the file executable for all users.
You can then run it by simjply typing ` $ ./exscript.sh ` or doing:
```
$ bash exscript.sh
HELLO
WORLD
```
Note that if you use the second form you won't have to make the file executable.

We can also create more interactive examples using a bash script.
In this example, the user will be prompted to enter a value, which is then displayed on the screen.
The value is stored in a temporary variable ` sname `.
We can reference the value of a shell variable by using a '$' in front of the variable such as ` $sname `.
To create this script, you need to create a file named ` ioscript.sh ` in your favorite editor with the following content:
```
#!/bin/bash
# Interactive reading of variables
echo "ENTER YOUR NAME"
read sname
# DISPLAY of variable values
echo $sname
```
Once again, your file needs to be made executable with ` $ chmod +x ioscript.sh `.
In the above example, when the script ` ./ioscript.sh ` is executed, the user will receive a prompt ` ENTER YOUR NAME `.
The user then needs to enter a value and press the ` ENTER ` key.
The value will then be printed out.
The pound-sign(#) is used to start comments in the script and can be placed anywhere in the line (the rest of the line is considered a comment.)

All shell scripts generate a return value upon finishing execution.
The value can be set with the exit statement.
Return values permit a process to monitor the exit state of another process often in a parent-child relationship.
This helps to determine how this process terminated and take any appropriate steps necessary, contingent on success or failure.

As a script executes, one can check for a specific value or condition and return success or failure as the result.
By convention, success is return as 0, and failure is returned as a non-zero value.
An easy way to demonstrate success and failure completion is to execute ` ls ` on a file that exists and one that doesn't, as shown in the following example, where the return value is stored by the environment variable represented by ` $? `:
```
$ ls /etc/passwd
/etc/passwd

$ echo $?
0
```
In this example, the system is able to locate the file ` /etc/passwd ` and returns a value of 0 to indicate success; the return value is always stored in the ` $? ` environment variable.
Applications often translate these return values into meaningful messages that can be easily understood by the user.

### SECTION 2: SYNTAX
___

Scripts require you to follow a standard language syntax.
Rules deliniate how to define variables and how to construct and format allowed statements, etc.
The table below lists some special character usages within bash scripts.

Character | Description
- | -
` # ` | Used to add a comment, except when used as ` \# ` or as ` #! ` when starting a script.
` \ ` | Used at the end of a line to indicate continuation on the next line.
` ; ` | Used to interpret what follows as a new command.
` $ ` | Indicates what follows is a variable.

Note that when ` # ` is inserted at the beginning of a line of commentary, the whole line is ignored.
```
# This line will not get executed
```

Users sometimes need to combine several commands and statements and even execute them based on the behaviour of operators used in between them.
This method is called chaining of commands.
The concatenation operator (` \ `) is used to concatenate large commands over several lines in the shell.
For example, you want to copy the file ` /var/ftp/pub/userdata/custdata/read ` from server1.linux.com to the ` /opt/oradba/master/abc ` directory on server3.linux.co.in. To perform this action, you can write the command using the ` \ ` operator as:
```
scp abc@server1.linux.com:\
/var/ftp/pub/userdata/custdata/read \
abc@server3.linux.co.in:\
/opt/oradba/master/abc/
```
The command is divided into multiple lines to make it look readable and easier to understand.
The ` \ ` operator at the end of each line combines the commands from multiple lines and executes it as one single command.

Sometimes, you may want to group multiple commands on a single line.
The ` ; ` (semicolon) character is used to separate these commands and execute them sequentially as if they had been typed on separate lines.
The 3 commands in the following example will all execute even if the ones preceding them fail:
```
$ make ; make install ; make clean
```
However, you may want to abort subsequent commands if one fails.
You can do this using the ` && ` operator as in:
```
$ make && make install && make clean
```
If the first command fails, the second one will never be executed.
A final refinement is to use the ` || ` (or) operator as in:
```
$ cat file1 || cat file2 || cat file3
```
In this case, the script proceeds until something succeeds and then stops executing any further steps.

A function is a code block that implements a set of operations.
Functions are useful for executing procedures multiple times perhaps ith varying input variables.
Functions are also often called subroutines.
using functions in scripts requires two steps:
  1. Declaring a function
  2. Calling a function

The function declaration requires a name which is used to invoke it.
The proper syntax is:
```
function_name () {
  command...
}
```
For example, the following function is named ` display `:
```
display () {
  echo "This is a sample function."
}
```
The function can be as long as desired and have many statements.
Once defined, the function can be called later as many times as necessary.
You can also pass an argument into a function. These can be referred to as ` $1 `, ` $2 `, etc.
Shell scripts are used to execute sequences of commands and other types of statements.
Commands can be divided into the following categories:
  * Compiled applications
  * Built-in bash commands
  * Other scripts

Compiles applications are binary executable files that you can find on the filesystem.
The shell script always has access to compiled applications such as rm, ls, df, vi, and gzip.
bash has many built-in commands which can only be used to display the output within a terminal shell or shell script.
Sometimes these commands have the same name as executable programs on the system such as echo, which can lead to subtle problems.
bash built-in commands include cd, pwd, echo, read, logout, printf, let, and ulimit.
A complete list of bash built-in commands can be found in the bash man page or by simply typing ` help `.
At times, you may need to substitute the result of a command as a portion of another command.
This can be done in two ways:
  1. By enclosing the inner command with backticks(\`)
  2. By enclosing the inner command with ` $() `.

No matter the method, the innermost command will be execute in a newly launched shell environment and the standard output of the shell will be inserted where the command substitution has been done.
Virtually any command can be execute this way.
Both of these methods enable command substitution; however, the ` $() ` method allow command nesting.
New scripts should always use this more modern method.
For example:
```
$ cd /lib/modules/$(uname -r)/
```
In the above example, the output of the command ` uname -r ` becomes the argument for the ` cd ` command.
Almost all scripts use variables containing a value which can be used anywhere in the script.
These variables can either be user or system defined.
Many applications use such environment variables for supplying inputs, validation, and controlling behaviour.
Some examples of standard environment variables are ` HOME `, ` PATH `, and ` HOST `.
When referenced, environment variables must be prefixed with the ` $ ` symbol as in ` $HOME `.
You can view and set the value of environment variables.
For example, the following command displays the value stored in the ` PATH ` variable.
```
$ echo $PATH
```
However, no prefix is required when setting or modifying the variable value.
For example, the following command sets the value of ` MYCOLOR ` to blue:
```
$ MYCOLOR=blue
```
You can get a list of environment variables with the env, set, or printenv commands.

By default, the variables created within a script are available only tot he subsequent steps of that script.
Any child processes (sub-shells) do not have automatic access to the values of these variables.
To make them available to child processes, they must be promoted to environment variables using the export statement as in:
```
export VAR=value
```
or
```
VAR=value ; export VAR
```
While child processes are allowed to modify the value of exported variables the parent will not see any changes; exported variables are not shared, only copied.

Users often need to pass parameter values to a script such as a filename, date, etc.
Scripts will take different paths or arrive at different values according to the parameters (command arguments) that are passed to them.
These values can be text or numbers as in:
```
$ ./script.sh /tmp
$ ./script.sh 100 200
```
Within a script, the parameter or an argument is represented with a ` $ ` and a number.
The table below lists some of the parameters:
Parameter | Meaning
- | -
` $0 ` | Script name
` $1 ` | First parameter
` $2 `, ` $3 `, etc. | Second parameter, third parameter, etc.
` $* ` | All parameters
` $# ` | Number of arguments

The following is an example script that demonstrates usage of parameters in a script.
```
#!/bin/bash
echo "The name of this program is: $0"
echo "The first argument passed from the command line is: $1"
echo "The second argument passed from the command line is: $2"
echo "The third argument passed from the command line is: $3"
echo "All of the arguments passed from the command line are : $*"
echo
echo "All done with $0"
```
You can make the script executable with ` chmod +x `.
Now run the script giving it three arguments as in ` script3.sh one two three `.
The script will be processesed as follows:
  * ` $0 ` prints the script name: ` script3.sh `
  * ` $1 ` prints the first parameter: ` one `
  * ` $2 ` prints the second parameter: ` two `
  * ` $3 ` prints the third parameter: ` three `
  * ` $* ` prints all parameters: ` one two three `
  * The final statement becomes: ` All done with script3.sh `

Most operating system accept input from the keyboard and display the output on the terminal.
However, in shell scripting, you can send the output to a file.
the process of diverting the output to a file is called redirection.
The ` > ` character is used to write output to a file.
For example, the following command sends the output of free to the file ` /tmp/free.out `:
```
$ free > /tmp/free.out
```
To check the contents of the ` /tmp/free.out ` file, you can use ` $ cat /tmp/free.out `.
Two ` > ` characters (` >> `) will append output to a file if it exists and act just like ` > ` if the file doesn't already exist.

Just as the output can be redirected to a file, the input of a a file can be read from a file.
The process of reading input from a file is called input redirection and uses the ` > ` character.
If you create a file called ` script8.sh ` with the following contents:
```
#!/bin/bash
echo "Line count"
wc -l < /temp/free.out
```
and then execute it with ` $ chmod +x script8.sh ; ./script8.sh `, it will count the number of lines from the ` /temp/free.out ` file and display the results.
