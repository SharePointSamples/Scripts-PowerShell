Add-PSSnapin Microsoft.SharePoint.PowerShell

$TemplateName = "Personal Site"
$WebApplicationUrl = "http://server/site"

$contentService = [Microsoft.SharePoint.Administration.SPWebService]::ContentService
$quotaTemplate = $contentService.QuotaTemplates[$TemplateName]
$webApplication = Get-SPWebApplication $WebApplicationUrl
$webApplication.Sites | ForEach-Object { try { $_.Quota = $quotaTemplate; } finally { $_.Dispose(); } }

write-host "Operação realizada com sucesso!"
read-host