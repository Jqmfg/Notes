# Chapter 8: File Operations

### INTRODUCTION
___

Linux treats almost everything like a file.
By the end of this chapter, you should be able to:
  * Explore the filesystem and its hierarchy
  * Explain the filesystem architecture
  * Compare files and identify different file types
  * Back up and compress data

### SECTION 1: FILESYSTEMS
___

In Linux and all UNIX-like operating systems, it is often said that everything is a file or is treated as such.
This means that whether you are dealing with:
  * Normal data files and documents
  * Devices such as sound cards and printers

You interact with them through the same kind of input/output (I/O) operations.
This is one reason why text editors are so important.
On many systems, the filesystem is structured like a tree.
The tree is usually portrayed as inverted and starts at what is most often called the root directory (` / `).
This marks the beginning of the hierarchical filesystem and is sometimes referred to as the trunk.
The root directory is not the same as the root user.
The hierarchical filesystem also contains other elements in the path (directory names) which are spearated by forward slashes.
e.g. ` /usr/bin/awk `.
The last element is the actual file name.

The Filesystem Hierarchy Standard (FHS) grew out of historical standards from early versions of UNIX such as the Berkeley Software Distribution (BSD).
The FHS provides Linux developers and sysadmins with a standard directory structure for the filesystem.
This helps to provide consistency between systems and distributions.
You can visit http://www.pathname.com/fhs/ for a list of the main directories and their contents in Linux systems.
Linux supports various filesystem type created for Linux along with compatible filesystems from other operating systems such as Windows and MacOS.
Legacy filesystems like FAT are also supported.
Some examples of common filesystems in Linux are:
  * ` ext3 `, ` ext4 `, ` brtfs `, `xfs ` (native Linux filesystems)
  * ` vfat `, ` ntfs `, ` hfs ` (filesystems from other OSes)

Each filesystem resides on a hard disk partition.
Partitions help to organize the contents of disks according to the kind of data contained.
e.g. important program required to run the system are often kept on a separate partition known as root or ` / `.
e.g. the one that contains files owned by regular users is kept separate on /home.
Temporary files created and destroyed during the normal operation of Linux are often located on a separate partition.
This way, using all the available space on a particular partition may not fatally affect the normal operation of the system.
Before you can start using a filesystem, you need to mount it to the filesystem tree at a mount point.
This is a directory (which can be empty) where the filesystem is attached or mounted.
Sometimes you may need to create the directory if it doesn't already exist.
Note: if you mount a filesystem on a non-empty directory, the form contents of that directory are covered-up and not accessible until the filesystem is unmounted.
Because of this, mount points are usually empty directories.
The mount command is used to attacha  filesystem.
This can be local to the computer or on a network.
Arguments include the device node and the mount point.
e.g. ` $ mount /dev/sda5 /home `.
e.g. This will attach the filesystem contained in the disk partition associated with the ` /dev/sda5 ` device node into the filesystem tree at the ` /home ` mount point.
Unless the system is otherwise configured, only the root user has permissions to run mount.

If you want it to be automatically available every time the system starts up, you need to edit the file /etc/fstab accordingly (Filesystem Table).
Looking at this file will show you the configuration for all pre-configured filesystems.
` man fstab ` will display how the file is used and how to configure it.
Typing mount without any arguments will show all presently mounted filesystems.
The command ` $ df -Th ` (disk-free) will display information about mounted filesystems including usage statistics about currently used and available space.
Using NFS (the Network FileSystem) is one of the methods used for sharing data across physical systems.

Many sysadmins mount remote users' home directories on a server in order to give them access to the same files and config files across multiple client systems.
This allows the users to log in to different computers and still have access to the same files and resources.
On the server machine, NFS daemons (built-in networking and service processes in Linux) and other system servers are typically started with
` $ sudo service nfs start `.
The text file ` /etc/exports ` contains the directories and permissions that a host is willing to share with other systems over NFS.
An entry in this file might look like ` /projects *.example.com(rw) `.
This entry allows the directory /projects to be mounted using NFS with read and write (rw) permissions and shared with other hosts in the example.com domain.
Every file in Linux has 3 possible permissions:
  * read (r)
  * write (w)
  * execute (x)

After modifying the ` /etc/exports file `, you can use the ` $ exportfs -av ` command.
This notifies Linux about the directories you are allowing to be remotely mounted using NFS.
You can also restart NFS with ` $ sudo service nfs restart `.
On a client machine, if it is desired to have the remote filesystem automatically mounted upon boot, the ` /etc/fstab ` file is modified to accomplish this.
e.g. an entry in ` /etc/fstab ` might look like the following.
e.g. ` servername:/projects /mnt/nfs/projects nfs defaults 0 0 `.
You can also mount the remote filesystem without a reboot or as a one-time mount by directly using the mount command.
` $ mount servernmae:/projects /mnt/nfs/projects `.
If ` /etc/fstab ` is not modified, this remote mount will not be present the next time the system is restarted.

Certain files like the one mounted at ` /proc ` are called pseudo filesystems because they have no permanent presence anywhere on disk.
The ` /proc ` filesystem contains virtual files (files that exist only in memory).
This permits viewing constantly varying kernel data.
This filesystem contains files and directories that mimic kernel structures and configuration information.
It doesn't contain any real files, but it does contain runtime information (e.g. system memory, devices mounted, hardware configuration, etc.).
Some important files in ` /proc ` are:
  * ` /proc/cpuinfo `
  * ` /proc/nterrupts `
  * ` /proc/meminfo `
  * ` /proc/mounts `
  * ` /proc/partitions `
  * ` /proc/version `

` /proc ` has subdirectories as well including:
  * ` /proc/<Process-ID-#> `
  * ` /proc/sys `

The first example shows there is a directory for every process running on the system which contains vital information about it.
The second example shows a virtual directory that contains a lot of information about the entire system.
In particular, it contains information on hardware and its configuration.
The ` /proc ` filesystem is useful because the information it has is gathered only as needed and never stored on disk.

### SECTION 2: FILESYSTEM ARCHITECTURE
___

Each user has a home directory usually under ` /home `.
The ` /root ` directory on modern Linux systems is the root user's home directory.
The ` /home ` directory is often mounted in a separate filesystem on its own partition.
It is often even exported remotely on a network through NFS.
Sometimes you may group users based on their department or function.
You can create subdirectories in ` /home ` for this.
e.g. a school may organize ` /home ` into ` /home/faculty/ ` ` /home/staff/ ` and ` /home/students/ `.
The ` /bin ` directory contains all executable binaries, essential commands used in single-user mode, and essential commands required by the system including:
  ` ps ` - produces a list of precesses along with stats information for the system
  ` ls ` - produces a listing of the contents of a directory
  ` cp ` - used to copy files

To view a list of programs in ` /bin ` use ` $ ls /bin `.
Commands that are not essential for the system in single-user mode are placed in the ` /usr/bin ` directory.
The ` /sbin ` directory is used for essential binaries related to system administration such as ` ifconfig ` and ` shutdown `.
There is also a ` /usr/sbin ` directory for less essential sysadmin programs.
Sometimes ` /usr ` is a separate fileystem that may not be available/mounted in single-user mode.
This was why essential commands were separated from non-essential commands.
In some of the most modern Linux systems, this distinction is considered obsolete and the ` /usr/bin ` and ` /bin ` directories are linked together as ` /usr/sbin ` and ` /sbin `.
The ` /dev ` directory contains device nodes, a type of pseudo-file used by most hardware and software devices, except for network devices.
This directory is:
  * Empty on the disk partition when it is not mounted
  * Contains entries which are created by the udev system
  * The udev system creates and manages device nodes on Linux
  * It creates them dynamically when devices are found
  * The ` /dev ` directory contains items such as:
    + ` /dev/sda1 ` (the first partition on the first hard disk)
    + ` /dev/lp1 ` (second printer)
    + ` /dev/dvd1 ` (first DVD drive)

The ` /var ` directory contains files that are expected to change in size and content as the system is running (var stands for variable).
There are entries like:
  * System log files: ` /var/log `
  * Package and databse files: ` /var/lib `
  * Print queues: ` /var/spool `
  * Temp files: ` /var/tmp `

` /var ` may be put it its own filesystem so that growth of the files can be accommodated and the file sizes don't fatally affect the system.
Network service directories such as ` /var/ftp ` (the FTP service) and ` /var/www ` (the HTTP service) are also found under ` /var `.
The ` /etc ` directory is home for system config files.
It has no binary programs, although there are some executable scripts.
e.g. the file ` reslv.conf ` tells the system where to go on the network to obtain host name to IP address mappings (DNS).
Files like ` passwd `, ` shadow `, and ` group ` for managing user accounts are found in the ` /etc ` directory.
System run level scripts are found in subdirectories of ` /etc `.
e.g. ` /etc/rc2.d ` contains links to scripts for entering and leaving run level 2.
The ` rc ` directory historically stood for run commands.
Some distros extend the contents of ` /etc `.
e.g. Red Hat adds the sysconfig subdirectory that contains more config files.
The ` /boot ` directory contains the essential files for booting the system.
For every alternate kernel installed on the system, there are four files:
  * ` vmlinuz `: the compressed Linux kernel; required for booting
  * ` initramfs `: the initial ram filesystem; required for booting; sometimes called initrd, not initramfs
  * ` config `: the kernel configuration file; only used for debugging and bookkeeping
  * ` System.map `: kernel symbol table; only used for debugging

Each of these files has a kernel version appended to its name.
The Grand Unified Bootloader (GRUB) files (such as ` /boot/grub/grub.conf ` or ` /boot/grub2/grub2.cfg `) are also found under ` /boot `.
` /lib ` contains libraries (common code shared by applications and needed for them to run) for the programs in ` /bin ` and ` /sbin `.
These library filenames start with ` ld ` or ` lib `.
e.g. ` /lib/libncurses.so.5.7 `...
Most of these are known as dynamically loaded libraries (also called shared libraries or Shared Objects (SOs)).
On some Linux distros, there exists a ` /lib64 ` directory containing 64-bit libraries while ` /lib ` contains 32-bit versions.
Kernel modules are located in ` /lib/modules/<kernel-version-number> `.
Kernel modules are kernel code, often device drivers, that can be loaded and unloaded without restarting the system.
The ` /media ` directory is typically located where removable media such as CDs, DVDs, and USB drives are mounted.
Unless configuration prohibits it, Linux automatically mounts the removable media in the ` /media ` directory when they are detected.
The following is a list of additional directories and their use:
  * ` /opt ` optional application software packages
  * ` /sys ` virtual pseudo-filesystem giving info about the system and the hardware
       can be used to later system parameters and for debugging purposes
  * ` /srv ` site-specific data served up by the system; seldom used
  * ` /tmp ` temporary files; on some distros erased across a reboot and/or may actually be a ramdisk in memory
  * ` /usr ` multi-user applications, utilities, and data

The /usr directory contains non-essential programs in scripts (in the sense that they aren't needed for boot) and has the following subdirectories:
  * ` /usr/include ` header files used to compile applications
  * ` /usr/lib ` libraries for programs in /usr/bin and /usr/sbin
  * ` /usr/lib64 ` 64-bit libraries for 64-bit programs in /usr/bin and /usr/sbin
  * ` /usr/sbin ` non-essential system binaries such as system daemons
  * ` /usr/share ` shared data used by applications, generally architecture-independent
  * ` /usr/src ` source code, usually for the Linux kernel
  * ` /usr/` xz `11R6 ` X Window configuration files; generally obsolete
  * ` /usr/local ` data and programs specific to the local machine including subdirectories bin, sbin, lib, share, include, etc
  * ` /usr/bin ` this is the primary directory of executable commands on the system

### SECTION 3: COMPARING FILES AND FILE TYPES
___

diff is used to compare files and directories.
This utility has many options:
  * ` -c ` provides a listing of differences that include 3 lines of context before and after the lines differing in context
  * ` -r ` used to recursively compare subdirectories as well as the current directory
  * ` -i ` ignore the case of letters
  * ` -w ` ignore differences in spaces and tabs (white space)

To compare two files use ` $ diff <filename1> <filename2> `
You can compare 3 files at once with ` diff3 ` which uses one file as a basis for the other two

e.g. two people made modifications to a file at the same time
diff three shows the difference with ` $ diff3 MY-FILE COMMON-FILE YOUR-FILE `

Many modifications to source code and config files are distributed utilizing patches which are applied with the patch program
A patch file contains the deltas required to update the older version of a file to the new one
Patch files are actually produced by running diff with the correct options ` $ diff -Nur originalfile newfile > patchfile `
Distributing just the patch is more concise and efficient than distributing the entire file
e.g. if only one line needs to change in a file that contains 1000 lines, the patch will just be a few lines long
To apply a patch, you can use either of the following commands:
  * ` $ patch -p1 < patchfile `
  * ` $ patch originalfile patchfile `

The first usage is more common as it is often used to apply changes to an entire directory tree rather than just one file as in the second example
You  can see the man page for patch to see how the other options work
In Linux, a file's extension often doesn't categorize it the way it might in other OSes
You can't assume that file named ` file.txt ` is a text file and not an executable
In Linux, a file name is generally more meaningful to the user of the system than to the system itself
Most applications directly examine a file's contents to see what kind of object it is rather than relying on an extension
This is different from Windows in which .exe represents an executable binary file
The real nature of a file can be ascertained using the file utility
You can examine the contents and certain characteristics to determine if the files are:
  * plain text
  * shared libraries
  * executable programs
  * scripts
  * etc.

### SECTION 4: BACKING UP AND COMPRESSING DATA
___

There are many ways you can back up data or your entire system.
You can do a simple copy with cp, or use a more robust system with rsync.
Both can be used to synchronize entire directory trees.
Types of copies include:
  * ` rsync ` is more efficient because it checks if the file being copied already exists and there is no change in size or modification time.
  * ` rsync ` will avoid necessary copy and save time.
  * ` rsync ` copies only the parts of file that have actually changed.
  * ` cp ` can only copy files to and from destinations on the local machine unless you are copying to or from a filesystem mounted using NFS.
  * ` rsync ` can also be used to copy files from one machine to another.

Locations are designated in ` target:path ` form where the target can be in the form of ` [user@]host `.
The ` user@ ` part is optional and used if the remote user is different from the local user.
` rsync ` is very efficient when recursively copying one directory tree to another because only the differences are transmitted over the network.
You can synchronize the destination directory tree with the origin using the ` -r ` option to recursively walk down the directory tree.
It will copy all files and directories below the one listed as the source.
rsync is a very powerful utility.
e.g. you can back up a project with ` $ rsync -r project-X archive-machine:archives/project-X `.

Note that ` rsync ` can be very destructive.
Accidental misuse can do a lot of harm to data and programs by inadvertently copying changes to where they are not wanted.
Take care to specify the correct options and paths.
It is highly recommended that you first test ` rsync ` commands with a dry-run option to ensure that it provides the results you want.
To use rsync at the command prompt use ` $ rsync sourcefile destinationfile ` where either file can be on the local machine or a networked machine.
File data is often compressed to save disk space and reduce the time it takes to transmit files over networks.
Linux uses a number of methods to perform compression including:
  * ` gzip `: the most frequently used Linux compression utility
  * ` bzip2 `: Produces files significantly smaller than those produced by ` gzip `
  * ` xz `: The mostspace efficient compression utility used in Linux
  * zip: Is often required to examine and decompress archives from other operating systems

These techniques vary in the efficiency of the compression (how much space is saved) and in how long they take to compress.
gnereally the more efficient techniques take longer.
Decompression time doesn't vary as much across different networks.
In addition the tar utility is often used to group files in an archive and then compress the whole archive at once.
` gzip ` is the most commonly used Linux compression utility.
It compresses very well and fast.
The following table provides some usage examples:
  * ` $ gzip * ` compresses all files in the current directory; each file is compressed and renamed with a ` .gz ` extension
  * ` $ gzip -r projectX ` compresses all files in the ` projectX ` directory along with all files of the directory under ` projectX `
  * ` $ gunzip foo ` De-compresses foo found in the file foo-gz; under the hood, gunzip command is actually the same as ` gzip -d `

` bzip2 ` has syntax that is similar to ` gzip `, but it uses a different compression algorithm and produces significantly smaller files.
However, ` bzip2 ` takes more time to work than ` gzip `.
It is more likely used to compress larger files:
  * ` $ gzip2 * ` compresses all files in the current directory and replaces each file with a file renamed with a ` .bz2 ` extension
  * ` $ bunzip2 *.bz2 ` decompress all of the files with extension .bz2 in the current directory; under the hood, ` bunzip2 ` is the same as calling ` bzip2 -d `

` xz ` is the most space efficient compression utility in Linux.
It is used by www.kernel.org to store archives of the Linux kernel.
It trades slower compression for a higher compression ratio:
  * ` $ xz * ` compress all files in the current directory and replace each one with a .` xz ` extension
  * ` $ xz foo ` compress the file foo into ` foo.xz ` using the default compression level (-6) and remove foo if the compression succeeds
  * ` $ xz -dk bar.xz ` decompress ` bar.xz ` into bar and don't remove ` bar.xz ` even if decompression is successful
  * ` $ xz -dcf a.txt b.txt.xz > abcd.txt ` decompress a mix of compressed and uncompressed files to standard output using a single command
  * ` $ xz -d *.xz ` decompress the files using ` xz `

Compressed files are stored with a .` xz ` extension.
The zip program is not often used to compress in Linux, but is often required to decompress archives from other OSes.
It is only used in Linux when you get a zipped file from a Windows user.
It is a legacy program:
  * ` $ zip backup * ` compress all files in the current directory and place them in the file ` backup.zip `
  * ` $ zip -r backup.zip ~ ` archives your login directory (` ~ `) and all files and directives under it in the file ` backup.zip `
  * ` $ unzip backup.zip ` extracts all files in the file backup.zip and places them in the current directory

Historically, tar stood for "tape archive" and was used to archive files to a magnetic tape.
It allows you to create or extract files from an archive file often called a tarball.
You can optionally compress while creating the archive and decompress when extracting the contents:
  * ` $ tar xvf mydir.tar ` extract all the files in mydir.tar into the mydir directory
  * ` $ tar zcvf mydir.tar.gz mydir ` create the archive and compress with ` gzip `
  * ` $ tar jcvf mydir.tar.bz2 mydir ` create the archive and compress with bz2
  * ` $ tar Jcvf mydir.tar. xz mydir ` create and compress with ` xz `
  * ` $ tar xvf mydir.tar.gz ` extract all the files in mydir.tar.gz into the mydir directory; don't have to tell tar it is in ` gzip ` format

You can separate out the archiving and compression stages as in:
  * ` $ tar mydir.tar mydir ; gzip mydir.tar `
  * ` $ gunzip mydir.tar.gz ; tar xvf mydir.tar `
This is slower and wastes space by creating an unneeded intermediary .tar file.
The ` dd ` program is very useful for making copies of raw disk space.
e.g. to back up your MBR (Master Boot Record the first 512 byte sector on the disk that contains a table of partitions) you can type:
` $ dd if=/dev/sda of=sda.mbr bs=512 count=1 `
To use ` dd ` to make a copy of one disk onto another (DELETES everything on the second disk).
An exact copy of the first disk device is created on the second disk device.
` $ dd if=/dev/sda of=/dev/sdb `.
Do not experiment with this command as it can erase a hard disk.
Exactly what the name ` dd ` stands for is unknown.
data definition is the most popular theory, others include disk destroyer and delete data.

### SUMMARY
___

  * The filesystem tree starts at what is often called the root directory (` / `)
  * The Filesystem Hierarchy Standard (FHS) provides Linux developers and sysadmins with a standard directory structure for the filesystem
  * Partitions help to segregate files according to usage, ownership, and type
  * Filesystems can be mounted anywhere on the main filesystem tree at a mounting point
  * Automatic filesystem mounting can be set up by editing ` /etc/fstab `
  * Filesystems like /proc are called pseudo filesystem because they only exist in memory
  * NFS (Network FileSystem) is a useful method for sharing files and data through network systems
  * ` /root ` (slash-root) is the home directory for the root user
  * ` /var ` may be put in its own filesystem so that growth can be contained and not fatally affect the system
  * ` /boot ` contains the basic files needed to boot the system
  * patch is a very useful tool in Linux
  * Many modifications to source code and configuration files are distributed with patch files as they contain the deltas or changes
  * These deltas go from an old version of a file to the new version of a file
  * File extensions in Linux do not necessarily mean that a file is of a certain type
  * cp is used to copy files on the local machine while ` rsync ` can also be used to copy files from one machine to another as well as synchronize contents
  * ` gzip `, ` bzip2 `, ` xz `, and zip are used to compress files
  * tar allows you to create or extract files from an archive file, often called a tarball
  * You can optionally compress while creating the archive and decompress while extracting its contents
  * ` dd ` can be used to make large exact copies even of entire disk partitions efficiently
