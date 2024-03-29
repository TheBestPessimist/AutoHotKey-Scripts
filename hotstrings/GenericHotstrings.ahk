﻿; Reference: https://autohotkey.com/docs/Hotstrings.htm#Options
; Flag explanations:
; - 0 (letter o) deletes the ending character (the one which activates the hotstring)
; - B0 (letter b and zero): Disable automatic backspacing
; - Kn: Delay between each keypress

; ----- @self --------------------------
:O:c@tbp::cristian@tbp.land
:O:c@gmail::cristian.nahsuc@gmail.com
:O:c@nagarro::cristian.pasat.ext@nagarro.com
:O:@tbp::TheBestPessimist



; ----- my autohotkey github -----------
::.gitahk::https://git.tbp.land/AutoHotKey-Scripts/
::.gitahkl::https://git.tbp.land/AutoHotKey-Launcher/


::.date:: {
    Send(FormatTime( , "yyyy-MM-dd"))
}
::.datet:: {
    Send(FormatTime(, "yyyy-MM-dd--HH-mm-ss"))
}





; todo: fix for ahk 2
;::.collapsed::
;::.hidden:: {
;text =
;( LTrim
;<details>
;<summary>Collapsed for Brevity</summary>
;
;
;
;</details>
;)
;Send, % text
;}



; ------ powershell --------------------
::.pwsh::powershell
::.pwshtranscript::Start-Transcript -NoClobber -OutputDirectory $(Join-Path $(Resolve-Path "~") "\Desktop\PowershellTranscripts\")
:O:.pwshtop::while($true){{}$TheCommandOutput = `; clear; echo $TheCommandOutput; Date; sleep 1{}}{left 47}
:O:.pwshfind::Get-ChildItem -Force -Recurse -Include **{left 1}




; ----- Robocopy -----------------------
::.robocopy::robocopy /E /Z /R:5 /W:5 /TBD /unicode /V /XJ /ETA /MT:32       'source' 'destination'



; ---- Misc ----------------------------
::.giggle::__(giggle)__

::.youtried::https://discourse.tbp.land/uploads/default/original/1X/ffe6c3aeef608606b00fa5587acce5bbf6d15d05.png

:O:.tias::https://discourse.tbp.land/uploads/default/original/1X/e741730b2b41b7ecd3672f986951038ca43af531.jpeg
