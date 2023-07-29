#!/bin/bash

clear
printf "Setting up...\n "
printf "currently running script as $USER...\n "
# Welcome to another minecraft server installer! -- Executes with superuser and normal user. finally. https://github.com/Theslees/Termux-minecraft-server-installer

# *Define the variables*
. /etc/os-release
# $version used in quilt() to determine what instance version to download
version="1.20.1"
# removed installer_version, script doesnt store the quilt server installer locally anymore.
#bashrc variable removed, not used
ram=$(free --mega | grep Mem | awk '{ print $7 }')
whereami=$(pwd)
#distroid removed, not needed
# $mc and $mc_root are here to help setup the shell script placed in your current enviroment's bin directory for executing within your terminal, like a normal binary.
# the configuration processes can be found in the mc() and mc_root() functions, for non-root and root respectively.
mc="$HOME/.local/bin/mc"
mc_root="/bin/mc"
termux=/data/data/com.termux/files/usr

# ---------------------------------------------
# - finished! termux does not have openjdk18 but does have openjdk17, which is what will be used if native Termux support is implemented. (poorly implemented but it works)
# - fixed! if openjdk18 is not in your repositories for some reason, it will not error despite not installing properly. fallback to openjdk17.
# - fixed! if you're running this on termux, it'll go through the normal installer despite already knowing that they wont work. Not a bug, but an oversight causing Termux users having to wait longer for the script to finish.
# - New! Update to Java 19, and 1.19.3.
# - New! Update to Java 20 (and 1.20.x i forgot to mention, i'll stop timestamping these (if you can even consider it that, I did not write the time of these writings whatsoever) things here though, its stupid lol)
# - fixed! Improved termux and root detection algorithms in different parts of this script
# ---------------------------------------------

# uses $termux to check for a directory normally found in Termux. Detects termux enviroment
if [ -d $termux ]; then
  termux=0
  echo -n "Detected Termux enviroment! continuing setup..\n"
  sleep 0.4
  pkg update
  if [ ! $(command -v tsu) ];
  	then
  		echo "Tsu is not installed... installing tsu.."
  		pkg install tsu
  fi
    if [ $(whoami) != "root" ]; then
    echo -n "Installing dependancies.."
    sudo pkg install openjdk-17 grep procps wget
  else
    echo -n "Installing dependancies.."
    pkg install openjdk-17 grep procps wget
  fi
else
  termux=1
	echo -n "Detected a non-termux enviroment, continuing setup! \n"
fi


installer() {
# Download dependencies and requirements
if [ $termux = 0 ]; then 
  break 
else 
  return 0
fi

if [ -x "$(command -v apk)" ]; then
  pkgfnd=1
    apk update && apk add --no-cache openjdk20-jre-headless nano grep procps wget
elif [ -x "$(command -v apt-get)" ]; then
  pkgfnd=2
    apt-get update && apt-get install openjdk-20-jre-headless nano grep procps wget
elif [ -x "$(command -v apt)" ]; then
  pkgfnd=3
    apt update && apt install openjdk-20-jre-headless nano grep procps wget
elif [ -x "$(command -v dnf)" ]; then
  pkgfnd=4
    dnf upgrade && dnf install java-latest-openjdk-headless nano grep procps-ng wget
elif [ -x "$(command -v pacman)" ]; then
  pkgfnd=5
    pacman -Syy jre-openjdk-headless nano grep procps wget --needed
else
  echo -n "PACKAGE MANAGER NOT FOUND; You must manually install Java 17 or higher. \nTry opening an issue on Github to suggest support for your distro.\n "
  return 1
  exit
fi

if [ $? != 0 ]; then
  pkgfail=true
else
  pkgfail=false
fi

# Uses $pkgfnd (package find) earlier defined to know what package manager you're using inorder to downgrade java version if needed
if [ $pkgfnd = 1 ]; then pkgfnd="apk update && apk add --no-cache openjdk17-jre-headless nano grep procps wget"
elif [ $pkgfnd = 2 ]; then pkgfnd="apt-get update && apt-get install openjdk-17-jre-headless nano grep procps wget"
elif [ $pkgfnd = 3 ]; then pkgfnd="apt update && apt install openjdk-17-jre-headless nano grep procps wget"
elif [ $pkgfnd = 4 ]; then pkgfnd="dnf upgrade && dnf install java-17-openjdk-headless nano grep procps-ng wget"
elif [ $pkgfnd = 5 ]; then pkgfnd="pacman -Syy jre17-openjdk-headless nano grep procps wget --needed"
fi

if [ $pkgfail = true ]; then
  echo -n "\nFAILED TO INSTALL PACKAGES; Attempting to download Java 17 instead...\n "
  $pkgfnd
  return 1
else
  echo -n "Success!"
  return 0
fi
if [ $? != 0 ]; then
  echo -n "FAILED TO INSTALL PACKAGES; Java 17 installation failed, or required packages could not be synced and installed. \nPlease check my github for more support.\n "
  return 1
fi
}

installer_sudo() {
if [ $termux = 0 ]; then 
  break
else 
  return 0
fi
if [ -x "$(command -v apk)" ]; then
  pkgfnd=1
  sudo apk update && sudo apk add --no-cache openjdk20-jre-headless nano grep procps wget
elif [ -x "$(command -v apt-get)" ]; then
  pkgfnd=2
  sudo apt-get update && sudo apt-get install openjdk-20-jre-headless nano grep procps
elif [ -x "$(command -v apt)" ]; then
  pkgfnd=3
  sudo apt update && sudo apt install openjdk-20-jre-headless nano grep procps
elif [ -x "$(command -v dnf)" ]; then
  pkgfnd=4
  sudo dnf upgrade && sudo dnf install java-latest-openjdk-headless nano grep procps-ng
elif [ -x "$(command -v pacman)" ]; then
  pkgfnd=5
  sudo pacman -Syy jre-openjdk-headless nano grep procps --needed
else
  echo -n "PACKAGE MANAGER NOT FOUND; You must manually install Java 17 or higher. \nMaybe open an issue on Github to suggest support for your distro.\n "
  return 1
  exit
fi

if [ $? != 0 ]; then
  pkgfail=true
else
  pkgfail=false
fi

if [ $pkgfnd = 1 ]; then pkgfnd="sudo apk update && sudo apk add --no-cache openjdk17-jre-headless nano grep procps"
elif [ $pkgfnd = 2 ]; then pkgfnd="sudo apt-get update && sudo apt-get install openjdk-17-jre-headless nano grep procps"
elif [ $pkgfnd = 3 ]; then pkgfnd="sudo apt update && sudo apt install openjdk-17-jre-headless nano grep procps"
elif [ $pkgfnd = 4 ]; then pkgfnd="sudo dnf upgrade && sudo dnf install java-17-openjdk-headless nano grep procps-ng"
elif [ $pkgfnd = 5 ]; then pkgfnd="sudo pacman -Syy jre17-openjdk-headless nano grep procps --needed"
fi

if [ $pkgfail = true ]; then
  echo -n "FAILED TO INSTALL PACKAGES; Attempting to download Java 17..."
  $pkgfnd
else
  echo -n "Success!"
  return 0
fi

if [ $? != 0 ]; then
  echo -n "FAILED TO INSTALL PACKAGES; Java 17 installation failed, or required packages could not be sync and installed. \nPlease check github for more support.\n "
  return 1
fi
}

# Detects if you're root, then runs the appropriate setup
if [ $(whoami) == "root" ]; then
    installer
else
    installer_sudo
fi

# The quilt server instance downloader
quilt() {
clear
printf "\nDownloading MC Java server $version.. Powered by Quilt! Please Wait.. \n "
# This will get the quilt server installer jar and run it, which downloads the prerequisites required for the server instance itself and the jar files to boot it.
wget https://quiltmc.org/api/v1/download-latest-installer/java-universal&&mv java-universal quilt-installer.jar
java -jar quilt-installer.jar \
    install server $version \
    --download-server
# Cleanup and organize quilt files
clear
printf "Done! Cleaning and organizing.. \n "
mv server/* . && rm -R server quilt-installer.jar
}
quilt

mc() {
clear
printf "You have *$ram* Mb available!\n"
printf "How much ram do you want to allocate to your server? (Mb) \n(leave atleast 2000Mb or more for your operating system. u may experience crashes otherwise.)\n"
printf "note: if the script exits because a number wasn't placed, then it'll just exit, please run the script again if this happens, you should be fine. \n(no decimals allowed either please)"
read -p $"Mb: " option
if [[ ! $option =~ ^[0-9]+$ ]]; then
    echo -e "\nPlease enter a number only."
    return 127
    break 1
else
    if [ $termux = 0 ]; then 
# The mc file for termux will still be at root, so theres currently no support for Termux non-root enviroments. I heard that it shouldn't matter anyway though, but I dont know if people are running users (non-root) in their termux enviroments.
# Creates the mc bin at root still despite this function being for local installs.
      mc="/data/data/com.termux/files/usr/bin/mc"
    else 
      return 0
    fi
    option="${option}M"
    touch $mc && cat /dev/null > $mc && echo "#!/bin/bash
    cd $whereami && java -Xms$option -Xmx$option -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar quilt-server-launch.jar nogui" >> $mc && chmod +x $mc
fi
}

mc_root() {
clear
printf "You have *$ram* Mb available!\n "
printf "How much memory do you want to allocate to your server? (Mb) \n(leave atleast 2000Mb free or more for your operating system. u may experience crashes otherwise.)\n"
printf "note: if the script exits because a number wasn't placed, then it'll just exit, please run the script again if this happens, you should be fine. \n(no decimals allowed either please)"
read -p $"Mb: " option
if [[ ! $option =~ ^[0-9]+$ ]]; then
    echo -e "\nPlease enter a number only."
    return 127
    break 1
else
    if [ $termux = 0 ]; then 
      mc_root="/data/data/com.termux/files/usr/bin/mc"
    else 
      return 0
    fi
    option="${option}M"
    touch $mc_root && cat /dev/null > $mc_root && echo "#!/bin/bash
    cd $whereami && java -Xms$option -Xmx$option -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar quilt-server-launch.jar nogui" >> $mc_root && chmod +x $mc_root
fi
}

if [ $(whoami) == "root" ]; then
    mc_root
else
    mc
fi

printf "That should be it! \nrun \"mc\" in your terminal to start the mc server anytime. \nIf anything is wrong please check github. \n~ https://github.com/Theslees/termux-Optimized-MC-Java-server ~\n "
exit
