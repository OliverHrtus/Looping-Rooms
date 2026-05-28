Add-Type -AssemblyName System.Drawing
$path = 'c:\Users\Yokin\OneDrive\Desktop\Looping Rooms\assets\Player_Sprite.png'
$bmp = [System.Drawing.Bitmap]::FromFile($path)
$w = $bmp.Width; $h = $bmp.Height
Write-Output "size $w $h"
$colHas = New-Object bool[] $w
$rowHas = New-Object bool[] $h
for ($x=0; $x -lt $w; $x++) {
  for ($y=0; $y -lt $h; $y++) {
    $p = $bmp.GetPixel($x,$y)
    if (($p.A -gt 16) -and (($p.R + $p.G + $p.B) -gt 10)) {
      $colHas[$x] = $true; break
    }
  }
}
for ($y=0; $y -lt $h; $y++) {
  for ($x=0; $x -lt $w; $x++) {
    $p = $bmp.GetPixel($x,$y)
    if (($p.A -gt 16) -and (($p.R + $p.G + $p.B) -gt 10)) {
      $rowHas[$y] = $true; break
    }
  }
}
function Get-Runs($arr) {
  $in=false; $start=0; $runs=@()
  for ($i=0; $i -lt $arr.Length; $i++) {
    if ($arr[$i] -and -not $in) { $in=$true; $start=$i }
    elseif (-not $arr[$i] -and $in) { $in=$false; $runs += ,@($start,$i-1) }
  }
  if ($in) { $runs += ,@($start,$arr.Length-1) }
  return $runs
}
$cr = Get-Runs $colHas
$rr = Get-Runs $rowHas
Write-Output "col runs count $($cr.Count)"
Write-Output "row runs count $($rr.Count)"
Write-Output "first 10 col runs: $($cr[0..([Math]::Min(9,$cr.Count-1))] | ForEach-Object { $_ -join ',' } )"
Write-Output "first 10 row runs: $($rr[0..([Math]::Min(9,$rr.Count-1))] | ForEach-Object { $_ -join ',' } )"
$cw = $cr | ForEach-Object { $_[1]-$_[0]+1 }
$rh = $rr | ForEach-Object { $_[1]-$_[0]+1 }
Write-Output "col widths unique: $(($cw | Sort-Object | Get-Unique) -join ', ')"
Write-Output "row heights unique: $(($rh | Sort-Object | Get-Unique) -join ', ')"
if ($cw.Count -gt 0) { Write-Output "first 10 col widths: $($cw[0..([Math]::Min(9,$cw.Count-1))] -join ', ')" }
if ($rh.Count -gt 0) { Write-Output "first 10 row heights: $($rh[0..([Math]::Min(9,$rh.Count-1))] -join ', ')" }
$bmp.Dispose()

