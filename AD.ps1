#Содаем директорию temp и записываем в нее параметр#

$pass = ConvertTo-SecureString -String "Qwerty123!" -AsPlainText -Force
$statePath = "C:\temp\State.txt"

#Содаем директорию temp и записываем в нее параметр#
if (!(Test-Path $statePath)){
	if (!(Test-Path C:\temp\)) { New-Item C:\temp\ -ItemType Directory | Out-Null }
	New-Item $statePath -ItemType File | Out-Null
}

$state = Get-Content $statePath
$state = 0 + $state

if($state -lt 1){
    Write-Host "Установка нужных компонентов для домена" -ForegroundColor Green
    
    install-windowsfeature AD-Domain-Services, RSAT-Role-ToolsRSAT-ADRMS, RSAT-ADDS-Tools, RSAT-AD-AdminCenter
    
    1 | Out-File -FilePath $statePath
}

if($state -lt 2){
        sleep 4

    Write-Host "Установка домен контролера" -ForegroundColor Green
    Import-Module ADDSDeployment
    Install-ADDSForest `
    -CreateDnsDelegation:$false `
    -DatabasePath "C:\Windows\NTDS" `
    -DomainMode "Win2012" `
    -DomainName "m24.etc" `
    -DomainNetbiosName "M24" `
    -ForestMode "Win2012" `
    -InstallDns:$true `
    -LogPath "C:\Windows\NTDS" `
    -NoRebootOnCompletion:$false `
    -SysvolPath "C:\Windows\SYSVOL" `
    -Force:$true
    2 | Out-File -FilePath $statePath
}
if($state -lt 3){
        sleep 3
        Write-Host "Создаем Организационный юнит" -ForegroundColor Green

Remove-Item C:\temp\ -Recurse -Force -ErrorAction SilentlyContinue
Write-Host "===== Установка завершена! Нажмите ENTER для выхода =====" -ForegroundColor Green
Read-Host
