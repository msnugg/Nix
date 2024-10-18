#Clone Subnautica's Compatdata path for Nitrox to run in
cp -r ~/home/deck/.local/share/Steam/steamapps/compatdata/264710 ~/home/deck/.local/share/Steam/steamapps/compatdata/NitroxLauncher



export STEAM_COMPAT_DATA_PATH=~/home/deck/.local/share/Steam/steamapps/compatdata/NitroxLauncher
export STEAM_COMPAT_CLIENT_INSTALL_PATH=~/home/deck/.local/share/Steam
launcherpath=~/home/deck/.local/share/Steam/steamapps/compatdata/264710/pfx/drive_c/users/steamuser/AppData/Roaming/Nitrox

#Create the Nitrox directory if it doesnt exist
mkdir -p $launcherpath

#Create the launcherpath.txt file so Subnautica can locate and load Nitrox
$(dirname $(readlink -f $0)) > $launcherpath/launcherpath.txt

#Create path.exe and put Subnautica's path into it (removes a step in the Nitrox Launcher)
echo ~/home/deck/.local/share/Steam/steamapps/common/Subnautica > $(dirname $(readlink -f $0))/path.txt


#Start the Nitrox Launcher with Proton
~/home/deck/.local/share/Steam/steamapps/common/Proton\ 6.3/proton run NitroxLauncher.exe || proton=1

#If the above command failed prompt user to install Proton 6.3
if [[ $proton == 1 ]]; then
  xdg-open steam://install/1580130
  sleep 1
  echo -e "\e[31mProton 6.3 Not Found. Install it to the default steam directory\nPress any key when it finishes downloading\e[0m"
  read -n 1 -s -r -p ""
  ~/home/deck/.local/share/Steam/steamapps/common/Proton\ 6.3/proton run NitroxLauncher.exe
fi
