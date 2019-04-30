; i call this method
Tippy(text = "", duration := 3333, WhichToolTip := 16) {
    TT.Tippy(text, duration, WhichToolTip)
}


class TT {
    static CurrentText := []
    static LastText := []
    static hwnd := []
    static DestroyAtTime := []
    static multipleToolTipsY := []


    static __TippyOnFn := TT.__TippyOn.Bind(TT)
    static __TippyOffFn := TT.__TippyOff.Bind(TT)

    Tippy(text, duration, WhichToolTip) {
        ; sanitize WhichToolTip
        WhichToolTip := Max(1, Mod(WhichToolTip, 20))

        ; init the possibly new timer
        TT.CurrentText[WhichToolTip] := text
        TT.DestroyAtTime[WhichToolTip] := A_TickCount + duration

        ; call start and stop
        fnOff := this.__TippyOffFn
        SetTimer, % fnOff, % Abs(Min(TT.DestroyAtTime*)-A_TickCount)
        fnOn := this.__TippyOnFn
        SetTimer, % fnOn, 10

        Sleep 2
    }

    __TippyOn() {
        this.__ToolTipFM()
    }

    __TippyOff() {
        copy := TT.CurrentText.Clone()

        For WhichToolTip, Text in copy
        {
            if (A_TickCount >= TT.DestroyAtTime[WhichToolTip])
            {
                TT.CurrentText[WhichToolTip] := ""
            }
        }

        ; no need to waste resources
        if(!TT.CurrentText.Count())
        {
            SetTimer,, Off
        }
    }


    __ToolTipFM() { ; ToolTip which Follows the Mouse
        static defaultxOffset := 16, defaultyOffset := 16
        static VirtualScreenWidth, VirtualScreenHeight ; http://www.autohotkey.com/forum/post-430240.html#430240

        if (VirtualScreenWidth = "" or VirtualScreenHeight = "")
        {
            SysGet, VirtualScreenWidth, 78
            SysGet, VirtualScreenHeight, 79
        }

        copy := TT.CurrentText.Clone()
        For WhichToolTip, Text in copy
        {
            ; destroy old
            if(Text = "")
            {
                this.__DestroyWhichTooltip(whichTooltip)
            }

            ; move or recreate tooltip
            WinGetPos,,, w, h, % "ahk_id " . TT.hwnd[WhichToolTip]
            CoordMode, Mouse, Screen
            MouseGetPos, x, y
            x += defaultxOffset
            y += defaultyOffset
            ; stack tooltips vertically
            y += this.__multipleToolTipsOffsetCalc(TT.multipleToolTipsY, WhichToolTip)


            ; if mouse is bottom right, adjust Tooltip position
            if ((x+w) > VirtualScreenWidth)
            {
                AdjustX := 1
            }
            if ((y+h) > VirtualScreenHeight)
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
                x := VirtualScreenWidth - w
            }
            else if(AdjustY)
            {
                y := VirtualScreenHeight - h
            }


            ; move tooltip
            if (Text = TT.LastText[WhichToolTip])
            {
                DllCall("MoveWindow", A_PtrSize ? "UPTR" : "UInt", TT.hwnd[WhichToolTip], "Int", x, "Int", y, "Int", w, "Int", h, "Int", 0)
            }
            ; recreate tooltip
            else
            {
                ; Perfect solution would be to update tooltip text (TTM_UPDATETIPTEXT), but must be compatible with all versions of AHK_L and AHK Basic.
                ; My Ask For Help link: http://www.autohotkey.com/forum/post-421841.html#421841
                CoordMode, ToolTip, Screen
                ToolTip, % Text, x, y, % WhichToolTip
                TT.hwnd[WhichToolTip] := WinExist("ahk_class tooltips_class32 ahk_pid " DllCall("GetCurrentProcessId"))
                TT.LastText[WhichToolTip] := Text

                WinGetPos,,, w, h, % "ahk_id " . TT.hwnd[WhichToolTip]
                TT.multipleToolTipsY[WhichToolTip] := h
            }
        }
        ; Winset, AlwaysOnTop, on, % "ahk_id" . TT.hwnd[WhichToolTip]
    }


    __multipleToolTipsOffsetCalc(arrr, lenn) {
        result := 0
        For i, v in arrr
        {
            if(i >= lenn)
            {
                break
            }
            result += v + 2
        }
        return result
    }

    __DestroyWhichTooltip(whichTooltip)
    {
        ToolTip,,,, % WhichToolTip
        this.CurrentText.Delete(WhichToolTip)
        this.LastText.Delete(WhichToolTip)
        this.hwnd.Delete(WhichToolTip)
        this.DestroyAtTime.Delete(WhichToolTip)
        this.multipleToolTipsY.Delete(WhichToolTip)
    }

}


