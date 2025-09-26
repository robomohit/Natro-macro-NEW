; Stub implementation for nowUnix function
; Returns current Unix timestamp
nowUnix() {
    ; Get current UTC time in seconds since epoch
    return Integer(A_NowUTC)
}
