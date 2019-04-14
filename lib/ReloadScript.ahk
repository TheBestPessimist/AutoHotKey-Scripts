;-------------------------------------------------
; reload all ahk scripts via CapsLock and F5
; What i'm doing is sending a windows message to all the ahk programs running.
; The message is called WM_COMMAND. It is, internally in Windows, defined as the number 0x111.
; Ref: https://www.autohotkey.com/docs/misc/SendMessageList.htm
; I am sending the message 0x111 with the wParam 65303
; That wParam is what ahk interprets are "Reload"
CapsLock & F5::
ReloadAllAhkScripts() {
    DetectHiddenWindows, On
    SetTitleMatchMode, 2

    WinGet, allAhkExe, List, ahk_class AutoHotkey
    Loop, % allAhkExe {
        hwnd := allAhkExe%A_Index%

        if (hwnd = A_ScriptHwnd)  ; ignore the current window for reloading
        {
            continue
        }

        PostMessage, 0x111, 65303,,, % "ahk_id" . hwnd
    }
    Reload
}
