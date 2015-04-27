Add-PSSnapin Microsoft.SharePoint.PowerShell
#Get Web and Quick Launch objects

$web = Get-SPWeb http://server/site
$qlNav = $web.Navigation.QuickLaunch



#Clear Quick Launch links
$qlNav | ForEach-Object {
    $currentLinks = $currentLinks + $_.Id
}
$currentLinks | ForEach-Object {
    $currentNode = $web.Navigation.GetNodeById($_)
    write-host "Deleting" $currentNode.Title "and all child navigation links..."
    $qlNav.Delete($currentNode)

}
$web.Dispose()

Read-Host