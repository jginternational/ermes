#################################################
#      GiD-Tcl procedures invoked by GiD        #
#################################################
proc GiD_Event_InitProblemtype { dir } {
    Ermes::SetDir $dir ;#store to use it later
    Ermes::ModifyMenus
    gid_groups_conds::open_conditions menu
    Ermes::CreateWindow  ;#create a window as Tcl example (random surface creation)       
}

proc GiD_Event_ChangedLanguage { language } {
    Ermes::ModifyMenus ;#to customize again the menu re-created for the new language
}
 
proc GiD_Event_AfterWriteCalculationFile { filename errorflag } {   
    if { ![info exists gid_groups_conds::doc] } {
        WarnWin [= "Error: data not OK"]
        return
    }    
    set err [catch { Ermes::WriteCalculationFile $filename } ret]
    if { $err } {       
        WarnWin [= "Error when preparing data for analysis (%s)" $::errorInfo]
        set ret -cancel-
    }
    return $ret
}

#################################################
#      namespace implementing procedures        #
#################################################
namespace eval Ermes { 
    variable problemtype_dir 
}

proc Ermes::SetDir { dir } {  
    variable problemtype_dir
    set problemtype_dir $dir
}

proc Ermes::GetDir { } {  
    variable problemtype_dir
    return $problemtype_dir
}

proc Ermes::ModifyMenus { } {   
    if { [GidUtils::IsTkDisabled] } {  
        return
    }          
    foreach menu_name {Conditions Interval "Interval Data" "Local axes"} {
        GidChangeDataLabel $menu_name ""
    }       
    GidAddUserDataOptions --- 1    
    GidAddUserDataOptions [= "Data tree"] [list GidUtils::ToggleWindow CUSTOMLIB] 2
    set x_path {/*/container[@n="Properties"]/container[@n="materials"]}
    GidAddUserDataOptions [= "Import/export materials"] [list gid_groups_conds::import_export_materials .gid $x_path] 3
    GiDMenu::UpdateMenus
}


###################################################################################
#      print data in the .dat calculation file (instead of a classic .bas template)
proc Ermes::WriteCalculationFile { filename } {
    customlib::InitWriteFile $filename
    set elements_conditions [list "Shells"]
    # This instruction is mandatory for using materials
    customlib::InitMaterials $elements_conditions active
    customlib::WriteString "=================================================================="
    customlib::WriteString "                        General Data File"    
    customlib::WriteString "=================================================================="
    customlib::WriteString "Units:"
    customlib::WriteString "length [gid_groups_conds::give_active_unit L] mass [gid_groups_conds::give_active_unit M]"
    customlib::WriteString "Number of elements and nodes:"
    customlib::WriteString "[GiD_Info Mesh NumElements] [GiD_Info Mesh NumNodes]"    
    customlib::WriteString ""
    customlib::WriteString "................................................................."    
    #################### COORDINATES ############################ 
    set units_mesh [gid_groups_conds::give_mesh_unit]
    customlib::WriteString ""
    customlib::WriteString "Coordinates:"
    customlib::WriteString "  Node        X $units_mesh               Y $units_mesh"
    # Write all nodes of the model, and it's coordinates
    # Check documentation to write nodes from an specific condition
    
    # 2D case
    customlib::WriteCoordinates "%5d %14.5e %14.5e%.0s\n"
    # Example for 3D case
    #customlib::WriteCoordinates "%5d %14.5e %14.5e %14.5e\n"
    #################### CONNECTIVITIES ############################    
    customlib::WriteString ""
    customlib::WriteString "................................................................."
    customlib::WriteString ""
    customlib::WriteString "Connectivities:"
    customlib::WriteString "    Element    Node(1)   Node(2)   Node(3)     Material"
    set element_formats [list {"%10d" "element" "id"} {"%10d" "element" "connectivities"} {"%10d" "material" "MID"}]
    customlib::WriteConnectivities $elements_conditions $element_formats active 
    #################### MATERIALS ############################
    set num_materials [customlib::GetNumberOfMaterials used]
    customlib::WriteString ""
    customlib::WriteString "................................................................."
    customlib::WriteString ""
    customlib::WriteString "Materials:"
    customlib::WriteString $num_materials
    customlib::WriteString "Material      Surface density [gid_groups_conds::give_active_unit M/L^2]"
    customlib::WriteMaterials [list {"%4d" "material" "MID"} {"%13.5e" "material" "Density"}] used active
    #################### CONCENTRATE WEIGHTS ############################
    customlib::WriteString ""
    customlib::WriteString "................................................................."
    customlib::WriteString ""
    set condition_list [list "Point_Weight"]
    set condition_formats [list {"%1d" "node" "id"} {"%13.5e" "property" "Weight"}]
    set number_of_conditions [customlib::GetNumberOfNodes $condition_list]
    customlib::WriteString "Concentrate Weights:"
    customlib::WriteString $number_of_conditions
    customlib::WriteString "Node   Mass [gid_groups_conds::give_active_unit M]"
    customlib::WriteNodes $condition_list $condition_formats "" active
    customlib::EndWriteFile ;#finish writting
}

#procedure that draw a square to represent the Weight condition
proc Ermes::DrawSymbolWeigth { values_list } {  
    variable _opengl_draw_list
    if { ![info exists _opengl_draw_list(weight)] } {
        set _opengl_draw_list(weight) [GiD_OpenGL draw -genlists 1]
        GiD_OpenGL draw -newlist $_opengl_draw_list(weight) compile
        set filename_mesh [file join [Ermes::GetDir] symbols weight_2d.msh]
        gid_groups_conds::import_gid_mesh_as_openGL $filename_mesh black blue	
        GiD_OpenGL draw -endlist
    }
    set weigth_and_unit [lrange [lindex $values_list [lsearch -index 0 $values_list Weight]] 1 2]
    set weigth [lindex $weigth_and_unit 0]
    set scale [expr {$weigth*0.1}]
    set transform_matrix [list $scale 0 0 0 0 $scale 0 0 0 0 $scale 0 0 0 0 1]
    set list_id [GiD_OpenGL draw -genlists 1]
    GiD_OpenGL draw -newlist $list_id compile
    GiD_OpenGL draw -pushmatrix -multmatrix $transform_matrix
    GiD_OpenGL draw -call $_opengl_draw_list(weight)
    GiD_OpenGL draw -popmatrix
    GiD_OpenGL draw -endlist
    return $list_id
}
