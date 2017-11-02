#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

currNum := 3
F1::
currNum++
;~ Send =10/(SUM(N1:N%currNum%)+50)*100
;~ string := "=10/(SUM(N1:N" . currNum . ")+50)*100"
string := "=N3/(SUM(N1:N" . currNum . ")+50)*100"
SendRaw %string%
return

;~ F5::ExitApp

