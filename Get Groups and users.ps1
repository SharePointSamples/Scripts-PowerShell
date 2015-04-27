$site = Get-SPSite <Endereço do Site>
$groups = $site.RootWeb.sitegroups
foreach ($grp in $groups) {$grp.name + " - " + $grp.Users.Count; foreach ($user in $grp.users) {"   " + $user.name} }
$site.Dispose() 