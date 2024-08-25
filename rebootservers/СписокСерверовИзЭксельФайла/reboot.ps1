
$i = 1
while($i = 1) {
write-host "Выберите действие:"
write-host "1-перезагрузка серверов"
write-host "2-проверка после перезагрузки(после перезагрузки необходимо подождать минут 30)"
write-host "3-Выход"
$what=read-host " "
if ( $what -eq "1") {
$SRVNm = Get-Content .\name.csv 
ForEach( $SRV in $SRVNm )  {
invoke-command -computername  $SRV   -scriptblock {
( Get-WmiObject win32_computersystem).name
shutdown /r /t 0 
}

}
}

if ( $what -eq "2") {
$SRVNm = Get-Content .\name.csv
$data = Get-Date -Format dd_MM_yy
write-host "Результат будет в файле result_reboot$($data).txt"
$result = ForEach( $SRV in $SRVNm ) {

invoke-command -computername  $SRV   -scriptblock {
 ( Get-WmiObject win32_computersystem).name

Get-CimInstance -ClassName win32_OperatingSystem | select csname, lastbootuptime

echo "Внимательно изучи дату и время запуска ОС каждого сервера, если дата не совпадает с текущей, то необходимо руками перезапустить сервер"

}
}
$result | Out-File result_reboot$($data).txt -Append;
}
if ( $what -eq "3")
{
exit
}
else {
write-host -BackgroundColor red -ForegroundColor black "Неверный выбор"
}
}
