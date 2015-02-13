#!/usr/bin/env bash
if [[ -n "$DEBUG" ]]; then 
  set -x
fi

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # http://stackoverflow.com/questions/59895

if hash md5 2>/dev/null
then
  md5='md5'
elif hash md5sum 2>/dev/null
then
  md5='md5sum'
else
  echo "no md5"
  exit 1
fi

check_for() {
  for arg in $@
  do
    hash $arg 2>/dev/null || { echo >&2 "$arg required"; exit 1; }
  done
}
check_for groovy python ruby node jq

run_all () {
  for command in $(ls facet_decade.*)
  do
    echo $command
    (./$command "$@") | jq . | $md5
  done
}

run_all "hey" 
run_all "1 11 111 1111 11111"
run_all "1 11 111 2222 22222"
run_all ""
run_all "1952-12-21 to 2014-10-22"
