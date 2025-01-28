#Include lib/Tippy.ahk


resetCapsLockState()

; As far as i can see, CapsLock is sometimes stuck when launcher Flow Launcher via Caps + Win.
; I hope this will fix it
resetCapsLockState(){
    SetCapsLockState("On")
    SetCapsLockState("AlwaysOff")
}

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
