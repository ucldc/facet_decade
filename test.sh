#!/usr/bin/env bash
if [[ -n "$DEBUG" ]]; then 
  set -x
fi

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # http://stackoverflow.com/questions/59895

if hash md5 2>/dev/null; then
  md5='md5'
elif hash md5sum 2>/dev/null; then
  md5='md5sum'
else
  echo >&2 "no md5 or md5sum found"
  exit 1
fi

check_for() {
  for arg in $@; do
    hash $arg 2>/dev/null || { echo >&2 "no $arg found"; exit 1; }
  done
}
check_for groovy python ruby node jq

run_all () {
  for command in $(ls facet_decade.*); do
    echo $command
    (./$command "$@") | jq .
  done
}

check_all () {
  # make sure all the versions have the same output
  local check=''
  for command in $(ls facet_decade.*); do
    next_check=$((./$command "$@") | jq . | $md5)
    if [[ $check ]]; then
      if ! [[ $check == $next_check ]]; then
        echo >&2 "mismatch in: \"$@\""
        run_all "$@"
        exit 1
      fi
    fi
    check=$next_check
  done
  echo "hash: $check in: \"$@\" "
}

if [ $# > 1 ]; then
  run_all "$@"
  exit 0
fi


YEAR=$(date +"%Y")
NEXT_YEAR=$((YEAR + 1))

check_all "1001 $NEXT_YEAR"
check_all "1000 $YEAR"
check_all "1920 1951"
check_all "1920 1949"
check_all "1920 1950"
check_all "hey" 
check_all ""
check_all "1 11 111 2222 22222"
check_all "1 11 111 1111 11111"
check_all "1952-12-21 to 2014-10-22"


# http://www.cyberciti.biz/faq/bash-comment-out-multiple-line-code/
: '
Copyright © 2015, Regents of the University of California
All rights reserved.
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
- Redistributions of source code must retain the above copyright notice,
  this list of conditions and the following disclaimer.
- Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.
- Neither the name of the University of California nor the names of its
  contributors may be used to endorse or promote products derived from this
  software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
'
