#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Gui, Add, ActiveX, x10 y10 w300 h300 vWB, Shell . Explorer
WB.Navigate("about:blank")
WB.silent := true
Gui, Show
WB.Navigate("https://www.myfxbook.com/api/login.xml?email=510thanh.ngo@gmail.com&password=GU2ZPD9mECKVyKn6wIrE")
while wb.ReadyState <> 4
	continue   
SourceCode := WB.document.documentElement.innerText
Sleep 20
session_num := getXMLVal("session",SourceCode)
MsgBox % MyFxBook("GetOpenTrade",session_num)
;~ MsgBox % getXMLVal("session",SourceCode)
; https://www.myfxbook.com/api/logout.xml?session=DSL07vu14QxHWErTIAFrH40

return

getXMLVal(value,XML) {
	RegExMatch(XML,"<" . value . ">(.*)</" . value . ">", data)
	StringReplace, data, data, <%value%>,,
	StringReplace, data, data, </%value%>,,
	return data
}
MyFxBook(command,session) {
	global WB
	if command == "GetAccInfo"
		command = https://www.myfxbook.com/api/get-my-accounts.xml?session=
	else if command == "GetOpenTrade"
	{
		;https://www.myfxbook.com/api/get-open-trades.xml?session=5xgASOteSC4uXOxMwJBs469923&id=2302561
		WB.Navigate(command . "https://www.myfxbook.com/api/get-open-trades.xml?session=" . session . "&id=2302561")
		while wb.ReadyState <> 4
			continue   
		SourceCode := WB.document.documentElement.innerText
		Sleep 20
		getXMLVal("Profit",SourceCode)
		;~ command = https://www.myfxbook.com/api/get-open-trades.xml?session=
	}
	; Traer Logger
	
}
GuiClose:
ExitApp
F5::ExitApp