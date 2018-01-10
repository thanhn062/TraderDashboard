#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetKeyDelay, 100
Gui, Add, ActiveX, x-300 y-300 w300 h300 vWB, Shell.Explorer
WB.Navigate("about:blank")
WB.silent := true
Gui, Add, ListView,x10 y10 r20 w750 gTradeList, #|Time Start|Time End|Symbol|Type|Size|Open Price|Close Price|S/L|T/P|Profit/Loss|Pips|Duration
Menu, MyContext, Add, select
Gui, Show


Sleep 20
;~ session_num := getXMLVal("session",XML)
;~ history = https://www.myfxbook.com/api/get-history.xml?session=%session_num%&id=2302561
;~ WB.Navigate(history)

;~ MsgBox % getXML("history",WB)
historyXML := getXML("history",WB)
StringReplace, historyXML, historyXML, <transaction>, †, all
StringSplit, trade_, historyXML, †
Gui, Listview, TradeList
Loop, %trade_0%
{
	if A_Index = 1
		continue
	;~ MsgBox % trade_%A_Index%
	openDate := getXMLVal("openDate", trade_%A_Index%)
	closeDate := getXMLVal("closeDate", trade_%A_Index%)
	symbol := getXMLVal("symbol", trade_%A_Index%)
	action := getXMLVal("action", trade_%A_Index%)
	lotSize := getXMLVal("value", trade_%A_Index%)
	openPrice := getXMLVal("openPrice", trade_%A_Index%)
	closePrice := getXMLVal("closePrice", trade_%A_Index%)
	tp := getXMLVal("tp", trade_%A_Index%)
	sl := getXMLVal("sl", trade_%A_Index%)
	pips := getXMLVal("pips", trade_%A_Index%)
	;~ profit := getXMLVal("profit", trade_%A_Index%)
	profit := pips * lotSize
	; need to modify profit based on currency
	if (symbol = "eurusd" || symbol = "gbpusd" || symbol = "usdjpy")
		profit := profit*10
	;~ else if (symbol ="usdjpy")
		;~ profit := profit*10
; testing variables
;~ openDate = 9.30.2017 13:19
;~ closeDate = 11.30.2017 13:20

StringReplace, openDate, openDate, /, ., all
; get Hour & Minute , Month & Date
StringSplit, openDate_, openDate, %A_Space%
StringSplit, start_date_, openDate_1, .
StringSplit, start_time_, openDate_2, :
openDate := start_date_1 "." start_date_2 A_Space start_time_1 ":" start_time_2
StringReplace, closeDate, closeDate, /, ., all
; get Hour & Minute , Month & Date
StringSplit, closeDate_, closeDate, %A_Space%
StringSplit, end_date_, closeDate_1, .
StringSplit, end_time_, closeDate_2, :
closeDate := end_date_1 "." end_date_2 A_Space end_time_1 ":" end_time_2

; Calculate
if (start_date_2 = end_date_2) ; if on the same date
{
	duration_h := end_time_1 - start_time_1
	duration_m := end_time_2 - start_time_2
	if (duration_m < 0)
	{
		duration_m+=60
		duration_h-=1
	}
	if duration_h != 0
		duration = %duration_h%h %duration_m%m
	else
		duration = %duration_m%m
}
else ; not on same date
{
	;example 10.31 6:43 , 11.01 4:33
	;find days difference
	if (start_date_1 = end_date_1) ;if same month
	{
		days_diff := end_date_1 - start_date_1
		duration_h := 24*days_diff - start_time_1 + end_time_1
		duration_m := end_time_2 - start_time_2
		if (duration_m < 0)
		{
			duration_m+=60
			duration_h-=1
			if duration_h < 0
				duration_h+=24
		}
		if duration_h != 0
			duration = %duration_h%h %duration_m%m
		else
			duration = %duration_m%m
		}
	else ; diff month
	{
		; days count
		;~ days_of_start := findDateCount(start_date_1) -  start_date_2 + end_date_2
		days_diff := findDateCount(start_date_1) -  start_date_2 + end_date_2
		duration_h := 24*days_diff - start_time_1 + end_time_1
		duration_m := end_time_2 - start_time_2
		if (duration_m < 0)
		{
			duration_m+=60
			duration_h-=1
			if duration_h < 0
				duration_h+=24
		}
		if duration_h != 0
			duration = %duration_h%h %duration_m%m
		else
			duration = %duration_m%m
		if duration_h >= 24
		{
			if duration_h/24 is integer
				duration := Round(duration_h/24,0) "d" A_Space duration_m "m"
			else
				duration := Floor(duration_h/24) "d" A_Space Mod(duration_h,24) "h" A_Space duration_m "m"
		}
	}
}

	LV_Add("",A_Index, openDate, closeDate, symbol, action, lotSize, openPrice, closePrice, sl, tp, profit, pips, duration)
	LV_ModifyCol()
}
return
^!v::
Send %openDate%
sleep 500
Send {Right}
sleep 500
Send %closeDate%
sleep 500
Send {Right} 
sleep 500
Send %duration%
sleep 500
Send {Right}
sleep 500
Send %action%
sleep 500
Send {Right}
sleep 500
Send %lotSize%
sleep 500
Send {Right}
sleep 500
Send %symbol%
sleep 500
Send {Right}
sleep 500
Send {Right}
sleep 500
Send {Right}
sleep 500
Send {Right}
sleep 500
Send %openPrice%
sleep 500
Send {Right}
sleep 500
Send %closePrice%
sleep 500
Send {Right}
sleep 500
Send %sl%
sleep 500
Send {Right}
sleep 500
Send %tp%
sleep 500
Send {Right}
sleep 500
Send {Right}
sleep 500
Send %profit%
sleep 500
Send {Right}
sleep 500
Send {Right}
sleep 500
Send %pips%
return
select:
LV_GetText(openDate,currRow,2)
StringReplace, openDate, openDate, /, ., all
StringReplace, openDate, openDate, .2017, , all
LV_GetText(closeDate,currRow,3)
StringReplace, closeDate, closeDate, /, ., all
StringReplace, closeDate, closeDate, .2017, , all
LV_GetText(symbol,currRow,4)
LV_GetText(action,currRow,5)
LV_GetText(lotSize,currRow,6)
LV_GetText(openPrice,currRow,7)
LV_GetText(closePrice,currRow,8)
LV_GetText(sl,currRow,9)
LV_GetText(tp,currRow,10)
LV_GetText(profit,currRow,11)
LV_GetText(pips,currRow,12)
LV_GetText(duration,currRow,13)
return
TradeList:
return
GuiContextMenu:
MouseGetPos, x, y
currRow := A_EventInfo
Menu, MyContext, Show, %x% %y%
return
GuiClose:
ExitApp

findDateCount(start_date_1) {
		if start_date_1 = 1
			days_count := 31
		if start_date_1 = 2
			if (Mod(start_date_3,4) = 0)
				days_count := 29
			else if (Mod(start_date_3,100) = 0)
				days_count := 28
			else if (Mod(start_date_3,100) = 0 && Mod(start_date_3,400) = 0)
				days_count := 29
			else
				days_count := 28
		if start_date_1 = 3
			days_count := 31
		if start_date_1 = 4
			days_count := 30
		if start_date_1 = 5
			days_count := 31
		if start_date_1 = 6
			days_count := 30
		if start_date_1 = 7
			days_count := 31
		if start_date_1 = 8
			days_count := 31
		if start_date_1 = 9
			days_count := 30
		if start_date_1 = 10
			days_count := 31
		if start_date_1 = 11
			days_count := 30
		if start_date_1 = 12
			days_count := 31
		return days_count
}
getXML(type,WB) {
	WB.Navigate("https://www.myfxbook.com/api/login.xml?email=510thanh.ngo@gmail.com&password=GU2ZPD9mECKVyKn6wIrE")
	while wb.ReadyState <> 4
		continue
	Sleep 50
	while !XML
		XML := WB.document.documentElement.innerText
	while !session_num
		session_num := getXMLVal("session",XML)
	XML =
	WB.Navigate("about:blank")
	sleep 100
	if (type == "history")
	{
		WB.Navigate("https://www.myfxbook.com/api/get-history.xml?session=" . session_num . "&id=2302561")
		while wb.ReadyState <> 4
			continue
		WB.Refresh()
		sleep 100
		while !XML
			XML := WB.document.documentElement.innerText
	}
	return XML
}
getXMLVal(value,XML) {
	RegExMatch(XML,"<" . value . ">(.*)</" . value . ">", data)
	StringReplace, data, data, <%value%>,,
	StringReplace, data, data, </%value%>,,
	return data
}

