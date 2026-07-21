
#HotIf WinActive(WinTitles.tf2)
CapsLock & LButton:: {
    Loop 20 {
        SetControlDelay -1
        MouseGetPos(&xPos, &yPos)
        ControlClick(, WinTitles.tf2,, "Left", 20,  "NA " " X" xPos " Y" yPos)
    }
}

CapsLock & RButton:: {
    While (GetKeyState("RButton", "P") && GetKeyState("CapsLock", "P")){
        Click
        sleep 5
    }
}

;;
;CapsLock & RButton:: {
;    static toggle := 0
;    SetTimer(clicky, (toggle := !toggle) ? 150 : 0)
;
;    clicky(){
;        ControlClick(, WinTitles.tf2,, "Left",)
;    }
;}



;/*
;TF2: delete items from backpack when they're at the 300 limit. (fuck that limit btw)
;*/
;f:: {
;    SendMode "Event"
;    SetMouseDelay 20
;    SetKeyDelay 20, 20
;
;    ; save initial position
;    MouseGetPos &x, &y
;
;    Send "{RButton}"
;
;    ImageSearch &xx, &yy, 0, 0, A_ScreenWidth, A_ScreenHeight, "resources/TF2 - Items Backpack Delete Button.png"
;    MouseMove xx, yy
;
;    Send "{LButton}"
;    Send "{Enter}"
;
;    ; restore initial position
;    MouseMove x, y
;}

#HotIf
