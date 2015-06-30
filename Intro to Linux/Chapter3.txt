# Chapter 3: Linux Structure and Installation

### INTRODUCTION
___

By the end of this chapter, you should be able to:
  * identify Linux filesystems
  * identify the differences between partitions and filesystems
  * describe the boot process
  * know how to install Linux on a computer

### SECTION 1: LINUX FILESYSTEM BASICS
___

A filesystem is a method for storing and organizing arbitrary collections of data in a human-usable form.
There are several different types of filesystems that Linux can use:
  * Conventional disk filesystems (ext2, ext3, ext4, XFS, Btrfs, JFS, NTFS, etc.)
  * Flash storage filesystems (ubifs, JFFS2, YAFFS, etc.)
  * Database filesystems
  * Special purpose filesystems (procfs, sysfs, tmpfs, debugfs, etc.)

This section will describe the standard filesystem layout shared by most Linux distributions.
A partition is a logical part of the disk, whereas a filesystem is a method of storing/finding those files.
The filesystem can be though of as being a family tree that shows descendants and their relationship.
A partition can be though of as the different families, each with their own family tree.
Windows partitions are Disk1; Linux partitions are /dev/sda1.
Windows filesystem types are NTFS/FAT32; Linux filesystem types are usually EXT3/EXT4/XFS....
Windows mounting parameters are drive letters; Linux mounting parameters are mount points.
The windows base folder (for the OS) is the C drive; Linux base folder is ` / `.

Linux filesystems store their important files in a hierarchy called the filesystem hierarchy standard (FHS).
Filesystem standard information can be found here - https://courses.edx.org/asset-v1:LinuxFoundationX+LFS101x.2+1T2015+type@asset+block/LFS101_Ch3_Sec1_FSH.pdf.
The original source documents are also on the website here - http://refspecs.Linuxfoundation.org/fhs.shtml.
This standard ensures that users can move between distros without having to relearn where everything is.
Linux uses the ` / ` character to separate paths unlike windows which uses ` / `.
New drives are mounted as directories in a single filesystem (usually under /media).
A CD-ROM disc labeled FEDORA might end up being found at ` /media/FEDORA `.
Linux filesystem names are case-sensitive.
Many distributions place files not needed as a core utility under ` /usr ` (user).

### SECTION 2: THE BOOT PROCESS
___

In this section, we will learn about what happens in the background when the power button is pressed.
The boot process is the procedure for initializing the system.
The basic process is:
  1. power on
  2. bios
  3. master boot record
  4. boot loader
  5. kernel
  6. initial ram disk
  7. /sbin/init
  8. command shell
  9. x window system

The first step when you power the computer on is Basic Input/Output System (BIOS).
This initializes the hardware including the screen and keyboard, and tests the main memory.
This process is known as the Power On Self Test (POST).
The BIOS software is stored on a ROM chip on the motherboard.
After this, the remainder of the boot process is completed entirely by the OS.
After BIOS is finished, control is passed to the boot loader.
this is usually stored on one of the hard disks in the system, either in the boot sector or the EFI partition.
EFI (Extensible Firmware Interface) or UEFI (Unified EFI).
Before this stage, the machine doesn't have access to any mass storage media.
Afterwards, information on date, time, and peripherals are loaded from CMOS values.

Various boot loaders exist for Linux.
The most common ones are GRUB (GRand Unified Boot loader) and ISOLinux (for booting from removable media).
Most Linux boot loaders present a user interface for choosing alternative options for booting Linux and other OSes.
When booting Linux, the boot loader is responsible for loading the kernel image and the initial RAM disk into memory.
The RAM disk contains some critical files and device drivers needed to start the system.
The first stage of the boot loader resides at the first sector of the hard disk known as the Master Boot Record (MBR).
The MBR is just 512 bytes.
In this stage, the boot loader examines the partition table and founds a bootable partition.
Upon finding a bootable partition, it looks for the second stage boot loader (e.g. GRUB).
this is then loaded into RAM.
This is for the BIOS/MBR method.
Using the EFI/UEFI method, the UEFI firmware reads it's Boot Manager to determine which UEFI application is to be launched.
The firmware launches the UEFI application (e.g. GRUB).

The second stage of the boot loader is located at /boot.
A splash screen is displayed to pick the operation system to boot from.
After choosing the OS, the boot loader loads the kernel of the selected operation system into RAM and passes control of the system to it.
Kernels are almost always compressed, so the first thing it must do is uncompressed itself.
Afterwards, it will check and analyze the system hardware and initialize any hardware device drivers built into the kernel.
The boot loader will load both the kernel and an initial RAM-based file system called initramfs directly into memory so it can be used by the kernel.
When the kernel is loaded into RAM, it initializes and configures the computer's memory and hardware attached to the system.
This includes processors, I/O subsystems, storage devices, and various other things.
The kernel also loads user space applications.
The initramfs filesystem image contains programs and binary files that help mount the root filesystem.
They provide kernel functionality for the needed filesystem and device drivers for mass storage controllers.
These are loaded with a facility called udev (User DEVice).

After the root filesystem has been found, it is first checked for errors.
The mount program instructs the OS that a filesystem is ready for use.
It is then associated with a particular point in the overall hierarchy of the filesystem (the mount point).
If this is successful, then the initramfs is cleared from RAM and the init program is executed ` (/sbin/init) `.
init handles the mounting and transferring over the the real root filesystem.
If hardware drivers are needed for the real root filesystem, then the must be in the initramfs image.
Once the kernel has set up all its hardware, then the /sbin/init program runs.
This becomes the initial process.
It starts other processes to get the system running.
Most other processes trace their origin ultimately to init.
The exceptions are the kernel processes for managing the internal OS details.
Traditionally, the process startup was done using conventions that date back to System V UNIX.

The system passes through a sequence of runlevels that contain collections of scripts that start and stop services.
Each runlevel supports a different mode of running the system.
Within each runlevel, individual services can be set to run, or shut down if running.
New distributions have begun moving away from System V standard, but usually still support it.
Besides starting the system, init is responsible for keeping the system running and for shutting it down cleanly.
It acts as a manager of last resort for all non-kenrel processes.
It will clean up after them when necessary and restarts user login services as needed when users log in and log out.
Near the end of the boot process, init starts a number of text-mode login prompts (through getty).
These enable you to type in a username and password and get to a command shell.
Usually, the default command shell is bash (gnu Borne Again Shell), but there are other command shells available.
The shell prints a text-rompt indicating it is ready to accept commands.
The terminals which run the command shells can be accessed using the ALT key plus a function key.
Most distributions start six text terminals and one graphics terminal starting with f1 or f2.
If the GUI is also started, switching to a text console requires pressing CTRL+ALT+FUNCTION (F7 or F1 is usually the GUI).
you may need to run the startx command in order to start or restart the graphical desktop.

Generally, in a Linux desktop system, the X Window System is loaded as the final step in the boot process.
A service called the display manager keeps track of the displays being provided and loads the X server.
The X server provides graphical services to application sometimes called X clients.
The display manager also handles graphical logins and starts the appropriate desktop environment after a user logs in.
The desktop environment consists of a session manager and the window manager.
The session manager starts and maintains that components of the graphical session.
The window manager controls the placement and movement of windows, window title-bars, and controls.
Although these can be mixed, usually a set of utilities, session manager, and windows manager are provided together as a unit.
If the display manager is not started by default in the default runlevel, you can start X a different way by running startx from the command line.

### SECTION 3: Linux DISTRIBUION INSTALLATION
___

There are many factors that you should think about when choosing a distribution.
Choosing a distro requires some planning.
Some questions to think about before deciding on a distro:
  * What is the main function of your system (server or desktop)?
  * What types of packages are important to your organization e.g. web server, word processing, etc.
  * How much hard disk space is available (when installing Linux on an embedded device, there will be space limitations)
  * How often are packages updated
  * How long is the support cycle for each release i.e. LTS releases have long-term suppor
  * Do you need kernel customization from the vendor
  * What hardware are you running the Linux distribution on e.g. x86, ARM, PPC, etc.
  * Do you need long-term stability or short-term experimental software

A partition layout needs to be decided at the time of installation .
Linux systems handle partitions by mounting them at specific points in the filesystem.
You can modify the design later.
It is easier to try to get it right to begin with.
Nearly all installers provide a reasonable filesystem layout by default.
They either allocate all space dedicated to normal files on one big partition and a smaller swap partition.
Or they separate partitions for some space-sensitive areas like ` /home ` and ` /var `.
You can override the defaults and do something different if you have special needs.
You can also use more than one disk.
All installations include the bare minimum software for running a Linux distribution.
Most installers also provide options for adding categories of software.
Common applications (e.g. firefox and libreoffice), developer tools (e.g. vi and emacs), and other popular services (e.g. apache and MySQL) are usually included.
A desktop environment is also installed by default.

All installers secure the system being installed as part of the installation.
This consists of setting the password for the superuser (root) and setting up an initial user.
In some cases (e.g. Ubuntu) only an initial user is set up.
In this situation, the root user is disabled by default and requires logging in as a normal user and then using sudo.
Some distributions will also install more advanced security frameworks such as SELinux or AppArmor.
Like other operating systems, Linux distributions can be installed through usb, cd/dvd, and other methods.
Most Linux distributions support booting a small image and then downloading the rest of the system over a network.
These small images are usable on media or as network boot images, making it possible to install without any local media at all.
Many installers can do an installation completely automatically using a configuration file to specify installation options.
This file is called a kickstart file for fedora-based systems, an AutoYAST file for SUSE-based systems, and a preseed file for Debian-based systems.

Each distro provides its own documentation and tools for creating and managing these files.
The actual install process is very similar for all distributions.
After booting from the install media, the installer starts and asks for config settings.
These questions can be skipped if an automatic installation file is provided.
Then the installation is performed.
Finally, the computer reboots to the newly-installed system.
Some distros will ask additional questions after the computer reboots.
Oftentimes, you can also install updates as part of the installation process.
This requires internet access.
If this isn't an option, then the system uses the normal update mechanism to retrieve those updates later.

### SUMMARY
___

  * A partition is a logical part of the disk
  * A filesystem is a method of storing/finding files on a hard disk
  * Dividing the hard disk into partitions allows data to be grouped and separated as needed
  * When a failure or mistake occurs, only the data in the affected partition will be damaged
  * The data on the other partitions will likely survive
  * The boot process has multiple steps
  * First the BIOS triggers the boot loader, which the starts the Linux kernel, the initramfs filesystem, and the init program
  * Determining the right distribution requires that you match your requirements with the capabilities of the various distros
