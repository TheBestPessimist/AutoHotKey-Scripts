; This is the main function for Tippy :^)
Tippy(text = "", duration := 3333, whichToolTip := 1) {
    TT.ShowTooltip(text, duration, whichToolTip)
}


class TT {
    static ToolTipData := {}

    static __TippyOnFn := TT.__TippyOn.Bind(TT)

    ShowTooltip(text, duration, whichToolTip) {
        fnOff := ""
        ; rate limiting if ToolTip already exists
        ttData := this.ToolTipData[whichToolTip]
        if(ttData)
        {
            fnOff := ttData.fnOff
            if(text = "")
            {
                this.__TippyOff(whichToolTip)
                return
            }
            if(ttData.CurrentText = text)
            {
                ttData.Duration := duration
            }
        }
        else
        {
            ; this "hack" is needed because
            ; a new object SHOULD ONLY BE CREATED IF IT DOES NOT EXIST
            ; and if it exists, then we will only update the existing fields.
            ; this prevents recreating the ToolTip sometimes
            this.ToolTipData[whichToolTip] := {}
        }

        ; sanitize whichToolTip
        whichToolTip := Max(1, Mod(whichToolTip, 20))

        ; in this case we have a new ToolTip
        if(!fnOff)
        {
            fnOff := this.__TippyOff.Bind(this, whichToolTip)
        }
        ; call start and stop
        SetTimer, % fnOff, % "-" duration
        fnOn := this.__TippyOnFn
        SetTimer, % fnOn, 10

        ; init the ToolTipData
        this.ToolTipData[whichToolTip].CurrentText := text
        this.ToolTipData[whichToolTip].Duration := duration
        this.ToolTipData[whichToolTip].fnOff := fnOff
        this.ToolTipData[whichToolTip].WhichToolTip := whichToolTip

        Sleep 2
    }


    __TippyOn() {
        this.__ToolTipFM()
    }


    __TippyOff(whichTooltip) {
        this.__DestroyWhichTooltip(whichToolTip)
        this.__InvalidateToolTipYOffset()

        if(this.ToolTipData.Count() = 0)
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

        For whichToolTip, ttData in this.ToolTipData
        {
            ; move or recreate tooltip
            WinGetPos,,, w, h, % "ahk_id " . ttData.Hwnd
            CoordMode, Mouse, Screen
            MouseGetPos, x, y
            x += defaultxOffset
            y += defaultyOffset
            ; stack tooltips vertically
            y += this.__MultipleToolTipsYOffsetCalc(whichToolTip)

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
    }


    __MultipleToolTipsYOffsetCalc(neededToolTip) {
        ; check if it's the very first tooltip. there's no offset
        isVeryFirst := 1
        For whichToolTip, ttData in this.ToolTipData
        {
            if(neededToolTip = whichToolTip && isVeryFirst)
            {
                return 0
            }
            else
            {
                break
            }
            isVeryFirst := 0
        }

        ; if it's already calculated
        if(this.ToolTipData[neededToolTip].YOffset != "" && this.ToolTipData[neededToolTip].YOffset != 0)
        {
            return this.ToolTipData[neededToolTip].YOffset
        }

        Debug("no cache hit" neededToolTip)

        ; not precalculated, so recompute everything
        result := 0
        For whichToolTip, ttData in this.ToolTipData
        {
            ttData.YOffset := result
            result += ttData.ToolTipHeight + 2
        }
        return this.ToolTipData[neededToolTip].YOffset
    }


    __InvalidateToolTipYOffset() {
        For whichToolTip, ttData in this.ToolTipData
        {
           ttData.YOffset := 0
        }
    }


    __DestroyWhichTooltip(whichTooltip) {
        ToolTip,,,, % whichToolTip
        this.ToolTipData.Delete(whichToolTip)
    }
}


