#include lib/Tippy.ahk



; There is no need for a standard ahk auto-execute area anymore because of this method.
; This method is called automatically when the static variable autoExecute is instantiated,
; and since it's a static, it will only be instantiated once!
;
; Idea provided by @nnnik#6686 on the AHK Discord Server: https://discord.gg/s3Fqygv
FixKeyGhostPressesAutoExecute()
{
    static autoExecute := FixKeyGhostPressesAutoExecute()

}

class Ghosty
{
    static lastUpTime := A_TickCount
    static lastDownTime := A_TickCount
    static minTime := 40 ; millis - anything key down->up or up->down less than this value is an unwanted ghost click.
    static tooltipMillis := 5000
    static tooltipExtraOffsetY := 80
    static counter := 0
}


;------------------------------------------------
; Disable faulty multiple "i" key presses
;
; Explanation: my 1st gen many-years-old-spilled-with-tea Corsair K70 RGB a has faulty "i" key.
;   When pressed once, it may register 1, none, or even 3 presses.
;   Kinda annoying, yes.
;
;
; The commented hotkey below is the legacy way which even if works, has the issue that it breaks all hotstrings containing "i"
;           since keyboard "i" is blocked, and ahk sends a "fake i"
; $*i::
;     If (A_TimeSincePriorHotkey < 90 && A_TimeSincePriorHotkey > 1) {
;         Tippy("i doublePress " . A_Now)
;         Return
;     }
;     Send % "{Blind}i"       ; use Blind mode so that Shift and CapsLock work
; Return
;
;
; This is a suggestion from @CloakerSmoker#2459 on the ahk discord: https://discord.gg/eKEX7AG
;
; Bind "i" key to nothing (`~*i::Return`), just so that A_TimeSincePriorHotkey updates and don't block the key on a normal press.
; Otherwise if it was a double press, show the tooltip and block the OS from getting the key press
; By using #if we have the original key presses getting sent, instead of AHK sending them
;       which should fix hotstrings/hotkeys that were messing up

; #if (A_TimeSincePriorHotkey < 90 && A_TimeSincePriorHotkey > 1)
; *i::
;     Tippy("Double press at " A_Now)
; Return
; #if

; ~*i::Return







; --------------------------------------
; --------------------------------------
; --------------------------------------
; --------------------------------------
; let's try the same fix for LMB
;       -- later edit, not working properly
;
; #if (A_TimeSincePriorHotkey < 100 && A_TimeSincePriorHotkey > 0)
; *LButton::
;     Tippy("Double press at " A_Now "`nTime since prior hotkey " A_TimeSincePriorHotkey "`n`nThis hotkey " A_ThisHotkey "`nPrior hokey " A_PriorHotkey, , -1)
; Return
; #if
;
; ~*LButton::Return

; ; --------------------------------------

; ; this version doesn't work either
; LButton up::Return

; LButton::
;    Ghosty.minTime := 30 ; millis - anything key down->up or up->down less than this value is an unwanted ghost click.

;    ; If (A_ThisHotkey = "LButton up")
;    ; {
;    ;     Return
;    ; }

;    If (A_TimeSincePriorHotkey < Ghosty.minTime && A_TimeSincePriorHotkey > 0)
;    {
;        Tippy("Double press at " A_Now "`nTime since prior hotkey " A_TimeSincePriorHotkey "`n`nThis hotkey " A_ThisHotkey "`nPrior hokey " A_PriorHotkey, , -1)
;        Return
;    }

;    ; loop KeyWait until Ghosty.minTime millis pass between mouse clicks
;    Send {LButton Down}
;    ticksKeyDown := A_TickCount
;    KeyWait, LButton
;    ticksKeyUp := A_TickCount
;    difference := ticksKeyUp - ticksKeyDown
;    while( difference <= Ghosty.minTime )
;    {
;        ticksKeyDown := A_TickCount
;        KeyWait, LButton
;        ticksKeyUp := A_TickCount
;        difference := ticksKeyUp - ticksKeyDown
;    }
;    Send {LButton Up}
; Return




; LButton up::
;     Ghosty.lastUpTime := A_TickCount
;     ;                         Tippy("up    " A_TickCount, Ghosty.tooltipMillis, -1, Ghosty.tooltipExtraOffsetY)

;     SetTimer, sendUp, % -1 * Ghosty.minTime * 1.6
; Return

; LButton::
;     delta := Min(A_TickCount - Ghosty.lastUpTime, A_TickCount - Ghosty.lastDownTime)
;     if ( GetKeyState(LButton , P) || delta <= Ghosty.minTime )
;     {
;         SetTimer, sendUp, Off
;         ; Tippy(A_TickCount " ↓ X ↑ X            delta " delta,, -1, Ghosty.tooltipExtraOffsetY)
;         Return
;     }

;     ; if (Ghosty.counter >= 1)
;     ; {
;     ;     Tippy(A_TickCount " ↓ X ↑ X            counter " Ghosty.counter,, -1, Ghosty.tooltipExtraOffsetY)
;     ;     Return
;     ; }

;     Send {LButton Down}
;     Tippy(A_TickCount " ↓↓↓↓                  delta " delta, Ghosty.tooltipMillis, -1, Ghosty.tooltipExtraOffsetY)
;     Ghosty.lastDownTime := A_TickCount
;     Ghosty.counter++
; Return

; sendUp() {
;     delta := Min(A_TickCount - Ghosty.lastUpTime, A_TickCount - Ghosty.lastDownTime)

;     if( GetKeyState(LButton , P) || delta <= Ghosty.minTime )
;     {
;         Return
;     }

;     ; if (Ghosty.counter <= -1)
;     ; {
;     ;     Tippy(A_TickCount " ↓ X ↑ X            counter " Ghosty.counter,, -1, Ghosty.tooltipExtraOffsetY)
;     ;     Return
;     ; }

;     Send {LButton up}
;     Tippy(A_TickCount " Send UP " delta, Ghosty.tooltipMillis, -1, Ghosty.tooltipExtraOffsetY)
;     Ghosty.lastUpTime := A_TickCount
;     Ghosty.counter--
; }
