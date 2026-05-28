Add-Type -AssemblyName System.Drawing
$path = 'c:\Users\Yokin\OneDrive\Desktop\Looping Rooms\assets\Player_Sprite.png'
$bmp = [System.Drawing.Bitmap]::FromFile($path)
$w = $bmp.Width; $h = $bmp.Height
Write-Output "size $w $h"
function isNonBlack($x,$y) {
  $p = $bmp.GetPixel($x,$y)
  if ($p.A -le 16) { return $false }
  if (($p.R + $p.G + $p.B) -le 10) { return $false }
  return $true
}
$left = -1; for ($x=0; $x -lt $w; $x++) { for ($y=0; $y -lt $h; $y++) { if (isNonBlack $x $y) { $left=$x; break } } if ($left -ne -1) { break } }
$right = -1; for ($x=$w-1; $x -ge 0; $x--) { for ($y=0; $y -lt $h; $y++) { if (isNonBlack $x $y) { $right=$x; break } } if ($right -ne -1) { break } }
$top = -1; for ($y=0; $y -lt $h; $y++) { for ($x=0; $x -lt $w; $x++) { if (isNonBlack $x $y) { $top=$y; break } } if ($top -ne -1) { break } }
$bottom = -1; for ($y=$h-1; $y -ge 0; $y--) { for ($x=0; $x -lt $w; $x++) { if (isNonBlack $x $y) { $bottom=$y; break } } if ($bottom -ne -1) { break } }
Write-Output "bounds left=$left right=$right top=$top bottom=$bottom"
$bmp.Dispose()

