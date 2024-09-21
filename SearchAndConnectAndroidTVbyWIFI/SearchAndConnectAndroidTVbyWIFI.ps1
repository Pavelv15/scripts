[Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding("windows-1251")
Set-StrictMode -Version latest
Get-Content .\ip.txt | %{adb.exe connect $_}
TIMEOUT /T 5
scrcpy
write-host "Запустить попытку подключения через сканирование всей сети, если не получилось поключиться? Ведите цифру 1 чтобы запустить. 2 или  любую другую чтобы завершить выполнение скрипта"
$what=read-host " "
if ( $what -eq "1") {
write-host "Это может занять  несколько минут"
$ips = (Get-NetIPConfiguration -InterfaceAlias Et*).IPv4DefaultGateway.NextHop
[array]$ips = $ips.split(".")
[string]$ips = $ips[0] + "." + $ips[1] + "." + $ips[2]
write-host "Подсеть $ips"
[array]$massive = 1..254 | %{ping -n 1 -w 10 $ips`.$_ > $null; if($LASTEXITCODE -eq 0) {"$ips.$_"}}
for ($i=0; $i -lt $massive.Length;$i++) {
$chek =(Test-NetConnection -Port 5555  $massive[$i]).tcpTestSucceeded
if ( $chek -eq $True)
{
write-host "Порт найден"
adb.exe connect $massive[$i]
$massive[$i] | Out-File -FilePath .\ip.txt
TIMEOUT /T 5
scrcpy

break

}
else {
Write-host "Телика пока не видно в сети"

} 
}
}


else {
exit
}


