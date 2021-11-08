; old scripts, not used anymore.


;-------------------------------------------------
;       mouse lower the volume
; XButton2::
; firstClick = 1
; loop
; {
;     if firstClick = 1   ; so that i have a pause after pressing and holding the key
;     {
;         Send {Volume_Up 1}
;         sleep, 500
;         firstClick = 0
;     }
;     GetKeyState, state, XButton2, P
;     if state = D
;         Send {Volume_Up 1}
;     else
;         return

;     sleep, 120
; }



;-------------------------------------------------
;       mouse increase the volume
; XButton1::
; firstClick = 1
; loop
; {
;     if firstClick = 1   ; so that i have a pause after pressing and holding the key
;     {
;         Send {Volume_Down 1}
;         sleep, 500
;         firstClick = 0
;     }
;     GetKeyState, state, XButton1, P
;     if state = D
;         Send {Volume_Down 1}
;     else
;         return
;     sleep, 120
; }



;------------------------------------------------
; Disable faulty double middle click
; as per here: http://leo.steamr.com/2012/08/fixing-mouse-buttonwheel-from-unintended-double-clicking/
; Explanation: my Madcatz RAT 9 mouse has a faulty middle buttton
; which if pressed once it actually can register 1, none, or even 20 clicks.
; Kinda annoying yea.

; ; This fixes the problem.
; MButton::
;     If (A_TimeSincePriorHotkey < 190 && A_TimeSincePriorHotkey > 1) {
;       ;  MsgBox % A_TimeSincePriorHotkey
;         Return
;     }
;     Send {MButton Down}
;     KeyWait, MButton
;     Send {MButton Up}
; Return
