#include lib/ToggleTimerAndShowTooltip.ahk
#include lib/Tippy.ahk


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
    ahk_SC2 := "ahk_exe SC2_x64.exe"

    xPos := 0
    yPos := 0

    dragoonQMillis := 2000
    spectrePlayMillis := 1053
    centurionPlayMillis := 1017
    autoupgradeMillis := 15003


    ; Save mouse position to use in SC2
    ClickAndSaveMousePosition()
    {
        MouseGetPos, xPos, yPos
        Tippy("Mouse position is: x:" xPos " y:" yPos)
        Click 123
    }

    ; Dragoon is always in group 8
    ToggleDragoonQ()
    {
        ToggleTimerAndShowTooltip("SC2.DragoonQ", dragoonQMillis, SC2.DragoonQ.Bind(SC2))
    }

    ; Spectre is always in group 2
    ToggleSpectrePlay()
    {
        ToggleTimerAndShowTooltip("SC2.SpectrePlay", spectrePlayMillis, SC2.SpectrePlay.Bind(SC2))
    }

    ; Centurion is always in group 4
    ToggleCenturionPlay()
    {
        ToggleTimerAndShowTooltip("SC2.CenturionPlay", centurionPlayMillis, SC2.CenturionPlay.Bind(SC2))
    }


    ToggleAutoupgrade()
    {
        ToggleTimerAndShowTooltip("SC2.Autoupgrade", autoupgradeMillis, SC2.Autoupgrade.Bind(SC2))
    }


    ; Dragoons is always in group 8
    DragoonQ()
    {
        Critical

        SetKeyDelay, 60, 5
        SetControlDelay 0

        if (WinActive(ahk_SC2)) {
            Tippy("DragoonQ")
        }

        ; use the saved position
        x := xPos
        y := yPos

        ; ControlClick, must have the coordinates as "x100 y100", not just "100 100"
        x := "x" . x
        y := "y" . y

        ControlSend,, 8q, % ahk_SC2
        ControlClick,, % ahk_SC2,, LEFT, 1, %  "NA" x y
        ControlSend,, h, % ahk_SC2
    }

    ; Spectre is always in group 2
    SpectrePlay()
    {
        Critical

        SetKeyDelay, 60, 5

        if (WinActive(ahk_SC2)) {
            Tippy("SpectrePlay")
        }

        ; need "eee" because somehow it takes more time to switch from q to w guns
        ControlSend,, 2weeqh, % ahk_SC2
    }


    ; Centurion is always in group 4
    CenturionPlay()
    {
        Critical

        SetKeyDelay, 60, 5

        if (WinActive(ahk_SC2)) {
            Tippy("CenturionPlay")
        }

        ControlSend,, 4whhh, % ahk_SC2
    }

    Autoupgrade()
    {
        Critical

        SetKeyDelay, 60, 5

        if (WinActive(ahk_SC2)) {
            Tippy("Autoupgrade")
        }

        ControlSend,, 1uqwertsdfgzxc1hh, % ahk_SC2
    }


}
