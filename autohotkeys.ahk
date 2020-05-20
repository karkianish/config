#SingleInstance force ;this supresses the dialogue box that confirms about running a new instance when an instance is already running.
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;this is useful when using Vimium and I need to escape the entry field; my fav is when escaping intellisense help in VS
Capslock::Esc

::;rqf::ps.plan.+.reporting-listener

;::btw::by the way,
;::Btw::By the way,
::shrug::¯\_(?)_/¯
::;lcl::https://app-local.pluralsight.com:3000/plan-analytics/adventureworks
--psql
::;sf::select * from limit(10);{Left 11}
::;tt::create temp table t1 as select * from limit(10);{Left 11}
::;ea::explain analyse
::;ij::inner join


;markdown hotkeys
::;js::```````javascript{Enter 2}```````{Up}
