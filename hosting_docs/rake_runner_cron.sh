#! /bin/bash
directory=~/mf17/my_website/log/share_file_app
if [ ! -d $directory ]; then
  mkdir $directory
fi

CRON_FILE=~/mf17/my_website/log/share_file_app/rake_runner_cron.log
if test -f "$CRON_FILE"; then
   :
else
   touch $CRON_FILE
fi

FILE=~/mf17/my_website/log/share_file_app/rake_runner.log
if test -f "$FILE"; then
  :
else
   touch $FILE
fi
echo -e "started the share files app cronjob(rake runner) at "`date`>> $FILE

cd ~/mf17/my_website/
RAILS_ENV=production /usr/local/rvm/wrappers/ruby-2.7.0@my_website/rake share_file:clean_up_file_senders
RAILS_ENV=production /usr/local/rvm/wrappers/ruby-2.7.0@my_website/rake share_file:delete_alert_sender
echo -e "finished the share files app cronjob(rake runner) at "`date` >> $FILE
echo -e "" >> $FILE