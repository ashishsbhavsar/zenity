#!/bin/bash

form_data=$(zenity --forms --title="Docker Container Setup" \
	--text="Enter container details" \
	--separator="," \
	--add-entry="Image Name" \
	--add-entry="Host Port" \
	--add-entry="Container Port" \
	--add-entry="Host Volume Path" \
	--add-entry="Container Volume" \
	--add-entry="Container Name"
)

if [ $? -ne 0 ]; then
	exit
fi

imagename=$(echo "$form_data" | cut -d "," -f1)
host_port=$(echo "$form_data" | cut -d "," -f2)
container_port=$(echo "$form_data" | cut -d "," -f3)
host_volume=$(echo "$form_data" | cut -d "," -f4)
container_volume=$(echo "$form_data" | cut -d "," -f5)
container_name=$(echo "$form_data" | cut -d "," -f6)

output=$(sudo docker run -d --name=$container_name -p $host_port:$container_port -v $host_volume:$container_volume $imagename >&1)

if [ $? -eq 0 ]; then
	zenity --info --title="Success" --text="Container launched successfully!\n$output"
else
	zenity --error --title="Error" --text="Failed to run container!\n$output"
fi
