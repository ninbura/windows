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
    
    if($currentPropertyValue -ne $registryTweak.propertyValue -or $null -eq $currentPropertyValue) {
      New-ItemProperty -Path $registryTweak.path -Name $registryTweak.property -PropertyType $registryTweak.propertyType -Value $registryTweak.propertyValue -Force -Verbose
    }
  }
}

function editRegistry($config) {
  Write-Host "Configuring settings..."

  $registryTweaks = [ordered]@{}

  # administrative settings 
  if($null -ne $($config)?.Administrative?.DisableUacPopups){
    $registryTweaks.DisableUacPopups = @(
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
  }


  # cursor settings
  if($null -ne $($config)?.Cursor?.DisableEnhancedPointerPrecision){
    $registryTweaks.DisableEnhancedPointerPrecision = @(
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
  }

  if($null -ne $($config)?.Cursor?.DisableEaseCursorMovement){
    $registryTweaks.DisableEaseCursorMovement = [pscustomobject]@{
      path = "HKCU:\Control Panel\Cursors"
      property = "CursorDeadzoneJumpingSetting"
      propertyType = "DWord"
      propertyValue = $config.Cursor.DisableEaseCursorMovement ? 0 : 1
    }
  }


  # file explorer settings
  if($null -ne $($config)?.FileExplorer?.EnableCompactView){
    $registryTweaks.EnableCompactView = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "UseCompactMode"
      propertyType = "DWord"
      propertyValue = $config.FileExplorer.EnableCompactView ? 1 : 0
    }
  }

  if($null -ne $($config)?.FileExplorer?.MoveRecycleBinToFileExplorer){
    $registryTweaks.MoveRecycleBinToFileExplorer = @(
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
  }

  if($null -ne $($config)?.FileExplorer?.ShowFileExtensionsForKnownFileTypes){
    $registryTweaks.ShowFileExtensionsForKnownFileTypes = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "HideFileExt"
      propertyType = "DWord"
      propertyValue = $config.FileExplorer.ShowFileExtensionsForKnownFileTypes ? 0 : 1
    }
  }

  if($null -ne $($config)?.FileExplorer?.ShowHiddenFilesAndFolders){
    $registryTweaks.ShowHiddenFilesAndFolders = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "Hidden"
      propertyType = "DWord"
      propertyValue = $config.FileExplorer.ShowHiddenFilesAndFolders ? 1 : 0
    }
  }
  
  
  if($null -ne $($config)?.FileExplorer?.ShowRecentlyUsedFilesInQuickAccess){
    $registryTweaks.ShowRecentlyUsedFilesInQuickAccess = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer"
      property = "ShowRecent"
      propertyType = "DWord"
      propertyValue = $config.FileExplorer.ShowRecentlyUsedFilesInQuickAccess ? 1 : 0
    }
  }
  
  if($null -ne $($config)?.FileExplorer?.ShowFrequentlyUsedFoldersInQuickAccess){
    $registryTweaks.ShowFrequentlyUsedFoldersInQuickAccess = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer"
      property = "ShowFrequent"
      propertyType = "DWord"
      propertyValue = $config.FileExplorer.ShowFrequentlyUsedFoldersInQuickAccess ? 1 : 0
    }
  }

  if($null -ne $($config)?.FileExplorer?.ShowOfficeCloudFilesInQuickAccess){
    $registryTweaks.ShowOfficeCloudFilesInQuickAccess = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer"
      property = "ShowCloudFilesInQuickAccess"
      propertyType = "DWord"
      propertyValue = $config.FileExplorer.ShowOfficeCloudFilesInQuickAccess ? 1 : 0
    }
  }

  # if($null -ne $($config)?.FileExplorer?.ShowQuickAccessInHome) {
  #   $registryTweaks.ShowQuickAccessInHome = [pscustomobject]@{
  #     path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderMSGraph_WithRecommendations\NameSpace\DelegateFolders\{3936E9E4-D92C-4EEE-A85A-BC16D5EA0819}"
  #     property = "(Default)"
  #     propertyValue = "Frequent Places Folder"
  #   }
  # }

  # start menu settings
  if($null -ne $($config)?.StartMenu?.ShowMorePins){
    $registryTweaks.ShowMorePins = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "Start_Layout"
      propertyType = "DWord"
      propertyValue = $config.StartMenu.ShowMorePins ? 1 : 0
    }
  }

  if($null -ne $($config)?.StartMenu?.ShowRecentlyAddedApps){
    $registryTweaks.ShowRecentlyAddedApps = [pscustomobject]@{
      path = "HKCU:\Software\Policies\Microsoft\Windows\Explorer"
      property = "HideRecentlyAddedApps"
      propertyType = "DWord"
      propertyValue = $config.StartMenu.ShowRecentlyAddedApps ? 0 : 1
    }
  }

  if($null -ne $($config)?.StartMenu?.ShowMostUsedApps){
    $registryTweaks.ShowMostUsedApps = @(
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
  }

  if($null -ne $($config)?.StartMenu?.ShowRecentlyOpenedItems){
    $registryTweaks.ShowRecentlyOpenedItems = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "Start_TrackDocs"
      propertyType = "DWord"
      propertyValue = $config.StartMenu.ShowRecentlyOpenedItems ? 1 : 0
    }
  }

  if($null -ne $($config)?.StartMenu?.ShowRecomendations){
    $registryTweaks.ShowRecomendations = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "Start_IrisRecommendations"
      propertyType = "DWord"
      propertyValue = $config.StartMenu.ShowRecomendations ? 1 : 0
    }
  }


  # services settings
  if($null -ne $($config)?.Services?.DisableTelemetry){
    $registryTweaks.DisableTelemetry = [pscustomobject]@{
      path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
      property = "AllowTelemetry"
      propertyType = "DWord"
      propertyValue = $config.Services.DisableTelemetry ? 0 : 1
    }
  }


  # task bar settings
  if($null -ne $($config)?.Taskbar?.ShowTaskbarOnAllDisplays){
    $registryTweaks.ShowTaskbarOnAllDisplays = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "MMTaskbarEnabled"
      propertyType = "DWord"
      propertyValue = $config.Taskbar.ShowTaskbarOnAllDisplays ? 1 : 0
    }
  }

  if($null -ne $($config)?.Taskbar?.CenterAlignTaskbarItems){
    $registryTweaks.CenterAlignTaskbarItems = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "TaskbarAl"
      propertyType = "DWord"
      propertyValue = $config.Taskbar.CenterAlignTaskbarItems ? 1 : 0
    }
  }

  if($null -ne $($config)?.Taskbar?.ShowSearch){
    $searchStyle = $null -ne $config.Taskbar?.SearchStyle ? $config.Taskbar.SearchStyle : 2

    $registryTweaks.ShowSearch = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search"
      property = "SearchboxTaskbarMode"
      propertyType = "DWord"
      propertyValue = $config.Taskbar.ShowSearch ? $searchStyle : 0
    }
  }

  if($null -ne $($config)?.Taskbar?.ShowTaskViewButton){
    $registryTweaks.ShowTaskViewButton = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "ShowTaskViewButton"
      propertyType = "DWord"
      propertyValue = $config.Taskbar.ShowTaskViewButton ? 1 : 0
    }
  }

  if($null -ne $($config)?.Taskbar?.ShowWidgetsButton){
    $registryTweaks.ShowWidgetsButton = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "TaskbarDa"
      propertyType = "DWord"
      propertyValue = $config.Taskbar.ShowWidgetsButton ? 1 : 0
    }
  }

  if($null -ne $($config)?.Taskbar?.ShowChatButton){
    $registryTweaks.ShowChatButton = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "TaskbarMn"
      propertyType = "DWord"
      propertyValue = $config.Taskbar.ShowChatButton ? 1 : 0
    }
  }

  if($null -ne $($config)?.Taskbar?.ShowSecondsOnClock){
    $registryTweaks.ShowSecondsOnClock = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "ShowSecondsInSystemClock"
      propertyType = "DWord"
      propertyValue = $config.Taskbar.ShowSecondsOnClock ? 1 : 0
    }
  }
  

  # apply registry tweaks
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
  if($null -ne $($config)?.Network?.EnableNetworkDiscovery) {
    if($config.Network.EnableNetworkDiscovery){
      Set-NetFirewallRule -DisplayGroup "Network Discovery" -Enabled True -Profile Any
      Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled True -Profile Any
    } else {
      Set-NetFirewallRule -DisplayGroup "Network Discovery" -Enabled False -Profile Any
      Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled False -Profile Any
    }
  }

  # performance settings
  if($null -ne $($config)?.Performance?.EnableUltimatePerformance) {
    if($config.Performance.EnableUltimatePerformance) {
      powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61
  
      $currentPowerPlan = powercfg /GetActiveScheme
      
      if($currentPowerPlan -notlike "*e9a42b02-d5df-448d-aa00-03f14749eb61*"){
        powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
        powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61
      }
    } 
  }

  if($null -ne $($config)?.Performance?.DisableMonitorTimeout) {
    if($config.Performance.DisableMonitorTimeout){
      powercfg -change -monitor-timeout-dc 0
      powercfg -change -monitor-timeout-ac 0
    } else {
      $monitorTimeout = $null -ne $config.Performance?.MonitorTimeout ? $config.Performance.MonitorTimeout : 15

      powercfg -change -monitor-timeout-dc $monitorTimeout
      powercfg -change -monitor-timeout-ac $monitorTimeout
    }
  }

  if($null -ne $($config)?.Performance?.DisableSleep) {
    if($config.Performance.DisableSleep) {
      powercfg -change -standby-timeout-dc 0
      powercfg -change -standby-timeout-ac 0
    } else {
      $standbyTimeout = $null -ne $config.Performance?.StandbyTimeout ? $config.Performance.StandbyTimeout : 15

      powercfg -change -standby-timeout-dc $standbyTimeout
      powercfg -change -standby-timeout-ac $standbyTimeout
    }
  }

  if($null -ne $($config)?.Performance?.DisableUsbSelectiveSuspend) {
    if($config.Performance.DisableUsbSelectiveSuspend) {
      powercfg /SETDCVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
      powercfg /SETACVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
    } else {
      powercfg /SETDCVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 1
      powercfg /SETACVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 1
    }
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
