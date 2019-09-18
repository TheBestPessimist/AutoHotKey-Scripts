;   == Markdown Code Highlighter ==
;
; it's supposed to write this:
;```<your language>
;|<-cursor is left here, so you can just paste what you want
;```

:O:``ahk::
:O:``java::
:O:``sql::
:O:``css::
:O:``json::
:O:``js::
    MarkdownCodeHighlighter()
    {
        ; A_ThisHotkey contains ":O:`" which is not needed
        hs := SubStr(A_ThisHotkey, 5)

        if (false)
        {}
        else if (hs == "ahk")
        {
            hs := "autoit"
        } else if (hs == "js")
        {
            hs := "javascript"
        }
        Send % "``````" hs "`n`n" "``````" "{left 4}"
    }


; telegram clients are retarded and want "__" instead of "_" for italics, bold respectively.
; (ノಠ益ಠ)ノ彡┻━┻ so much for CommonMarkdown
#If WinActive(ahk_telegram)
    :OB0:__::__{left 2}
#If

:OB0:__::{left 1}
:OB0:****::{left 2}
:O:````````::```````n`n``````{left 4}             ; write 4 backticks!
:OB0:````::{left 1}
:OB0:<kbd::></kbd>{left 6}


; There is (imo) a bug in autohotkey:
; the hotstring recognizer does not reset if i do `ctrl v`
; So i need this workaround:
; Ref: https://www.autohotkey.com/boards/viewtopic.php?p=276407
~^v::Hotstring("Reset")


; emoji helper
:O::ok::
    sendOK(){
        Send % ":white_check_mark:"
    }

:O::nok::
    sendNOK(){
        Send % ":x:"
    }

:O:.tias::
    tagTias() {
        Send % "https://i.imgur.com/VkRzeQJ.png"
    }
