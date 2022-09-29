# termux-Optimized-MC-Java-server
This is a simple script that will automatically install and configures an extremely optimized vanilla-experience server for Minecraft Java Edition. Powered by the Quilt Mod Loader! This is the best script to automatically get the most optimized MC Server out there as far as I know. Add any Fabric or Quilt mod you want, and it Works in Termux too!

## Thanks to these things/people that made it possible !
> MC v1.19.2 - Synced server package manifest to client, updating the framework Netty

> Quilt Mod Loader - Best solution for hosting MC servers imo (That isn't enterprise, proprietary and designed for specific things.)

> Quilt Mod Loader Discord - Very cool people and devs helped me find lib issues, ty.

> The Mods - Lithium, VMP *(Very Many Players)*, FerriteCore, Krypton, ViaFabric, Starlight, qfapi *(fabric library implementation and Quilt library from Quilt)*, Fabrictailor *(to change skins, do /skin)*, Clumps, C2ME.

> Sukiru - they're like a java dev or something, they were useful with answering my very urgent and serious questions.

# Steps to Install

### ⚠️ This guide assumes you are runnning a supported operating system in termux. If not, you can download AnLinux to install a supported distro. ⚠️
*p.s As long as you are on a supported operating system, this script should work, even if you're not on Termux. I Will update this repository accordingly if a new mc version comes out, and I will also update the mods and things from time to time. Ofcourse you can do this yourself, and I would reccomend to aswell, but you wont die if you dont so don't sweat.*

**Currently supported distros; Fedora, Debian, Ubuntu, Arch Linux, Manjaro, Alpine Linux, and anything else that has the package manager found in these core distros.**

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
---------------------------------------------------------------------------------------------------------------------------------------

## Install (run in order, do this to update your server whenever I make a new update.)
`git clone https://github.com/Theslees/termux-Optimized-MC-Java-server mc && cd mc`

`chmod +x one-time-install.sh`

*With or without root;*

`./one-time-install.sh`

---------------------------------------------------------------------------------------------------------------------------------------
**Conclusion; After finishing the setup and script, you should be able to run "mc" in your terminal to start the server anytime you want. to connect to your server, you can go to your phone's Wifi Settings, and click on your connection to see more details about it. There you find your ip address, which u use to connect to your mc server. (should look something like 192.168.0.XX.) if u need to contact me in any way,, my discord is Theslees#1162. Enjoy~**

###### i am not responsible for batteries frying or anything that may happen. You are doing this on your own will, and you are aware of the Risks that come with putting your phone through this.

## Windows Setup
wip

# To do
- Add Windows support
- Geyser support
- ~~More Distros~~
- ~~Use functions to make it easier to read ig~~
