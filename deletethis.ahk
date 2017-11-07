#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

currNum := 5
;~ currNum2 :=
;~ MsgBox % currNum "," currNum-1 "," currNum
;~ /*
F1::
currNum++
;~ Send =10/(SUM(N1:N%currNum%)+50)*100
;~ string := "=10/(SUM(N1:N" . currNum . ")+50)*100"
;~ =10/(SUM(O1:O2)+'Oct 2017'!O35+50)
;=O5/(SUM(O1:O4)+'Oct 2017'!O35+50)
;~ string := "=10/(SUM(O1:O" . currNum . ")+'Oct 2017'!O35+50)"
string := "=O" . currNum . "/(SUM(O1:O" . currNum-1 . ")+'Oct 2017'!O35+50)"
SendRaw %string%
return

;~ F5::ExitApp

