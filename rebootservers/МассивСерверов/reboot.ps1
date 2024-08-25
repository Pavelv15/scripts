[array]$Servers= '' # Массив серверов
$i = 1
while($i = 1) {
write-host "Выберите действие:"
write-host "1-перезагрузка серверов"
write-host "2-проверка после перезагрузки(после перезагрузки необходимо подождать минут 30)"
write-host "3-Выход"
$what=read-host " "
if ( $what -eq "1") {
for ($i=0; $i -lt $Servers.Length;$i++) {
invoke-command -computername  $Servers[$i]   -scriptblock {
( Get-WmiObject win32_computersystem).name
shutdown /r /t 0 
}

}
}

if ( $what -eq "2") {
for ($i=0; $i -lt $Servers.Length;$i++) {
invoke-command -computername  $Servers[$i]   -scriptblock {
( Get-WmiObject win32_computersystem).name

Get-CimInstance -ClassName win32_OperatingSystem | select csname, lastbootuptime

Write-host -BackgroundColor black -ForegroundColor Cyan "Внимательно изучи дату и время запуска ОС каждого сервера, если дата не совпадает с текущей, то необходимо руками перезапустить сервер"

}
}
}
if ( $what -eq "3")
{
exit
}
else {
write-host -BackgroundColor red -ForegroundColor black "Неверный выбор"
}
}
