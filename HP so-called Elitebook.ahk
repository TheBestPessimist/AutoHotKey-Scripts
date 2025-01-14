/*
I have a HP so-called "Elitebook" laptop which has the Home, End, PgUp, PgDn keys in a retarded order.
I swear to fucking god, whoever designs these keyboards are fucking retards who never use them.

So here I come, trying to fix their fucking shit, yet again.

Initial order: Home, PgUp, PgDown, End (like, WTF Intel?)
Correct order: PgUp, PgDown, Home, End (duuuh)

WHY MAKE ME JUMP OVER 3 KEYS FOR HOME-END????? BRAH!?!?! WHY???
*/



#HotIf A_ComputerName = "RO-5CG3260MPX"
Home::PgUp
PgUp::PgDn
PgDn::Home
; End::End
#HotIf
