#!/bin/bash
shopt -s expand_aliases
alias muby='ruby /Users/matt/Documents/Git/mash_util/muby.rb'

#to get the latest backup(filename)
#ssh light.com"ls -ld -rt /var/mysql_backups/* | tail -1 " | awk '{ print $9}'
Home_Dir="~/Documents/Git/StoreMagento/"
MySQL_User="root"
MySQL_Password="password"

function update_mysql(){
	command=`muby -p ls_newest_file_full_path "/var/mysql_backups"`
	filename=`muby ssh_execute_remote_cmd "light.com" "$command"`
	filename=`echo $filename | sed -e "s/\"//g" | awk '{print $9}'`
	basename=`basename $filename`
	muby  scp_retrieve "light.com" $filename .
	muby  gunzip $basename
	basename=`echo $basename | sed -e "s/\.gz//g"`
	#last param (optional) is bad
	mysql_i=`muby -p mysql_import "$MySQL_User" "$MySQL_Password" "$basename" '--all-databases'`
	muby vagrant_execute_cmd "$mysql_i" 
}

function set_env(){
	#figure out how to wait for vagrant to be up
#	muby vagrant_start "$Home_Dir"
	muby  set_local_hosts "3.3.3.3\tlight.com\n3.3.3.3\tdev.light.com\n3.3.3.3\twww.light.com"
}

function unset_env(){
	muby -p unset_local_hosts "light"
#	muby -p vagrant_pause "/directory"
}

if [ "$1" == "update_mysql" ]; then
	update_mysql
	exit
fi

set_env
