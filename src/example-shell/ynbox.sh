#!/bin/bash

dialog --title "Warning : File Deletion" --backtitle \
"Hakchin's Shell" --yesno \
"\nDo you delete? '/home/multi/testdel.sh' file" 7 60
sel=$?
case $sel in
  0) echo "Yes Selected" ;;
  1) echo "No Selected";;
  255) echo "<ESC>키를 눌러 취소하였습니다.";;
esac
