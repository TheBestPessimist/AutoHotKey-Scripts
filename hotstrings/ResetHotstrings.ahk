/*
There is imo a bug in autohotkey:
the hotstring recognizer does not reset if i do `ctrl v`
So i need this workaround:
Ref: https://www.autohotkey.com/boards/viewtopic.php?p=276407
*/

~^v::Hotstring("Reset")
~End::Hotstring("Reset")
~Left::Hotstring("Reset")
~Right::Hotstring("Reset")
~^BackSpace::Hotstring("Reset")
~^::Hotstring("Reset")


