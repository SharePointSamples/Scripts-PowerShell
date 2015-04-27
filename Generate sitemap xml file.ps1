Add-PSSnapin microsoft.sharepoint.powershell -ErrorAction SilentlyContinue


$Site = "http://server/site"
$FilePath = "C:\SiteMap.xml"



function New-SPSiteMap ($SavePath, $Url)

{
    

	try
    
	{
        
		$site=Get-SPSite $Url
        
		$list = $site.Allwebs | ForEach { $_.Lists } | ForEach-Object -Process {$_.Items}| ForEach-Object -Process {$_.web.url.Replace(" ","%20") + "/" + $_.url.Replace(" ","%20")}



        #excludes directories you don’t want in sitemap. you can put multiple lines here:
        
	
	$list=  $list | ? {$_ -notmatch "_catalogs"}
        
	$list=  $list | ? {$_ -notmatch "Cache%20Profiles"}
        
	$list=  $list | ? {$_ -notmatch "Reports%20List"}
        
	$list=  $list | ? {$_ -notmatch "Long%20Running%20Operation%20Status"}
        
	$list=  $list | ? {$_ -notmatch "Relationships%20List"}
        
	$list=  $list | ? {$_ -notmatch "ReusableContent"}
        
	$list=  $list | ? {$_ -notmatch "Style%20Library"}
        
	$list=  $list | ? {$_ -notmatch "PublishingImages"}
        
	$list=  $list | ? {$_ -notmatch "SiteCollectionDocuments"}
        
	$list=  $list | ? {$_ -notmatch "Lists/"}
        
	$list=  $list | ? {$_ -notmatch "Documents/"}
        
	$list=  $list | ? {$_ -notmatch "PublishedLinks"}
        
	$list=  $list | ? {$_ -notmatch "WorkflowHistory"}
        
	$list=  $list | ? {$_ -notmatch "WorkflowTasks"}
        

	$list | New-Xml -RootTag urlset -ItemTag url -ChildItems loc -SavePath $SavePath

    

	}
    
	catch
    
	{
        
		write-host "Unable to create sitemap." -foregroundcolor red
        
		break
    
	}

}



function New-Xml

{

    
	param($RootTag="urlset",$ItemTag="url",$ChildItems="*",$SavePath)
    
	
	Begin 
	{
        
		$xml="<?xml version=""1.0"" encoding=""UTF-8""?>
        <urlset xmlns=""http://www.sitemaps.org/schemas/sitemap/0.9"">"
        
	}
    
	Process 
	{
        
		$xml += " <$ItemTag>"
        foreach ($child in $_)
		
		{
        
			$Name = $child
        
			$xml += " <$ChildItems>$child</$ChildItems>"
        
		}
        

		$xml += " </$ItemTag>"
        
	}
    
	End 
	{
        
		$xml += "</$RootTag>"
        
		$xmltext=[xml]$xml
        
		$xmltext.Save($SavePath)
    
	}

}



New-SPSiteMap -Url $Site -SavePath $FilePath

write-host "SiteMap for $Site saved to $FilePath" -foregroundcolor green

Read-host