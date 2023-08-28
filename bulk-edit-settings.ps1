param(
  # administrative settings 
  [boolean]$disableUac = $true, # removes the "are you sure" popup when you doing anything that requires admin privileges

  # cursor settings
  [boolean]$disableEnhancedPointerPrecision = $true, # disabled enhanced pointer precision, good for gaming, and everything else tbh
  [boolean]$disableEaseCursorMovement = $true, # disables "easing" cursor movement between displays, feels super jank when on

  # file explorer settings
  [boolean]$hideRecentlyUsedFilesInQuickAccess = $true, # prevents windows from showing recently used files in your quick access pin list in file explorer
  [boolean]$hideRecycleBinOnDesktop = $true, # removes the recycle bin shortcut from your desktop & places it in the navigation pane of file explorer
  [boolean]$showFileExtensionsForKnownFileTypes = $true, # prevents windows from hiding file extensions for "known" file types
  [boolean]$showHiddenFilesAndFolders = $true, # prevents windows from hiding files and folders in file explorer

  # network settings
  [boolean]$enableNetworkDiscovery = $true, # enables network discovery on private & public networks
  [boolean]$bypassNetworkOptions = $false, # this variable is for testing purposes, please set it to false if you're not testing the script

  # performance settings
  [boolean]$enableUltimatePerformance = $true, # enables windows' ultimate performance power plan

  # start menu settings
  [boolean]$showMorePinsOnStartMenu = $true, # gives more space for pinned apps vs suggested apps

  # task bar settings
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
    if(Test-Path -Path $registryTweak.path){
      Remove-Item -Path $registryTweak.path -Recurse -Force -Verbose
    }
  } else {
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
    hideRecentlyUsedFilesInQuickAccess = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "Start_TrackDocs"
      propertyType = "DWord"
      propertyValue = $hideRecentlyUsedFilesInQuickAccess ? 0 : 1
    }
    hideRecycleBinOnDesktop = @(
      [pscustomobject]@{
        path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\645FF040-5081-101B-9F08-00AA002F954E"
        delete = $hideRecycleBinOnDesktop ? $true : $false
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
    showHiddenFilesAndFolders = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "Hidden"
      propertyType = "DWord"
      propertyValue = $showHiddenFilesAndFolders ? 1 : 0
    }
    # start menu settings
    showMorePinsOnStartMenu = [pscustomobject]@{
      path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
      property = "Start_Layout"
      propertyType = "DWord"
      propertyValue = $showMorePinsOnStartMenu ? 1 : 0
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

  powercfg -change -monitor-timeout-dc 0
  powercfg -change -monitor-timeout-ac 0
  powercfg -change -standby-timeout-dc 0
  powercfg -change -standby-timeout-ac 0
  powercfg /SETDCVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
  powercfg /SETACVALUEINDEX SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
}
 
Write-Host "Starting process..."
editRegistry
configureOtherSettings
Write-Host "`n`nSettings have been configured, please restart your computer." -ForegroundColor green
quit