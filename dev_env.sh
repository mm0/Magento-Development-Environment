#!/bin/bash
IP="3.3.3.3"
DOMAIN=""


function set_env(){
	echo "Adding $DOMAIN to hosts file"
	echo -e "$IP\t$DOMAIN\n" >> /etc/hosts 

}

function unset_env(){
	echo "Removing $DOMAIN from hosts file"
	`grep -v "$DOMAIN" /etc/hosts > /tmp/hosts; mv /tmp/hosts /etc`
}


COMM="set_env"
for i in "$@"
do 
	case $i in 
		-u|--unset)
			COMM="unset_env"
			shift
		;;
		-s)
			COMM="set_env"
			shift
		;;
	-d=*|--domain=*)
		DOMAIN="${i#*=}"
		shift
		;;
	-i=*|--ip=*)
		IP="${i#*=}"
		shift
		;;
esac
done
if [ -z "$DOMAIN" ] ; then
	echo "Please enter a domain to use. Exiting.";
	exit;
fi

$COMM
