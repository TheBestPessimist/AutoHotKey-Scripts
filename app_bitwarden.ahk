;-------------------------------------------------
; Bitwarden Shortcuts which they won't implement for some stupid reason
#HotIf WinActive(WinTitles.Bitwarden)
; Helper: click an image within the Bitwarden window bounds
bitwardenClickImage(imgPath) {
    CoordMode "Pixel", "Screen"
    CoordMode "Mouse", "Screen"
    SendMode "Event"
    MouseGetPos &x, &y
    WinGetPos &wx, &wy, &ww, &wh, WinTitles.Bitwarden
    x1 := wx
    y1 := wy
    x2 := wx + ww - 1
    y2 := wy + wh - 1
    if ImageSearch(&ix, &iy, x1, y1, x2, y2, imgPath) {
        MouseMove ix, iy, 5
        Send "{LButton}"
        MouseMove x, y, 5
        return true
    } else {
        Tippy("Image   `"" . imgPath . "`"    was not found.")
        return false
    }
}

#HotIf WinActive(WinTitles.Bitwarden)
^e::bitwardenClickImage("resources/BW - Bitwarden Edit Button.png")
^s::bitwardenClickImage("resources/BW - Bitwarden Save Button.png")
^d::bitwardenClickImage("resources/BW - Bitwarden Delete Button.png")
#HotIf

