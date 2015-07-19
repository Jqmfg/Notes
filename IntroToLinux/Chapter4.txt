# Chapter 4: Graphical Interface

### INTRODUCTION
___

By the end of this chapter, you should be able to:
  * Manage graphical interface sessions
  * Perform basic operations using the graphical interface
  * Change the graphical desktop to suit your needs

### SECTION 1: SESSION MANAGEMENT
___

You can use either a command line interface (CLI) or a graphical user interface (GUI) when using Linux.
To work in the CLI, you have to remember which programs and commands are used to perform tasks.
You must also remember how to quickly and accurately obtain information about their use and options.
Using the GUI is often quick and easy.
It allows you to interact with your system through graphical icons and screens.
For repetitive tasks, the CLI is more efficient.
The GUI is easier to navigate if you don't remember all the details or only do something rarely.
In this section, we will learn about managing sessions using the GUI for:
  * CentOS (fedora-based)
  * openSUSE (SUSE-based)
  * Ubuntu (Debian-based)

openSUSE uses KDE instead of GNOME as the default desktop manager.
GNOME is a popular desktop environment with an easy to use GUI.
It is bundled as the default desktop environment for many distros including RHEL, Fedora, CentOS, SUSE, and Debian.
GNOME has menu-based navigation and is sometimes an easy translation for Windows suers.
The look and feel can be very different among distro, even if they are all using GNOME.
Another common desktop environment is KDE which the the default in openSUSE.
Other alternatives include UNITY, Xfce, and LXDE.
Most desktop environments follow a similar structure to GNOME.

When you install a desktop environment, the X display manager starts at the end of the boot process.
The X display manager is responsible for starting the graphics system, logging in the user, and starting the user's desktop environment.
You can often select from a choice of desktop environments when logging into the system.
The default display manager for GNOME is gdm.
Other popular display managers include lightdm (Ubuntu) and kdm (associated with KDE).
It is a good idea to lock your screen whenever you step away from your computer to stop them from accessing your computer.
This does not suspend your computer: all the applications and processes are still running.
There are two ways to lock your screen:
  * Using the graphical interface
  * Using the keyboard shortcut ` CTRL+ALT+L `

This keyboard shortcut can be changed using the following methods:
  * CentOS: System->Preferences->Keyboard Shortcuts
  * openSUSE: Configure Desktop->Shortcuts and Gestures
  * Ubuntu: System Settings->Keyboard->Shortcuts

Linux is a true multiuser operating system which allows more than one user to be simultaneous logged in.
If more than one person uses the system, it is best for each person to have their own user account and password.
This allows for individualized settings, home directories, and other files.
Users can be logged in simultaneously through the network.
Besides normal daily starting and stopping of the computer, a system restart may be required as part of a major system update.
These usually are only necessary when installing a new Linux kernel.
The init process is responsible for implementing both restarts and shut downs.
On systems using System V init, run level 0 is usually used for shutting down.
Run level 6 is used to reboot the system.

Shutdown, reboot, and logout operations will ask for confirmation before completing.
This is because many applications will not save their data properly when terminated this way.
Always save your documents and data before restarting, shutting down, or logging out.
Most modern computers support suspend mode or sleep mode when you stop using your computer for a short while.
Suspend mode saves the current system state and allows you to resume your session more quickly.
However, suspend mode uses very little power.
It works by keeping your system's applications, desktop, and so on in the system RAM.
It turns of all other hardware.
The suspend mode bypasses the time for a full system start-up and continues to use minimal power.

### SECTION 2: BASIC OPERATIONS
___

Linux allows you to quickly open applications using the GUI.
Applications are found in different places in Linux:
  * CentOS: the Applications menu in the upper-left corner of the screen
  * openSUSE: the Activities menu in the upper-left corner of the screen
  * Ubuntu: the Dash button in the upper-left corner of the screen
  * KDE: the button in the lower-left corner of the screen

There are also several submenus that exist in Linux for different types of applications including:
  * Accessories
  * Games
  * Graphics
  * Internet
  * Office
  * Sound and Video
  * System Tools

Unlike other OSes, the initial Linux install usually comes with a wide range of applications and software archives.
These can contain thousands of programs that enable you to accomplish a wide variety of tasks with your computer.
For most key tasks, the default application is usually already installed.
You can always install more applications and try different options.
e.g. Firefox is popular as the default browser in many distros while Epiphany, Konqueror and Chromium are usually available.
Proprietary web browser such as opera and chrome are also available.
Locating applications from the GNOME and KDE menu8s is easy as the are organized into submenus.
Multiple applications are available to accomplish various tasks and to open a file of a given type.
e.g. you can click on a web address when reading an email and launch a browser such as Firefox or chrome.
The file managing program can be used to set the default application to be used for any particular file type.
Every user with an account on the system will have a home directory usually created under ` /home ` e.g. /home/student.
By default, saves files will be placed here.
Account creation, whether during system installation or at a later time, also induces default directories to be created under the home directory.
e.g. Documents, Desktop, and Downloads.

Nautilus (the file manager or file browser) allows you to view files and directories in several different formats.
To view files in the icons, list, or compact forms click view drop-down and select your view.
You can also use ` CTRL+1 `, ` CTRL+2 `, and ` CTRL+3 ` respectively.
In addition, you also arrange the files by name, size, type, or modification date for further sorting.
To do so, click view and select arrange items.
Another useful option is to show hidden files.
These are usually configuration files that are hidden by default and whose name starts with a dot.
To show hidden files, click view and select show hidden files or press CTRL+H.
The file browser provides multiple ways to customize your window view to drag and drop.
You can alter the size of the icons by selecting zoom in or zoom out under the view menu.
Nautilus includes a great search tool inside the file browser.
  1. Click search in the toolbar (to bring up a text box).
  2. Enter the keyword in the textbox (Nautilus will perform a recursive search from the current directory for any file or directory that contains part of this keyword).
  3. To open Nautilus from the command line, simply type nautilus.
  4. To open Nautilus in graphical mode, press ` ALT+F2 ` and search for Nautlius.

This will open the graphical interface for the program.
The shortcut key to get to the search text box is ` CTRL+F `.
You can exit the search text box view by clicking the search button again.
Another quick way to access a specific directory is to press ` CTRL+L ` which will give you a location text box to type in a path to a directory.
Nautilus allows you to refine your search beyond the initial keyword by providing drop-down menus to further filter the search:
  * Based on location or file type, select additional criteria from the drop down
  * To regenerate the search, click the reload button
  * To add multiple search criteria, click the + button and select additional search criteria

Editing any text file through the graphical interface is easy in the GNOME desktop environment.
Simply double-click the file on the desktop or in the Nautilus file browser window to open the file associated with the default text editor.
The default text editor in GNOME is gedit.
It is simple yet powerful, ideal for editing documents, making quick notes, and programming.
Although gedit is designed as a general purpose text editor, it offers additional features for spell checking, highlighting, file listings and statistics.
Deleting a file in Nautilus will automatically move the deleted files to .local/share/Trash/files/ directory.
This is under the user's HOME directory.
There are several ways to delete files using Nautilus:
  * Select all the files and directories you want to delete
  * Press ` DELETE ` (Unity/KDE) or ` CTRL+DELETE ` (GNOME) on your keyboard, or right click the file
  * Select move to trash or highlight the file
  * Click edit and move to trash through the GUI

To permanently delete a file:
  * On the left panel inside a Nautilus file browser window, right-click on the Trash directory
  * Select empty trash

Alternatively, you can select the file or directory you want to delete and press SHIFT+DELETE.
As a precaution, you should never delete your HOME directory.
Doing so will most likely erase all your GNOME configuration files and possibly prevent you from logging in.
Many personal system and configuration files are stored under your ` HOME ` directory.

### SECTION 3: GRAPHICAL DESKTOP
___

Each Linux distro comes with its own set of desktop backgrounds.
You can change the default by choosing a new wallpaper or selecting a  custom picture to be set as the desktop background.
If you do not want to use an image as the background, you can select a color instead.
In addition, you can also change the desktop theme.
The desktop theme changes the look and feel of the Linux system.
The theme also defines the appearance of application windows.
If you do not like any of the installed wallpapers, you can use different shades of color as the background.
To do this, use the colors and gradients drop-down in the appearance window.
There are three types of color:
  * solid
  * horizontal gradient
  * vertical gradient

Click the box at the bottom and pick the effect between solid and the two gradients.
In addition, you can also install packages that contain wallpapers by searching for packages using "wallpaper" as a keyword.
The visual appearance of applications (the buttons, scroll bars, widgets, and other graphical compnents) are set by the theme.
GNOME has several different themes that it comes with by default.
The method for changing your theme will depend on your linux distro.
e.g. Ubuntu: right-click anywhere on the desktop->select a different theme from the theme drop down.
e.g. CentOS: System->Preferences->Apppearance.
There are other options that you can use to change the them if you download additional packages.
You can download and install themes from http://art.gnome.org/themes/.
In openSUSE to change themes you will need to install the gnome-weak-tool program.

### SUMMARY
___

  * GNOME is a popular desktop environment and graphical user interface that runs on top of the Linux OS
  * The default display manger for GNOME is called gdm
  * The gdm display manager presents the user with the login screen which prompts for a username and password
  * Logging out kills all processes in your current X session and returns to the display manager login screen
