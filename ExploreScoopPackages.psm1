function exploreScoopHome{
  while(1){
    $searchTerm = Read-Host "What term would you like to explore?"

    $scoopList = scoop search $searchTerm | Out-String
    $scoopList = $scoopList.Trim()
    $scoopList = $scoopList -Split "`r`n"

    $scoopRows = [System.Collections.ArrayList]::new()

    foreach($row in $scoopList){
      if(-not($row.Contains("bucket:`n")) -and $row -notlike " "){
        $item = $row.Trim() | Out-String
        $scoopRows.Add($item) | Out-Null
      }
    }

    if($scoopRows.Length -le 0){
      Write-Host "No entries were found with this term. Please try another one!"
    } else{
      break
    }
  }

  $scoopRows = $scoopList -Split "`r`n"

  $maxItems = Read-Host "How many items would you like to explore? (* will show all results)"

  $newList = [System.Collections.ArrayList]::new()

  $i = 1
  foreach ($row in $scoopRows) {
    $scoopItems = $row.Trim().split(" ")
    if($scoopItems[0] -notlike " "){
      scoop home $scoopItems[0] | Out-Null
      if ($i -eq $maxItems){
        break
      }
      $i += 1
    }
  }

  echo "`nend"
}
