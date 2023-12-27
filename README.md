# table of contents
- [steps](#steps)
	1. [update & configure your motherboard's bios](#update--configure-your-motherboards-bios)
	2. [purchase/obtain a `windows 11 pro for workstations` product key](#purchaseobtain-a-windows-11-pro-for-workstations-product-key)
	3. [create a bootable flash drive & install windows](#create-a-bootable-flash-drive--install-windows)
	4. [verify that windows is activated](#verify-that-windows-is-activated)
	5. [update windows](#update-windows)
	6. [update microsoft store apps](#update-microsoft-store-apps)
	7. [install powershell 7 & git](#install-powershell-7--git)
	8. [configure windows terminal](#configure-windows-terminal)
	9. [download, configure, & run bulk-edit-settings powershell script](#download-configure--run-bulk-edit-settings-powershell-script)
	10. [manually configure other windows settings](#manually-configure-other-windows-settings)
	11. [download/install system drivers](#downloadinstall-system-drivers)
	12. [download, install, & run winget-autoupdate (bulk software installer/updater)](#download-install--run-winget-autoupdate-bulk-software-installerupdater)
	13. [configure msi afterburner (gpu fan curve)](#configure-msi-afterburner-gpu-fan-curve)
	14. [verify that system temperatures are in-check](#verify-that-system-temperatures-are-in-check)
	15. [download/install remaining software](#downloadinstall-remaining-software)
	16. [configure audio settings](#configure-audio-settings)
	17. [configure rgb lighting](#configure-rgb-lighting)
	[winget/wigui basics](#wingetwigui-basics)
- [drivers](#drivers)
	- [preface](#preface)
	- [intel](#intel)
	- [amd cpu/chipset & gpu](#amd-cpuchipset--gpu)
	- [nvidia](#nvidia)
	- [other drivers](#other-drivers)
- [winget basics](#wingetwigui-basics)
	- [winget preface](#winget-preface)
	- [searching for apps](#searching-for-apps)
	- [install apps](#installing-apps)
	- [updating apps](#updating-apps)
	- [uninstalling apps](#uninstalling-apps)
- [software](#software)
	- [**wsl** (windows subsystem for linux)](#wsl-windows-subsystem-for-linux)
	- [winget](#winget)
	- [microsoft store](#microsoft-store) 
	- [old-school](#old-school)
- [troubleshooting](#troubleshooting)
	- [troubleshooting bootloop / boot problems](#troubleshooting-bootloop--boot-problems)
	- [troubleshooting failed windows activation](#troubleshooting-failed-windows-activation)
	- [troubleshooting high temperatures](#troubleshooting-high-temperatures) 
- [wigui lists](#wigui-lists)
	- [update blacklist](#update-blacklist)
	- [install list](#install-list)
# steps
1. ### update & configure your motherboard's bios
	- attach a >=32GB USB 2.0 flash drive to your computer
	- format your flash drive as fat32 ([tutorial](https://www.asus.com/support/FAQ/1044735/))
 	- take note of your motherboard's model number, should be listed on the box it came in.
	- search for your motherboard via it's model number on google & download the latest bios file from your motherboard's support page
	- copy the bios file to the flash drive
	- enter bios (mash [delete] key while computer is restarting)
 	- verify that cpu temp isn't anything crazy
  		- should be on bios home page
		- should be sub 60c
  		- if temps are higher than this see [troubleshooting high temperatures](#troubleshooting-high-temperatures)
	- undergo the bios update process ([tutorial](<https://www.youtube.com/watch?v=n6ZAMrjRudg>) | should be similar for most motherboards)
	- enable x.m.p ([tutorial](<https://www.youtube.com/watch?v=qCnGQPlY6pE>) | should be similar for most motherboards)
		- if computer no longer boots or bootloops after enabling x.m.p see [troubleshooting bootloop / boot problems](#troubleshooting-bootloop--boot-problems)
	- set fan curves in bios if desired ([tutorial](<https://www.youtube.com/watch?v=ZoWlNIzOO0E>) | should be similar for most motherboards)
2. ### purchase/obtain a `windows 11 pro for workstations` product key
	- buy keys [here](https://wholsalekeys.com/shop/windows-11-pro-for-workstations/)
 	- if you have a business grade microsoft account for work you may be able to obtain a key for free [here](https://my.visualstudio.com/Downloads?q=Windows%2011)
		- *you will need to login with your work/business email before this link will direct you to the proper place*
3. ### create a bootable flash drive & install windows
	- attach an 8gb+ flash drive to your computer (preferably less than 32gb)
	- download & install [rufus](<https://rufus.ie/en/>)
	- use rufus to download & mount the windows 11 iso to your flash drive ([tutorial](<https://pureinfotech.com/rufus-create-bootable-windows-11-usb/>))
	- before starting the windows setup process, please have your aformentioned windows 11 pro for workstations product key ready.
 	- despite what the following video says, you **do** want to provide the product key up front so the correct version of windows is installed.
  	- if you don't have a product key yet you might be able to manually select windows 11 pro for workstations as the target operating system. But I've come accross times where "for workstations" isn't in the operating system list.
	- undergo the windows setup process ([tutorial](<https://youtu.be/mTDbHgs9dHk?si=hBSuKpeqPmHCfUP6&t=117>) | start video at 1:57)
4. ### verify that windows is activated
	- open settings & navigate to `system > activation`
	- If it says activation failed don't panic, see [troubleshooting failed windows activation](#troubleshooting-failed-windows-activation).
5. ### update windows
	- open windows settings & navigate to `windows updates`
 	- optionally - toggle "Get the latest updates as soon asy they're available"; I personally suggest doing this.
	- check for updates & wait for them to download/install
	- **restart your computer**
	- check for updates again
	- if you have more updates and pc requests restarting again, do so.
	- repeat until windows states that everything is up-to-date 
6. ### update microsoft store apps
	- open the microsoft store via your start menu
	- click the "library" button in the bottom left hand corner of the window
 	- select "get updates" in the top right hand corner of the window
	- wait until all updates have been retreived, should be a little loading symbol to reference
	- select "update all" just left of the "get updates" button
 	- wait for all microsoft store applications to update before proceeding to step 7
7. ### install powershell 7 & git
	- open windows terminal
	- run the following commands
		- `winget install microsoft.powershell`
		- `winget install git.git`
8. ### configure windows terminal
	- restart windows terminal
	- open windows terminal settings (dropdown near tabs) & set your default profile as powershell 7 (darker blue powershell)
	- select the powershell 7 profile in the left hand menu & enable "run this profile as administrator"
9. ### download, configure, & run `bulk-edit-settings` powershell script
	- restart windows terminal
	- run the following commands
		- `new-item -path "/repos" -itemtype directory`
		- `cd /repos`
		- `git clone https://github.com/ninbura/windows`
	- open `c:/repos/windows/bulk-edit-settings.ps1` in desired text editor 
	- configure setting parameters at top of file as desired
	- save and close file
	- right click `run-me.bat` & select "run as administrator"
	- wait for script to finish then **restart your computer**
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
	- configure other system settings you'd like which weren't included in the above list or the `bulk-edit-settings` powershell script.
11. ### download/install system drivers
	- see [drivers](#drivers) list below
	- note that every driver you need may not be listed below, said list is composed of items relevant to me and my direct peers.
 	- you don't need to restart your computer when prompted after every single driver
	- restart your computer after installing all drivers
12. ### download, install, & run winget-autoupdate (bulk software installer/updater)
	- download & run [wigui](https://github.com/Romanitho/Winget-Install-GUI/releases)
	- move `wigui.exe` to your documents folder & run it
	- click on the "configure wau" tab (wau = winget-autoupdate)
 		- wau aka winget-autoupdate updates all winget packages that have updates every time you login. Long story short, you almost never have to manually update software again.
 		- load `c:/repos/windows/.blacklist.txt`
		- reference image below for configuration on this tab
		- ![image](https://github.com/ninbura/install-and-configure-microsoft-windows/assets/58058942/acbfc1f2-0846-466e-ab07-a00b26a4cb7a)
		- to modify update blacklist going forward edit the following txt file
  			- `C:\ProgramData\Winget-AutoUpdate\excluded_apps.txt` 
			- blacklist apps that
				- consistently fail to update via winget-autoupdate
				- needlessly update every time you login
			- you will see this info in windows notification center (click clock on task bar)
			- it is *highly recommended* that you save your edited `.blacklist.txt` in a backed up / redundant location and start managing it yourself
	- **restart your computer**
	- open windows terminal & run the following command
		- `winget settings --enable InstallerHashOverride`
	- wait for winget-autoupdate to update existing packages (wait until you're no longer receiving notifcations from wigui)
	- open `install-list.txt` in your text editor of choice and remove/add entries per your desires
		- `c:/repos/windows/.install-list.txt`
		- see [winget basics](#wingetwigui-basics) for info in-relation to finding appliations to add to your `.install-list.txt` via winget
  		- required applications (do not remove from `.install-list.txt`)
			- FinalWire.AIDA64.Extreme
			- Guru3D.Afterburner
			- REALiX.HWiNFO
		- Pro tip, you can sort lines in `.txt` files via [vscode](https://code.visualstudio.com/) by hitting the run hotkey ([f1] or [ctrl+shit+p]) and running "sort lines ascending".
		- it is *highly recommended* that you save your edited `.install-list.txt` in a backed up / redundant location and start managing it yourself
	- Open wigui, load your install list, click install, & wait for the process to finish.
	- **restart your computer**
13. ### configure msi afterburner (gpu fan curve)
	- *this is not applicable if your gpu is water cooled*
	- this program should have been installed via wigui, just search for it in start and open it.
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
	- cpu & gpu
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
				- cpu load temp should be >=98c
				- gpu load temp should be >=85c
		- with modern amd & intel cpus with even high end cooling you can still reach 100c
		- while this is technically safe because they'll throttle, it's best if you stay below 100c.
		- there are all in one water coolers large enough to prevent even the highest end CPUs from throttling
		- I suggest Artic's "liquid freezer line"
			- 360/420mm for intel i7 & amd x700
			- 420mm for intel i9 & amd X900
   		- for i5 cpus & below I suggest purchasing the **thermalright peerless assassin** air cooler
		- if temps for cpu or gpu are high per numbers above see [troubleshooting high temperatures](#troubleshooting-high-temperatures) 
	- m.2 drives
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
	- see [software](#software) list below
 	- just like drivers you don't need to restart your computer when prompted after every single install
	- restart your computer after installing all desired software (if you were prompted at somepoint to do so)
	- note that every piece of software you want may not have been included in `.install-list.txt` and or may not be listed below. said lists are composed of items relevant to me and my direct peers.
	- software in list below is software that can not currently be installed properly via wigui
	- it is *always* preferred you install software with winget, it's much quicker & winget-autoupdate will keep your software updated.
		- see [winget basics](#wingetwigui-basics) for instructions on how to use winget/wigui
	- if software isn't available via winget, install software the old fashioned way 😭
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
	- repeat these steps any time you encounter ***(😔((((audio problems))))😔)***
17. ### configure rgb lighting
	- this is a very inconsistent process not only by motherboard but often by sepcific components
	- often times your motherboard will have a single piece of software that allows for configuring all rgb
	- other times you need a specific program for a specific component
 		- for exmaple, pny gpus use dedicated software, motherboard can't configure many pny gpus lighting.
	- it's really such a mixed bag that you'll just have to start by referencing / installing your motherboards rgb control software, and then work from there.
	- for each component that can't be controlled via this software, google the exact component in question + "rgb control" & pray that you find competent instructions online.
# drivers
### preface
- please read [download/install drivers from the drivers list below](#downloadinstall-drivers-from-the-drivers-list-below)
- some drivers will need be downloaded from your motherboard's support page, others are typically universal. if your motherboard uses intel drivers for bluetooth, lan (ethernet), & wan (wifi) you can use the links below to get the latest versions. To verify that your motherboard uses universal intel drivers, you'll need to go to your motherboards support page.
- take note of your motherboard's model number, should be listed on the box it came in.
- search for your motherboard via it's model number on google & locate the support page
- drivers you typically need to grab from your motherboards support page
	- audio driver
		- usually labeled as realtek
		- only grab latest version, don't need mulitple motherboard audio drivers 
	- intel chipset driver (intel cpus only)
		- there may be multiple "chipset" style drivers
		- look for drivers titled as so
			- intel serial i/o
			- intel management engine
			- intel me
			- intel mei  
			- intel inf
			- intel hid
		- you should see one or many of the aformentioned intel chipset drivers   
	- sata driver
		- only required if you're using sata based storage
		- typically labeled as "intel rapid storage technology" 
### intel
- check motherboard page to make sure your motherboard uses intel for these devices
- [bluetooth](<https://www.intel.com/content/www/us/en/support/articles/000005489/wireless.html>)
- [lan](https://www.intel.com/content/www/us/en/download/727998/intel-network-adapter-driver-for-microsoft-windows-11.html)
- [wan](<https://www.intel.com/content/www/us/en/download/19351/windows-10-and-windows-11-wi-fi-drivers-for-intel-wireless-adapters.html>)
- [graphics](https://www.intel.com/content/www/us/en/download/785597/intel-arc-iris-xe-graphics-windows.html)
- drivers you will need from your motherboard's support page if said devices aren't intel
	- bluetooth driver
	- lan driver
	- wan driver
### [amd cpu/chipset & gpu](<https://www.amd.com/en/support>)
### [nvidia](<https://www.nvidia.com/download/index.aspx>)
- *Click buttons on nvidia driver page slowly, if you move too fast you will get ip banned!*
- always select **custom install** and then **clean install**
- open nvidia control panel ([shift+right click] desktop)
	- select "manage 3d settings" in left hand side menu
		- set "power management mode" to "prefer maximum performance"
	- select "change resolution" in left hand side menu & verify that all monitors are
		- set to the correct resolution & refresh rate
		- set to full rgb color mode
		- if color mode is partial and greyed out; override settings with "use nvidia color settings".
- after driver install it's likely that your windows audio settings got borked (see [configure audio settings](#configure-audio-settings) for fix)
### other drivers
- [silabs 3.9.2](<https://hdfury.com/product/integral-2/>) (hdfury integral 2)
	- must be installed via **admin elevated** terminal
	- `start-process -path [releativepath]/Silabs_Driver_v3/Silabs_Driver_v3/USBXpressInstaller.exe`
- [magewell pro capture](<https://www.magewell.com/downloads/pro-capture>) (magewell capture pro cards)
- [rme drivers](<https://www.rme-usa.com/downloads.html>) (rme audio interfaces)
- [tx401](<https://www.tp-link.com/us/support/download/tx401/>) (10g ethernet pcie card)
# winget/wigui basics
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
- while it's not always needed, there are some useful flags you can tack onto then end of `winget install` commands.
	- `--ignore-security-hash` 
		- before using this flag you must first run `winget settings --enable InstallerHashOverride` in an elevated console
		- ignores an apps "security hash"
		- sometimes a app developers application building pipeline erros on the winget step, so the hash is not updated.
		- You can tell winget that you don't care that the hash doesn't match, and install anyways.
		- Note that this is techinically a security risk as someone could hijack a developers pipeline and inject their own application.
		- I use it all the time 😅
	- `--force`
		- Sometimes winget refuses to install an app because it thinks it's already installed, or it thinks a newer version is installed. Sometimes the above is true, sometimes it's not.
		- Using this flag bypasses issues like this, and forces winget to install the specified application.
		- Note that this will re-install an application 100% of the time. So, backup your settings in an app you already have installed if you're going to use this flag.
- flag usage examples
	- `winget install Mozilla.Firefox.Nightly --ignore-security-hash`
	- `winget install Microsoft.DotNet.SDK.6 --force`
	- `winget install Microsoft.DotNet.SDK.7 --ignore-security-hash --force`
### updating apps
- Note that if you installed winget auto update via wigui earlier in the tutorial you don't have to worry about updating applications via winget manually. This applies to any application that *is not* on your update blacklist. Those applications are typically blacklisted because they either update automatically via the app themselves, or there's a problem with updating them via winget auto update.
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
- please read [download/install remaining software](#downloadinstall-remaining-software)
### **wsl** (windows subsystem for linux)
- install **wsl** the hard way (required for ssh capability)
	- download & install the [**wsl2 exe**](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)
	- run the following command in powershell
		- `wsl --set-default-version 2`
	- **restart your pc**
	- `winget search ubuntu`
	- take note of the id of the linux distribution you want to install & install via winget
	- for exmample  
		- `winget canonical.ubuntu.2204 --ignore-security-hash`  
- installing **wsl** the easy way
	- run the following command in an **elevated** powershelkl  console
	- `wsl --install`
	- **restart your computer**
### winget
- admin elevated terminal required
	- **ffmpeg** (cli media tool)
		- `winget install gyan.ffmpeg --ignore-security-hash`
	- **itunes**
		- `winget install apple.itunes --ignore-security-hash`
	- **proton vpn** (vpn client)
		- `winget install protontechnologies.protonvpn --ignore-security-hash`
	- **rufus** (image mounter)
		- `winget install rufus.rufus --ignore-security-hash`
	- **tailwindcss** (css library for dev)
		- `winget install tailwindlabs.tailwindcss --ignore-security-hash`
- standard terminal
	- **.net sdks** (micorosft .net runtime(s) for dev)
		- you have to install .net sdks in decending order or it'll prompt you to update pre-existing installations to later versions. for example, if you have dotnet 6 sdk installed, and try to install .net sdk7; you'll be prompted to update .net 6 to 7. In many cases you need multiple .net SDKs installed, keep this in mind.
		- `winget install microsoft.dotnet.sdk.7 --ignore-security-hash --force`
		- `winget install microsoft.dotnet.sdk.6 --ignore-security-hash --force`
	- **docker desktop** (running docker images for dev)
		- **wsl must be installed/configured first (see [wsl](#wsl-windows-subsystem-for-linux))**
		- `winget install docker.dockerdesktop --ignore-security-hash`
### microsoft store
- **icloud** (apples icloud desktop application)
- **cisco anyconnect** (vpn client)
- **wsa** (windows subsystem for android)
	- download amazon store via microsoft store
	- **restart your computer**
- **xbox accessories** (tool for configuring xbox controllers)
### old school
- [**adobe creative cloud**](<https://www.adobe.com/creativecloud.html>) (photoshop, premiere, etc.)
- [**advanced scene switcher**](<https://github.com/WarmUpTill/SceneSwitcher/releases>) (obs plugin)
- **appstudio** (reporting client)
- [**battlenet launcher**](<https://us.shop.battle.net/en-us>) (blizzard's game launcher)
- [**crystaldiskinfo**](<https://crystalmark.info/en/software/crystaldiskinfo/>) (check disk hard drive health)
- [**crystaldiskmark**](<https://crystalmark.info/en/software/crystaldiskmark/>) (test hard drive speed)
- [**davinci resolve**](<https://www.blackmagicdesign.com/products/davinciresolve>) (download link near the bottom of the page)
- [**easybcd**](<https://neosmart.net/EasyBCD/>) (tool for dual booting)
- [**ffxiv launcher**](<https://na.finalfantasyxiv.com/lodestone/playguide/#returner>) (square enix's final fantasy 14 launcher)
- [**ireboot**](<https://neosmart.net/iReboot/>) (tool for dual booting)
- [**obs asio**](<https://github.com/Andersama/obs-asio/releases>) (obs plugin)
- [**obs ndi**](https://github.com/obs-ndi/obs-ndi/releases/tag/4.11.1) (obs plugin)
- [**synergy**](<https://symless.com/synergy/account-login?redirect=https%3A%2F%2Fsymless.com%2Fsynergy%2Fdownload>) (tool for sharing single mouse & keyboard with multiple computers)
- [**rode central**](<https://rode.com/en-us/software/rode-central>) (Rodecaster Pro II & Rodecaster Duo)
- [**via**](<https://www.caniusevia.com/>) (tool for configuring many keyboard models)
- [**vlc 4.0**](<https://artifacts.videolan.org/vlc/nightly-win64/>) (video player, plays all codecs including the new av1 codec)
- [**window-switcher**](<https://github.com/sigoden/window-switcher/releases>) (macOS style window switching for windows 11)
- [**wootliltiy**](<https://wooting.io/wootility>) (software to configure wooting keyboards)
# troubleshooting
### troubleshooting bootloop / boot problems
- if computer is bootlooping
	- re-flash bios using advanced flashing utility
	- consult motherboard manual for exact steps, should mention the word "flash" and describe a process for updating your bios without having access to the bios.
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
- if your ***cpu*** temperatures are too high you
	- mounted your cpu cooler incorrectly
		- clean, re-paste, and re-seat the heatsink / water block
	- didn't plug in your fans / fans are defective & not running
	- have your fan curve misconfigured, causing fans/pumps to not run (see fan curve [tutorial](<https://www.youtube.com/watch?v=ZoWlNIzOO0E>) | should be similar for most motherboards).
	- used an inadequate cpu cooler
	- have major airflow problems in your case
	- are running your pc in an overly hot environment (90f+) 
	- have a motherboard that is misreporting temps (unlikely but happens)
	- have a defective cpu or cpu cooler and need to rma / exchange one or the other
- if your ***gpu*** temperatures are too high
	- verify that gpu fans are spinning
	- verify that nothing is too close to or obstructing gpu fans
	- verify that all other fans in case are working
	- set a more aggressive fan curve via msi afterburner
	- if temps are still too high your gpu's heatsink may have a poor factory mount, at which point you can
		- rma / exchange the gpu
		- clean, re-paste, and re-seat the heatsink ([tutorial](https://www.youtube.com/watch?v=n7NMeu0QiYk))
- if your ***m.2 ssd*** temperatures are too high you
	- didn't properly install your m.2 drive
	- need an aftermarket heatsink for your m.2 drive
	- need to install a fan pointing directly at your m.2 drive   
	- have a defective drive and need to rma / exchange it
# wigui lists
### update blacklist
```
CrystalDewWorld.CrystalDiskInfo
CrystalDewWorld.CrystalDiskInfo.KureiKeiEdition
CrystalDewWorld.CrystalDiskInfo.ShizukuEdition
CrystalDewWorld.CrystalDiskMark
CrystalDewWorld.CrystalDiskMark.ShizukuEdition
Discord.Discord
Docker.DockerDesktop
Elgato.CameraHub
EpicGames.EpicGamesLauncher
Google.GoogleChrome
Guru3D.RTSS
Microsoft.AzureDataStudio
Microsoft.DotNet.SDK.6
Microsoft.DotNet.SDK.7
Microsoft.Office
Microsoft.Teams
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
Mozilla.Firefox
Mozilla.Firefox.DeveloperEdition
Mozilla.Firefox.Nightly
Obsidian.Obsidian
OBSProject.OBSStudio
REALiX.HWiNFO
RiotGames.LeagueOfLegends.NA
RiotGames.Valorant.NA
Valve.Steam

```
### install list
```
7zip.7zip --ignore-security-hash
Apple.iTunes --ignore-security-hash
Discord.Discord --ignore-security-hash
Docker.DockerDesktop --ignore-security-hash
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
ProtonTechnologies.ProtonVPN --ignore-security-hash
REALiX.HWiNFO --ignore-security-hash
RiotGames.LeagueOfLegends.NA --ignore-security-hash
RiotGames.Valorant.NA --ignore-security-hash
Rufus.Rufus --ignore-security-hash
Spotify.Spotify --ignore-security-hash
TailwindLabs.TailwindCSS --ignore-security-hash
TeamViewer.TeamViewer --ignore-security-hash
Valve.Steam --ignore-security-hash
```
