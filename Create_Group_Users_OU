#Содаем директорию temp и записываем в нее параметр#

$statePath = "C:\temp\Group.txt"
$pass = ConvertTo-SecureString -String "Qwerty123!" -AsPlainText -Force

#Содаем директорию temp и записываем в нее параметр#
if (!(Test-Path $statePath)){
	if (!(Test-Path C:\temp\)) { New-Item C:\temp\ -ItemType Directory | Out-Null }
	New-Item $statePath -ItemType File | Out-Null
}

$state = Get-Content $statePath
$state = 0 + $state

if($state -lt 3){
        sleep 3
        Write-Host "Создаем Организационный юнит" -ForegroundColor Green
        New-ADOrganizationalUnit -Name "Moscow" -Path "dc=m24,dc=etc"
        New-ADOrganizationalUnit -Name "Server" -Path "OU=Moscow, dc=m24,dc=etc"
        New-ADOrganizationalUnit -Name "Hyper-v" -Path "OU=Moscow, dc=m24,dc=etc"
        New-ADOrganizationalUnit -Name "Application" -Path "OU=Moscow, dc=m24,dc=etc"
        New-ADOrganizationalUnit -Name "AdminUsers" -Path "OU=Moscow, dc=m24,dc=etc"
        New-ADOrganizationalUnit -Name "ServiceUsers" -Path "OU=Moscow, dc=m24,dc=etc"
        New-ADOrganizationalUnit -Name "Group" -Path "OU=Moscow, dc=m24,dc=etc"

    3 | Out-File -FilePath $statePath
}
if($state -lt 4){
        sleep 3
        Write-Host "Создаем группы" -ForegroundColor Green
        New-ADGroup -Name "Admins" -SamAccountName "Admins" -GroupScope Global -GroupCategory Security -Description "Admins_Group" -Path "OU=Group, OU=Moscow, dc=m24,dc=etc"
        New-ADGroup -Name "SQL" -SamAccountName "SQL" -GroupScope Global -GroupCategory Security -Description "Admins_SQl" -Path "OU=Group, OU=Moscow, dc=m24,dc=etc"
        New-ADGroup -Name "Hyper-v" -SamAccountName "Hyper-v" -GroupScope Global -GroupCategory Security -Description "Admins_Hyper-v" -Path "OU=Group, OU=Moscow, dc=m24,dc=etc"
        New-ADGroup -Name "Application" -SamAccountName "Application" -GroupScope Global -GroupCategory Security -Description "Admins_Application" -Path "OU=Group, OU=Moscow, dc=m24,dc=etc"
    
    4 | Out-File -FilePath $statePath
}
if($state - lt 5){
        sleep 3
        Write-Host "Создаем пользователя Admin" -ForegroundColor Green

        New-ADUser -Name "Admin" -UserPrincipalName "admin" -SamAccountName "admin" -GivenName "Admin" -Surname "IT" -DisplayName "Admin IT" -AccountPassword $pass -CannotChangePassword $false -Enabled $true -Path "OU=AdminUsers, OU=Moscow, dc=m24, dc=etc"
    
    5 | out-File -FilePath $statePath
}
if($state -lt 6){
    sleep 1
            Write-Host "добавляем в группу Администратора" -ForegroundColor Green
            Add-ADGroupMember "Администраторы домена" admin

            6 | out-File -FilePath $statePath

}

Remove-Item C:\temp\ -Recurse -Force -ErrorAction SilentlyContinue
Write-Host "===== Установка завершена! Нажмите ENTER для выхода =====" -ForegroundColor Green
Read-Host
