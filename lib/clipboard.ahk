saveClipboard() {
    ; Try is needed because I get an error "can't open clipboard for reading" while lock screen is on
    Try {
        global __ClipboardSaved := ClipboardAll()
        A_Clipboard := ""
    }
}

restoreClipboard()
{
    Try {
        global __ClipboardSaved
        A_Clipboard := __ClipboardSaved   ; Restore Clipboard
        __ClipboardSaved := ""
    }
}
