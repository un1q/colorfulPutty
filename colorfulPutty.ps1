#HLS->RGB
function HLS_RGB($H, $L, $S) {
	$C=(1-[Math]::Abs(2.0*$L-1.0))*$S
	$HP=$H/60.0
	$X=$C*(1.0-[Math]::Abs($HP%2-1.0))
	$HP=[Math]::floor($HP)
	$M=$L-$C/2.0
	$C+=$M
	$X+=$M
	$M=[Math]::floor($M*255.0)
	$C=[Math]::floor($C*255.0)
	$X=[Math]::floor($X*255.0)
	switch ($HP) {
		0 {$O="$C,$X,$M"}
		1 {$O="$X,$C,$M"}
		2 {$O="$M,$C,$X"}
		3 {$O="$M,$X,$C"}
		4 {$O="$X,$M,$C"}
		5 {$O="$C,$M,$X"}
	}
	$O
}

& 'C:\Program Files (x86)\putty.exe'
cd "HKCU:\Software\SimonTatham\PuTTY\Sessions"
$H=[double][environment]::GetEnvironmentVariable("H","User")
if ($H -eq $null) { $H=0 }
$L=0.95
$S=1
$L_Bold=0.3
$S_Bold=0.8
$light=HLS_RGB $H $L $S
$bold=HLS_RGB $H $L_Bold $S_Bold
ls | ? {-not ($_.Name -like "*NEG*")} | Set-ItemProperty -Name "Colour0" -Value "0,0,0"
ls | ? {-not ($_.Name -like "*NEG*")} | Set-ItemProperty -Name "Colour1" -Value "$bold"
ls | ? {-not ($_.Name -like "*NEG*")} | Set-ItemProperty -Name "Colour2" -Value "$light"
$L=0.1
$S=1
$L_Text=0.85
$S_Text=0.5
$L_Bold=0.7
$S_Bold=0.8
$text=HLS_RGB $H $L_Text $S_Text
$dark=HLS_RGB $H $L $S
$bold=HLS_RGB $H $L_Bold $S_Bold
ls | ? {$_.Name -like "*NEG*"} | Set-ItemProperty -Name "Colour0" -Value "$text"
ls | ? {$_.Name -like "*NEG*"} | Set-ItemProperty -Name "Colour1" -Value "$bold"
ls | ? {$_.Name -like "*NEG*"} | Set-ItemProperty -Name "Colour2" -Value "$dark"
$H=($H+137.5)%360
[Environment]::SetEnvironmentVariable("H", $H, "User")
