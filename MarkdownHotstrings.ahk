;   == Markdown Code Highlighter ==
;
; it's supposed to write this:
;```<your language>
;|<-cursor is left here, so you can just paste what you want
;```

:O:``ahk::
:O:``java::
:O:``sql::
    MarkdownCodeHighlighter()
    {
        ;A_ThisHotkey contains ":O:`" which is not needed
        hs := SubStr(A_ThisHotkey, 5)
        Send % "``````" hs "`n`n" "``````" "{left 4}"
        ; ``````autoit`n`n``````{left 4}
    }


; telegram clients are retarded and want "__" instead of "_" for italics, bold respectively.
; (ノಠ益ಠ)ノ彡┻━┻ so much for CommonMarkdown
#If WinActive(ahk_telegram)
    :O:__::____{left 2}
    :O:**::****{left 2}
#If

:O:__::__{left 1}
:O:**::**{left 1}
:O:``````::```````n`n``````{left 4}
:O:````::````{left 1}
