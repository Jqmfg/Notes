# Chapter 13: Manipulating Text

### INTRODUCTION
___

By the end of this chapter you should be able to:
  * Display and append to file contents using cat and echo.
  * Edit and print file contents using sed and awk.
  * Search for patterns using grep.
  * Use multiple other utilities for file and text manipulation.

### SECTION 1: CAT AND ECHO
___

Irrespective of the role you play with Linux (sysadmin, developer, or user), you often need to browse through and parse text files and/or extract data from them.
These are file manipulation operations.
Thus, it is essential for the Linux user to become adept at performing certain operations on files.
Most of the time such file manipulation is done at the command line which allows users to perform tasks more efficiently than while using a GUI.
Furthermore, the command line is more suitable for automating often executed tasks.
Experienced sysadmins write customized scripts to accomplish such repetitive tasks, standardized for each particular environment.
In this section, we will concentrate on command line file and text manipulation related utilities.

cat is short for concatenate and is one of the most frequently used Linux command line utilities.
It is often used to read and print files as well as for simply viewing file contents.
To view a file, use ` $ cat <filename> `.
For example, ` $ cat readme.txt ` will display the contents of ` readme.txt ` on the terminal.
Often the main purpose of cat is to combine (concatenate) multiple files together.
You can perform the actions listed on the following table using cat:

Command | Usage
- | -
` cat file1 file2 ` | Concatenate multiple files and display the output. i.e. the entire content of the first file followed by that of the second file.
` cat file1 file2 > newfile ` | Combine multiple files and save the output to a new file.
` cat file >> existingfile ` | Append a file to the end of an existing file.
` cat > file ` | Any subsequent lines typed will go into the file until ` CTRL+D ` is typed.
` cat >> file ` | Any subsequent lines typed are appended to the file until ` CTLR+D ` is typed.

The tac command (cat spelled backwards) prints the lines of a file in reverse order.
Each line remains the same, but the order of the lines is reversed.
The syntax of tac is exactly the same at for cat as in:
  * ` $ tac file `
  * ` $ tac file1 file2 > newfile `

cat can be used to read from standard input (such as the terminal window) if no other files are specified.
you can use the ` > ` operator to create and add lines into a new file and the ` >> ` operator to append lines (or files) to an existing file.
To create a new file at the command prompt, type ` $ cat > <filename> `.
The command creates a new file and waits for the user to edit/enter the text.
After you finish tying the required text, press ` CTRL+D ` at the beginning of the next line to save and exit the editing.
Another way to create a file at the terminal is ` $ cat > <filename> << EOF `.
A new file is created and you can type the required input.
To exit, enter ` EOF ` at the beginning of a line.
Note that ` EOF ` is case-sensitive.
You can also use another word such as ` STOP `.

echo simply displays (echos) text.
It is run by typing ` $ echo string `.
echo can be used to display a string on standard output (i.e. the terminal) or to place in a new file (using the ` > ` operator) or append to an already existing file (using the ` >> ` operator.)
The ` -e ` option along with the following switches is used to enable special character sequences such as the newline character or horizontal tab.
  * ` \n ` represents newline.
  * ` \t ` represents tab.

echo is particularly useful for viewing the values of environment variables (built-in shell variables.)
For example, ` $ echo $USERNAME ` will print the name of the user who has logged into the current terminal.
The following table lists echo commands and their usage:

Command | Usage
- | -
` echo string > newfile ` | The specified string is placed in a new file.
` echo string >> existingfile ` | The specified string is appended to the end of an already existing file.
` echo $variable ` | The contents of the specified environment variable are displayed.

### SECTION 2: SED AND AWK
___

It is very common to create and then repeatedly edit and/or extract contents from a file.
This section will cover how to use sed and awk to easily perform such operations.
Note that many Linux users and administrators will write scripts using more comprehensive language utilities such as python and perl rather than use sed and awk (and some other utilities discussed later.)
Using such utilities is fine under most circumstances; one should always feel free to use the tools one is experienced with.
However, the utilities that are described here are much lighter; i.e. they use fewer system resources and execute faster.
There are times (such as during system booting) where a lot of time would be wasted using the more complicated tools and the system may not even be able to run them.
Thus the simpler tools will always be needed.

sed is a powerful text processing tool and is one of the oldest, earliest, and most popular Linux utilities.
It is used to modify the contents of a file, usually placing the contents into a new file.
Its name is an abbreviation for stream editor.
sed can filter text as well as perform substitutions in data streams working like a churn-mill.
Data from an input source/file (or stream) is taken and moved to a working space.
The entire list of operations/modifications is applied over the data in the working space, and the final contents are moved to the standard output space (or stream.)

You can invoke sed using commands like those listed in the following table:

Command | Usage
- | -
` sed -e command <filename> ` | Specify editing commands at the command line, operate on file, and put the output on standard out (i.e. the terminal.)
` sed -f scriptfile <filename> ` | Specify a scriptfile containing sed commands, operate on file, and put output on standard out.

The ` -e ` command allows you to specify multiple editing commands simultaneously at the command line.

The following table lists some basic operations that can be used to perform multiple editing and filtering operations with sed where ` pattern ` is the current string and ` replace_string ` is the new string:

Command | Usage
- | -
` sed s/pattern/replace_string file ` | Substitute the first string occurrence in a line.
` sed s/pattern/replace_string/g file ` | Substitute all string occurrences in a line.
` sed 1, 3s/pattern/replace_string/g file ` | Substitute all string occurrences in a range of lines.
` sed -i s/pattern/replace_string/g file ` | Save changes for string substituion in the same file.

You must use the -i option with care because the action is not reversible.
It is always safer to use sed without the -i option and then replace the file yourself as in ` $ sed s/pattern/replace_string/g file1 > file2 `.
This command will replace all occurrences of pattern with replace_string in file1 and then move the contents to ` file2 `.
The contents of ` file2 ` can be viewed with cat ` file2 `.
If you approve, you can then overwrite the original file with ` mv file1 file2 `.
Example: to convert 01/02/... to JAN/FEB/...:
  * ` $ sed -e 's/01/JAN/' -e 's/02/FEB/' -e 's/03/MAR' -e 's/04/APR/' -e 's/05/MAY/' -e 's/06/JUN/' -e 's/07/JUL/' -e 's/08/AUG/' -e 's/09/SEP' -e 's/10/OCT' -e 's/11/NOV/' -e 's/12/DEC/' `

awk is used to extract and then print specific contents of a file and is often used to construct reports.
It was created at Bell Labs in the 1970s and derived its name from the last names of its authors: Alfred Aho, Peter Weinberger, and Brian Kernighan.
awk has the following features:
  * It is a powerful utility and interpreted programming language.
  * It is used to manipulate data files, retrieving and processing text.
  * It works well with fields (containing a single piece of data, essentially a column) and records (a collection of fields, essentially a line in a file.)

awk is invoked as shown in the following:

Command | Usage
- | -
` awk 'command' var=value file ` | Specify a command directly at the command line.
` awk -f scriptfile var=value file ` | Specify a file that contains the script to be executed along with ` f `.

As with sed, short awk commands can be specified directly at the command line, but a more complex script can be saved in a file that you can specify using the -f option.

The following table explains the basic tasks the can be performed using awk.
The input file is read one line at a time and for each line, awk matches the given pattern in the given order and preforms the requested action.
The ` -F ` option allows you to specify a particular field sparator character.
For example, the ` etc/passwd ` file uses ` : ` to separate the fields, so the ` -F: ` option is used with the ` /etc/passwd ` file.
The command/action in awk needs to be surrounded with apostrophes (or single-quote (')). awk can be used as follows:

Command | Usage
- | -
` awk '{ print $0 }' /etc/passwod ` | Print the entire file.
` awk -F: '{ print $1 }' /etc/passwd ` | Print the first field (column of every line, separated by a space.)
` awk -F: '{ print $1 $6 }' /etc/passwd ` | Print the first and sixth field of every line.

### SECTION 3: FILE MANIPULATION UTILITIES
___

In managing your files, you may need to perform many tasks such as sorting data and copying data from one location to another.
Linux provides several file manipulation utilities that you can use while working with text files.
In this section, you will learn about the following file manipulation programs:
  * sort
  * uniq
  * paste
  * join
  * split

You will also learn about regular expressions and search patterns.

sort is used to rearrange the lines of a text file either in ascending or descending order, according to a sort key.
You can also sort by particular fields of a file.
The default sort key is the order of the ASCII characters (i.e. essentially alphabetically.)
sort can be used as follows:

Syntax | Usage
- | -
` sort <filename> ` | Sort the lines in the specified file.
` cat file1 file2  sort ` | Append the two files, then sort the lines and display the output on the terminal.
` sort -r <filename> ` | Sort the lines in reverse order

When used with the ` -u ` option, sort checks for unique values after sorting the records (lines).
It is equivalent to running ` uniq ` on the output of sort.

uniq is used to remove duplicate lines in a text file and is useful for simplifying text display.
uniq requires that the duplicate entries to be removed are consecutive.
Therefore, one often runs sort first and then pipes the output into uniq; if sort passed the ` -u ` option, it can do all this in one step.
in the example shown, the file is called ` names ` and was originaly ted, Bob, Alice, bob, Carol, Alice.
to remove the duplicate entries from some files, you can do ` $ sort file1 file2 | uniq > file3 ` or ` sort -u file1 file2 > file 3 `
To count the number of duplicate entries, you can use ` $ uniq -c filename `.

Suppose that you have a file that contains the full name of all employees and another file that lists their phone numbers and Employee IDs.
You want to create a new file that contains all the data listed in three columns: name, employee ID, and phone number.
How can you do this effectively without investing too much time?
paste can be used to create a single file containing all three columns.
The different columns are identified based on delimiters (spacing used to separate two fields.)
For example, delimiters can be a blank space, a tab, or an enter.
paste accepts the following options:
  * ` -d ` delimiters which specify a list of delimiters to be used instead of tabs for separating consecutive values on a single line. Each delimiter is used in turn; when the list has been exhausted, paste begins again at the next delimiter.
  * ` -s ` which causes paste to append the data in series rather than in parallel; that is, in a horizontal rather than a vertical fashion.

paste can be used to combine fields (such as name or phone number) from different files as well as combine lines from multiple files.
For example, line one from ` file ` can be combined with line one of ` file 2 `, line two from ` file1 ` can be combined with line two of ` file2 ` and so on.
To paste contents from two files, you can do ` $ paste file1 file2 `.
The syntax to use a different delimiter is ` $ paste -d, file1 file2 `
Common delimiters are 'space', 'tab', '|', 'comma', etc.

Suppose that you have two files with similar columns.
You have saved employee's phone numbers in two files: one with their first name and the other with their last name.
You want to combine the files without repeating the data of common columns.
you can achieve this using join, which is essentially an enhanced version of paste.
It first checks whether the files share common fields such as names or phone numbers, and then joins the lines in two files based on a common field.
To combibne two files on a common field, at the command prompt, type ` $ join file1 file2 `.
For example, the common field (i.e. the field containing the same values) among the phonebook and directory files is the pohne number, as shown by the output of the following cat commands.
  * ` $ cat phonebook `
  * ` 555-12-3456 Bob `
  * ` 555-231-3325 Carol `
  * ` 555-240-5678 Ted `
  * ` 555-290-6193 Alice `

  * ` $ cat directory `
  * ` 555-123-4567 Anytown `
  * ` 555-231-3325 Mytown `
  * ` 555-340-5678 Yourtown `
  * ` 555-290-6193 Youngstown `

The result of joining these two files is shown as the output of the following command:
  * ` $ join phonebook directory `
  * ` 555-123-4567 Bob Anytown `
  * ` 555-231-3325 Carol Mytown `
  * ` 555-340-5678 Ted Yourtown `
  * ` 555-290-6193 Alice Youngstown `

split is used to break up (or split) a file into equal-sized segments for easier viewing and manipulation, and is generally used only on relatively large files.
By default, split breaks up a file into 1,000-line segments.
The original file remains unchanged, and a set of new files with the same name plus an added prefix is created.
By default, the x prefix is added.
to split a file into segments, use the command ` $ split infle `.
To split a file into segments using a different prefix, use the command ` $ split infile <prefix> `

Regular expressions and text strings are used for matching a specific pattern or to search for a specific location such as the start or end of a line or word.
Regular expressions can contain both normal characters or so-called metacharacters such as * and $.
Many text editors and utilities such as vi, sed, awk, find, and grep work extensively with regular expressions.
Some of the popular computer languages that use regular expressions include Perl, Python, and Ruby.
It can get rather complicated and there are whole books written about regular expressions.
These regular expressions are different from the wildcards (or "metacharacters") used in filename matching in command shells such as bash.
The table below lists search patterns and their usage.

Search Patterns | Usage
- | -
` .(dot) ` | Match any single character
<code>a&#124;z</code> | Match a or z
` $ ` | Match end of string
` * ` | match preceding item 0 or more times.

For example, consider the expression the quick brown fox jumped over the lazy dog.
Some of the patterns that can be applied to this sentence are:

Command | Result
- | -
` a.. ` | matches azy
<code>b.&#124;j.</code> | matches br and ju
` ..$ ` | matches og
` l.* ` | matches lazy dog
` l.*y ` | matches lazy
` the.* ` | matches the whole sentence

### SECTION 4: GREP
___

grep is extensively used as a primary text searching tool.
It scans for specified patterns and can be used with regular expressions as well as simple strings as shown in the table below:
Command | Usage
- | -
` grep [pattern] <filename> ` | Search for a pattern in a file and print all matching lines.
` grep -v [pattern] <filename> ` | Print all lines that do not match the pattern.
` grep [0-9] <filename> ` | Print the lines that contain the numbers 0 through 9.
` grep -C 3 [pattern] <filename> ` | Print context of lines (specified number of lines above and below the pattern) for. matching the pattern. Here the number of lines is specified as 3.

### SECTION 5: MISCELLANEOOUS TEXT UTILITIES
___

In this section, we will learn about some additional text utilities that you can use for performing various actions on your Linux files, such as changing the case of letters or determining the count of words, lines, and characters in a file.
The tr utility is used to translate specified characters into other characters or to delete them.
The general syntax is ` $ tr [options] set1 [set2] `
The items in the square brackets are optional.
tr requires at least on argument and accepts a maximum of two.
The first, designated ` set1 ` in the example, lists the characters in the etext to be replaced ore moved.
The second, ` set2 `, lists the characters that are to be substituted for the characters listed in the first argument.
Sometimes these sets need to be surrounded by apostrophes (or single-quotes) in order to have the shell ignore that they means something special to the shell.
It is usually safe (and may be required) to use the single-quotes around each of the sets as you will see in the following example.
Suppose you have a file named ` city ` containing several lines of text in mixed case.
To translate all lower case characters to upper case, at the command prompt, type ` $ cat city | tr a-z A-Z `.
The following table lists additional flags you may specify.

Command | Usage
- | -
` $ tr abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLNOPQRSTUVWXYZ ` | Convert lower case to upper case.
` $ tr '{}' '()' < inputfile > outputfile ` | Translates braces into parenthesis.
<code>$ echo "This is for testing" &#124; tr [:space:] '\t'</code> | Translate white-space into tabs.
<code>$ echo "This     is    for    testing" &#124; tr -s [:space:]</code> | Squeeze repetition of characters using ` -s `.
<code>$ echo "the geek stuff" &#124; tr -d 't'</code> | Delete specified characters using the ` -d ` option.
<code>$ echo "my username is 432234" &#124; tr -cd [:digit:]</code> | Complements the sets using ` -c ` option.
` $ tr -cd [:print:] < file.txt ` | Remove all non-printable characters from a file.
` $ tr -s '\n' ' ' < file.txt ` | Join all the lines in a file into a single file.

tee takes the output from any command and, while sending it to standard output, also saves it to a file.
In other words, it "tees" the output stream from the command: one stream is displayed on the standard output and the other is saved to a file.
For example, to list the contents of a directory on the screen and save the output to a file, use ` $ ls -l | tee newfile `.
Typing ` $ cat newfile ` will then display the output of ` ls -l `.

wc (word counts) counts the number of lines, words, and characters in a file or list of files.
By default, all three of these options are active, but you can also toggle one or all of them manually.
For example, to print the number of lines contained in a file, use ` wc -l filename `.

Option | Description
- | -
` -l ` | Displays the number of lines
` -c ` | Displays the number of bytes
` -w ` | Displays the number of words

cut is used for manipulating column-based files and is designed to extract specific columns.
The default column separator is the tab character.
A different delimiter can be given as a command option.
For example, to display the third column delimited by a blank space, use ` ls -l | cut -d" " -f3 `.

### SECTION 6: DEALING WITH LARGE FILES AND TEXT RELATED UTILITIES
___

Sysadmins need to work with configuration files, text files, documentation files, and log files.
Some of these files may be large or become quite large as they accumulate data with time.
These files will require both viewing and administrative updating.
in this section, we will learn how to manage large files.
For example, a banking system might maintain one simple large log file to record details of all of one day's ATM transactions.
Due to a security attack or a malfunction, the administrator might be forced to check for some data by navigating within the file.
In such cases, directly opening the file in an editor will cause issues due to the huge memory utilization, as an editor will usually try to read the whole file into memory first.
However, one can use less to view the contents of such a large file, scrolling up and won page by page without the system having to place the entire file in memory before starting.
This is much faster than using a text editor.
Viewing the file can be done by uwing ` $ less <filename> ` or ` $ cat <filename> | less `.
By default, manual (the man command) pages are sent through the less command.

head reads the first few lines of each named file (10 by default) and displays it on standard output.
You can give a different number of lines as an option as well.
For example, if you want to print the first 5 lines from ` atmtrans.txt ` you would use ` $ head -n 5 atmtrans.txt `.
You can also just use ` head -5 atmtrans.txt `.

tail prints the last few lines of each named file and displays it on standard output.
By default it displays the last 10 lines.
Just as with head, you can give a different number of lines as an option.
tail is especially useful when you are troubleshooting any issue using log files as you probably want to see only the most recent lines of output.
For example, to display the last 15 lines of ` atmtrans.txt `, use the command ` $ tail -n 15 atmtrans.txt `.
You can also just say ` tail -15 atmtrans.txt `.
To continually monitor new output in a growing log file, use ` $ tail -f atmtrans.txt `.
This command will continuously display any new lines of output in atmtrans.txt as soon as they appear.
Thus it enables you to monitor any current activity that is being reported and recorded.

strings is used to extract all printable character strings found in a file or files given as arguments.
It is useful in locating human readable content embedded in binary files: for text files you can just use grep.
For example, to search for the string my_string in a spreadsheet, use ` $ strings book1.xls | grep my_string `.
When working with compressed files many standard commands can't be used directly. For many commonly-used file and text manipulation programs, there is also a version especially designed to work directly with compressed files.

When working with compressed files, many standard commands cannot be used directly.
For many commonly-used file and text manipulation programs, there is also a version especially designed to work directly with compressed files.
These associated utilities have the letter z prefixed to their name.
For example, we have utility programs such as zcat, zless, zdiff, and zgrep.
The following table lists some z family commands:

Command | Description
- | -
` $ zcat compressed-file.txt.gz ` | To view a compressed file.
` $ zless <filename.gz ` \n or \n ` $ zmore <filename>.gz ` | To page through a compressed file.
` $ zgrep -i less test-file.txt.gz ` | To search inside a compressed file.
` $ zdiff filename1.txt.gz filename2.txt.gz ` | To compare two compressed files.

Note that if you run zless on an uncompressed file, it will still work and ignore the decompression stage.
There are also equivalent utility programs for other compression methods besides gzip; i.e. we have bzcat and bzless associated with bazip2 and xzcat and xzless associated with xz.

### SUMMARY
___

  * The command line often allows the user to perform tasks more efficiently than the GUI.
  * cat, short for concatenate, is used to read, print, and combine files.
  * echo displays a line of text either on standard output or to place in a file.
  * sed is a popular stream editor often used to filter and perform substitutions on files and text data streams.
  * awk is an interpreted programming language typically used as a data extraction and reporting tool.
  * sort is used to sort text files and output stream in either ascending or descending order.
  * uniq eliminates duplicate entries in a text file.
  * paste combines fields from different files and can also extract and combine lines from multiple sources.
  * join combines lines from two files based on a common field. It works only if files share a common field.
  * split breaks up a large file into equal-sized segments.
  * Regular expressions are text strings used for pattern matching. The pattern can be used to search for a specific location, such as the start or end of a line or word.
  * grep searches text files and data streams for patterns and can be used with regular expressions.
  * tr translates characters, copies standard input to standard output, and handles special characters.
  * tee saves a copy of standard output to a file while still displaying it at the terminal.
  * wc (word count) displays the number of lines, words, and characters in a file or a group of files.
  * cut extracts columns from a file.
  * less views files a page at a time and allows scrolling in both directions.
  * head displays the first few lines of a file or data stream on standard output. By default it displays 10 lines.
  * tail displays the last few lines of a file or data stream or standard output. By default, it displays 10 lines.
  * strings extracts printable character strings from binary files.
  * The z command family is used to read and work with compressed files.
