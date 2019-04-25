#include lib/ToggleTimerAndShowTooltip.ahk
#include lib/Tippy.ahk
#include lib/ReloadScript.ahk

; This script contains all the stuff and timers and macros for SC2 (mostly the map Fallen World)
;
;       == HOW TO USE ==
;
; Press one of the key combos (CapsLock and NumpadX) after you saved that specific character(s) in the correct group.
; Read below what are the control groups.
;
; Starcraft 2 MUST be in **windowed fullscreen** or **windowed** mode.


; There is no need for a standard ahk auto-execute area anymore because of this method.
; This method is called automatically when the static variable autoExecute is instantiated,
; and since it's a static, it will only be instantiated once!
;
; Idea provided by @nnnik#6686 on the AHK Discord Server: https://discord.gg/s3Fqygv
StarCraft2AutoExecute(){
    static autoExecute := StarCraft2AutoExecute()

    SetTimer, StarCraft2AutoExecuteOnTimer, 3000
}


; In this method you can add all the function calls you want to run
; after autohotkey has started/reloaded
StarCraft2AutoExecuteOnTimer()
{
    SetTimer, StarCraft2AutoExecuteOnTimer, Off

    ; SC2.ToggleSpectrePlay()
    ; SC2.ToggleDragoonQ()
    ; SC2.ToggleMedic()
    ; SC2.ToggleAutoupgrade()
}

CapsLock & LButton::SC2.ClickManyTimes()

CapsLock & NumpadMult::SC2.SaveMousePosition()

; Dragoon is always on group 8
CapsLock & Numpad8::SC2.ToggleDragoonQ()

; Medic is always on group 7
CapsLock & Numpad7::SC2.ToggleMedic()

; Spectre is always in group 2
CapsLock & Numpad2::SC2.ToggleSpectrePlay()

; Centurion is always in group 4
CapsLock & Numpad4::SC2.ToggleCenturionPlay()

; Upgrade whatever is selected in group 1
CapsLock & Numpad1::SC2.ToggleAutoupgrade()



class SC2
{
; ahk OOP is weird/stupid.
; i have to make variables static, and still use `this.variable` when using them.
; It's kinda like JS with Prototype Object Inheritance
    static ahk_SC2 := "ahk_exe SC2_x64.exe"

    static xPos := 0
    static yPos := 0

    static dragoonQMillis := 2000
    static spectrePlayMillis := 1053
    static centurionPlayMillis := 219
    static autoupgradeMillis := 15003
    static medicMillis := 2000

    ; Save mouse position to use in SC2
    SaveMousePosition()
    {
        MouseGetPos, xPos, yPos
        this.xPos := xPos
        this.yPos := yPos
        Tippy("Mouse position is: x:" this.xPos " y:" this.yPos)
    }

    ClickManyTimes()
    {
        Click 123
    }

    ToggleDragoonQ()
    {
        ToggleTimerAndShowTooltip("SC2.DragoonQ", this.dragoonQMillis, SC2.DragoonQ.Bind(SC2))
    }

    ToggleMedic()
    {
        ToggleTimerAndShowTooltip("SC2.Medic", this.medicMillis, SC2.Medic.Bind(SC2))
    }

    ToggleSpectrePlay()
    {
        ToggleTimerAndShowTooltip("SC2.SpectrePlay", this.spectrePlayMillis, SC2.SpectrePlay.Bind(SC2))
    }

    ToggleCenturionPlay()
    {
        ToggleTimerAndShowTooltip("SC2.CenturionPlay", this.centurionPlayMillis, SC2.CenturionPlay.Bind(SC2))
    }

    ToggleAutoupgrade()
    {
        ToggleTimerAndShowTooltip("SC2.Autoupgrade", this.autoupgradeMillis, SC2.Autoupgrade.Bind(SC2))
    }


    DragoonQ()
    {
        Critical

        SetKeyDelay, 60, 5
        SetControlDelay -1

        if (WinActive(this.ahk_SC2)) {
            Tippy("DragoonQ")
            if(this.xPos = 0){
                this.SaveMousePosition()
            }
        }

        ; use the saved position
        x := this.xPos
        y := this.yPos

        ; ControlClick, must have the coordinates as "x100 y100", not just "100 100"
        x := "x" . x
        y := "y" . y

        ControlSend,, {Blind}8q, % this.ahk_SC2
        ControlClick,, % this.ahk_SC2,, LEFT, 1, %  "NA" x y
        ControlSend,, {Blind}h, % this.ahk_SC2
    }

    Medic()
    {
        Critical

        SetKeyDelay, 60, 5
        SetControlDelay 58

        if (WinActive(this.ahk_SC2)) {
            Tippy("Medic")
            if(this.xPos = 0){
                this.SaveMousePosition()
            }
        }

        ; use the saved position
        x := this.xPos
        y := this.yPos

        ; ControlClick, must have the coordinates as "x100 y100", not just "100 100"
        x := "x" . x
        y := "y" . y

        ControlSend,, {Blind}7q, % this.ahk_SC2
        ControlClick,, % this.ahk_SC2,, LEFT, 1, %  "NA" x y
        ControlSend,, {Blind}7w, % this.ahk_SC2
        ControlClick,, % this.ahk_SC2,, LEFT, 1, %  "NA" x y
        ControlSend,, {Blind}7e, % this.ahk_SC2
        ControlClick,, % this.ahk_SC2,, LEFT, 1, %  "NA" x y
        ControlSend,, {Blind}7h, % this.ahk_SC2
    }

    SpectrePlay()
    {
        Critical

        SetKeyDelay, 60, 5

        if (WinActive(this.ahk_SC2)) {
            Tippy("SpectrePlay")
        }

        ; need "eee" because somehow it takes more time to switch from q to w guns
        ControlSend,, {Blind}2weeqh, % this.ahk_SC2
    }

    CenturionPlay()
    {
        Critical

        SetKeyDelay,,

        if (WinActive(this.ahk_SC2)) {
            Tippy("CenturionPlay")
        }

        ; use the saved position
        x := this.xPos
        y := this.yPos

        ; ControlClick, must have the coordinates as "x100 y100", not just "100 100"
        x := "x" . x
        y := "y" . y

        ControlSend,, {Blind}4wh, % this.ahk_SC2
    }

    Autoupgrade()
    {
        Critical

        SetKeyDelay, 60, 5

        if (WinActive(this.ahk_SC2)) {
            Tippy("Autoupgrade")
        }

        ControlSend,, {Blind}1uqwehrtsdfgzxc1hh, % this.ahk_SC2
    }
}

