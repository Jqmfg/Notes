# Chapter 10: Text Editors

### INTRODUCTION
___

By the end of this chapter, you should be familiar with:
  * How to create and edit files using the available Linux text editors
  * nano, a simple text-based editor
  * gedit, a simple graphical editor
  * vi and emacs, two advanced editors with both text-based and graphical interfaces

### SECTION 1: BASIC EDITORS NANO AND GEDIT
___

At some point, you will need to manually edit text files.
You might be:
  * Composing an email off-line
  * Writing a script to be used for bash or other command interpreters
  * Altering a system or application configuration file
  * Developing source code for a programming language such as ` C ` of ` Java `

Linux admins often sidestep text editors by using graphical utilities for modifying config files.
However, this is much more laborious than using a text editor.
Note that word processing applications such as Notepad or the applications that are part of office suites are not really basic text editors because they have a lot of extra formatting information.
This formatting information will render sysadmin config files unusable for their intended purpose.
Using true text editors is essential for Linux.
There are many choices when it comes to using text editors for Linux including:
  * nano
  * gedit
  * vi
  * emacs

In this section, we will cover nano and gedit.
Both of these editors are relatively simple and easy to learn.
Sometimes, you might want to create a short file and don't want to bother invoking a text editor.
in addition, doing so can be quite useful when used from within scripts, even when creating longer files.
You'll find yourself using this method when you start on the later chapters that cover bash scripting.

If you want to create a file without using an editor, there are two standard ways to do so from the command line and fill it with content.
The first is to use echo repeatedly:
  * ` $ echo line one > myfile `
  * ` $ echo line two >> myfile `
  * ` $ echo line three >> myfile `

The single ` > ` will send the output of a command to a file.
The double ` >> ` will append the output to an existing file.
The second way is to use cat combined with redirection:
  * ` $ cat << EOF > myfile `
  * ` > line one `
  * ` > line two `
  * ` > line three `
  * ` > EOF`

Both the above techniques will produce the same output file.
They can be extremely useful when employed by scripts.

There are some text editors that are extremely easy to use and obvious in how they work.
These don't take that much work to learn, but they aren't very robust.
One particularly easy one to use is the text-terminal based editor nano.
Just invoke nano by giving a file name as an argument.
All the help you need is displayed at the bottom of the screen.
As a graphical editor, gedit is part of the GNOME desktop system (kwrite is associated with KDE.)
The gedit and kwrite editors are also very easy to use and extremely capable.
They are also very configurable.
They will look a lot like Notepad in Windows.
Other variants such as kedit and kate are also supported by KDE.

nano is easy to use and requires very little effort to learn.
To open a file in nano, type ` $ nano <filename> ` and press ` ENTER `.
If the file doesn't exist, it will be created.
nano provides a two line "shortcut bar" at the bottom of the screen that lists the available commands.
Some of these commands include:
  * ` CTRL+G `: Display the help screen
  * ` CTRL+O `: Write to a file
  * ` CTRL+X `: Exit a file
  * ` CTRL+R `: Insert contents from another file to the current buffer
  * ` CTRL+C `: Cancels the previous commands

gedit is a simple to use graphical editor that can only be run within a graphical desktop environment.
It is visually similar to Notepad in Windows, but is far more capable and very configurable.
it also has a wealth of plugins available to further extend its capabilities.
To open a new file in gedit, find the program in your desktop's menu system, or from the command line type ` $ gedit <filename> `.
If the file doesn't exist, it will be created.
Using gedit is also very straightforward and doesn't require much training.
Its interface is composed of very familiar elements.

SECTION 2: MORE ADVANCED EDITORS VI AND EMACS
___

Developers and admins experienced with UNIX-like systems almost always use one of two venerable editors: vi and emacs.
Both are present or easily available on all distros and are have versions compatible with other OSes.
Both vi and emacs have a purely text-based form that can run in a non-GUI environment.
They also have one or more X-based graphical forms with extended capabilities.
The graphical forms can be friendlier for the less experienced user.
vi and emacs have a very steep learning curve, but they are extremely efficient once they are learned.
Note: there are often fights among users over which editor is best that are often described as a holy war.

First we will cover vi.
The actual program installed on your system usually isn't vi, it's vim which stands for vi improved.
This is still referred to as vi.
Even if you don't want to use vi, it is good to gain some familiarity with it.
vi is a standard tool that is installed on virtually all Linux distros.
There are many times when no other editor is available on the system.
GNOME extends vi with a very graphical interface known as gvim.
KDE offers kvim.
Either of these may be easier to use at first.
When using vi, all commands are entered through the keyboard.
This is because you don't want to keep moving your hands to use a pointer devices such as a mouse or touchpad.

Typing vimtutor launches a short but very comprehensive tutorial for those that want to learn their first vi commands.
The tutorial is a great place to start learning vi.
Even though it only provides an introduction and seven lessons, it has enough material to make someone a proficient vi user because it covers a large number of commands.
After learning the basic ones, you can look up new tricks to incorporate into your list of vi commands.
There are always more optimal ways to do things in vi with less typing.

Vi provides three modes as described in the table below.
it is vital not to lose track of which mode you are in.
Many keystrokes and commands behave differently in different modes.

Mode | Feature
- | -
Command | <ul><li> By default, vi starts in command mode</li><li> Each key is an editor command</li><li> Keybaord strokes are interpreted as commands that can modify file contents</li></ul>
Insert | <ul><li> Type ` i ` to switch to insert mode from command mode</li><li> Insert mode is used to enter (insert) text into a file</li><li> Insert mode is indicated by an ` ? INSERT ? ` indicator at the bottom of the screen</li><li> Press ` ESC ` to exit insert mode and return to command mode</li></ul>
Line | <ul><li> Type ` : ` to switch to the line mode from command mode</li><li> Each key is an external command, including operations such as writing the file contents to disk or exiting</li><li> vi uses line editing commands inherited from older line editors</li><li> Most of these commands are no longer used</li><li> Some line editing commands are very powerful</li><li> Press ` ESC ` to exit line mode and return to command mode</li></ul>

The table below describes the most important commands used to start, exit, read, and write files in vi.
The ` ENTER ` key needs to be pressed after all of these commands.

Command | Usage
- | -
` vi myfile ` | Start the vi editor and edit the myfile file
` vi -r myfile ` | Start vi and edit myfile in recovery mode from a system crash
` :r file2 ` | Read in file2 and insert at current position
` :w ` | Write to file (save)
` :w myfile ` | Write out the file to myfile
` :w! file2 ` | Overwrite file2
` :x ` or ` :wq ` | Exit vi and rite out modified file
` :q ` | Quit vi
` :q! ` | Quit vi even though modifications have not been saved

The table below describes the most important keystrokes used when changing cursor position in vi.
Line mode commands (those following colon) require the ` ENTER ` key to be pressed after the command is typed.

Key | Usage
- | -
arrow keys | To move up, down, left, and right
` j ` or ` <ret> ` | To move one line down
` k ` | To move one line up
` h ` or ` BACKSPACE ` | To move one character left
` l ` or ` SPACE ` | To move one character right
` 0 ` | To move to the beginning of the line
` $ ` | To move to the end of the line
` w ` | To move to the beginning of the next word
` :0 ` or ` 1G ` | To move to the beginning of the file
` :n ` or ` nG ` | To move to line n
` :$ ` or ` G ` | To move to the last line in the file
` CTRL+f ` or `PAGE DOWN ` | To move forward one page
` CTRL+b ` or `PAGE UP ` | To move backward one page
` ^l ` | To refresh and center the screen

The following table describes the most important commands when searching for text in vi.
The ` ENTER ` key should be pressed after typing the search pattern.

Command | Usage
- | -
` /pattern ` | Search forward for pattern
` ?pattern ` | Search backward for pattern

The following table describes the most important keystrokes used when searched for text in vi

Key | Usage
- | -
` n ` | Move to the next occurrence of the search pattern
` N ` | Move to the previous occurrence of the search pattern

The table below describes the most important keystrokes used when changing, adding, and deleting text vi.

Key | Usage
- | -
` a ` | Append text after cursor; stop upon ` ESCAPE ` key
` A ` | Append text at the end of the current line; stop upon ` ESCAPE ` key
` i ` | Insert text before the cursor: stop upon ` ESCAPE ` key
` I ` | Insert text at the beginning of the current line; stop upon ` ESCAPE ` key
` o ` | Start a new line below current text, insert text there; stop upon ` ESCAPE ` key
` O ` | Start a new line above the current line; insert text there; stop upon ` ESCAPE ` key
` r ` | Replace character at current position
` R ` | Replace text starting with current position; stop upon ` ESCAPE ` key
` x ` | Delete character at current position
` Nx ` | Delete N characters, starting at current position
` dw ` | Delete the word at the current position
` D ` | Delete the rest of the current line
` dd ` | Delete the current line
` Ndd ` or ` dNd ` | Delete N lines
` u ` | Undo the previous operation
` yy ` | Yank (copy) the current line and put it in the buffer
` Nyy ` or ` yNy ` | Yank N lines and put them in the buffer
` p ` | Paste at the current position the yanked lines or lines from the buffer

Typing ` :sh command ` opens an external command shell.
When you exit the shell, you will resume your vi editing session.
Typing ` :! ` executes a command from within vi.
The command follows the exclamation point.
This technique is best suited for non-interactive commands such as ` :! wc % `
Typing this will run the ` wc ` (word count) command on the file; the character ` % ` represents the file currently being edited.
The ` fmt ` command does simple formatting of text.
If you are editing a file and want the fie to look nice, you can run the file through ` fmt `.
One way to to do this while editing is by using ` : %!fmt, ` which runs the entire file (the ` % ` part) through fmt and replaces the file with the results.

Now we will go over emacs.
The emacs editor is a popular competitor for vi
Unlike vi, it does not work with modes.
emacs is highly customizable and includes a large number of features.
It was initially designed for the console, but a GUI version was soon released too.
emacs has many other capabilities other than text editing.
It can be used for email, debugging and many other things.
Rather than having different modes for command and insert, emacs uses the ` CTRL ` and meta (` ALT ` or ` ESC `) keys for special commands.
The following table lists some of the most important key combinations that are used when starting, exiting, reading, and writing files in emacs.

Key | Usage
- | -
` emacs myfile ` | Start emacs and edit myfile
` CTRLx i ` | Insert prompted for file at current position
` CTRL+x s ` | Save all files
` CTRL+x CTRL+w ` | Write to the file giving a new name when prompted
` CTLR+x CTRL+s ` | Saves the current file
` CTRL+x CTRL+c ` | Exit after being prompted to save any modified files

The emacs tutorial is a good place to start learning basic emacs commands.
It is available any time when in emacs by simply typing ` CTLR+h ` (for help) and then the letter ` t ` for tutorial.

The following table lists some of the keys and key combinations that are used for changing cursor position in emacs.

Key | Usage
- | -
arrow keys | Use the arrow keys for up, down, left, and right
` CTRL+n ` | One line down
` CTRL+p ` | One line up
` CTRL+f ` | One character forward/right
` CTRL+b ` | One character back/left
` CTRL+a ` | Move to the beginning of the line
` CTRL+e ` | Move to the end of the line
` CTRL+f ` | Move to the beginning of the next word
` CTRL+b ` | Move to the beginning of the preceding word
` META+> ` | Move to the end of the file
` CTRL+v ` or ` PAGE DOWN ` | Move forward one page
` META+v ` or ` PAGE UP ` | Move backward one page
` CTRL+l ` | Refresh and center screen

The following table lists key combinations that are used for searching text in emacs.

Key | Usage
- | -
` CTRL+s ` | Search forward for prompted pattern, or for next pattern
` CTRL+r ` | Search backward for prompted pattern, or for next pattern

The following table lists some of the key combinations used for changing, adding, and deleting text in emacs.

Key | Usage
- | -
` CTRL+o ` | Insert a blank line
` CTRL+d ` | Delete character at current position
` CTRL+k ` | Delete the rest of the current line
` CTRL+_ ` | Undo the previous command
` CTRL+SPACE ` or ` CTRL+@ ` | Mark the beginning of the selected region. The end will be at the cursor position
` CTRL+w ` | Delete the current marked text and write it to the buffer
` CTRL+y ` | Insert at the current cursor location whatever was most recently deleted

### SUMMARY
___

  * Text editors (rather than word processing programs) are used often in Linux for tasks such as creating or modifying system config files, writing scripts, developing source code, etc.
  * nano is an easy-to-use text-based editor that utilizes on-screen prompts
  * gedit is a graphical editor very similar to Notepad in Windows
  * The vi editor is available on all Linux systems and is very widely used
  * Graphical extension versions of vi are also widely available
  * emacs is available on all Linux systems as well as a popular alternative to vi
  * emacs can support both a GUI and a text mode interface
  * To access the vi tutorial, type vimtutor at the command line window
  * To access the emacs tutorial, type ` CTRL+h ` and then ` t ` from within emacs
  * vi has three modes: Command, Insert, and Line; emacs has only one, but requires use of special keys such as ` CTRL ` and ` ESC `
  * Both editors use various combinations of keystrokes t accomplish tasks
  * The learning curve to master these can be long, but once mastered, using either editor is extremely efficient
