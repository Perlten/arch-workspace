#!/bin/bash
echo "name of workspace"

read workspaceName
workspaceName="${workspaceName,,}"

echo "Volume to mount(absolute path)"

volumeLocationHost=""
while read -ep "Enter folder path location: " file_dir; do
	if [ -d "${file_dir}" ]; then
		volumeLocationHost=${file_dir}
		break
	else
		echo "location does not exsists"
	fi
done

echo "Location to mount(from user path ~/)"
read volumeLocationContainer
echo "Mount shh keys? (yes/no)"
read mountSSH

docker build --no-cache -t $workspaceName-image .

mountSSHCommand="-v $HOME/.ssh:/home/perlt/.ssh"
mountVolumeCommand="-v $volumeLocationHost:/home/perlt/$volumeLocationContainer"

if [[ "$OSTYPE" == "msys"* ]]; then
	MSYS_NO_PATHCONV=1 docker run -v //var/run/docker.sock:/var/run/docker.sock -d --name $workspaceName $mountVolumeCommand $mountSSHCommand -it $workspaceName-image
else
	docker run -v /var/run/docker.sock:/var/run/docker.sock -d --name $workspaceName $mountVolumeCommand $mountSSHCommand -it $workspaceName-image
fi
