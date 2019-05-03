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
        whichToolTip := TT.GetUnusedToolTip(text)
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
; I honestly think i would have kicked someone for being as stupid as I was at times.


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

    static AllToolTipsHeightSum := 0
    static WidestToolTip := 0

    static MaxWhichToolTip := 20
    static DefaultWhichToolTip := 10

    static __TippyOnFn := TT.__TippyOn.Bind(TT)

    ShowTooltip(text, duration, whichToolTip) {
        fnOff := ""
        ; sanitize whichToolTip
        whichToolTip := Max(1, Mod(whichToolTip, this.MaxWhichToolTip))
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
            ; since doing `this.ToolTipData[whichToolTip] := {CurrentText: text, Duration: duration, fnOff: fnOff , WhichToolTip : whichToolTip }` would clear ttData.LastText
            ttData := {}
            this.ToolTipData[whichToolTip] := ttData
        }


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
        ttData.CurrentText := text
        ttData.Duration := duration
        ttData.fnOff := fnOff
        ttData.WhichToolTip := whichToolTip

        Sleep 2
    }


    GetUnusedToolTip(text) {
        ; firstly go through all tooltips to check if this one is not already shown
        For whichToolTip, ttData in this.ToolTipData
        {
            if(ttData.CurrentText == text)
            {
                return whichToolTip
            }
        }

        ; if no tooltips with same text is shown, then return a new one
        whichToolTip := 11
        While (whichToolTip <= this.MaxWhichToolTip)
        {
            if(!this.ToolTipData[whichToolTip])
            {
                return whichToolTip
            }
            whichToolTip++
        }
        Return this.DefaultWhichToolTip
    }


    __TippyOn() {
        this.__ToolTipFM()
    }


    __TippyOff(whichTooltip) {
        this.__DestroyWhichTooltip(whichToolTip)
        this.__InvalidateToolTipYOffsetCache()

        if(this.ToolTipData.Count() == 0)
        {
            fnOn := this.__TippyOnFn
            SetTimer, % fnOn, Off
        }
    }


    __ToolTipFM() { ; ToolTip which Follows the Mouse
        static defaultxOffset := 16, defaultyOffset := 16

        localScreen := this.__GetLocalScreenMouseCoordsAndBounds()
        localScreenMouseX := localScreen.x
        localScreenMouseY := localScreen.y
        localScreenHeight := localScreen.screenHeight
        localScreenWidth := localScreen.screenWidth

        CoordMode, Mouse, Screen
        MouseGetPos, realMouseX, realMouseY

        For whichToolTip, ttData in this.ToolTipData
        {
            x := realMouseX
            y := realMouseY
            WinGetPos,,, w, h, % "ahk_id " . ttData.Hwnd

            ; stack tooltips vertically
            multipleToolTipsYOffset := this.__ToolTipYOffsetCache(whichToolTip)

            ; adjust ToolTip position if:
            ; tooltip reaches bottom of screen
            if ((y + this.AllToolTipsHeightSum + defaultyOffset*4) >= localScreenHeight)
            {
                ; if ToolTip reaches bottom of screen AND RIGHT
                if ((x + this.WidestToolTip + defaultxOffset*2) >= localScreenWidth)
                {
                    y := y - (this.AllToolTipsHeightSum + defaultyOffset*4)
                }
                ; if ToolTip reaches bottom of screen ONLY
                else
                {
                    y := localScreenHeight - (this.AllToolTipsHeightSum + defaultyOffset*4)
                }
            }
            ; if ToolTip reaches right side of screen   (! no "else" here)
            if ((x + w + defaultxOffset*2) >= localScreenWidth)
            {
                x := localScreenWidth - (w + defaultxOffset*2)
            }

            x += defaultxOffset
            y += defaultyOffset
            y += multipleToolTipsYOffset

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
                this.WidestToolTip := Max(this.WidestToolTip, w)
                this.__InvalidateToolTipYOffsetCache()
            }
        }
    }


    __ToolTipYOffsetCache(neededToolTip) {
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

        ; not precalculated, so recompute everything
        result := 0
        For whichToolTip, ttData in this.ToolTipData
        {
            ttData.YOffset := result
            result += ttData.ToolTipHeight + 2
        }
        this.AllToolTipsHeightSum := result
        return this.ToolTipData[neededToolTip].YOffset
    }


    ; each time a new ToolTip is created or destroyed the offset has to be recomputed
    __InvalidateToolTipYOffsetCache() {
        For whichToolTip, ttData in this.ToolTipData
        {
           ttData.YOffset := 0
        }
    }


    __DestroyWhichTooltip(whichTooltip) {
        ToolTip,,,, % whichToolTip
        this.ToolTipData.Delete(whichToolTip)
    }


    __GetLocalScreenMouseCoordsAndBounds() {
        screens := this.__GetAllScreenDimensions()

        CoordMode, Mouse, Screen
        MouseGetPos, X, Y

        for k, v in screens {
            if (X >= v.Left && X <= v.Right && Y <= v.Bottom && Y >= v.Top) {
                return {"x": X - v.Left, "y": Y - v.Top, "screenHeight": v.Bottom, "screenWidth": v.Right}
            }
        }
    }


    __GetAllScreenDimensions() {
        static monitorCount
        static screens

        SysGet, newMonitorCount, MonitorCount
        if (monitorCount != newMonitorCount)
        {
            monitorCount := newMonitorCount

            screens := []
            loop, % MonitorCount
            {
                SysGet, BoundingBox, Monitor, % A_Index
                screens.Push({"Top": BoundingBoxTop, "Bottom": BoundingBoxBottom, "Left": BoundingBoxLeft, "Right": BoundingBoxRight})
            }
        }
        return screens
    }




}







; ; ================================
; ; HERE IS HOW YOU TEST THE SCRIPT!

; ; Uncomment the following code
; ; Press and hold F1 then F2 hotkeys, and move mouse.
; ; See the difference in CPU usage and smoothness


; VeryLongText = ; Make a very long ToolTip text for testing purpose
; (
; If blank or omitted, the existing tooltip (if any) will be hidden.
; Otherwise, this parameter is the text to display in the tooltip.
; If blank or omitted, the existing tooltip (if any) will be hidden.
; Otherwise, this parameter is the text to display in the tooltip.
; If blank or omitted, the existing tooltip (if any) will be hidden.
; Otherwise, this parameter is the text to display in the tooltip.
; If blank or omitted, the existing tooltip (if any) will be hidden.
; Otherwise, this parameter is the text to display in the tooltip.
; If blank or omitted, the existing tooltip (if any) will be hidden.
; Otherwise, this parameter is the text to display in the tooltip.
; If blank or omitted, the existing tooltip (if any) will be hidden.
; Otherwise, this parameter is the text to display in the tooltip.
; If blank or omitted, the existing tooltip (if any) will be hidden.
; Otherwise, this parameter is the text to display in the tooltip.
; )


; ; old system = flickers + high CPU load + slow moving
; F1::
; While, GetKeyState(A_ThisHotkey,"p")
; {
;     ToolTip, % VeryLongText
;     Sleep, 10
; }
; ToolTip
; return


; ; new system = does not flicker + low CPU load + fast moving + multiple Tips
; F2::
; {
;     Tippy(VeryLongText, 6000) ; you pass the text and the duration
;     Tippy("second ToolTip", 4000, 1) ; text, duration and a unique tooltip number
;     Tippy("third ToolTip", 10000, 2)

; }
; return
