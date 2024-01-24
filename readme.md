# summary

This repository aims to assist anyone attempting to install and configure/optimize Microsoft Windows. Through automation via PowerShell & Winget, as well as other third party tools; you can greatly decrease the time required to install and configure/optimize Windows. Maybe most noteably, if you follow the instructions properly you will never have to manually update 90% of your apps again. They will update automatically via Winget Auto Update. I've provided convenient linked lists for popular applications that fall out of winget's domain. As well as linked lists for many common drivers.

# table of contents

- [steps](#steps)
  1.  [update & configure your motherboard's bios](#update--configure-your-motherboards-bios)
  2.  [purchase/obtain a `windows 11 pro for workstations` product key](#purchaseobtain-a-windows-11-pro-for-workstations-product-key)
  3.  [create a bootable flash drive & install windows](#create-a-bootable-flash-drive--install-windows)
  4.  [verify that windows is activated](#verify-that-windows-is-activated)
  5.  [update windows](#update-windows)
  6.  [update microsoft store apps](#update-microsoft-store-apps)
  7.  [install powershell 7 & git](#install-powershell-7--git)
  8.  [configure windows terminal](#configure-windows-terminal)
  9.  [download, configure, & run bulk-edit-settings powershell script](#download-configure--run-bulk-edit-settings-powershell-script)
  10. [manually configure other windows settings](#manually-configure-other-windows-settings)
  11. [download/install system drivers](#downloadinstall-system-drivers)
  12. [wigui - install winget auto update & bulk install applications](#wigui---install-winget-auto-update--bulk-install-applications)
      - [wigui preface](#wigui-preface)
      - [populate wigui lists](#populate-wigui-lists)
      - [install winget auto update](#install-winget-auto-update)
      - [bulk install applications](#bulk-install-applications)
  13. [configure msi afterburner (gpu fan curve)](#configure-msi-afterburner-gpu-fan-curve)
  14. [verify that system temperatures are in-check](#verify-that-system-temperatures-are-in-check)
      - [cpu & gpu](#cpu--gpu)
      - [m.2 drives](#m2-drives)
  15. [download/install remaining software](#downloadinstall-remaining-software)
  16. [configure audio settings](#configure-audio-settings)
  17. [configure rgb lighting](#configure-rgb-lighting)
- [drivers](#drivers)
  - [drivers preface](#drivers-preface)
  - [motherboard specific drivers](#motherboard-specific-drivers)
  - [intel](#intel)
  - [amd cpu/chipset & gpu](#amd-cpuchipset--gpu)
  - [nvidia](#nvidia)
  - [other drivers](#other-drivers)
- [winget basics](#winget-basics)
  - [winget preface](#winget-preface)
  - [searching for apps](#searching-for-apps)
  - [install apps](#installing-apps)
  - [updating apps](#updating-apps)
  - [uninstalling apps](#uninstalling-apps)
- [software](#software)
  - [**wsl** (windows subsystem for linux)](#wsl-windows-subsystem-for-linux)
  - [microsoft store](#microsoft-store)
  - [old-school](#old-school)
- [troubleshooting](#troubleshooting)
  - [troubleshooting bootloop / boot problems](#troubleshooting-bootloop--boot-problems)
  - [troubleshooting failed windows activation](#troubleshooting-failed-windows-activation)
  - [troubleshooting high temperatures](#troubleshooting-high-temperatures)
- [bulk edit settings configuration](#bulk-edit-settings-configuration)
  - [setting descriptions](#setting-descriptions)
  - [config.json example](#configjson-example)
- [wigui lists](#wigui-lists)
  - [update blacklist](#update-blacklist)
  - [admin install list](#admin-install-list)
  - [standard install list](#standard-install-list)

# steps

1. ### update & configure your motherboard's bios
   - attach any usb flash drive to your computer
   - format your flash drive as fat32
     - if your flash drive is over 32GB you will need to use [this tool](http://ridgecrop.co.uk/index.htm?guiformat.htm)
     - Otherwise, just follow [this tutorial](https://www.asus.com/support/FAQ/1044735/).
   - Take note of your motherboard's model number, should be listed on the box it came in, or via an online order.
   - search for your motherboard via it's model number on google & download the latest bios file from your motherboard's support page
   - copy the bios file to the flash drive
   - enter bios (mash [delete] key while computer is restarting)
   - verify that cpu temp isn't anything crazy
     - should be on bios home page
     - should be sub 60c
     - if temps are higher than this see [troubleshooting high temperatures](#troubleshooting-high-temperatures)
   - undergo the bios update process ([tutorial](https://www.youtube.com/watch?v=n6ZAMrjRudg) | should be similar for most motherboards)
   - enable x.m.p ([tutorial](https://www.youtube.com/watch?v=qCnGQPlY6pE) | should be similar for most motherboards)
     - if computer no longer boots or bootloops after enabling x.m.p see [troubleshooting bootloop / boot problems](#troubleshooting-bootloop--boot-problems)
   - set fan curves in bios if desired ([tutorial](https://www.youtube.com/watch?v=ZoWlNIzOO0E) | should be similar for most motherboards)
2. ### purchase/obtain a `windows 11 pro for workstations` product key
   - buy keys [here](https://wholsalekeys.com/shop/windows-11-pro-for-workstations/)
   - if you have a business grade microsoft account for work you may be able to obtain a key for free [here](https://my.visualstudio.com/Downloads?q=Windows%2011)
     - _you will need to login with your work/business email before this link will direct you to the proper place_
3. ### create a bootable flash drive & install windows
   - attach an 8gb+ flash drive to your computer
   - download & install [rufus](https://rufus.ie/en/)
   - use rufus to download & mount the windows 11 iso to your flash drive ([tutorial](https://pureinfotech.com/rufus-create-bootable-windows-11-usb/))
   - Before starting the windows setup process, please have your aformentioned windows 11 pro for workstations product key ready.
   - If you don't have a product key yet you might be able to manually select windows 11 pro for workstations as the target operating system. But I've come accross times where "for workstations" isn't in the operating system list.
   - undergo the windows setup process ([tutorial](https://youtu.be/mTDbHgs9dHk?si=hBSuKpeqPmHCfUP6&t=117) | start video at 1:57)
4. ### verify that windows is activated
   - open settings & navigate to `system > activation`
   - If it says activation failed don't panic, see [troubleshooting failed windows activation](#troubleshooting-failed-windows-activation).
5. ### update windows
   - open windows settings & navigate to `windows updates`
   - optionally - toggle "Get the latest updates as soon asy they're available"; I personally suggest doing this.
   - check for updates & wait for them to download/install
   - **restart your computer**
   - check for updates again
   - If you have more updates and pc requests restarting again, do so.
   - repeat until windows states that everything is up-to-date
6. ### update microsoft store apps
   - open the microsoft store via your start menu
   - click the "library" button in the bottom left hand corner of the window
   - select "get updates" in the top right hand corner of the window
   - wait until all updates have been retreived, should be a little loading symbol to reference
   - select "update all" just left of the "get updates" button
   - wait for all microsoft store applications to update before proceeding to step 7
7. ### install powershell 7 & git
   - right click start button on taskbar & select "Terminal (Admin)"
   - run the following command
     - ```powershell
       winget install jazzdelightsme.WingetPathUpdater microsoft.powershell git.git
       ```
8. ### configure windows terminal
   - restart windows terminal
   - open windows terminal settings (dropdown near tabs) & set your default profile as powershell 7 (darker blue powershell)
   - select the powershell 7 profile in the left hand menu & enable "run this profile as administrator"
9. ### download, configure, & run `bulk-edit-settings` powershell script
   - restart windows terminal
   - run the following commands
     - ```powershell
       new-item -path "/repos" -itemtype "directory"`
       cd /repos
       git clone https://github.com/ninbura/windows
       new-item -path "/repos/windows/config.json" -itemtype "file"
       ```
   - open `/repos/windows/config.json` in desired text editor
   - see [bulk edit settings configuration](#bulk-edit-settings-configuration) for instructions as how to configure your `config.json` file
   - save and close `config.json`
   - right click `/repos/windows/run-me.bat` & select "run as administrator"
   - Wait for the script to finish running, then **restart your computer**.
   - ### some notes
     - It's advandtageous to maintain and backup your `config.json` file somewhere, so you can easily load it in the future.
     - I will likely update the preconfigured `config.json` example, as well as add more options in the future. Revisit this repository every so often to get the latest enhancements.
     - To update the `bulk-edit-settings.ps1` script to handle said new options, you simply need to `pull` the repository in its existing location on your pc using git.
       - `cd /repos/windows`
       - `git pull`
10. ### manually configure other windows settings
    - theme settings
      - navigate to `personalization > colors`
      - change "choose your mode" to dark
      - set desired accent color
    - display settings
      - navigate to `system > display`
      - order displays as desired
      - select main display
      - open "multiple displays" dropdown
        - check "make this my main display"
      - scroll to bottom of list & select "advanced display"
        - generally set refresh rate to max for each monitor
    - network settings
      - navigate to `network & internet > advanced network settings > advanced sharing settings`
      - expand "all networks" drop down
      - enable "public folder sharing"
      - enable "password protected sharing"
    - Configure other system settings you'd like which weren't included in the above list or the `bulk-edit-settings` powershell script.
11. ### download/install system drivers
    - see [drivers](#drivers) list below
    - Note that every driver you need may not be listed below, said list is composed of items relevant to me and my direct peers.
    - you don't need to restart your computer when prompted after every single driver
    - restart your computer after installing all drivers
12. ### wigui - install winget auto update & bulk install applications
    - #### wigui preface
      - wigui is a an application that
        - uses winget (cli application tool) in the background via a user interface
        - Installs winget auto update. Once winget auto updated is installed it'll keep most applications installed via wigui/winget automatically updated.
    - #### populate wigui lists
      - After running `bulk-edit-settings.ps1` as part of [step #9]((#download-configure--run-bulk-edit-settings-powershell-script)), a folder should have been created in `/repos/windows` called `wigui-lists`.
      - contained within `/repos/windows/wigui-lists` there should be 3 `.txt` list files
        1. `admin-install-list.txt`
        2. `standard-install-list.txt`
        3. `update-blacklist.txt`
      - populate update blacklist
        - open `update-blacklist.txt`
        - paste the list found [here](#update-blacklist) into the file
        - save the file & close it if you please
        - you want to blacklist apps that consistently fail to update via winget-autoupdate
        - note that once loaded, you need to modify the following file to add applications to your currently active blacklist
          - `C:\ProgramData\Winget-AutoUpdate\excluded_apps.txt`
      - populate install lists
        - Open `admin-install-list.txt` & `standard-install-list.txt`, and paste the lists found in [admin install list](#admin-install-list) & [standard install list](#standard-install-list) into each file respectively.
        - Add and remove applications from these lists as you see fit, then save the files, and close them if you please.
          - see [winget basics](#wingetwigui-basics) for more details on this step
          - do not remove the following applications from your install list for the sake of later steps in this tutorial
            - `FinalWire.AIDA64.Extreme`
            - `Guru3D.Afterburner`
            - `REALiX.HWiNFO`
      - It can be a chore, but I recommend you maintain each of these lists and back them up somewhere for future use.
    - #### install winget auto update
      - run the following command in PowerShell
        - `winget install Romanitho.WiGUI --location documents`
      - navigate to your documents folder and run the WiGui `.exe` (double click)
        - If you're prompted to update WiGui, do so.
        - after the update is complete there should be a new WiGui exe with a later version number
        - you may delete the original WiGui `.exe` after updating
        - Once you've got this sorted, run the latest/new WiGui `.exe` file by double clicking it.
      - click on the "configure wau" tab (wau = winget-autoupdate)
      - Reference image below for configuration on this tab, don't forget to load your previously created blacklist.
      - ![image](https://github.com/ninbura/windows/assets/58058942/e84ff19d-d0ab-4bc3-895d-b48b5f9304db)
      - **restart your computer**
    - #### bulk install applications
      - wait for winget-autoupdate to finish updating existing packages (wait until you're no longer receiving notifcations from wigui)
      - Before you can bulk install applications, you need to enable a setting in winget.
      - open windows terminal & run the following command
        - ```powershell
          winget settings --enable InstallerHashOverride
          ```
        - Note that this command must be run in an elevated instance of PowerShell. If you followed [step #8](#configure-windows-terminal) correctly, when you open Windows Terminal it should open an admin elevated instance of PowerShell 7 by default.
      - installing admin install list applications
        - right click the WiGui exe & select "Run as administrator"
        - click the "Import from file" button & select your `admin-install-list.txt`
        - click "Install"
        - wait for the process to finish & close WiGui
      - installing standard install list applications
        - double click the WiGui exe
        - click the "Import from file" button & select your `standard-install-list.txt`
        - click "Install"
        - wait for the process to finish & close WiGui
      - **restart your computer**
13. ### configure msi afterburner (gpu fan curve)
    - _this is not applicable if your gpu is water cooled_
    - This program should have been installed via wigui, just search for it in start and open it.
    - open settings (should be a button on the left hand side)
    - enable startup at launch
      - click on the "general" tab
      - check "start with windows"
      - check "start minimized"
      - hit "apply"
    - enable msi afterburners fan curve
      - click on the "fan" tab
      - check "enable user defined software automatic fan control"
        - Leaving the fan curve in its default state is fine, but feel free to create your own curve if you want.
      - hit "apply"
    - hit "ok" to close settings dialog
    - minimize msi afterburner
14. ### verify that system temperatures are in-check
    - #### cpu & gpu
      - temps are model dependent
      - higher end components run hotter than lower end components
      - lower temp is better but as long as things are generally within listed ranges you should be fine
      - open HWiNFO (installed via wigui, search start)
        - select "show sensors"
        - cpu & gpu idle temp should be >60c
      - open Aida64 Extreme (installed via wigui, search start)
        - confirm you're okay with app being in trial mode
        - open system stability test dialog `tools > system stability test`
        - enable everything except "local disks"
        - run test for 5-15 minutes
        - to prevent throttling your
          - cpu load temp should be >=99c
          - gpu load temp should be >=84c
      - Even high-end cooling, modern amd & intel cpus can easily reach 100c.
      - While this is technically safe because they'll throttle, you won't get maximum performance unless you stay below 100c.
      - there are all in one water coolers large enough to prevent even the highest end CPUs from throttling
      - I suggest Artic's "liquid freezer line"
        - 360/420mm for intel i7 & AMD x700
        - 420mm for intel i9 & AMD X900
      - for i5 cpus & below I suggest purchasing the **thermalright peerless assassin** air cooler
      - if temps for cpu or gpu are high per numbers above see [troubleshooting high temperatures](#troubleshooting-high-temperatures)
    - #### m.2 drives
      - download/install [crystaldiskinfo & crystaldiskmark](https://crystalmark.info/en/software)
        - hard drive monitor & benchmark
        - get "Shizuku" edition for a good time ☺️
      - open crystaldiskinfo (search start)
        - verify that m.2 idle temp is below 60c
        - verify that m.2 drive health is "good"
        - consider replacing your hard drive if health is poor
      - open crystaldiskmark and hit the giant "all" button
        - verify that drive temp remains under 65c via crystaldiskinfo during benchmark
      - if you see your m.2 temperatures go above 65c during the benchamrk see [troubleshooting high temperatures](#troubleshooting-high-temperatures)
15. ### download/install remaining software
    - see [software](#software) section below
    - just like drivers you don't need to restart your computer when prompted after every single install
    - restart your computer after installing all desired software (if you were prompted at somepoint to do so)
    - Note that every piece of software you want may not have been included in your install list, and or may not be listed in the [software](#software) section below. Said lists are composed of items relevant to me and my direct peers.
    - software in the [software](#software) section below is software that can not currently be installed properly via wigui
    - It is _always_ preferred you install software with winget, it's much quicker & winget-autoupdate will keep your software updated.
      - see [winget basics](#winget-basics) for instructions on how to use winget
    - If software isn't available via winget, install software the old fashioned way 😭
16. ### configure audio settings
    - open control panel & navigate to `hardware & sound > sound`
    - verify you're on the "playback" tab
      - right click any device that you wont be using & select "disable" (repeat for all unused devices)
      - right click any device and uncheck "show disabled devices" (re-enable as needed for troubleshooting and stuff)
      - if you only have one usable/desired output device
        - select desired device & click the "set default" button below the device list
      - if you have a fancy pants audio mixer or what have you with multiple usable output devices
        - right click which audio output you want as your default output device & select "set as default device"
        - right click which audio output you want as your communication device & select "set as default comunication device"
    - click on "recording" tab
      - right click any device that you wont be using & select "disable" (repeat for all unused devices)
      - right click any device and uncheck "show disabled devices" (re-enable as needed for troubleshooting and such)
      - select desired device & click the "set default" button below the device list
    - repeat these steps any time you encounter **_(😔((((audio problems))))😔)_**
17. ### configure rgb lighting
    - this is a very inconsistent process not only by motherboard but often by sepcific components
    - often times your motherboard will have a single piece of software that allows for configuring all rgb
    - other times you need a specific program for a specific component
      - For exmaple, pny gpus use dedicated software, motherboard can't configure many pny gpus lighting.
    - It's really such a mixed bag that you'll just have to start by referencing / installing your motherboards rgb control software, and then work from there.
    - For each component that can't be controlled via this software, google the exact component in question + "rgb control" & pray that you find competent instructions online.

# drivers

### drivers preface

- please read [download/install drivers from the drivers list below](#downloadinstall-drivers-from-the-drivers-list-below)
- Some drivers will need be downloaded from your motherboard's support page, others are typically universal. If your motherboard uses intel drivers for bluetooth, lan (ethernet), & wan (wifi) you can use the links below to get the latest versions. To verify that your motherboard uses universal intel drivers, you'll need to go to your motherboards support page.
- Take note of your motherboard's model number, should be listed on the box it came in.
- search for your motherboard via it's model number on google & locate the support page

### motherboard specific drivers

- look for the following drivers on your motherboard's support/driver page
- audio drivers
  - usually labeled as realtek
  - only grab latest version, don't need mulitple motherboard audio drivers
- intel chipset drivers (intel cpus only)
  - there may be multiple "chipset" style drivers
  - look for drivers titled as so
    - intel serial i/o
    - intel management engine
    - intel me
    - intel mei
    - intel inf
    - intel hid
  - you should see one or many of the aformentioned intel chipset drivers
- communication drivers
  - notes
    - If your motherboards support/driver page states that the following drivers are Intel drivers; see below in the Intel section for the latest Intel communication drivers, as opposed to downloading the outdated ones on your motherboards support/driver page.
    - Should go without saying but... if your motherboard doesn't have bluetooth or wifi capabilities, you aren't going to see drivers listed for them.
  - drivers
    - bluetooth
    - lan (ethernet / wired internet driver)
    - wan (wifi driver)
- sata drivers
  - only required if you're using sata based storage
  - typically labeled as "Intel Rapid Storage Technology" or "AMD SATA"

### intel

- check motherboard page to make sure your motherboard uses intel for these devices
- [bluetooth](https://www.intel.com/content/www/us/en/support/articles/000005489/wireless.html)
- [lan](https://www.intel.com/content/www/us/en/download/727998/intel-network-adapter-driver-for-microsoft-windows-11.html)
- [wan](https://www.intel.com/content/www/us/en/download/19351/windows-10-and-windows-11-wi-fi-drivers-for-intel-wireless-adapters.html)
- [graphics](https://www.intel.com/content/www/us/en/download/785597/intel-arc-iris-xe-graphics-windows.html)

### [amd cpu/chipset & gpu](https://www.amd.com/en/support)

- I would uncheck installing amd's powerplan when installing AMD chipset/cpu drivers
- you'll also want to select the "clean install" option when installing AMD gpu drivers.

### [nvidia](https://www.nvidia.com/download/index.aspx)

- _Click buttons on nvidia driver page slowly, if you move too fast you will get ip banned!_
- always select **custom install** and then **clean install**
- open nvidia control panel ([shift+right click] desktop)
  - select "manage 3d settings" in left hand side menu
    - set "power management mode" to "prefer maximum performance"
  - select "change resolution" in left hand side menu & verify that all monitors are
    - set to the correct resolution & refresh rate
    - set to full rgb color mode
    - If color mode is partial and greyed out; override settings with "use nvidia color settings".
- after driver install it's likely that your windows audio settings got borked (see [configure audio settings](#configure-audio-settings) for fix)

### other drivers

- [silabs 3.9.2](https://hdfury.com/product/integral-2/) (hdfury integral 2)
  - must be installed via **admin elevated** terminal
  - `start-process -path [releativepath]/Silabs_Driver_v3/Silabs_Driver_v3/USBXpressInstaller.exe`
- [magewell pro capture](https://www.magewell.com/downloads/pro-capture) (magewell capture pro cards)
- [rme drivers](https://www.rme-usa.com/downloads.html) (rme audio interfaces)
- [tx401](https://www.tp-link.com/us/support/download/tx401/) (10g ethernet pcie card)

# winget basics

### winget preface

- You can call winget in cmd, powershell, and powershell 7 terminals. I would recommend installing and using powershell 7 as it is the most modern shell for Windows. If you don't already have powershell 7 you can install it using winget in powershell. If you've followed the steps higher up in this readme you would have already done that 😅
- wigui, which we use earlier in this guide, is just a winget with a user interface.
- Some applications aren't compatible with wigui for one reason or another, so you have to interact with those apps manually with winget.
- Appliations installed with winget or wigui will automatically update so long as you installed winget auto update via wigui as explained earlier in the tutorial. Note that some apps won't update properly through winget auto update, and that's why they've landed a spot on the update black list at the bottom of this readme.

### searching for apps

- to search for applications you can install with winget you use the `search` keyword
  - `winget search [app name]`
- search exmaples
  - `winget search chrome`
  - `winget search discord`
  - `winget search steam`
- once you've found the disired app take note of or copy its `id`
- id examples
  - `Google.GoogleChrome`
  - `Discord.Discord`
  - `Valve.Steam`

### installing apps

- to install applications using winget you use the `install` keyword
  - `winget install [app id]`
  - you can technically use the `name` of an application instead of the `id`. But things get complicated with spaces in app names, so I wouldn't recommend it.
- install examples
  - `winget install Google.GoogleChrome`
  - `winget install Discord.Discord`
  - `winget install Valve.Steam`
- When installing applications with winget, some applications will need to be installed in an elevated terminal, while others you can / should install in an non-elevated terminal.
  - elevated = run as administrator
- While it's not always needed, there are some useful flags you can tack onto then end of `winget install` commands.
  - `--ignore-security-hash`
    - before using this flag you must first run `winget settings --enable InstallerHashOverride` in an elevated console
    - ignores an apps "security hash"
    - Sometimes a app developer's application building pipeline erros on the winget step, so the hash is not updated.
    - You can tell winget that you don't care that the hash doesn't match, and install the application anyways.
    - Note that this is techinically a security risk as someone could hijack a developer's pipeline and inject their own application.
    - I use it all the time 😅
  - `--force`
    - Sometimes winget refuses to install an app because it thinks it's already installed, or it thinks a newer version is installed. Sometimes this is true, sometimes it's not.
    - Using this flag bypasses issues like this, and forces winget to install the specified application.
    - Note that this will re-install an application 100% of the time, if it's already installed. So, backup your settings in an app you already have installed if you're going to use this flag.
- flag usage examples
  - `winget install Mozilla.Firefox.Nightly --ignore-security-hash`
  - `winget install Microsoft.DotNet.SDK.6 --force`
  - `winget install Microsoft.DotNet.SDK.7 --ignore-security-hash --force`

### updating apps

- Note that if you installed winget auto update via wigui earlier in the tutorial you don't have to worry about updating applications via winget manually. This applies to any application that _is not_ on your update blacklist. Those applications are typically blacklisted because they either update automatically via the app themselves, or there's a problem with updating them via winget auto update.
- to update applications using winget you use the `update` keyword
  - `winget update [app id]`
- update examples
  - `winget update Google.GoogleChrome`
  - `winget update Discord.Discord`
  - `winget update Valve.Steam`
- When updating applications with winget, some applications will need to be updated in an elevated terminal, while others you can / should update in an non-elevated terminal.
  - elevated = run as administrator

### uninstalling apps

- to uninstall applications using winget you use the `uninstall` keyword
  - `winget uninstall [app id]`
- uninstall examples
  - `winget uninstall Google.GoogleChrome`
  - `winget uninstall Discord.Discord`
  - `winget uninstall Valve.Steam`

# software

please read [download/install remaining software](#downloadinstall-remaining-software)

### **wsl** (windows subsystem for linux)

- run the following command in an **elevated** powershell console
  - ```powershell
    wsl --install
    ```
- **restart your computer**

### microsoft store

- [**Adobe Creative Cloud**](https://apps.microsoft.com/store/detail/XPDLPKWG9SW2WD?ocid=pdpshare) (photoshop, premiere, etc.)
- [**Cisco AnyConnect**](https://www.microsoft.com/store/productId/9WZDNCRDJ8LH?ocid=pdpshare) (vpn client)
- [**iCloud**](https://www.microsoft.com/store/productId/9PKTQ5699M62?ocid=pdpshare) (Apple's iCloud desktop application)
- **Crystaldiskinfo** (check disk hard drive health)
  - [Standard Edition](https://apps.microsoft.com/store/detail/XP8K4RGX25G3GM?ocid=pdpshare) (lame)
  - [Shizuku Edition](https://apps.microsoft.com/store/detail/XPFP35NT4K8RWK?ocid=pdpshare)
  - [Aoi Edition](https://apps.microsoft.com/store/detail/XPDNKFM52KNR94?ocid=pdpshare)
- **Crystaldiskmark** (test hard drive speed)
  - [Standard Edition](https://www.microsoft.com/store/productId/9NBLGGH4Z6F2?ocid=pdpshare) (lame)
  - [Shizuku Edition](https://www.microsoft.com/store/productId/9NBLGGH536CC?ocid=pdpshare)
- **WSA** (Windows Subsystem for Android)
  - install [Amazon Appstore](https://www.microsoft.com/store/productId/9NJHK44TTKSX?ocid=pdpshare) via the Microsoft Store
  - **restart your computer**
- [**Xbox Accessories**](https://www.microsoft.com/store/productId/9NBLGGH30XJ3?ocid=pdpshare) (tool for configuring Xbox controllers)

### old school

- [**Advanced Scene Switcher**](https://github.com/WarmUpTill/SceneSwitcher/releases) (obs plugin)
- [**Battlenet Launcher**](https://us.shop.battle.net/en-us) (blizzard's game launcher)
- [**Davinci Resolve**](https://www.blackmagicdesign.com/products/davinciresolve) (download link near the bottom of the page)
- [**EasyBCD**](https://neosmart.net/EasyBCD/) (tool for dual booting)
- [**FFXIV Launcher**](https://na.finalfantasyxiv.com/lodestone/playguide/#returner) (square enix's final fantasy 14 launcher)
- [**iReboot**](https://neosmart.net/iReboot/) (tool for dual booting)
- [**OBS ASIO**](https://github.com/Andersama/obs-asio/releases) (obs plugin)
- [**OBS Audio Monitor](https://obsproject.com/forum/resources/audio-monitor.1186/) (obs plugin)
- [**OBS NDI**](https://github.com/obs-ndi/obs-ndi/releases/tag/4.11.1) (obs plugin)
- [**Recitfy11**](https://rectify11.net/) (Windows 11 themeing tool)
- [**Rode Central**](https://rode.com/en-us/software/rode-central) (Rodecaster Pro II & Rodecaster Duo)
- [**Synergy 3**](https://symless.com/synergy/account-login?redirect=https%3A%2F%2Fsymless.com%2Fsynergy%2Fdownload) (tool for sharing single mouse & keyboard with multiple computers)
- [**VIA**](https://www.caniusevia.com/) (tool for configuring many keyboard models)
- [**VLC 4.0**](https://artifacts.videolan.org/vlc/nightly-win64/) (video player, plays all codecs including the new av1 codec)
- [**window-switcher**](https://github.com/sigoden/window-switcher/releases) (macOS style window switching for windows 11)
- [**Wootliltiy**](https://wooting.io/wootility) (software to configure wooting keyboards)

# troubleshooting

### troubleshooting bootloop / boot problems

- if computer is bootlooping
  - re-flash bios using advanced flashing utility
  - Consult motherboard manual for exact steps, should mention the word "flash" and describe a process for updating your bios without having access to the bios.
  - typically involves
    - putting bios file on flash drive
    - naming bios file something specific
    - putting usb stick in specific port
    - pressing a physical button on the motherboard / io panel or simply booting the pc once criteria is met
- if computer failed to boot into bios after enabling x.m.p and now you're stuck in "safe mode"
  - try setting ram clock at a lower clock
  - if setting the clock speed lower multiple time fails simply disable x.m.p
  - note that you want your ram to be at the highest possible clock for best performance
  - if ram is a reasonable speed (DDR5 5600-6800Mhz | DDR4 2600-3600) and can't achive x.m.p you should consider returning it for different ram
  - if new ram of similar speed has the same issues you may have a defective cpu or motherboard and will need to replace it

### troubleshooting failed windows activation

- verify that the activation key you entered matches the one you purchased/obtained earlier
- if key matches but windows still failed to activate you may need to activate by phone
  - there should be a button to do this via the `system > activation` screen
  - follow on-screen instructions
  - involves calling a number and answering prompts by voice and dial pad
  - I typically start spamming "represnetative" by voice to try to get to someone as soon as possible. But I believe you can only do this after stating that you're having trouble with activating windows.
- I've never had phone activiation fail, but if it did somehow you may have purchased a key that's already been used and will need to get a new one.

### troubleshooting high temperatures

- if your **_cpu_** temperatures are too high you
  - mounted your cpu cooler incorrectly
    - clean, re-paste, and re-seat the heatsink / water block
  - didn't plug in your fans / fans are defective & not running
  - Have your fan curve misconfigured, causing fans/pumps to not run (see fan curve [tutorial](https://www.youtube.com/watch?v=ZoWlNIzOO0E) | should be similar for most motherboards).
  - used an inadequate cpu cooler
  - have major airflow problems in your case
  - are running your pc in an overly hot environment (90f+)
  - have a motherboard that is misreporting temps (unlikely but happens)
  - have a defective cpu or cpu cooler and need to rma / exchange one or the other
- if your **_gpu_** temperatures are too high
  - verify that gpu fans are spinning
  - verify that nothing is too close to or obstructing gpu fans
  - verify that all other fans in case are working
  - set a more aggressive fan curve via msi afterburner
  - if temps are still too high your gpu's heatsink may have a poor factory mount, at which point you can
    - rma / exchange the gpu
    - clean, re-paste, and re-seat the heatsink ([tutorial](https://www.youtube.com/watch?v=n7NMeu0QiYk))
- if your **_m.2 ssd_** temperatures are too high you
  - didn't properly install your m.2 drive
  - need an aftermarket heatsink for your m.2 drive
  - need to install a fan pointing directly at your m.2 drive
  - have a defective drive and need to rma / exchange it

# bulk-edit-settings configuration

### setting descriptions

- #### administrative
  - `DisableUacPopups` [`true`/`false`] - removes the "are you sure" popup when you doing anything that requires admin privileges
- #### cursor
  - `DisableEnhancedPointerPrecision` [`true`/`false`] - Disables enhanced point precision, a must for gaming, but just good in all cases to be honest.
  - `DisableEaseCursorMovement` [`true`/`false`] - Disables "easing" cursor movement between displays. Easing feels super jank imo, it can make your cursor jump to an unnatural place when transitioning through displays.
- #### file explorer
  - `EnableCompactView` [`true`/`false`] - This removes a lot of dead space in file explorer, returning some of the way it looked/felt in windows 10.
  - `MoveRecycleBinToFileExplorer` [`true`/`false`] - This will remove the recycle bin shortcut from your desktop and pin it to the bottom of the left hand side menu of file explorer. It's still very accesible, and this keeps your desktop clean.
  - `ShowFileExtensionsForKnownFileTypes` [`true`/`false`] - This makes it so windows doesn't hide file extensions at the end of file names, super useful to see file extensions in many use cases.
  - `ShowFrequentlyUsedFoldersInQuickAccess` [`true`/`false`] - Supposed to make it so pinned folders show in the File Explorer Home, but kinda it's kind of bugged. May require interaction with the gui to get working properly.
  - `ShowHiddenFilesAndFolders` [`true`/`false`] - prevents windows from hiding files and folders in file explorer
  - `ShowOfficeCloudFilesInQuickAccess` [`true`/`false`] - Make it so Office cloud files show up in the quick access menu within the left hand side menu of file explorer. I like to to disable this.
  - `ShowRecentlyUsedFilesInQuickAccess` [`true`/`false`]- Make it so recently used files show up in the quick access menu within the left hand side menu of file explorer. I like to to disable this.
- #### network
  - `EnableNetworkDiscovery` [`true`/`false`] - enables network discovery on all networking interfaces
- #### performance
  - `EnableUltimatePerformance` [`true`/`false`] - unlocks Windows' "Ultimate Performance" power plan setting and enable it. This will give you the abosolute best performance out of your PC.
  - `DisableMonitorTimeout` [`true`/`false`] - prevents windows from turning off your display after a period of inactivity
  - `MonitorTimeout` [`1-9999`] - If `DisableMonitorTimeout` is set to `false`; this will set the number of minutes before your display will turn itself off due to inactivity.
  - `DisableSleep` [`true`/`false`] - prevents windows from putting your computer into sleep/hybernation after a certain period of inactivity. In my experience sleep can break a lot of things, after which I'm required to reboot. I much prefer that my computer simply never enters a hybernated state.
  - `StandbyTimeout` [`1-9999`] - If `DisableSleep` is set to `false`; this will set the number of minutes before you computer will enter sleep/hybernation due to inactivity.
  - `DisableUsbSelectiveSuspend` [`true`/`false`] - prevents windows from powering down usb connected devices after a certain amount of inactivity. USB Selective Suspend can really mess with audio interfaces and other USB devices, I highly recommend you sest this to `true` to disable it.
- #### services
  - `DisableTelemetry` [`true`/`false`] - Disables telemetry within Windows. Telemetry is the process of Microsoft collecting data from your pc, diagnostic and what have you. I'd recommend setting this to `true` for the most part, you don't need to send your data to Microsoft in most cases. Should marginally increase performance and network usage.
- #### start menu
  - `ShowMorPins` [`true`/`false`] - Allows for more pinned apps in the start menu as opposed to more recommendations. People sleep on the new start menu, apps that you use frequently that aren't already pinned to your taskbar should be pinned to your start menu. You also get pin folders for good orgnaiztion capabilities.
  - `ShowRecentlyAddedApps` [`true`/`false`] - Will momentarily disable recently installed apps within the recommendations section of the start menu. I like this, it's useful for quickly accessing and or pinning newly installed apps.
  - `ShowMostUsedApps` [`true`/`false`] - shows most used apps within the recommendations section of the start menu
  - `ShowRecentlyOpenedItems` [`true`/`false`] - shows recently opened files within the recommendations section of the start menu
  - `ShowRecommendations` [`true`/`false`] - shows algorithmically generated file/app recommendations within the recommendations section of the start menu
- #### task bar
  - `ShowTaskbarOnAllDisplays` [`true`/`false`] - shows task bar on all connected displays
  - `CenterAlignTaskbarItems` [`true`/`false`] - Center aligns task bar items. Preferable to left alignment as your mouse is always closer to what you have pinned on the taskbar.
  - `ShowSearch` [`true`/`false`] - Displays a search box on your task bar. Feels redundant to me as you can just open the start menu and start typing to search. Easiest by simply pressing the Windows key and then typing.
  - `SearchStyle` [`1-3`] - If `ShowSearchOnTaskBar` is set to `true`, this will determine what style your search bar will display as (1=compact | 2=search icon + label + box icon | 3=search icon + label).
  - `ShowTaskViewButton` [`true`/`false`] - shows the taskview button on task bar
  - `ShowWidgetsButton` [`true`/`false`] - shows the widget button on task bar
  - `ShowChatButton` [`true`/`false`] - shows the chat button on your (through Microsoft Teams)
  - `ShowSecondsOnClock`- displays seconds on your system clock

### config.json example

Note that if a setting is ommited from the configuration it will simply skip the logic to set that setting. So, you don't necessarily have to set everything to true or false. If you want to use Windows' default configuration for any given setting, simly omit it from `config.json`.

```json
{
  "Administrative": {
    "DisableUacPopups": true
  },
  "Cursor": {
    "DisableEnhancedPointerPrecision": true,
    "DisableEaseCursorMovement": true
  },
  "FileExplorer": {
    "EnableCompactView": true,
    "MoveRecycleBinToFileExplorer": true,
    "ShowFileExtensionsForKnownFileTypes": true,
    "ShowHiddenFilesAndFolders": true,
    "ShowRecentlyUsedFilesInQuickAccess": false,
    "ShowFrequentlyUsedFoldersInQuickAccess": true,
    "ShowOfficeCloudFilesInQuickAccess": false
  },
  "Network": {
    "EnableNetworkDiscovery": true
  },
  "Performance": {
    "EnableUltimatePerformance": true,
    "DisableMonitorTimeout": true,
    "DisableSleep": true,
    "DisableUsbSelectiveSuspend": true
  },
  "Services": {
    "DisableTelemetry": true
  },
  "StartMenu": {
    "ShowMorePins": true,
    "ShowRecentlyAddedApps": true,
    "ShowMostUsedApps": true,
    "ShowRecentlyOpenedItems": true,
    "ShowRecomendations": false
  },
  "Taskbar": {
    "ShowTaskbarOnAllDisplays": false,
    "CenterAlignTaskbarItems": true,
    "ShowSearchOnTaskbar": false,
    "ShowTaskViewButton": false,
    "ShowWidgetsButton": false,
    "ShowChatButton": false,
    "ShowSecondsOnClock": true
  }
}
```

# wigui lists

### update blacklist

```
BurntSushi.ripgrep.GNU
CrystalDewWorld.CrystalDiskInfo
CrystalDewWorld.CrystalDiskInfo.KureiKeiEdition
CrystalDewWorld.CrystalDiskInfo.ShizukuEdition
CrystalDewWorld.CrystalDiskInfo.AoiEdition
CrystalDewWorld.CrystalDiskMark
CrystalDewWorld.CrystalDiskMark.ShizukuEdition
Discord.Discord
Docker.DockerDesktop
Elgato.CameraHub
EpicGames.EpicGamesLauncher
Gyan.FFmpeg
Google.GoogleChrome
Guru3D.RTSS
Microsoft.AzureDataStudio
Microsoft.Office
Microsoft.Teams
Microsoft.UI.Xaml.2.7
Microsoft.VCRedist.2005.x64
Microsoft.VCRedist.2005.x86
Microsoft.VCRedist.2008.x64
Microsoft.VCRedist.2008.x86
Microsoft.VCRedist.2010.x64
Microsoft.VCRedist.2010.x86
Microsoft.VCRedist.2012.x64
Microsoft.VCRedist.2012.x86
Microsoft.VCRedist.2013.x64
Microsoft.VCRedist.2013.x86
Microsoft.VSTOR
Mozilla.Firefox
Mozilla.Firefox.DeveloperEdition
Mozilla.Firefox.Nightly
Obsidian.Obsidian
OBSProject.OBSStudio
REALiX.HWiNFO
RiotGames.LeagueOfLegends.NA
RiotGames.Valorant.NA
Romanitho.WiGUI
TeamViewer.TeamViewer
Valve.Steam
```

### admin install list
the application list below must be installed in an *admin elevated* instance of WiGui
```
apple.itunes --ignore-security-hash
docker.dockerdesktop --ignore-security-hash
gyan.ffmpeg --ignore-security-hash
protontechnologies.protonvpn --ignore-security-hash
rufus.rufus --ignore-security-hash --location documents
tailwindlabs.tailwindcss --ignore-security-hash
```

### standard install list
it is recommended that the application list below is installed in a *non-elevated* instance of WiGui
```
7zip.7zip --ignore-security-hash
BurntSushi.ripgrep.GNU --ignore-security-hash
Discord.Discord --ignore-security-hash
Elgato.4KCaptureUtility --ignore-security-hash
Elgato.CameraHub --ignore-security-hash
Elgato.StreamDeck --ignore-security-hash
EpicGames.EpicGamesLauncher --ignore-security-hash
Ferdium.Ferdium --ignore-security-hash
Figma.Figma --ignore-security-hash
Figma.FigmaAgent --ignore-security-hash
FinalWire.AIDA64.Extreme --ignore-security-hash
Google.Chrome --ignore-security-hash
Google.ChromeRemoteDesktop --ignore-security-hash
Google.PlatformTools --ignore-security-hash
Guru3D.Afterburner --ignore-security-hash
Guru3D.RTSS --ignore-security-hash
Logitech.GHUB --ignore-security-hash
Logitech.OptionsPlus --ignore-security-hash
Logitech.UnifyingSoftware --ignore-security-hash
Microsoft.AzureDataStudio --ignore-security-hash
Microsoft.DotNet.SDK.Preview --ignore-security-hash
Microsoft.PowerToys --ignore-security-hash
Microsoft.Teams --ignore-security-hash
Microsoft.VCRedist.2005.x64 --ignore-security-hash
Microsoft.VCRedist.2005.x86 --ignore-security-hash
Microsoft.VCRedist.2008.x64 --ignore-security-hash
Microsoft.VCRedist.2008.x86 --ignore-security-hash
Microsoft.VCRedist.2010.x64 --ignore-security-hash
Microsoft.VCRedist.2010.x86 --ignore-security-hash
Microsoft.VCRedist.2012.x64 --ignore-security-hash
Microsoft.VCRedist.2012.x86 --ignore-security-hash
Microsoft.VCRedist.2013.x64 --ignore-security-hash
Microsoft.VCRedist.2013.x86 --ignore-security-hash
Microsoft.VCRedist.2015+.x64 --ignore-security-hash
Microsoft.VCRedist.2015+.x86 --ignore-security-hash
Microsoft.VisualStudio.2022.Professional --ignore-security-hash
Microsoft.VisualStudio.2022.Professional.Preview --ignore-security-hash
Microsoft.VisualStudioCode --ignore-security-hash
Mozilla.Firefox --ignore-security-hash
Mozilla.Firefox.DeveloperEdition --ignore-security-hash
Mozilla.Firefox.Nightly --ignore-security-hash
NDI.NDI5Tools --ignore-security-hash
Notion.Notion --ignore-security-hash
Obsidian.Obsidian --ignore-security-hash
OBSProject.OBSStudio --ignore-security-hash
Proton.ProtonDrive --ignore-security-hash
REALiX.HWiNFO --ignore-security-hash
RiotGames.LeagueOfLegends.NA --ignore-security-hash
RiotGames.Valorant.NA --ignore-security-hash
Spotify.Spotify --ignore-security-hash
TeamViewer.TeamViewer --ignore-security-hash
Touchbyte.PhotoSync --ignore-security-hash
Valve.Steam --ignore-security-hash
```
