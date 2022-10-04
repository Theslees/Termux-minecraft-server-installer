# termux-Optimized-MC-Java-server
This is a simple script that will automatically install and configure an extremely optimized vanilla-experience server for Minecraft Java Edition, Powered by the Quilt Mod Loader! This is the best script to automatically get the most optimized MC Server out there as far as I know. You can add any Fabric or Quilt mod you want. Termux supported.

----------------------------------------------------------------------
## Thanks to these things/people that made it possible !
> MC v1.19.2 - Synced server package manifest to client, updating the framework Netty

> Quilt Mod Loader - Best solution for hosting MC servers imo (That isn't enterprise, proprietary and designed for specific things.)

> Quilt Mod Loader Discord - Very cool people and devs helped me find lib issues, ty.

> The Mods - Lithium, VMP *(Very Many Players)*, FerriteCore, Krypton, ViaFabric, Starlight, qfapi *(fabric library implementation and Quilt library from Quilt)*, Fabrictailor *(to change skins, do /skin)*, Clumps, C2ME.

> Sukiru - they're like a java dev or something, they were useful with answering my very urgent and serious questions.

------------------------------------------------------------------
# Steps to Install

### ⚠️ This guide assumes you are runnning a supported operating system.  ⚠️
Please check if your system is compatible with this script before trying it, I will be updating this repository accordingly whenever a new mc version comes out or something.

### ***Currently supported os; Windows 10.0=<, Fedora-based, Debian-based, Arch Linux-based, Alpine-based, and Termux***

-----------------------------------------------------------------
## Setup (linux)
Debian-based

`apt update && apt install git`

Arch-based

`pacman -Syy git`

Fedora

`dnf upgrade && dnf install git`

Alpine

`apk update && apk add git`

Termux

`apt update && apt install git`

## Install (linux) (run this to update your server whenever I make a new update.)

*you can run this single command in any directory u want to create a folder with a brand new server in that directory!*

`git clone https://github.com/Theslees/termux-Optimized-MC-Java-server mc && cd mc && chmod +x one-time-install.sh`

*Execute With or Without root, up to preference;*

`./one-time-install.sh`

## Update

*Update your server, run with your terminal open in the server instance's folder.*

`git fetch` 

---------------------------------------------------------------------------------------------------------------------------------------
**Conclusion; After finishing the setup and script, you should be able to run "mc" in your terminal to start the server anytime you want. to connect to your server. (TERMUX USERS; you can go to your phone's Wifi Settings, and click on your connection to see more details about it. There you find your ip address, which u use to connect to your mc server. should look something like 192.168.0.XX.)**

If u need to contact me in any way, my discord is Theslees#1162.

###### TERMUX WARNING; i am not responsible for batteries frying or anything that may happen. You are doing this on your own will, and you are aware of the Risks that come with putting your phone through this.

## Windows Setup
wip

# To do
- Add Windows support
- Geyser support
- ~~More Distros~~
- ~~Use functions to make it easier to read ig~~
- Native Termux Support (remove the need for AnLinux.)
