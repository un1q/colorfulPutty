colorfulPutty
=============

Opens putty with different background colors (test of my color choosing algorithm). Written in Powershell.

Algorithm is simple - each new color if like previous one, but rotated by golden angle (http://en.wikipedia.org/wiki/Fibonacci_number#In_nature) in HLS color space (http://en.wikipedia.org/wiki/HLS_color_space). Algorithm provides beautiful colors different each time you open putty console.

usage:
powershell.exe &'colorfulPutty.ps1'
