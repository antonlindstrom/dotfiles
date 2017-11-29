#!/bin/bash

doc=$(ls ~/Documents | rofi -dmenu -p "Documents:" -a 0 -no-custom)
xdg-open ~/Documents/$doc
