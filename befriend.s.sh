#!/bin/sh

REMOTEHOST=$1

if test	-f ~/.ssh/identity.pub
then
	SSHKEY=~/.ssh/identity.pub
else
	if test -f ~/.ssh/id_dsa.pub
	then
		SSHKEY=~/.ssh/id_dsa.pub
	else
		if test -f ~/.ssh/id_rsa.pub
		then
			SSHKEY=~/.ssh/id_rsa.pub
		else
			echo No available key found, creating one
			ssh-keygen -t dsa
		fi
	fi
fi

echo Using ${SSHKEY}
echo Connecting to ${REMOTEHOST}

cat ${SSHKEY} | ssh ${REMOTEHOST} 'cat >> /tmp/sshkey.pub;
					test -d ~/.ssh4 || mkdir ~/.ssh4;
					cat /tmp/sshkey.pub >> ~/.ssh4/authorized_keys;
					cat /tmp/sshkey.pub >> ~/.ssh4/authorized_keys2;
				       	rm /tmp/sshkey.pub'
