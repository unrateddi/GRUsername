$file = Read-Host -prompt "Drop List File"
$names = Get-Content $file
$tmpf = New-TemporaryFile
foreach($name in $names){
    $spl = $name.split(", ")
    $spl = $spl.Replace(",","")
    $splfixed = $spl | ?{$_.replace("`n","")}
    try{
        $GRusername = $splfixed[0]
        $GRusername += $splfixed[1].Substring(0,1)
        $GRusername | Out-File $tmpf -Append
    }catch{Write-host "!WARNING AT: $name !" }
}
Read-Host -prompt "Press any key to continue"
Rename-Item $tmpf.FullName $tmpf.Name.Replace(".tmp",".csv")
Invoke-Item $tmpf.FullName.Replace(".tmp",".csv")