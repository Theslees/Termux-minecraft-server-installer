#!/bin/bash

# Works with superuser and normal user. finally. https://github.com/Theslees/termux-Optimized-MC-Java-server
clear
printf "Setting up..."
printf "\ncurrently running script as $USER...\n "
. /etc/os-release

version="1.19.2"
installer_version="0.4.4"
#bashrc variable removed, not used
ram=$(free --mega | grep Mem | awk '{ print $7 }')
whereami=$(pwd)
#distroid removed, not needed
mc="$HOME/.local/bin/mc"
mc_root="/bin/mc"

# Download dependencies and requirements
# If Termux's repositories has java 18, then it'll be implemented here to remove the need of AnLinux, so you can run the script in native Termux!
# !bug! if openjdk is not in your repositories for some reason, it will not error despite not installing properly.
installer() {
if [ -x "$(command -v apk)" ];       then  apk add --no-cache openjdk18-jre-headless nano grep procps
elif [ -x "$(command -v apt-get)" ]; then  apt-get install openjdk-18-jre-headless nano grep procps
elif [ -x "$(command -v apt)" ];  then  sudo apt install openjdk-18-jre-headless nano grep procps
elif [ -x "$(command -v dnf)" ];     then  dnf install java-18-openjdk-headless nano grep procps-ng
elif [ -x "$(command -v pacman)" ]; then pacman -S jre-openjdk-headless nano grep procps --needed
else echo "FAILED TO INSTALL PACKAGE: Package manager not found. You must manually install: Java or check github"
fi
}

installer_sudo() {
if [ -x "$(command -v apk)" ];       then  sudo apk add --no-cache openjdk18-jre-headless nano grep procps
elif [ -x "$(command -v apt-get)" ];  then  sudo apt-get install openjdk-18-jre-headless nano grep procps
elif [ -x "$(command -v apt)" ];  then  sudo apt install openjdk-18-jre-headless nano grep procps
elif [ -x "$(command -v dnf)" ];     then  sudo dnf install java-18-openjdk-headless nano grep procps-ng
elif [ -x "$(command -v pacman)" ]; then sudo pacman -S jre-openjdk-headless nano grep procps --needed
else echo "FAILED TO INSTALL PACKAGE: Package manager not found. You must manually install: Java or check github"
fi
}
# Detects if you're signed in as root
if [ $(id -u) -eq 0 ]; then
    installer
else
    installer_sudo
fi
clear
echo "Done! Finalizing and creating shell script.."

# Runs the quilt server installer
quilt() {
printf "\nDownloading MC Java server $version.. Powered by Quilt! Please Wait.."
java -jar quilt-installer-$installer_version.jar \
    install server $version \
    --download-server
# Cleanup
cd server && cp -r libraries server.jar quilt-server-launch.jar .. && cd .. && rm -R server LICENSE README.md
}
quilt

mc() {
echo -e "\nYou have *$ram* Mb available!"
echo -e " \nHow much ram do you want to allocate to your server? (Mb) \n(leave atleast 2000Mb or more for your operating system. u may experience crashes otherwise.)"
read -p $"Mb: " option
if [[ ! $option =~ ^[0-9]+$ ]]; then
    echo -e "\nPlease enter a number only."
    return 1
else
    clear
    option="${option}M"
    touch $mc && cat /dev/null > $mc && echo "#!/bin/bash
    cd $whereami && java -Xms$option -Xmx$option -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar quilt-server-launch.jar nogui" >> $mc && chmod +x $mc
fi
}

mc_root() {
echo -e "\nYou have *$ram* Mb available!"
echo -e " \nHow much memory do you want to allocate to your server? (Mb) \n(leave atleast 2000Mb or more for your operating system. u may experience crashes otherwise.)"
read -p $"Mb: " option
if [[ ! $option =~ ^[0-9]+$ ]]; then
    echo -e "\nPlease enter a number only."
    return 1
else
    clear
    option="${option}M"
    touch $mc_root && cat /dev/null > $mc_root && echo "#!/bin/bash
    cd $whereami && java -Xms$option -Xmx$option -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar quilt-server-launch.jar nogui" >> $mc_root && chmod +x $mc_root
fi
}
if [ $(id -u) -eq 0 ]; then
    mc_root
else
    mc
fi

printf "That should be it! \nrun \"mc\" in your terminal to start the mc server anytime. \nIf anything is wrong please open an Issue in github, or DM me on Discord. \n~ https://github.com/Theslees/termux-Optimized-MC-Java-server ~ || ~ Theslees\#1162 ~\n "
exit
