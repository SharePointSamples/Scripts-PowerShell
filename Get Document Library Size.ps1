if(-not(Get-PSSnapin | where { $_.Name -eq "Microsoft.SharePoint.PowerShell"}))
{
      Add-PSSnapin Microsoft.SharePoint.PowerShell;
}

$SPsite = Get-SPsite http://server/site

$dataTable = $SPsite.StorageManagementInformation(2,0x11,0,0)

$dataTable | where {$_.LeafName -eq "" } | Format-Table LeafName, @{Label = "Size in GB"; Expression = {[Math]::Round(($_.Size/1GB),2)}}