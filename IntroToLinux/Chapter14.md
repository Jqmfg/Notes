# Chapter 14: Printing

### INTRODUCTION
___

By the end of this chapter you should know how to:
  * Configure a printer on a Linux machine.
  * Print documents.
  * Manipulate postscript and pdf files using command line utilities.

### SECTION 1: CONFIGURATION
___

To manage printers and print directly from a computer or across a networked environment, you need to know hot configure and install a printer.
Printing itself requires software that converts information from the application you are using to a language your printer can understand.
The standard for printing software is the Common UNIX Printing System (CUPS).
CUPS is the software that is used behind the scenes to print from applications like a web browser or LibreOffice.
It converts page descriptions produced by your applications (put a paragraph here, draw a line here, and so forth) and then sends the information to the printer.
it acts as a print server for local as well as network printers.

Printers manufactured by different companies may use their own particular print languages and formats.
CUPS uses a modular printing system which accommodates a wide variety of printers and aso processes various data formats.
This make the printing process simpler; you can concentrate more on printing and less on how to print.
Generally, the only time you should need to configure your printer is when you use it for the first time.
in fact, CUPS often figures things out on its own by detecting and configuring any printers it locates.
CUPS carries out the printing process with the help of various components:
 * Configuration files
 * Scheduler
 * Job files
 * Log files
 * Filter
 * Printer drivers
 * Backend

CUPS is designed around a print scheduler that manages print jobs, handles admin commands, allows users to query the printer status, and manages the flow of data through all CUPS components.
CUPS has a browser-based interface which allows you to view and manipulate the order and status of pending print jobs.

The print scheduler reads server settings from several configuration files, the two most important of which are ` cupsd.conf ` and ` printers.conf `.
These and all other CUPS related config files are stored under the ` /etc/cups ` directory.
` cupsd.conf ` is where most system-wide settings are located; it doesn't contain any printer-specific details.
Most of the settings available in this file relate to network security.
For example which systems can access CUPS network capabilities, how printers are advertised on the local network, what management features are offered, and so on.
` printers.conf ` is where you will find the printer-specific settings.
For every printer connected to the system, a corresponding section describes the rpinter's status and capabilities.
This file is generated only after adding a printer to the system and should not be modified by hand.
You can view the full list of config files by typing ` $ ls -l /etc/cups/ `.

CUPS stores print requests as files under the ` /var/spool/cups ` (these can actually be accessed before a document is sent to the printer.)
Data files are prefixed with the letter 'd' while control files are prefixed with the letter 'c'.
After a printer successfully handles a job, data files are automatically removed.
These data files belong to what is commonly known as the print queue.

Log files are places in ` /var/log/cups ` and are used by the scheduler to record activities that have taken place.
These files include access, error, and page records.
to view what log files exist, type ` sudo ls -l /var/log/cups `.
Note that on some distros, permissions are set such that you don't need the sudo.)
You can view the log files with the usual tools.

CUPS uses filters to convert job file formats to printable formats.
Printer drivers contain descriptions for currently connected and configured printers and are usually stored under ` /etc/cups/ppd/ `.
The print data is then sent to the printer through a filter and vie a backend that helps to locate devices connected to the system.
When you execute a print command, the scheduler validates the command and processes the print job creating job files according to the settings specified in the config files.
Simultaneously, the scheduler records activities in the log files.
Job files are processes with the help of the filter, printer driver, and backend, and then sent to the printer.

Due to printing being a relatively important and fundamental feature of any Linux distro, most Linux systems come with CUPS preinstalled.
In some cases, especially for Linux server setups, CUPS may have been left uninstalled.
This may be fixed by installing the corresponding package manually.
To install CUPS, ensure that your system in connected to the internet.

After installing CUPS, you'll need to start and manage the CUPS daemon so that CUPS is ready for configuring a printer.
Managing the CUPS daemon is simple; all management features are wrapped around the cups init script, which can easily be started, stopped, and restarted.

Each Linux distro has a GUI application that lets you add, remove, and configure local or remote printers.
Using this application, you can easily set up the system to use both local and network printers.
The following screens show how to find and use the appropriate application in each of the distro families covered in this course.
When configuring a printer, make sure the device is currently turned on and connected to the system; if so, it should show up in the printer selection menu.
If the printer is not visible, you may want to troubleshoot using tools that will determine if the printer is connected.
For common USB printers, for example, the lsusb utility will show a line for the printer.
Some printer manufacturers also require some extra software to be installed in order to make the printer visible to CUPS, however, due to the standardization these days, this is rarely required.

CUPS also comes with its own web server, which makes a configurable interface available via a set of CGI scripts.
The web interface allows you to:
  * Add and remove local/remote printers
  * Configure printers:
    - Local/remote printers
    - Share a printer as a CUPS server
  * Control print jobs:
    - Monitor jobs
    - Show completed or pending jobs
    - Cancel or move jobs

SECTION 2: PRINTING OPERATIONS
___

Many graphical applications allow users to access printing features using the ` CTRL+P ` shortcut.
To print a file, you first need to specify the printer (or a file name and location if youare printing to a file instead) you want to use; then select the page setup, quality, and color options.
After selecting the required options, you can submit the document for printing.
The document is then submitted to CUPS.
You can use your browser to access the CUPS web interface at http://localhost:631/ to monitor the status of a printing job.
Now that you have configured your printer, you can print using either the Graphical or Command Lin interfaces.

CUPS provides two command-line interfaces, descended from the System V and BSd flavors of UNIX.
You can use either lp (System V) or lpr (BSD) to print.
You can use these commands to print text, PostScript, PDF, and image files.
These commands are useful in cases where printing operations must be automated (from shell scripts, for instance, which contain multiple commands in one file.)
lp is just a command line front-end to use the lpr utility that passes input to lpr.
We will only discuss lp in detail.

lp and lpr accept command line options that help you perform all operations that the GUI can accomplish.
lp is typically used with a file name as an argument.
Some lp commands and other printing utilities are listed in the table below:

Command | Usage
- | -
` lp <filename> ` | To print the file to the default printer
` lp -d printer <filename> ` | To print to a specific printer (useful if multiple printers are available)
<code>program &#124; lp \n echo string &#124; lp</code> | To print the output of a program
` lp \n number <filename> ` | To print multiple copies
` lpoptions -d printer ` | to set the default printer
` lpq -a ` | To show the queue status
` lpadmin ` | To configure printer queues

The lpoptions utility can be used to set printer options and defaults.
Each printer has a set of tags associated with it, such as the default number of copies and authentication requirements.
You can execute the command ` lpoptions help ` to obtain a list of supported options.
lpoptions can also be used to set system-wide values such as the default printer.

In Linux, command line print job management commands allow you to monitor the jab state as well as managing the listing of all printers and checking their status, and cancelling or moving print jobs to another printer.
Some of the commands that can be used are listed in the following table:

Command | Usage
- | -
` lpstat -p -d ` | To get a list of available printers, along with their status
` lpstat -a ` | To check the status of all connected printers, including job numbers
` cancel job-id ` \n or \n ` lprm job-id ` | to cancel a print job
` lpmove job-id newprinter ` | To move a print job to a new printer

SECTION 3: MANIPULATING POSTSCRIPT AND PDF FILES
___

Postscript is a standard page description language.
It effectively manages scaling of fonts and vector graphics to provide quality printouts.
It is purely a text format that contains the data fed to a PostScript interpreter.
The format itself is a language that was developed by Adobe in the early 1980s to enable the transfer of data to printers.
Features of PostScript are:
  * It can be used on any printer that is PostScript-compatible; i.e. any modern printer.
  * Any program that understands the PostScript specification can print to it.
  * Information about page appearance etc. is embedded in the page.

enscript is a tool that is used to convert a text file to PostScript and other formats.
It also supports Rich Text Format (RTF) and HyperText Markup Language (HTML).
For example, you can convert a text file to two column (-2) formatted PostScript using the command: ` enscript -2 -r -p psfile.ps textfile.txt `.
This command will also rotate 9-r) the output to print so the width of the paper is greater than the height (landscape mode) reducing the number of pages required for printing.
The commands that are used with enscript are listed in the following table (for a file called ` textfile.txt `):

Command | Usage
- | -
` enscript -p psfile.ps textfile.txt ` | Convert a text file to PostScript (saved to psfile.ps)
` enscript -n -p psfile.ps textfile.txt ` | Convert a text file to n columns where n = 1 - 9 (saved in psfile.ps)
` enscript textfile.txt ` | Print a text file directly to the default printer
