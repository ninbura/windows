# Table of Contents

- [steps](#steps)
    1.  [Mount the Windows 11 ISO/Installer to a Bootable Flash Drive using Rufus](#mount-the-windows-11-isoinstaller-to-a-bootable-flash-drive-using-rufus)
    2.  [Update & Configure Your Motherboard's BIOS](#update--configure-your-motherboards-bios)
    3.  [Install Windows](#install-windows)
    4.  [Verify that Windows is Activated](#verify-that-windows-is-activated)
    5.  [Update Windows](#update-windows)
    6.  [Update Microsoft Store Apps](#update-microsoft-store-apps)
    7.  [Install Optional Features (Windows N Editions)](#install-optional-features-windows-n-editions)
    8.  [Configure Windows Settings](#configure-windows-settings)
    9.  [Configure winget & manually install a few applications](#configure-winget--manually-install-a-few-applications)
    10. [configure windows terminal](#configure-windows-terminal)
    11. [Download, configure, & run the `bulk-edit-settings` PowerShell script.](#Download-configure--run-the-bulk-edit-settings-PowerShell-script)
    12. [manually configure other windows settings](#manually-configure-other-windows-settings)
    13. [download/install system drivers](#downloadinstall-system-drivers)
    14. [UniGetUI - bulk install/update applications](#UniGetUI---bulk-installupdate-applications)
    15. [verify that system temperatures are in-check](#verify-that-system-temperatures-are-in-check)
    16. [download/install remaining software](#downloadinstall-remaining-software)
    17. [configure audio settings](#configure-audio-settings)
    18. [configure rgb lighting](#configure-rgb-lighting)
- [drivers](#drivers)
- [software](#software)
- [troubleshooting](#troubleshooting)

# Suggested Prerequisites
- A currently functioning computer running Windows.
- A USB 2.0 flash drive under 32GB in size.
- A USB 3.0 flash drive greater than 8GB in size.
- A Windows 11 Pro For Workstations product key.
    - If you have a business grade microsoft account for work, you may be able to obtain a key for free [here](https://my.visualstudio.com/Downloads?q=Windows%2011).
    - Otherwise, [this](https://wholsalekeys.com/shop/windows-11-pro-for-workstations/) is a good place to buy cheap keys.

# steps
1. ### Mount the Windows 11 ISO/Installer to a Bootable Flash Drive using Rufus
    - USB 3.0 drive preffered
    - must be greater than 8GB
2. ### Update & Configure Your Motherboard's BIOS
    1. update BIOS via GUI or advanced "Flashback"
       - USB 2.0 flash drive preferred
       - must be smaller than 32GB & formatted as FAT32
    2. configure BIOS
        - enable virtual or physical TPM (usually on by default)
        - verify that secure boot is *enabled and active*
        - enable XMP/EXPO/DOCP (memory profile)
        - adjust system fan curves as desired
3. ### Install Windows
    - Under construction
    - It's best to put your key in up-front if you have it, for enterprise it'll figure that out during the later setup when you say "for work".
    - When choosing the disk you want to install Windows on, make sure you're deleted all the partitions on it so it shows as one entry.
4. ### Verify that Windows is Activated
    - open settings & navigate to `system > activation`
    - If it says activation failed don't panic, see [troubleshooting failed windows activation](#troubleshooting-failed-windows-activation).
5. ### Update Windows
    - Open the Settings app & navigate to `Windows Updates`.
    - Optionally, toggle "Get the latest updates as soon as they're available"; I personally suggest doing this.
    - Check for updates & wait for them to download/install.
    - Restart your computer.
    - Check for updates again.
    - If you have more updates and pc requests restarting again, do so.
    - Repeat until Windows states that everything is up-to-date.
6. ### Update Microsoft Store Apps
    1. Open the Microsoft Store via your Start Menu.
    2. Click the "library" or "downloads" button (version dependent) in the bottom left hand corner of the window.
    3. Select "Get Updates" in the top right hand corner of the window.
    4. Wait until all updates have been retreived, should be a little loading symbol to reference.
    5. Select "Update All" just left of the "Get Updates" button.
    6. Wait for all Microsoft Store applications to update before proceeding.
7. ### Install Optional Features (Windows N Editions)
    1. Open Windows Settings & navigate to "System" > "Optional Features" > "View Features" > "See available features".
    3. Search "Media" & Install "Media Feature Pack.
    4. Note that if install fails, just repeat the steps to try again, sometimes it takes 2 tries.
    5. Open Microsoft Store.
    6. Search & Install "Xbox" app.
    7. Open Xbox app & sign in.
    8. Uncheck all the "Get ready to play" toggles.
    9. Click your username/photo in the top right, then click Settings.
    10. Navigate to "App" & install missing dependencies.
    11. Open Windows Settings & Navigate to 
8. ### Configure Windows Settings
    - Mouse Acceleration
        1. Open Control Panel.
        2. Click "Hardware And Sound" > "Mouse" (Devices and Printers).
        3. Click the "Pointer Option" tab & uncheck "Enhance pointer precision".
    - UAC Prompts
        - Do at your own risk, technically this makes it easier to perform administrative actions.
        1. Open Control Panel.
        2. Navigate to "User Accounts" > "User Accounts" > "Change User Account Control Settings".
        3. Drag the slider to "Never notify".
    - Advanced Settings
        1. Open Windows Settings & navigate to "System" > "Advanced" > "File Explorer".
            1. Toggle "Show file extensions" on
            2. Toggle "Show hidden and system files" on
        2. Navigate back to "Advanced"
        3. Set Terminal to "Windows Terminal"
        4. Expand the "PowerShell" menu & enable "Change execution policy to allow..."
        5. Enable sudo, Expand the sudo menu, and set "Configure how sudo runs applications to "Inline".
    - Personalization
        1. Open Windows Settings & navigate to "Personalization" > "Colors".
            1. Set "Choose your mode" to "Dark".
            2. Set your Accent color per your desire.
        2. Navigate to "Personalization" > "Themes" > "Desktop icon settings"
            1. Before you uncheck "Recycle Bin", pin it to your Favorites in File Explorer.
            2. Open your Recyle Bin by double clicking the icon on your desktop.
            3. Drag the "Recycle Bin" text from from the URL bar in File Explorer to your pinned section, I put it at the bottom.
            4. Uncheck "Recycle Bin" in the "Desktop icon settings" dialog we opened earlier.
        3. Navigate to "Personalization" > "Lock screen"
            1. Set "Lock screen status" to "None".
        4. Navigate to "Personalization" > "Start"
            1. Toggle off "Show reccomended files int Start...".
            2. Toggle off "Show recommendatoins for tips...".
            3. Toggle off "Show account-related notifications.
        5. Navigate to "Personalization" > "Taskbar".
            1. Set "Search" to "Hide" & untoggle all other "Taskbar items".
            2. Expand the "Taskbar behaviors" menu.
            3. Uncheck "Show flashing taskbar apps", and "Show my taskbar on all displays".
    - Date & Time
        - Date & Time Format
            1. Open Control Panel.
            2. Click "Clock & Region" > "Date & Time".
            3. Click the "Change date and time..." button.
            4. Click the "Change calendar settings" hyperlink.
            5. Click the "Additional settings..." button.
            6. Click the "Time" tab.
                1. Set "Short time:" to `HH:mm`.
                2. Set "Long time:" to `HH:mm:ss`.
            7. Click the "Date" tab.
                1. Set "Short Date:" to `yyyy/MM/dd`.
        - Taskbar & Notification Tray
            1. Open Windows Settings & navigate to "Time & Language" > "Date & Time".
            3. Toggle "Show time in Notification Center" on.
            4. Expand "Show time and date in the System try" & enable "Show seconds in system tray clock".
    - File Explorer
        1. Open File Explorer, Click "View" > "Show", and enable "Compact view".
        2. Cick the ellipsis (...) in the ribbon, and click "Options".
        3. Uncheck everything in the "Privacy" section, apply & close.
    - Network File Sharing
        1. Open Windows Settings & Navigate to "Network & internet" > "Advanced network settings" > "Advanced sharing settings".
        2. Toggle on all toggles in each section.
        3. Open File Explorer and navigate to "This PC".
        4. Right click your `C` drive, and then "Properties" > "Sharing" (tab) > "Advanced Sharing".
        5. Check "Share this folder", supply a Share name (ie GamePC), click Permissions, and check Allow on everything, "OK", "Apply", and "OK".
    - Performance Settings
        1. Open Control Panel & navigate to "Hardware and Sound" > "Power Options".
        2. Expand the "Hide additional plans" menu, and select "Ultimate Performance" or "High Performance" if the former isn't showing.
        3. Click the "Change plan settings" hyperlink on the plan you enabled, and configure display & computer sleep to your liking.
        4. Click the "change advanced power settings" hyperlink, expand the "USB settings" > "USB selective suspend setting" and disable it.
9. ### Configure winget & manually install a few applications
    1. right click the start button and click `Terminal`
    2. run/enter the following commands in Windows Terminal
    3. enable InstallerHasOverride
        - ```PowerShell
          sudo winget settings --enable InstallerHashOverride
          ```
    4. install PowerShell 7 & Git
        - ```PowerShell
          winget install Microsoft.PowerShell Git.Git
          ```
    5. install your internet browser of choice
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
          git clone https://github.com/ninbura/windows $HOME/repos/windows
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
13. ### download/install system drivers
    - see [drivers](#drivers) list below
    - Note that every driver you need may not be listed below, said list is composed of items relevant to me and my direct peers.
    - you don't need to restart your computer when prompted after every single driver
    - restart your computer after installing all drivers
14. ### UniGetUI - bulk install/update applications
    1. install & open UniGetUI
        - ```PowerShell
          winget install MartiCliment.UniGetUI
          ```
    2. click on "Package Bundles" in the left-hand side menu
    3. Load the `~/repos/windows/unigetui-package-bundles/dependencies.ubundle` bundle, check the box in the header to select all applications, and click "Install Selection".
    4. wait for dependencies to finish installing
    5. load the `~/repos/windows/unigetui-package-bundles/apps.ubundle` bundle, select the apps you'd like to install, and and click "Install Selection".
    6. wait for apps to finish installing
15. ### verify that system temperatures are in-check
    - under construction
    - see [troubleshooting high temperatures](#troubleshooting-high-temperatures) if temps are high
16. ### download/install remaining software
    - see [software](#software) section below
    - just like drivers you don't need to restart your computer when prompted after every single install
    - restart your computer after installing all desired software (if you were prompted at somepoint to do so)
    - Note that every piece of software you want may not have been included in your `apps.ubundle`, and or may not be listed in the [software](#software) section below. Said lists are composed of items relevant to me and my direct peers.
    - software in the section below is software that can not currently be installed properly via winget/UniGetUI
    - It is _always_ preferred you install software with winget/UniGetUI, it's much quicker & UniGetUI will keep your software updated.
    - If software isn't available via winget/UniGetUi, install software the old fashioned way 😭
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

- **Many drivers will need be downloaded from your motherboard's support page**, others are typically universal.
- If your motherboard uses intel drivers for bluetooth, lan (ethernet), & wan (wifi) you can use the links below to get the latest versions.
- To verify that your motherboard uses universal intel drivers, you'll need to go to your motherboards support page.
- Take note of your motherboard's model number, should be listed on the box it came in, or you can use HWiNFO to retreive it.
    - ```PowerShell
      winget install REALiX.HWiNFO
      ```   
- search for your motherboard via it's model number on google & locate the support page

### motherboard specific drivers

- look for the following drivers on your motherboard's support/driver page
- audio drivers
  - usually labeled as Realtek
  - only grab latest version, don't need mulitple motherboard audio drivers
- intel chipset drivers (intel cpus only)
  - there may be multiple "chipset" style drivers
  - look for drivers titled as so
    - Intel Serial I/O
    - Intel Management Engine
    - Intel INF
    - Intel HID
    - etc
  - you should see one or many of the aformentioned intel chipset drivers
- communication drivers
  - If LAN, Wifi, or Bluetooth drivers are listed as Intel, I would suggest using the links below in-favor of the drivers on the Motherboard support page. They are more up to date.
  - drivers
    - Bluetooth
    - LAN (ethernet / wired internet driver)
    - WAN (wifi driver)
- sata drivers
    - typically labeled as "Intel Rapid Storage Technology" or "AMD SATA"

### Intel

- check motherboard page to make sure your motherboard uses intel for these devices
- [Bluetooth](https://www.intel.com/content/www/us/en/support/articles/000005489/wireless.html)
- [LAN](https://www.intel.com/content/www/us/en/download/727998/intel-network-adapter-driver-for-microsoft-windows-11.html)
- [WAN](https://www.intel.com/content/www/us/en/download/19351/windows-10-and-windows-11-wi-fi-drivers-for-intel-wireless-adapters.html)
- [graphics](https://www.intel.com/content/www/us/en/download/785597/intel-arc-iris-xe-graphics-windows.html)

### [AMD CPU/chipset & GPU](https://www.amd.com/en/support)

- I would uncheck installing AMD's powerplan when installing AMD chipset/CPU drivers
- you'll also want to select the "clean install" option when installing AMD GPU drivers

### Nvidia ([direct drivers](https://www.nvidia.com/download/index.aspx) | [Nvidia App (preferred)](https://www.nvidia.com/en-us/software/nvidia-app/))

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

- [**AVerMedia Assist Central Pro**](https://www.avermedia.com/support/download) (AVerMedia capture card firmware/software)
- [**Dante Controller**](https://my.audinate.com/support/downloads/dante-controller) (Audinate/Dante audio router)
- [**DaVinci Resolve**](https://www.blackmagicdesign.com/products/davinciresolve) (download link near the bottom of the page)
- [**EasyBCD**](https://neosmart.net/EasyBCD/) (tool for dual booting)
- [**FFXIV Launcher**](https://na.finalfantasyxiv.com/lodestone/playguide/#returner) (square enix's final fantasy 14 launcher)
- [**iReboot**](https://neosmart.net/iReboot/) (tool for dual booting)
- [**Nvidia App**](https://www.nvidia.com/en-us/software/nvidia-app/) (new Nvidia app that aims to replace GeForce Now & Nvidia Control Panel)
- [**OBS Advanced Scene Switcher**](https://github.com/WarmUpTill/SceneSwitcher/releases) (OBS plugin)
- [**OBS Audio Monitor**](https://obsproject.com/forum/resources/audio-monitor.1186/) (OBS plugin)
- [**Jagex Launcher**](https://www.jagex.com/en-GB/launcher) (RuneScape client)
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
