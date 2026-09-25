; There's no Insert key
CapsLock & Del::Insert


; There's no PrintScreen key either
#+s::PrintScreen
; s::PrintScreen



; When starting my laptop from hibernate and on Balanced, CPU power is low (as if it's still on Silent Mode)
; See: https://github.com/seerge/g-helper/issues/5935
; So what i'm doing is cycling through all power modes with a pause to give GHelper time to change
CapsLock & P::{
    loop(3) {
        Send ("^!+{F5}")
        Sleep(2000)
    }
}
