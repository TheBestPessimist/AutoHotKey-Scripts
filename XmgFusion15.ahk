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
    static autoExecute := XmgFusion15AutoExecute()

    changeKeyOrder()
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
changeKeyOrder()
{
    AHI := new AutoHotInterception()
    Fusion15KeyboardId := AHI.GetKeyboardIdFromHandle("ACPI\VEN_MSFT&DEV_0001", 1)

    AHI.SubscribeKey(Fusion15KeyboardId, GetKeySC("PgUp"), true, Func("XmgKeyEventHandler").Bind("PgDn"))
    AHI.SubscribeKey(Fusion15KeyboardId, GetKeySC("PgDn"), true, Func("XmgKeyEventHandler").Bind("Home"))
    AHI.SubscribeKey(Fusion15KeyboardId, GetKeySC("Home"), true, Func("XmgKeyEventHandler").Bind("PgUp"))

    Tippy("inside changeKeyOrder")
}

XmgKeyEventHandler(newKey, state)
{
    if(state)
        Send % "{Blind}{" newKey " down}"
    else
        Send % "{Blind}{" newKey " up}"
}





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
; ==== Fn Lock
;
; still todo


; ====
; ==== Disable insert key
;

Insert::Return



