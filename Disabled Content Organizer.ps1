if((Get-PSSnapin | Where {$_.Name -eq "Microsoft.SharePoint.PowerShell"}) -eq $null) {
 Add-PSSnapin Microsoft.SharePoint.PowerShell;
}

Get-SPSite -Identity http://server/site | Get-SPWeb -Limit ALL | ForEach-Object { 
  Disable-SPFeature –Identity DocumentRouting –url $_.Url –Confirm:$false
  $dropOffLibrary = $_.Lists["Library"]
  $dropOffLibrary.AllowDeletion = "True"
  $dropOffLibrary.Update()
  $dropOffLibrary.Delete()
}

PAUSE