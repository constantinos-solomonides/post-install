# post-install
This is the set of files and configurations used to bring a system to a working baseline. The system is **assumed** to
be a Xubuntu / Ubuntu server version >= `20.04.0`. The script can easily be adapted to other use cases, as most files
are simply `include`'d or `source`'d in. This can be expanded as needed

# Lists of files / directories
## `bin/` - Scripts for meta-use
Files under this directory are not meant to be copied in locations on the system. Their primary job is to move those
files in the appropriate locations and include them as appropriate.
    * `install.sh` -- Handles the installation of packages (1st step) and the subsequent deployment of everything
    * `uninstall.sh` -- Handles an "as-clean-as-possible" cleanup, removing inclusions and uninstalling packages
    * `make_iptables.sh` -- Generates a first set of **restrictive** `iptables` firewall rules and give samples of rules
       to use. MAY evolve into something that generates the rules by given a YaML file if needed

## `etc/`
Contains files that have to do with

* `vim`  - (Vim / neovim)
* `screen` - Custom `screenrc` file with extended functionalities
* `bash` - Extended `bashrc` files, used to extend the bash shell to a familiar style

Files will be split and formatted further. They are currently also usable "mostly as-is". Doing so costs slightly in
upfront effort, but it's a "once-per-system" cost, so has a slow repayment cost.

### Tasks to add to `/etc`
* `sudo` related file(s) and actions:
    * A mask and disable switch, to prevent misuse when running on systems with limited permissions
    * A set of passwordless disabling and enabling of specific commands.

### NOTES
* `sudo`-related actions will be something to copy-paste using the `visudo` command. This is to prevent issues with
    misconfiguration blocking `sudo` access.

## `packages/` / `install_packages.sh`

**Eventual vision:**

Distro-specific *metapackages* that have as dependencies all packages needed to bring the system to a baseline state. By
installing them, the system will be up to date with all the necessary packages

**Initial format:**

`install_packages.sh`, a shell script that calls the available package manager to install the expected dependencies


# Developer / expansion details

* TBC

# Reasoning for design decisions
The configuration of a new system happens rarely and thus a `copy-paste` approach works decently. However, by automating
the process, changes can be centralized to a single repository and uniformity. Care must be taken that the deployment
process be idempotent, to ensure that updates of the package and redeployments are easy to do. There's however *some*
need to justify functionality introduced

## Automatically starting `screen` in new session
Doing so ensures that, especially for machines that are used remotely (via SSH), tasks are not interrupted. This changes
in special cases, when a machine is used as a standard connection hub, towards which connections are meant to take on
previous work and continue with it. There are several advantages:

* Network failures won't cause connections to fail
* Work in `vim` or other tools can continue across multiple connects seamlessly
* Long-running processes don't trap me to keep a connection open
* Long-distance network doesn't become a bottleneck in the completion of long tasks

There will be a change after the initial addition, to introduce the capability of reconnecting / creating a default
screen session. The mechanism to disconnect without being logged-out is already in place, to allow switching. A possible
"two-for-one" capability to add may be a way to switch the default session name, to continue the same task across
reconnects and even restarts.

## Use of `TMOUT` by default in new sessions
In case connection is interrupted, kill any ephemeral `screen` sessions after a while. This is a safeguard for screen
sessions that are left hanging after a disconnect.
