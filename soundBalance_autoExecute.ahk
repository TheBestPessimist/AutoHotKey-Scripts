; Windows sound controls are retarded. Yes, even in windows 10.
; You can set a custom sound balance for your speakers and the volume is adjusted proportionally. (good)
;
; The problem is that as soon as you turn the volume to 0 (you want to mute the sound for some unknown reason), that balance is reset.
;       Yes, that means that left and right speakers have the same volume when you turn the volume up again.
;
; So for example if you need 20 times a day to turn the volume to 0 (remember this can be done by accident quite easily
; since microshitsoft also fucks with the speed which it changes your volume_lower_step after 5 consecutive changes)
; then you must also, for the exact 20 times set your speaker balance AGAIN as well.
;
; I mean OMG how could I possibly want to have the balance adjustment remembered when i actually learn how to set it properly....
;
;
;
;
; FUCK YOU USER and fuck your quality of life! This is not a bug, is a feature you dumb user
;                                           -- Yours truly, microshitsoft
;
;
; References:
;   https://answers.microsoft.com/en-us/windows/forum/all/speaker-balance-resets-when-volume-is-turned-down/d3331dcb-a788-4b30-8ccf-7b4175ad76fe
;   https://answers.microsoft.com/en-us/windows/forum/windows8_1-pictures/windows-audio-balance-reset/2d850653-3721-4c36-8ca7-396a2b59b8ca
;
; Autohotkey ref: https://autohotkey.com/board/topic/21984-vista-audio-control-functions/
;
;
#include VA.ahk

; only run this on the desk PC
if (A_ComputerName = "TBP-NUC") {
    SetTimer, fixTheGoddamnVolumeBalance, 10000
}

fixTheGoddamnVolumeBalance() {
    curr_vol := VA_GetMasterVolume()

    ; a good ratio is
    ; left speaker volume = 30
    ; right speaker volume = 50
    left_speaker_ratio := 30/50

    ; Get the volume of the first and second channels.
    left_speaker := VA_GetMasterVolume(1)
    right_speaker := VA_GetMasterVolume(2)

    ; if the 2 speakers have the same volume, they must be fixed
    if (curr_vol > 1 && Abs(left_speaker-right_speaker)<0.5){
        VA_SetMasterVolume(curr_vol*left_speaker_ratio, 1)
    }
}




; SetTimer, debug, 1
debug() {
    ; Get the master volume of the default playback device.
    volume := VA_GetMasterVolume()

    ; Get the volume of the first and second channels.
    volume1 := VA_GetMasterVolume(1)
    volume2 := VA_GetMasterVolume(2)

    ; Get the master volume of a device by name.
    lineout_volume := VA_GetMasterVolume("", "Line Out")

    ; Get the master volume of the default recording device.
    recording_volume := VA_GetMasterVolume("", "capture")

    mousegetpos,x,y
    ToolTip, % "Playback volume:`t" volume
            . "`n  Channel 1:`t" volume1
            . "`n  Channel 2:`t" volume2
            . "`nLine Out volume:`t" lineout_volume
            . "`nRecording volume:`t" recording_volume
            , x+100, y+50
}









