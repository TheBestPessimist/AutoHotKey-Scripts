; XMG Fusion 15 Improved keyboard shortcuts, plus Fn Lock functionality

; The Fn key has Scan Code 178


#include lib\AutoHotInterception\AutoHotInterception.ahk



; There is no need for a standard ahk auto-execute area anymore because of this method.
; This method is called automatically when the static variable autoExecute is instantiated,
; and since it's a static, it will only be instantiated once!
;
; Idea provided by @nnnik#6686 on the AHK Discord Server: https://discord.gg/s3Fqygv
XmgFusion15AutoExecute()
{
    if (A_ComputerName != "tbp-fusion") {
        return
    }

    static autoExecute := XmgFusion15AutoExecute()

    ; changeKeyOrderUsingAutoHotInterception()

    changeKeyOrderByDetectingUSBKeyboard()

}


; ====
; ==== Change order of keys to PgUp, PgDown, Home, End
;
; Initial order: Home, PgUp, PgDown, End (like, WTF Intel?)
; Correct order: PgUp, PgDown, Home, End (duuuh)
;
; This is done  using AutoHotInterception library, so that only the keys from the laptop are changed,
;   and not the keys from other connected keyboards
;
; PROBLEM: this doesn't always block the original key therefore I have to use "subscription" mechanism instead of the easier to use "context"
; changeKeyOrderUsingAutoHotInterception()
; {
;     AHI := new AutoHotInterception()
;     Fusion15KeyboardId := AHI.GetKeyboardIdFromHandle("ACPI\VEN_MSFT&DEV_0001", 1)
;
;     AHI.SubscribeKey(Fusion15KeyboardId, GetKeySC("PgUp"), true, Func("XmgKeyEventHandler").Bind("PgDn"))
;     AHI.SubscribeKey(Fusion15KeyboardId, GetKeySC("PgDn"), true, Func("XmgKeyEventHandler").Bind("Home"))
;     AHI.SubscribeKey(Fusion15KeyboardId, GetKeySC("Home"), true, Func("XmgKeyEventHandler").Bind("PgUp"))
;
;     Tippy("inside changeKeyOrder")
; }
;
; XmgKeyEventHandler(newKey, state)
; {
;     if(state)
;         Send % "{Blind}{" newKey " down}"
;     else
;         Send % "{Blind}{" newKey " up}"
; }


; The thing above is commented out, because Interception driver is fucked and after disconnecting and reconnecting ANY USB device multiple times,
; all usb devices stop working.
; Source: https://www.autohotkey.com/boards/viewtopic.php?f=76&p=439480
changeKeyOrderByDetectingUSBKeyboard()
{
    OnMessage(0x219, "onUsbDeviceChangeTimer")
}

onUsbDeviceChangeTimer()
{
    SetTimer % "onUsbDeviceChange", -2000
}

global usbKeyboardAttached := false
onUsbDeviceChange()
{
    global usbKeyboardAttached
    static corsairKeyboardDeviceId := "HID\VID_1B1C&PID_1B13&MI_00&COL01\8&270545BF&0&0000"

    saveClipboard()

    PS := "Get-WmiObject Win32_PNPEntity | Sort-Object -Property DeviceID | Format-Table DeviceID | clip"
    RunWait, PowerShell.exe -Command "%PS%",, Hide
    found := InStr(Clipboard, corsairKeyboardDeviceId)
    if found
        usbKeyboardAttached := true
    else
        usbKeyboardAttached := false

    restoreClipboard()
}


#If !usbKeyboardAttached
{
     PgUp::PgDn
     PgDn::Home
     Home::PgUp
}
#if



; ====
; ==== PageUp, PageDown, Home, End

; Note: Fusion already has dedicated keys for this, but I also find useful to have these Fn shortcuts.

; PageUp = Fn + Up
sc178 & Up::PgUp

; PageDown = Fn + Down
sc178 & Down::PgDn

; Home = Fn + left
sc178 & Left::Home

; End = Fn + Right
sc178 & Right::End




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


; ====
; ==== Disable insert key
;
Insert::Return
