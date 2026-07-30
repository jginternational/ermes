
proc ::Ermes::WriteGeneralInformation { filename } {

    customlib::InitWriteFile $filename

    customlib::WriteString "// Problem settings"

#######################  Problem settings  ###################################
    set problem_mode [::Ermes::GetValueForName Problem_mode]
    ::Ermes::WriteGeneralVariable Problem_mode

    if { $problem_mode == "Full_wave" } {
        set symmetry [::Ermes::GetValueForName Symmetry]
        set symmetry_value "Exyz_3D"
        if { $symmetry == "XY" } {
            set symmetry_value "Exy_3D"
        } elseif { $symmetry == "ZZ" } {
            set symmetry_value "Ez_3D"
        } elseif { $symmetry == "AY" } {
            set symmetry_value "Exz_2D"
        } 
        ::Ermes::WriteGeneralVariable Symmetry $symmetry_value
    } 

#######################  GiD geometric tolerance  ############################
    set geo_error_tolerance [::Ermes::GetValueForName Geo_error_tol]
    if { $geo_error_tolerance == "0.0" } {
        set geo_error_tolerance_value GeoTol_0
    } elseif { $geo_error_tolerance == "1e-1" } {
        set geo_error_tolerance_value GeoTol_1
    } elseif { $geo_error_tolerance == "1e-2" } {
        set geo_error_tolerance_value GeoTol_1em2
    } elseif { $geo_error_tolerance == "1e-3" } {
        set geo_error_tolerance_value GeoTol_1em3
    } elseif { $geo_error_tolerance == "1e-4" } {
        set geo_error_tolerance_value GeoTol_1em4
    } elseif { $geo_error_tolerance == "1e-5" } {
        set geo_error_tolerance_value GeoTol_1em5
    } elseif { $geo_error_tolerance == "1e-6" } {
        set geo_error_tolerance_value GeoTol_1em6
    } elseif { $geo_error_tolerance == "1e-7" } {
        set geo_error_tolerance_value GeoTol_1em7
    } elseif { $geo_error_tolerance == "1e-8" } {
        set geo_error_tolerance_value GeoTol_1em8
    } elseif { $geo_error_tolerance == "1e-9" } {
        set geo_error_tolerance_value GeoTol_1em9
    } elseif { $geo_error_tolerance == "1e-10" } {
        set geo_error_tolerance_value GeoTol_1em10
    } elseif { $geo_error_tolerance == "1e-11" } {
        set geo_error_tolerance_value GeoTol_1em11
    } elseif { $geo_error_tolerance == "1e-12" } {
        set geo_error_tolerance_value GeoTol_1em12
    }

    ::Ermes::WriteGeneralVariable Geo_error_tol $geo_error_tolerance_value

##################  Periodic boundary condition type  ########################
    set pbc_symmetry [::Ermes::GetValueForName PBC_symmetry]
    if { $pbc_symmetry == "Cyclic" } {
        ::Ermes::WriteGeneralVariable PBC_symmetry "PBC_Cyclic"
    } elseif { $pbc_symmetry == "Periodic" } {
        ::Ermes::WriteGeneralVariable PBC_symmetry "PBC_Periodic"
    }

##########################  Solution mode  ###################################
    set solving_mode [::Ermes::GetValueForName Solving_mode]
    if { $solving_mode == "Release" } {
        ::Ermes::WriteGeneralVariable ProblemType "Release_Mode"
    } elseif { $solving_mode == "Debug" } {
        ::Ermes::WriteGeneralVariable ProblemType "Debug_Mode"
    } elseif { $solving_mode == "Read" } {
        ::Ermes::WriteGeneralVariable ProblemType "Read_Mode"
    }

######################  Element type and order  ##############################
    ::Ermes::WriteGeneralVariable Element_type

####################  E-fields or AV-potentials  #############################
    set potentials [::Ermes::GetValueForName Potentials]
    if { $potentials == "On" } {
        ::Ermes::WriteGeneralVariable Potentials "Potentials_On"
    } elseif { $potentials == "Off" } {
        ::Ermes::WriteGeneralVariable Potentials "Potentials_Off"
    }


    customlib::EndWriteFile 
}

proc ::Ermes::WriteGeneralVariable {name {value ""}} {
    
    if { $value == "" } {
        set value [::Ermes::GetValueForName $name]
    }
    customlib::WriteString "ProblemType = $value;"
}