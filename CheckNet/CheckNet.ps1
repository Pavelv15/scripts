Start-Transcript -path "C:\Users\pasho\OneDrive\������� ����\������������\logs.txt"
[string]$mask = ipconfig

$chek_mask= $mask.Contains('192.168.')

if( $chek_mask -eq $True) {
Write-Host "������ �����"
tracert 8.8.8.8
$what = Read-Host "��������� �������������� �������������� ������� ��������(Y-��;N-���)"
if($what -eq "Y") {
netsh winsock reset
netsh int ip reset
netcfg -d
ipconfig /release
ipconfig /renew
ipconfig /flushdns
ipconfig /registerdns

Write-Host "������������ ���������� ����� 10 ������"
Start-Sleep -Seconds 10
shutdown /r /t 0 
}
else {
pause
}

}
else {
Write-Host "������ �������"
Get-NetIPConfiguration -All -Detailed
pause
}
Stop-Transcript