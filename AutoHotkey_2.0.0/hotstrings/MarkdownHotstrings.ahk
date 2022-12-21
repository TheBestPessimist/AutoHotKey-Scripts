; telegram clients are retarded and want "__" instead of "_" for italics, bold respectively.
; (ノಠ益ಠ)ノ彡┻━┻ so much for CommonMarkdown
#HotIf WinActive(WinTitles.Telegram)
:OB0:__::__{left 2}
#HotIf

:OB0:__::{left 1}
:OB0:****::{left 2}
:O:````````::```````n`n``````{left 4}             ; write 4 backticks!
:OB0:````::{left 1}
:O:.kbd::<kbd></kbd>{left 6}




/*
   == Markdown Code Highlighter ==

 it's supposed to write this:
```<your language>
|<-cursor is left here, so you can just paste what you want
```
*/

:O:``pwsh::
:O:``ahk::
:O:``java::
:O:``sql::
:O:``css::
:O:``json::
:O:``js::
:O:``xml::
:O:``kt::
:O:``yaml::
MarkdownCodeHighlighter(hs)
{
    ; hs contains the full hotstring name
    hs := SubStr(hs, 5)

    if (false)
    {}
    else if (hs == "ahk")
    {
        hs := "autoit" ; using `autoit` instead of `autohotkey` because HighlightJS, the library that everyone uses had bad syntax for autohotkey
    }
    else if (hs == "js")
    {
        hs := "javascript"
    }
    else if (hs == "kt")
    {
        hs := "kotlin"
    }
    else if (hs == "pwsh")
    {
        hs := "powershell"
    }
    Send("``````" hs "`n`n" "``````" "{left 4}")
}
