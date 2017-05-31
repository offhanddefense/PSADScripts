# #############################################################################
# CompanyD - SCRIPT - POWERSHELL
# NAME: AddDatatoADUsers.ps1
# 
# AUTHOR:  OffHand
# DATE:  12/22/2016
# EMAIL: OffHand
# 
# COMMENT:  This script will add a piece of data to Exchange based on a csv file.
#           Must be run under Exchange tools
#
# VERSION HISTORY
# 1.0 2016.12.22 Initial Version.
# 
#
# TO ADD
#
# #############################################################################

#$ErrorActionPreference = "Stop"
$wf = "c:\temp"
$csvfile = "$wf\employeephones.csv"
$rawinput = Import-Csv $csvfile
$failusers = "$wf\failusers.csv"
# $attribute = "customattribute1"
$err = @()


foreach ($user in $rawinput) {
    $fn = $user.firstname
    $ln = $user.lastname
    $phone = $user.cellphone
    #$err = @()
   
    # creates the display name to be used in the AD search
    $displayname = $fn + " " + $ln
      
    set-mailbox $displayname -customattribute1 $phone 2>> $failusers
    
    #Write-Output $err #| export-csv $failusers -NoTypeInformation -Append 
<#   
    Try 
    { 
      #set-mailbox $displayname -customattribute1 $phone -erroraction "stop"
      get-mailbox $displayname -erroraction "Stop"
    } 
    Catch 
    { 
      #Write-Output  -InputObject "The user $displayname does not exist" #| export-csv $failusers -NoTypeInformation -Append
      $displayname | Out-File $failusers -Append 
    }
    
 #>   
}
