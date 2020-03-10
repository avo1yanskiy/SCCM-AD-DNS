
<#
Создание домен контроллера & добавление компонентов v.1
#>

#Содаем директорию temp и записываем в нее параметр#

$statePath = "C:\temp\Ad.txt"

#Содаем директорию temp и записываем в нее параметр#
if (!(Test-Path $statePath)){
	if (!(Test-Path C:\temp\)) { New-Item C:\temp\ -ItemType Directory | Out-Null }
	New-Item $statePath -ItemType File | Out-Null
}

$state = Get-Content $statePath
$state = 0 + $state

if($state -lt 2){
    Write-Host "Установка службы домен контролера" -ForegroundColor Green
    
    install-windowsfeature AD-Domain-Services
    
    2 | Out-File -FilePath $statePath
}

if($state -lt 3){
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
    3 | Out-File -FilePath $statePath
}

Remove-Item C:\temp\ -Recurse -Force -ErrorAction SilentlyContinue
Write-Host "===== Установка завершена! Нажмите ENTER для выхода =====" -ForegroundColor Green
Read-Host
