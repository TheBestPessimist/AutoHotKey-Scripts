saveClipboard()
{
    ; Try is needed because I get an error "can't open clipboard for reading" while lock screen is on
    Try {
        global ClipSaved := ClipboardAll
        clipboard := ""
    }
}

restoreClipboard()
{
    Try {
        global ClipSaved
        Clipboard := ClipSaved   ; Restore Clipboard
    }
}
