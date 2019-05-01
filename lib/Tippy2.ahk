; Show a ToolTip which follows the mouse for a specific duration.
; Multiple ToolTips are stacked vertically, so no information is hidden.
;
; == How to use ==
;
; - At the top of your scripts include this ahk file:
;           #include lib/Tippy.ahk
; - Call the function Tippy("Text to show") with the text you want to show.
;           You have an example at the end of the script (just uncomment it)!

Tippy(text := "", duration := 3333, whichToolTip := 10) {
    if(whichToolTip == -1)
    {
        whichToolTip := TT.GetUnusedToolTip()
    }

    TT.ShowTooltip(text, duration, whichToolTip)
}

;   == Original idea ==
;       - https://autohotkey.com/board/topic/63640-tooltip-which-follows-the-mouse-is-flickering/#entry409383
;       - https://www.autohotkey.com/boards/viewtopic.php?f=6&t=12307


;   == Thanks ==
; Many thanks to @nnnik#6686 and @evilC#8858 on the AHK Discord Server: https://discord.gg/s3Fqygv
;       for putting up with all my lack of knowledge and understanding of
;       Object Oriented Programming in ahk.


;   ==  How it works ==
;
; Function Tippy is the ToolTip launcher.
;
; All the details are stored into the class TT
;
; - Method ToolTipFM is called on a timer every 10 ms to update the tooltip position
;       and uses MoveWindow dll call instead of recreating the ToolTip,
;       that's why the tooltip movement is smooth!
;
; - TippyOff is called after %Duration% time to tur  off the timer for TippyOn so everything is clean
;
;  - MultipleToolTipsYOffsetCalc computes each ToolTip's stacking position and caches those values.
;
;
class TT {
    static ToolTipData := {}
    static MaxWhichToolTip := 20
    static DefaultWhichToolTip := 10

    static __TippyOnFn := TT.__TippyOn.Bind(TT)

    ShowTooltip(text, duration, whichToolTip) {
        fnOff := ""
        ; rate limiting if ToolTip already exists
        ttData := this.ToolTipData[whichToolTip]
        if(ttData)
        {
            fnOff := ttData.fnOff
            if(text == "")
            {
                this.__TippyOff(whichToolTip)
                return
            }
            if(ttData.CurrentText == text)
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
        whichToolTip := Max(1, Mod(whichToolTip, this.MaxWhichToolTip))

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


    GetUnusedToolTip() {
        whichToolTip := this.MaxWhichToolTip
        While (whichToolTip > 0)
        {
            if(!this.ToolTipData[whichToolTip])
            {
                return whichToolTip
            }
            whichToolTip--
        }
        Return this.DefaultWhichToolTip
    }


    __TippyOn() {
        this.__ToolTipFM()
    }


    __TippyOff(whichTooltip) {
        this.__DestroyWhichTooltip(whichToolTip)
        this.__InvalidateToolTipYOffset()

        if(this.ToolTipData.Count() == 0)
        {
            fnOn := this.__TippyOnFn
            SetTimer, % fnOn, Off
        }
    }


    __ToolTipFM() { ; ToolTip which Follows the Mouse
        static defaultxOffset := 16, defaultyOffset := 16
        static virtualScreenWidth, virtualScreenHeight ; http://www.autohotkey.com/forum/post-430240.html#430240

        if (virtualScreenWidth == "" or virtualScreenHeight == "")
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
            if (ttData.CurrentText == ttData.LastText)
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
        ; if it's the only tooltip
        if(this.ToolTipData.Count() == 1)
        {
            return 0
        }

        ; if it's the very first tooltip
        isVeryFirst := 1
        For whichToolTip, ttData in this.ToolTipData
        {
            if(neededToolTip == whichToolTip && isVeryFirst)
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

        ; Debug("no cache hit => initialize cache. WhichToolTip: " neededToolTip)

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

