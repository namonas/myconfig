#!/bin/bash

# trap handler
function traphandler() {
  # Disable SIG* inside this handler
  trap '' $@
  
  # Kill child process
  pid=$$
  
  for child in $(ps -o pid,ppid -ax | awk "{if(\$2 == $pid){print \$1}}")
  do
    echo "Killing child process $child because ppid = $pid"
    kill $child
  done
  
  echo 'quit';
  exit 1;
}

# register trap handler for SIG*
trap "traphandler $*" $@
