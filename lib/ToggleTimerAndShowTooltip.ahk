#include lib/Tippy.ahk

; Function which toggles a timer (using SetTimer) but also shows if it turned the timer on or off with a tooltip.
;
; How to use:
;   call a function with:  `ToggleTimerAndShowTooltip("functionName", 1000)`
;   call a class method with:
;           `ToggleTimerAndShowTooltip("ClassName.MethodName", 7000, ClassName.MethodName.Bind(ClassName))`
;           eg. `ToggleTimerAndShowTooltip("SC2.aaa", 7000, SC2.aaa.Bind(SC2))`
;               where
;                   SC2 = class
;                   aaa = method from class
;
; Note: the `functionIdentifier` and `functionReferences` thing is just a hack to be able to toggle class methods: `class.method.Bind(this)`
;
ToggleTimerAndShowTooltip(functionName, interval, functionIdentifier := 0)
{
    static functionNames :=  {}
    static functionReferences := {}

    ; if there's no functionIdentifier, we're in a normal function call, not class method call
    if (functionIdentifier = 0)
    {
        functionIdentifier := functionName
    }

    if !(functionReferences[functionName])
    {
        functionReferences[functionName] := functionIdentifier
    }

    toggle := !functionNames[functionName]
    functionNames[functionName] := toggle

    Fn := functionReferences[functionName]
    SetTimer, % Fn, % toggle ? interval : "Off"

    if (toggle)
    {
        Tippy(functionName . " on",, -1)
        %Fn%()
    }
    else
    {
        Tippy(functionName . " off",, -1)
    }
}
