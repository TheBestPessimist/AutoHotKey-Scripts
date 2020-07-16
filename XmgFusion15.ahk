; XMG Fusion 15 Improved keyboard shortcuts, plus Fn Lock functionality

; The Fn key has Scan Code 178


; ====
; ==== PageUp, PageDown, Home, End

; Note: Fusion already has dedicated keys for this, but I also find useful to have these Fn shortcuts.


; PageUp = Fn + Up
sc178 & Up::PgUp

; PageDown = Fn + Down
sc178 & Down::PgDn

; Home = Fn + left
sc178 & Left::Home

; End = Fn + Right
sc178 & Right::End


; ====
; ==== Disable some Fn Shortcuts which I do not like
;
; Unfortunately this cannot be done (at least i did not find a way to do it), as Fn+Fx is handled by the hardware (ie. it works without having Control Center open),
; so there's nothing that AutoHotkey can do.
;
; Disable Airplane Mode
;sc178 & F4::return
;
; Disable Touchpad Disabler
;sc178 & F5::return



; ====
; ==== Fn Lock
;
; still todo


; ====
; ==== Disable insert key
;

Insert::Return
