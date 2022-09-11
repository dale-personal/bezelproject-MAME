$files = Get-ChildItem -File -Filter *.png  -Path retroarch\overlay\ArcadeBezels\

$vertical = Get-Content -Path .\mame_vert.txt
$skip_bezel = Get-Content -Path .\mame_skip_bezel.txt
$no_bezel = Get-Content -Path .\mame_no_bezel.txt

for ($i=0; $i -lt $files.Count; $i++) {
    Write-Output $files[$i].FullName
    if ($no_bezel -contains $files[$i].BaseName) {
        Remove-Item $files[$i].FullName
    }
    elseif ($skip_bezel -contains $files[$i].BaseName){
        Write-Output "skipping"
    }
    elseif ($vertical -contains $files[$i].BaseName){
        magick $files[$i].FullName -strokewidth 0 -fill black -draw "rectangle 470,0 1450,1080" -region "981x1080+470+0" -transparent black $files[$i].FullName
    }
    else {
        magick $files[$i].FullName -strokewidth 0 -fill black -draw "rectangle 222,0 1698,1080" -region "1477x1080+222+0" -transparent black $files[$i].FullName
    }
}