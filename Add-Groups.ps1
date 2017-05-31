# #############################################################################
# CompanyD - SCRIPT - POWERSHELL
# NAME: Add-Groups.ps1
# 
# AUTHOR:  OffHand
# DATE:  2017/05/11
# EMAIL: OffHand
# 
# COMMENT:  This script will add mutiple groups to AD 
#
# VERSION HISTORY
# 1.0 2011.05.25 Initial Version.
# 
#
# TO ADD
# -Add a Function to ...
# -Fix the...
# #############################################################################




$raw = "c:\temp\input.csv"
$groups = import-csv $raw
$path = "OU=PermissionGroups,OU=Sharepoint2016,OU=MedPro Applications,DC=CompanyD,DC=com"
$ADServer = "IODC1.medprodoctors.com"

foreach ($group in $groups)  {
    $gname = $group.page
    $gowners = "SP-" + $gname + "-Owners"
    $gcontrib = "SP-" + $gname + "-Contributers"
    $gview = "SP-" + $gname + "-Viewers"
    $description = "Used to control permissions to the 2016 sharepoint Prod and Dev sites"
    


    New-ADGroup -DisplayName $gowners -Description $description -GroupCategory Security -GroupScope Global -Name $gowners -Path $path -SamAccountName $gowners -Server $ADServer
    New-ADGroup -DisplayName $gcontrib -Description $description -GroupCategory Security -GroupScope Global -Name $gcontrib -Path $path -SamAccountName $gcontrib -Server $ADServer
    New-ADGroup -DisplayName $gview -Description $description -GroupCategory Security -GroupScope Global -Name $gview -Path $path -SamAccountName $gview -Server $ADServer

}


