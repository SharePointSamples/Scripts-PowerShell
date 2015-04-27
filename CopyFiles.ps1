if((Get-PSSnapin "Microsoft.SharePoint.PowerShell") -eq $null)
{
    Add-PSSnapin Microsoft.SharePoint.PowerShell
}
 
#Script settings
 
$webUrl = "http://server/site"
 
$docLibraryName = "Documentos"
$docLibraryUrlName = "Documents/Documentos"
 
$localFolderPath = "\\server\c$\ArquivosSharePoint"
$destinationFolderPath = "\\server\c$\ArquivosSharePoint\Processados"

#Open web and library
 
$web = Get-SPWeb $webUrl
 
$docLibrary = $web.Lists[$docLibraryName]
 
$files = ([System.IO.DirectoryInfo] (Get-Item $localFolderPath)).GetFiles()
 
ForEach($file in $files)
{
 
    #Open file
    $fileStream = ([System.IO.FileInfo] (Get-Item $file.FullName)).OpenRead()
 
    #Add file
    $folder =  $web.getfolder($docLibraryUrlName)
 
    write-host "Copying file " $file.Name " to " $folder.ServerRelativeUrl "..."
    $spFile = $folder.Files.Add($folder.Url + "/" + $file.Name, [System.IO.Stream]$fileStream, $true)
 
    
    write-host "Success"
 
    #Close file stream
    $fileStream.Close();

    
    #Moving Files
    $fileSource =  $localFolderPath + "\" + $file
    write-host "Moving file $fileSource to $destinationFolderPath"
    Move-item -Path  $fileSource -destination $destinationFolderPath
    
    write-host "Success"
}
 
#Dispose web
 
$web.Dispose()

