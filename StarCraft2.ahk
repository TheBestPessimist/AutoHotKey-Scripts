#include lib/ToggleTimerAndShowTooltip.ahk
#include lib/Tippy.ahk
#include lib/ReloadScript.ahk

; This script contains all the stuff and timers and macros for SC2 (mostly the map Fallen World: Last Stand)
; This script is better than what you currently have.
;
;
;       == HOW TO USE ==
;
; - Download this whole repository (  https://www.google.com/search?q=how+to+download+github+repository  )
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

; disabled
; CapsLock & LButton::SC2.ClickManyTimes()

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
    static spectrePlayMillis := 1053
    static centurionPlayMillis := 319
    static autoupgradeMillis := 15003
    static medicMillis := 2000
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
        this.cryoxPos := xPos - 55    ; compared to the center: a little bit to the left
        this.cryoyPos := yPos - 5    ; compared to the center: a little bit upper

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
        Loop, % 20
        {
            Click, % 5
            Sleep 1
        }
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

        SetKeyDelay, 30, 10
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



        ControlSend,, {Blind}{Raw}7hq, % this.ahk_SC2
        ControlClick,, % this.ahk_SC2,, LEFT, 1, %  "NA" attackX attackY
        ControlSend,, {Blind}{Raw}7hw, % this.ahk_SC2
        ControlClick,, % this.ahk_SC2,, LEFT, 1, %  "NA" defensiveX defensiveY
        ControlSend,, {Blind}{Raw}7he, % this.ahk_SC2
        ControlClick,, % this.ahk_SC2,, LEFT, 1, %  "NA" defensiveX defensiveY
        ControlSend,, {Blind}{Raw}7hr, % this.ahk_SC2
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

        ControlSend,, {Blind}{Raw}{f2}uvqwehrtsdfgzxc{f2}hh, % this.ahk_SC2
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

        SetKeyDelay, 30, 10
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


    ; Sc2 Scaling is non-linear so this doesn't work properly
    ; Ref: https://docs.google.com/spreadsheets/d/1STwquGGrOA0wobRG8ltlgDoU3IqV5GzP8r0WQuFwokM/edit#gid=0
    ; __ClickScaled(x, y, ClickCount)
    ; {
    ;     orx := x
    ;     ory := y
    ;    if (WinActive(this.ahk_SC2)) {
    ;         CoordMode, Mouse, Client

    ;         noOfClicks := 5
    ;         ClickCount := Max(ClickCount / noOfClicks, 1)

    ;         this.GetWindowClientSize(this.ahk_SC2, wWidth, wHeight)
    ;         ; calculate coordinates relative to current screen
    ;         x := x * wWidth  / 1920
    ;         y := y * wHeight / 1137



    ;         MouseMove, x, y

    ;         Tippy("x: " x " y: " y
    ;             . " orx: " orx " ory: " ory
    ;             . " wWidth: " wWidth " wHeight: " wHeight
    ;             , 500000, 11)
    ;         ; MouseDebugging()
    ;         ; ToggleMouseDebugging()

    ;         ; KeyWait, a, D

    ;         Loop, % ClickCount
    ;         {
    ;             Click, % noOfClicks
    ;             Sleep 2
    ;         }
    ;     }
    ; }

    ; __Upgrades()
    ; {

    ;     this.__ClickScaled(337, 186, 1) ; Specialty



    ;     ; sleepBetweenUpgrades := 50
    ;     ; this.__ClickScaled(50, 165, 1) ; Skill Points open

    ;     ; this.__UpgradeFullPage(400, 210, sleepBetweenUpgrades) ; Recruit
    ;     ; this.__UpgradeFullPage(400, 250, sleepBetweenUpgrades) ; Corporal
    ;     ; this.__UpgradeFullPage(400, 290, sleepBetweenUpgrades) ; Sergeant
    ;     ; this.__UpgradeFullPage(400, 330, sleepBetweenUpgrades) ; Capitain
    ;     ; this.__UpgradeFullPage(400, 370, sleepBetweenUpgrades) ; Major

    ;     ; Sleep, % s
    ;     ; this.__ClickScaled(400, 670, 1) ; Specialty
    ;     ; Sleep, % s

    ;     ; this.__ClickScaled(73, 275, 100) ; Skill 1
    ;     ; this.__ClickScaled(73, 425, 100) ; Skill 3
    ;     ; this.__ClickScaled(73, 500, 100) ; Skill 4

    ;     ; this.__ClickScaled(50, 165, 1) ; Skill Points close
    ; }

    ; __UpgradeFullPage(x, y, s)
    ; {
    ;     Sleep, % s
    ;     this.__ClickScaled(x, y, 1) ; Skill Rank
    ;     Sleep, % s

    ;     this.__ClickScaled(73, 275, 100) ; Skill 1
    ;     this.__ClickScaled(73, 350, 100) ; Skill 2
    ;     this.__ClickScaled(73, 425, 100) ; Skill 3
    ;     this.__ClickScaled(73, 500, 100) ; Skill 4
    ;     this.__ClickScaled(73, 575, 100) ; Skill 5

    ;     this.__ClickScaled(300, 650, 1) ; Next page
    ;     Sleep, % s

    ;     this.__ClickScaled(73, 275, 100) ; Skill 1
    ;     this.__ClickScaled(73, 350, 100) ; Skill 2
    ;     this.__ClickScaled(73, 425, 100) ; Skill 3
    ;     this.__ClickScaled(73, 500, 100) ; Skill 4
    ;     this.__ClickScaled(73, 575, 100) ; Skill 5
    ; }

    ; ; get the size of the window w/o titlebar and shadows and all that shit
    ; GetWindowClientSize(winTitle, ByRef w := "", ByRef h := "")
    ; {
    ;     WinGet, hWnd, ID , % winTitle
    ;     VarSetCapacity(rect, 16)
    ;     DllCall("GetClientRect", "ptr", hWnd, "ptr", &rect)
    ;     w := NumGet(rect, 8, "int")
    ;     h := NumGet(rect, 12, "int")
    ; }

    ; __GetAllScreenDimensions() {
    ;     static monitorCount
    ;     static screens

    ;     SysGet, monitorCount, MonitorCount
    ;     if (monitorCount != newMonitorCount)
    ;     {
    ;         monitorCount := newMonitorCount

    ;         screens := []
    ;         loop, % MonitorCount
    ;         {
    ;             SysGet, BoundingBox, Monitor, % A_Index
    ;             screens.Push({"Top": BoundingBoxTop, "Bottom": BoundingBoxBottom, "Left": BoundingBoxLeft, "Right": BoundingBoxRight})
    ;         }
    ;     }
    ;     return screens
    ; }
}
