# termux-Optimized-MC-Java-server
This is a simple script that will automatically install and configure a optimized vanilla-experience server for Minecraft Java Edition. Powered by the Quilt Mod Loader! 

## Thanks to these things/people that made it possible !
> MC 1.19.2 - Synced server package manifest to client, updating the network framework Netty

> Quilt Mod Loader - Best solution for hosting MC servers imo. (That isn't enterprise, proprietary and specifically designed for certain things.)

> The Mods - Lithium, VMP *(Very Many Players)*, FerriteCore, Krypton, ViaFabric, Starlight, qfapi *(fabric library implementation from Quilt)*, Fabrictailor *(to change skins, do /skin)*, Clumps, C2ME.

> Sukiru - they're like a java dev as a job or something idk, they were useful nontheless with answering questions.
*Will update this repository accordingly if a new mc version comes out, and I will also update the mods time to time, but it's good that You also take this responsibility yourself. Feel free to open issues and whatnot too :)*
# Steps to Install

### ⚠️ This guide assumes you are runnning a Debian based operating system in termux. If not, you can download AnLinux which allows u to install a linux distro of your choosing to Termux. ⚠️
This guide also assumes ur installation is __barebones__, right after installing a distro from AnLinux. To paint the image; AnLinux doesn't even install sudo, or setup any users for you besides root. This is fine if you don't value security. 
If you need help with anything, my discord is below.

> notice; This has not been tested with any other Linux Distros, so feedback is appriciated!! My discord is Theslees#1162. I want to make this script compatible with anything Linux, not only Termux. Though you're on you're own if your enviroment isn't exactly as I described.

Anyways, enough talking!

### Setup
`apt-get install git`

### Cmds (run in order)
`git clone https://github.com/Theslees/termux-Optimized-MC-Java-server`

`mv termux-Optimized-MC-Java-server mc`

`cd mc`

`./one-time-install.sh`

