#include lib/ToggleTimerAndShowTooltip.ahk
#include lib/Tippy.ahk
#include lib/ReloadScript.ahk

; This script contains all the stuff and timers and macros for SC2 (mostly the map Fallen World)
;
;       == HOW TO USE ==
;
; Press one of the key combos (CapsLock and NumpadX) after you saved that specific character(s) in the same control group.
; (eg. CapsLock + Numpad2 always uses control group 2 which is assigned to Spectre)
; Read below what are the control groups.
;
; Starcraft 2 MUST be in **windowed fullscreen** or **windowed** mode.
;
;       == CURRENT HOTKEYS ==

; Numpad0: toggle Templar

; Numpad9: toggle Marine

; Numpad8: toggle Dragoon

; Numpad7: toggle Medic;

; Numpad4: toggle Centurion

; Numpad2: toggle Spectre

; Numpad1: toggle upgrades

; NumpadMult (the *): save new Mouse position

; CapsLock & F5: stop all macros at once



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

; Dragoon is in group 8
CapsLock & Numpad8::SC2.ToggleDragoonQ()

; Medic is in group 7
CapsLock & Numpad7::SC2.ToggleMedic()

; Spectre is in group 2
CapsLock & Numpad2::SC2.ToggleSpectrePlay()

; Centurion is in group 4
CapsLock & Numpad4::SC2.ToggleCenturionPlay()

; Upgrade whatever is selected in group 1
CapsLock & Numpad1::SC2.ToggleAutoupgrade()

; Marine is in group 9
CapsLock & Numpad9::SC2.ToggleMarine()

; Templar is in group 0
CapsLock & Numpad0::SC2.ToggleTemplar()


class SC2
{
; ahk OOP is weird/stupid.
; i have to make variables static, and still use `this.variable` when using them.
; It's kinda like JS with Prototype Object Inheritance
    static ahk_SC2 := "ahk_exe SC2_x64.exe"

    static xPos := 0
    static yPos := 0

    static secondaryxPos := 0
    static secondaryyPos := 0

    static dragoonQMillis := 2000
    static spectrePlayMillis := 1053
    static centurionPlayMillis := 219
    static autoupgradeMillis := 15003
    static medicMillis := 2000
    static marineMillis := 15000
    static templarMillis := 4000


    ; Save mouse position to use in SC2
    SaveMousePosition()
    {
        MouseGetPos, xPos, yPos
        this.xPos := xPos
        this.yPos := yPos
        this.secondaryxPos := xPos + 188    ; compared to the center: a little bit to the right
        this.secondaryyPos := yPos - 120    ; compared to the center: a little bit upper

        msg :=
        (Join
            "Mouse position is:  x: " . this.xPos . " y: " . this.yPos . "`n" .
            "Secondary position: x: " . this.secondaryxPos . " y: " . this.secondaryyPos
        )

        Tippy(msg)

    }

    ClickManyTimes()
    {
        Click 151
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

    ToggleMarine()
    {
        ToggleTimerAndShowTooltip("SC2.Marine", this.marineMillis, SC2.Marine.Bind(SC2))
    }

    ToggleTemplar()
    {
        ToggleTimerAndShowTooltip("SC2.Templar", this.templarMillis, SC2.Templar.Bind(SC2))
    }

    DragoonQ()
    {
        Critical

        ; SetKeyDelay, 60, 5
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

        ControlSend,, {Blind}{Raw}8q, % this.ahk_SC2
        ControlClick,, % this.ahk_SC2,, LEFT, 1, %  "NA" x y
        ControlSend,, {Blind}{Raw}h, % this.ahk_SC2
    }

    Medic()
    {
        Critical

        ; SetKeyDelay, 60, 5
        SetControlDelay 100
        ; SetControlDelay -1

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

        ControlSend,, {Blind}{Raw}7q, % this.ahk_SC2
        ControlClick,, % this.ahk_SC2,, LEFT, 1, %  "NA" x y
        ControlSend,, {Blind}{Raw}7w, % this.ahk_SC2
        ControlClick,, % this.ahk_SC2,, LEFT, 1, %  "NA" x y
        ControlSend,, {Blind}{Raw}7e, % this.ahk_SC2
        ControlClick,, % this.ahk_SC2,, LEFT, 1, %  "NA" x y
        ControlSend,, {Blind}{Raw}7h, % this.ahk_SC2
    }

    SpectrePlay()
    {
        Critical

        ; ; SetKeyDelay, 60, 5

        if (WinActive(this.ahk_SC2)) {
            Tippy("SpectrePlay")
        }

        ; need "eee" because somehow it takes more time to switch from q to w guns
        ControlSend,, {Blind}{Raw}2weqh, % this.ahk_SC2
    }

    CenturionPlay()
    {
        Critical

        ; SetKeyDelay,,

        if (WinActive(this.ahk_SC2)) {
            Tippy("CenturionPlay")
        }

        ; use the saved position
        x := this.xPos
        y := this.yPos

        ; ControlClick, must have the coordinates as "x100 y100", not just "100 100"
        x := "x" . x
        y := "y" . y

        ControlSend,, {Blind}{Raw}4wh, % this.ahk_SC2
    }

    Autoupgrade()
    {
        Critical

        ; SetKeyDelay, 60, 5

        if (WinActive(this.ahk_SC2)) {
            Tippy("Autoupgrade")
        }

        ControlSend,, {Blind}{Raw}1uqwehrtsdfgzxc1hh, % this.ahk_SC2
    }

    Marine()
    {
        Critical

        ; ; SetKeyDelay, 60, 5

        if (WinActive(this.ahk_SC2)) {
            Tippy("Marine")
        }

        ControlSend,, {Blind}{Raw}9th, % this.ahk_SC2
    }

    Templar()
    {
        Critical

        ; SetKeyDelay, 60, 5
        SetControlDelay 100
        ; SetControlDelay -1

        if (WinActive(this.ahk_SC2)) {
            Tippy("Templar")
            if(this.xPos = 0){
                this.SaveMousePosition()
            }
        }

        ; use the saved position
        x := this.secondaryxPos
        y := this.secondaryyPos

        ; ControlClick, must have the coordinates as "x100 y100", not just "100 100"
        x := "x" . x
        y := "y" . y

        ControlSend,, {Blind}{Raw}0q, % this.ahk_SC2
        ControlClick,, % this.ahk_SC2,, LEFT, 1, %  "NA" x y
        ControlSend,, {Blind}{Raw}0h, % this.ahk_SC2
    }
}

