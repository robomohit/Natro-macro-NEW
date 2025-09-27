; Debug logging utility for Natro Macro
; This file provides functions to log errors and debug information

global debugLogFile := A_ScriptDir "\..\debug.log"
global debugEnabled := true

; Initialize debug logging
nm_InitDebug() {
    try {
        ; Create debug log file if it doesn't exist
        if !FileExist(debugLogFile)
            FileAppend "=== Natro Macro Debug Log - " FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss") " ===`n", debugLogFile
    } catch {
        ; Silent fail if we can't create the log file
    }
}

; Log a message to the debug file
nm_Log(message, level := "INFO") {
    if !debugEnabled
        return

    try {
        timestamp := FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss")
        logLine := Format("[{}] [{}] {}`n", timestamp, level, message)
        FileAppend logLine, debugLogFile
    } catch {
        ; Silent fail if logging fails
    }
}

; Log an error with stack trace
nm_LogError(message, error := "") {
    nm_Log("ERROR: " message, "ERROR")
    if error {
        nm_Log("Error details: " error.Message, "ERROR")
        nm_Log("Error file: " error.File ":" error.Line, "ERROR")
    }
}

; Log function calls for debugging
nm_LogCall(functionName, params := "") {
    if !debugEnabled
        return

    nm_Log("CALL: " functionName (params ? " with params: " params : ""), "DEBUG")
}
