# Clone Subnautica's Compatdata path for Nitrox to run in
cp -r ~/.local/share/Steam/steamapps/compatdata/264710 ~/.local/share/Steam/steamapps/compatdata/NitroxLauncher

export STEAM_COMPAT_DATA_PATH=~/.local/share/Steam/steamapps/compatdata/NitroxLauncher
export STEAM_COMPAT_CLIENT_INSTALL_PATH=~/.local/share/Steam
launcherpath=~/.local/share/Steam/steamapps/compatdata/264710/pfx/drive_c/users/steamuser/AppData/Roaming/Nitrox

# Create the Nitrox directory if it doesn't exist
mkdir -p "$launcherpath"

# Create the launcherpath.txt file so Subnautica can locate and load Nitrox
echo "$launcherpath" > "$launcherpath/launcherpath.txt"

# Create path.txt and put Subnautica's path into it
echo ~/.local/share/Steam/steamapps/common/Subnautica > "$(dirname $(readlink -f $0))/path.txt"

# Start the Nitrox Launcher with Proton
~/home/deck/.local/share/Steam/steamapps/common/Proton\ 6.3/proton run NitroxLauncher.exe
if [[ $? -ne 0 ]]; then
  proton=1
fi

# If the above command failed prompt user to install Proton 6.3
if [[ $proton == 1 ]]; then
  xdg-open steam://install/1580130
  sleep 1
  echo -e "\e[31mProton 6.3 Not Found. Install it to the default steam directory\nPress any key when it finishes downloading\e[0m"
  read -n 1 -s -r -p ""
  ~/home/deck/.local/share/Steam/steamapps/common/Proton\ 6.3/proton run NitroxLauncher.exe
fi

