; i call this method
Tippy(text = "", duration := 3333, whichToolTip := 16) {
    TT.ShowTooltip(text, duration, whichToolTip)
}


class TT {
    static WhichToolTips := {}

    static __TippyOnFn := TT.__TippyOn.Bind(TT)

    ShowTooltip(text, duration, whichToolTip) {
        fnOff := ""
        ; rate limiting if ToolTip already exists
        ttData := this.WhichToolTips[whichToolTip]
        if(ttData)
        {
            fnOff := ttData.fnOff
            if(text = "")
            {
                SetTimer, % fnOff, Off
                this.__DestroyWhichTooltip(whichToolTip)
                return
            }
            if(ttData.CurrentText = text)
            {
                ttData.Duration := duration
            }
        }

        ; sanitize whichToolTip
        whichToolTip := Max(1, Mod(whichToolTip, 20))

        ; call start and stop
        if(!fnOff)
        {
            fnOff := this.__TippyOff.Bind(this, whichToolTip)
        }
        SetTimer, % fnOff, % "-" duration

        fnOn := this.__TippyOnFn
        SetTimer, % fnOn, 10

        ; init the possibly new timer
        this.WhichToolTips[whichToolTip] := {CurrentText: text, Duration: duration, fnOff: fnOff}

        Sleep 2
    }

    __TippyOn() {

                    DllCall("QueryPerformanceCounter", "Int64*", CounterBefore)
                    DllCall("QueryPerformanceFrequency", "Int64*", Freq)

        this.__ToolTipFM()

                    DllCall("QueryPerformanceCounter", "Int64*", CounterAfter)
                    elapsed :=  (CounterAfter-CounterBefore)/Freq * 1000
                    if (elapsed > 10)
                        tooltip, % "performance: time: " . elapsed . " milliseconds", , 17
    }

    __TippyOff(whichTooltip) {
        ; MsgBox, % "which" toStr(this.WhichToolTips)
        ; msgbox % ttData.CurrentText = ttData.LastText

        this.__DestroyWhichTooltip(whichToolTip)

        if(this.WhichToolTips.Count() = 0)
        {
            fnOn := this.__TippyOnFn
            SetTimer, % fnOn, Off
        }
    }


    __ToolTipFM() { ; ToolTip which Follows the Mouse
        static defaultxOffset := 16, defaultyOffset := 16
        static virtualScreenWidth, virtualScreenHeight ; http://www.autohotkey.com/forum/post-430240.html#430240

        if (virtualScreenWidth = "" or virtualScreenHeight = "")
        {
            SysGet, virtualScreenWidth, 78
            SysGet, virtualScreenHeight, 79
        }

        copy := this.WhichToolTips
        For whichToolTip, ttData in copy
        {
            ; move or recreate tooltip
            WinGetPos,,, w, h, % "ahk_id " . ttData.Hwnd
            CoordMode, Mouse, Screen
            MouseGetPos, x, y
            x += defaultxOffset
            y += defaultyOffset
            ; stack tooltips vertically
            y += this.__MultipleToolTipsOffsetCalc(whichToolTip)

            ; if mouse is bottom right, adjust Tooltip position
            if ((x+w) > virtualScreenWidth)
            {
                AdjustX := 1
            }
            if ((y+h) > virtualScreenHeight)
            {
                AdjustY := 1
            }
            if (AdjustX and AdjustY)
            {
                x := x - defaultxOffset*2 - w
                y := y - defaultyOffset*2 - h
            }
            else if(AdjustX)
            {
                x := virtualScreenWidth - w
            }
            else if(AdjustY)
            {
                y := virtualScreenHeight - h
            }

            ; move tooltip
            if (ttData.CurrentText = ttData.LastText)
            {
                DllCall("MoveWindow", A_PtrSize ? "UPTR" : "UInt", ttData.Hwnd, "Int", x, "Int", y, "Int", w, "Int", h, "Int", 0)
            }
            ; create tooltip
            else
            {
                ; Perfect solution would be to update tooltip text (TTM_UPDATETIPTEXT), but must be compatible with all versions of AHK_L and AHK Basic.
                ; My Ask For Help link: http://www.autohotkey.com/forum/post-421841.html#421841
                CoordMode, ToolTip, Screen
                ToolTip, % ttData.CurrentText, x, y, % whichToolTip
                ttData.Hwnd := WinExist("ahk_class tooltips_class32 ahk_pid " DllCall("GetCurrentProcessId"))
                ttData.LastText := ttData.CurrentText

                WinGetPos,,, w, h, % "ahk_id " . ttData.Hwnd
                ttData.ToolTipHeight := h
            }
        }
        ; Winset, AlwaysOnTop, on, % "ahk_id" . ttData.Hwnd
    }


    __MultipleToolTipsOffsetCalc(maxWhichToolTip) {
        result := 0
        For whichToolTip, ttData in this.WhichToolTips
        {
            if(whichToolTip >= maxWhichToolTip)
            {
                break
            }
            result += ttData.ToolTipHeight + 2
        }
        return result
    }

    __DestroyWhichTooltip(whichTooltip) {
        ToolTip,,,, % whichToolTip
        this.WhichToolTips.Delete(whichToolTip)
    }
}


