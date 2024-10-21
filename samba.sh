#!/usr/bin/env bash

if ! command -v samba &> /dev/null ; then
	echo "samba is not installed, it will now be installed!"
	read -n1 -r -p "Press any key to continue..."
	if sudo apt-get install samba ; then
		echo "samba was successfully installed"
		read -n1 -r -p "Press any key to continue.."
		echo -e "\e[1;1f\e[2J"
	fi
fi

echo backing up default samba config
if ! sudo ls /etc/samba/smb.conf.bak &> /dev/null ; then
	sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak
fi

echo "Creating new samba config"
echo "[$USER]
	path = /home/$USER
	read only = no
	writable = yes" | sudo tee /etc/samba/smb.conf &> /dev/null

sudo service smbd restart &> /dev/null && echo restarted samba service
sudo ufw allow samba &> /dev/null && echo allowed samba through ufw

echo "Add a user in samba"
read -r -p "Do you want to create a samba user? [y|n] " validation
if [ $validation == "y" ] ; then
	sudo smbpasswd -a $USER
fi
echo
ipv4_address=$(hostname -I | grep -oP '(\d{1,3}\.){3}\d{1,3}')
echo on windows add \\\\$ipv4_address\\$USER
