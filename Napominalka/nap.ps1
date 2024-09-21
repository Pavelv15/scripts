#$t='[DllImport("user32.dll")] public static extern bool ShowWindow(int handle, int state);'
#Add-Type -Name win -member $t -Namespace native
#[native.win]::ShowWindow(([System.Diagnostics.Process]::GetCurrentProcess() | Get-Process).MainWindowHandle,0)
function window_napominalka 
{
$date_today=(Get-Date).Day
if ($date_today -ge $date) {
Write-Host "Даты совпадают"
Add-Type -Assembly System.Windows.Forms
Add-type -Assembly 'System.IO.Compression'
Add-type -Assembly 'System.IO.Compression.FileSystem'
$window_form= New-Object System.Windows.Forms.Form
$window_form.Text = "Ежемесячный сбор данных"
$window_form.Width = 550 
$window_form.Height = 400 
#$window_form.BackColor = "#BDB76B"
#$window_form.ForeColor = "black"
$window_form.AutoScale = $true
$window_form.BackgroundImage = [System.Drawing.Image]::FromFile("Тут лучше указать полный путь до  kartinka.jpg. Пример: O:\Scripts\Napominalka\kartinka.jpg ") 
$FormLablel= New-Object System.Windows.Forms.Label
$FormLablel.Location = New-Object System.Drawing.Point(10,10)
$FormLablel.AutoSize = $true 

$window_form.Controls.Add($FormLablel)


$Button = New-Object System.Windows.Forms.Button
$Button.Location =New-Object System.Drawing.Point(10,200)
$Button.Size =New-Object System.Drawing.Size(150,30)
$Button.Text = "Перейти на сайт"
$window_form.Controls.Add($Button)


$Button.Add_Click( 
{
Start-Process -FilePath Chrome -ArgumentList "https://lkk.mosobleirc.ru/#/" #  в  ArgumentList указывается ссылка на сайт где вносятся показатели счётчика. В  FilePath  указывается имя названия исполняемого фалйа, который запускает  браузер 
# В строке 38,39 и 54  нужно указать путь до проверочного файла proverka.txt. Путь может быть любой, главное чтобы они совпадали 
Remove-Item .\proverka.txt # удаляет проверочный файл
New-Item .\proverka.txt #  создаёт новый проверочный файл с текущим числом 
$window_form.Close()
}
)

$window_form.ShowDialog()


}
else 
{
echo "Íîy"
}
}

$month_chek = (Get-ChildItem .\proverka.txt).CreationTime.Month
$month_today = (get-date).Month
if ($month_chek -eq $month_today)
{
echo "Ты уже предупреждён"
echo $month_chek
}
else {  

echo $month_chek

if ($month_today -eq 12) 
{
$date=8
echo "Декабрь"
window_napominalka


}
else 
{

$date=20
echo $data
window_napominalka
}

}
