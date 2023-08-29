param(
  # administrative settings 
  [boolean]$disableUac = $true, # removes the "are you sure" popup when you doing anything that requires admin privileges

  # cursor settings
  [boolean]$disableEnhancedPointerPrecision = $true, # disabled enhanced pointer precision, good for gaming, and everything else tbh
  [boolean]$disableEaseCursorMovement = $true, # disables "easing" cursor movement between displays, feels super jank when on

  # file explorer settings
  [boolean]$hideRecycleBinOnDesktop = $true, # removes the recycle bin shortcut from your desktop & places it in the navigation pane of file explorer
  [boolean]$showFileExtensionsForKnownFileTypes = $true, # prevents windows from hiding file extensions for "known" file types
  [boolean]$showFrequentlyUsedFoldersInQuickAccess = $false, # allows windows to show recently used folders in your quick access pin list in file explorer
  [boolean]$showHiddenFilesAndFolders = $true, # prevents windows from hiding files and folders in file explorer
  [boolean]$showOfficeCloudFilesInQuickAccess = $false, # allows windows to show cloud files from office.com in your quick access pin list in file explorer
  [boolean]$showRecentlyUsedFilesInQuickAccess = $false, # allows windows to show recently used files in your quick access pin list in file explorer

  # network settings
  [boolean]$enableNetworkDiscovery = $true, # enables network discovery on private & public networks
  [boolean]$bypassNetworkOptions = $false, # if $true network options are skipped, this greatly increases run time of this script, you only need to run network options once for them to take

  # performance settings
  [boolean]$enableUltimatePerformance = $true, # enables windows' ultimate performance power plan, give you best possible performance but at the expense of power consumption
  [boolean]$disableMonitorTimeout = $true, # prevents your monitors from turning themselves off after a certain number of inactive minutes
  [int]$monitorTimeout = 15, # if $disableMonitorTimeout is set to false, this is the number of minutes of inactivity it will take before your monitors turn off
  [boolean]$disableSleep = $true, # prevents your computer from entering sleep after a certain number of inactive minutes, highly reccomended for desktop computers
  [int]$standbyTimeout = 60, # if $disableSleep is set to false, this is the number of minutes of inactivity it will take before your computer goes into standby/sleep
  [boolean]$disableUsbSelectiveSuspend = $true, # this prevents windows from disconnecting usb devices after a certain amount of inactivity from said device

  # start menu settings
  [boolean]$showMorePinsOnStartMenu = $true, # gives more space for pinned apps vs suggested apps
  [boolean]$showRecentlyAddedApps = $true, # puts entries at the bottom of the start menu for recently installed apps
  [boolean]$showMostUsedApps = $true, # puts entries at the bottom of the start menu for most used apps
  [boolean]$showRecentlyOpenedItems = $true, # this is techinically the setting for start and the task bar, I suggest you leave this enabled
  [boolean]$showRecomendations = $false, # puts reccomended entries at the bottom of the start menu (tips, shortcuts, new apps, etc.)

  # task bar settings
  [boolean]$centerAlignTaskbar = $true, # center aligns icons and start on the task bar
  [boolean]$hideChatButtonOnTaskBar = $true, # hides the chat button on windows task bar
  [boolean]$hideSearchOnTaskbar = $true, # hides search ui on windows task bar
  [int]$searchOnTaskbarType = 2, # if you set $hideSearchOnTaskbar to $false it will use this version of search (1=compact | 2=search icon + label + box icon | 3=search icon + label)
  [boolean]$hideTaskViewButtonOnTaskbar = $true, # hides the task view button on windows task bar
  [boolean]$hideWidgetButtonOnTaskBar = $true, # hides the widgets button on windows task bar
  [boolean]$showSecondsOnClock = $true, # shows seconds on system clock in the left had corner of the windows taskbar
  [boolean]$showTaskbarOnAllDisplays = $false # hides taskbar on secondary displays
)

function quit () {
  write-host('closing program, press [enter] to exit...') -NoNewLine
  $Host.UI.ReadLine()

  exit
}

function modifyRegistry($registryTweak) {
  if($registryTweak.delete){
    if($null -ne $registryTweak.property) {
      if(Test-Path -Path $registryTweak.path){
        $currentPropertyValue = (Get-ItemProperty -Path $registryTweak.path).$($registryTweak.property)
      }
  
      if($null -ne $currentPropertyValue){
        Remove-ItemProperty -Path $registryTweak.path -Name $registryTweak.property -Force -Verbose
      }
    } else {
      Remove-Item -Path $registryTweak.path -Recurse -Force -Verbose
    }

  } elseif ($null -ne $registryTweak.propertyValue) {
    if(!(Test-Path -Path $registryTweak.path)){
      New-Item -Path $registryTweak.path -Force -Verbose
    }

    $currentPropertyValue = (Get-ItemProperty -Path $registryTweak.path).$($registryTweak.property)
    
    if($currentPropertyValue -ne $registryTweak.propertyValue) {
      New-ItemProperty -Path $registryTweak.path -Name $registryTweak.property -PropertyType $registryTweak.propertyType -Value $registryTweak.propertyValue -Force -Verbose
    } elseif($null -eq $currentPropertyValue) {
      New-ItemProperty -Path $registryTweak.path -Name $registryTweak.property -PropertyType $registryTweak.propertyType -Value $registryTweak.propertyValue -Force -Verbose
    }
  }
}

function editRegistry() {
  Write-Host "Configuring settings..."

  $registryTweaks = [ordered]@{
    # administrative settings 
    disableUac = [pscustomobject]@{
      path = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System"
      property = "EnableLUA"
      propertyType = "DWord"
      propertyValue = $disableUac ? 0 : 1
    }
    # cursor settings
    disableEnhancedPointerPrecision = @(
      [pscustomobject]@{
        path = "HKCU:\Control Panel\Mouse"
        property = "MouseSpeed"
        propertyType = "String"
        propertyValue = $disableEnhancedPointerPrecision ? 0 : 1
      },
      [pscustomobject]@{
        path = "HKCU:\Control Panel\Mouse"
        property = "MouseThreshold1"
        propertyType = "String"
        propertyValue = $disableEnhancedPointerPrecision ? 0 : 6
      },
      [pscustomobject]@{
        path = "HKCU:\Control Panel\Mouse"
        property = "MouseThreshold2"
        propertyType = "String"
        propertyValue = $disableEnhancedPointerPrecision ? 0 : 10
      }
    )
    disableEaseCursorMovement = [pscustomobject]@{
      path = "HKCU:\Control Panel\Cursors"
      property = "CursorDeadzoneJumpingSetting"
      propertyType = "DWord"
      propertyValue = $disableEaseCursorMovement ? 0 : 1
    }
    # file explorer settings
    hideRecycleBinOnDesktop = @(
      [pscustomobject]@{
        path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"
        property = "{645FF040-5081-101B-9F08-00AA002F954E}"
        propertyType = "DWord"
        propertyValue = $hideRecycleBinOnDesktop ? 1 : 0
      },
      [pscustomobject]@{
        path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu"
        property = "{645FF040-5081-101B-9F08-00AA002F954E}"
        propertyType = "DWord"
        propertyValue = $hideRecycleBinOnDesktop ? 1 : 0
      },
      [pscustomobject]@{
        path = "HKCU:\Software\Classes\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}"
        property = "System.IsPinnedToNameSpaceTree"
        propertyType = "DWord"
        propertyValue = $hideRecycleBinOnDesktop ? 1 : 0
      }
    )
    showFileExtensionsForKnownFileTypes = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "HideFileExt"
      propertyType = "DWord"
      propertyValue = $showFileExtensionsForKnownFileTypes ? 0 : 1
    }
    showFrequentlyUsedFoldersInQuickAccess = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer"
      property = "ShowRecent"
      propertyType = "DWord"
      propertyValue = $showFrequentlyUsedFoldersInQuickAccess ? 1 : 0
    }
    showHiddenFilesAndFolders = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "Hidden"
      propertyType = "DWord"
      propertyValue = $showHiddenFilesAndFolders ? 1 : 0
    }
    showOfficeCloudFilesInQuickAccess = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer"
      property = "ShowCloudFilesInQuickAccess"
      propertyType = "DWord"
      propertyValue = $showOfficeCloudFilesInQuickAccess ? 1 : 0
    }
    showRecentlyUsedFilesInQuickAccess = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer"
      property = "ShowRecent"
      propertyType = "DWord"
      propertyValue = $showRecentlyUsedFilesInQuickAccess ? 1 : 0
    }

    # start menu settings
    $centerAlignTaskbar = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "TaskbarAl"
      propertyType = "DWord"
      propertyValue = $centerAlignTaskbar ? 1 : 0
    }
    showMorePinsOnStartMenu = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "Start_Layout"
      propertyType = "DWord"
      propertyValue = $showMorePinsOnStartMenu ? 1 : 0
    }
    showRecentlyAddedApps = [pscustomobject]@{
      path = "HKCU:\Software\Policies\Microsoft\Windows\Explorer"
      property = "HideRecentlyAddedApps"
      propertyType = "DWord"
      propertyValue = $showRecentlyAddedApps ? 0 : 1
    }
    showMostUsedApps = @(
      [pscustomobject]@{
        path = "HKCU:\Software\Policies\Microsoft\Windows\Explorer"
        property = "ShowOrHideMostUsedApps"
        propertyType = "DWord"
        propertyValue = $showMostUsedApps ? 1 : 0
      },
      [pscustomobject]@{
        path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
        property = "NoStartMenuMFUprogramsList"
        propertyType = "DWord"
        propertyValue = $showMostUsedApps ? 1 : 0
        delete = $showMostUsedApps
      },
      [pscustomobject]@{
        path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
        property = "NoInstrumentation"
        propertyType = "DWord"
        propertyValue = $showMostUsedApps ? 1 : 0
        delete = $showMostUsedApps
      }
    )
    showRecentlyOpenedItems = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "Start_TrackDocs"
      propertyType = "DWord"
      propertyValue = $showRecentlyOpenedItems ? 1 : 0
    }
    showRecomendations = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "Start_IrisRecommendations"
      propertyType = "DWord"
      propertyValue = $showRecomendations ? 1 : 0
    }
    # task bar settings
    hideChatButtonOnTaskBar = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "TaskbarMn"
      propertyType = "DWord"
      propertyValue = $hideChatButtonOnTaskBar ? 0 : 1
    }
    hideSearchOnTaskbar = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"
      property = "SearchboxTaskbarMode"
      propertyType = "DWord"
      propertyValue = $hideSearchOnTaskbar ? 0 : $searchOnTaskbarType
    }
    hideTaskViewButtonOnTaskbar = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "ShowTaskViewButton"
      propertyType = "DWord"
      propertyValue = $hideTaskViewButtonOnTaskbar ? 0 : 1
    }
    hideWidgetButtonOnTaskBar = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "TaskbarDa"
      propertyType = "DWord"
      propertyValue = $hideWidgetButtonOnTaskBar ? 0 : 1
    }
    showSecondsOnClock = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "ShowSecondsInSystemClock"
      propertyType = "DWord"
      propertyValue = $showSecondsOnClock ? 1 : 0
    }
    showTaskbarOnAllDisplays = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "MMTaskbarEnabled"
      propertyType = "DWord"
      propertyValue = $showTaskbarOnAllDisplays ? 1 : 0
    }
  }

  foreach ($key in $registryTweaks.keys) {
    $registryTweak = $registryTweaks[$Key]

    if($registryTweak -is [array]) {
      foreach($_registryTweak in $registryTweak) {
        modifyRegistry $_registryTweak
      }
    } else {
      modifyRegistry $registryTweak
    }
  }
}

function configureOtherSettings(){
  # network settings
  if(!$bypassNetworkOptions){
    if($enableNetworkDiscovery){
      Set-NetFirewallRule -DisplayGroup "Network Discovery" -Enabled True -Profile Any
      Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled True -Profile Any
    } else {
      Set-NetFirewallRule -DisplayGroup "Network Discovery" -Enabled False -Profile Any
      Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled False -Profile Any
    }
  }

  # performance settings
  if($enableUltimatePerformance) {
    powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61

    $currentPowerPlan = powercfg /GetActiveScheme
    
    if($currentPowerPlan -notlike "*e9a42b02-d5df-448d-aa00-03f14749eb61*"){
      powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
      powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61
    }
  } 

  if($disableMonitorTimeout){
    powercfg -change -monitor-timeout-dc 0
    powercfg -change -monitor-timeout-ac 0
  } else {
    powercfg -change -monitor-timeout-dc $monitorTimeout
    powercfg -change -monitor-timeout-ac $monitorTimeout
  }

  if($disableSleep) {
    powercfg -change -standby-timeout-dc 0
    powercfg -change -standby-timeout-ac 0
  } else {
    powercfg -change -standby-timeout-dc $standbyTimeout
    powercfg -change -standby-timeout-ac $standbyTimeout
  }

  if($disableUsbSelectiveSuspend) {
    powercfg /SETDCVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
    powercfg /SETACVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
  } else {
    powercfg /SETDCVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 1
    powercfg /SETACVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 1
  }

}
 
Write-Host "Starting process..."
editRegistry
configureOtherSettings
Write-Host "`n`nSettings have been configured, please restart your computer." -ForegroundColor green
quit
