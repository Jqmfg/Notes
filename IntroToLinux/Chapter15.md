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
