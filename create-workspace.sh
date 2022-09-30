#!/bin/bash
echo "name of workspace"
read workspaceName
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


mountSSHCommand="-v $HOME/.ssh:/home/perlt/.ssh"
mountVolumeCommand="-v $volumeLocationHost:/home/perlt/$volumeLocationContainer"
echo $mountSSHCommand
echo $mountVolumeCommand


if [[ "$OSTYPE" == "msys"* ]]; then
    MSYS_NO_PATHCONV=1 docker run -d --name $workspaceName $mountVolumeCommand $mountSSHCommand -it arch-workspace
else
    docker run -d --name $workspaceName $mountVolumeCommand $mountSSHCommand -it arch-workspace
fi
