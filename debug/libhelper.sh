#!/bin/bash

# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 3, or
# (at your option) any later version.

# Show messages
plain() {
  local mesg=${1}; shift
  printf "${BOLD}    ${mesg}${ALL_OFF}\n" "${@}" >&2
}
msg() {
  local mesg=${1}; shift
  printf "${GREEN}==>${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "${@}" >&2
}
msg2() {
  local mesg=${1}; shift
  printf "${BLUE}  ->${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "${@}" >&2
}
warning() {
  if [ -z "${IGNORE_WARN}" ]; then
      local mesg=${1}; shift
      printf "${YELLOW}==> $(gettext "WARNING:")${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "${@}" >&2
  fi
}
error() {
  local mesg=${1}; shift
  printf "${RED}==> $(gettext "ERROR:")${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "${@}" >&2
}
abort() {
  error "${@}"
  error "$(gettext "Aborting...")"
  exit 1
}
setup_color_message() {
  unset ALL_OFF BOLD BLUE GREEN RED YELLOW
  if [[ -t 2 && $USE_COLOR != "n" ]]; then
      # prefer terminal safe colored and bold text when tput is supported
      if tput setaf 0 &>/dev/null; then
          ALL_OFF="$(tput sgr0)"
          BOLD="$(tput bold)"
          BLUE="${BOLD}$(tput setaf 4)"
          GREEN="${BOLD}$(tput setaf 2)"
          RED="${BOLD}$(tput setaf 1)"
          YELLOW="${BOLD}$(tput setaf 3)"
      else
        ALL_OFF="\e[0m"
        BOLD="\e[1m"
        BLUE="${BOLD}\e[34m"
        GREEN="${BOLD}\e[32m"
        RED="${BOLD}\e[31m"
        YELLOW="${BOLD}\e[33m"
      fi
  fi
}
setup_color_message

# Grep block
grep_block() {
  local keyword="${1}"; shift
  local files=${@}
  awk -v keyword="${keyword}" 'BEGIN{RS="\n\n"} $0 ~ keyword{print ""; print; n++}' ${files}
}

# Get self functions
app_file="${0}"
get_self_funcs() {
  grep -o "^${1}.*()" "${app_file}" | sed "s/^\(.*\)()/\1/" | sort
}

get_action_funcs() {
  get_self_funcs "action_" | sed 's/action_/        /g'
}
