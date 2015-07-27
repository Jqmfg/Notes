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
