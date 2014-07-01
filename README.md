# Description

A collection of software from Linux Deepin that ported to Archlinux,
you could find them in
[AUR](https://aur.archlinux.org/packages/?O=0&C=0&SeB=nd&K=deepin&outdated=&SB=n&SO=a&PP=50&do_Search=Go),

And now, thanks @metak's great job, we could install all them more easily
through his OBS repository, just add following code to
/etc/pacman.conf

    [home_metakcahura_arch-deepin_Arch_Extra]
    SigLevel = Never
    Server = http://download.opensuse.org/repositories/home:/metakcahura:/arch-deepin/Arch_Extra/$arch

Then
    
    sudo pacman -Sy deepin
  
More information to see the [topic](https://bbs.archlinux.org/viewtopic.php?id=181861).

# Launch DDE
  We can use either lightdm or xinit to launch DDE, if use xinit,
  specific configuration is as follows:
  
  1. Add the following code to `$HOME/.xinitrc`
  
     exec startdde
        
  2. run xinit in tty to enter DDE
  
  
  *Notice: this is still a testing version, if desktop blocked for
   issues, just kill startdde in another tty, :-)*
  
# Troubleshooting
  - Why network in deepin-control-center not working?
  
    LinuxDeepin manage network through NetworkManager, so don't
    forget to start it,
     
        sudo systemctl start NetworkManager
     
    And if you want to experience DDE for a long time, use
    NetworkManager instead of netctl is a better choice,
     
        sudo systemctl stop netctl
        sudo systemctl disable netctl
        sudo systemctl stop netctl@ethernetdhcp
        sudo systemctl disable netctl@ethernetdhcp
        sudo systemctl enable NetworkManager
        sudo systemctl start  NetworkManager
        sudo systemctl enable ModemManager
        sudo systemctl start ModemManager

# Screenshot

<img src="./screenshot/dde_2014_01.png"
width=500/>

<img src="./screenshot/dde_2014_02.png"
width=500/>

<img src="./screenshot/dde_2014_03.png"
width=500/>

<img src="./screenshot/dde_2014_04.png"
width=500/>

# License

GNU General Public License, Version 3.0
