Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue


$habilitarFeature = Read-Host "Habilitar/Desabilitar feature? (H/D)"

$siteUrl = Read-Host "Informe a url do site"

$rootSite = New-Object Microsoft.SharePoint.SPSite($siteUrl)
$spWebApp = $rootSite.WebApplication


function HabilitarFeature([Microsoft.SharePoint.SPWeb] $web)
{
  write-host $web.Title;

  $defaultOpenBehaviorFeatureId = $(Get-SPFeature -limit all | where {$_.displayname -eq "OpenInClient"}).Id 

  
  Write-Host "Site: " $web.URL


    if($habilitarFeature -eq "H")
    {
      Enable-SPFeature $defaultOpenBehaviorFeatureId -url $web.URL -ErrorAction SilentlyContinue      
    }
    
    if($habilitarFeature -eq "D")
    {
      Disable-SPFeature $defaultOpenBehaviorFeatureId -url $web.URL  -ErrorAction SilentlyContinue -Confirm: $false      
    }
  
}
  
foreach($site in $spWebApp.Sites)
{  
    $site.AllWebs | foreach-object { HabilitarFeature $_ }
    $site.Dispose()
}

Write-Host $spWebApp.Sites.Count
Out-Default