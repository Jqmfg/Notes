# Chapter 2: Linux Philosophy and Concepts

### INTRODUCTION
___

By the end of this chapter you should be able to:
  * Understand the history and philosophy of Linux
  * Describe the Linux community
  * Define the common terms associated with Linux
  * Understand the components of a Linux distribution


### SECTION 1: Linux HISTORY
___

Linux is a free open-source computer OS initially developed for intel x86 personal computers.
It has been ported to many other hardware platforms.
Linux Torvalds was a student in Finland in 1991 when started a project to write his own OS kernel.
He also collected/developed the other parts to create and entire operation system with his kernel.
This became known as the Linux kernel.
In 1992, Linux was re-liscenced using the General Public License(GPL) by GNU (a project of the free software foundation (FSF)).
This made it possible to build a worldwide community of developers.
Numerous other developers created complete systems called Linux distros in the mid-90s.
The Linux distros created in the mid-90s provided the basis for fully free computing.
This became a driving force in the open-source community.
In 1998, major companies like IBM and Oracle announced support for the Linux platform and began their own development efforts.
Today, Linux powers more than half the servers on the internet, android, and nearly all of the world's supercomputers.


### SECTION 2: Linux PHILOSOPHY
___

Every organization or project has a philosophy that works as a guide while framing its objectives and creating its growth path.
This section talks about the Linux philosophy and its impact on development.
Linux is constantly enhanced and maintained by developers from all over the world collaborating over the internet.
Linux Torvalds remains the head of all this.
Technical skill and desire are the only qualifications for participating and contributing.
Linux borrows heavily from the UNIX operation system because it was meant to be an open-source version of UNIX.
Files are stored in a heirarchical file system with the top of the system (root) being ` / `.
Linux always tries to make its components available via files or objects that look like files.
Processes, devices, and network sockets are all represented by file-like objects.
They can often be worked on using the same utilities used for regular files.
Linux is a fully multitasking, multiuser OS with built-in networking and service processes (daemons for the UNIX world).

You use Linux everyday.
over 850,000 android phones are activated every day.
nearly 700,000 TVs are sold every day, most of which run Linux.
Google, Facebook, Twitter, and Amazon are all powered by Linux.
Linux is built collaboratively.
This is the largest collaborative development project in human history.
There are 15 million lines of code.
1.5 million lines were written in the last couple of years.
Linux is developed very quickly.
A new kernel comes out every 2-3 months.
When submitting code to the Linux kernel, patches are submitted.
They can:
  * rework things
  * improve performance
  * fix a problem
  * add new support for a device
  * add a new feature

Developers post their patches to the relevant mailing list.
Patches are accepted by senior developers or maintainers.
When the maintainer finishes their review, they will send the patch to Linus, who has ultimate authority on which patches are applied.


### SECTION 3: Linux COMMUNITY
___

Suppose as part of your job you need to configure a Linux file server and you run into some difficulties.
If you can't figure out the problem yourself, the Linux community can save the day.
There are many ways to engage with the Linux community:
  * post questions on relevant discussion forums
  * subscribe to discussion threads
  * join local Linux groups

In August 1991, Linux Torvalds posted his announcement of Linux.
The penguin is Linux's official mascot.
Linus decided to use the GPL license created by Richard Stallman.
The GPL license gives the user:
  1 The freedom to use the software for any purpose
  2 The freedom to change the software to suit your needs
  3 The freedom to share the software with your friends and neighbors
  4 The freedom to share the changes you make

These ideas fueled Linux's spread around the world.
It forms the foundation of a thriving industry.
In 1999, Red Hat stock tripled as they were the first Linux company to go public.
Linux helped fuel the rise of the internet.
Whenever something is this disruptive, there is bound to be competitive crossfire.
The Linux development community numbers in the thousands.
You use Linux literally every time you go on the internet.
Linux is in many devices that you use every day.
The Linux community has severe ways to connect with each other including:
  * Linux User Groups (both local and online)
  * Internet Relay Chat (IRC) channels such as pidgin and xchat
  * online communities and discussion boards
  * newsgroups and mailing lists
  * Community events such as Linuxcon and Apachecon

The official Linux.com website serves over one million unique visitors every month and has active sections on:
  * news
  * community discussion threads
  * free tutorials and user tips


### SECTION 4: Linux TERMINOLOGY
___

There are many unfamiliar terms that you may come across when you start to use Linux.
You need to be aware of some basic terms such as:
  * kernel
  * distribution
  * boot loader
  * service
  * filesystem
  * X window system
  * desktop environment
  * command line

The kernel is the glue between hardware and applications.
considered the brain of the operating system e.g. the Linux kernel.
A distribution (distro) is a collection of software making up a Linux-based OS.
The bootloader is a program that boots the operating system e.g. GRUB and ISOLinux.
A service is a program that runs as a background process e.g. httpd, named.
A filesystem is a method for storing and organizing files e.g. ext3, ext4, FAT, XFS, NTFS.
The X Window System provides the standard toolkit to build GUIs.
The desktop environment is the GUI on top f the OS.
The command line is an interface for typing commands on top of the operation system.
The shell is the command line interpreter that interprets the command line input and tells the operating system how to process those inputs.


### SECTION 5: Linux DISTRIBUTIONS
___

Suppose you have been assigned a project building a product for Linux.
If we want the project to work on all Linux systems, then we need to learn about different:
  * components
  * services
  * configurations

that are associated with each distribution.
A Linux distribution is related to the Linux kernel because it consists of the kernel plus all the other software tools.
These tools can be used for:
  * file-related operations
  * user management
  * software package management
  * generic proprietary applications
  * Generic free applications
  * Distro-specific applications
  * manuals for applications
  * support services

The current Linux kernel and all past kernels can be found at Linux.org.
Various distros can be based on various kernel versions.
Other essential tools of Linux distributions include:
  * C/C++ compiler
  * gdb debugger
  * core system libraries needed for programs to run
  * low-level interface for drawing graphics on the screen
  * system for installing and updating the various components including the kernel itself

A vast variety of Linux distros cater to different audiences and organizations depending on their specific needs.
Large organizations tend to favor the commercially supported distros e.g. RHEL, SUSE, Ubuntu.
CentOS is a popular free alternative to RHEL.
Ubuntu and Fedora are popular in the education realm.
Scientific Linux is favored by the research community.
Many commercial distros offer long-term fee-based support for their distros, hardware, and software certification.
All major distros provide update services for keeping your system primed with security and bug fixes and online support.


### SUMMARY
___

* The Linux community is the far-reaching ecosystem of envelopers, vendors and users.
* They support and advance the Linux OS.
* A Linux distro consists of the kernel and other software tools for various tasks.
