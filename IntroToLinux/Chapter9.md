# Chapter 9: User Environment

### INTRODUCTION
___

By the end of this chapter, you should be able to:
  * Use and configure user accounts and user groups
  * Use and set environment variables
  * Use the previous shell command history
  * Use keyboard shortcuts
  * Use and define aliases
  * Use and set file permissions and ownership

### SECTION 1: ACCOUNTS
___

Linux is a multiuser operating system (more than one user can log in at the same time).
To list the currently logged-on users, type ` $ who `.
To identify the current user type ` $ whoami `.
Use ` $who ` with the ` -a ` option to give more detailed information.
Linux uses groups to organize users.
Groups are collections of accounts that share permissions.
Control of group membership is administered through the /etc/group file which shows a list of groups and their members.
By default, every user belongs to the default/primary group.
Whenever a user logs in, the group membership is set for their primary group and all the members who have the same level of access and privilege.
Permissions on various files and directories can be modified at the group level.
All Linux users are assigned a unique user ID (uid) which is an integer.
They are also assigned one or more group IDs (gid) including a default one which is the same as the user ID.
Fedora systems start uids at 500 while other distros start at 1000.
The numbers associated with names through the files /etc/passwd and /etc/group.
e.g. the first file might contain ` george:x:1002:1002:George Metesky:/home/george:/bin/bash `.
e.g. and the second ` george:x:1002 `.
Groups are used to make a set of users who have common interests in terms of:
  * access rights
  * privileges
  * security considerations

Access rights to files (and devices) are granted on the basis of the user and the group that they belong to.
Distros have straightforward graphical interfaces for creating and removing users and groups and manipulating group membership.
It is often useful to do so from the command line or from within shell scripts.
Only the root user can add and remove users and groups.
Adding a new user is done with ` useradd ` and removing an existing user is done with ` userdel `.
An account for the new user turkey would be done with ` $ sudo useradd turkey `.
Note that in openSUSE, useradd is not in the normal user's PATH so the command would be ` $ sudo /usr/sbin/useradd turkey `.
this sets the default home directory to ` /home/turkey ` and populates it with some basic files.
It also adds a line to ` /etc/passwd ` such as.
` turkey:x:502:502::/home/turkey:/bin/bash `.
This sets the default shell to ` /bin/bash `.
Removing a user account can be done with ` $ userdel turkey `.
This will leave the ` /home/turkey ` directory intact.
This can be useful for temporary inactivation.

To remove the home directory also you can add the ` -r ` option to ` userdel `.
Typing id with no argument gives information about the current user.
e.g. typing ` $ id ` will give `uid=500(george) gid=500(george) groups=106(fuse),500(george) `.
If given the name of another user as an argument, id will report information about that other user.
Adding a group can be done with ` groupadd `.
e.g. ` $ sudo /usr/sbin/groupadd anewgroup `.
Groups can be removed with
` $ sudo /usr/sbin/groupdel anewgroup `
Adding a user to an already existing group is done with ` usermod `.
e.g.
  1. You would first look at what groups the user belongs to
    * ` $ groups turkey `
    * ` turkey : turkey `
  2. Then add the new group
    * ` $ sudo /usr/sbin/usermod -G anewgroup turkey `
    * ` $ groups turkey `
    * ` turkey : turkey anewgroup `

These utilities update ` /etc/group ` as necessary.
` groupmod ` can be used to change group properties such as the Group ID (gid) with the ` -g ` option or its name with the ` -n ` option.
You can also remove users from groups.
The ` -G ` option to ` usermod ` must give a complete list of groups.
If you do:
  * ` $ sudo /usr/sbin/usermod -G turkey turkey `
  * ` $ groups turkey `
  * ` turkey : turkey `

Only the turkey group will be left.
The root account is very powerful and has full access to the system.
Other operating systems call this the administrator or admin account.
In Linux, it is often called the superuser account.
You must be extremely cautious before granting full root access to a user, they rarely need it.
External attacks often consist of tricks used to elevate to the root account.
You can use the ` sudo ` feature to assign more limited privileges to user accounts:
  * on a temporary basis
  * only for a specific subset of commands

When elevating privileges, you can use the command ` su ` (switch or substitute user) to launch a new shell running as another user.
To do this, you must type in that other users' password.
Most often, the other user is root and the new shell allows the use of elevated privileges until exited.
It is almost always bad practice to use ` su ` to become root (both for security and stability).
Resulting errors can include deletion of vital files from the system and security breaches.
Granting privileges using ` sudo ` is less dangerous and is preferred.
By default, ` sudo ` must be enabled on a per-user basis.
Some distros (such as Ubuntu) enable it by default for at least one main user, or give this as an installation option.
To fully become root, one merely types ` su ` and is then prompted for the root password.
To execute just one command with root privilege, type ` sudo <command> `.
When the command is complete, you will return to being a normal unprivileged user.

` sudo ` config files are stored in ` /etc/sudoers ` file and the ` /etc/sudoers.d/ ` directory.
By default, the ` sudoers.d ` directory is empty.
In Linux, the command shell program (generally bash) uses one or more startup files to configure the environment.
Files in the ` /etc ` directory define global settings for all users.
Initialization files in the user's home directory can include and/or override the global settings.
The startup files can do anything the user would like to do in every command shell such as:
  * Customizing the user's prompt
  * Defining command-line shortcuts and aliases
  * Setting the default text editor
  * Setting the path for where to find executable programs

When you first login to Linux, /etc/profile is read and evaluated.
After this, the following files are searched (if they exist) in the listed order:
  1. ` ~/.bash_profile `
  2. ` ~/.bash_login `
  3. ` ~/.profile `

The Linux login shell evaluates whatever startup file it comes across first and ignores the rest.
If it finds ` ~/.bash_profile `, it ignores ` ~/.bash_login ` and ` ~/.profile `.
Different distros may use different startup files.
Every time you create a new shell, terminal window, etc. you do not perform a full system login.
Only the ` ~/.bashrc ` file is read and evaulated.
Although this file is not read and evaluated with the login shell, most distros/users include the ` ~/.bashrc ` file from within one of the three user-owned startup files.
In Ubuntu, openSUSE, and CentOS distros, the user must make changes in the ` ~/.bash_profile ` file to include the ` ~/.bashrc ` file.
The ` .bash_profile ` will have certain extra lines which collect the required customization parameters from ` .bashrc `.

### SECTION 2: ENVIRONMENT VARIABLES
___

Environment variables are named quantities that have specific values and are understood by the command shell (e.g. bash).
Some of these are built-in to the system and others can be set by the users at the command line or through startup scripts.
An environment variable is a character string that contains information used by an application.
There are a number of ways to view the value of currently set environment variables.
e.g. ` set `, ` env `, and ` export `.
Depending on the state of your system, ` set ` may print out many more lines than the other two methods.

  * ` $ set `
  * ` BASH=/bin/bash `
  * ` BASHOPTS=checkwinsize:cmdhist:Expand_aliases:extglbo:extquote:force_fignore `
  * ` BASH_ALIASES=() `
  * ` ... `


  * ` $ env `
  * ` SSH_AGENT_PID=1892 `
  * ` GPG_AGENT_INFO=/run/user/me/keyring-Ilf3vt/gpg:0:1 `
  * ` TERM=xterm `
  * ` SHELL=/bin/bash `
  * ` ... `


  * ` $ export `
  * ` declare -x COLORTERM=gnome-terminal `
  * ` declare -x COMPIZ_BIN_PATH=/usr/bin / `
  * ` declare -x COMPIZ_CONIFG_PROFILE=ubuntu `
  * ` ... `

By default, environment variables are created within a script are only available to the current shell.
Child processes will not have access to values that have been set or modified.
Allowing child processes to see the value requires the uses of ` export `.

Task                                  | Command
                                    - | -
Show the value of a specific variable | ` echo $SHELL `
Export a new variable value           | ` export VARIABLE=value ` or ` VARAIBLE=value; export VARIABLE `
Add a variable permanently            | 1. Edit ` ~/.bashrc ` and add the line ` export VARIABLE=value `
                                      | 2. Type ` source ~/.bashrc ` or just ` . ~/.bashrc ` or just start a new shell by typing ` bash `
The ` HOME ` variable is the variable that represents the home (or login) directory of the user.
` cd ` without arguments will change the current working directory to the value of ` HOME `.
Note that the tilde character (` ~ `) is often used as an abbreviation for ` $HOME `.
Thus ` cd $HOME ` and ` cd ~ ` are equivalent statements.

Command          | Explanation
-                | -
` $ echo $HOME ` | Show the value of the ` HOME ` variable (which will return ` /home/me `)
` $ cd /bin `    | Change the directory to ` /bin `
` $ pwd `        | Prints the current working directory (which will return ` /bin `)
` $ cd `         | Changes the directory to the one set by ` $HOME `
` $ pwd `        | Calling ` pwd ` again will return ` /home/me `

` PATH ` is an order4ed list of directories (the path) which is scanned when a command is given to find the appropriate program or script to run.
Each directory in the path is separated by colons ( ` : `).
A null (empty) directory name (or ` ./ `) indicates the current directory and any given time.
  * ` :path1:path2 `
  * ` path1::path2 `

In the example ` :path1:path2 `, there is a null directory before the first colon.
In the second example, there is a null directory between ` path1 ` and ` path2 `
To prefix a private ` bin ` directory to your path:
  1. ` $ export PATH=$HOME/bin:$PATH `
  2. ` $ echo $PATH `
  3. ` /home/me/bin:/usr/local/bin:/usr/bin:/bin/usr `

Prompt Statement (` PS `) is used to customize your prompt string to display the information that you want.
` PS1 ` is the primary prompt variable which controls what your command line prompt looks like.
The following special characters can be included in ` PS1 `:
  * ` \u ` - User name
  * ` \h ` - Host name
  * ` \w ` - Current working directory
  * ` \! ` - History number of this command
  * ` \d ` - Date

They must be surrounded in single quotes when the are used as in the following example:
  * ` $ echo $PS1 `
  * ` $ `
  * ` export PS1='\u@\h:\w$ `
  * ` me@example.com:~$ # new prompt `
  * ` me@example.com:$ `

To revert the changes:
  * ` me@example.com:~$ export PS1='$ ' `
  * ` $ `

Even better practice would be to save the old prompt first and then restore it as in:
  * ` $ OLD_PS1=$PS1 `

This allows you to change the prompt and then eventually change it back with:
  * ` $ PS1=$OLD_PS1 `
  * ` $ `

The environment variable ` SHELL ` points to the user's default command shell.
The command shell handles whatever you type in a command window and usually bash.
` SHELL ` contains the full pathname to the shell:
  * ` $ echo $SHELL `
  * ` /bin/bash `
  * ` $ `

### SECTION 3: RECALLING PREVIOUS COMMANDS
___

Bash will keep track of previously entered commands and statements in a history buffer.
You can recall previously used commands simply by using the ` up ` and ` down ` arrow keys.
To view the list of previously executed commands, you can type history at the command line.
The list of commands is displayed with the most recent item appearing last in the list.
This information is stored under ` ~/.bash_history `.
Several associated environment variables can be used to get information about the history file.
  * ` HISTFILE ` stores the location of the history file.
  * ` HISTFILESIZE ` stores the maximum number of lines in the history file.
  * ` HISTSIZE ` stores the maximum number of lines in the history file for the current session.

Specific keys can perform various tasks.

Key | Usage
- | -
` Up `/` Down ` arrow keys | Browse through the list of commands previously executed
` ! ! ` (pronounced bang-bang) | Execute the previous command
` CTRL+R ` | Search previously used commands

If you want to recall a command in the history list, but don't want to press the arrow key, you can press ` CTRL+R ` to do a reverse intelligent search.
As you start typing, the search goes back in reverse order to the first command that matches the letters you've typed.
You can type more letters to match more specific commands.
The following is an example of how you can use ` CTRL+R ` to search through the command history.
  * ` $ ^R ` # This all happens on 1 line
  * ` (reverse-i-search)'s': sleep 1000 ` # searched for 's'; matched "sleep"
  * ` $ sleep 1000 ` # Pressed enter to execute the searched command

The table below describes the syntax used to execute previously used commands:

Syntax | Task
- | -
` ! ` | Start a histroy substitution
` !$ ` | Refer to the last argument in a line
` !n ` | Refer to the nth command line
` !string ` | Refer to the most recent command starting with string

All history substitutions start with ` ! `.
In the line ` $ ls -l /bin /etc /var `, ` !$ ` refers to ` /var ` which is the last argument in the line.
Below is another example:
  1. ` $ echo $SHELL `
  2. ` $ echo $HOME `
  3. ` $ echo $PS1 `
  4. ` $ ls -a `
  5. ` $ ls -l /etc/ passwd `
  6. ` $ sleep 1000 `
  7. ` $ history `

  * ` $ !1 ` # execute command #1 above
  * ` echo $SHELL `
  * ` /bin/bash `
  * ` $ !sl ` # Execute the command beginning with "sl"
  * ` sleep 1000 `

There are also keyboard shortcuts that you can use to preform different tasks quickly.
The table below lists some of the keybord shortcuts and their uses:

Keyboard Shortcut | Task
- | -
` CTRL+L ` | Clears the screen
` CTRL+D ` | Exits the current shell
` CTRL+Z ` | Puts the current process into suspended background
` CTRL+C ` | Kills the current process
` CTRL+H ` | Works the same as backspace
` CTRL+A ` | Goes to the beginning of the line
` CTRL+W ` | Deletes the word before the cursor
` CTRL+U ` | Deletes from the beginning of the line to the cursor position
` CTRL+E ` | Goes the end of the line
` TAB ` | Auto-completes files, directories, and binaries

### SECTION 4: COMMAND ALIASES
___

You can create custom commands or modify the behaviour of existing commands by creating aliases.
Most often, these aliases are placed in your ~/.bashrc file so they are available to any command shells you create.
Typing alias with no arguments will list currently defined aliases.
Note that there should not be any spaces on either side of the equal sign and the alias definition needs to be placed within either single or double quotes if it contains any spaces.

### SECTION 5: FILE PERMISSIONS
___

In Linux and other UNIX-based systems, every file is associated with a user who is the owner.
Every file is also associated with a group (a subset of all users) which has an interest in the file and certain rights or permissions: read, write, and execute.
The following utility programs involve user and group ownership and permission setting:

Command | Usage
- | -
` chown ` | Change user ownership of a file or directory
` chgrp ` | Change group ownership
` chmod ` | Change the permissions on the file which can be done separately for owner, group, and the rest of the system (often named as other)

Files have three kinds of permission:
  * read (r)
  * write (w)
  * execute (x)

These permissions affect three groups of owners:
  * user/owner (u)
  * group (g)
  * others (o)

As a result, you have the following three groups of permissions
  * rwx: rwx: rwx
  * u: g: o

There are different ways to use chmod.
To give the owner and others execute permission and remove the group write permission:
  * ` $ ls -l test1 `
  * ` -rw-rw-r-- 1 coop coop 1601 Mar 9 15:04 test1 `
  * ` $ chmod uo+x, g-w test1 `
  * ` ls -l test1 `
  * ` -rwxr--r-x 1 coop coop 1601 Mar 9 15:04 test1 `

` u ` stands for the user (ownser), ` o ` stands for other (world), and ` g ` stands for group.
This kind of syntax can be difficult to type and remember, so there is a shorthand which lets you set all the permissions in one step.
This is done with a simple algorithm and a single digit specifies all three permission bits for each entity.
This digit is the sum of:
  * 4 for read permission
  * 2 for write permission
  * 1 for execute permission

Using this scheme, 7 means read/write/execute, 6 means read/write, and 5 means read/execute.
When you apply this the chmod command, you have to give three digits for each degree of freedom such as in:
  * ` $ chmod 755 test1 `
  * ` $ ls -l test1 `
  * ` -rwxr-xr-x 1 coop coop 1601 Mar 9 15:04 test1 `

We can also change file ownership using ` chown `:
  * ` $ ls -l `
  * ` total 4 `
  * ` -rw-rw-r--. 1 bob bob 0 Mar 16 19:04 file-1 `
  * ` -rw-rw-r--. 1 bob bob 0 Mar 16 19:04 file-2 `
  * ` drwxrwxr-x. 2bob bob 4096 Mar 16 19:04 temp `

  * ` $ sudo chown root file-1 `
  * [sudo] password for bob:

  * ` $ ls -l `
  * ` total 4 `
  * ` -rw-rw-r--. 1 root bob 0 Mar 16 19:04 file-1 `
  * ` -rw-rw-r--. 1 bob bob 0 Mar 16 19:04 file-2 `
  * ` drwxrwxr-x. 2 bob bob 4096 Mar 16 19:04 temp `

Wee can also change file ownership using ` chgrp `:
  * ` $ sudo shgrp bin file-2 `
  * ` $ ls -l `
  * ` total 4 `
  * ` -rw-rw-r--. 1 root bob 0 Mar 16 19:04 file-1 `
  * ` -rw-rw-r--. 1 bob bin 0 Mar 16 19:04 file-2 `
  * ` drwxrwxr-x. 1 bob bob 4096 Mar 16 19:04 temp `

### SUMMARY
___

  * Linux is a multiuser system
  * To find the currently logged on users, you can use the ` who ` command
  * To find the current user ID, you can use the ` whoami ` command
  * The ` root ` account has full access to the system
  * It is never sensible to grant full root access to a user
  * You can assign root privileges to regular user acounts on a temporary basis using the ` sudo ` command
  * The shell program (bash) uses multiple startup files to create the user environment
  * Each startup file affects the interactive environment in a different way
  * ` /etc/profile ` provides the global settings startup file
  * Advantages of startup files include that they customize the user's prompt, set the user's terminal type, set the command-line shortcuts and aliases, and set the default text editor
  * An environment variable is a character string that contains data used by one or more applications
  * The built-in shell variables can be customized to suit your requirements
  * The ` histroy ` command recalls a list of previous commands which can be edited and recycled
  * In Linux, various keyboard shortcuts can be used at the command prompt instead of the long actual commands
  * You can customize commands by creating aliases
  * Adding an alias to ` ~/.bashrc ` will make it available for other shells
  * File permission can be changed by typing ` chmod permissions filename `
  * File ownership is changed by typing ` chown owner filename `
  * File group ownerships is changed by typing ` chgrp gropup filename `
