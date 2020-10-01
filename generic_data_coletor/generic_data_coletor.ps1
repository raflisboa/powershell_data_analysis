##NOTE: This is a generic script. Feel free to modify and adapt to your necessities.

$lines = Get-Content -Path "C:\IMPUT\YOUR_LOCAL\DIR_HERE*" -Filter *.log | select-string "IMPUT:","YOUR:","DATA:","HERE:","FROM:","FILES:","THAT_YOU:","WANT:","EXTRACT:",| %{$_ -replace '$',''}
    
# Number 9 means 9 categories. Did you get it?
$result = for ($i = 0; $i -lt $lines.Count; $i += 9) {
    $str = (($lines[$i] -split ':', 2).Trim() -join ' = '),
           (($lines[$i + 1] -split ':', 2).Trim() -join ' = '),
           (($lines[$i + 2] -split ':', 2).Trim() -join ' = '),
           (($lines[$i + 3] -split ':', 2).Trim() -join ' = '),
           (($lines[$i + 4] -split ':', 2).Trim() -join ' = '),
           (($lines[$i + 5] -split ':', 2).Trim() -join ' = '),
           (($lines[$i + 6] -split ':', 2).Trim() -join ' = '),
           (($lines[$i + 7] -split ':', 2).Trim() -join ' = '),
           (($lines[$i + 8] -split ':', 2).Trim() -join ' = ') -join "`r`n"
		   
# Just repeat all categories, without ":" 
	[PsCustomObject]($str | ConvertFrom-StringData) | Select-Object 'IMPUT','YOUR','DATA','HERE','FROM','FILES','THAT_YOU','WANT','EXTRACT'
} 
# This will put all data into a single CSV file
$result | Export-Csv -Path .\YOUR_NEM_FILE.csv -Delimiter ';' -NoTypeInformation

