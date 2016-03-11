#!/bin/sh

REMOTEHOST=$1

if test -z $REMOTEHOST
then
        echo "Usage: befriend.s.sh user@host.i.want.to.be.friend.with"
        echo "Script will find (or create) and upload keys to host"
        exit
fi

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
					mkdir -p ~/.ssh;
					cat /tmp/sshkey.pub >> ~/.ssh/authorized_keys;
					cat /tmp/sshkey.pub >> ~/.ssh/authorized_keys2;
					chmod 700 ~/.ssh
					chmod 640 ~/.ssh/authorized_keys
					chmod 640 ~/.ssh/authorized_keys2
				       	rm /tmp/sshkey.pub' && echo Done!
