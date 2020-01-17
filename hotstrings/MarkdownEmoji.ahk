; Emoji helper
;
; I have created this, because some emoji names don't make much sense to me.
; The hotstrings should be written as ":ok<space>", or ":!<space" and they will be expanded.
; ";" is used to trigger the emoji as I want to reflect that this is an emoji.

:O::ok::
    sendOK() {
        Send % ":white_check_mark:"
    }

:O::nok::
    sendNOK() {
        Send % ":x:"
    }

:O::!::
    sendExclamation() {
        Send % ":exclamation:"
    }

:O::deny::
    sendDenied() {
        Send % ":no_entry_sign:"
    }
