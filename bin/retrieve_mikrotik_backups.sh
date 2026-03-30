#!/bin/bash -x
# Assumptions
#   * RouterOS 7+
#   * ssh-agent running and keys loaded
#   * mikrotik passwordless access setup
#   * Backup script running on mikrotik doing periodic backups (to be found in the `mikrotik` directory of this repository, upcoming)
#   * `dos2unix` available

base_dir="${HOME}/Documents/personal/sysadmin/mikrotik/files"
mkdir -p "${base_dir}"

# Check that the router is available
ping -W 0.3 -q -c 1 router-secondary.MY_DOMAIN > /dev/null || exit 1

# Load the user agent. See `one_liners.sh` for a CLI command to do just that
file="${HOME}/${USER}-agent";
[ -e "$file" ] || exit 1;
. $file
ps -p ${SSH_AGENT_PID} | grep -q -e ssh-agent || exit 1
ssh-add -l | grep -q -v -e 'has no identities' || exit 1

# Get files one by one. Set IFS in a sub-shell to only be newline
# `sed` must strip whitespace from the beginning and end when IFS is set, otherwise it's included in the name and it fails
(
    IFS=$'\n';
    for i in $(
        ssh mikrotik '/file/print proplist=name' \
        | dos2unix \
        | sed \
            -e '1,/^ # NAME/d' \
            -e '/^\s*$/d' \
            -e 's/^\s*[#0-9]\+ //' \
            -e 's/^\s\+//' \
            -e 's/\s\+$//'
    ); do
        [ -e "${base_dir}/$i" ] \
            ||  scp mikrotik:"$i"  "${base_dir}";
    done;
)
