; There is no need for a standard ahk auto-execute area anymore because of this method.
; This method is called automatically when the static variable autoExecute is instantiated,
; and since it's a static, it will only be instantiated once!
;
; Idea provided by @nnnik#6686 on the AHK Discord Server: https://discord.gg/s3Fqygv
CapsLockToggleAutoExecute()
{
    static autoExecute := CapsLockToggleAutoExecute()

    ; Every second enforce the correct CapsLock state
    SetTimer, enforceCapsLockState, 1000

    ; Sometimes i may want to use caps. This is a toggle to control that.
    global CapsLockState := "off"
}

; disable normal CapsLock usage
CapsLock::return

enforceCapsLockState()
{
    global CapsLockState

    if (CapsLockState = "on")
    {
        SetCapsLockState On
        Tippy("CapsLock is: ON")
    }
    else if(CapsLockState = "off")
    {
        SetCapsLockState Off
    }
}


CapsLock & Alt::
ToggleCapsLockState()
{
    Critical
    global CapsLockState

    if (CapsLockState = "on")
    {
        CapsLockState := "off"
        Tippy("CapsLock is: off")
    }
    else if(CapsLockState = "off")
    {
        CapsLockState := "on"
    }
    enforceCapsLockState()
}
