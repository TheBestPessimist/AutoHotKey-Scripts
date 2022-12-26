#Include lib/Tippy.ahk

SetCapsLockState("AlwaysOff")

CapsLock & Alt:: {
    static state := 0
    state := !state
    if state {
        SetCapsLockState("AlwaysOn")
        Tippy("CapsLock is: ON", 99999999999999, 15)
    }
    else {
        SetCapsLockState("AlwaysOff")
        Tippy("CapsLock is: off",, 15)
    }
}
