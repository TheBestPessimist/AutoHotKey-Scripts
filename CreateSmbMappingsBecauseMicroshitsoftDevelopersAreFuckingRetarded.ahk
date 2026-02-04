CreateSmbMappingsBecauseMicroshitsoftDevelopersAreFuckingRetardedAutoExecute()

CreateSmbMappingsBecauseMicroshitsoftDevelopersAreFuckingRetardedAutoExecute()
{
    SetTimer(CreateSmbMappingsBecauseMicroshitsoftDevelopersAreFuckingRetarded, -2000)
}

; After reinstalling windows (25H2, from 24H2), Windows became even MORE fucking retarded than usual, and does not automatically reconnect my network shares
; They are fucking there in Explorer, but they show the ❌ (disconnected) icon, and i have to manually open each one of them (ie double click on them).
;
; Obviously, this was supposed to be fixed, but Microshitsoft is just too retarded to fix it, so they give us this garbage workaround: https://learn.microsoft.com/en-us/troubleshoot/windows-client/networking/mapped-network-drive-fail-reconnect
;
; FUCK THIS FUCKING GARBAGE joke of a fucking operating system, Microshitsoft.
; Fuck your fucking Copilot crap.
; Fuck whoever broke this, and whoever the fuck tested and approved this fucking garbage. I wish them all diarrhea 3 days a week.
CreateSmbMappingsBecauseMicroshitsoftDevelopersAreFuckingRetarded()
{
    Run('pwsh -WindowStyle Hidden -Command "'
        . "Remove-SmbMapping -LocalPath 'P:' -Force -ErrorAction SilentlyContinue; "
        . "Remove-SmbMapping -LocalPath 'T:' -Force -ErrorAction SilentlyContinue; "
        . "Remove-SmbMapping -LocalPath 'W:' -Force -ErrorAction SilentlyContinue; "
        . "New-SmbMapping -Persistent `$true -LocalPath 'P:' -RemotePath '\\tbp-nuc\patrunjel\Patrunjel\Patrunjel'; "
        . "New-SmbMapping -Persistent `$true -LocalPath 'T:' -RemotePath '\\tbp-nuc\torrentz'; "
        . "New-SmbMapping -Persistent `$true -LocalPath 'W:' -RemotePath '\\tbp-nuc\tbp'; "
        . '"',, "Hide")
}
