    # Установка временной зоны - Москва\С. Петербург
    
    Set-TimeZone -Id 'Russian Standard Time'

#Вводим нужные пререки для сети"

    $IP = Write-Host "Введите IP, пример 192.168.XX.1"[$OldIP]
    
    $MASK = Write-Host "Введите маску, привет 255.255.ХХХ.ХХХ"[$OldMask]

    $GW = Write-Host "Введите шлюз по умолчанию, пример 192.168.XX.1"[$OldGW]

    $DNSSERVER = Write-Host "Введите днс сервер"[$OldDNS]

#Если не назначают IP/MASK/GW/DNS  он оставляет по умолчанию#
    
        $NetConfig = gwmi -computer . -class "win32_networkadapterconfiguration" | Where-Object { $_.defaultIPGateway -ne $null }
        
        $OldDNS = (Get-DnsClientServerAddress -InterfaceIndex (Get-NetAdapter).ifIndex -AddressFamily IPv4).ServerAddresses
        
        $OldIP = (Get-NetIPAddress -InterfaceIndex (Get-NetAdapter).ifIndex).IPv4Address
	    
        $OldMask = $NetConfig.ipsubnet | foreach { if ($_.Length -ge 7) { $_ } }
	    
        $OldGW = $NetConfig.DefaultIPGateway





        Write-Host "===== Установка завершена! Нажмите ENTER для выхода =====" -ForegroundColor Green
        Read-Host
