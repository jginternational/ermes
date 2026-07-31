proc ::Ermes::WriteNodalVoltages { filename } {

    set nodal_filename [file rootname $filename]-2.dat
    customlib::InitWriteFile $nodal_filename
    customlib::WriteString "// Voltages applied on nodes"

    set problem_mode [::Ermes::GetValueForName Problem_mode]
    if { $problem_mode == "Electrostatic" } {
        set condition_list [list "Voltage_Electrostatic"]
        set condition_formats [list {"No[%d]" "node" "id"} {".V.FixC([%e]);" "property" "Voltage"}]
        customlib::WriteNodes $condition_list $condition_formats
        customlib::EndWriteFile
    } elseif { $problem_mode == "Full_wave" } {
        set condition_list [list "Voltage_Full_wave"]
        set condition_formats [list {"No[%d]" "node" "id"} {".V.FixC([%e," "property" "Module_Voltage"} {"%e]);" "property" "Phase_Voltage"}]
        customlib::WriteNodes $condition_list $condition_formats
    }
    
    customlib::EndWriteFile
}