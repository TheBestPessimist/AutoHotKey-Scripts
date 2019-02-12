; disable normal CapsLock usage
CapsLock::return

;-------------------------------------------------
; Keep CapsLock off at (almost) all times!
; reset Caps state via CapsLock + Alt
keepCapsLockOff()
{
    if(!shouldKeepCapsLockOff)
    {
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
        Tippy("CapsLock is off")
        SetCapsLockState Off
    }
    else
    {
        Tippy("CapsLock is on")
        SetCapsLockState On
    }
    Return
}
