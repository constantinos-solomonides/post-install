# post-install
This is the set of files and configurations used to bring a system to a working baseline. The system is
**assumed** to be a Xubuntu / Ubuntu server version >= `20.04.0`. The script can easily be adapted to other
use cases, as most files are simply `include`'d or `source`'d in. This can be expanded as needed

**NOTE** This repository is primarily meant to allow **me** to deploy my config on other systems. I'm making
it public mostly because it can be useful to like-minded friends and because someone may end-up drawing ideas
from the way I've done things. It's **not** meant to be general purpose, useful to many (or anyone other than
me for that matter) or complicated. I expect however that it can be easily adapted by others in some cases.

For example, the way `screen` is made to run automatically upon login on a remote system, reattach can be made
possible and timeouts can happen has been invaluable to me in settings where I use a single, central VM to do
all my work and orchestration from, to which I can arbitrarily disconnect and re-connect from anywhere, having
a workflow that's completely independent to the location from which I'm working.

# TODOs

* [x] Include all configuration files that are modified upon running a new system
* [x] Extract common, custom-set configuration
* [x] Extract added configuration
* [x] Update README (this document) with status up to current point (v0.1.3)
* [] Create script(s) to copy the files in (an) appropriate location(s) in the filesystem
* [] Create / expand scripts to include in / overwrite the default configuration file


# Lists of files / directories
```
.
+-- bin
|   +-- popup_thunar.sh
|   +-- retrieve_mikrotik_backups.sh
|   +-- set_workspace_background.sh
|   +-- toggle_mousekeys.sh
+-- etc
|   +-- bash.bashrc.local
|   +-- bash.bashrc.local.d
|   |   +-- 000.setup
|   |   +-- 010.functions
|   |   +-- 012.variables_configuration
|   |   +-- 013.variables_PS
|   |   +-- 050.start_terminals_in_screen
|   |   +-- 051.set_cli_name_in_screen
|   |   +-- by-uid
|   |       +-- 0
|   |           +-- 000.extended-motd
|   +-- inputrc
|   +-- screenrc.custom
|   +-- vim
|       +-- gvimrc
|       +-- vimrc
|       +-- vimrc.external_defaults
|       +-- vimrc.personal
+-- examples
|   +-- test_vim_colours.vim
|   +-- text_example.viewcolours
|   +-- triangle_area_BASE.py
|   +-- triangle_area_LOCAL.py
|   +-- triangle_area.py
|   +-- triangle_area_REMOTE.py
|   +-- vimdiff1.base
|   +-- vimdiff1.merged
|   +-- vimdiff1.orig
|   +-- vimdiff1.remote
+-- gitconfig
+-- LICENSE
+-- one_liners.sh
+-- README.md
+-- usr
    +-- share
        +-- nvim
        |   +-- sysinit.vim
        +-- vim
            +-- common
                +-- colors
                    +-- legible_dark-256.vim
                    +-- vimcolourstest.vim
```

## `./`
The project base directory contains _mostly_ files that have to do with the repository itself, as well as
files that act more as note than as functional scripts. In that latter vein, `gitconfig` and `one_liners.sh`
aren't meant to be used directly, but mostly to draw inspiration / ideas from.

Commands may be copy-pasted from them, but there's zero warranties on the behavior those commands may end-up
having

## `./bin/`
In here custom scripts & wrappers that have consistently been useful to me are stored. They may not always
stand alone, but require / assume the installation of certain packages or that there is a partner script that
prepares some other content, such as the `retrieve_mikrotik_backups.sh` script that expects it. Not all of
those scripts are to be made public.

`toggle_mousekeys.sh` may also be useful to someone, as it resolves the issue with working from the laptop
keyboard when the touchpad is a bit too trigger happy, despite the setting to deactivate it while typing

## `./etc/`
There are three categories of files under `.etc`:

* General configuration files (`inputrc`, `screenrc.custom`)
* `vim` configuration files
* `bash` setup files

In essence, all of these files however are configured to setup my environment so that upon login I can find
myself in a familiar environment

Some files that are of special interest are:

* `000.variables_PS`
    * How `PROMPT_COMMAND` is hijacked to create a centralized log for commands executed in all sessions
      running
    * How `PS` is made into a source of information that can be used to debug and trace issues
* `050.start_terminals_in_screen`
    * Handles starting a screen session by default when logging in to a system, ensuring that:
        * It's re-attaching to the default one if detached from
        * The session terminates if the screen session is detached-from
        * There are ways to keep the session running and not starting a screen sessions if desired

## `./examples/`
Contains files that were used (so far) to nail down the details of the VIM colorscheme that is meant to be as
easy to read as possible. Does **not** contain code snippets testing concepts, that's a whole other repository
(unpublished as of today, 2026-05-18). The files within help with syntax highlighting but also with the
highlighting of three-way diff, as seen when running the `git mergetool` command for example

## `./usr/`
Contains

* Files for the configuration of `nvim`
* `legible` colorscheme, 256 colors, dark syntax highlight
* "syntax" and "colorscheme" files to allow visualizing the mapping of the 256 numbers to colors colors

# Developer / expansion details

NONE PROVIDED OTHER THAN COMMENTS WHERE PRESENT

Most of the scripts in this repository are meant to help **me** setup a new system. This can be when buying a
new system, when deploying a VM or more often than not, when getting a new work laptop / work VM to use. As
such, the code is not as clear as I would normally deploy, nor are as many corner cases handled.

It however can be useful as a source of inspiration to others who enjoy using `vim` and `screen` and who
manage multiple remote systems, trying for an as seamless experience as possible. This is very much an "as-is"
offering, with all cleanup taking place because I'm trying to re-organize my work prior to posting for
presentation reasons, rather than versatility in deployment.

# Reasoning for design decisions
The configuration of a new system happens rarely and thus a `copy-paste` approach works decently. However, it
creates the issue of diverging configuration or with the need to re-invent the wheel on desirable
functionality. By centralizing the deployment, continuity and uniformity is assured.

# Potentially useful functionalities

This discussion elaborates more on what interesting functionalities were witnessed and why they deserve a
second look from someone who manages multiple \*NIX systems remotely. There may be some adaptations needed if
a shell other than `bash` (or one not sufficiently updated), however the reasoning works well enough and has
been tested with OS-X and termux on android

## Automatically starting `screen` in new session
Doing so ensures that, especially for machines that are used remotely (via SSH), tasks are not interrupted.
This changes in special cases, when a machine is used as a standard connection hub, towards which connections
are meant to take on previous work and continue with it. There are several advantages:

* Network failures won't cause connections to fail
* Work in `vim` or other tools can continue across multiple connects seamlessly
* Long-running processes don't trap me to keep a connection open
* Long-distance network doesn't become a bottleneck in the completion of long tasks

There will be a change after the initial addition, to introduce the capability of reconnecting / creating a
default screen session. The mechanism to disconnect without being logged-out is already in place, to allow
switching. To do so, one needs only create the file `${HOME}/no_screen` or `/tmp/no_screen` A possible
"two-for-one" capability to add may be a way to switch the default session name, to continue the same task
across reconnects and even restarts. Note that creating the file will prevent the session from terminating
upon screen disconnect and will also prevent a new session from starting.

As the file gets deleted after it's used, to disconnect a screen session and have screen not start upon next
connect, the order is
`create file` -> `disconnect screen` -> `create file` -> `disconnect from SSH / terminal session`

## Use of `TMOUT` by default in new sessions
In case connection is interrupted, log-out of any ephemeral `screen` sessions after a while. This is a
safeguard for screen sessions that are left hanging after a disconnect or when logging in to one of the system
virtual terminals for any reason, without needing to go back in to explicitly log them out. This will **NOT**
work if there's any program started that waits for input in said session, as `TMOUT` has to do with idle bash
sessions.

## `PS1` format and `PROMPT_COMMAND` hijacking

**NOTE**: I'm aware of the existence of plugins that are way more informative and "good looking" than what I'm
doing here. I find them a bit too much for my tastes, as I want all characters to be ASCII (besides coloring)
and paths / dates to be usable and parseable

### `PS1`
`PS1` defines the command prompt. If one uses a single system in a single session, then the format is too
much, and is overloaded with information that's not needed. For a workflow that relies on connecting to
multiple systems using `screen` on top however, most of the information can be really useful. Additionally, in
`012.variables_configuration`, different colors are defined, making the prompt coloring helpful in identifying
the type of system one's logged into.

The prompt provides information on:

* The full hostname
* The date and time (can help identify how long it took for the previous command to be executed)
* The full current path (home is represented as `~` however)
* The active user (includes `@<short_host>` to highlight what it is
* The screen escape sequence (works only in synergy with the screen rc file) or `N/A` if not in a screen
  session
* The string `=====> <user_prompt> `, colored yellow if `TMOUT` is set, white if not

### `PROMPT_COMMAND`
`PROMPT_COMMAND` is hijacked to ensure some actions are undertaken after every time a command is run in the
interactive session. These actions are:

* Set the terminal title as per the value of `TERM_TITLE` or a default if not set
* Save each command executed upon completion into a file named `~/.bash_history.log`

The second functionality allows each command to be stored sequentially as executed, and not when each session
disconnects. This also allows reusing commands across various screen windows without having to issue
`history -w` / `history -r` explicitly to retrieve them.
