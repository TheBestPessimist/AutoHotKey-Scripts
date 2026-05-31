
; todo i should try both of these and see which one works better
CapsLock & LButton:: {
    Loop 20 {
        SetControlDelay -1
        MouseGetPos(&xPos, &yPos)
        ControlClick(, WinTitles.tf2,, "Left", 20,  "NA " " X" xPos " Y" yPos)
    }
}

;CapsLock & RButton:: {
;    While (GetKeyState("RButton", "P") && GetKeyState("CapsLock", "P")){
;        Click
;        sleep 5
;    }
;}


CapsLock & RButton:: {
    static toggle := 0
    SetTimer(clicky, (toggle := !toggle) ? 250 : 0)

    clicky(){
        Click
    }
}
