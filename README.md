# termux-Optimized-MC-Java-server
This is a simple script (originally designed for Termux) that will automatically install and configure a vanilla-optimized Quilt server for Minecraft Java (and in the future hopefully, Bedrock.)
This is the most __up-to-date__ script to setup the most optimized MC Server out there, afaik.
You can add any Fabric or Quilt mod you want.

### I have an example of this running on my own android device; a Modded Survival experience. You can take a peak of its performance by joining; `androidmc.tplinkdns.com` !!

----------------------------------------------------------------------
## Thanks to these things/people that made it possible !
> MC v1.19.2 - Synced server package manifest to client, updating the Netty framework

> Quilt Mod Loader - Best solution for hosting MC servers imo (That isn't enterprise, proprietary, or designed for specific things.)

> Quilt Mod Loader Discord - Very cool people and devs helped me find compalibility issues, ty.

> The Mods - Lithium, VMP *(Very Many Players)*, FerriteCore, Krypton, ViaFabric, ViaBackwards, ViaRewind, Starlight, qfapi *(fabric library implementation and Quilt library from Quilt)*, Fabrictailor *(to change skins, do /skin)*, Clumps, C2ME.

> Sukiru - they're like a java dev or something, they were useful with answering my very urgent and serious questions.

------------------------------------------------------------------
# Steps to Install

### ⚠️ This guide assumes you are runnning a supported operating system.  ⚠️
Feedback is appriciated, my discord is Theslees#1162 if you need to reach out.
Please check if your system is compatible with this script before running it;

### ***Currently supported os; Fedora-based, Debian-based, Arch Linux-based, Alpine-based, Termux.***

-----------------------------------------------------------------
## Setup
Termux, Debian, or Debian-based;

`apt update && apt install git`

Arch or Arch-based;

`pacman -Syy git`

Fedora or Fedora-based;

`dnf upgrade && dnf install git`

Alpine or Alpine-based;

`apk update && apk add git`

## Install

*you can run this command in any directory u want, creating a folder with your brand new server in that directory*

`git clone https://github.com/Theslees/termux-Optimized-MC-Java-server mc && cd mc && chmod +x one-time-install.sh`

*Execute With or Without root, up to preference!~*

`./one-time-install.sh`

## Update

*run with your terminal open in the server instance's folder.*
*⚠️ Make sure to back up modified configs since it may overwrite them. ⚠️*
`git fetch -q`

---------------------------------------------------------------------------------------------------------------------------------------
**Conclusion; After finishing the setup and script, you should be able to run "mc" in your terminal to start the server anytime you want. to connect to your server.**
**(TERMUX USERS; you can go to your phone's Wifi Settings, and click on your connection to see more details about it. There you find your ip address, which u use to connect to your mc server. should look something like 192.168.0.XX.)**

###### TERMUX WARNING; i am not responsible for batteries frying or anything that may happen. You are doing this on your own will, and you are aware of the Risks that come with putting your phone through this.

## Windows Setup
wip (soon)

# To do
- Add Windows support
- Geyser support
- ~~More Distros~~
- ~~Use functions to make it easier to read ig~~
- ~~Native Termux Support (remove the need for AnLinux.)~~
