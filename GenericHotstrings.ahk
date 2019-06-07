; Reference: https://autohotkey.com/docs/Hotstrings.htm#Options
; Note: "O" deletes the ending character (the one which activates the hotstring)

; ----- @self --------------------------
:O:c@tbp::cristian@tbp.land
:O:c@gmail::cristian.nahsuc@gmail.com
:O:@tbp::TheBestPessimist



; ----- my autohotkey github -----------
::gitahk::https://git.tbp.land/AutoHotKey-Scripts/
::gitahkl::https://git.tbp.land/AutoHotKey-Launcher/



; ------ metasfresh --------------------
::gitmetas.::https://github.com/metasfresh/metasfresh/
::cacher.::rest/api/debug/cacheReset


; ------ powershell --------------------
::pwsh::powershell

#If WinActive("ahk_exe powershell.exe")
    ::pwshtranscript::Start-Transcript -NoClobber -OutputDirectory $(Join-Path $(Resolve-Path "~") "\Desktop\PowershellTranscripts\")
    :O:pwshtop::while($true){{}$TheCommandOutput = `; clear; echo $TheCommandOutput; Date; sleep 1{}}{left 47}
    :O:pwshfind::Get-ChildItem -Force -Recurse -Include **{left 1}
#If


; ----- You tried :^) ------------------
::youtried.::https://chat.tbp.land/uploads/default/original/1X/ffe6c3aeef608606b00fa5587acce5bbf6d15d05.png
