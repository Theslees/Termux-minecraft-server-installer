#!/bin/bash
printf "Setting up..."
# Update version when new version is out.

version="1.19.2"
installer_version="0.4.3"
bashrc=~/.bashrc
0="0"
# Download dependencies and requirements
apt-get update && apt-get install openjdk-18-jre-headless && openjdk-18-jdk-headless && tar
printf "Downloading MC Java server $version.. Powered by Quilt! Please Wait.."

java -jar quilt-installer-$installer_version.jar \
  install server $version \
  --download-server
echo "Done! Finalizing and creating alias.."
# Cleanup

cd server && mv libraries server.jar quilt-server-launch.jar .. && cd .. && rmdir server
echo -n "How much ram do you want to allocate to your server(Mb)?\n (make sure to leave atleast 2gb for Android! Or maybe more if possible! If not, u may experience crashes.); "
read option
if [[ ! $option =~ ^[0-9]+$ ]] ; then
    echo "Please enter a Number only"
    exit
fi
# Creates alias "mc" to run the server

echo "\n alias mc='cd ~/mc/ && java -Xms$option\M -Xmx$option\M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar quilt-server-launch.jar nogui'\n" >> $bashrc
printf "That's should be it! run mc in your terminal to start the mc server anytime.\n Please make sure to exit your session and log back in for it to take effect! If anything is wrong please open an Issue in github, or DM me on Discord.\n https://github.com/Theslees/termux-Optimized-MC-Java-server || Theslees\#1162"
exit
