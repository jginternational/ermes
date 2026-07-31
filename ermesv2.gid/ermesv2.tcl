#################################################
#      GiD-Tcl procedures invoked by GiD        #
#################################################
proc GiD_Event_InitProblemtype { dir } {
    Ermes::SetDir $dir ;#store to use it later
    Ermes::LoadScripts $dir
    Ermes::ModifyMenus
    gid_groups_conds::open_conditions menu

    ::Ermes::CreateToolbar
          
}

proc GiD_Event_ChangedLanguage { language } {
    Ermes::ModifyMenus ;#to customize again the menu re-created for the new language
}
 
proc GiD_Event_AfterWriteCalculationFile { filename errorflag } {   
    if { ![info exists gid_groups_conds::doc] } {
        WarnWin [= "Error: data not OK"]
        return
    }    
    set err [catch { ::Ermes::WriteCalculationFiles $filename } ret]
    if { $err } {       
        WarnWin [= "Error when preparing data for analysis (%s)" $::errorInfo]
        set ret -cancel-
    }
    return $ret
}

proc GiD_Event_EndProblemtype {} {
    Ermes::SetDir ""
    Ermes::ModifyMenus
    
    ::Ermes::DestoyToolbar
}



#################################################
#      namespace implementing procedures        #
#################################################
namespace eval ::Ermes { 
    variable problemtype_dir 
    variable toolbar
}

proc ::Ermes::SetDir { dir } {  
    variable problemtype_dir
    set problemtype_dir $dir

}

proc ::Ermes::GetDir { } {  
    variable problemtype_dir
    return $problemtype_dir
}

proc ::Ermes::ModifyMenus { } {   
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

proc ::Ermes::LoadScripts { dir } {
    source $dir/scripts/toolbar.tcl
    source $dir/scripts/tree.tcl
    source $dir/scripts/write/write.tcl
    source $dir/scripts/write/00_write_generaldata.tcl
    source $dir/scripts/write/01_write_nodaldata.tcl
    source $dir/scripts/write/02_write_nodalvoltages.tcl
    source $dir/scripts/write/03_write_nodalsingular.tcl
    source $dir/scripts/write/validate.tcl
}


