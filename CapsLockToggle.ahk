#Include lib/Tippy.ahk

CapsLockState := 0
CapsLockStateWasChanged := 0

; On startup, caps is always off
SetCapsLockState("AlwaysOff")

SetTimer(() => setMyCapsLockState(), 10000)

CapsLock & Alt:: {
    global CapsLockState
    global CapsLockStateWasChanged

    CapsLockState := !CapsLockState
    CapsLockStateWasChanged := 1

    setMyCapsLockState()
}

setMyCapsLockState() {
    global CapsLockState
    global CapsLockStateWasChanged

    if CapsLockStateWasChanged {
        CapsLockStateWasChanged := 0
        if CapsLockState {
            SetCapsLockState("AlwaysOn")
            Tippy("CapsLock is: ON", 99999999999999, 15)
        }
        else {
            SetCapsLockState("AlwaysOff")
            Tippy("CapsLock is: off",, 15)
        }
    }
}
