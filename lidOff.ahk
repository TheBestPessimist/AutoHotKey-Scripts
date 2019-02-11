; The purpose of this autohotkey script is to lock the V whenever the user closes the "lid" (keyboard in this case)
; This implies that in "Power Options -> Chose what closing the lid does" is selected "Do nothing"


WM_POWERBROADCAST(wparam, lparam)
{
  if (wparam = 0x8013) ;PBT_POWERSETTINGCHANGE
  {
    new_state := Numget(lparam+20, 0, "uchar")
    ;new_state = 0 = closed
    ;new_state = 1 = opened
    if(new_state = 0) {
        DllCall("LockWorkStation")
    }
  }
  return 1
}
