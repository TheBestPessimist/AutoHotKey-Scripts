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

GUID_MONITOR_POWER_ON:="02731015-4510-4526-99e6-e5a17ebd1aea"
GUID_CONSOLE_DISPLAY_STATE:="6fe69556-704a-47a0-8f24-c28d936fda47"
global monitorStatus:=1
global newGUID:=""

varSetCapacity(newGUID,16,0)
if a_OSVersion in WIN_8,WIN_8.1,WIN_10
    dllCall("Rpcrt4\UuidFromString","Str",GUID_CONSOLE_DISPLAY_STATE,"UInt",&newGUID)
else
    dllCall("Rpcrt4\UuidFromString","Str",GUID_MONITOR_POWER_ON,"UInt",&newGUID)
rhandle:=dllCall("RegisterPowerSettingNotification","UInt",a_scriptHwnd,"Str",strGet(&newGUID),"Int",0)
onMessage(0x218,"WM_POWERBROADCAST")

setTimer,checkMonitor,500
return

checkMonitor:
while(!monitorStatus){
    ; ToolTip % A_Hour ":" A_Min ":" A_Sec "`nwparama: " wparam "`niparam: " iparam "`ntt: " tt "`nyy: " yy
    if(a_index=1)
        msgbox ok
    sleep 500
}
return


WM_POWERBROADCAST(wParam,lParam) {
    static PBT_POWERSETTINGCHANGE:=0x8013
    if(wParam=PBT_POWERSETTINGCHANGE){
        if(subStr(strGet(lParam),1,strLen(strGet(lParam))-1)=strGet(&newGUID)){
            ToolTip % A_Hour ":" A_Min ":" A_Sec "`nwparam: " wParam "`niparam: " lParam ; "`ntt: " tt "`nyy: " yy
            ;fileAppend,% "lParam Data: " numGet(lParam+0,20,"UInt") "`n`n",file.txt
            monitorStatus:=numGet(lParam+0,20,"UInt")?1:0
        }
    }
    return
}


;-------------------------------------------------
; reload this script
; caps + shift + r
~CapsLock & F5::
    SetCapsLockState Off
    Reload
Return
