#include Tippy.ahk

; function which toggles a timer (using SetTimer) but also shows
; if it turned the timer on or off with a tooltip
StartTimerAndShowTooltip(functionName, interval)
{
    static functionNames :=  {}

    toggle := !functionNames[functionName]
    functionNames[functionName] := toggle

    SetTimer, %functionName%, % toggle ? interval : "Off"

    if (toggle)
    {
        Tippy(functionName . " on")
        Sleep 1000
        %functionName%()
    }
    else
    {
        Tippy(functionName . " off")
    }
}

