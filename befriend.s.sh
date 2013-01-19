#!/bin/sh


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
