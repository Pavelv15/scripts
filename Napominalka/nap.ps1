#$t='[DllImport("user32.dll")] public static extern bool ShowWindow(int handle, int state);'
#Add-Type -Name win -member $t -Namespace native
#[native.win]::ShowWindow(([System.Diagnostics.Process]::GetCurrentProcess() | Get-Process).MainWindowHandle,0)
function window_napominalka 
{
$date_today=(Get-Date).Day
if ($date_today -ge $date) {
Write-Host "���� ���������"
Add-Type -Assembly System.Windows.Forms
Add-type -Assembly 'System.IO.Compression'
Add-type -Assembly 'System.IO.Compression.FileSystem'
$window_form= New-Object System.Windows.Forms.Form
$window_form.Text = "����������� ���� ������"
$window_form.Width = 550 
$window_form.Height = 400 
#$window_form.BackColor = "#BDB76B"
#$window_form.ForeColor = "black"
$window_form.AutoScale = $true
$window_form.BackgroundImage = [System.Drawing.Image]::FromFile("kartinka.jpg")
$FormLablel= New-Object System.Windows.Forms.Label
$FormLablel.Location = New-Object System.Drawing.Point(10,10)
$FormLablel.AutoSize = $true 

$window_form.Controls.Add($FormLablel)


$Button = New-Object System.Windows.Forms.Button
$Button.Location =New-Object System.Drawing.Point(10,200)
$Button.Size =New-Object System.Drawing.Size(150,30)
$Button.Text = "������� �� ����"
$window_form.Controls.Add($Button)


$Button.Add_Click( 
{
Start-Process -FilePath Chrome -ArgumentList "https://lkk.mosobleirc.ru/#/"
Remove-Item O:\Scripts\Napominalka\proverka.txt # ������� ����������� ���� 
New-Item O:\Scripts\Napominalka\proverka.txt #  ������ ����� ����������� ���� � ������� ������ 
$window_form.Close()
}
)

$window_form.ShowDialog()


}
else 
{
echo "��y"
}
}

$month_chek = (Get-ChildItem O:\Scripts\Napominalka\proverka.txt).CreationTime.Month
$month_today = (get-date).Month
if ($month_chek -eq $month_today)
{
echo "�� ��� �����������"
echo $month_chek
}
else {  

echo $month_chek

if ($month_today -eq 12) 
{
$date=8
echo "�������"
window_napominalka


}
else 
{

$date=20
echo $data
window_napominalka
}

}
