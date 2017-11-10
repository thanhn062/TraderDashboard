#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#NoTrayIcon
SetBatchLines, -1
global WB_Calendar, WB_Home, MYAPP_PROTOCOL
;	/////////////////////////////////////////////
;	///														///
;	///				DEFAULT VARS				///
;	///														///
;	////////////////////////////////////////////
MYAPP_PROTOCOL:="TraDas"
UTC_offset := UTC_offset()+2
Clock_In = 0
quote_list = 
(Ltrim
Successful people do what unsuccessful people are not willing to do. Don't wish it were easier, wish you were better. - Jim Rohn
The trend is your friend !
Enter at retest
No retest, no entry. - Kendel / Trev
Always have a plan, keep it realistic, where you gettin in, where you gettin out, what's the target profit.
Keep the risk minimal
Don't micro manage
Don't trade emotionally
)
;	/////////////////////////////////////////////
;	///														///
;	///				USER INTERFACE				///
;	///														///
;	////////////////////////////////////////////
Gui, Add, MonthCal, x-400 y-90 vMonthCal
Gui, Add, ActiveX, x-1000 y-500 w620 h240 vWB_Calendar, Shell.Explorer
Gui, Add, ActiveX, vWB_Home x0 y0 w620 h520, Shell,Explorer
WB_Calendar.Navigate("about:blank")
WB_Home.Navigate("about:blank")
WB_Calendar.silent := true
WB_Home.silent := true
SetTimer, update_market_hour, 1000
;	/////////////////////////////////////////////
;	///			MARKET HOUR HTML			///
;	////////////////////////////////////////////
time_html =
(LTrim Join
        <table id="market-hour" onmousemove ="showCoor(event)" onmouseout="clearCoor()">
        <!-- Marks -->
        <tr class="market-hours-mark" style="height: 10px;">
          <td class="bad-time-highlight"></td>
          <td></td>
          <td class="good-time-highlight"></td>
          <td class="good-time-highlight"></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td class="good-time-highlight"></td>
          <td class="good-time-highlight"></td>
          <td class="good-time-highlight"></td>
          <td class="good-time-highlight"></td>
          <td></td>
          <td class="good-time-highlight"></td>
          <td class="good-time-highlight"></td>
          <td class="good-time-highlight"></td>
          <td class="good-time-highlight"></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td class="bad-time-highlight"></td>
          <td class="bad-time-highlight"></td>
        </tr>
        <!-- Display Hours -->
        <tr>
          <td class="bad-time-highlight"></td>
          <td onmouseover="show_sydney_stat()" onmouseout="hide_sydney_stat()" id="market-hours-sydney-1" style="position: relative;"><span class="market-hours-name">Sydney</span><span id="sydney_stat" style="display: none">close in 1h 30m</span></td>
          <td id="market-hours-sydney-2"></td>
          <td id="market-hours-sydney-3"></td>
          <td id="market-hours-sydney-4"></td>
          <td id="market-hours-sydney-5"></td>
          <td id="market-hours-sydney-6"></td>
          <td id="market-hours-sydney-7"></td>
          <td id="market-hours-sydney-8"></td>
          <td id="market-hours-sydney-9"></td>
          <td class="good-time-highlight"></td>
          <td class="good-time-highlight"></td>
          <td class="good-time-highlight"></td>
          <td></td>
          <td class="good-time-highlight"></td>
          <td class="good-time-highlight"></td>
          <td class="good-time-highlight"></td>
          <td class="good-time-highlight"></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td class="bad-time-highlight"></td>
          <td class="bad-time-highlight"></td>
        </tr>
        <tr>
          <td class="bad-time-highlight"></td>
          <td></td>
          <td onmouseover="show_tokyo_stat()" onmouseout="hide_tokyo_stat()" id="market-hours-tokyo-1" style="position: relative;"><span class="market-hours-name">Tokyo</span><span id="tokyo_stat" style="display: none">close in 1h 30m</span></td>
          <td id="market-hours-tokyo-2"></td>
          <td id="market-hours-tokyo-3"></td>
          <td id="market-hours-tokyo-4"></td>
          <td id="market-hours-tokyo-5"></td>
          <td id="market-hours-tokyo-6"></td>
          <td id="market-hours-tokyo-7"></td>
          <td id="market-hours-tokyo-8"></td>
          <td id="market-hours-tokyo-9"></td>
          <td class="good-time-highlight"></td>
          <td class="good-time-highlight"></td>
          <td></td>
          <td class="good-time-highlight"></td>
          <td class="good-time-highlight"></td>
          <td class="good-time-highlight"></td>
          <td class="good-time-highlight"></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td class="bad-time-highlight"></td>
          <td class="bad-time-highlight"></td>
        </tr>
        <tr>
          <td class="bad-time-highlight"></td>
          <td></td>
          <td class="good-time-highlight"></td>
          <td class="good-time-highlight"></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td class="good-time-highlight"></td>
          <td onmouseover="show_london_stat()" onmouseout="hide_london_stat()" id="market-hours-london-1" style="position: relative;"><span class="market-hours-name">London</span><span id="london_stat" style="display: none">close in 1h 30m</span></td>
          <td id="market-hours-london-2"></td>
          <td id="market-hours-london-3"></td>
          <td id="market-hours-london-4"></td>
          <td id="market-hours-london-5"></td>
          <td id="market-hours-london-6"></td>
          <td id="market-hours-london-7"></td>
          <td id="market-hours-london-8"></td>
          <td id="market-hours-london-9"></td>
          <td></td>
          <td></td>
          <td></td>
          <td class="bad-time-highlight"></td>
          <td class="bad-time-highlight"></td>
        </tr>
        <tr>
          <td class="bad-time-highlight"></td>
          <td></td>
          <td class="good-time-highlight"></td>
          <td class="good-time-highlight"></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td class="good-time-highlight"></td>
          <td class="good-time-highlight"></td>
          <td class="good-time-highlight"></td>
          <td class="good-time-highlight"></td>
          <td></td>
          <td class="good-time-highlight"></td>
          <td onmouseover="show_newyork_stat()" onmouseout="hide_newyork_stat()" id="market-hours-newyork-1" style="position: relative;"><span class="market-hours-name">New York</span><span id="newyork_stat" style="display: none">close in 1h 30m</span></td>
          <td id="market-hours-newyork-2"></td>
          <td id="market-hours-newyork-3"></td>
          <td id="market-hours-newyork-4"></td>
          <td id="market-hours-newyork-5"></td>
          <td id="market-hours-newyork-6"></td>
          <td id="market-hours-newyork-7"></td>
          <td id="market-hours-newyork-8"></td>
          <td id="market-hours-newyork-9"></td>
        </tr>
        <div id="timeMarker"></div>
        <tr style="height: 2px; background-color: white;"><td colspan="24">Volume</td></tr>
        <tr id="vol-chart">
          <td class="bad-time-highlight"><div id="vol-1"></div></td>
          <td><div id="vol-2"></div></td>
          <td class="good-time-highlight"><div id="vol-3"></div></td>
          <td class="good-time-highlight"><div id="vol-4"></div></td>
          <td><div id="vol-5"></div></td>
          <td><div id="vol-6"></div></td>
          <td><div id="vol-7"></div></td>
          <td><div id="vol-8"></div></td>
          <td><div id="vol-9"></div></td>
          <td class="good-time-highlight"><div id="vol-10"></div></td>
          <td class="good-time-highlight"><div id="vol-11"></div></td>
          <td class="good-time-highlight"><div id="vol-12"></div></td>
          <td class="good-time-highlight"><div id="vol-13"></div></td>
          <td><div id="vol-14"></div></td>
          <td class="good-time-highlight"><div id="vol-15"></div></td>
          <td class="good-time-highlight"><div id="vol-16"></div></td>
          <td class="good-time-highlight"><div id="vol-17"></div></td>
          <td class="good-time-highlight"><div id="vol-18"></div></td>
          <td><div id="vol-19"></div></td>
          <td><div id="vol-20"></div></td>
          <td><div id="vol-21"></div></td>
          <td><div id="vol-22"></div></td>
          <td class="bad-time-highlight"><div id="vol-23"></div></td>
          <td class="bad-time-highlight"><div id="vol-24"></div></td>
        </tr>
		</table>
      <div id="Mark"><div id="Arrow"></div><div id="Label">00:00:00</div></div>
      <div id="Mark_hover"><div id="Arrow_hover"></div><div id="Label_hover"></div></div>
      <script>
      function showCoor(event) {
        var x, y;
        if (event.pageX || event.pageY) { 
            x = event.pageX;
            y = event.pageY;
        }
        else {
            x = event.clientX + document.body.scrollLeft + document.documentElement.scrollLeft;
            y = event.clientY + document.body.scrollTop + document.documentElement.scrollTop;
        }
        var width = document.getElementById("market-hour").offsetWidth+10.5;
        var hour = width/24;
        var minute = width/1440;
        var time_hour,time_minute;

      for (var i = 0; i < 24; i++) {
        time_hour = hour*i;
        var next_hour = hour*(i+1);
        if (x >= time_hour && x <= next_hour) {
          time_hour = i;

          for (var i = 0; i < 1440; i++) {
            time_minute = minute*i;
            var next_minute = minute*(i+1);
            if (x >= time_minute && x <= next_minute) {
              time_minute = i - (60*time_hour);
              break;
            }
          }
          break;
        }
      }
      if (x >= hour*20)
      {
        document.getElementById("Label_hover").style.left = "-115px";
        document.getElementById("Arrow_hover").style.left = "-11px";
        document.getElementById("Arrow_hover").style.borderTop = "7px solid transparent";
        document.getElementById("Arrow_hover").style.borderBottom = "7px solid transparent";
        document.getElementById("Arrow_hover").style.borderRight = "7px solid transparent";
        document.getElementById("Arrow_hover").style.borderLeft = "7px solid black";
      }
      else
      {
        document.getElementById("Label_hover").style.left = "11px";
        document.getElementById("Arrow_hover").style.left = "4px";
        document.getElementById("Arrow_hover").style.borderTop = "7px solid transparent";
        document.getElementById("Arrow_hover").style.borderBottom = "7px solid transparent";
        document.getElementById("Arrow_hover").style.borderLeft = "";
        document.getElementById("Arrow_hover").style.borderRight = "7px solid black";
      }
      time_hour -=  %UTC_offset%+17;
      if (time_hour < 0)
        time_hour = time_hour+24;
      if (time_hour < 10)
        time_hour = "0" + time_hour;
      if (time_minute < 10)
        time_minute = "0" + time_minute;
      if (time_hour >= 12) {
        time_hour -= 12;
        if (time_hour == 0)
          time_hour = 12;
        if (time_hour < 10)
          time_hour = "0" + time_hour;
        am_pm = " pm";
      }
      else {
        am_pm = " am";
      }
        document.getElementById("Label_hover").innerHTML = time_hour + ":" + time_minute + am_pm;
        document.getElementById("Mark_hover").style.left  = x-5;
        document.getElementById("Mark_hover").style.display  = "";
      }
       function clearCoor() {
         document.getElementById("Mark_hover").style.left  = "-120px";
         document.getElementById("Mark_hover").style.display  = "none";
       }
        function show_sydney_stat() {
          document.getElementById("sydney_stat").style.display = "";
        }
        function hide_sydney_stat() {
           document.getElementById("sydney_stat").style.display = "none";
        }
        function show_tokyo_stat() {
          document.getElementById("tokyo_stat").style.display = "";
        }
        function hide_tokyo_stat() {
           document.getElementById("tokyo_stat").style.display = "none";
        }
        function show_london_stat() {
          document.getElementById("london_stat").style.display = "";
        }
        function hide_london_stat() {
           document.getElementById("london_stat").style.display = "none";
        }
        function show_newyork_stat() {
          document.getElementById("newyork_stat").style.display = "";
        }
        function hide_newyork_stat() {
           document.getElementById("newyork_stat").style.display = "none";
        }
        </script>
)
Sleep 50
;	/////////////////////////////////////////////
;	///		MAIN HOME PAGE HTML		///
;	////////////////////////////////////////////
home_html =
(Ltrim Join
<!DOCTYPE html>
<head>
	<style>
      body {
        overflow: hidden;
        margin: 0;
      }
		.background {
			position: absolute;
			index: 0;
		}
		#time-info {
			position: absolute;
			width: 240px;
			index: 1;
			right: 10px;
			top: 5px;
		}
		.time td {
			font-size: 33px;
			padding: 5px;
		}
        a {
          text-decoration: none;
          color: white;
        }
        /* UTILITY */
        #trading-plan {
          position: absolute;
          left: 15px;
          top: 60px;
          padding: 5px;
          border: 1px solid black;
          width: 235px; 
          height: 270px;
          background-color: #252B3C; 
          color: white;
        }
        #trading-checklist {
          position: absolute;
          left: 265px;
          top: 60px;
          padding: 5px;
          border: 1px solid black;
          width: 235px; 
          height: 270px;
          background-color: #252B3C; 
          color: white;
        }
        #utility {
          position: absolute;
          padding: 5px;
          left: 15px;
          top: 10px;
          border: 1px solid black; 
          width: 495px; 
          height: 45px;
          background-color: #252B3C; 
          color: white;
          font-size: 30px;
        }
        #event-watcher {
          position: absolute;
          padding: 5px;
          right: 8px;
          top: 150px;
          overflow-y: auto;
          border: 1px solid black; 
          width: 230px; 
          height: 180px
        }
        #utility ul {
          list-style-type: none;
        }
        #utility li {
            float: left;
        }
        #utility li a {
            display: block;
            color: white;
            text-align: center;
            padding: 2px 16px;
            text-decoration: none;
        }
        li a:hover {
            background-color: #111;
        }
        #trading-plan li {
          padding-top: 15px;
        }
        #trading-checklist li {
          padding-top: 9px;
        }
        /* 
        ////////////////////////////////////////////////////////
        ///                     MARKET - HOUR CSS                      ///
        ///////////////////////////////////////////////////////
        */
        #market-hour {
          width: 100`%;
          height: 100`%;
          border: 1px solid black;
          background-color: #3b4157;
          position: absolute;
          border-collapse: collapse;
          bottom: 0;
          right: 0;
          z-index: -1;
        }
        #market-hours-mark {
          border-top: 1px solid #white;
        }
        .market-hours-mark td {
          border-right: 1px solid white;
        }
        .market-hours-name {
          position: absolute;
          top: 3;
          left: 3;
          font-weight: bold;
          width: 284px;
        }
        /* MARKET HOURS */
        /* Default Color */
        #market-hours-sydney-1, #market-hours-sydney-2, #market-hours-sydney-3, #market-hours-sydney-4, #market-hours-sydney-5, #market-hours-sydney-6, #market-hours-sydney-7, #market-hours-sydney-8, #market-hours-sydney-9, #market-hours-tokyo-1 , #market-hours-tokyo-2, #market-hours-tokyo-3, #market-hours-tokyo-4, #market-hours-tokyo-5, #market-hours-tokyo-6, #market-hours-tokyo-7, #market-hours-tokyo-8, #market-hours-tokyo-9, #market-hours-london-1, #market-hours-london-2, #market-hours-london-3, #market-hours-london-4, #market-hours-london-5, #market-hours-london-6, #market-hours-london-7, #market-hours-london-8, #market-hours-london-9, #market-hours-newyork-1, #market-hours-newyork-2, #market-hours-newyork-3, #market-hours-newyork-4, #market-hours-newyork-5, #market-hours-newyork-6, #market-hours-newyork-7, #market-hours-newyork-8, #market-hours-newyork-9  {
          height: 25px;
          color: white;
          font-size: 1em;
          background-color: #252b3c;
          }
        /* TIME MARK */
        #Mark {
        content: "";
        position: absolute;
        border: 1px solid orange;
        height: 295px;
        bottom: 0px;
        left: -120px;
        width: 0;
        z-index: -1;
      }
      #Mark #Arrow {
        content: '';
        position: absolute;
        left: 4px;
        top: 115px;
        width: 0;
        height: 0;
        border-top: 7px solid transparent;
        border-bottom: 7px solid transparent;
        border-right: 7px solid black;
        clear: both;
        z-index: -1;
      }
      #Mark #Label {
        text-align: center;
        border: 1px solid black;
        background-color: orange;
        color: black;
        font-weight: bold;
        position: absolute;
        top:  109px;
        left: 11px;
        z-index: -1;
        padding: 2px;
        font-size: 18px;
        width: 98px;
        height: 20px;
      }
      /* TIME MARK - HOVER */
        #Mark_hover {
        content: "";
        position: absolute;
        border: 1px solid #25d0a3;
        height: 295px;
        bottom: 0px;
        left: -120px;
        width: 0;
        z-index: -1;
      }
      #Mark_hover #Arrow_hover {
        content: '';
        position: absolute;
        left: 4px;
        top: 115px;
        width: 0;
        height: 0;
        border-top: 7px solid transparent;
        border-bottom: 7px solid transparent;
        border-right: 7px solid black;
        clear: both;
        z-index: -1;
      }
      #Mark_hover #Label_hover {
        text-align: center;
        border: 1px solid black;
        background-color: #25d0a3;
        color: black;
        font-weight: bold;
        position: absolute;
        top:  109px;
        left: 11px;
        z-index: -1;
        padding: 2px;
        font-size: 18px;
        width: 98px;
        height: 20px;
      }
      /* VOLUME */
      #vol-chart {
        height: 160px;
      }
      #vol-chart td {
        border-right: 1px solid white;
      }
      #vol-chart td div{
        background-color: #25d0a3;
        width: 5px;
        bottom: 1px;
        position: absolute;
        margin: 10px 10px 0 10px;
        padding: 4;
      }
      #vol-1 {height: 1`%;}
      #vol-2 {height: 5`%;}
      #vol-3 {height: 8`%;}
      #vol-4 {height: 15`%;}
      #vol-5 {height: 16`%;}
      #vol-6 {height: 12`%;}
      #vol-7 {height: 10`%;}
      #vol-8 {height: 5`%;}
      #vol-9 {height: 13`%;}
      #vol-10 {height: 25`%;}
      #vol-11 {height: 35`%;}
      #vol-12 {height: 30`%;}
      #vol-13 {height: 28`%;}
      #vol-14 {height: 25`%;}
      #vol-15 {height: 22`%;}
      #vol-16 {height: 40`%;}
      #vol-17 {height: 45`%;}
      #vol-18 {height: 48`%;}
      #vol-19 {height: 35`%;}
      #vol-20 {height: 20`%;}
      #vol-21 {height: 10`%;}
      #vol-22 {height: 8`%;}
      #vol-23 {height: 5`%;}
      #vol-24 {height: 2`%;}
      .good-time-highlight {
        background-color: #999900;
      }
      .bad-time-highlight {
        background-color: #CC0000;
      }
      #sydney_stat, #tokyo_stat, #london_stat, #newyork_stat {
        position: absolute;
        left: 150px;
        top: 3px;
        width: 135px;
      }
      /*
          /////////////////////
          ///   TOOL TIP    ///
          ////////////////////
      */
      .tooltip {
          position: relative;
          display: inline-block;
      }
      .tooltip .tooltiptext {
          visibility: hidden;
          left: -295px;
          top: -20px;
          width: 235px;
          background-color: #fff;
          color: black;
          text-align: left;
          padding: 10px 10px;
          border: 2px solid white;
          /* Position the tooltip */
          position: absolute;
          z-index: 1;
      }
      .tooltip-arrow {
      position: absolute;
      width: 0; 
      height: 0; 
      border-top: 10px solid transparent;
      border-bottom: 10px solid transparent;
      border-left: 10px solid white;
      left: 255px;
      top: 20px;
      }
      .tooltip:hover .tooltiptext {
          visibility: visible;
      }
      a img {
      border: 0;
      }
      /*
      ////////////////////////////////////
      ///           Menu TOOL TIP           ///
      ////////////////////////////////////
      */
      .menu-tooltip {
          position: relative;
          display: inline-block;
      }
      .menu-tooltip .tooltiptext {
          visibility: hidden;
          left: 0;
          top: 60px;
          width: 125px;
          background-color: #fff;
          color: black;
          text-align: left;
          padding: 5px 5px;
          border: 2px solid white;
          /* Position the tooltip */
          position: absolute;
          z-index: 1;
          font-size: 20px;
          text-align: center;
      }
      .menu-tooltip .menu {
          visibility: hidden;
          left: 0px;
          top: 45px;
          width: 150px;
          background-color: #fff;
          color: black;
          text-align: left;
          padding: 5px 5px;
          border: 2px solid white;
          /* Position the tooltip */
          position: absolute;
          z-index: 1;
          font-size: 20px;
      }
      .menu-tooltip-arrow {
      position: absolute;
      width: 0; 
      height: 0; 
      border-left: 10px solid transparent;
      border-right: 10px solid transparent;
      border-bottom: 10px solid white;
      left:  10px;
      top: -12px;
      }
      .menu-tooltip:hover .tooltiptext {
          visibility: visible;
      }
      .menu-tooltip:hover .menu {
        visibility: visible;
      }
	</style>
</head>
<html>
	<body>
    <script>document.ondragstart = function () { return false; };</script>
		<img class="background" src="C:/Users/510th/Desktop/Trader Dashboard/nature.jpg" width="100`%" height="54`%">
        <!-- CLOCK -->
		<div id="time-info"><div id="currDate" style="font-size: 21px; background-color: #252B3C; color: white; padding: 2px; text-align: center; ">------------</div><hr>
			<table class="time">
				<tr>
					<td id="time_display_1" style="background-color: #252B3C; color: white">0</td>
					<td id="time_display_2" style="background-color: #252B3C; color: white">0</td>
					<td>:</td>
					<td id="time_display_3" style="background-color: #252B3C; color: white">0</td>
					<td id="time_display_4" style="background-color: #252B3C; color: white">0</td>
					<td>:</td>
					<td id="time_display_5" style="background-color: #252B3C; color: white">A</td>
					<td id="time_display_6" style="background-color: #252B3C; color: white">M</td>
				</tr>
			</table>
		</div>
        <!-- UTILITY -->
        <div id="trading-plan">📜 Trading Plan<hr>
        <div style="width: 240px; height: 230px; overflow-y: scroll;">
          <ul style="margin: 10px; padding: 0 20px 20px 10px;">
            <li>I will treat Forex like a business.</li>
            <li>I will base my trade off 4H & higher time frame.</li>
            <li>I never trade when I am tired, upset, rushed, emotional, or need money.</li>
            <li>I do my chart markup HW at 9 pm every day.</li>
            <li>I check the market when I get out of bed.</li>
            <li>I enter the market on the 15 minute time frame.</li>
            <li>I predict what the market might do, for the purpose of giving myself options, BUT I never anticipate what the market will do. I trade with at least 6-10 confirmations. </li>
            <li>I always use confirmations to enter and exit a trade</li>
            <li>I always make my own decisions to enter/exit a trade. (I trust my own analysis)</li>
            <li>I always start a trade with 0.1 (lot size). I only add to a trade when there are confirmations to scale in. </li>
            <li>I never trade with more than 10`% of my trading account. </li>
            <li>I accept losses and move on to the next trade. (Losing is part of trading</li>
            <li>I record my trades in my trading journal. </li>
            <li>I take responsibility for my successes and failures in the market. (I do not blame others) </li>
            <li>I want what the market is willing to give. (No greed or fear) </li>
          </ul>
          </div>
        </div>
        <div id="trading-checklist">☑ Check List - <a href="%MYAPP_PROTOCOL%://refresh/checklist">🔄</a> <hr>
          <div style="width: 240px; height: 230px;">
            <ol style="margin: 10px; padding: 0 20px 10px;">
            <form>
              <li><div class="tooltip"><input type="checkbox"> Trend<span class="tooltiptext"><div class="tooltip-arrow"></div>( multi time frame = overall trend )<br>From monthly to the 4H, is it going up or down. Check them all out IE "1M⇧ 1W⇧ 1D⇧ 4H⇧" & mark it up so you know what's going on over all, then break it down.<br>And yes it'd be better to mark every time frame individually so you got a good grasp of everything happpening if the 4H is going down currently but all the higher timeframes are going up something's wrong.</span></div></li>
              <li><div class="tooltip"><input type="checkbox"> Structure<span class="tooltiptext">Is it making HH or LH, if it keeps up with structure it should NEVER break a high or low in the opposite direction if it does then structure is officially broken.<div class="tooltip-arrow"></div></span></div></li>
              <li><div class="tooltip"><input type="checkbox"> Candle Pattern<span class="tooltiptext">A lot of the time we aim to look for engulfings but we forget the fact that you could easily tell a reversal from wicks that is essential the market putting the brakes on and slowing down to the opposite site ot either retest or change direction.<div class="tooltip-arrow"></div></span></div></li>
              <li><div class="tooltip"><input type="checkbox"> Trend Pattern (opt)<span class="tooltiptext">Meaning if you make a channel with the trend line to see higher highs and lower highs where is it headed on the channel did it just hit the top or bottom ? If overall structure is held you should be able to predict higher lows and lower highs.<div class="tooltip-arrow"></div></span></div></li>
              <li><div class="tooltip"><input type="checkbox"> PRZ Behavior<span class="tooltiptext">When price gets to prz what's going on ? Is it showing rejection, is it showing power & breaking? What time frame PRZ is it at,4H, Daily, Weekly, or Monthly, and how did it react.<div class="tooltip-arrow"></div></span></div></li>
              <li><div class="tooltip"><input type="checkbox"> Fibonacci<span class="tooltiptext">Where is it at currently on fibs where was the past low or high compared to where it's at currently? Does it line up with PRZ and structure and previous price?<div class="tooltip-arrow"></div></span></div></li>
              </form>
            </ol>
          </div>
        </div>
        <div id="event-watcher"></div>
        <div style='right: 13px; top: 100px; position: absolute; text-align: center; border: 1px solid black; background-color: #252B3C; color: white; padding: 2px; width: 230px; height: 30px; margin-top: 5px;'>
        <ul style="list-style-type: none; margin: 0; padding: 0; line-height: 27px;">
          <li style="float: left"><a style="display: block; color: white; text-align: center; padding: 2px 16px; text-decoration: none;" href="%MYAPP_PROTOCOL%://refresh/eventwatcher">🔄 Refresh</a></li>
          <li style="float: left"><a style="display: block; color: white; text-align: center; padding: 2px 16px; text-decoration: none;" href="%MYAPP_PROTOCOL%://setting/eventwatcher">⚙ Setting</a></li>
        </ul></div>
        <ul id="utility" style="margin: 0px; padding: 0px;">
          <li><div class="menu-tooltip"><a href="%MYAPP_PROTOCOL%://" style="line-height: 42px;">≡</a><span class="menu"><a style="color: black" href="%MYAPP_PROTOCOL%://run/myfxbook">📓 MyFxBook</a><hr>⌛ Menu 2</span></div><li>
          <li><div class="menu-tooltip"><a href="%MYAPP_PROTOCOL%://" style="font-size: 20px; height: 40px">▶</a><span class="tooltiptext"><div class="menu-tooltip-arrow"></div>Start Trading</span></div><li>
          <li><div class="menu-tooltip"><a href="%MYAPP_PROTOCOL%://run/tradelogger">📝</a><span class="tooltiptext"><div class="menu-tooltip-arrow"></div>Trade Logger</span></div><li>
          <li><div class="menu-tooltip"><a href="%MYAPP_PROTOCOL%://run/terminal">⚖</a><span class="tooltiptext"><div class="menu-tooltip-arrow"></div>Trade Terminal</span></div><li>
          <li><div class="menu-tooltip"><a href="%MYAPP_PROTOCOL%://run/quip"><img width="42" height="42" src="%A_ScriptDir%/pic/quip.png"></a><span class="tooltiptext"><div class="menu-tooltip-arrow"></div>Quip</span></div><li>
          <li><div class="menu-tooltip"><a href="%MYAPP_PROTOCOL%://run/tradingview"><img width="42" height="42" src="%A_ScriptDir%/pic/tradingview.png"></a><span class="tooltiptext"><div class="menu-tooltip-arrow"></div>Tradingview</span></div><li>
          <li><div class="menu-tooltip"><a href="%MYAPP_PROTOCOL%://run/calculator"><span style="font-size: 50px; line-height: 42px">🖩</span></a><span class="tooltiptext"><div class="menu-tooltip-arrow"></div>Calculator</span></div><li>
          <li><div class="menu-tooltip"><a href="%MYAPP_PROTOCOL%://run/setting">🛠</a><span class="tooltiptext"><div class="menu-tooltip-arrow"></div>Setting</span></div></li>
        </ul>
	</body>
</html>
)
WB_Home.Document.Write(home_html . time_html)
Gui, +ToolWindow +AlwaysOnTop
Gui, Show, w620 h510 y50, Trader Dashboard ™ - © 2017
UpdateEventWatch(5)
Sleep 50
ComObjConnect(WB_Home, WB_Home_events)  ; Connect WB's events to the WB_events class object.
return

;	/////////////////////////////////////////////
;	///														///
;	///					G - LABEL					///
;	///														///
;	////////////////////////////////////////////
;	/////////////////////////////////////////////
;	///	    	CLOCK - IN SYSTEM      		///
;	////////////////////////////////////////////
ClockIn:
Time_Second++
if Time_Second >= 60
{
  Time_Second = 0
  Time_Minute++
}
if Time_Minute >= 60
{
  Time_Minute = 0
  Time_Hour++
}
Display_Second := Time_Second
Display_Minute := Time_Minute
Display_Hour := Time_Hour

If Time_Second < 10
  Display_Second = 0%Time_Second%
If Time_Minute < 10
  Display_Minute = 0%Time_Minute%
If Time_Hour < 10
  Display_Hour = 0%Time_Hour%

;~ GuiControl,, ClockTime, %Display_Hour%:%Display_Minute%:%Display_Second%
return

return
;	/////////////////////////////////////////////
;	///		UPDATE MARKET TIMELINE	///
;	////////////////////////////////////////////
update_market_hour:
FormatTime, Label, , hh:mm:ss
WB_Home.document.getElementById("Label").innerHTML := Label
; Varibles
table_width := WB_Home.document.getElementById("market-hour").offsetWidth+10.5
hour_pixel := table_width/24
h := SubStr(A_NowUTC, 9, 2)
m := SubStr(A_NowUTC,11, 2)
s := SubStr(A_NowUTC,13, 2)
; calculate closing in / opening in status
if m = 0
  m = 60
; SYDNEY
sydney_open := 21-h . "h " . 60-m . "m"
if h >= 21
  sydney_close := 6-(h-23) . "h " . 60-m . "m"
  ;~ sydney_close := 6-(h-23) . "h " . 60-m . "m" HERE
else
  sydney_close := 6-h . "h " . 60-m . "m"
; TOKYO
tokyo_open := 22-h . "h " . 60-m . "m"
if h >= 22
  tokyo_close := 7-(h-23) . "h " . 60-m . "m"
else
  tokyo_close := 7-h . "h " . 60-m . "m"
; LONDON
if h >= 20
  london_open := 23+7-h . "h " . 60-m . "m"
else
  london_open := 6-h . "h " . 60-m . "m"
london_close := 15-h . "h " . 60-m . "m"
; NEWYORK
if h >= 20
  newyork_open := 23+12-h . "h " . 60-m . "m"
else
  newyork_open := 11-h . "h " . 60-m . "m"
newyork_close := 20-h . "h " . 60-m . "m"
;--------------------------------------------------------------
; SYDNEY
if (h  >= 21 && h <= 23 || h >= 0 && h <= 6)
  WB_Home.document.getElementById("sydney_stat").innerText := "close in " . sydney_close
else
  WB_Home.document.getElementById("sydney_stat").innerText := "open in " . sydney_open
; TOKYO
if (h >= 22 && h <= 23 || h >= 0 && h <= 7 )
  WB_Home.document.getElementById("tokyo_stat").innerText := "close in " . tokyo_close
else
  WB_Home.document.getElementById("tokyo_stat").innerText := "open in " . tokyo_open
; LONDON
if (h >= 7 && h <= 15)
  WB_Home.document.getElementById("london_stat").innerText := "close in " . london_close
else
  WB_Home.document.getElementById("london_stat").innerText := "open in " . london_open
; NEWYORK
if (h >= 12 && h <= 20)
  WB_Home.document.getElementById("newyork_stat").innerText := "close in " . newyork_close
else
  WB_Home.document.getElementById("newyork_stat").innerText := "open in " . newyork_open
;off set hour
if (h >= 21)
  h -= 24
x_coord := (hour_pixel*h)
;display correction
x_coord := x_coord + (hour_pixel*3)
; offset minutes
x_coord := x_coord + (hour_pixel/60)*m
WB_Home.document.getElementById("Mark").style.left := x_coord-5
WB_Home.document.getElementById("Label").style.left := "11px"
WB_Home.document.getElementById("Arrow").style.left := "4px"
WB_Home.document.getElementById("Arrow").style.borderTop := "7px solid transparent"
WB_Home.document.getElementById("Arrow").style.borderBottom := "7px solid transparent"
WB_Home.document.getElementById("Arrow").style.borderLeft := ""
WB_Home.document.getElementById("Arrow").style.borderRight := "7px solid black"
if (h >= 17 && h <= 20)
{
  WB_Home.document.getElementById("Label").style.left := "-115px"
  WB_Home.document.getElementById("Arrow").style.left := "-11px"
  WB_Home.document.getElementById("Arrow").style.borderTop := "7px solid transparent"
  WB_Home.document.getElementById("Arrow").style.borderBottom := "7px solid transparent"
  WB_Home.document.getElementById("Arrow").style.borderRight := "7px solid transparent"
  WB_Home.document.getElementById("Arrow").style.borderLeft := "7px solid black"
}
 ; -- Market Light up --
 ; neutralize number to 0 linear
 h+=3
 if (h >= 1 && h < 10) ; SYDNEY
   Loop 9
     WB_Home.document.getElementById("market-hours-sydney-" . A_Index).style.backgroundColor := "#25d0a3"
   else
     Loop 9
       WB_Home.document.getElementById("market-hours-sydney-" . A_Index).style.backgroundColor := "#252b3c"
 if (h >= 2 && h < 11) ; TOKYO
   Loop 9
     WB_Home.document.getElementById("market-hours-tokyo-" . A_Index).style.backgroundColor := "#25d0a3"
   else
     Loop 9
       WB_Home.document.getElementById("market-hours-tokyo-" . A_Index).style.backgroundColor := "#252b3c"
 if (h >= 10 && h < 19) ; LONDON
   Loop 9
     WB_Home.document.getElementById("market-hours-london-" . A_Index).style.backgroundColor := "#25d0a3"
   else
     Loop 9
       WB_Home.document.getElementById("market-hours-london-" . A_Index).style.backgroundColor := "#252b3c"
 if (h >= 15 && h < 24) ; NEWYORK
   Loop 9
     WB_Home.document.getElementById("market-hours-newyork-" . A_Index).style.backgroundColor := "#25d0a3"
   else
     Loop 9
       WB_Home.document.getElementById("market-hours-newyork-" . A_Index).style.backgroundColor := "#252b3c"
;	/////////////////////////////////////////////
;	///		CLOCK & DATE UPDATE			///
;	////////////////////////////////////////////
If A_WDay = 1
  DOTW = Sunday
else if A_WDay = 2
  DOTW = Monday
else if A_WDay = 3
  DOTW = Tuesday
else if A_WDay = 4
  DOTW = Wednesday
else if A_WDay = 5
  DOTW = Thursday
else if A_WDay = 6
  DOTW = Friday
else if A_WDay = 7
  DOTW = Saturday
if (A_Min != currMin)
  WB_Home.document.getElementById("event-watcher").innerHTML := countDownEvent()
currMin := A_Min

GuiControl,, home_info, %A_MMM%, %A_DD%, %A_YYYY%`n%DOTW%
FormatTime, home_info_time, , hhmmtt
GuiControl,, home_info_time, %home_info_time%
StringSplit, home_info_time_, home_info_time
Loop 6
	WB_Home.document.getElementById("time_display_" . A_Index).innerHTML := home_info_time_%A_Index%
WB_Home.document.getElementById("currDate").innerHTML := "<a href='" . MYAPP_PROTOCOL . "://toggle/monthcal'>" . DOTW . ", " .  A_MMM .  ", " . A_DD . ", " . A_YYYY . "</a>"
return
;	/////////////////////////////////////////////
;	///														///
;	///					FUNCTION					///
;	///														///
;	////////////////////////////////////////////
class WB_Home_events {
	;for more events and other, see http://msdn.microsoft.com/en-us/library/aa752085
	
	NavigateComplete2(WB_Home) {
		WB_Home.Stop() ;blocked all navigation, we want our own stuff happening
	}
	DownloadComplete(WB_Home, NewURL) {
		WB_Home.Stop() ;blocked all navigation, we want our own stuff happening
	}
	DocumentComplete(WB_Home, NewURL) {
		WB_Home.Stop() ;blocked all navigation, we want our own stuff happening
	}
	
	BeforeNavigate2(WB_Home, NewURL)
	{
		WB_Home.Stop() ;blocked all navigation, we want our own stuff happening
		;parse the url
		global MYAPP_PROTOCOL, toggle_MonthCal, toggle_Setting
		if (InStr(NewURL,MYAPP_PROTOCOL "://")==1) { ;if url starts with "myapp://"
			what := SubStr(NewURL,Strlen(MYAPP_PROTOCOL)+4) ;get stuff after "myapp://"
			if InStr(what,"toggle/monthcal")
            {
              toggle_MonthCal := !toggle_MonthCal
              if toggle_MonthCal
                GuiControl, Move, MonthCal, x410 y85
              else
                GuiControl, Move, MonthCal, x-400 y-90
            }
			else if InStr(what,"refresh/eventwatch")
              UpdateEventWatch(5)
            else if InStr(what,"setting/eventwatch")
            {
              toggle_MonthCal := !toggle_MonthCal
              if toggle_MonthCal
              {
                GuiControl,Move, WB_Calendar, x0 y278
                WB_Calendar.Navigate("https://www.forexfactory.com/calendar.php")
              }
              else
              {
                GuiControl,Move, WB_Calendar, x-1000 y-500
                WB.Navigate("about:blank")
              }
            }
            else if InStr(what,"refresh/checklist")
            {
              checklist_html =
              (Ltrim Join
          ☑ Check List - <a href="%MYAPP_PROTOCOL%://refresh/checklist">🔄</a> <hr>
          <div style="width: 240px; height: 230px;">
            <ol style="margin: 10px; padding: 0 20px 10px;">
            <form>
              <li><div class="tooltip"><input type="checkbox"> Trend<span class="tooltiptext"><div class="tooltip-arrow"></div>( multi time frame = overall trend )<br>From monthly to the 4H, is it going up or down. Check them all out & mark it up so you know what's going on over all, then break it down</span></div></li>
              <li><div class="tooltip"><input type="checkbox"> Structure<span class="tooltiptext"><div class="tooltip-arrow"></div></span></div></li>
              <li><div class="tooltip"><input type="checkbox"> Candle Pattern<span class="tooltiptext"><div class="tooltip-arrow"></div></span></div></li>
              <li><div class="tooltip"><input type="checkbox"> Trend Pattern (opt)<span class="tooltiptext"><div class="tooltip-arrow"></div></span></div></li>
              <li><div class="tooltip"><input type="checkbox"> PRZ Behavior<span class="tooltiptext"><div class="tooltip-arrow"></div></span></div></li>
              <li><div class="tooltip"><input type="checkbox"> Fibonacci<span class="tooltiptext"><div class="tooltip-arrow"></div></span></div></li>
              </form>
            </ol>
          </div>
              )
              WB_Home.document.getElementById("trading-checklist").innerHTML := checklist_html
            }
            else if InStr(what,"run")
            {
              StringSplit, temp_, what, /
              if temp_2 = tradelogger
                Run Trade Logger.ahk
              else if temp_2 = terminal
                Run C:\Program Files (x86)\LMFX MetaTrader 4 Terminal\terminal.exe
              else if temp_2 = quip
                Run C:\Users\510th\AppData\Local\Quip\Update.exe --processStart "Quip.exe"
              else if temp_2 = tradingview
                Run chrome.exe https://www.tradingview.com/chart/2LEk6KYk/
              else if temp_2 = myfxbook
                Run chrome.exe https://www.myfxbook.com/portfolio/traders-way/2302561
            }
		}
		;else do nothing
	}
}
GetCalendar(WB) {
	WB.Navigate("https://www.forexfactory.com/calendar.php")
	while wb.ReadyState <> 4
		continue    
	SourceCode := WB.document.documentElement.outerHTML
	Sleep 100
	; Split source code to take the calendar part only
	StringReplace, SourceCode, SourceCode, <span class="normal">, †,all
	StringReplace, SourceCode, SourceCode, Forex Factory 2017, †
	StringSplit, html_, SourceCode, † 
	WB.Navigate("about:blank")
	Sleep 50
	; Split the Calendar HTML code to get the table only
	StringReplace, html_4, html_4, </form>, †
	StringSplit, html_, html_4, †
	CalendarSource := html_2
	; Dividing days
	StringReplace, CalendarSource, CalendarSource, calendar__row--day-breaker, †, all
	StringSplit, Calendar_day_, CalendarSource, †
	Loop, %calendar_day_0%
	{
		; divide up the events in the day
		StringReplace,  Calendar_day_%A_Index%, Calendar_day_%A_Index%, calendar__row calendar_row,  †, all
		StringSplit, event_, Calendar_day_%A_Index%, †
		currIndex := A_Index
		Loop %event_0%
		{
			; replace class to ID for easier maniupulation
			mod_Index := A_Index - 1
			StringReplace, Calendar_day_%currIndex%, Calendar_day_%currIndex%, class="calendar__cell calendar__date date", id="day-%currIndex%-event-date"
			StringReplace, Calendar_day_%currIndex%, Calendar_day_%currIndex%, class="calendar__cell calendar__time time", id="day-%currIndex%-event-time-%mod_Index%"
			StringReplace, Calendar_day_%currIndex%, Calendar_day_%currIndex%, class="calendar__cell calendar__currency currency", id="day-%currIndex%-event-currency-%mod_Index%"
			StringReplace, Calendar_day_%currIndex%, Calendar_day_%currIndex%, class="calendar__impact-icon calendar__impact-icon--screen", id="day-%currIndex%-event-impact-%mod_Index%"
			StringReplace, Calendar_day_%currIndex%, Calendar_day_%currIndex%, class="calendar__impact-icon calendar__impact-icon--print", id="day-%currIndex%-event-impact-img-%mod_Index%"
			StringReplace, Calendar_day_%currIndex%, Calendar_day_%currIndex%, class="calendar__event-title", id="day-%currIndex%-event-title-%mod_Index%"
			StringReplace, Calendar_day_%currIndex%, Calendar_day_%currIndex%, class="calendar__cell calendar__actual actual", id="day-%currIndex%-event-actual-%mod_Index%"
			StringReplace, Calendar_day_%currIndex%, Calendar_day_%currIndex%, class="calendar__cell calendar__forecast forecast", id="day-%currIndex%-event-forecast-%mod_Index%"
			StringReplace, Calendar_day_%currIndex%, Calendar_day_%currIndex%, class="calendar__cell calendar__previous previous", id="day-%currIndex%-event-previous-%mod_Index%"
		}
	}
	Loop %Calendar_day_0%
	{
		if A_Index = 1
			continue
		calendar_html := calendar_html . Calendar_day_%A_Index%
	}
	; Load html & renaming classes
	WB.Document.Write("<table>" . calendar_html)
	Sleep 50
	Loop, %calendar_day_0%
	{
		if (A_Index = 1)
			continue
		curr_mod_Index := A_Index
		StringReplace, calendar_day_%A_index%, calendar_day_%A_Index%, †, †, UseErrorLevel	
		event_num := ErrorLevel
		; numbers of event in the day
		Loop, %event_num%
		{
			; Collect info and set it to parsable text
			mod_Index := A_Index - 1
			event_date := WB.document.getElementById("day-" . curr_mod_Index . "-event-date").innerText 
			event_time := WB.document.getElementById("day-" . curr_mod_Index . "-event-time-" . mod_Index).innerText 
			event_currency := WB.document.getElementById("day-" . curr_mod_Index . "-event-currency-" . mod_Index).innerText 
			RegExMatch(WB.document.getElementById("day-" . curr_mod_Index . "-event-impact-" . mod_Index).innerHTML ,"title=(.*)class", event_impact)
			StringReplace, event_impact, event_impact, title=,,
			StringReplace, event_impact, event_impact, %A_Space%class,,
			StringReplace, event_impact, event_impact, `",,all
			event_impact_img := WB.document.getElementById("day-" . curr_mod_Index . "-event-impact-img-" . mod_Index).innerHTML
			event_title := WB.document.getElementById("day-" . curr_mod_Index . "-event-title-" . mod_Index).innerText
			event_actual :=  WB.document.getElementById("day-" . curr_mod_Index . "-event-actual-" . mod_Index).innerHTML
			event_forecast :=  WB.document.getElementById("day-" . curr_mod_Index . "-event-forecast-" . mod_Index).innerHTML
			event_previous :=  WB.document.getElementById("day-" . curr_mod_Index . "-event-previous-" . mod_Index).innerHTML
			if event_title !=
				calendar_txt := calendar_txt . event_date . "|" . event_time . "|" . event_currency . "|" . event_impact . "|" . event_impact_img . "|" event_title . "|" event_actual . "|" event_forecast . "|" event_previous . "`n"
		}
		calendar_txt = %calendar_txt%#
	}
    WB.Navigate("about:blank")
	return calendar_txt
}
UTC_offset() {
  Leap_Year := false
  if SubStr(A_NowUTC,1,4)/4 = 0
     if SubStr(A_NowUTC,1,4)/100 = 0
       if Substr(A_NowUTC,1,4)/400 = 0
         Leap_Year := true
  dayOfyear := 0
  Loop 12
  {
    if (A_Index < SubStr(A_NowUTC,5,2))
    {
      if A_Index = 1
        dayOfyear += 31
      if A_Index = 2
        if Leap_Year = 0
          dayOfyear += 28
        else
          dayOfyear += 29
      if A_Index = 3
        dayOfyear += 31
      if A_Index = 4
        dayOfyear += 30
      if A_Index = 5
        dayOfyear += 31
      if A_Index = 6
        dayOfyear += 30
      if A_Index = 7
        dayOfyear += 31
      if A_Index = 8
        dayOfyear += 31
      if A_Index = 9
        dayOfyear += 30
      if A_Index = 10
        dayOfyear += 31
      if A_Index = 11
        dayOfyear += 30
    }
  }
  dayOfyear += SubStr(A_NowUTC,7,2)
  if (dayOfyear < A_YDay)
    UTC := SubStr(A_NowUTC,9,2) - SubStr(A_Now,9,2)
  else if (dayOfyear = A_YDay)
    UTC := SubStr(A_NowUTC,9,2) - SubStr(A_Now,9,2)
  else if (dayOfyear > A_YDay)
    UTC := 24- (SubStr(A_Now,9,2) - SubStr(A_NowUTC,9,2))
  ; reverse
  return UTC*-1
}
findDateCount(month) {
  if month = 1
    days_count := 31
  if month = 2
    if (Mod(A_Year,4) = 0)
      days_count := 29
    else if (Mod(A_Year,100) = 0)
      days_count := 28
    else if (Mod(A_Year,100) = 0 && Mod(A_Year,400) = 0)
      days_count := 29
    else
      days_count := 28
  if month = 3
    days_count := 31
  if month = 4
    days_count := 30
  if month = 5
    days_count := 31
  if month = 6
    days_count := 30
  if month = 7
    days_count := 31
  if month = 8
    days_count := 31
  if month = 9
    days_count := 30
  if month = 10
    days_count := 31
  if month = 11
    days_count := 30
  if month = 12
    days_count := 31
  return days_count
}
UpdateEventWatch(amount) {
cal_txt := getCalendar(WB_Calendar)
WB_Home.document.GetElementById("event-watcher").innerHTML := ""
event_info_num := 0
  Loop, parse, cal_txt, #		; Parse Day seperate by #
  {
    Loop, parse, A_LoopField, `n			; Parse Events inside Day seperate by linefeed
    {
      ; get incoming news
      if !A_LoopField
          continue
      ; Split event to variables
      StringSplit, event_info_, A_LoopField, |
      AutoTrim, On
      event_info_date := event_info_1
      event_info_date_m := SubStr(event_info_date,4,3)
      event_info_date_d := SubStr(event_info_date,8,2)
      if event_info_2 ; save last run time
          event_info_time := event_info_2
      AutoTrim, Off
      ; TIME
      StringRight, event_info_time_ap, event_info_time, 2		; AM / PM
      StringTrimRight, event_info_time_h_12, event_info_time, 2 ; HOUR in 12H mode
      StringSplit, event_time_, event_info_time_h_12, :
      event_info_time_h_12 := event_time_1
      if event_info_time_ap = pm
      {
        event_info_time_h_24 := event_info_time_h_12 + 12
        if event_info_time_h_12 = 12
          event_info_time_h_24 = 12
      }
      else
      {
          event_info_time_h_24 := event_info_time_h_12
          if event_info_time_h_12 = 12
            event_info_time_h_24 = 0
      }
      event_info_time_m := event_time_2
      ; --
      event_info_currency := event_info_3
      event_info_impact := event_info_4
      event_info_impact_img := event_info_5
      event_info_title := event_info_6
      event_info_actual := event_info_7
      event_info_forecast := event_info_8
      event_info_previous := event_info_9
      ; Filter out old news
      if (A_MMM = event_info_date_m)  ; if same month
      {
        event_info_until_h :=  24*(event_info_date_d - A_DD) - A_Hour + event_info_time_h_24
        event_info_until_m := event_info_time_m - A_Min
        if event_info_until_m < 0
        {
          event_info_until_m+=60
          event_info_until_h-=1
        }
        if (even_info_until_m > 0 && event_info_until_m < 10)
          event_info_until_m = 0%event_info_until_m%
      }
      else if (A_MMM > event_info_date_m) ; diff month
      {
        event_info_until_h := 24*(findDateCount(A_MM) - A_DD + event_info_date_d) - A_Hour + event_info_time_h_24
        event_info_until_m := event_info_time_m - A_Min
        if event_info_until_m < 0
        {
          event_info_until_m+=60
          event_info_until_h-=1
        }
        if (even_info_until_m > 0 && event_info_until_m < 10)
          event_info_until_m = 0%event_info_until_m%
      }
      ; Value Check
      ;~ MsgBox event_info_date : %event_info_date%`nevent_info_time : %event_info_time%`nevent_info_time_ap : %event_info_time_ap%`nevent_info_time_h_12 : %event_info_time_h_12%`nevent_info_time_h_24 : %event_info_time_h_24%`nevent_info_time_m : %event_info_time_m%`nevent_info_currency : %event_info_currency%`nevent_info_impact : %event_info_impact%`nevent_info_impact_img : %event_info_impact_img%`nevent_info_title : %event_info_title%`nevent_info_date_m : %event_info_date_m%`nevent_info_date_d : %event_info_date_d%
      event_info_until := event_info_until_h "h " event_info_until_m "m"
      ; get All Day , Tentative and other type of Time
      if (event_info_date_m == "Jan")
        event_info_date_MM = 1
      else if (event_info_date_m == "Feb")
        event_info_date_MM = 2
      else if (event_info_date_m == "Mar")
        event_info_date_MM = 3
      else if (event_info_date_m == "Apr")
        event_info_date_MM = 4
      else if (event_info_date_m == "May")
        event_info_date_MM = 5
      else if (event_info_date_m == "Jun")
        event_info_date_MM = 6
      else if (event_info_date_m == "Jul")
        event_info_date_MM = 7
      else if (event_info_date_m == "Aug")
        event_info_date_MM = 8
      else if (event_info_date_m == "Sep")
        event_info_date_MM = 9
      else if (event_info_date_m == "Oct")
        event_info_date_MM = 10
      else if (event_info_date_m == "Nov")
        event_info_date_MM = 11
      else if (event_info_date_m == "Dec")
        event_info_date_MM = 12
      ; filter All Day, tentative & stuff like that by dates
      if (event_info_date_MM >= A_MM)
        if (event_info_date_d >= A_DD)
          IfNotInString, event_info_time, :
        WB_Home.document.GetElementById("event-watcher").innerHTML .= "<div style='position: relative; text-align: left; border: 1px solid black; background-color: #252B3C; color: white; padding: 5px; width: 200px; height: 20px; margin-top: 5px'>" . event_info_impact_img . event_info_currency . " - " . event_info_time . "</div>"
      ; Update Event Watch
      if event_info_until_h >= 0
        WB_Home.document.GetElementById("event-watcher").innerHTML .= "<div style='position: relative; text-align: left; border: 1px solid black; background-color: #252B3C; color: white; padding: 5px; width: 200px; height: 20px; margin-top: 5px'>" . event_info_impact_img . event_info_currency . " - " . event_info_until . "</div>"
      ; Set UpNextTimer = Event Time - currTime, accurate by seconds
      ;~ here
    }
  }
}
countDownEvent() {
  event_watcher_html := WB_Home.document.getElementById("event-watcher").innerHTML
  StringReplace, event_watcher_html, event_watcher_html, <DIV, †, all
  StringSplit, event_watcher_html_, event_watcher_html, †
  Loop, %event_watcher_html_0%
  {
    if A_Index = 1
      continue
    ; Assign variables
    StringLeft, symbol, event_watcher_html_%A_Index%, 3
    RegExMatch(event_watcher_html_%A_Index%,"png(.*)<",symbol)
    RegExMatch(event_watcher_html_%A_Index%,"impact-(.*)png",impact)
    StringTrimRight, symbol, symbol, 1
    StringTrimLeft, symbol, symbol, 6
    StringTrimRight, impact, impact, 4 
    StringTrimLeft, impact, impact, 7
    StringReplace, impact, impact, red, High
    StringReplace, impact, impact, orange, Medium
    StringReplace, impact, impact, yellow, Low
    StringSplit, symbol_, symbol, -
    symbol := symbol_1
    time := symbol_2
    StringTrimLeft, time, time, 1
    StringTrimRight, symbol, symbol, 1
    var := SubStr(time,1,1) 
    if var is number
    {
      StringReplace, time, time, h,,
      StringReplace, time, time, m,,
      StringSplit, time_, time, %A_Space%
      time_h := time_1
      time_m := time_2
      
      time_m-=1 ; Minute
      if time_m <= 0
      {
        time_h-=1   ;Hour
        time_m+=60
      }
      StringReplace, event_watcher_html_%A_Index%, event_watcher_html_%A_Index%,%symbol% - %time_1%h %time_2%m, %symbol% - %time_h%h %time_m%m
      if (time_m >= 0 && time_h >= 0)
        new_Event_watcher_html .= "<DIV " . event_watcher_html_%A_Index%
      ; 5 minute notify
      if (time_m = 4 && time_h = 0)
        TrayTip , %impact% Impact, %symbol% - in 5 minute, 4 ;show for 4 seconds
    }
    else
      new_Event_watcher_html .= "<DIV " . event_watcher_html_%A_Index%
  }
  return new_Event_watcher_html
}
;~ F2::  WB_Home.document.getElementById("event-watcher").innerHTML := countDownEvent()
; Hotkey for multiple time frame analyse
^Up::Send ⇧
^Down::Send ⇩
^Left::Send  ⇘
^Right::Send  ⇗
~Up & Down::Send ⇨
Shift & Tab::
toggle_Show := !toggle_Show
if toggle_Show
  Gui, Hide
else
  Gui, Show
return
GuiClose:
F5::
ExitApp