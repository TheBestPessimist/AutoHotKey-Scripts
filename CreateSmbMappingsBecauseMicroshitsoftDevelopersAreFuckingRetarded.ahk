; There is no need for a standard ahk auto-execute area anymore because of this method.
; This method is called automatically when the static variable autoExecute is instantiated,
; and since it's a static, it will only be instantiated once!
;
; Idea provided by @nnnik#6686 on the AHK Discord Server: https://discord.gg/s3Fqygv
CreateSmbMappingsBecauseMicroshitsoftDevelopersAreFuckingRetardedAutoExecute()
{
    static autoExecute := CreateSmbMappingsBecauseMicroshitsoftDevelopersAreFuckingRetardedAutoExecute()

    SetTimer(CreateSmbMappingsBecauseMicroshitsoftDevelopersAreFuckingRetarded, -2000)
}

; After reinstalling windows (25H2, from 24H2), Windows became even MORE fucking retarded than usual, and does not automatically reconnect my network shares
; They are fucking there in Explorer, but they show the ❌ (disconnected) icon, and i have to manually open each one of them (ie double click on them).
;
; Obviously, this was supposed to be fixed, but Microshitsoft is just too retarded to fix it, so they give us this garbage workaround: https://learn.microsoft.com/en-us/troubleshoot/windows-client/networking/mapped-network-drive-fail-reconnect
;
; FUCK THIS FUCKING GARBAGE joke of a fucking operating system, Microshitsoft.
; Fuck your fucking Copilot crap.
; Fuck whoever broke this, and whoever the fuck tested and approved this fucking garbage. I wish them all dihareea 3 days a week.
CreateSmbMappingsBecauseMicroshitsoftDevelopersAreFuckingRetarded()
{
    Run('powershell.exe -WindowStyle Hidden -Command "'
        . "New-SmbMapping -Persistent `$true -LocalPath 'P:' -RemotePath '\\tbp-nuc\patrunjel\Patrunjel\Patrunjel'; "
        . "New-SmbMapping -Persistent `$true -LocalPath 'T:' -RemotePath '\\tbp-nuc\torrentz'; "
        . "New-SmbMapping -Persistent `$true -LocalPath 'W:' -RemotePath '\\tbp-nuc\tbp'"
        . '"',, "Hide")
}
