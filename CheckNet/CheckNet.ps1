<<<<<<< HEAD
Start-Transcript -path ".\logs.txt"
=======
Start-Transcript -path "logs.txt"
>>>>>>> d6d2673852c4fd61862550038d11de6790d0a990
[string]$mask = ipconfig
#Указывается первый и второй октет локальной сети 
$chek_mask= $mask.Contains('192.168.')

if( $chek_mask -eq $True) {
Write-Host "Роутер виден"
tracert 8.8.8.8
$what = Read-Host "Запустить автоматическое восстановление доступа интернет(Y-да;N-нет))"
if($what -eq "Y") {
netsh winsock reset
netsh int ip reset
netcfg -d
ipconfig /release
ipconfig /renew
ipconfig /flushdns
ipconfig /registerdns

Write-Host "Перезагрузка компьютера через 10 секунд"
Start-Sleep -Seconds 10
shutdown /r /t 0 
}
else {
pause
}

}
else {
Write-Host "Роутер невиден"
Get-NetIPConfiguration -All -Detailed
pause
}
Stop-Transcript
