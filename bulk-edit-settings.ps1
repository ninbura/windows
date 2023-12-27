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
    $centerAlignTaskbarItems = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "TaskbarAl"
      propertyType = "DWord"
      propertyValue = $config.Taskbar.CenterAlignTaskbarItems ? 1 : 0
    }
    showSearch = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"
      property = "SearchboxTaskbarMode"
      propertyType = "DWord"
      propertyValue = $config.Taskbar.ShowSearch ? $config.Taskbar.SearchStyle : 0
    }
    showTaskViewButton = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "ShowTaskViewButton"
      propertyType = "DWord"
      propertyValue = $config.Taskbar.ShowTaskViewButton ? 1 : 0
    }
    showWidgetButton = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "TaskbarDa"
      propertyType = "DWord"
      propertyValue = $config.Taskbar.ShowWidgetButton ? 1 : 0
    }
    showChatButton = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "TaskbarMn"
      propertyType = "DWord"
      propertyValue = $config.Taskbar.ShowChatButton ? 1 : 0
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