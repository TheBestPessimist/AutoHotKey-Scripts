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
