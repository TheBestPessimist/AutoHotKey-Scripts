SetTimer(() => SetCapsLockState("AlwaysOff"), -1)

CapsLock & Alt:: {
    static state := 0
    state := !state
    if state {
        SetCapsLockState("AlwaysOn")
;        Tippy("CapsLock is: ON", 99999999)
    }
    else {
;        Tippy("CapsLock is: off")
        SetCapsLockState("AlwaysOff")
    }
}
