#include lib/ToggleTimerAndShowTooltip.ahk
#include lib/Tippy.ahk


CapsLock & LButton::SC2.ClickManyTimes()

CapsLock & LButton::SC2.ClickAndSaveMousePosition()

; Dragoons are always on group 8
CapsLock & Numpad8::SC2.ToggleDragoonQ()

; Spectre is always in group 2
CapsLock & Numpad2::SC2.ToggleSpectrePlay()

; Centurion is always in group 4
CapsLock & Numpad4::SC2.ToggleCenturionPlay()

CapsLock & Numpad1::SC2.ToggleAutoupgrade()

; This contains all the stuff and timers and macros for SC2 (mostly Fallen World map)
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
    static centurionPlayMillis := 1017
    static autoupgradeMillis := 15003

    ; Save mouse position to use in SC2
    ClickAndSaveMousePosition()
    {
        MouseGetPos, xPos, yPos
        this.xPos := xPos
        this.yPos := yPos
        Tippy("Mouse position is: x:" this.xPos " y:" this.yPos)
        Click 123
    }

    ; Dragoon is always in group 8
    ToggleDragoonQ()
    {
        ToggleTimerAndShowTooltip("SC2.DragoonQ", this.dragoonQMillis, SC2.DragoonQ.Bind(SC2))
    }

    ; Spectre is always in group 2
    ToggleSpectrePlay()
    {
        ToggleTimerAndShowTooltip("SC2.SpectrePlay", this.spectrePlayMillis, SC2.SpectrePlay.Bind(SC2))
    }

    ; Centurion is always in group 4
    ToggleCenturionPlay()
    {
        ToggleTimerAndShowTooltip("SC2.CenturionPlay", this.centurionPlayMillis, SC2.CenturionPlay.Bind(SC2))
    }


    ToggleAutoupgrade()
    {
        ToggleTimerAndShowTooltip("SC2.Autoupgrade", this.autoupgradeMillis, SC2.Autoupgrade.Bind(SC2))
    }


    ; Dragoons is always in group 8
    DragoonQ()
    {
        Critical

        SetKeyDelay, 60, 5
        SetControlDelay 0

        if (WinActive(this.ahk_SC2)) {
            Tippy("DragoonQ")
        }

        ; use the saved position
        x := this.xPos
        y := this.yPos

        ; ControlClick, must have the coordinates as "x100 y100", not just "100 100"
        x := "x" . x
        y := "y" . y

        ControlSend,, 8q, % this.ahk_SC2
        ControlClick,, % this.ahk_SC2,, LEFT, 1, %  "NA" x y
        ControlSend,, h, % this.ahk_SC2
    }

    ; Spectre is always in group 2
    SpectrePlay()
    {
        Critical

        SetKeyDelay, 60, 5

        if (WinActive(this.ahk_SC2)) {
            Tippy("SpectrePlay")
        }

        ; need "eee" because somehow it takes more time to switch from q to w guns
        ControlSend,, 2weeqh, % this.ahk_SC2
    }


    ; Centurion is always in group 4
    CenturionPlay()
    {
        Critical

        SetKeyDelay, 60, 5

        if (WinActive(this.ahk_SC2)) {
            Tippy("CenturionPlay")
        }

        ControlSend,, 4whhh, % this.ahk_SC2
    }

    Autoupgrade()
    {
        Critical

        SetKeyDelay, 60, 5

        if (WinActive(this.ahk_SC2)) {
            Tippy("Autoupgrade")
        }

        ControlSend,, 1uqwertsdfgzxc1hh, % this.ahk_SC2
    }


}
