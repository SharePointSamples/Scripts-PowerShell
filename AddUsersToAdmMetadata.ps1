$taxonomySite = get-SPSite "http://server/site"

#Connect to Term Store in the Managed Metadata Service Application
$taxonomySession = Get-SPTaxonomySession -site $taxonomySite
$termStore = $taxonomySession.TermStores[$metadataService]

$termStore.AddTermStoreAdministrator(“Domain\Username”)

#Update the Term Store
$termStore.CommitAll()
$taxonomySite.Dispose()