; XMG Fusion 15 Improved keyboard shortcuts, plus Fn Lock functionality

; The Fn key has Scan Code 178



; ====
; ==== Change order of keys to PgUp, PgDown, Home, End
;
; Initial order: Home, PgUp, PgDown, End (like, WTF Intel?)
; Correct order: PgUp, PgDown, Home, End (duuuh)
;
; This thing was done originally using Interception but now is changed,
; because Interception driver is fucked and after disconnecting and reconnecting ANY USB device
; multiple times, all usb devices stop working.
;
; Instead, I'm listening to the "usb device changed" message and searching for my external keyboard HID.
; Source: https://www.autohotkey.com/boards/viewtopic.php?f=76&p=439480
init()

init() {
    global IsUsbKeyboardAttached := false
    OnMessage(0x219, (*) => SetTimer(onUsbDeviceChange, -2000))
    SetTimer(onUsbDeviceChange, -2000)
}

onUsbDeviceChange(*) {
    global IsUsbKeyboardAttached
    static corsairKeyboardDeviceId := "HID\VID_1B1C&PID_1B13&MI_00&COL01"

    saveClipboard()

    PS := '"Get-WmiObject Win32_PNPEntity | Sort-Object -Property DeviceID | Format-Table DeviceID | clip"'
    RunWait('PowerShell.exe -Command ' PS,, "Hide")

    IsUsbKeyboardAttached := InStr(A_Clipboard, corsairKeyboardDeviceId)

    restoreClipboard()
}

; #HotIf !IsUsbKeyboardAttached
; PgUp::PgDn
; PgDn::Home
; Home::PgUp
; #HotIf



; ====
; ==== PageUp, PageDown, Home, End

; Note: Fusion already has dedicated keys for this, but I also find useful to have these Fn shortcuts.

; PageUp = Fn + Up
; sc178 & Up::PgUp

; PageDown = Fn + Down
; sc178 & Down::PgDn

; Home = Fn + left
; sc178 & Left::Home

; End = Fn + Right
; sc178 & Right::End




; ====
; ==== Fn + 1, 2, 3, 4, etc. work as Num1, Num2, etc.
sc178 & 0::NumPad0
sc178 & 1::NumPad1
sc178 & 2::NumPad2
sc178 & 3::NumPad3
sc178 & 4::NumPad4
sc178 & 5::NumPad5
sc178 & 6::NumPad6
sc178 & 7::NumPad7
sc178 & 8::NumPad8
sc178 & 9::NumPad9


; ====
; ==== Disable insert key
;
Insert::Return


; ====
; ==== Disable some Fn Shortcuts which I do not like
;
; Unfortunately this cannot be done (at least i did not find a way to do it), as Fn+Fx is handled by the hardware (ie. it works without having Control Center open),
; so there's nothing that AutoHotkey can do.
;
; Disable Airplane Mode
;sc178 & F4::return
;
; Disable Touchpad Disabler
;sc178 & F5::return
