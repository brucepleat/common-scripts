Import-Module "D:\Movies\_tools\imdb_ps_module_v3.ps1"

<#
param (
	[Parameter(Mandatory=$true)][string]$title,
	[Parameter(Mandatory=$true)][string]$year
)
#>


$CodedP = "D:\Movies"
ForEach ($FN in Get-ChildItem -Recurse -Path $CodedP) {
$F = $FN.Name
$X = ""

If ( -not ($F -match "TV series") ) {
    If ( $F.length -ge 5 ) { $X = $F.substring($F.length-4,4) }
        If ( ($X -eq ".mp4") -or ($X -eq ".mkv") -or ($X -eq ".avi") -or ($X -eq ".mpg") -or ($X -eq ".m4v") ) {
            $P = $FN.directory
            $F = $F.substring(0,$F.length-4) <# Remove extension #>
            $Out = "$P\$F.txt"
                
# Comment the next few lines out except when you want to purge all the files for a refresh
<#
            If (Test-Path $Out -PathType Leaf) {
                Remove-Item -Path $Out
            }
#>

            <# Checking whether file exists; if so, don't repeat the work #>
            If ( -not (Test-Path $Out -PathType Leaf) ) {

                <# Assume Year is last four digits and title is the rest#>
                $Year = $F.substring($F.length-4,4)
                $Title = $F.substring(0,$F.length-5)

                (get-IMDBMatch -Title $Title | Where { $_.Released -eq $Year } | Where-Object { $_.Type -eq 'Movie'} | Get-IMDBItemXML ) > $Out

                If ( ( (Get-Item $Out).length) -eq 0 ) {
                    <#  Echo "Deleting 0-byte: $Out" #>
                      Remove-Item $Out

                }
                write-output """$Out"""
            }
        }
    } 
}