#!/bin/bash
printf "Setting up..."
# Update when new version is out.

version="1.19.2"
installer_version="0.4.3"
bashrc="~/.bashrc"
ram=$(free --mega | grep Mem | awk '{ print $4 }')
whereami=$(pwd)
zero=0
distro=$(cat /etc/os-release | grep '^ID=')
# Download dependencies and requirements

if [ $distro = ID=ubuntu ] ; then
    apt-get update && apt-get install openjdk-18-jre-headless openjdk-18-jdk-headless tar
if [ $distro = ID=arch ] ; then
    pacman -Syy jre-openjdk-headless
if [ $distro = ID=alpine ] ; then
    apk update && apk add openjdk18-jre-headless
if [ $distro = ID=debian ] ; then
    apt update && dpkg --install openjdk-18-jre-headless
if [ $distro = ID=fedora ] ; then
    dnf install java-18-openjdk-headless
if [ $distro = ID=manjaro ] ; then
    pacman -Syy jre-openjdk-headless
else
    echo -n "Unsupported OS. File an issue at my Github with the name of your OS"
    exit
fi
printf "Downloading MC Java server $version.. Powered by Quilt! Please Wait.."

java -jar quilt-installer-$installer_version.jar \
  install server $version \
  --download-server
echo "Done! Finalizing and creating alias.."
# Cleanup

cd server && mv libraries server.jar quilt-server-launch.jar .. && cd .. && rmdir server
echo -n "You have $ram\Mb available!\n"
printf "How much ram do you want to allocate to your server(Mb)?\n (make sure to leave atleast 2gb for Android! Or maybe more if possible! If not, u may experience crashes.); "
read option
if [[ ! $option =~ ^[0-9]+$ ]] ; then
    echo "Please enter a Number only"
    exit
else
    echo "\n alias mc='cd $whereami/mc/ && java -Xms$option\M -Xmx$option\M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar quilt-server-launch.jar nogui'\n" >> $bashrc
fi
# Creates alias "mc" to run the server ^

printf "That's should be it! run mc in your terminal to start the mc server anytime.\n Please make sure to exit your session and log back in for it to take effect! If anything is wrong please open an Issue in github, or DM me on Discord.\n https://github.com/Theslees/termux-Optimized-MC-Java-server || Theslees\#1162"
exit
