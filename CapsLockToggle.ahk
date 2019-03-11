; There is no need for a standard ahk auto-execute area anymore because of this method.
; This method is called automatically when the static variable autoExecute is instantiated,
; and since it's a static, it will only be instantiated once!
;
; Idea provided by @nnnik#6686 on the AHK Discord Server: https://discord.gg/s3Fqygv
CapsLockToggleAutoExecute()
{
    static autoExecute := CapsLockToggleAutoExecute()

    ; Check every second if CapsLock is off
    SetTimer, keepCapsLockOff, 1000

    ; Sometimes i may want to use caps. This is a toggle to control that
    global shouldKeepCapsLockOff := 1
}

; disable normal CapsLock usage
CapsLock::return

;-------------------------------------------------
; Keep CapsLock off at (almost) all times!
; reset Caps state via CapsLock + Alt
keepCapsLockOff()
{
    global shouldKeepCapsLockOff

    if(!shouldKeepCapsLockOff)
    {
        Sleep, 100
        SetCapsLockState On
        Return
    }
    SetCapsLockState Off
}

; Sometimes i may want to use caps. This is a toggle to control that
CapsLock & Alt::
ToggleCapsLockState()
{
    global shouldKeepCapsLockOff
    shouldKeepCapsLockOff := !shouldKeepCapsLockOff
    Sleep, 100

    if (shouldKeepCapsLockOff)
    {
        Sleep, 300    ; one has to sleep JUST BEFORE toggling caps
        Tippy("CapsLock is off")
        SetCapsLockState Off
    }
    else
    {
        Sleep, 300    ; one has to sleep JUST BEFORE toggling caps
        Tippy("CapsLock is on")
        SetCapsLockState On
    }
}
