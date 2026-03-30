#!/bin/false
# Do **not** run this file, use as reference
# This file stores in a "deconstructed" format one-linesrs, with explanation of their sections
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
#   * AND make sure that there is an an identity OR add it
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
#   * AND make sure that there is an an identity OR add it
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

git config --global filter.anonymize.clean
    'sed
        -e "s/<PHONE_PATTERN>/MY_PHONE_NUMBER/g"
        -e "s/<EMAIL_1_PATTERN>/MY_EMAIL_ADDRESS/g"
        -e "s/<EMAIL_2_PATTERN>/MY_EMAIL_ADDRESS_2/g"
        -e "s/<DOMAIN_PATTERN>/MY_SHORT_HANDLE-MY_SECONDARY_HANDLE.net/g"
        -e "s/<FULL_HANLDE_PATTERN>/MY_SHORT_HANDLE_MY_SECONDARY_HANDLE/g"
        -e "s/<SHORT_HANDLE_PATTERN>/MY_SHORT_HANDLE/g"
        -e "s/<OPENAI_KEY_PATTERN>/MY_OPENAI_KEY/"
        -e "s/\s\+$//"'
