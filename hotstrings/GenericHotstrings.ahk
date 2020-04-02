; Reference: https://autohotkey.com/docs/Hotstrings.htm#Options
; Note: "O" deletes the ending character (the one which activates the hotstring)

; ----- @self --------------------------
:O:c@tbp::cristian@tbp.land
:O:c@gmail::cristian.nahsuc@gmail.com
:O:c@metas::cristian.pasat@metasfresh.com
:O:@tbp::TheBestPessimist



; ----- my autohotkey github -----------
::.gitahk::https://git.tbp.land/AutoHotKey-Scripts/
::.gitahkl::https://git.tbp.land/AutoHotKey-Launcher/



; ------ metasfresh --------------------
::.gitmetas::https://github.com/metasfresh/metasfresh/
::.cacher::rest/api/debug/cacheReset
::.date::
    FormatDateyyyyMMdd()
    {
        FormatTime, CurrentDate,, yyyy-MM-dd
        Send %CurrentDate%
    }
::.@date::
    DateAndUser()
    {
        Send % "- "
        FormatDateyyyyMMdd()
        Send % " - @TheBestPessimist"
    }




; ------ powershell --------------------
::.pwsh::powershell

#If WinActive("ahk_exe powershell.exe")
    ::pwshtranscript::Start-Transcript -NoClobber -OutputDirectory $(Join-Path $(Resolve-Path "~") "\Desktop\PowershellTranscripts\")
    :O:pwshtop::while($true){{}$TheCommandOutput = `; clear; echo $TheCommandOutput; Date; sleep 1{}}{left 47}
    :O:pwshfind::Get-ChildItem -Force -Recurse -Include **{left 1}
#If




; ----- Robocopy -----------------------
::.robocopy::robocopy /E /Z /R:5 /W:5 /TBD /unicode /V /XJ /ETA /MT:32       'source' 'destination'



; ---- Misc ----------------------------
::.(giggle)::__(giggle)__

::.youtried::https://chat.tbp.land/uploads/default/original/1X/ffe6c3aeef608606b00fa5587acce5bbf6d15d05.png

:O:.tias::
    tagTias() {
        Send % "https://i.imgur.com/VkRzeQJ.png"
    }

