## Script automatizando a Deduplicação de dados com System Insights (Informações do Sistema) - Instalando e habilitando a Deduplicação de dados em um volume. - Créditos Gabriel Luiz - www.gabrielluiz.com ##


Install-WindowsFeature -ComputerName FILE -Name FS-Data-Deduplication # Instala a Deduplicação de dados no servidor com o hostname File.

Enable-DedupVolume -Volume D: -UsageType Default # Habilita a Deduplicação de dados no volume com a letra D:, o parametro -UsageType Default, significa que o volume que será analisado será de uso geral, como arquivos, pastas, documentos. Mas esse parametro pode ser alterado para Backup, ajustado especificamente para aplicativos de backup virtualizado, como Microsoft DPM ou o parametro HyperV, ajustado especificamente para um volume para armazenamento Hyper-V.

Start-DedupJob -Type Optimization -Volume D: -Memory 100 -Cores 100 -Priority High # Iniciar a Deduplicação de dados no volume com a letra D: com prioridade alta e utilizando 100% de memória e do núcleos físicos do processador.

Get-DedupStatus | Out-file -FilePath "C:\CriticalVolumeDepuplicacaoStatus.txt" # Cria um artigo TXT informando o status da Deduplicação de dado.

Get-DedupVolume -Volume "D:"  | Out-file -FilePath "C:\CriticalVolumeDepuplicacaoStatusVolume.txt" # Cria um artigo TXT informando o status da Deduplicação de dado do volume.


# Script de envio de e-mail

$emailSmtpServer = "wp174.hostgator.com.br" # Servidor SMTP.
$emailSmtpServerPort = "587" # Porta do Servidor SMTP.
$emailSmtpUser = "testeenviaemail@gabrielluiz.com" # Usuário do e-mail.
$emailSmtpPass = "@abc123"  # Senha do e-mail.
 
$emailMessage = New-Object System.Net.Mail.MailMessage
$emailMessage.From = "System Insights (Informações do Sistema) <testeenviaemail@gabrielluiz.com>" # E-mail remetente.
$emailMessage.To.Add( "gabrielluiz@msn.com" ) # E-mail destinatário.
$attachment1 = “C:\CriticalVolumeDepuplicacaoStatus.txt” # Anexo um. Status da Deduplicação de dado.
$emailMessage.Attachments.Add($attachment1)
$attachment2 = “C:\CriticalVolumeDepuplicacaoStatus.txt” # Anexo dois. Status da Deduplicação de dado do volume.
$emailMessage.Attachments.Add($attachment2)
$emailMessage.Subject = "System Insights (Informações do Sistema) - Habilitação e execução da Deduplicação de dados" # Assunto do e-mail.
$emailMessage.IsBodyHtml = $true # Habilita o e-mail HTML.
$emailMessage.Body = "Foi habilitado a execução da Deduplicação de dados no volume D:, segue em anexo os TXTs com as informações dos status da Deduplicação de dados." # Mensagem do e-mail.
 
$SMTPClient = New-Object System.Net.Mail.SmtpClient( $emailSmtpServer , $emailSmtpServerPort )
$SMTPClient.EnableSsl = $true # Habilita a criptografía SSL no email.
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential( $emailSmtpUser , $emailSmtpPass );
$SMTPClient.Send( $emailMessage )