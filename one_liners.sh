#!/bin/false
# Do **not** run this file, use as reference
# This file stores in a "deconstructed" format one-liners, with explanation of their sections
# NOTE: The weird alignment is to allow explanation while showing blocks. Each section should be one long line. Merge
# and convert all double spaces to single, then run from CLI

# Configure a secondary `gh` location, in case you have more than one github accounts (e.g. work / personal)
# Explanation:
# : <> ; -> Sets a title that's useful with history search. `:` starts a special type of comment
# * Set a location other than actual HOME to act as HOME **for the execution**.
#       Since `gh` has no formally supported way to ingest specific config, giving it a fake `HOME` to work from
#       resolves that
# * Create the folder with `-p` to avoid issues if it's present
# * Define `gh` to be an alias for `HOME=${NEWHOME}
# * Verify an ssh-agent to store key for secondary account is already running
#   * Try with existing file
#       * Define `file` to be **a** location an ssh-agent instance details are stored
#       * IF the file exists source it
#       * IF the process in the file exists and is an ssh-agent continue
#   * OR start an new instance of an ssh agent
#       * Launch ssh-agent and redirect its output to `$file`
#       * Source `$file` so that information becomes accessible
#   * AND make sure that there is an identity OR add it
# ---
# * Check if running in `screen`
#   * Starting from the **current** process ID
#   * Set flag to `no`
#   * For a maximum of twenty (20) iterations [number is arbitrary, high enough that it's unlikely it'd be more nested]
#     * Check if pid is 1, break if so
#     * Check if process with given pid is a `screen` instance
#       * IF yes, set flag to `yes` and break
#       * IF no, set pid value to PID of parent process
#   * Compare value of flag to `yes`
# * AND If the previous step succeeded (flag was `yes`)
#   * Set SSH_AUTH_SOCK environment for the screen session to the current SSH_AUTH_SOCK (secondary agent)
: gh2-agent;
DUMMYHOME=${HOME}/.gh2;
mkdir -p ${DUMMYHOME};
alias gh="HOME=${DUMMYHOME} $(type -P gh)";
file="${DUMMYHOME}/agent";
    {
            { [ -e "${file}" ] && . "${file}"; }
        &&  { ps -p "${SSH_AGENT_PID}" | grep -q -e ssh-agent; };
} || {
        ssh-agent > "${file}"
    &&  chmod go-rwx "${file}"
    &&  .  "${file}";
} && {
    ssh-add -l | grep -q -v -e 'has no identities' || ssh-add ~/.ssh/keys/.phome2;
} ; {
    pid=$$;
    screen=no;
    for i in {1..20}; do
        if (("${pid}"==1)); then
            break;
        fi;
        if (ps -h -p "${pid}" -o cmd | grep -q -ie screen); then
            screen=yes;
            break;
        fi;
        pid=$(ps -h -p "${pid}" -o ppid);
    done;
    [ "${screen}" == "yes" ];
} && {
        screen -X setenv SSH_AUTH_SOCK "${SSH_AUTH_SOCK}";
}

# Stop time-based auto-logout, and load an ssh-agent with default keys
#   This is useful for a home lab that uses ssh keys systematically and frequently
# unset TMOUT. Stops logout from happening after a given time. See README for motive of TMOUT use
# NOTE this matches work done for GH above. Copy-pasting for this reason
# * Verify an ssh-agent to store key for secondary account is already running
#   * Try with existing file
#       * Define `file` to be **a** location an ssh-agent instance details are stored
#       * IF the file exists source it
#       * IF the process in the file exists and is an ssh-agent continue
#   * OR start an new instance of an ssh agent
#       * Launch ssh-agent and redirect its output to `$file`
#       * Source `$file` so that information becomes accessible
#   * AND make sure that there is an identity OR add it
# ---
# * Check if running in `screen`
#   * Starting from the **current** process ID
#   * Set flag to `no`
#   * For a maximum of twenty (20) iterations [number is arbitrary, high enough that it's unlikely it'd be more nested]
#     * Check if pid is 1, break if so
#     * Check if process with given pid is a `screen` instance
#       * IF yes, set flag to `yes` and break
#       * IF no, set pid value to PID of parent process
#   * Compare value of flag to `yes`
# * AND If the previous step succeeded (flag was `yes`)
#   * Set SSH_AUTH_SOCK environment for the screen session to the current SSH_AUTH_SOCK (secondary agent)
#   * Unset TMOUT for the parent environment and thus all windows in this screen session
unset TMOUT;
file="${HOME}/${USER}-agent";
{
    {
        [ -e "${file}" ] && . "${file}";
    } && {
        ps -p "${SSH_AGENT_PID}" | grep -q -e ssh-agent;
    };
} || {
    ssh-agent > "${file}" && chmod go-rwx "${file}" && .  "${file}";
} && {
    ssh-add -l | grep -q -v -e 'has no identities' || ssh-add ~/.ssh/keys/p*;
} ; {
    pid=$$;
    screen=no;
    for i in {1..20}; do
        if (("${pid}"==1)); then
            break;
        fi;
        if (ps -h -p "${pid}" -o cmd | grep -q -ie screen); then
            screen=yes;
            break;
        fi;
        pid=$(ps -h -p "${pid}" -o ppid);
    done;
    [ "${screen}" == "yes" ];
} && {
    screen -X setenv SSH_AUTH_SOCK "${SSH_AUTH_SOCK}";
    screen -X setenv TMOUT "";
}

# Add git `anonymize` filter
# The first part is not given, as it will be anonymized by the repo if so. Use meaningful values for each one
# E.g.
#   * A phone_number pattern could be, written symbolically, <plus_sign>?[<digits><whitespace>]*
#   * An e-mail patter could be <not_whitespace><backslash><plus_sign><at><not_whitespace><backslash><plus_sign>
#   * ...

# Convert the git filters into base64 to prevent confusion upon merge. By running the `cat` command, one gets the
# original command to run, by replacing the values.
# As this will actually be stored verbatim into the repository, the actual identifying information needed to be removed
base64 -d - <<END
UEhPTkVfTlVNQkVSPSIiCkVNQUlMPSIiCkhBTkRMRV8xPSIiCkhBTkRMRV8yPSIiCkZVTExfSEFO
RExFPSIiCkRPTUFJTj0iIgoKRU1BSUxfUEFUVEVSTj0iW2EtekEtWjAtOV8rLi1dXCtAXHdcK1wu
XChjb1x8bmV0XClcKFx3XHxcLlwpKiIKUEhPTkVfUEFUVEVSTj0iK1swLTkuICgpXVwrWzAtOV0i
CgpnaXQgY29uZmlnIC0tZ2xvYmFsIGZpbHRlci5hbm9ueW1pemUuc211ZGdlIFwKICAgICdzZWQg
XAogICAgICAgIC1lICJzL1BIT05FX05VTUJFUi8nIiR7UEhPTkVfTlVNQkVSfSInL2ciIFwKICAg
ICAgICAtZSAicy9FTUFJTC8nIiR7RU1BSUx9IicvZyIgXAogICAgICAgIC1lICJzL0RPTUFJTi8n
IiR7RE9NQUlOfSInL2ciIFwKICAgICAgICAtZSAicy9GVUxMX0hBTkRMRS8nIiR7RlVMTF9IQU5E
TEV9IicvZyIgXAogICAgICAgIC1lICJzL0hBTkRMRV8xLyciJHtIQU5ETEVfMX0iJy9nIiBcCiAg
ICAgICAgLWUgInMvSEFORExFXzIvJyIke0hBTkRMRV8yfSInL2ciIFwKICAgICAgICAtZSAicy9c
c1wrJC8vIiBcCiAgICAgJwoKZ2l0IGNvbmZpZyAtLWdsb2JhbCBmaWx0ZXIuYW5vbnltaXplLmNs
ZWFuIFwKICAgICdzZWQgXAogICAgICAgIC1lICJzLyciJHtFTUFJTF9QQVRURVJOfSInL0VNQUlM
L2lnIiBcCiAgICAgICAgLWUgInMvJyIke1BIT05FX1BBVFRFUk59IicvUEhPTkVfTlVNQkVSL2ci
IFwKICAgICAgICAtZSAicy8nIiR7RE9NQUlOfSInL0RPTUFJTi9pZyIgXAogICAgICAgIC1lICJz
LyciJHtGVUxMX0hBTkRMRX0iJy9GVUxMX0hBTkRMRS9pZyIgXAogICAgICAgIC1lICJzLyciJHtI
QU5ETEVfMX0iJy9IQU5ETEVfMS9pZyIgXAogICAgICAgIC1lICJzLyciJHtIQU5ETEVfMn0iJy9I
QU5ETEVfMi9pZyIgXAogICAgJwo=
END
