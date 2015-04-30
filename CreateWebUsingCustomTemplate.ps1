param(

    [Parameter(Mandatory=$true)]
    [string]
    $Url,

    [Parameter(Mandatory=$true)]
    [string]
    $WebUrl,
    [Parameter(Mandatory=$true)]
    [string]
    $WebTitle,
    [Parameter(Mandatory=$true)]
    [string]
    $WebDescription,
    [Parameter(Mandatory=$true)]
    [string]
    $TemplateType,
    [Parameter(Mandatory=$true)]
    [string]
    $LanguageID,

    [Parameter(Mandatory=$false)]
    [switch]
    $Force,
    [Parameter(Mandatory=$false)]
    [switch]
    $InheritesMasterPage
)

Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

function CreateWebUsingTemplate($site, $webUrl, $webTitle, $webDescription, $templateType, $languageID)
{  
    write-host "Criando site ... " -NoNewline
    $template = $site.GetWebTemplates($languageID)  | ? { $_.Title -eq $templateType }
    if( $template -ne $null )
    {
        
        $templateSite = Get-SPWeb $webUrl -ErrorAction SilentlyContinue
        
        if( $templateSite -ne $null && $Force -eq $true)
        {
            Write-Host "Já existia, deletando para criar novamente." -ForegroundColor Yellow -NoNewline
            $templateSite.Delete()
            $templateSite.Dispose()
        }
        else {
            $templateSite = New-SPWeb -Url $webUrl -Name $webTitle -Description $webDescription -UseParentTopNav:$true -Language $languageID -UniquePermissions:$false
            $templateSite.ApplyWebTemplate($template)

            if( $InheritesMasterPage -eq $true )
            {
                $parentWeb = $templateSite.ParentWeb

                $templateSite.MasterUrl = $parentWeb.MasterUrl
                $templateSite.CustomMasterUrl = $parentWeb.CustomMasterUrl
                $templateSite.Navigation.UseShared = $true

               
                $templateSite.Update()
            }
            
            Write-Host "OK" -ForegroundColor Green            
        }

    }
    else
    {
        Write-Host "Template não encontrado" -ForegroundColor yellow
    }
}


$siteColl = Get-SPSite $Url
if( $siteColl -ne $null)
{
    CreateWebUsingTemplate $siteColl $WebUrl $WebTitle $WebDescription $TemplateType $LanguageID
}
$siteColl.Dispose()
