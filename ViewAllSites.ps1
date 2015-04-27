$siteUrl = Read-Host "Informe a url do site"
 
$rootSite = New-Object Microsoft.SharePoint.SPSite($siteUrl)
$spWebApp = $rootSite.WebApplication
 
foreach($site in $spWebApp.Sites)
{
    foreach($siteAdmin in $site.RootWeb.SiteAdministrators)
    {
        Write-Host "$($siteAdmin.ParentWeb.Url) - $($siteAdmin.DisplayName)"

    }


    $site.Dispose()
}
