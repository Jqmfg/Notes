# Chapter 5: System Configuration from the Graphical Interface

### INTRODUCTION
___

By the end of this chapter, you should be able to:
  * Apply system, display, and date and time settings using the system settings panel
  * Track the network settings and manage connections using Network Manager in Linux
  * Install and update software in Linux from the GUI

### SECTION 1: SYSTEM, DISPLAY, DATE AND TIME SETTINGS
___

The System Settings panel allows you to control most of the basic configuration options and desktop settings.
These include:
  * specifying the screen resolution
  * managing network connections
  * changing the date and time of the system

Accessing System Settings various from distro to distro:
  * CentOS: System->Preferences
  * openSUSE: Activities->type Settings into the Search box
  * Ubuntu: Located in the panel on the left of the screen

The display panel under System Settings (or Display and Monitor panel under Configure Desktop) contains the most common settings for desktop appearance.
These settings function independently of the specific display drivers that you are running.
If your system uses a proprietary driver such as those from nVidia or AMD, you will probably have a configuration program for that driver.
This configuration program will not be included in System Settings.
This program many give more configuration options, but may be more complicated and might require root access.
If possible, you should configure the settings in the Displays panel rather than the proprietary configuration program.
The X server which actually provides the GUI uses the /etc/X11/xorg.conf file as its configuration file if it exists.
in modern Linux distros, this file is usually present only in unusual circumstances such as when less common graphic drivers are in use.
Changing this configuration file directly is usually for the more advanced user.

The system can usually figure out the best resolution for a given screen automatically.
However, in some cases, it might get this wrong, or you might want to change the resolution to fit your needs.
This can be accomplished through the Displays panel.
The new resolution will come into effect when you click Apply and then confirm that the new resolution is working.
If the selected resolution didn't work or if you aren't happy with how it looks, the system will switch back to the original resolution after a short time.
In most cases, the configuration for multiple displays is set up automatically as one big screen spanning all monitors.
This will attempt to find a reasonable guess for the screen layout.
If the screen layout is not as desired, then you can change it from this screen.

Linux will always use Coordinated Universal Time (UTC) for its own internal time-keeping.
Display or stored time values rely on the system time zone setting to get the proper time.
UTC is similar to, but more accurate than, Greenwich Mean Time (GMT).
The Date and Time Settings window can be accessed from the System Settings window.
You can also right-click Date and Time on the top panel to access the Date and Time Settings window.
The Network Time Protocol (NTP) is the most popular and reliable protocol for settings the local time via internet servers.
Most Linux distros include a working NTP setup which refers to specific time servers run by the distros.
This means no setup beyond on or off is required for network time synchronization.
If you want, more detailed configuration is possible by editing the standard NTP config file (/etc/ntp.conf).

### SECTION 2: NETWORK MANAGER
___

All Linux distros have network config files, but file formats and locations can differ from distro to distro.
Hand editing of these files can handle complicated setups, but it is not very dynamic or easy to learn and use.
The Network Manager utility was developed to make things easier and more uniform across distros.
It can:
  * list all available networks (wired and wireless)
  * Allow the choice of a wired, wireless, or mobile broadband network
  * handle passwords
  * set up Virtual Private Networks (VPNs)

Except for unusual situations, it's generally bet to let the Network Manager establish connections and keep track of settings.
In this section we will learn how to manage network connections, including wired and wireless connections, and mobile broadband and VPN connections.
Wired connections usually do not require any manual configuration.
The hardware and signal presence are automatically detected and the Network Manager sets the actual network settings via DHCP (Dynamic Host Control Protocol).
For static configurations that don't use DHCP, manual setup can also be done through Network Manager.
You can also change the Ethernet Media Access Control (MAC) address if your hardware supports it.
The MAC address is a unique hexadecimal number of your network card.

Wireless networks are not connected to the machine by default.
You can view the list of available wireless networks and see which ones you are connected to by using Network Manager.
You can add, edit, or remove known wireless networks, and also specify which ones you want connected by default when present..
You can set up a mobile broadband connection through the Network Manager.
This will launch a wizard to set up the connection details for each connection.
Once the config is done, the network is configured automatically each time the broadband network is attached.

Network Manager can also manage VPN connections.
It supports VPN technologies such as IPSec, Cisco OpenConnect, Microsoft PPTP, and OpenVPN.
You might get support for VPN as a separate package from your distributor.
You need to install this package if the preferred VPN is not supported.

### SECTION 3: INSTALLING AND UPDATING SOFTWARE
___

Each package in a Linux distro provides one piece of the system e.g.:
  * Linux kernel
  * C compiler
  * shared software code for USB devices
  * Firefox web browser

Packages often depend on each other.
Firefox communicated using SSL/TLS and depends on the packages for those encryption methods.
It won't install unless those packages are also installed.
One utility handles the low-level details of installing/unpackaging a package.
Most of the time, you will be working with a high-level utility which downloads packages from the internet.
This utility can manage dependencies and groups for you.
Package Management in Debian is handled through dpkg.
It can install, remove, and build packages.
It doesn't automatically download and install packages to satisfy dependencies.

The higher-level package management system is the apt (Advanced Package Tool) system of utilities.
Each distro within the Debian family will usually use apt.
It creates its own user interface on top of it (e.g. apt-get, aptitude, synaptic, Ubuntu Software Center, Update Manager, etc.).
Apt repositories are usually compatible with each other, but the software they contain generally isn't.
Most apt repositories target a particular distro e.g. Ubuntu.
Software often ships with multiple repos to support multiple distros.
The Red Hat Package Manager (RPM) is also popular on Linux distros.
It was developed by Red Hat and is currently used by distros like openSUSE, Madriva, and CentOS.
The high-level package manger differs between distros.
Most use the basic format used in yum (Yellowdog Updater, Modified).
yum is the package manager used for Fedora and RHEL.
they include changes to fit the features they support.
The GNOME project has been developing PackageKit as a unified interface.
This is now the default interface for Fedora.
openSUSE uses YaST (Yet another System Tool).
openSUSE used to use apper, but it has been replaced.
The YaST Software Manager is similar to other graphical package managers.
It is an RPM-based application.
You can add, remove, and update packages with this application.
To access the YaST Software Manager:
  * Click Activities
  * In the Search box type YaST
  * Click the YaST icon
  * Click Software Management
OpenSUSE's YaST Software Management application is similar to the graphical package managers in other distros.


SUMMARY

  * You can control basic config options and desktop settings through they System Settings panel.
  * Linux uses Coordinated Universal Time (UTC) for its own internal time keeping.
  * You can set Date and Time Settings from the System Settings window.
  * The Network Time Protocol is the most popular and reliable protocol for setting the local time via internet servers.
  * The Displays panel allows you to change the resolution of your display and configure multiple screens.
  * Network Manager can present available wireless networks, allow the choice of wireless or mobile broadband networks, handle passwords, and set up VPNs.
  * dpkg and RPM are the most popular package management systems used on Linux distros.
  * Debian distros use dpkg and apt-based utilities for package management.
  * RPM was developed by Red Hat and adopted by a number of other distros including openSUSE, Mandriva, CentOS, Oracle Linux, and others.
