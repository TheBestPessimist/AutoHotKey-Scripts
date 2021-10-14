
range(startx, endx, stepsize := 1) {
    stepsize := stepsize * (startx < endx ? 1 : -1)
    range_a := Array()
    Loop {
        range_a.Push(startx)
        startx += stepsize
    } Until ((stepsize > 0) ? (startx >= endx) : (startx <= endx))
    range_a.Push(startx)
    return range_a
}

:X:.scmacro:: SetTimer, cc, % (togglem := !togglem) ? 1000: "Off"

CapsLock & m:: SetTimer, cc, % (togglem := !togglem) ? 1000: "Off"
cc() {
    SetKeyDelay, 200, 1000

    ; idle breaker
    ControlSend,, {Blind}{w down}, % "ahk_exe game.exe"
    ControlSend,, {Blind}{w up}, % "ahk_exe game.exe"
    ControlSend,, {Blind}{s down}, % "ahk_exe game.exe"
    ControlSend,, {Blind}{s up}, % "ahk_exe game.exe"
    ControlSend,, {Blind}{1}, % "ahk_exe game.exe"
    ControlSend,, {Blind}{4}, % "ahk_exe game.exe"
    ControlSend,, {Blind}{2}, % "ahk_exe game.exe"
    ; used for Waz'Got Battle Station
    ControlSend,, {Blind}{3 down}{3 up}, % "ahk_exe game.exe"

    ; Autoselect bonuses at game end
    if (WinActive("ahk_exe game.exe") || WinActive("ahk_exe ACDSeeProfessional2018.exe"))
    {
    ; search for goodies
        oldX := 401
        oldY := 200
        for _, x in range(401, A_ScreenWidth-401, 43) {
            for _, y in range(200, A_ScreenHeight-200, 43) {
                ; Tippy("x y:" x " " y "`n" " ox oy: " oldX " " oldY)
                sleep, -1
                if (WinActive("ahk_exe game.exe") || WinActive("ahk_exe ACDSeeProfessional2018.exe"))
                {
                    MouseMove, x, y
                    ; Sleep 100
                    ImageSearch, FoundX, FoundY, oldX, oldY, x, y, *8 games/DOT1.jpg
                    if (ErrorLevel = 0)
                    {
                        Tippy("Mouse Pos: " FoundX " " FoundY)

                        MouseClick, left, FoundX, FoundY,,,D
                        sleep 2000
                        MouseClick, left, FoundX, FoundY,,,U
                    }
                }
                oldY = % y
            }
            oldX = % x
        }
    }


    ; cancel any "unwelcomed goodies" + reconnect
    ControlSend,, {Blind}{Esc}, % "ahk_exe game.exe"
    ControlSend,, {Blind}{Enter}, % "ahk_exe game.exe"
    ControlSend,, {Blind}{Esc}, % "ahk_exe game.exe"
    ControlSend,, {Blind}{Enter}, % "ahk_exe game.exe"
    ControlSend,, {Blind}{Enter}, % "ahk_exe game.exe"



    ; next game
    if (WinActive("ahk_exe game.exe"))
    {
        ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *80 games/to_battle.jpg
        if (ErrorLevel = 0)
        {
            MouseClick, left, FoundX, FoundY,,,D
            Sleep 100
            MouseClick, left, FoundX, FoundY,,,U
    }
    }

}
