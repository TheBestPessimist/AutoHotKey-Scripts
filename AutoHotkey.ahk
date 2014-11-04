;-------------------------------------------------
; i use this to capture the keyboard keystrokes (it does not work for FN + sth on SUSV)
; #InstallKeybdHook
; #InstallMouseHook

;-------------------------------------------------
;       mouse lower the volume
XButton2::
firstClick = 1
loop
{
	
	if firstClick = 1	; so that i have a pause after pressing and holding the key
	{
		Send {Volume_Up 2}
		sleep, 500
		firstClick = 0
	}
	GetKeyState, state, XButton2, P
	if state = D
		Send {Volume_Up} 
	else
		return

	sleep, 120
}


;-------------------------------------------------
;       mouse increase the volume
XButton1:: 
firstClick = 1
loop
{
	
	if firstClick = 1	; so that i have a pause after pressing and holding the key
	{
		Send {Volume_Down 2}
		sleep, 500
		firstClick = 0
	}
	GetKeyState, state, XButton1, P
	if state = D
		Send {Volume_Down}
	else
		return
	sleep, 120
}



;-------------------------------------------------
;       shortcut alt+3
!3::Send {Volume_Down 2}

;-------------------------------------------------
;       shortcut alt+4
!4::Send {Volume_Up 2}



;-------------------------------------------------
; start Sublime Text. "#" is used to simultate winKey (therefore shortcut = winKey + s)
!s::run "%A_Desktop%\Sublime Text 3\sublime_text.exe"
;!s::run "E:\portable apps\Sublime Text 3 32 bit\sublime_text -  cracked.exe"


; close Digsby when Esc key is pressed
; #IfWinActive Digsby "Buddy List"
;	WinGetActiveTitle, Title
;	MsgBox, The active window is "%Title%"

;#IfWinActive, Buddy List
;Esc::
; #c::
;{
;	WinClose
;	; msgbox tibi
;}




;-------------------------------------------------
;       Media Monkey shortcuts
Capslock & Right::Send {Media_Next}
Capslock & Left::Send {Media_Prev}
