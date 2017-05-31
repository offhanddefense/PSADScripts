$dmgu = import-csv C:\temp\badhomedrives.csv

foreach ($user in $dmgu)
    {
    $uname = $user.samaccountname
    $source = $user.homedirectory
    $dest = "\\fs1\users\$uname"
    robocopy $source $dest /E /Copyall /R:2 /W:1 
    set-aduser $uname -HomeDirectory $dest
    }
