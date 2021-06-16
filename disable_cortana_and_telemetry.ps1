#requires -runasadministrator
#requires -version 4.0

# Disabling Cortana
If (-Not (Test-Path "HKCU:\Software\Microsoft\Personalization\Settings")) {
    New-Item -Path "HKCU:\Software\Microsoft\Personalization\Settings" -Force
}
Set-ItemProperty "HKCU:\Software\Microsoft\Personalization\Settings" "AcceptedPrivacyPolicy" 0
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" "CortanaEnabled" 0

If (-Not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force
}
Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" "AllowCortana" 0

# Disable Bing Web Search
Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" "DisableWebSearch" 1

# Disable Connected Search
Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" "ConnectedSearchPrivacy" 3
Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" "ConnectedSearchSafeSearch" 3
Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" "ConnectedSearchUseWeb" 0
Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" "ConnectedSearchUseWebOverMeteredConnections" 0

If (-Not (Test-Path "HKCU:\Software\Microsoft\InputPersonalization")) {
    New-Item -Path "HKCU:\Software\Microsoft\InputPersonalization" -Force
}
Set-ItemProperty "HKCU:\Software\Microsoft\InputPersonalization" "RestrictImplicitTextCollection" 1
Set-ItemProperty "HKCU:\Software\Microsoft\InputPersonalization" "RestrictImplicitInkCollection" 1

If (-Not (Test-Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore")) {
    New-Item -Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore" -Force
}
Set-ItemProperty "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore" "HarvestContacts" 0

# Disable Cortana on Taskbar
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" "SearchboxTaskbarMode" 0

Write-Host "Removed Cortana"
Write-Host "++ Run cleanup/rem-sysapps.ps1 to remove cortana exe"

# Disable Telemetry in Software Policies
If (-Not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"))
{
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Name DataCollection
}
Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "AllowTelemetry" 0
Set-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DataCollection" "AllowTelemetry" 0

# Disable Windows Problem Steps Recorder
If (-Not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat"))
{
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Name AppCompat
}
Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" "DisableUAR" 1

# Disable Application Impact Telemetry
Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" "AITEnable" 0

# Disable Customer Experience Improvement Program
If (-Not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\SQMClient"))
{
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft" -Name SQMClient
}
If (-Not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\SQMClient\Windows"))
{
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\SQMClient" -Name Windows
}
Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\SQMClient\Windows" "CEIPEnable" 0

# Set Windows Explorer Default view to This PC
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "LaunchTo" 1

# Disable Hiding of Known File Extensions
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "HideFileExt" 0

#Disable Hibernate
powercfg.exe /hibernate off