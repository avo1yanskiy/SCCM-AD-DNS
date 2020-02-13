


$placeNumber= Read-Host "Введите номер прощадки"
$statePath = "C:\temp\State.txt"

#  create state file
if (!(Test-Path $statePath)){
	if (!(Test-Path C:\temp\)) { New-Item C:\temp\ -ItemType Directory | Out-Null }
	New-Item $statePath -ItemType File | Out-Null
}

$state = Get-Content $statePath
$state = 0 + $state

if($state -lt 1){

    $ip = "10.1$placeNumber.3.50"
    $mask = "24"
    $gw = "10.1$placeNumber.3.1"
    $DNS = "10.1$placeNumber.3.11"
    Write-Host "Установка сети" -ForegroundColor Yellow
    $NetAdapter = Get-NetAdapter -Name "*Ethernet 2*"
    $NetAdapter | Set-NetIPInterface -Dhcp Disabled
    $NetAdapter | New-NetIPAddress -IPAddress $ip -PrefixLength $mask -DefaultGateway $gw
    $NetAdapter | Set-DnsClientServerAddress -ServerAddresses $DNS

     
    1 | Out-File -FilePath $statePath
}
