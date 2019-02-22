; disable normal CapsLock usage
CapsLock::return

;-------------------------------------------------
; Keep CapsLock off at (almost) all times!
; reset Caps state via CapsLock + Alt
keepCapsLockOff()
{
    if(!shouldKeepCapsLockOff)
    {
        Sleep, 100
        SetCapsLockState On
        return
    }
    SetCapsLockState Off
}

; Sometimes i may want to use caps. This is a toggle to control that
CapsLock & Alt::
{
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
    Return
}
