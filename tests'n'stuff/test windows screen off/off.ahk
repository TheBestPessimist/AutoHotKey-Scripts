; taken from here: https://autohotkey.com/boards/viewtopic.php?f=5&t=17457&hilit=GUID_CONSOLE_DISPLAY_STATE

; WM_POWERBROADCAST := 0x218
; onMessage(0x8013,"a")
; onMessage(WM_POWERBROADCAST,"a")

; a(wparam, iparam, tt, yy)
; {
;     ; MsgBox ceva
;     ToolTip % A_Hour ":" A_Min ":" A_Sec "`nwparama: " wparam "`niparam: " iparam "`ntt: " tt "`nyy: " yy
; return
; }





#persistent
#singleInstance force


; GUID_CONSOLE_DISPLAY_STATE:="6fe69556-704a-47a0-8f24-c28d936fda47" ;  although this should work for win 10, it seems that it doesnt, so we use GUID_MONITOR_POWER_ON
; GUID_MONITOR_POWER_ON:="02731015-4510-4526-99e6-e5a17ebd1aea"
; global newGUID:=""
; global screenTurnOffFirstRun := 0

; varSetCapacity(newGUID,16,0)
; if a_OSVersion in WIN_8,WIN_8.1,WIN_10
;     dllCall("Rpcrt4\UuidFromString","Str",GUID_CONSOLE_DISPLAY_STATE,"UInt",&newGUID)
; else
;     dllCall("Rpcrt4\UuidFromString","Str",GUID_MONITOR_POWER_ON,"UInt",&newGUID)
; rhandle:=dllCall("RegisterPowerSettingNotification","UInt",a_scriptHwnd,"Str",strGet(&newGUID),"Int",0)
; onMessage(0x218,"WM_POWERBROADCAST")

; WM_POWERBROADCAST(wParam,lParam) {
;     ; global screenTurnOffFirstRun
;     static PBT_POWERSETTINGCHANGE:=0x8013
;     if(wParam=PBT_POWERSETTINGCHANGE){
;         if(subStr(strGet(lParam),1,strLen(strGet(lParam))-1)=strGet(&newGUID)){
;             if (screenTurnOffFirstRun = 1) {
;                 ToolTip % A_Hour ":" A_Min ":" A_Sec "`nflag: " screenTurnOffFirstRun ;"`nwparam: " wParam "`niparam: " lParam "`nmonitorStatus: " monitorStatus
;                 ; DllCall("LockWorkStation")
;                 ;fileAppend,% "lParam Data: " numGet(lParam+0,20,"UInt") "`n`n",file.txt
;                 ; monitorStatus:=numGet(lParam+0,20,"UInt")?1:0
;             } else {
;                 screenTurnOffFirstRun := 1
;             }
;         }
;     }
;     return
; }



global  GUID_LIDSWITCH_STATE_CHANGE := "ba3e0f4d-b817-4094-a2d1-d56379e6a0f3"
global newGUID:=""

varSetCapacity(newGUID,16,0)
dllCall("Rpcrt4\UuidFromString","Str",GUID_LIDSWITCH_STATE_CHANGE,"UInt",&newGUID)
rhandle:=dllCall("RegisterPowerSettingNotification","UInt",a_scriptHwnd,"Str",strGet(&newGUID),"Int",0)
onMessage(0x218,"WM_POWERBROADCAST")

WM_POWERBROADCAST(wparam, lparam)
{
  if (wparam = 0x8013) ;PBT_POWERSETTINGCHANGE
  {
    new_state := Numget(lparam+20, 0, "uchar")
    ;new_state = 0 = closed
    ;new_state = 1 = opened
    if(new_state = 0) {
        ; FormatTime, TimeString,, HH:mm:ss
        ; global aaa := "The lid was " (new_state ? "opened" : "closed" ) " at " TimeString "`n"
        ; ToolTip % aaa
        DllCall("LockWorkStation")
    }
  }
  return 1
}



;-------------------------------------------------
; reload this script
; caps + shift + r
~CapsLock & F5::
    SetCapsLockState Off
    Reload
Return
