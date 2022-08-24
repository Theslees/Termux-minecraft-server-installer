#!/bin/bash
# Works with superuser and normal user. finally
printf "Setting up..."
printf "\ncurrently running script as $USER\n "

. /etc/os-release
version="1.19.2"
installer_version="0.4.3"
bashrc="$HOME/.bashrc"
ram=$(free --mega | grep Mem | awk '{ print $7 }')
whereami=$(pwd)
distro="$ID"
mc="$HOME/.local/bin/mc"
mc_root="/bin/mc"
# Download dependencies and requirements

installer() {
if [ $distro = ubuntu ]; then
    apt-get update && apt-get install openjdk-18-jre-headless openjdk-18-jdk-headless tar
elif [ $distro = arch ] || [ $distro = manjaro ]; then
    pacman -Syy jre-openjdk-headless
elif [ $distro = alpine ]; then
    apk update && apk add openjdk18-jre-headless
elif [ $distro = debian ]; then
    apt update && dpkg --install openjdk-18-jre-headless
elif [ $distro = fedora ]; then
    dnf install java-18-openjdk-headless
elif [ $? =~ 0 ]; then
    printf "Error. File an issue at my Github with the name of your OS. ($distro)"
    return 1
    exit
fi
}

installer_sudo() {
if [ $distro = ubuntu ]; then
    sudo apt-get update && sudo apt-get install openjdk-18-jre-headless openjdk-18-jdk-headless tar
elif [ $distro = arch ] || [ $distro = manjaro ]; then
    sudo pacman -Syy jre-openjdk-headless
elif [ $distro = alpine ]; then
    sudo apk update && sudo apk add openjdk18-jre-headless
elif [ $distro = debian ]; then
    sudo apt update && sudo dpkg --install openjdk-18-jre-headless
elif [ $distro = fedora ]; then
    sudo dnf install java-18-openjdk-headless
elif [ $? =~ 0 ]; then
    printf "Error. File an issue at my Github with the name of your OS. ($distro)"
    return 1
    exit
fi
}

if [ $(id -u) -eq 0 ]; then
    installer
else
    installer_sudo
fi
# Download Quilt server jar

quilt() {
printf "\nDownloading MC Java server $version.. Powered by Quilt! Please Wait.."
java -jar quilt-installer-$installer_version.jar \
    install server $version \
    --download-server
clear
echo "Done! Finalizing and creating shell script.. (so you should only have to run mc in your terminal.)"
# Cleanup

cd server && cp -r libraries server.jar quilt-server-launch.jar .. && cd .. && rm -R server
}

quilt

mc() {
echo -e "\nYou have *$ram* Mb available!"
echo -e " \nHow much ram do you want to allocate to your server? (Mb) \n(leave atleast 2000Mb or more for Android. u may experience crashes otherwise.)"
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
echo -e " \nHow much ram do you want to allocate to your server? (Mb) \n(leave atleast 2000Mb or more for Android. u may experience crashes otherwise.)"
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
# ^ Creates a shell script at /.local/bin or /bin if root. ^

printf "That should be it! \nrun mc in your terminal to start the mc server anytime. \nPlease make sure to exit your session and log back in for it to take effect! \nIf anything is wrong please open an Issue in github, or DM me on Discord. \n~ https://github.com/Theslees/termux-Optimized-MC-Java-server || Theslees\#1162 ~\n "
exit
