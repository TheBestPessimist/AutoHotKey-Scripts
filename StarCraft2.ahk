#include lib/ToggleTimerAndShowTooltip.ahk
#include lib/Tippy.ahk
#include lib/ReloadScript.ahk

; This script contains all the stuff and timers and macros for SC2 (mostly the map Fallen World: Last Stand)
; This script is better than what you currently have.
;
;
;       == HOW TO USE ==
;
; - Run `AutoHotkeyU64.exe`
; - Run Stacraft 64 bit version
; - Start the map
; - Select your character
; - Add your character to its specific control group (read on to see which character goes in which control group)
;               - Hint: Multiple characters of the same type can be controlled together (eg. multiple spectres)
; - Press one of the key combos (CapsLock and NumpadX, where X is the control group)
;       - eg. CapsLock + Numpad2 always uses control group 2 which is assigned to Spectre
;               - Hint: Multiple macros(hotkeys) can run at the same time without interfering with each other
; - Read below what the control groups are.
;
; Starcraft 2 MUST be in **windowed fullscreen** or **windowed** mode.
;
;       == CURRENT HOTKEYS (CONTROL GROUP HAS TO BE THE SAME) ==

; CapsLock & Numpad0: toggle Templar

; CapsLock & Numpad9: toggle Marine

; CapsLock & Numpad8: toggle Dragoon

; CapsLock & Numpad7: toggle Medic

; CapsLock & Numpad6: toggle Cyro

; CapsLock & Numpad4: toggle Centurion

; CapsLock & Numpad2: toggle Spectre

; CapsLock & Numpad1: toggle upgrades (every 15 seconds)

; CapsLock & NumpadMult (the *): save new Mouse position (The mouse has to be OVER THE TANK when you run this)

; CapsLock & Click: Send 100 clicks (useful for quick SP upgrades)

; CapsLock & F5: stop all macros at once

;
;       That's it. There's nothing more for you to read from this point on.
;       Now go and play the game!
;


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

    ; SC2.ToggleDragoonQ()
    ; SC2.ToggleSpectrePlay()
    ; SC2.ToggleTemplar()
    ; SC2.ToggleMedic()
    ; SC2.ToggleAutoupgrade()
    ; SC2.ToggleCyro()
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

; Cyro is in group 6
CapsLock & Numpad6::SC2.ToggleCyro()


class SC2
{
; ahk OOP is weird/stupid.
; i have to make variables static, and still use `this.variable` when using them.
; It's kinda like JS with Prototype Object Inheritance
    static ahk_SC2 := "ahk_exe SC2_x64.exe"


    static tankxPos := 0
    static tankyPos := 0

    static casterxPos := 0
    static casteryPos := 0

    static dragoonQMillis := 2000
    static dragoonEQMillis := 2000
    static spectrePlayMillis := 1053
    static centurionPlayMillis := 219
    static autoupgradeMillis := 15003
    static medicMillis := 8000
    static marineMillis := 15000
    static templarMillis := 4000
    static cyroMillis := 5000


    ; Save mouse position to use in SC2
    SaveMousePosition()
    {
        MouseGetPos, xPos, yPos
        this.tankxPos := xPos
        this.tankyPos := yPos
        this.casterxPos := xPos + 188    ; compared to the center: a little bit to the right
        this.casteryPos := yPos - 120    ; compared to the center: a little bit upper
        this.cryoxPos := xPos - 20    ; compared to the center: a little bit to the right
        this.cryoyPos := yPos - 35    ; compared to the center: a little bit upper

        msg :=
        (Join
            "Tank position is:  x: " . this.tankxPos . " y: " . this.tankyPos . "`n" .
            "Caster position is: x: " . this.casterxPos . " y: " . this.casteryPos
            "Cyro cast is: x: " . this.cyroxPos . " y: " . this.cyroyPos
        )

        Tippy(msg, 9000, -1)

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

    ToggleCyro()
    {
        ToggleTimerAndShowTooltip("SC2.Cyro", this.cyroMillis, SC2.Cyro.Bind(SC2))
    }

    DragoonQ()
    {
        Critical

        SetKeyDelay, 20, 10
        SetControlDelay 30

        if (WinActive(this.ahk_SC2)) {
            Tippy("DragoonQ",, 8)
            if(this.tankxPos = 0){
                this.SaveMousePosition()
            }
        }

        ; use the saved position
        x := this.casterxPos
        y := this.casteryPos

        ; ControlClick, must have the coordinates as "x100 y100", not just "100 100"
        x := "x" . x
        y := "y" . y

        ControlSend,, {Blind}{Raw}8q, % this.ahk_SC2
        ControlClick,, % this.ahk_SC2,, LEFT, 1, %  "NA" x y
        ControlSend,, {Blind}{Raw}8h, % this.ahk_SC2
    }

    Cyro()
    {
        Critical

        SetKeyDelay, 30, 10
        SetControlDelay 30

        if (WinActive(this.ahk_SC2)) {
            Tippy("Cyro",, 6)
            if(this.tankxPos = 0){
                this.SaveMousePosition()
            }
        }

        ; use the saved position
        x := this.cryoxPos
        y := this.cryoyPos

        ; ControlClick, must have the coordinates as "x100 y100", not just "100 100"
        x := "x" . x
        y := "y" . y

        ControlSend,, {Blind}{Raw}6ehh, % this.ahk_SC2
        ControlSend,, {Blind}{Raw}6w, % this.ahk_SC2
        ControlClick,, % this.ahk_SC2,, LEFT, 1, %  "NA" x y
        ControlSend,, {Blind}{Raw}6hh, % this.ahk_SC2
    }

    Medic()
    {
        Critical

        SetKeyDelay, 20, 10
        SetControlDelay 30

        if (WinActive(this.ahk_SC2)) {
            Tippy("Medic",, 7)
            if(this.tankxPos = 0){
                this.SaveMousePosition()
            }
        }

        ; use the saved position
        defensiveX := this.tankxPos
        defensiveY := this.tankyPos

        ; ControlClick, must have the coordinates as "x100 defensiveY100", not just "100 100"
        defensiveX := "x" . defensiveX
        defensiveY := "y" . defensiveY

        attackX := this.casterxPos
        attackY := this.casteryPos

        attackX := "x" . attackX
        attackY := "y" . attackY



        ControlSend,, {Blind}{Raw}7q, % this.ahk_SC2
        ControlClick,, % this.ahk_SC2,, LEFT, 1, %  "NA" attackX attackY
        ControlSend,, {Blind}{Raw}7w, % this.ahk_SC2
        ControlClick,, % this.ahk_SC2,, LEFT, 1, %  "NA" defensiveX defensiveY
        ControlSend,, {Blind}{Raw}7e, % this.ahk_SC2
        ControlClick,, % this.ahk_SC2,, LEFT, 1, %  "NA" defensiveX defensiveY
        ControlSend,, {Blind}{Raw}7r, % this.ahk_SC2
        ControlClick,, % this.ahk_SC2,, LEFT, 1, %  "NA" defensiveX defensiveY
        ControlSend,, {Blind}{Raw}7h, % this.ahk_SC2
    }

    SpectrePlay()
    {
        Critical

        SetKeyDelay, 20, 10

        if (WinActive(this.ahk_SC2)) {
            Tippy("SpectrePlay",, 2)
        }

        ; need "eee" because somehow it takes more time to switch from q to w guns
        ControlSend,, {Blind}{Raw}2weqh, % this.ahk_SC2
    }

    CenturionPlay()
    {
        Critical

        SetKeyDelay, 20, 10

        if (WinActive(this.ahk_SC2)) {
            Tippy("CenturionPlay",, 4)
        }

        ControlSend,, {Blind}{Raw}4wh, % this.ahk_SC2
    }

    Autoupgrade()
    {
        Critical

        SetKeyDelay, 20, 10

        if (WinActive(this.ahk_SC2)) {
            Tippy("Autoupgrade",, 1)
        }

        ControlSend,, {Blind}{Raw}1uqwehrtsdfgzxc1hh, % this.ahk_SC2
    }

    Marine()
    {
        Critical

        SetKeyDelay, 20, 10

        if (WinActive(this.ahk_SC2)) {
            Tippy("Marine",, 9)
        }

        ControlSend,, {Blind}{Raw}9th, % this.ahk_SC2
    }

    Templar()
    {
        Critical

        SetKeyDelay, 20, 10
        SetControlDelay 30

        if (WinActive(this.ahk_SC2)) {
            Tippy("Templar",, 0)
            if(this.tankxPos = 0){
                this.SaveMousePosition()
            }
        }

        ; use the saved position
        x := this.casterxPos
        y := this.casteryPos

        ; ControlClick, must have the coordinates as "x100 y100", not just "100 100"
        x := "x" . x
        y := "y" . y

        ControlSend,, {Blind}{Raw}0q, % this.ahk_SC2
        ControlClick,, % this.ahk_SC2,, LEFT, 1, %  "NA" x y
        ControlSend,, {Blind}{Raw}0h, % this.ahk_SC2
    }
}

