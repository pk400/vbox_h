#! /bin/bash

VBOX_DIR=/mnt/c/Program\ Files/Oracle/VirtualBox
VBOX_CMD="$VBOX_DIR"/VboxManage.exe
VBOX_LIST=$("$VBOX_CMD" list vms)

case $1 in
  start)
  echo "Which VM do you want to start?"
  echo "$VBOX_LIST" | awk 'BEGIN {FS="\""} {$0 = "[" ++i "] " $2}1'
  read OPT
  VM_LIST=$(echo "$VBOX_LIST" | awk -F '"' -v o=$OPT 'NR==o{print $2}')
  "$VBOX_CMD" startvm "$VM_LIST" --type headless
  ;;
  stop)
  RUNNING=$("$VBOX_CMD" list runningvms | awk -F '"' '{print $2}')
  "$VBOX_CMD" controlvm "$RUNNING" poweroff 
  ;;
  *)
  echo "Use either start or stop"
esac
