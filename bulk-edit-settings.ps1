param(
  # administrative settings 
  [boolean]$disableUacPopups = $true, # removes the "are you sure" popup when you doing anything that requires admin privileges

  # cursor settings
  [boolean]$disableEnhancedPointerPrecision = $true, # disabled enhanced pointer precision, good for gaming, and everything else tbh
  [boolean]$disableEaseCursorMovement = $true, # disables "easing" cursor movement between displays, feels super jank when on

  # file explorer settings
  [boolean]$enableCompactView = $true, # this removes a lot of dead space in file explorer returning the way it looked/felt in windows 10
  [boolean]$moveRecycleBinToFileExplorer = $true, # removes the recycle bin shortcut from your desktop & places it in the navigation pane of file explorer
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
  [boolean]$centerAlignTaskbar = $true, # center aligns icons and start on the task bar, $false = left align
  [boolean]$showChatButtonOnTaskBar = $true, # hides the chat button on windows task bar
  [boolean]$showSearchOnTaskbar = $false, # hides search ui on windows task bar
  [int]$searchOnTaskbarType = 2, # if you set $showSearchOnTaskbar to $false it will use this version of search (1=compact | 2=search icon + label + box icon | 3=search icon + label)
  [boolean]$showTaskViewButtonOnTaskbar = $false, # hides the task view button on windows task bar
  [boolean]$showWidgetButtonOnTaskBar = $false, # hides the widgets button on windows task bar
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

function editRegistry($config) {
  Write-Host "Configuring settings..."

  $registryTweaks = [ordered]@{
    # administrative settings 
    disableUac = @(
      [pscustomobject]@{
        path = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System"
        property = "ConsentPromptBehaviorAdmin"
        propertyType = "DWord"
        propertyValue = $config.Administrative.DisableUacPopups ? 0 : 1
      },
      [pscustomobject]@{
        path = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System"
        property = "EnableLUA"
        propertyType = "DWord"
        propertyValue = 1
      },
      [pscustomobject]@{
        path = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System"
        property = "PromptOnSecureDesktop"
        propertyType = "DWord"
        propertyValue = $config.Administrative.DisableUacPopups ? 0 : 1
      }
    )

    # cursor settings
    disableEnhancedPointerPrecision = @(
      [pscustomobject]@{
        path = "HKCU:\Control Panel\Mouse"
        property = "MouseSpeed"
        propertyType = "String"
        propertyValue = $config.Cursor.DisableEnhancedPointerPrecision ? 0 : 1
      },
      [pscustomobject]@{
        path = "HKCU:\Control Panel\Mouse"
        property = "MouseThreshold1"
        propertyType = "String"
        propertyValue = $config.Cursor.DisableEnhancedPointerPrecision ? 0 : 6
      },
      [pscustomobject]@{
        path = "HKCU:\Control Panel\Mouse"
        property = "MouseThreshold2"
        propertyType = "String"
        propertyValue = $config.Cursor.DisableEnhancedPointerPrecision ? 0 : 10
      }
    )
    disableEaseCursorMovement = [pscustomobject]@{
      path = "HKCU:\Control Panel\Cursors"
      property = "CursorDeadzoneJumpingSetting"
      propertyType = "DWord"
      propertyValue = $config.Cursor.DisableEaseCursorMovement ? 0 : 1
    }

    # file explorer settings
    enableCompactView = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "UseCompactMode"
      propertyType = "DWord"
      propertyValue = $config.FileExplorer.EnableCompactView ? 1 : 0
    }
    moveRecycleBinToFileExplorer = @(
      [pscustomobject]@{
        path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"
        property = "{645FF040-5081-101B-9F08-00AA002F954E}"
        propertyType = "DWord"
        propertyValue = $config.FileExplorer.MoveRecycleBinToFileExplorer ? 1 : 0
      },
      [pscustomobject]@{
        path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu"
        property = "{645FF040-5081-101B-9F08-00AA002F954E}"
        propertyType = "DWord"
        propertyValue = $config.FileExplorer.MoveRecycleBinToFileExplorer ? 1 : 0
      },
      [pscustomobject]@{
        path = "HKCU:\Software\Classes\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}"
        property = "System.IsPinnedToNameSpaceTree"
        propertyType = "DWord"
        propertyValue = $config.FileExplorer.MoveRecycleBinToFileExplorer ? 1 : 0
      }
    )
    showFileExtensionsForKnownFileTypes = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "HideFileExt"
      propertyType = "DWord"
      propertyValue = $config.FileExplorer.ShowFileExtensionsForKnownFileTypes ? 0 : 1
    }
    showFrequentlyUsedFoldersInQuickAccess = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer"
      property = "ShowRecent"
      propertyType = "DWord"
      propertyValue = $config.FileExplorer.ShowFrequentlyUsedFoldersInQuickAccess ? 1 : 0
    }
    showHiddenFilesAndFolders = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "Hidden"
      propertyType = "DWord"
      propertyValue = $config.FileExplorer.ShowHiddenFilesAndFolders ? 1 : 0
    }
    showOfficeCloudFilesInQuickAccess = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer"
      property = "ShowCloudFilesInQuickAccess"
      propertyType = "DWord"
      propertyValue = $config.FileExplorer.ShowOfficeCloudFilesInQuickAccess ? 1 : 0
    }
    showRecentlyUsedFilesInQuickAccess = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer"
      property = "ShowRecent"
      propertyType = "DWord"
      propertyValue = $config.FileExplorer.ShowRecentlyUsedFilesInQuickAccess ? 1 : 0
    }

    # start menu settings
    showMorePins = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "Start_Layout"
      propertyType = "DWord"
      propertyValue = $config.StartMenu.ShowMorePins ? 1 : 0
    }
    showRecentlyAddedApps = [pscustomobject]@{
      path = "HKCU:\Software\Policies\Microsoft\Windows\Explorer"
      property = "HideRecentlyAddedApps"
      propertyType = "DWord"
      propertyValue = $config.StartMenu.ShowRecentlyAddedApps ? 0 : 1
    }
    showMostUsedApps = @(
      [pscustomobject]@{
        path = "HKCU:\Software\Policies\Microsoft\Windows\Explorer"
        property = "ShowOrHideMostUsedApps"
        propertyType = "DWord"
        propertyValue = $config.StartMenu.ShowMostUsedApps ? 1 : 0
      },
      [pscustomobject]@{
        path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
        property = "NoStartMenuMFUprogramsList"
        propertyType = "DWord"
        propertyValue = $config.StartMenu.ShowMostUsedApps ? 1 : 0
        delete = $showMostUsedApps
      },
      [pscustomobject]@{
        path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
        property = "NoInstrumentation"
        propertyType = "DWord"
        propertyValue = $config.StartMenu.ShowMostUsedApps ? 1 : 0
        delete = $showMostUsedApps
      }
    )
    showRecentlyOpenedItems = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "Start_TrackDocs"
      propertyType = "DWord"
      propertyValue = $config.StartMenu.ShowRecentlyOpenedItems ? 1 : 0
    }
    showRecomendations = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "Start_IrisRecommendations"
      propertyType = "DWord"
      propertyValue = $config.StartMenu.ShowRecomendations ? 1 : 0
    }

    # services settings

    # task bar settings
    showTaskbarOnAllDisplays = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "MMTaskbarEnabled"
      propertyType = "DWord"
      propertyValue = $config.Taskbar.ShowTaskbarOnAllDisplays ? 1 : 0
    }
    $centerAlignTaskbar = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "TaskbarAl"
      propertyType = "DWord"
      propertyValue = $config.Taskbar.CenterAlignTaskbar ? 1 : 0
    }
    showSearchOnTaskbar = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"
      property = "SearchboxTaskbarMode"
      propertyType = "DWord"
      propertyValue = $config.Taskbar.ShowSearchOnTaskbar ? $searchOnTaskbarType : 0
    }
    showTaskViewButtonOnTaskbar = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "ShowTaskViewButton"
      propertyType = "DWord"
      propertyValue = $config.Taskbar.ShowTaskViewButtonOnTaskbar ? 1 : 0
    }
    showWidgetButtonOnTaskBar = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "TaskbarDa"
      propertyType = "DWord"
      propertyValue = $config.Taskbar.ShowWidgetButtonOnTaskBar ? 1 : 0
    }
    showChatButtonOnTaskBar = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "TaskbarMn"
      propertyType = "DWord"
      propertyValue = $config.Taskbar.ShowChatButtonOnTaskBar ? 1 : 0
    }
    showSecondsOnClock = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "ShowSecondsInSystemClock"
      propertyType = "DWord"
      propertyValue = $config.Taskbar.ShowSecondsOnClock ? 1 : 0
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

function configureOtherSettings($config) {
  # network settings
  if(!$config.Network.BypassNetworkOptions){
    if($config.Network.EnableNetworkDiscovery){
      Set-NetFirewallRule -DisplayGroup "Network Discovery" -Enabled True -Profile Any
      Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled True -Profile Any
    } else {
      Set-NetFirewallRule -DisplayGroup "Network Discovery" -Enabled False -Profile Any
      Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled False -Profile Any
    }
  }

  # performance settings
  if($config.Performance.EnableUltimatePerformance) {
    powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61

    $currentPowerPlan = powercfg /GetActiveScheme
    
    if($currentPowerPlan -notlike "*e9a42b02-d5df-448d-aa00-03f14749eb61*"){
      powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
      powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61
    }
  } 

  if($config.Performance.DisableMonitorTimeout){
    powercfg -change -monitor-timeout-dc 0
    powercfg -change -monitor-timeout-ac 0
  } else {
    powercfg -change -monitor-timeout-dc $config.Performance.MonitorTimeout
    powercfg -change -monitor-timeout-ac $config.Performance.MonitorTimeout
  }

  if($config.Performance.DisableSleep) {
    powercfg -change -standby-timeout-dc 0
    powercfg -change -standby-timeout-ac 0
  } else {
    powercfg -change -standby-timeout-dc $config.Performance.StandbyTimeout
    powercfg -change -standby-timeout-ac $config.Performance.StandbyTimeout
  }

  if($config.Performance.DisableUsbSelectiveSuspend) {
    powercfg /SETDCVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
    powercfg /SETACVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
  } else {
    powercfg /SETDCVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 1
    powercfg /SETACVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 1
  }

}

function main {
  Write-Host "Starting process..."
  $config = Get-Content -Raw -Path "$PSScriptRoot\config.json" | ConvertFrom-Json
  editRegistry $config
  configureOtherSettings $config
  Write-Host "`n`nSettings have been configured, please restart your computer." -ForegroundColor green
  quit
}
 
main