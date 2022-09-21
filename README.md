# termux-Optimized-MC-Java-server
This is a simple script that will automatically install and configures an extremely optimized vanilla-experience server for Minecraft Java Edition. Powered by the Quilt Mod Loader! This is the best script to automatically get the most optimized MC Server out there as far as I know. Works in Termux too!

# Thanks to these things/people that made it possible !
> MC 1.19.2 - Synced server package manifest to client, updating the network framework Netty

> Quilt Mod Loader - Best solution for hosting MC servers imo. (That isn't enterprise, proprietary and specifically designed for certain things.)

> Quilt Mod Loader Discord - Very cool people and devs helped me find lib issues, ty.

> The Mods - Lithium, VMP *(Very Many Players)*, FerriteCore, Krypton, ViaFabric, Starlight, qfapi *(fabric library implementation and Quilt library from Quilt)*, Fabrictailor *(to change skins, do /skin)*, Clumps, C2ME.

> Sukiru - they're like a java dev as a job or something idk, they were useful nontheless with answering questions.

*Will update this repository accordingly if a new mc version comes out, and I will also update the mods time to time. Feel free to open issues and whatnot too :)*
# Steps to Install

### ⚠️ This guide assumes you are runnning a supported operating system in termux. If not, you can download AnLinux to install a supported distro. ⚠️
As long as you are on a supported operating system, this script should work, even if you're not on Termux.

**Currently supported distros; Fedora, Debian, Ubuntu, Arch Linux, Manjaro, Alpine Linux.**

If you need help with anything, my discord is below.

> notice; This has only been tested with Ubuntu, so feedback is appriciated!! My discord is Theslees#1162. I want to make this script compatible with anything Linux. so make a PR if you're smarter than me and can contribute^^^. Though you're on you're own if your enviroment isn't exactly as I described.

Anyways, enough talking, lets set this server up!

## Setup
Debian-based

`apt-get install git`

Arch-based

`pacman -S git`

Fedora

`dnf install git`

Alpine

`apk add git`

## Cmds (run in order, do this to update your server whenever I make a new update.)
`git clone https://github.com/Theslees/termux-Optimized-MC-Java-server mc`

`cd mc`

`chmod +x one-time-install.sh`

*With or without root;*

`./one-time-install.sh`

**After finishing the setup and script, you should be able to run "mc" in your terminal to start the server anytime you want. to connect to your server, you can go to your phone's Wifi Settings, and click on your connection to see more details about it. There you find your ip address, which u use to connect to your mc server. (should look something like 192.168.0.XX.) if u need to contact me in any way,, my discord is above, Enjoy~**

###### i am not responsible for batteries frying or anything that may happen. You are doing this on your own will, and you are aware of the Risks that come with putting your phone through this.

# To do
- Add Windows support
- Geyser support
- More Distros
- ~~Use functions to make it easier to read ig~~
