#Include lib/Tippy.ahk

CapsLockState := 0
CapsLockStateWasChangedByUser := 0

; On startup, caps is always off
SetCapsLockState("AlwaysOff")

SetTimer(() => setMyCapsLockState(), 10000)

CapsLock & Alt:: {
    global CapsLockState
    global CapsLockStateWasChangedByUser

    CapsLockState := !CapsLockState
    CapsLockStateWasChangedByUser := 1

    setMyCapsLockState()
}

setMyCapsLockState() {
    global CapsLockState
    global CapsLockStateWasChangedByUser

    if CapsLockState {
        if CapsLockStateWasChangedByUser {
            CapsLockStateWasChangedByUser := 0

            SetCapsLockState("AlwaysOn")
            Tippy("CapsLock is: ON", 99999999999999, 15)
        }
    } else {
        SetCapsLockState("AlwaysOff")
        if CapsLockStateWasChangedByUser {
            CapsLockStateWasChangedByUser := 0
            Tippy("CapsLock is: off",, 15)
        }
    }
}
