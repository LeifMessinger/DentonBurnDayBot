#!/bin/bash

#If this gives "No crontab for [user]", do crontab -e to edit and you should be good

#Only run once. Maybe check the crontab with -e to make sure there's only one line like this.

(crontab -l ; echo "1 9 * * * /usr/bin/node ~/Documents/DentonBurnDayBot/burnDay.sh ~/Documents/DentonBurnDayBot/TisBurnDay.json") | crontab -
