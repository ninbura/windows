# Preface

First off, there is a [companion video](https://google.com) that goes along with this written tutorial. If at anypoint you feel the written instructions are hard to follow, please view the companion video. Next to each step there will be a link to the specific timestamp in said video regarding said step. This repository aims to assist anyone attempting to install and configure/optimize Microsoft Windows. Through automation via PowerShell & Winget, as well as other third party tools; you can greatly decrease the time required to install, configure/optimize, and maintain Microsoft Windows. 

# Table of Contents

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
    13. [configure msi afterburner (gpu fan curve)](#configure-msi-afterburner-gpu-fan-curve)
    14. [verify that system temperatures are in-check](#verify-that-system-temperatures-are-in-check)
    15. [download/install remaining software](#downloadinstall-remaining-software)
    16. [configure audio settings](#configure-audio-settings)
    17. [configure rgb lighting](#configure-rgb-lighting)
- [drivers](#drivers)
- [software](#software)
- [troubleshooting](#troubleshooting)
- [bulk edit settings configuration](#bulk-edit-settings-configuration)

# Suggested Prerequisites
- A currently functioning computer running Windows.
- A USB 2.0 flash drive under 32GB in size.
- A USB 3.0 flash drive greater than 8GB in size.
- A Windows 11 Pro For Workstations product key.
    - If you have a business grade microsoft account for work, you may be able to obtain a key for free [here](https://my.visualstudio.com/Downloads?q=Windows%2011).
    - Otherwise, [this](https://wholsalekeys.com/shop/windows-11-pro-for-workstations/) is a good place to buy cheap keys.

# steps
1. ### Mount the Windows 11 ISO/Installer to a Bootable Flash Drive using Rufus
2. ### Update & Configure Your Motherboard's BIOS
    1. update BIOS via GUI or advanced "Flashback"
    2. configure BIOS
        - Enable virtual or physical TPM (usually on by default).
        - Verify that secure boot is *enabled and active*.
        - Enable XMP.
        - Adjust system fan curves as desired.
4. ### Install Windows
    - Under construction
5. ### Verify that Windows is Activated
    - open settings & navigate to `system > activation`
    - If it says activation failed don't panic, see [troubleshooting failed windows activation](#troubleshooting-failed-windows-activation).
6. ### Update Windows
    - Open the Settings app & navigate to `Windows Updates`.
    - Optionally, toggle "Get the latest updates as soon as they're available"; I personally suggest doing this.
    - Check for updates & wait for them to download/install.
    - Restart your computer.
    - Check for updates again.
    - If you have more updates and pc requests restarting again, do so.
    - Repeat until Windows states that everything is up-to-date.
7. ### Update Microsoft Store Apps
    1. Open the Microsoft Store via your Start Menu.
    2. Click the "library" button in the bottom left hand corner of the window.
    3. Select "Get Updates" in the top right hand corner of the window.
    4. Wait until all updates have been retreived, should be a little loading symbol to reference.
    5. Select "Update All" just left of the "Get Updates" button.
    6. Wait for all Microsoft Store applications to update before proceeding.
8. ### Enable sudo for Windows
    1. toggle `Settings > System > For Developers > Enable sudo`
    2. change `Configure how sudo runs applications` to `Inline`
9. ### Use winget to manually install a few applications
    1. right click the start button and click `Terminal`
    2. run/enter the following commands in Windows Terminal
    3. enable script execution
        - ```PowerShell
          sudo Set-ExecutionPolicy RemoteSigned
          ```
    4. install WingetPathUpdater
        - ```PowerShell
          winget install jazzdelightsme.WingetPathUpdater
          ```
    5. run the following command
        - ```PowerShell
          winget install Microsoft.PowerShell Git.Git
          ```
    6. Install Your Internet Browser of Choice
        - winget search example
            - ```PowerShell
              winget search [browser name]
              ```
        - winget install examples
            - ```PowerShell
              winget install TheBrowserCompany.Arc
              ```
            - ```PowerShell
              winget install Mozilla.Firefox
              ```
            - ```PowerShell
              winget install Brave.Brave
              ```
            - ```PowerShell
              winget install Google.Chrome
              ```
            - ```PowerShell
              winget install Zen-Team.ZenBrowser
              ```
10. ### Configure Windows Terminal
    - set PowerShell 7 as default profile
        - There will be two PowerShell options in the list, you want the one with the darker blue color.
        - `Settings > Default profile > PowerShell`
    - configure theming
        - `Settings > Appearence`
        - `Settings > Defaults > Appearence`
11. ### Download, configure, & run the `bulk-edit-settings` PowerShell script.
    - Restart Windows Terminal
    - Run the following commands (you may have to hit enter multiple times if you copy/paste the full block).
        - ```PowerShell
          git clone https://github.com/ninbura/windows /Users/$env:username/repos/windows
          New-Item -Path "~/repos/windows/config.json" -ItemType "File"
          ```
    - Note that `~` represents your user's directory (ie `C:/Users/gabri/`).
    - Open `~/repos/windows/config.json` in desired text editor (ie Notepad).
    - See [bulk edit settings configuration](#bulk-edit-settings-configuration) for instructions as how to configure your `config.json` file.
    - Save and close `config.json`.
    - Right click `~/repos/windows/run-me.bat` & select "Run as administrator".
    - Wait for the script to finish running, then **restart your computer**.
12. ### Manually configure other windows settings
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
12. ### download/install system drivers
    - see [drivers](#drivers) list below
    - Note that every driver you need may not be listed below, said list is composed of items relevant to me and my direct peers.
    - you don't need to restart your computer when prompted after every single driver
    - restart your computer after installing all drivers
13. ### UniGetUI - bulk install/update applications
    - #### under construction
    - ```
      winget install MartiCliment.UniGetUI
      ```
    - UniGetUI package bundles are found in the `uniget-package-bundles` folder within the directory in-which you cloned this repository.
    - Please install all applications in the `dependencies.ubundle` package bundle before installing anything from the `apps.ubundle` package bundle.
14. ### configure msi afterburner (gpu fan curve)
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
15. ### verify that system temperatures are in-check
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
        - get "Shizuku" editions for a good time ☺️
      - open crystaldiskinfo (search start)
        - verify that m.2 idle temp is below 60c
        - verify that m.2 drive health is "good"
        - consider replacing your hard drive if health is poor
      - open crystaldiskmark and hit the giant "all" button
        - verify that drive temp remains under 65c via crystaldiskinfo during benchmark
      - if you see your m.2 temperatures go above 65c during the benchamrk see [troubleshooting high temperatures](#troubleshooting-high-temperatures)
16. ### download/install remaining software
    - see [software](#software) section below
    - just like drivers you don't need to restart your computer when prompted after every single install
    - restart your computer after installing all desired software (if you were prompted at somepoint to do so)
    - Note that every piece of software you want may not have been included in your install list, and or may not be listed in the [software](#software) section below. Said lists are composed of items relevant to me and my direct peers.
    - software in the [software](#software) section below is software that can not currently be installed properly via wigui
    - It is _always_ preferred you install software with winget, it's much quicker & winget-autoupdate will keep your software updated.
      - see [winget basics](#winget-basics) for instructions on how to use winget
    - If software isn't available via winget, install software the old fashioned way 😭
17. ### configure audio settings
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
18. ### configure rgb lighting
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

# software

please read [download/install remaining software](#downloadinstall-remaining-software)

### **wsl** (windows subsystem for linux)

- run the following command in an **elevated** powershell console
  - ```powershell
    wsl --install
    ```
- **restart your computer**

### microsoft store

- [**HEVC Video Extensions**](https://apps.microsoft.com/detail/9nmzlz57r3t7?hl=en-us&gl=US) (allows for playing H265 videos via Windows' media players | paid app)

### old school

- [**Davinci Resolve**](https://www.blackmagicdesign.com/products/davinciresolve) (download link near the bottom of the page)
- [**EasyBCD**](https://neosmart.net/EasyBCD/) (tool for dual booting)
- [**FFXIV Launcher**](https://na.finalfantasyxiv.com/lodestone/playguide/#returner) (square enix's final fantasy 14 launcher)
- [**iReboot**](https://neosmart.net/iReboot/) (tool for dual booting)
- [**Nvidia App**](https://www.nvidia.com/en-us/software/nvidia-app/) (new Nvidia app that aims to replace GeForce Now & Nvidia Control Panel)
- [**OBS Advanced Scene Switcher**](https://github.com/WarmUpTill/SceneSwitcher/releases) (obs plugin)
- [**OBS Audio Monitor**](https://obsproject.com/forum/resources/audio-monitor.1186/) (OBS plugin)
- [**OBS DistroAV**](https://github.com/obs-ndi/obs-ndi/releases/tag/4.11.1) (OBS NDI plugin)
- [**Rode Central**](https://rode.com/en-us/software/rode-central) (Rodecaster Pro II & Rodecaster Duo)
- [**Jagex Launcher**](https://www.jagex.com/en-GB/launcher) (RuneScape client)
- [**window-switcher**](https://github.com/sigoden/window-switcher/releases) (macOS style window switching for windows 11)
- [**Wootliltiy**](https://wooting.io/wootility) (software to configure wooting keyboards)

# troubleshooting

### troubleshooting bootloop / boot problems

- If computer is bootlooping
  - Re-flash bios using Flashback functionality, note that not every computer has this functionality.
  - See []()
- if computer failed to boot into bios after enabling x.m.p and now you're stuck in "safe mode"
  - try setting ram clock at a lower clock
  - if setting the clock speed lower multiple time fails simply disable x.m.p
  - note that you want your ram to be at the highest possible clock for best performance
  - if ram is a reasonable speed (DDR5 5600-6800Mhz | DDR4 2600-3600) and can't achive x.m.p you should consider returning it for different ram
  - if new ram of similar speed has the same issues you may have a defective cpu or motherboard and will need to replace it

### troubleshooting failed windows activation

- Verify that the product key you entered matches the one you purchased/obtained earlier.
- If the product keys match but Windows still failed to activate you may need to activate by phone.
  - There should be a button to do this via the `system > activation` screen.
  - Follow on-screen instructions.
  - Involves calling a number and answering prompts by voice and or your dial pad.
- I've never had phone activiation fail, but if it did somehow, you may have purchased a key that's already been used and will need to get a new one.

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

### config.json example

Note that if a setting is ommited from the configuration it will simply skip the logic to set that setting. So, you don't necessarily have to set everything to true or false. If you want to use Windows' default configuration for any given setting, simply omit it from `config.json`.

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
    "ShowFrequentlyUsedFoldersInQuickAccess": false,
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

### setting descriptions

- #### administrative
  - `DisableUacPopups` [`true`/`false`] - removes the "are you sure" popup when you doing anything that requires admin privileges
- #### cursor
  - `DisableEnhancedPointerPrecision` [`true`/`false`] - Disables enhanced pointer precision, a must for gaming, but just good in all cases to be honest.
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
  - `ShowMorePins` [`true`/`false`] - Allows for more pinned apps in the start menu as opposed to more recommendations. People sleep on the new start menu, apps that you use frequently that aren't already pinned to your taskbar should be pinned to your start menu. You also get pin folders for good orgnaiztion capabilities.
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
