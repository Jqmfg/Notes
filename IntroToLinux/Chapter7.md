# Chapter 7: Command Line Operations

### INTRODUCTION
___

By the end of this chapter you will be able to:
  * Use the command line to perform operations in Linux
  * Search for files
  * Create and manage files
  * Install and update software

### SECTION 1: COMMAND LINE MODE OPTIONS
___

Linux sysadmins spend a lot of their time using the CLI.
They often automate and troubleshoot tasks in this text environment.
A GUI makes tasks easier, while a CLI makes difficult tasks possible.
Linux relies heavily on the abundance of command line tools.
The CLI provides:
  * No GUI overhead
  * Virtually every tasks can be accomplished using the command line
  * You can script tasks and a series of procedures
  * You can log on remotely to networked machines anywhere on the internet
  * You can initiate graphical apps direly from the command line

A terminal emulator program emulates a stand alone terminal within a window on the desktop.
This means it behaves essentially as if you were logging into the machine at a pure text terminal with no running GUI.
Most terminal emulator programs support multiple terminal sessions by opening additional tabs or windows.
By default, GNOME uses the gnome-terminal application to emulate a text-mode terminal in a window.
Other programs include:
  * xterm
  * rxvt
  * knosole
  * terminator

To open a terminal in CentOS:
  * On the desktop in the upper-left corner, click applications
  * From the system tools menu, select terminal

To open a terminal in openSUSE:
  * On the desktop in the upper-left corner, click Activities
  * From the left pane, click Show Applications
  * Scroll down and select the required terminal

To open a terminal in Ubuntu:
  * In the left panel, click the Ubuntu icon
  * Type Terminal in the Search box

You can always open up a terminal by right clicking anywhere on the desktop and selecting Open in Terminal if nautilus-open-terminal is installed.
The customizable nature of Linux allows you to drop the X Window GUI or start it up after the system has been running.
Certain distros distinguish versions of the install media between desktop (with X) and server (usually without X).
Linux production servers are usually installed without X and even if it is installed, usually do not launch it during start up.
Removing X from a production server can be very helpful in maintaining a lean system which can be easier to support and keep secure.

Virtual Terminals (VTs) are console sessions that use the entire display and keyboard outside of a GUI.
Such terminals are considered virtual because only one terminal remains visible at a time even though there can be multiple running at once.
A VT is not quite the same as a command line terminal window.
you can have as many command line terminal windows visible at once as you want.
One virtual terminal (usually number one or seven) is reserved for the GUI and text logins are enabled on the unused VTs.
Ubuntu uses VT 7, but CentOS/RHEL and openSUSE use VT 1 for the GUI.
An example of a situation where using VTs is helpful is when you run into problems with the graphical desktop.

You can switch to one of the VTs and troubleshoot.
To switch between the VTs, press ` CTRL+ALT+Fx ` key for the VT.
e.g. ` CTRL+ALT+F6 ` for VT 6.
Most input lines entered at the shell prompt have three basic elements:
  * Command
  * Options
  * Arguments

The command is the name of the program you are executing.
It can be followed by one or more options (or switches) that modify what the command may do.
Options usually start with one or two dashes (e.g. ` -p ` or ` --print` ).
These differentiate them from arguments which represent what the command operates on.
Plenty of commands have no options, nor arguments, or neither.

You can also type other things at the command line besides issuing commands, such as setting environment variables.
Linux distros can start and stop the graphical desktop in various ways.
For Debian-based systems, the Desktop Manager runs as a service which can simply be stopped.
For RPM-based systems, the Desktop Manager is run directly by init when set to run level 5.
Switching to a different run level stops the desktop.
Use the ` $ sudo service gdm stop ` or ` $ sudo service lightdm stop` commands to stop the GUI in Debian-based systems.
Use the ` $ sudo telinit 3 ` command on RPM-based systems.

All the demonstrations previously have a user configured with ` sudo ` capabilities to provide the user with admin privileges when required.
` sudo ` allows users to run programs using the security privileges of another user generally root (superuser).
The functionality of ` sudo ` is similar to that of run as on Windows.
On your own systems, you may need to set up and enable ` sudo ` to work correctly.
To do this, you need to follow some steps we will learn about later.

When running on Ubuntu, sudo is already set up for you during installation.
If you are running something in the Fedora or openSUSE families, you will likely need to set up ` sudo ` yourself.
If your system does not already have ` sudo ` set up and enabled, you need to do the following steps:
  1. You will need to make modifications as the admin or super user, root
    * ` sudo ` is the prefered method of doing this, but we don't have it set up yet so we will use ` su ` instead
    * At the command line prompt, type ` su ` and press Enter
    * You will then be prompted for the root user password to enter that now
    * You will notice that nothing is printed so that others can't see the password on screen
    * You should end up with a different looking prompt, often ending with # e.g. ` $ su Password: # `
  2. Now you need to create a config file to enable your user account to use ` sudo `
    * This file is usually located in the ` /etc/sudoers.d/ ` directory with the name of the file as your username
    * e.g. if your name was student, you will create a config file for student using ` $ echo "student ALL=(ALL) ALL" > /etc/sudoers.d/student `
  3. Some Linux distros will complain if you don't also change permissions on the file by doing ` $ chmod 440 /etc/sudoers.d/student `

Now ` sudo ` should be set up correctly.
When using ` sudo` , by default you will be prompted to give a password (your own user's password) at least the first time you do it within a set time.
It is possible (but very insecure) to configure ` sudo ` to not require a password or change the time window in which the password is allowed.
This way it doesn't have to be repeated for every ` sudo ` command.

### SECTION 2: BASIC OPERATIONS
___

To log in and out a text terminal will prompt for a username (with the string login:) and the password.
When typing your password, nothing is displayed to prevent others from seeing your password.
After you are logged in, you can perform basic operations.
Once your session is started, you can also connect and log in to remote systems using the SSH (Secure SHell) utility.
e.g. typing ` $ ssh username@remote-server.com ` would connect you securely to the remote machine and give you a command line terminal window.
This lets you use passwords or cryptographic keys to prove your identity.
The preferred method to shut down or reboot the system is to use the shutdown command.

This sends a warning message and then prevents further users from logging in.
The init process will then control shutting down or rebooting the system.
It is important to always shut down properly.
Failure to do so can result in damage to the system and/or loss of data.
The ` halt ` and ` poweroff ` commands issue ` $ shutdown  -h ` to halt the system.
reboot issues shutdown -r and causes the machine to reboot instead of just shutting down.
Both rebooting and shutting down from the command line require root access.

When administering a multiuser system, you have the option of notifying all users prior to shutdown.
e.g. ` $ sudo shutdown -h 10:00 "Shutting down for scheduled maintenance" `.
This will prompt all users with a message "Shutting down for scheduled maintenance" at 10:00.
Depending on the specifics of your distro's policy, programs and software packages can be installed in various directories.

In general, executable programs should live under ` /bin `, ` /usr/bin `, ` /sbin `, ` /usr/sbin `, or ` /opt `.
One way to locate programs is to use the which utility.
e.g. to find out where the diff program resides on the filesystem use ` $ which diff `.
If which does not find the program, ` $ whereis ` is a good alternative because it looks for packages in a broader range of system directories.
e.g. ` $ whereis diff `.
When you first log into a system or open a terminal, the default directory should be your home directory.
You can print the exact path of this by typing ` $ echo $HOME `.
Note that some Linux systems actually open new graphical terminals in ` $HOME/Desktop `.
The following commands are useful for directory navigation.
  * ` $ pwd `: print working directory, displays the current working directory.
  * ` $ cd ~ ` or ` cd `: change your directory to you home directory (short-cut name is ` ~ `).
  * ` $ cd .. `: Changes your working directory to the parent directory
  * ` $ cd - `: Change to the previous directory

There are two ways to identify paths.
  1. Absolute pathname
    * An absolute pathname begins with the root directory and follows the tree, branch by branch until it reaches the desired directory or file
    * Absolute paths always start with ` / `
  2. Relative pathname
    * A relative pathname starts from the present working directory
    * Relative paths never start with ` / `

Multiple slashes between directories and files are allowed, but all but one slash between elements in the pathname is ignore by the system.
` //////usr//bin ` is valid, but seen as ` /usr/bin ` by the system.
Most of the time, it is most convenient to use relative paths, which require less typing.
Usually, you take advantage of the shortcuts provided by.
  * ` . ` (present directory)
  * ` .. ` (parent directory)
  * ` ~ ` (home directory)

e.g.:
  * Absolute pathname: ` $ cd /usr/bin `.
  * Relative pathname: ` $ cd ../../usr/bin `.

In this case, the absolute pathname method is less typing.
Traversing up and down the filesystem can get tedious.
The tree command is a good way to get a bird's-eye view of the filesystem tree.
Use ` $ tree -d ` to view just the directories and to suppress listing file names.
The following command can help in exploring the filesystem:
  * ` cd / `: changes the current directory to the root directory (or the path you supply)
  * ` ls `: lists the contents of the present working directory
  * ` ls -a `: lists all files including hidden files and directories (those that start with a ` . `)
  * ` tree `: displays a tree view of the filesystem

` ln ` can be used to create hard links and (with the ` -s ` option) soft links, also known as symbolic links or symlinks.
These two kinds of links are very useful in UNIX-based operating systems.
Suppose that file1 already exists.
A hard link called ` file2 ` is created with the command.
` $ ln file1 file2 `.
Note that the two files now appear to exist.
However, a close inspection of the file listing shows that this is not quite true.
` $ ls -li file1 file2 `.
The ` -i ` option is used to to print out the first column the inode number, which is a unique quantity for each file object.
This field is the same for both of these files.

What is really; going on here is that only one file is created, but it has more than one name associated with it.
This is indicated by the 3 that appears in the ` ls ` output.
Thus, there already was another object linked to file1 before the command was executed.
Symbolic or soft links are created with the ` -s ` option:
  * ` $ ln -s file1 file4 `
  * ` $ ls -li file1 file4 `

Notice that ` file4 ` no longer appears to be a regular file, and it clearly points to ` file1 ` and has a different inode number.
Symbolic links take no extra space on the filesystem (unless their names are very long).
They are extremely convenient as they can easily be modified to point to different places.

An easy way to create a shortcut from your home directory to long pathnames is to create a symbolic link.
Unlike hard links, soft links can point to objects even on different filesystems (or partitions) which may or may not be currently available or even exist.
In the case where the link does not point to a currently available or existing object, you obtain a dangling link.
Hard links are very useful and they save space, but you have to be careful with their use.
In the previous example, if you remove ` file1 ` or ` file2 `, the inode object (and the remaining file name) will remain.
This might lead to suble errors later if your recreate a file of that name.
If you edit one of the files, most editors will retain the link by default (inlcluding vi and gedit).
However, it is possible to change this default behaviour.

The cd command remembers where you were last and lets you go back with ` $ cd - `.
For remembering more than just the last directory you visited, use pushd to change the directory instead of cd.
This pushes your starting directory to a list.
Using ` popd ` will then send you back to those directories walking in the reverse order.
The list of directories can be displayed using the ` dirs ` command.

### SECTION 3: SEARCHING FOR FILES
___

When commands are executed, by default there are three standard file streams (or descriptors) always open for use:
  * Standard input (standrd in or ` stdin ` )
  * Standard output (standard out or ` stdout` )
  * Standard error (or ` stderr` )

Usually, ` stdin ` is your keyboard and ` stdout ` and ` stderr ` are printed on your terminal.
Often, ` stderr ` is redirected to an error logging file or from the output of the previous command through a pipe.
` stdout ` is also often redirected into a file.
Since ` stderr ` is where error messages are written, often nothing will go there.
In Linux, all open files are represented internally by file descriptors.
File descriptors are representative of the standard file streams:
  * ` stdin ` is file descriptor 0
  * ` stdout ` is file descriptor 1
  * ` stderr ` is file descriptor 2

Typically, if other files are opened in addition to these three, they will start at file descriptor 3 and increase from there.
Through the command shell, we can redirect the standard filestreams so that we can get input from a file or from another command.
We can also write output and error sot files or send them as input for subsequent commands.
e.g. if we have a program called do_something that reads from ` stdin ` and writes to ` stdout ` and ` stderr `, we can change its input by using the ` < ` followed by the name of the file.
` $ do_something < input-file `.
If you want to send the output to a file, use ` > `.
e.g. ` $ do_something > output-file `.
` stderr ` is not the same as ` stdout ` and error messages will still be seen on the terminal in the above examples.
If you want to redirect ` stderr ` to a separate file, you need to use ` stderr `'s file descriptor number (2) followed by ` > ` and the name of the file.
e.g. ` $ do_something 2> error-file `.
A special shorthand notation can be used to put anything written to file descriptor 2 (` stderr `) in the same place as file descriptor 1 `(stdout): 2>&1 `.
e.g. ` $ do_something > all-output-file 2>&1 `.
bash permits an easier syntax for the above.
e.g. ` $ do_something >& all-output-file `.

The Linux/UNIX philosophy is to have many simple and short programs (or commands) cooperate together to produce complex results.
This is rather than having one complex program with many possible options and modes of operation.
In order to accomplish this, extensive use of pipes is made.
You can pipe the output of one command or program into another as its input.
In order to do this, we use the vertical-bar | (pipe-symbol) between commands.
e.g. ` $ command1 | command 2 | command3 `.
This represents what we call a pipeline and allows Linux to combine the actions of several commands into one.
This is efficient because command2 and command3 do not have to wait for the previous pipeline commands to finish before they start hacking at the data in their input streams.

On multiple CPU-core systems, the computing power is much better utilized and things get done quicker.
There is no need to save the output to temporary files between the stages in the pipeline.
This saves disk space and reduces reading a writing to the disk which can be the slowest part of getting something done.
Being able to quickly find the files your are looking for will make your life much easier.
You can search for files in any system directory.
The locate utility program performs a search through a previously constructed database of files and directories on your system.
It will match all entries that contain a specified character string.
This can sometimes result in a very long list.

To get a shorter more relevant list, we can use the grep program as a filter.
grep will only print the lines that contain one or more specified strings.
e.g. ` $ locate zip | grep bin `.
This lists all files and directories with both "zip" and "bin" in their name.
Note the use of | to pipe the commands together.
Locate utilizes the database created by another program: updatedb.
Most Linux systems run this automatically once a day.
You can update it any time by running updatedb form the command line as root user.
You can also search for a filename containing specific characters using wildcards:
  * ` ? ` - Matches any single character
  * ` * ` - Matches any string of characters
  * ` [set] ` - Matches any character in the set of charter e.g. [adf] will match any 'a', 'd', or 'f'
  * ` [!set] ` - Matches any character not listed in the set of characters

To search for files using the ` ? ` wildcard, replace each unknown character with ` ? `.
e.g. if you only know the first to characters are ba of a three-letter filename you can use ` $ ls ba? `.
find is another often-used utility.
It searches recursively down the filesystem tree from any particular directory (or set of directories) and locates files that match the specified conditions.
The default pathname is always the present working directory.
e.g. sysadmins sometimes scan for large core files (which contain diagnostic info after a program fails) that are several weeks old to remove them.
e.g. It is also common to remove files in ` /tmp ` periodically.
Many distros use automated scripts that run periodically to accomplish such house cleaning.
When no arguments are given, find lists all files in the current directory and all of its subdirectories.
Commonly used options to shorten the list include:
  * -name (only list files with a certain pattern in their name)
  * -iname (also ignore the case of the file name)
  * -type (restricts the results to a specified type such as d for directory, l for symbolic link, f for regular file, etc.)

e.g.
  * Searching for files and directories named "gcc" ` $ find /usr -name gcc `
  * Searching only for directories named "gcc" ` $ find /usr -type d -name gcc `
  * Searching for only regular files named "test1" ` $ find /usr -type f -name test1 `

Another good use of find is being able to run commands on the files that match your search criteria.
The ` -exec ` option is used for that purpose.
e.g. To find and remove all files that end with ` .swp ` ` $ find -name "*.swp" -exec rm ` {} ` `';' `.
The {} is a place holder that will be filled with all the file names that result from the find expression and the preceding command will run on each one individually.
You also have to end the command with either ';' (including the single quotes) or \ both are fine.
You can also use the -ok option which behaves the same as -exec except that find will prompt you for permission before executing the command.
This makes it a good way to test your results before blindly executing any potentially dangerous commands.
Sometimes, you might want to find files based on their size, last use, creation, etc.
To find based on time e.g. ` $ find / -ctime 3 `.
c-time is when inode meta-data (i.e. file ownership, permissions, etc) last changed.
It is often, but not necessarily, when the file was created.

You can also search for accessed/last read(-atime) or modified/last written(-mtime) times.
The number is the number of days and can be expressed as either a number (n) that means the exact value +n, which is greater than the value, or -n less than.
There are similar options of rminutes (-cmin, amin, mmin).
e.g. finding based on sizes ` $ find / -size 0 `.
Note that the size here is in 512-byte blocks by default.
You can also specify bytes (c), kilobytes (k), megabytes (M), gigabytes (G), etc.
As with the time numbers above, file sizes can also be exact number (n), +n, or -n.
For more details, consult the find man page.
e.g. to find files greater than ` 10MB ` in size and run a command on those files ` $ find / -size +10M -exec command {} \ `.

### SECTION 4: WORKING WITH FILES
___

Linux has many commands that help in:
  * viewing the contents of a file
  * creating a new file or empty file
  * changing the timestamp of a file
  * removing and renaming a file or directory

These command help you in managing your data and files and ensuring the correct data is available at the correct location.
You can use the following utilities to help view files:
  * ` cat ` - use for viewing files that are not very long; it does not provide any scroll-back
  * ` tac ` - used to look at a file backwards, starting with the last line
  * ` less ` - used to view larger files because it is a paging program; it pauses at each screenfull of text and provides search and scrollback capabilities
    Use ` / ` to search for a patter in the forward direction and ? to search for a pattern in the backwards direction
  * ` tail ` - use to print the last 10 lines of a file by default you can also use -n for an n number of the last lines in a file e.g. -n 15 for the last 15
  * ` head ` - the opposite of ` tail `

` touch ` is a command that can be used to set or update the access, change and modify times of files
By default, it resets a file's time stamp to match the current time.
You can also create an empty file using touch e.g. ` $ touch <filename> `.
This is normally done to create an empty file as a placeholder for a later purpose.
touch provides several options including.
-t to set the date and time stamp of the file e.g. ` $ touch -t 03201600 myfile `.
This sets the file, myfile's timestamp to ` 4 p.m. March 20th (03 20 1600) `.
` mkdir ` is used to create a directory e.g.:
  * ` $ mkdir sampdir `
  * ` $ mkdir /usr/sampdir `

Removing a directory is done with ` rmdir `.
The directory must be empty or it will fail.
To remove a directory and all of its contents you have to do ` rm -rf `.
File commands:
  * ` mv ` - rename a file/move a file
  * ` rm ` - remove a file
  * ` rm -f ` - forcefully remove a file
  * ` rm -i ` - interactively remove a file

If you aren't sure about the files you are removing, it is best to use ` rm -i `.
You can also use some of the same commands or similar ones on directories:
  * ` mv ` - rename a directory/move a directory
  * ` rmdir ` - remove and empty directory
  * ` rm -rf ` - forcefully remove a directory

The ` PS1 ` variable is the character string that is displayed as the prompt on the command line.
Most distributions set ` PS1 ` to a known default value which is fine in most cases.
You can have custom information shown on the command line.
e.g. some sysadmins require the user and the host name to show up on the command line (` student@quad32 $ `).
This can be useful if you are working multiple roles and want to always be reminded of who you are and what machine you are on.
The prompt above could be implemented using ` \u@\h \$ `.
Other options:
  * ` $ echo $PS1 `
  * ` \$ `
  * ` $ PS1="\u@\h \$ " `
  * ` coop@quad64 $ echo $PS1 `
  * ` \u@\h \$ `
  * ` coop@quad64 $ `

### SECTION 5: INSTALLING SOFTWARE
___

The core parts of a Linux distro and most of its add-on software are installed via the Package Management System.
Each package contains the files and other instructions needed to make one software component work on the system.
Packages can depend on each other.
e.g. a package for a web-based application written in PHP can depend on the PHP package.
There are two broad families of package managers:
  * Those based on Debain
  * Those which use RPM

The two systems are incompatible, but provide the same features on a broad level.
Both package management systems provide two tool levels:
  * A low-level tool (such as dpkg or rpm) that takes care of unpacking individual packages, running scripts, and getting the software installed correctly
  * A high-level tool (such as apt-get, yum, or zypper) that works with groups of packages, downloads packages from the vendor, and figures out dependencies

Most of the time, users need to work only with the high-level tool which will take care of calling the low level tool as needed.
Dependency tracking is a particularly important feature of the high-level tool.
It handles the details of finding and installing each dependency for you.
Be careful because installing a single package could result in hundreds of dependent packages being installed.
The Advanced Packaging Tool (dpt) is the underlying package management system in Debian-based systems.
It forms the backend for graphical package managers (e.g. Ubuntu Software Center, synaptic), but its native user interface is the command line.
These command line programs include apt-get and apt-cache.

Yellowdog Update Modified (yum) is the command-line package management utility for RPM Linux systems (e.g. Fedora).
yum has both the command line and the GUI.
zypper is a package management system for openSUSE also based on RPM.
zypper allows you to manage repositories from the command line as well.
zypper is fairly straightforward and closely resembles yum.
Basic operations for RPM and dpkg based systems:

 Operation                     | RPM                        |Deb
 -                             |-                           |-
 Install Package               | rpm -i foo.rpm             | dpkg --install foo.deb
 Install package, dependencies | yum install foo            | apt-get install foo
 Remove package                | rpm -e foo.rpm             | dpkg --remove foo.deb
 Remove package, dependencies  | yum remove foo             | apt-get autoremove foo
 Update package                | rpm -U foo.rpm             | dpkg --install foo.deb
 Update package, dependencies  | yum update foo             | apt-get install foo
 Update entire system          | yum update                 | apt-get dist-upgrade
 Show all installed packages   | rpm -qa/yum list installed | dpkg --list
 Get information on package    | rpm -qil foo               | dpkg --listfiles foo
 Show packages named foo       | yum list "foo"             | apt-cache search foo
 Show all available packages   | yum list                   | apt-cache dumpavail foo
 What package is file part of  | rpm -qf file               | dpkg --search file

### SUMMARY
___

  * Virtual terminals (VT) in Linux are consoles or command line terminals that use the connected monitor and keyboard.
  * Different Linux distros start and stop the graphical desktop in different ways.
  * A terminal emulator program on the graphical desktop works by emulating a terminal within a window on the desktop.
  * The Linux system allows you to either log in via text terminal or remotely via the console.
  * When typing your password, nothing is printed to the terminal, not even a generic symbol to indicate what you typed.
  * The preferred method to shut down or reboot the system is to use the shutdown command.
  * The are two types of pathnames: absolute and relative.
  * An absolute pathname begins with the root directory and follows the tree, branch by branch, until it reaches the desired directory of the file.
  * A relative pathname starts from the present working directory.
  * Using hard and soft (symbolic) links is extremely useful in Linux.
  * cd remembers where you were last and lets you go back there with ` cd - `.
  * locate performs a database search to find all file names that match a given pattern.
  * find locates files recursively from a given directory or set of directories.
  * find is able to run commands on the files that it lists when used with the -exec option.
  * touch is used to set the access, change, and edit times of files, as well as to create empty files.
  * The Advanced Packaging Tool (apt) package management system is used to manage installed software on Debian-based systems.
  * You can use the Yellowdog Updater Modified (yum) open-source command-line package management utility for RPM-compatible Linux distros.
  * The zypper package management system is based on RPM and used for openSUSE.
