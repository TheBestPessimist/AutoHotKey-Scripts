; Reference: https://autohotkey.com/docs/Hotstrings.htm#Options
; ----- @self ----------------
::c@tbp::cristian@tbp.land
::c@gmail::cristian.nahsuc@gmail.com
::@tbp::TheBestPessimist

; ----- autohotkey highlighter ---------
; it's supposed to write this:
;```autoit
;|<-cursor is left here
;```
; Note: "O" deletes the ending character (the one which activates the hotstring)
:O:``ahk::``````autoit`n`n``````{left 4}

; ----- my autohotkey github -----------
::gitahk::https://git.tbp.land/AutoHotKey-Scripts/
::gitahkl::https://git.tbp.land/AutoHotKey-Launcher/


; ------ powershell -------------------

::pwsh::powershell

#If WinActive("ahk_exe powershell.exe")
    ::pwshtranscript::Start-Transcript -NoClobber -OutputDirectory $(Join-Path $(Resolve-Path "~") "\Desktop\PowershellTranscripts\")
    :O:pwshtop::while($true){{}$TheCommandOutput = `; clear; echo $TheCommandOutput; Date; sleep 1{}}{left 47}
    :O:pwshfind::Get-ChildItem -Force -Recurse -Include **{left 1}
#If
