###################################################################################
#      print data in the .dat calculation file (instead of a classic .bas template)
proc ::Ermes::WriteCalculationFiles { filename } {

    # validate before writing the calculation files
    if { [::Ermes::ValidateData] == "-cancel-" } {
        return
    }

    # W $filename
    # C:/Users/garat/Desktop/vers2.gid/vers2.dat

    # write general information about the problem
    ::Ermes::WriteGeneralInformation $filename

    # Write nodal data
    ::Ermes::WriteNodalData $filename

    # Write Voltages applied on nodes
    ::Ermes::WriteNodalVoltages $filename

}
