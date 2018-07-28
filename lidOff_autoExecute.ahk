; change this to the one gotten from running "hostname" in cmd
global hostname := "TBP-V"


; DO NOT CHANGE ANYTHING ELSE!!!!!!!!!
global GUID_LIDSWITCH_STATE_CHANGE := "ba3e0f4d-b817-4094-a2d1-d56379e6a0f3"
global newGUID:=""

; convert string to windows GUID then register for Power Notification Changes
if (A_ComputerName = hostname) {
    varSetCapacity(newGUID,16,0)
    dllCall("Rpcrt4\UuidFromString","Str",GUID_LIDSWITCH_STATE_CHANGE,"UInt",&newGUID)
    rhandle:=dllCall("RegisterPowerSettingNotification","UInt",a_scriptHwnd,"Str",strGet(&newGUID),"Int",0)
    onMessage(0x218,"WM_POWERBROADCAST")
}
