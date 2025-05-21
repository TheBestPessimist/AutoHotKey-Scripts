
#HotIf A_ComputerName = "tbp-mhp"
; Change display brightness with Ctrl + Volume
; Source: https://gist.github.com/krrr/3c3f1747480189dbb71f
;
; A problem: I cannot make the Windows Brightness OSD appear. Yes, I tried in multiple ways and with LLMs and everything.

Ctrl & Volume_Up::AdjustScreenBrightness(10)
Ctrl & Volume_Down::AdjustScreenBrightness(-10)

AdjustScreenBrightness(step) {
    static service := "winmgmts:{impersonationLevel=impersonate}!\\.\root\WMI"
    monitors := ComObjGet(service).ExecQuery("SELECT * FROM WmiMonitorBrightness WHERE Active=TRUE")
    monMethods := ComObjGet(service).ExecQuery("SELECT * FROM wmiMonitorBrightNessMethods WHERE Active=TRUE")
    for i in monitors {
        curr := i.CurrentBrightness
        break
    }
    toSet := curr + step
    if (toSet < 10)
        toSet := 0
    if (toSet > 100)
        toSet := 100
    Tippy("Brightnes: " toSet)
    for i in monMethods {
        i.WmiSetBrightness(1, toSet)
        break
    }
}

#HotIf
