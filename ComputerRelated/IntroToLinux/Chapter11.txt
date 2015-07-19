# Chapter 11: Local Security Principles

### INTRODUCTION
___

By the end of this chapter, you should:
  * Have a good grasp of best practices and tools for making Linux systems as secure as possible
  * Understand the powers and dangers of using the root (superuser) account
  * Know how to use thee ` sudo ` command to perform privileged operations while restricting enhanced powers as much as feasible
  * Be able to explain the importance of process isolation and hardware access
  * Know how to work with passwords, including how to set and change them
  * Describe how to secure the boot process and hardware resources

### SECTION 1: UNDERSTANDING LINUX SECURITY
___

The Linux kernel allows properly authenticated users to access files and applications.
Each user is identified by a unique integer (the user id or UID.)
A separate database associates a username with each UID.
When an account is created, new user information is added to the user database and the user's home directory is created and populated with some essential files.
You can use command line programs like ` useradd ` and ` userdel ` along with GUI tools to create and remove accounts.
For each user, the following table lists the seven fields that are maintained in the /etc/passwd file.

Field Name | Details | Remarks
- | - | -
Username | User login name | Should be between 1 and 32 characters long
Password | User password (or the character 'x' if the password is stored in the /etc/shadow file) in encrypted format | Is never show in Linux when it is being typed
User ID (UID) | Every user must have a user id (UID) | <ul><li>UID 0 is reserved for the root user</li><li>UIDs ranging from 1-99 are reserved for other predefined accounts</li><li>UIDs ranging from 100-999 are reserved for system accounts and groups (except for RHEL which reserves only up to 499)</li><li>Normal users have UIDs of 1000 or greater, except on RHEL where they start at 500</li></ul>
Gropu ID (GID) | The primary Group ID (GID) is stored in the /etc/group file | Will be covered ein further detail in the chapter on processes
User Info | This field is optional and allows insertion of extra information about the user such as their name | e.g. Rufus T. Firefly
Home Directory | The absolute path location of the user's home directory | e.g. /home/rtfirefly
Shell | The absolute location of the user's default shell | e.g. /bin/bash

By default, Linux distinguishes between several account types to isolate processes and workloads.
Linux has four types of accounts:
  * root
  * System
  * Normal
  * Network

For a safe working environment, it is advised to grant the minimum privileges possible and necessary to the accounts and remove inactive accounts.
The last utility, which shows the last time each user has logged into the system, can be used to help identify potentially inactive accounts should be considered for removal.
Keep in mind that you should be more strict on multi-user systems than you are on personal desktop systems that only affect the casual user.
The practices in this chapter are meant for use on enterprise servers that you can use on all systems, but they can be relaxed on personal systems.

root is the most privileged account on a Linux/UNIX system.
This account has the ability to carry out all facets of system administration, including adding accounts, changing user passwords, examining log files, installing software, etc.
Utmost care must be taken when using this account; it has no security restrictions on it.
When you are signed in as or acting as root, the shell prompt displays ` # ` (If you are using bash and haven't customized the prompt.)
This convention is intended to serve as a warning of the absolute power of this account.


### SECTION 2: UNDERSTANDING THE USAGE OF THE ROOT ACCOUNT
___

You must have root privileges in order to perform operations such as:
  * Creating, removing, and managing users accounts
  * Managing software packages
  * Removing or modifying system files
  * Restarting system services

Regular account users of Linux distros may be allowed to install software packages, update some settings, and apply various changes to the system.
However, root privilege is required for performing some administration tasks such as restarting services, manually installing packages, and managing parts of the filesystem that are outside of the normal user's directories.

To create a new user account in Linux:
  1. At the command prompt, as root, type ` $ useradd <username> `
  2. To set the inital password, type ` $ passwd <username> `: the new password prompt is displayed
  3. You must enter and confirm the new password
  4. The message ` passwd: all authentication tokens updated succesfully ` is displayed

A regular account user can perform some operations requiring special permissions.
The system configuration must allow such abilities to be exercised.
SUID (Set owner User ID upon execution - similar to the Windows "run as" feature) is a special kind of file permission given to a file.
SUID provides temporary permissions to a user to run a program with the permissions of the file owner instead of the permissions held by the user.
The table below provides examples of operations that don't require root:

Operations that do not require Root privilege | Examples of this operation
- | -
Running a network client | Sharing a file over the network
Using devices such as printers | Printing over the network
Operations on files that the user has proper permissions to access | Accessing files that you have access to or sharing data over the network
Running SUID-root applications | Executing programs such as ` passwd `

### SECTION 3: USING SUDO; THE IMPORTANCE OF PROCESS ISOLATION LIMITING HARDWARE ACCESS AND KEEPING SYSTEMS CURRENT
___

In Linux, you can use either ` su ` or ` sudo ` to temporarily grant root access to a normal user.
The two methods are very different.
The table below illustrates some of the differences between the two.

` su ` | ` sudo `
- | -
When elevating privilege, you need to enter the root password. Giving the root password to a normal user should never be done. | When elevating privilege, you need to enter the user's password and not the root password.
Once a user elevates to the root account using ` su `, the user can do anything that the root user can do for as long as the user wants without being asked again for a password. | Offers more features and is considered more secure and more configurable. Exactly what the user is allowed to do can be precisely controlled and limited. By default, the user will either always have to keep giving their password to do further operations with ` sudo `, or can avoid doing so for a configurable time interval.
The command has limited logging features. | The command has detailed logging features.

` sudo ` has the ability to keep track of unsuccessful attempts at gaining root access.
User's authorization for using ` sudo ` is based on configuration information stored in the ` /etc/sudoers ` file and in the ` /etc/sudoers.d ` directory.
A messsage such as the following would appear in a system log file (usually ` /var/log/secure `) when trying to execute ` sudo bash ` without successfully authenticating the user:

  * ` authntication failure; logname=op uid=0 euid=0 tty=/dev/pts/6 ruser=op rhost= user=op `
  * ` conversation failed `
  * ` auth could not identify password fo [op] `
  * ` op : 1 incorrect password attempt ` ;
  * ` TTY=pts/6 ; PWD=/var/log ; USER=root ; COMMAND=/bin/bash `

Whenever `sudo ` is invoked, a trigger will look at ` /etc/sudoers ` and the files in ` /etc/sudoers.d ` to determine if the user has the right to use ` sudo ` and what the scope of their privilege is.
Unknown user requests and requests to do operations not allowed to the user even with ` sudo ` are reported.
You can edit the ` sudoers ` file by using visudo.
This ensures that only one person is editing the file at a time, has the proper permissions, and refuses to write out the file and exit if there is an error in the changes made.
The basic structure of an entry is ` who where = (as_whom) what `.
The file has a lot of documentation in it about how to customize.
Most Linux distros now prefer that you add a file in the directory ` /etc/sudoers.d ` with the same name as the user.
This file contains the individual user's ` sudo ` configuration and one should leave the master configuration file untouched except for changes that affect all users.
By default, ` sudo ` commands and any failures are logged  in ` /var/log/auth.log ` under the Debian distro family and in ` /var/log/messages ` or ` /var/log/secure ` on other systems.
This is an important safeguard to allow for tracking the accountability of ` sudo ` use.
A typical entry of the message contains:
  * Calling username
  * Terminal info
  * Working directory
  * User account invoked
  * Command with arguments

Running a command such as ` $ sudo whoami ` results ina  log file entry such as ` Dec 8 14:20:47 server1 sudo: op : TTYP=pts/6 PWD=/var/log USER=root COMMAND=/usr/bin/whoami `
Linux is considered to be more secure than many other operating systems because processes are naturally isolated from each other.
One process cannot normally access the resources of another process, even when that process is running with the same user privileges.
Additional security mechanisms that have been recently introduced in order to make risks even smaller are:
  * Control Gropus (cgroups): Allows sysadmins to group processes and associate finite resources to each group
  * Linux Containers (LXC): Makes it possible to run multiple isolated Linux systems (containers) on a single system by relying on cgroups
  * Virtualization: Hardware is emulated in such a way that not can processes be isolated, but entire systems can be run simultaneously as isolated and insulated guests (virtual machines) on one physical host

Linux limits user access to non-networking hardware devices in a manner that is extremely siilar to regular file access.
Applications interact by engagin nthe filesystem layer (which is independent of the actual device or hadrware the file resides on.)
This layer will then open a device special file (often called a device node) under the ` dev ` directory that corresponds to the device being accessed. Each device special file has standard owner, group, and world permission fields. Security is naturally enforced just as it is when standard files are accessed.
Hard disks, for example, are represented as ` /dev/sd* `.
While a root user can read and write to the disk in a raw fashion by doing something like ` $ echo hello world > /dev/sda1 `, the standard permissions as show in the figure make it impossible for regular users to do so.
Writing to a devices in this fashion can easily obliterate the filesystem stored on it in a way that cannot be repaired without great effort, if at all.
The normal reading an writing of files on the hard disk by applications is done at a higher level through the filesystem and never through direct aces to the device node.

When security problems in either the Linux kernel or applicaions and libraries are discovered, Linux distributions have a good record of reacting quickly and pushing out fixes to all systems by updating their software repositories and sending notifications to update immediately.
The same thing is true with bug fixes and performance improvements that are not security related.
However, it is well known that many systems do not get update frequently enough and problems which have already been cured are allowed to remain on computers for a long time.
This is particularly true with proprietary operating systems where users are either uninformed or distrustful of the vendor's patching policy as sometimes updates can cause new problems and break existing operations.
Many of the most successful attack vectors come from exploiting security holes for which fixes are already known but not universally deployed.
The best practice is to take advantage of your Linux distro's mechanism for automatic updates and never postpone them.
It is extremely rare that such an update will cause new problems.

### SECTION 4: WORKING WITH PASSWORDS
___

Linux verifies authenticity and identity using user credentials.
Originally, encrypted passwords were stored in the ` /etc/passwd ` file, which was readable by everyone.
This made it easy for passwords to be cracked.
On modern systems, passwords are actually stored in an encrypted format in a secondary file name ` /etc/shadow `.
Only those with root access can modify/read this file.
Protecting passwords has become a crucial element of security.
Most Linux distros rely on a modern password algorithm called SHA-512 (Secure Hashing Algorithm 512 bits) developed by the US National Security Agency (NSA) to encrypt passwords.
The SHA-512 algorithm is widely used for security applications and protocols.
These security applications and protocols include TLS, SSL, PHP, SSH, S/MIME, and IPSec.
SHA-512 is one of the most tested hashing algorithms.
For example, (if you want to experement with SHA-512 encoding) the word "test" can be encoded using the program sha512sum to produce the SHA-512 form.

IT professionals follow several good practices for securing the data and password of every user.
  1. Password aging is a method to ensure that users get prompts that remind them to create a new password after a specific period. This can ensure that passwords, if cracked, will only be usable for a limited amount of time. This feature is implemented using ` chage ` which configures the password expiry information for a user.
  2. Another method is to force users to set strong passwords using Pluggable Authentication Modules (PAM). PAM can be configured to automatically verify that a password created or modified using the passwd utility is sufficiently strong. PAM configuration is implemented using a library called pam_cracklib.so, which can be replaced by pam_passwdqcso for more options.
  3. One can also install password cracking programs such as John The Ripper to secure the password file and detect weak password entries. It is recommended that written authorization be obtained before installing such tools on any system that you do not own.

### SECTION 5: SECURING THE BOOT PROCESS AND HARDWARE RESOURCES
___

You can secure the boot process with a secure password to prevent someone from bypassing the authentication step. For systems using the GRUB boot loader, for the older GRUB version 1, you can invoke grub-md5-crypt which will prompt you for a password and then encrypt as shown on the adjoining screen.
You then must edit ` /boot/grub/grub.conf ` by adding the following line below the timeout entry: ` password --md5 $1$Wnvo.1$qz781HRVG4jUnJXmdSCZ30 `.
You can also force passwords for only certain boot choices rather than all.
For the now more common GRUB version 2, things are more complicated, but you have more flexibility and can do things like use user-specific passwords which can be their normal login password.
Also, you never edit the configuration file ` /boot/grub/grub.cfg ` directly, rather you edit your system configuration files in ` /etc/grub.d / ` and thne run update-grub.
One explanation can be found at https://help.ubuntu.com/community/Grub2/Passwords.

When hardware is physically accessible, security can be compromised by:
  * Key Logging: Recording the real time activity of a computer user including the keys they press. The captured data can either be stored locally or transmitted to remote machines.
  * Network sniffing: Capturing and viewing the network packet level dat on your network.
  * Booting with a live or rescue disk.
  * Remounting and modifying content.

Your IT security policy should start with requirements on how to properly secure physical access to server and workstations.
Physical access to a system makes it possible for attackers to easily leverage several attack vector, in a way that makes all operating system level recommendations irrelevant.
The guidelines of security are:
  * Lock down workstations and servers.
  * Protect your network links such that it cannot be accessed by people you don't  trust.
  * Protect your keyboards where passwords are entered to ensure that keyboards can't be tampered with.
  * Ensure a password protects the BIOS in such a way that the system cannot be booted with a live or rescue DVD or USB key.

For single user computer and those in a home environment, some of the above features (like preventing booting from removable media) can be excessive, and you can avoid implementing them.
However, if sensitive information is on your system that requires careful protection, either it shouldn't be there, or it should be better protected by following the above guidelines.
Like all software, hackers occasionally find weaknesses in the Linux ecosystem. The strength of Linux (and the open source community in general) is the speed with which such vulnerabilities are exposed and remedied.

### SUMMARY
___

  * The root account has authority over the entire system.
  * root privileges may be required for tasks, such as restarting services, manually installing packages, and managing parts of the filesystem that are outside your home directory.
  * In order to perform any privileged operations such as system-wide changes, you need to use either ` su ` or ` sudo `.
  * Calls to ` sudo ` trigger a lookup in the ` /etc/sudoers ` file or in the ` /etc/sudoers.d ` directory which first validates that the calling user is allowed to use ` sudo ` and that it is being used within the permitted scope.
  * One of the most powerful features of ` sudo ` is the ability to log unsuccessful attempts at gaining root access. By default, ` sudo `commands and failures are logged in ` /var/log/auth.log ` under the Debian family and ` /var/log/messages ` in other distros.
  * One process cannot access another process' resources, even when that process is running the the same user privileges.
  * Using the user credentials, the system verifies the authenticity and identity.
  * The SHA-512 algorithm is typically used to encode passwords. They can be encrypted, but not decrypted.
  * Pluggable Authentication Modules (PAM) can be configured to automatically verify that passwords created or modified using the passwd utility are strong enough (what is considered strong enough can also be configured.)
  * Your IT security policy should start with requirements on how to properly secure physical access to servers and workstations.
  * Keeping your systems updated is an important step in avoiding security attacks.
