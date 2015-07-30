# Chapter 6: Finding Linux Documentation

### INTRODUCTION
___

By the end of this chapter you should be able to:
  * Use different sources of documentation
  * Use the man pages
  * access the GNU info system
  * use the help command and the --help option
  * use other documentation sources

### SECTION 1: DOCUMENTATION SOURCES
___

Regardless of whether you are an experienced or inexperienced Linux user, you won't always know how to use everything about Linux.
Sometimes, you will need to consult the help documentation.
Linux-based systems draw from a large variety of sources.
There are numerous places for documentation and ways of getting help.
Distributors consolidate this material and present it an a comprehensive and easy-to-use manner.
Important Linux documentation sources include.
  * The man pages (short for manual pages)
  * GNU Info
  * The help command and --help option
  * Other documentation sources e.g. https://www.gentoo.org/doc/en/

### SECTION 2: THE MAN PAGES
___

The man pages are the most often-used source of Linux documentation.
They provide in-depth documentation about many programs and utilities.
They also include documentation on other topics such as configuration files, system calls, library routines, and the kernel.
Typing man with a topic name as an argument retrieves the information stored in that topic's manual page.
This page will also explain the depth of coverage.
The man pages structure was first introduced in the early UNIX version of the early 1970s.
The man pages are often converted to:
  * Web pages
  * Published books
  * Graphical help
  * Other formats

The man program searches, formats, and displays the information associated with that man page.
Many topics have a lot of information, sot he output is piped through a terminal pager program such as less to be viewed one page at a time.
At the same time, this helps the information be formatted for good visual display.
When no options are given, by default one only sees the dedicated page specifically about the topic.
You can broaden this to view all man pages containing a string in their name using the ` -f ` option.
You can also view all man pages that discuss a specified subject by using the ` -k ` option.
  * ` $ man -f ` generates the same result as typing ` $ whatis `.
  * ` $ man -k ` generates the same result as typing ` $ apropos `.

The man pages are divided into nine numbered chapter (1 through 9).
Sometimes, a letter is appended to the chapter number to identify a specific topic.
e.g. many pages describing part of the X Window API are in chapter 3X.
The chapter number can be used to force man to display the page from a particular chapter.
It is common to have multiple pages across multiple chapters with the same name.
This is especially true for the names of library functions or system calls.
With the ` -a ` parameter, man will display all pages with the given name in all chapters one after another.
Some possible inputs for man include:
  * ` $ man 3 printf `
  * ` $ man -a printf `

### SECTION 3: GNU INFO
___

Another source of Linux documentation is the GNU Info System.
This is the GNU project's standard documentation format (info) which it prefers as an alternative to man.
The info system is more free-form and supports linked sub-sections.
Functionally, the GNU Info System resembles man in many ways.
Topics are connected using links (even though its design predates the Web).
Information can be viewed through the CLI, a graphical help utility, printed, or viewed online.
Typing info with no arguments in a terminal window displays an index of available topics.
You can browse through this topic list using the regular movement keys (e.g. arrows, page up, page down).
You can alos look for a particular topic by using info <topic name>.
The system then searches for the topic in all available info files.
Some useful keys are q to quit, h for help, and enter to select a menu item.
The topic which you view the info page is call a node.
Nodes are similar to sections and subsections in written documentation.
you can move between nodes or view each node sequentially.
Each node may contain menus and linked subtopics (items).
Items can be compared to Internet hyperlinks.
They are identified by an asterisk (` * `) at the beginning of the item name.
Named items (outisde a menu) are identified with double-colons (::) at the end of the item name.
Items can refer to other nodes within the file or to other files.
Some basic keystrokes for moving between nodes:
  * ` n `: go to the next node
  * ` p `: go to the previous node
  * ` u `: move one node up in the index

### SECTION 4: HELP COMMAND
___

The third source of Linux documentation is the use of the help command.
Most commands have an available short description which can be viewed using the ` --help ` or the ` -h ` option along with the command.
e.g. to learn more about the man command, you can use man ` --help .`
The ` --help ` option is useful as a quick reference and displays information faster than the man or info pages.
Some popular commands (e.g. ` echo `) when run in a bash command shell silently run their own built-in versions of system programs or utilities.
This is because it is more efficient to do so with these specific commands.
To view a synopsis of these built-in commands, you can simply type help.
For these built-in commands, help performs the same basic function as the ` -h ` and ` --help ` arguments perform for stand-alone programs.

### SECTION 5: OTHER DOCUMENTATION SOURCES
___

In addition to the man pages, the GNU Info System, and the help command, there are other sources of Linux documentation:
  * Desktop help system
  * Package documentation
  * Online resources

All Linux desktop systems have a graphical help application.
This application is usually displayed as a question-mark icon or an images of a ship's life-preserver.
These programs will contain custom help for the desktop itself and some of its applications.
They will often include graphically rendered info and man pages.
You can also start the graphical help system from a graphical terminal using the following commands:
  * GNOME: gnome-help
  * KDE: khelpcenter

Linux documentation is also available as part of the package management system.
Usually this documentation is pulled directly from the upstream source code, but it can also contain info on how the distro packaged and set up the software.
Such information is placed under the /usr/share/doc directory in a subdirectory named after the package.
This subdirectory might also include the version number.
There are many places to access online Linux documentation and a little bit of searching is usually the best way to find it.
There are also several very good sites that you can use to help find things easier.
Some offer a free,downloadable command line compendium under a Creative Commons license.
http://Linuxcommand.org/tlcl.php.
You can also find helpful documentation for each distro.
Each distro has its own user-generated forms and wiki sections:
  * Ubuntu: https://help.ubuntu.com/
  * CentOS: https://www.centos.org/docs/
  * OpenSUSE: http://en.opensuse.org/Portal:Documentation
  * GENTOO: http://www.gentoo.org/doc/en

You can also use online search sites to locate helpful resources from all over the internet including:
  * blog posts
  * forum and mailing list posts
  * news articles
  * etc.

### SUMMARY
___

  * The main sources of Linux documentation are the man pages, GNU Info, the help options and commands, and a variety of online documentation resources.
  * The man utility searches, formats, and displays man pages.
  * The man pages provide in-depth documentation about programs and other topics about the system including config files, system calls, library routines, and the kernel.
  * The GNU Info System was created by the GNU project as its standard documentation.
  * It is robust and is accessible via command line, web, and graphical tools using info.
  * Short descriptions for commands are usually displayed with the ` -h ` or ` --help ` argument.
  * You can type help at the command line to display a synopsis of built-in commands.
  * There are many other help resources both on your system and on the internet.
