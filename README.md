# table of contents
- [steps](#steps)
	1. [update & configure your motherboard's bios](#update--configure-your-motherboards-bios)
 	2. [purchase/obtain a `windows 11 pro for workstations` product key](#purchaseobtain-a-windows-11-pro-for-workstations-product-key)
  	3. [create a bootable flash drive & install windows](#create-a-bootable-flash-drive--install-windows)
  	4. [verify that windows is activated](#verify-that-windows-is-activated)
  	5. [update windows](#update-windows)
  	6. [update windows terminal](#update-windows-terminal)
  	7. [install powershell 7](#install-powershell-7)
  	8. [configure windows terminal & winget](#configure-windows-terminal--winget)
  	9. [install git](#install-git)
  	10. [download, configure, & run bulk-edit-settings powershell script](#download-configure--run-bulk-edit-settings-powershell-script)
  	11. [manually configure other windows settings](#manually-configure-other-windows-settings)
  	12. [download, install, & run winget-autoupdate (bulk software installer/updater)](#download-install--run-winget-autoupdate-bulk-software-installerupdater)
  	13. [configure msi afterburner (gpu fan curve)](#configure-msi-afterburner-gpu-fan-curve)
  	14. [verify that system temperatures are in-check](#verify-that-system-temperatures-are-in-check)
  	15. [download/install drivers from the drivers list below](#downloadinstall-drivers-from-the-drivers-list-below)
  	16. [configure audio settings](#configure-audio-settings)
  	17. [download/install remaining software as desired using winget/wigui & the software list below](#downloadinstall-remaining-software-as-desired-using-wingetwigui--the-software-list-below)
  	18. [configure rgb lighting](#configure-rgb-lighting)
- [winget/wigui basics](#wingetwigui-basics)
- [drivers](#drivers)
- [software](#software)

# steps
1. ### update & configure your motherboard's bios 
	- attach a flash drive to your computer (preferably less than 32gb)
	- format your flash drive as fat32 ([tutorial](https://www.asus.com/support/FAQ/1044735/))
	- download the latest bios file from your motherboard's support page
	- copy the bios file to the flash drive
	- enter bios (mash [delete] key while computer is restarting)
 	- verify that cpu temp isn't anything crazy
  		- should be on bios home page
		- should be sub 60c
  		- if temps are higher than this you
			- mounted your cpu cooler incorrectly
			- didn't plug in your fans / fans are defective & not running
			- have your fan curve misconfigured, causing fans/pumps to not run (see fan curve tutorail below).
			- used an inadequate cpu cooler
			- have major airflow problems in your case
			- are running your pc in an overly hot environment (90f+) 
   			- have a motherboard that is misreporting temps (unlikely but happens)
	- undergo the bios update process ([tutorial](<https://www.youtube.com/watch?v=n6ZAMrjRudg>))
	- enable x.m.p ([tutorial](<https://www.youtube.com/watch?v=qCnGQPlY6pE>) | should be similar for most motherboards)
		- if motherboard bootloops after this set ram clock lower or disable x.m.p (after mobo enters safe mode)
  		- If motherboard never enters safe mode and just continuously bootloops; reflash your bios using your motherboards advanced flash function.
			- consult manual for exact steps
			- typically involves
				- putting bios file on flash drive
				- naming bios file something specific
				- putting usb stick in specific port
				- pressing a physical button on the motherboard / io panel or simply booting the pc once criteria is met
	- set fan curves in bios if desired ([tutorial](<https://www.youtube.com/watch?v=ZoWlNIzOO0E>) | different per motherboard)
2. ### purchase/obtain a `windows 11 pro for workstations` product key
	- buy keys [here](https://wholsalekeys.com/shop/windows-11-pro-for-workstations/)
 	- if you have a business grade microsoft account for work you may be able to obtain a key for free [here](https://my.visualstudio.com/Downloads?q=Windows%2011)
		- *you will need to login with your work/business email before this link will direct you to the proper place*
3. ### create a bootable flash drive & install windows
	- attach an 8gb+ flash drive to your computer (preferably less than 32gb)
	- download & install [rufus](<https://rufus.ie/en/>)
	- use rufus to download & mount the windows 11 iso to your flash drive ([tutorial](<https://pureinfotech.com/rufus-create-bootable-windows-11-usb/>))
	- undergo the windows setup process ([tutorial](<https://youtu.be/mTDbHgs9dHk?si=hBSuKpeqPmHCfUP6&t=117>) | start video at 1:57)
4. ### verify that windows is activated
	- open settings & navigate to `system > activation`
	- If it says activation failed, don't panic.
		- you may need to activate by phone
		- there should be a button to do this via the `system > activation` screen
5. ### update windows
	- open windows settings & navigate to `windows updates`
	- check for updates & wait for them to download/install
	- **restart your computer**
	- check for updates again
	- If you have more updates and pc requests restarting again, do so.
	- repeat until windows states that everything is up-to-date 
6. ### update windows terminal
	- open the microsoft store & search for windows terminal
	- click the windows terminal listing & wait a few seconds
	- click the update button & wait for the update to complete
		- if update button doesn't appear within 30 seconds it's already up-to-date
7. ### install powershell 7
	- open windows terminal
	- run the following command
		- `winget install microsoft.powershell`
8. ### configure windows terminal & winget
	- restart windows terminal
	- open windows terminal settings (dropdown near tabs) & set your default profile as powershell 7 (darker blue powershell)
	- select the powershell 7 profile in the left hand menu & enable "run this profile as administrator"
	- close windows terminal & open it again
	- confirm that terminal is elevated (should state in tab) & run the following command
		- `winget settings --enable InstallerHashOverride`
9. ### install git
	- open windows terminal
	- run the following command
		- `winget install git.git`
10. ### download, configure, & run `bulk-edit-settings` powershell script
	- restart windows terminal
	- run the following commands
		- `new-item -path "/repos" -itemtype directory`
		- `cd /repos`
		- `git clone https://github.com/ninbura/install-and-configure-microsoft-windows`
	- open `c:/repos/install-and-configure-microsoft-windows/bulk-edit-settings.ps1` in desired text editor 
	- configure setting parameters at top of file as desired
	- save and close file
	- right click `run-me.bat` & select "run as administrator"
	- wait for script to finish then **restart your computer**
11. ### manually configure other windows settings
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
12. ### download, install, & run winget-autoupdate (bulk software installer/updater)
	- download & run wigui (wigui = gui for winget-autoupdate)
		- `winget install wigui --location documents`
		- should be in your user's documents folder after download
	- click on the "configure wau" tab
 		- load `c:/repos/install-and-configure-microsoft-windows/.blacklist.txt`
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
	- wait for winget-autoupdate to update existing packages (wait until you're no longer receiving notifcations from wigui)
	- open `install-list.txt` in your text editor of choice and remove/add entries per your desires
		- `c:/repos/install-and-configure-microsoft-windows/.install-list.txt`
		- see [winget basics](#wingetwigui-basics) for info in-relation to finding appliations to add to your `.install-list.txt` via winget
  		- required applications (do not remove from `.install-list.txt`)
			- 7zip.7zip
			- FinalWire.AIDA64.Extreme
			- Guru3D.Afterburner
			- REALiX.HWiNFO
		- Pro tip, you can sort lines in `.txt` files via [vscode](https://code.visualstudio.com/) by hitting the run hotkey ([f1] or [ctrl+shit+p]) and running "sort lines ascending".
		- it is *highly recommended* that you save your edited `.install-list.txt` in a backed up / redundant location and start managing it yourself
	- Restart wigui, load your install list, click install, & wait for the process to finish.
	- **restart your computer**
13. ### configure msi afterburner (gpu fan curve)
	- *this is not applicable if your gpu is water cooled*
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
	- cpu & gpu
		- open HWiNFO (installed via wigui, search start)
			- select "show sensors" 
		- temps are model dependent
		- higher end components run hotter than lower end components
		- lower temp is better but as long as things are generally in below ranges you should be fine 
			- cpu idle temp should be >50c 
			- gpu idle temp should be >50c
		- open Aida64 Extreme (installed via wigui, search start)
			- confirm you're okay with app being in trial mode
			- open system stability test dialog `tools > system stability test`
				- enable everything except "local disks"
				- run test for 5-15 minutes
					- cpu temp should be >=100c
					- gpu temp should be >=85c
		- if cpu temps are too high re-read [update & configure your motherboard's bios](#update--configure-your-motherboards-bios) for fixes
		- if gpu temps are too high
			- verify that gpu fans are spinning
			- verify that nothing is too close to or obstructing gpu fans
   			- verify that all other fans in case are working
   			- set a more aggressive fan curve via msi afterburner
	- m.2 drives
		- download & install [crystaldiskinfo](https://crystalmark.info/en/software/crystaldiskinfo/) (hard drive monitor | get "Shizuku" edition for a good time ☺️)
		- open crystaldiskinfo (search start)
			- verify that m.2 idle temp is below 60c
			- verify that m.2 drive health is "good"
				- consider replacing your hard drive if health is poor 
			- run another Aida64 Extreme stability test but with only "local disks" enabled
				- verify that drive temp remains under 65c
			- if idle temp is over 60c or stress temp is over 65c you
				- didn't properly install your m.2 drive
				- need an aftermarket heatsink for your m.2 drive
				- need to install a fan pointing directly at your m.2 drive   
15. ### download/install drivers from the **drivers** list below
	- you don't need to restart your computer when prompted after every single driver
	- restart your computer after installing all drivers
 	- Note that every driver you need may not be listed below, said list is composed of items relevant to me and my direct peers.
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
17. ### download/install remaining software as desired using winget/wigui & the **software** list below
	- just like drivers you don't need to restart your computer when prompted after every single install
	- restart your computer after installing all desired software (if you were prompted at somepoint to do so)
	- Note that every piece of software you want may not have been included in `.install-list.txt` and or may not be listed below. Said lists are composed of items relevant to me and my direct peers.
	- software in list below is software that is currently not available via winget/wigui
	- It is *always* preferred you install software with winget, it's much quicker & winget-autoupdate will keep your software updated.
		- see [winget basics](#wingetwigui-basics) for instructions on how to use winget/wigui
	- If software isn't available via winget, install software the old fashioned way 😭
18. ### configure rgb lighting
	- this is a very inconsistent process not only by motherboard but often by sepcific components
	- often times your motherboard will have a single piece of software that allows for configuring all rgb
	- other times you need a specific program for a specific component
 		- For exmaple, pny gpus use dedicated software, motherboard can't configure many pny gpus lighting.
	- It's really such a mixed bag that you'll just have to start by referencing / installing your motherboards rgb control software, and then work from there.
	- For each component that can't be controlled via this software, google the exact component in question + "rgb control" & pray that you find competent instructions online. 
# winget/wigui basics
- use the following powershell commands via windows terminal to search for & install software with winget (minus the brackets[])
	- `winget search [software name/id]`
	- `winget install [software id]`
	- example
		- `winget search chrome`
		- *take note of or copy id for google chrome* 
		- `winget install google.chrome`
	- Installing by id (listed on search results) is easiest, as exampled above.
	- but you can also use name if you wrap the name in quotes & use the `--name` flag.
		- example
			- `winget install --name "Google Chrome"`
- Or you can search for and install software with winget via wigui on the "select apps" tab, which you used earlier ([tutorial](https://github.com/Romanitho/Winget-Install-GUI)).
- some applications must be installed in an admin elevated instance of powershell
	- In this case wigui *will not work* for install, but apps should still automatically update via winget-autoupdate at login.
	- We already set your powershell 7 profile to run as admin by default, and we set powershell 7 as your default windows terminal profile. So, to spawn an admin elevated instance of powershell you just have to open windows terminal.
- some applications must be installed in a **non-elevated** instance of powershell
	- in this case wigui should work
	- Because we have powershell 7 set as your default profile in windows terminal, and said profile is set to launch as admin by default; you'll need to launch powershell 5 to install apps that require a non-elevated instance of powershell. Simply search "powershell" in start and launch the powershell listing that has the lighter blue icon.
- sometimes apps may require additonal flags to install
	- use this flag when "application hash doesn't match"
		- `--ignore-security-hash`
		- this flag must be run via winget in a **non-elvated** instance of powershell to work (see last nuance)
		- Note that there's some security concern with ignoring an application's security hash. A bad actor could intercept an application's winget pipeline and inject malicious code, which would typically trip the security hash check. But with this flag you're bypassing that check. **Use at your own risk** (I do it all the time 😅).
	- Use this command when winget is being stubborn about versioning, or just stubborn in general.
		- `--force`
		- Note that when using `--force` to install an app that's already installed, said app will be re-installed and you may lose some configurations previously set in said app. Generally app specific settings/configurations are stored in a separate cache from the install location/data. So, typically this should just re-install said app & retain said app's settings/configurations.
	- examples
		- `winget install microsoft.dotnet.sdk.6 --force`
		- `winget install google.chromeremotedesktop --ignore-security-hash`
		- `winget install obsproject.obsstudio --ignore-security-hash --force`
	- These flags can be used in wingui by appending them to the end of entries, as seen in `.install-list.txt`.
- It is *highly recommended* that you add any aditional software you install to your `.install-list.txt`, save it off in a backed up / redundant location, and start managing it yourself.
	- see [download, install, & run winget-autoupdate (bulk software installer/updater)](#download-install--run-winget-autoupdate-bulk-software-installerupdater) for more details 
- Pro tip, you can sort lines in `.txt` files via [vscode](https://code.visualstudio.com/) by hitting the run hotkey ([f1] or [ctrl+shit+p]) and running "sort lines ascending".

# drivers
- please read [download/install drivers from the drivers list below](#downloadinstall-drivers-from-the-drivers-list-below)
- Some drivers will need be downloaded from your motherboard's support page, others are typically universal. If your motherboard uses intel drivers for bluetooth, lan (ethernet), & wan (wifi) you can use the links below to get the latest versions. To verify that your motherboard uses universal intel drivers, you'll need to go to your motherboards support page.
- drivers you typically need to grab from your motherboards support page
	- audio driver 
		- usually labeled as realtek
	- intel chipset driver
		- only required if you're using an intel cpu
	- sata driver
		- only required if you're using sata based storage
		- typically labeled as "intel rapid storage technology"
- latest intel device drivers 
	- check motherboard page to make sure your motherboard uses intel for these devices
	- [intel bluetooth](<https://www.intel.com/content/www/us/en/support/articles/000005489/wireless.html>)
	- [intel lan](https://www.intel.com/content/www/us/en/download/727998/intel-network-adapter-driver-for-microsoft-windows-11.html)
	- [intel wan](<https://www.intel.com/content/www/us/en/download/19351/windows-10-and-windows-11-wi-fi-drivers-for-intel-wireless-adapters.html>)
- drivers you will need from your motherboard's support page if said devices aren't intel
	- bluetooth driver
	- lan driver
	- wan driver
- [amd cpu/chipset & gpu drivers](<https://www.amd.com/en/support>)
- [nvidia drivers](<https://www.nvidia.com/download/index.aspx>)
	- *Click buttons on nvidia driver page slowly, if you move too fast you will get ip banned!*
	- always select **custom install** and then **clean install**
	- open nvidia control panel ([shift+right click] desktop)
		- select "manage 3d settings" in left hand side menu
			- set "power management mode" to "prefer maximum performance"
		- select "change resolution" in left hand side menu & verify that all monitors are
			- set to the correct resolution & refresh rate
			- set to full rgb color mode
			- If color mode is partial and greyed out; override settings with "use nvidia color settings".
   	- after driver install it's likely that your windows audio settings got borked (see [configure audio settings](#configure-audio-settings) for fix)
- other drivers
	- [silabs 3.9.2](<https://hdfury.com/product/integral-2/>) (hdfury integral 2)
		- must be installed via **admin elevated** terminal
		- `start-process -path [releativepath]/Silabs_Driver_v3/Silabs_Driver_v3/USBXpressInstaller.exe`
	- [magewell pro capture](<https://www.magewell.com/downloads/pro-capture>) (magewell capture pro cards)
	- [rme drivers](<https://www.rme-usa.com/downloads.html>) (rme audio interfaces)
	- [tx401](<https://www.tp-link.com/us/support/download/tx401/>) (10g ethernet pcie card)
# software
- please read [download/install remaining software as desired using winget/wigui & the software list below](#downloadinstall-remaining-software-as-desired-using-wingetwigui--the-software-list-below)
- [adobe creative cloud](<https://www.adobe.com/creativecloud.html>) (photoshop, premiere, etc.)
- [advanced scene switcher](<https://github.com/WarmUpTill/SceneSwitcher/releases>) (obs plugin)
- appstudio (reporting client)
- [battlenet launcher](<https://us.shop.battle.net/en-us>)
- cisco anyconnect (vpn client)
	- microsoft store
- [crystaldiskinfo](<https://crystalmark.info/en/software/crystaldiskinfo/>) (check disk hard drive health)
- [crystaldiskmark](<https://crystalmark.info/en/software/crystaldiskmark/>) (test hard drive speed)
- [davinci resolve](<https://www.blackmagicdesign.com/products/davinciresolve>) (download link near the bottom of the page)
- [easybcd](<https://neosmart.net/EasyBCD/>) (tool for dual booting)
- ffmpeg (cli media editor)
	- run in **elevated** console
	- `winget install gyan.ffmpeg`
- [ffxiv launcher](<https://na.finalfantasyxiv.com/lodestone/playguide/#returner>) 
- icloud
	- microsoft store
- [ireboot](<https://neosmart.net/iReboot/>) (tool for dual booting)
- [obs asio](<https://github.com/Andersama/obs-asio/releases>) (obs plugin)
- [synergy](<https://symless.com/synergy/account-login?redirect=https%3A%2F%2Fsymless.com%2Fsynergy%2Fdownload>) (tool for sharing single mouse & keyboard with multiple computers)
- [rode central](<https://rode.com/en-us/software/rode-central>) (Rodecaster Pro II & Rodecaster Duo)
- [via](<https://www.caniusevia.com/>) (tool for configuring many keyboard models)
- [vlc 4.0](<https://artifacts.videolan.org/vlc/nightly-win64/>) (video player, plays all codecs including the new av1 codec)
- [window-switcher](<https://github.com/sigoden/window-switcher/releases>) (macOS style window switching for windows 11)
- [wootliltiy](<https://wooting.io/wootility>) (software to configure wooting keyboards)
- wsa (windows subsystem for android)
	- download amazon store via windows store
	- **restart your computer**
- wsl (windows subsystem for linux)
	- run in **elevated** console
	- `wsl --install`
		- **restart your computer**
	- `winget search ubuntu`
	- `winget install Canonical.Ubuntu.2204`
- xbox accessories (tool for configuring xbox controllers)
	- microsoft store
