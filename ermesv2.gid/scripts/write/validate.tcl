
proc ::Ermes::ValidateDataDo {} {
    return 0
}


proc ::Ermes::ValidateData {} {
    set err [catch { ::Ermes::ValidateDataDo } ret]
    if { $err } {       
        WarnWin [= "Error when validating data (%s)" $::errorInfo]
        return -cancel-
    }
    return $ret
}