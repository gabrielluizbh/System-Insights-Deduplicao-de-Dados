## Script automatizando a Deduplicação de dados com System Insights (Informações do Sistema) - Desabilitando a Deduplicação de dados em um volume. - Créditos Gabriel Luiz - www.gabrielluiz.com ##


Update-DedupStatus -Volume "D:" | Out-file -FilePath "C:\OKlVolumeDepuplicacaoStatusUpdate.txt" # Cria um artigo TXT informando a atualização do status da Deduplicação de dado.

Get-DedupVolume -Volume "D:" | Out-file -FilePath "C:\OKVolumeDepuplicacaoStatus.txt" # Cria um artigo TXT informando o status da Deduplicação de dado do volume.

Disable-DedupVolume -Volume "D:" # Desabilita da Deduplicação de dado no volume com a letra D:.


# Script de envio de e-mail

$emailSmtpServer = "wp174.hostgator.com.br" # Servidor SMTP.
$emailSmtpServerPort = "587" # Porta do Servidor SMTP.
$emailSmtpUser = "testeenviaemail@gabrielluiz.com" # Usuário do e-mail.
$emailSmtpPass = "@abc123"  # Senha do e-mail.
 
$emailMessage = New-Object System.Net.Mail.MailMessage
$emailMessage.From = "System Insights (Informações do Sistema) <testeenviaemail@gabrielluiz.com>" # E-mail remetente.
$emailMessage.To.Add( "gabrielluiz@msn.com" ) # E-mail destinatário.
$attachment1 = “C:\OKlVolumeDepuplicacaoStatusUpdate.txt” # Anexo um. Atualização do status da Deduplicação de dado.
$emailMessage.Attachments.Add($attachment1)
$attachment2 = “C:\OKVolumeDepuplicacaoStatus.txt” # Anexo dois. Status da Deduplicação de dado do volume.
$emailMessage.Attachments.Add($attachment2)
$emailMessage.Subject = "System Insights (Informações do Sistema) - Desabilitação da execução da Deduplicação de dados" # Assunto do e-mail.
$emailMessage.IsBodyHtml = $true # Habilita o e-mail HTML.
$emailMessage.Body = "Foi desabilitdo a execução da Deduplicação de dados no volume D:, segue em anexo os TXTs com as informações dos status da Deduplicação de dados." # Mensagem do e-mail.
 
$SMTPClient = New-Object System.Net.Mail.SmtpClient( $emailSmtpServer , $emailSmtpServerPort )
$SMTPClient.EnableSsl = $true # Habilita a criptografía SSL no email.
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential( $emailSmtpUser , $emailSmtpPass );
$SMTPClient.Send( $emailMessage )