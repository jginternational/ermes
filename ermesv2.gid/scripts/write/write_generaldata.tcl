
proc ::Ermes::WriteGeneralInformation { filename } {

    customlib::InitWriteFile $filename

    customlib::WriteString "// Problem settings"

#######################  Problem settings  ###################################
    set problem_mode [::Ermes::GetValueForName Problem_mode]
    switch -- $problem_mode {
        Full_wave {
            ::Ermes::WriteGeneralVariable Problem_mode Full_Wave

            set symmetry [::Ermes::GetValueForName Symmetry]
            switch -- $symmetry {
                3D { ::Ermes::WriteGeneralVariable Symmetry Exyz_3D }
                XY { ::Ermes::WriteGeneralVariable Symmetry Exy_3D }
                ZZ { ::Ermes::WriteGeneralVariable Symmetry Ez_3D }
                AY { ::Ermes::WriteGeneralVariable Symmetry Ea_3D }
            }
        }
        Cold_plasma { ::Ermes::WriteGeneralVariable Problem_mode Cold_Plasma }
        Electrostatic { ::Ermes::WriteGeneralVariable Problem_mode Electrostatic }
    }

#######################  GiD geometric tolerance  ############################
    set geo_error_tolerance [::Ermes::GetValueForName Geo_error_tol]
    switch -- $geo_error_tolerance {
        0.0 { set geo_error_tolerance_value GeoTol_0 }
        1e-1 { set geo_error_tolerance_value GeoTol_1 }
        1e-2 { set geo_error_tolerance_value GeoTol_1em2 }
        1e-3 { set geo_error_tolerance_value GeoTol_1em3 }
        1e-4 { set geo_error_tolerance_value GeoTol_1em4 }
        1e-5 { set geo_error_tolerance_value GeoTol_1em5 }
        1e-6 { set geo_error_tolerance_value GeoTol_1em6 }
        1e-7 { set geo_error_tolerance_value GeoTol_1em7 }
        1e-8 { set geo_error_tolerance_value GeoTol_1em8 }
        1e-9 { set geo_error_tolerance_value GeoTol_1em9 }
        1e-10 { set geo_error_tolerance_value GeoTol_1em10 }
        1e-11 { set geo_error_tolerance_value GeoTol_1em11 }
        1e-12 { set geo_error_tolerance_value GeoTol_1em12 }
    }
    ::Ermes::WriteGeneralVariable Geo_error_tol $geo_error_tolerance_value

##################  Periodic boundary condition type  ########################
    set pbc_symmetry [::Ermes::GetValueForName PBC_symmetry]
    switch -- $pbc_symmetry {
        Cyclic { ::Ermes::WriteGeneralVariable PBC_symmetry PBC_Cyclic }
        Periodic { ::Ermes::WriteGeneralVariable PBC_symmetry PBC_Periodic }
    }

##########################  Solution mode  ###################################
    set sweep_frequency_mode [::Ermes::GetValueForName Sweep_frequency_mode]
    set solving_mode [::Ermes::GetValueForName Solving_mode]
    if { $sweep_frequency_mode == "1" || $solving_mode == "Release" } {
        ::Ermes::WriteGeneralVariable ProblemType Release_Mode
    } elseif { $solving_mode == "Debug" } {
        ::Ermes::WriteGeneralVariable ProblemType Debug_Mode
    } elseif { $solving_mode == "Read" } {
        ::Ermes::WriteGeneralVariable ProblemType Read_Mode
    }

######################  Element type and order  ##############################
    set element_type [::Ermes::GetValueForName Element_type]
    ::Ermes::WriteGeneralVariable Element_type $element_type

####################  E-fields or AV-potentials  #############################
    set potentials [::Ermes::GetValueForName Potentials]
    switch -- $potentials {
        On { ::Ermes::WriteGeneralVariable Potentials Potentials_On }
        Off { ::Ermes::WriteGeneralVariable Potentials Potentials_Off }
    }

################  AV continuity on contact surfaces  ##########################
    set av_continuity [::Ermes::GetValueForName AV_continuity]
    switch -- $av_continuity {
        On { ::Ermes::WriteGeneralVariable AV_continuity AV_Continuity_On }
        Off { ::Ermes::WriteGeneralVariable AV_continuity AV_Continuity_Off }
    }

####################  Visualization points  ##################################
    set results_mode [::Ermes::GetValueForName Results_mode]
    switch -- $results_mode {
        Nodes { ::Ermes::WriteGeneralVariable Results_mode Results_On_Nodes }
        GP_1 { ::Ermes::WriteGeneralVariable Results_mode Results_On_1GP }
        GP_4 { ::Ermes::WriteGeneralVariable Results_mode Results_On_4GP }
    }

#################  LL2P smoothing on results  ################################
    set ll2p_smooth [::Ermes::GetValueForName LL2P_smooth]
    if { $ll2p_smooth == "On" } {
        ::Ermes::WriteGeneralVariable LL2P_smooth LL2P_Smoothing_On
    } else {
        ::Ermes::WriteGeneralVariable LL2P_smooth LL2P_Smoothing_Off
    }

################  Type of surface normal averaging  ##########################
    set normals_type [::Ermes::GetValueForName Normals_type]
    switch -- $normals_type {
        Geometric_average { ::Ermes::WriteGeneralVariable Normals_type Geometric_Average_Normals }
        Area_weighted { ::Ermes::WriteGeneralVariable Normals_type Area_Weighted_Normals }
    }

#######################  RME stabilization  #################################
    set rme_stabilize [::Ermes::GetValueForName RME_stabilize]
    switch -- $rme_stabilize {
        On { ::Ermes::WriteGeneralVariable RME_stabilize RMED_Stab_On }
        Off { ::Ermes::WriteGeneralVariable RME_stabilize RMED_Stab_Off }
    }

#######################  EDG stabilization  ##################################
    set edg_stabilize [::Ermes::GetValueForName EDG_stabilize]
    switch -- $edg_stabilize {
        On { ::Ermes::WriteGeneralVariable EDG_stabilize EDGE_Stab_On }
        Off { ::Ermes::WriteGeneralVariable EDG_stabilize EDGE_Stab_Off }
    }

#######################  LL2P stabilization  #################################
    set ll2p_stabilize [::Ermes::GetValueForName LL2P_stabilize]
    switch -- $ll2p_stabilize {
        On { ::Ermes::WriteGeneralVariable LL2P_stabilize LL2P_Stab_On }
        Off { ::Ermes::WriteGeneralVariable LL2P_stabilize LL2P_Stab_Off }
    }

#################  Iterative solver initial guess  ###########################
    set initial_guess [::Ermes::GetValueForName Initial_guess]
    switch -- $initial_guess {
        Read_file { ::Ermes::WriteGeneralVariable Initial_guess Read_Guess_On }
        Nil_vector { ::Ermes::WriteGeneralVariable Initial_guess Read_Guess_Off }
    }

##################  Write solution vector on file  ###########################
    set results_in_file [::Ermes::GetValueForName Results_in_file]
    switch -- $results_in_file {
        No { ::Ermes::WriteGeneralVariable Results_in_file Write_Solution_Off }
        Every_step { ::Ermes::WriteGeneralVariable Results_in_file Write_Solution_Steps }
        Final_step { ::Ermes::WriteGeneralVariable Results_in_file Write_Solution_Final }
    }

###################  Import Robin flux from files  ###########################
    set import_robin_flux [::Ermes::GetValueForName Import_Robin_flux]
    if { $import_robin_flux == "On" } {
        ::Ermes::WriteGeneralVariable Import_Robin_flux Import_Robin_On
    } else {
        ::Ermes::WriteGeneralVariable Import_Robin_flux Import_Robin_Off
    }

###################  Import J currents from files  ###########################
    set import_j_currents [::Ermes::GetValueForName Import_J_currents]
    if { $import_j_currents == "On" } {
        ::Ermes::WriteGeneralVariable Import_J_currents Import_J_On
    } else {
        ::Ermes::WriteGeneralVariable Import_J_currents Import_J_Off
    }

############  Import volumetric element matrices from files  #################
    set import_ele_matrix [::Ermes::GetValueForName Import_ele_matrix]
    if { $import_ele_matrix == "On" } {
        ::Ermes::WriteGeneralVariable Import_ele_matrix Import_VEM_On
    } else {
        ::Ermes::WriteGeneralVariable Import_ele_matrix Import_VEM_Off
    }

####################  Write results fields on files  #########################
    set export_fields [::Ermes::GetValueForName Export_fields]
    if { $export_fields == "On" } {
        ::Ermes::WriteGeneralVariable Export_fields Export_Fields_On
    } else {
        ::Ermes::WriteGeneralVariable Export_fields Export_Fields_Off
    }

##########################  Output file format  ##############################
    set output_format [::Ermes::GetValueForName Output_format]
    if { $output_format == "Ascii" } {
        ::Ermes::WriteGeneralVariable Output_format Results_Format_Ascii
    } else {
        ::Ermes::WriteGeneralVariable Output_format Results_Format_Binary
    }

######################  Number of parallel procesess  ########################
    set processors [::Ermes::GetValueForName Processors]
    ::Ermes::WriteGeneralVariable Processors "${processors}pr"

############################  Problem frequency  #############################
    if { $sweep_frequency_mode == "0" } {
        set complex_frequency_mode [::Ermes::GetValueForName Complex_frequency_mode]
        if { $complex_frequency_mode == "1" && $problem_mode == "Full_wave" } {
            ::Ermes::WriteGeneralVariable Complex_frequency_mode Load_Complex_Frequency
        } else {
            ::Ermes::WriteGeneralVariable Complex_frequency_mode Load_Angular_Frequency
        }
    } else {
        set two_pi 6.283185307179586476925286766559
        set initial_frequency [::Ermes::GetValueForName Initial_frequency]
        set final_frequency [::Ermes::GetValueForName Final_frequency]
        set step_frequency [::Ermes::GetValueForName Step_frequency]
        set initial_angular_frequency [format "%.18f" [expr {$initial_frequency * $two_pi}]]
        set final_angular_frequency [format "%.18f" [expr {$final_frequency * $two_pi}]]
        set step_angular_frequency [format "%.18f" [expr {$step_frequency * $two_pi}]]
        customlib::WriteString "SweepFrequency = vTow($initial_angular_frequency,$final_angular_frequency,$step_angular_frequency);"
    }

    customlib::WriteString ""
    customlib::WriteString "// Check settings consistency"
    ::Ermes::WriteGeneralVariable ProblemType Check_Consistency

    customlib::WriteString ""
    customlib::WriteString "// Read list of nodes"
    ::Ermes::WriteGeneralVariable ProblemType Read_Nodes_ID_Coord

    customlib::WriteString ""
    customlib::WriteString "// Read material properties"
    ::Ermes::WriteGeneralVariable ProblemType Read_Material_Properties

    if { $problem_mode == "Full_wave" || $problem_mode == "Cold_plasma" } {
        if { $problem_mode == "Cold_plasma" } {
            customlib::WriteString ""
            customlib::WriteString "// Read plasma parameters"
            ::Ermes::WriteGeneralVariable ProblemType Load_Cold_Plasma_Parameters
        }

        customlib::WriteString ""
        customlib::WriteString "// Read plane waves parameters"
        ::Ermes::WriteGeneralVariable ProblemType Load_Plane_Waves_Parameters

        customlib::WriteString ""
        customlib::WriteString "// Create high order nodes"
        ::Ermes::WriteGeneralVariable ProblemType Create_High_Order_Nodes

        customlib::WriteString ""
        customlib::WriteString "// Make contact elements"
        set contact_detect [::Ermes::GetValueForName Contact_detect]
        switch -- $contact_detect {
            Manual { ::Ermes::WriteGeneralVariable Contact_detect Make_Contact }
            Ignore { ::Ermes::WriteGeneralVariable Contact_detect Ignr_Contact }
        }

        customlib::WriteString ""
        customlib::WriteString "// Impose periodic boundary conditions "
        ::Ermes::WriteGeneralVariable ProblemType Impose_PBC

        customlib::WriteString ""
        customlib::WriteString "// Read PEC, PMC and TEC elements"
        ::Ermes::WriteGeneralVariable ProblemType Read_Dirichlet_Elements

        if { $problem_mode == "Cold_plasma" } {
            customlib::WriteString ""
            customlib::WriteString "// Set E parallel to zero"
            ::Ermes::WriteGeneralVariable ProblemType Set_E_Parallel_ToZero
        }

        customlib::WriteString ""
        customlib::WriteString "// Read singular nodes list"
        ::Ermes::WriteGeneralVariable ProblemType Read_Nodes_Singular

        customlib::WriteString ""
        customlib::WriteString "// Set un-gauged layers"
        foreach singularity_layer {2 3 4 5 6} {
            ::Ermes::WriteGeneralVariable ProblemType "Find_Sing_${singularity_layer}L"
        }

        if { $element_type == "LL2P_3sb" } {
            customlib::WriteString ""
            customlib::WriteString "// Collapse bubbles on un-gauged layers"
            ::Ermes::WriteGeneralVariable ProblemType Collapse_Bubbles

            set ll2p_keep_div [::Ermes::GetValueForName LL2P_keep_div]
            if { $ll2p_keep_div == "On" } {
                ::Ermes::WriteGeneralVariable ProblemType Clear_Singularities
            }
        }
    }

    customlib::WriteString ""
    customlib::WriteString "// Read voltages on nodes "
    ::Ermes::WriteGeneralVariable ProblemType Read_Nodes_Voltages

    customlib::WriteString ""
    customlib::WriteString "// Initialize building "
    customlib::WriteString "ElementsGroup = Electromagnetic_Group;"

    if { $solving_mode == "Debug" } {
        customlib::WriteString ""
        customlib::WriteString "// Print mesh"
        ::Ermes::WriteGeneralVariable ProblemType Print_High_Order_Mesh

        customlib::WriteString ""
        customlib::WriteString "// Print \"Debug\" mode results"
        customlib::WriteString "CalculateNodal(BOUNDARY_NORMALS);"
        customlib::WriteString "PrintOnNodes(BOUNDARY_NORMALS);"
        customlib::WriteString "CalculateNodal(CONTACT_NORMALS);"
        customlib::WriteString "PrintOnNodes(CONTACT_NORMALS);"

        if { $problem_mode == "Cold_plasma" } {
            ::Ermes::WriteGeneralVariable ProblemType Show_All_Plasma_Parameters
        }

        customlib::WriteString ""
        customlib::WriteString "// End \"Debug\" mode"
        ::Ermes::WriteGeneralVariable ProblemType End_Debug_Mode
    } else {
        customlib::WriteString ""
        customlib::WriteString "// Build linear system and solve"
        if { $sweep_frequency_mode == "1" || $solving_mode != "Read" } {
            ::Ermes::WriteGeneralVariable ProblemType Build
        } else {
            ::Ermes::WriteGeneralVariable ProblemType Read_Solve_Print_File
        }
    }

    customlib::EndWriteFile
}

proc ::Ermes::WriteGeneralVariable {name {value ""}} {
    
    if { $value == "" } {
        set value [::Ermes::GetValueForName $name]
    }
    customlib::WriteString "ProblemType = $value;"
}
