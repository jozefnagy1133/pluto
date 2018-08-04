**_IMPORTANT: pluto is not recommended for daily use because it is still in development stage._**

# About "pluto"
Pluto is just a normal OS. We hope that it will be secure, stable and light-weight Operating System.
Currently, pluto is in development stage, so it does not do anything much.

# How to make a bootable CD-ROM?
It is actually pretty easy:

Requirements:
  - Computer
  - CD-R or CD-RW
  - Burning software of your choice

> Download the ISO file from this GitHub repository.

> Burn the downloaded ISO file to CD-R or CD-RW.

**NOTE: When burning the ISO to disc, be sure it is written as an image file. Writing to the disc as another type of data will not work and render the Installation CD _unbootable_. Look for an option similar to "Burn from ISO" or "Write disk image".**

# How to install pluto?
Pluto goes through three stages during setup. The first two stages deal with the installation of the system, while the third stage is the first usable boot by the user.
 - FIRST STAGE  - Text mode setup (Started when booting from a pluto CD-ROM)
 - SECOND STAGE - Booting to GUI installer (Input of user information and registering of files)
 - THIRD STAGE  - Booting to desktop (User configurations)
 
## Real Hardware
 - Make sure your BIOS is configured to boot from the CD-ROM first.
 - Insert the pluto setup CD-ROM into a CD-ROM drive and reboot your computer. On the next boot, the pluto setup utility will start.
 - Follow the instructions on the screen to install pluto on your computer.
 - After the installation has finished, remove the setup CD-ROM from the CD-ROM drive and press _Enter_ to reboot your computer. You can now start pluto by selecting it from the boot menu.
 
 ## Real hardware without CD Drive
  - Create a virtual Machine but without the Harddisk
  - Create a virtual Harddisk for Virtualbox wich points to the real one.
    - On Linux: VBoxManage internalcommands createrawvmdk -filename "~/VirtualBox VMs/pluto/disk.vmdk" -rawdisk PathToHarddisk
    - **IMPORTANT: PathToHarddisk must be the whole disk, not a partition: /dev/sdb**
  - Add disk.vmdk to virtual Machine via Storage -> Add Harddisk
  - Install pluto as usual
  
## USB Installation
  - Due to problems with the USB stack it is **_NOT_** currently possible to install pluto from a USB stick or USB CD-ROM, the setup process will fail partway through.
  
## Virtual Machines
A Virtual Machine is a software program that provides a virtual hardware platform. Software instructions that would be run on hardware are now interpreted by the emulator software. This allows you to "run" a different kind of computer hardware and its software in a window on your computer.

[VirtualBox](https://www.virtualbox.org) is a great Virtual Machine software.
