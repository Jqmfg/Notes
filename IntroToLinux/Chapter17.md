# Chapter 17: Processes

### INTRODUCTION
___

By the end of this chapter, you should be able to:
  * Describe what a process is and distinguish between types of processes.
  * Enumerate process attributes
  * Manage processes using ps and top
  * Understand the use of load averages and other process metrics
  * Manipulate processes by putting them in background and restoring them to foreground
  * Use at, cron, and sleep to schedule processes for the future or pause them.

### SECTION 1: INTRODUCTION TO PROCESSES AND PROCESS ATTRIBUTES
___

A process is simply an instance of one or more related tasks (threads) executing on your computer.
It is not the same as a program or a command; a single program may actually start several processes simultaneously.
Some processes are independent of each other and others are related.
A failure of one process may or may not affect the others running on the system.
Processes use many system resources such as memory, CPU cycles, and peripheral devices such as printers and displays.
The operating system (especially the kernel) is responsible for allocating a proper share of these resources to each process and ensuring overall optimum utilization.

A terminal window (one kind of command shell) is a process that runs as long as needed.
It allows users to execute programs and access resources in an interactive environment.
You can also run programs in the background which means they become detached from the shell.
Processes can be different types according to the task being performed.
The following table lists some different process types along with their descriptions and examples.

Process Type | Description | Example
- | - | -
Interactive Processes | Need to be started by a user, either at a command line or through a graphical interface such as an icon or a menu selection. | bash firefox, top
Batch processes | Automatic processes which are scheduled from and then disconnected from the terminal. These tasks are queued and work on a FIFO (first in first out) basis. | updatedb
Daemons | Server processes that run continuously. Many are launched during system startup and then wait for a user or system request indicating that their service is required. | httpd, xinetd, sshd
Threads | Lightweight processes. These are tasks that run under the umbrella of a main process, sharing memory and other resources, but are scheduled and run by the system on an individual basis. An individual thread can end without terminating the whole process and a process can create new threads at any time. Many non-trivial programs are multi-threaded. | gnome-terminal, firefox
Kernel Threads | Kernel tasks that users neither start nor terminate and have little control over. These may perform actions like moving a thread from one CPU to another or making sure input/output operations to the disk are completed | kswapd0, migration, ksoftirqd

When a process is in a so-called running state, it means that it is either currently executing instructions on a CPU or is waiting for a share (or time slice) so it can run.
A critical kernel routing called the scheduler constantly shifts processes in and out of the CPU sharing time according to relative priority, how much time is needed, and how much has already been granted to a task.
All processes in this state reside on what is called a run queue and on a computer with multiple CPUs or cores, there is a run queue for each.
However, sometimes processes go into what is called a sleep state, generally when they are waiting for something to happen before they can resume, perhaps for the user to type something.
In this condition, a process is sitting in the wait queue.
There are some other less frequent process states, especially when a process is terminating.
Sometime, a child process completes but its parent process has not asked about its state.
Such a processes is said to be in a zombie state; it is not really alive, but still shows up in the system's list of processes.

At any given time, there are always multiple processes being executed.
The operating system keeps track of them by assigning each a unique process ID (PID) number.
The PID is used to track process state, CPU usage, memory use, precisely where resources are located in memory, and other characteristics.
New PIDs are usually assigned in ascending order as processes are born.
PID 1 denotes the init process (initialization process) and succeeding processes are gradually assigned higher numbers.
The table below explains the PID types and their descriptions.

ID Type | Description
- | -
Process ID (PID) | Unique Process ID number.
Parent Process ID (PPID) | Process (Parent) that started this process.
Thread ID (TID) | Thread ID number. This is the same as the PID for a single-threaded process. For a multi-threaded process, each thread shares the same PID but has a unique TID.

Many users can access a system simultaneously and each user can run multiple processes.
The operating system identifies the user who starts the process by the Real User ID (RUID) assigned to the user.
The user who determines the access rights for the users is identified by the Effective UID (EUID).
The EUID may or may not be the same as the RUID.
Users can be categorized into various groups.
Each group is identified by the Real Group ID (RGID).
The access rights of the group are determined by the Effective Group ID (EGID).
Each user can be a member of one or more groups.
Most of the time, we will just talk about the UID.

At any given time, many processes are running (i.e. in the run queue) on the system.
However, a CPU can actually accommodate only one task at a time.
Some processes are more important than others so Linux allows you to set and manipulate process priority.
Higher priority processes are granted more time on the CPU.
The priority for a process can be set by specifying a nice value or niceness for the processes.
The lower the nice value, the higher the priority.
Low values are assigned to important processes while high values are assigned to processes that can wait longer.
A process with a high nice value simply allows other processes to be executed first.
In Linux, a nice value of -20 represents the highest priority and 19 represents the lowest.
(This sounds backwards, but this convention goes back to the earliest days of UNIX.)
You can also assign a so-called real-time priority to time-sensitive tasks such as controlling machines through a computer or collecting incoming data.
This is just a very high priority and is not to be confused with what is called hard real time which is conceptually different and has more to do with making sure a job gets completed within a very well-defined time window.

### SECTION 2: LISTING PROCESSES
___

ps provides information about currently running processes keyed by PID.
If you want a repetitive update of this status, you can use top or commonly installed variants such as htop or atop from th command line, or you can invoke your distro's graphical system monitor application.
ps has many options for specifying exactly which tasks to examine, what information to display about them, and precisely what output format should be used.
Without options, ps will display all processes running under the current shell.
you can use the ` -u ` option to display information of processes for a specified username.
The command ` ps -ef ` displays all the processes in the system in full detail.
The command ` ps -eLf ` goes one step further and displays one line of information for every thread (remember that every process can contain multiple threads.)

ps has another style of option specification which stems from the BSD variety of UNIX where options are specified without preceding dashes.
For example, the command ` ps aux ` displays all processes of all users.
The command ` ps axo ` allows you tot specify with attributes you want to view.
The following is sample output of ps with the aux qualifier:
```bash
$ ps aux
USER PID %CPU %MEM VSZ   RSS  TTY STAT START TIME COMMAND
root 1   0.0  0.0  19356 1292 ?   Ss   Feb27 0:08 /sbin/init
root 2   0.0  0.0  0     0    ?   S    Feb27 0:00 [kthreadd]
root 3   0.0  0.0  0     0    ?   S    Feb27 0:27 [migration/0]
```
The following is sample output of ps with the axo qualifier:
```bash
$ ps axo, stat,priority,pid,pcpu,comm
STAT PRI PID %CPU COMMAND
Ss   20  1   0.0  init
S    20  2   0.0  kthreadd
S   -100 3   0.0  migration/0
```

At some point, one of your applications may stop working properly.
pstree displays the processes running on the system in the form of a tree diagram showing the relationship between a process and its parent process and any other processes that it created.
Repeated entries of a process are not displayed, and threads are displayed in curly braces.
To terminate a process you can use ` $ kill -SIGKILL <pid> ` or ` kill -9 <pid> `.
Note that you can only kill your own processes: those belonging to another user are off limits unless you are root.

While a static view of what the system is doing is useful, monitoring the system performance live over time is also valuable.
One option would be to run ps at regular intervals.
A better alternative is to use the top command to get constant real-time updates (every 2 seconds by default) until you exit by typing 'q'.
top clearly highlights which processes are consuming the most CPU cycles and memory (using appropriate commands from within top.)

The first line of the top output displays a quick summary of what is happening in the system including:
  * How long the system has been up
  * How many users are logged in
  * What the load average is

The load average determines how busy the system is.
A full load average of 1.00 per CPU indicates a fully subscribed, but not overloaded, system.
If the load average goes above this value, it indicates that processes are competing for CPU time.
If the load average is very high, it might indicate that the system is having a problem, such as a runaway process (a process in a non-responding state.)

The second line of the top output displays the total number of processes, the number of running, sleeping, stopped, and zombie processes.
Comparing the number of running processes with the load average helps determine if the system has reached its capacity or perhaps a particular user is running too many processes.
The stopped processes should be examined to see if everything is running correctly.

The third line of output indicates how the CPU time is being divided between the users (us) and the kernel (sy) by displaying the percentage of CPU time used for each.
The percentage of user jobs running at a lower priority (niceness -ni) is then listed.
Idle mode (id) should be low if the load average is high, and vice versa.
The percentage of jobs waiting (wa) for I/O is listed.
Interrupts include the percentage of hardware (hi) vs software (si) interrupts.
Steal time (st) is generally used with virtual machines, which has some of its idle CPU time taken for other uses.
The fourth and fifth lines of the top output indicate memory usage which is divided into two categories:
  * Physical memory (RAM) - displayed on line 4.
  * Swap space - displayed on line 5.

Both categories display total memory, used memory, and free space.
You need to monitor memory usage very carefully to ensure good system performance.
Once the physical memory is exhausted, the system starts using swap space (temporary storage space on the hard drive) as an extended memory pool, and since accessing disk is much slower than accessing memory, this will negatively affect system performance.
If the system starts using swap often, you can add more swap space.
However, adding more physical memory should also be considered.

Each line in the process list of the top output displays information about a process.
By default, processes are ordered by highest CPU usage.
The following information about each process is displayed:
  * Process Identification Number (PID)
  * Process owner (USER)
  * Priority (PR) and nice values (NI)
  * Virtual (VIRT), physical (RES), and shared memory (SHR)
  * Status (S)
  * Percentage of CPU (%CPU) and memory (%MEM) used
  * Execution time (TIME+)
  * Command (COMMAND)

Besides reporting information, top can be utilized interactively for monitoring and controlling processes.
While top is running in a terminal window, you can enter single-letter commands to change its behaviour.
For example, you can view the top-ranked processes based on CPU or memory usage.
If needed, you can alter the priorities of running processes or you can stop/kill a process.
The following table lists what happens when pressing various keys when running top:

Command | output
- | -
` t ` | Display or hide information (rows 2 and 3)
` m ` | Display or hide memory information (rows 4 and 5)
` A ` | Sort the process list by top resource consumers
` r ` | Renice (change the priority of) a specific process
` k ` | Kill a specific process
` f ` | Enter the top configuration screen
` o ` | Interactively select a new sort order in the process list

### SECTION 3: PROCESS METRICS AND PROCESS CONTROL
___

Load average is the average of the load number for a given period of time.
It takes into account processes that are:
  * Actively running on a CPU.
  * Considered runnable, but waiting for a CPU to become available.
  * Sleeping: i.e. waiting for some kind of resource (typically I/O) to become available.

The load average can obtained by running w, top, or uptime.

The load average is displayed using three sets of numbers.
The last piece of information is the average load of the system.
Assuming our system is a single-CPU, the 0.25 means that for the past minute, on average, the system has been 25% utilized.
0.12 in the next position means that over the past 5 minutes, on average, the system has been 12% utilized.
0.15 in the final position means that over the past 15 minutes, on average, the system has been 15% utilized.
If we saw a value of 1.00 in the second position, that would imply that the single-CPU system was 100% utilized, on average, over the past 5 minutes; this is good if want to fully use a system.
A value over 1.00 for a single-CPU system implies that the system was over-utilized: there were more processes needing CPU than CPU was available.
If we had more than one CPU, say a quad-CPU system, we would divide the load average numbers by the number of CPUs.
In this case, for example, seeing a 1 minute load average of 4.00 implies that the whole system was 100% (4.00/4) utilized during the last minute.
Short term increases are not usually a problem.
A high peak you see is likely a burst of activity, not a new level.
For example, at start up, many processes start and then activity settles down.
If a high peak is seen in the 5 and 15 minute load averages, it may be cause for concern.

Linux supports background and foreground job processing.
A job in this context is just a command launched from a terminal window.
Foreground jobs run directly from the shell, and when one foreground job is running, other jobs need to wait for shell access (at least in that terminal window if using a GUI) until it is completed.
This is fine when jobs complete quickly, but this can have an adverse effect if the current job is going to take a long time (even several hours) to complete.

In such cases, you can run the job in the background and free the shell for other tasks.
The background job will be executed at lower priority which, in turn, will allow smooth execution of the interactive task and allow you to type other commands in the terminal window while the background job is running.
By default, all jobs are executed in the foreground.
You can put a job in the background by suffixing ` & ` to the command like ` $ updatedb & `.
You can either use ` CTRL+Z ` to suspend a foreground job, or ` CTRL+C ` to terminate a foreground job, and you can always use the bg and fg commands to run a process in the background and foreground respectively.

The jobs utility displays all jobs running in the background.
The display shows the job ID, state, and command name as shown in the following:
```bash
$ jobs
[1]- Stopped      sleep 100
[2]+ Stopped      sleep 100
$ jobs -l
[1]- 23375 Stopped      sleep 100
[2]+ 23392 Stopped      sleep 100
```
` jobs -l ` provides the same information as ` jobs ` but also includes the PID of the background jobs.
The background jobs are connected to the terminal window, so if you log off, the jobs utility will not show the ones started from the window.

SECTION 4: STARTING PROCESSES IN THE FUTURE
___

Suppose you need to perform a task on a specific day sometime in the future but you know you will be away from the machine that day.
You can use the at utility program to execute any non-interactive command at a specified time as evidenced in the following example:
```bash
$ at now + 2 days     #Specifies when the task needs to be performed: after 2 days from now
at> cat file1.txt     #This command specifies the task to be performed
at> <EOT>             #CTRL+D here
job3 at 2014-07-12 11:58
```

cron is a time-based scheduling utility program.
It can launch routine background jobs at specific times and/or days on an on-going basis.
cron is driven by a configuration file called ` /etc/crontab ` (cron table) which contains the various shell commands that need to be run at the properly scheduled times.
There are both system-wide crontab files and individual user-based ones.
Each line of a crontab file represents a job and is composed of a so-called CRON expression followed by a shell command to execute.
The crontab -e command will open the crontab editor to edit existing jobs or to create new jobs.
Each line of the crontab file will contain 6 fields as detailed in the following table:

Field | Description | Values
- | - | -
MIN | Minutes | 0 to 59
HOUR | Hours | 0 to 23
DOM | Day of Month | 1 to 31
MON | Month | 1 to 12
DOW | Days of Week | 0 to 6 (6 is Sunday)
CMD | Command | Any command to be executed

Examples:
  * The entry "" * * * * * /usr/local/bin/execute/this/script.sh " will schedule a job to execute "script.sh" every minutes of every hour of every day of the month, and every month and every day of the week.
  * The entry "30 08 10 06 * /home/sysadmin/full-backup" will schedule a full-backup at 8:30AM on the 10th of June irrespective of the day of the week.

Sometimes a command or job must be delayed or suspended.
Suppose an application has read and processed the contents of a data file and then needs to save a report on a backup system.
If the backup system is currently busy or not available, the application can be made to sleep (wait) until it can complete its work.
Such a light delay might be to mount the backup device and prepare it for writing.
sleep suspends execution for at least the specified period of time which can be given as the number of seconds (default), minutes, hours, or days.
After that time has passed (or an interrupting signal has bee received) execution will resume.
The syntax is ` sleep NUMBER[SUFFIX] . . . ` where SUFFIX may be:
  * ` s ` for seconds (default)
  * ` m ` for minutes
  * ` h ` for hours
  * ` d ` for days

sleep and at very different; sleep delays execution for a specific period while at starts execution at a later time.

### SUMMARY
___

  * Processes are used to perform various tasks on the system.
  * Processes can be single-threaded or multi-threaded.
  * Processes can be of different types such as interactive and non-interactive.
  * Every process has a unique identifier (PID) to enable the operating system to keep track of it.
  * The nice value or niceness can be used to set priority.
  * ps provides information about the currently running processes.
  * You can use top to get constant real-time updates about overall system performance as well as information about the processes running on the system.
  * Load average indicates the amount of utilization the system is under at particular times.
  * Linux supports background and foreground processing for a job.
  * at executes any non-interactive command at a specified time.
  * cron is used to schedule tasks that need to be performed at regular intervals.
