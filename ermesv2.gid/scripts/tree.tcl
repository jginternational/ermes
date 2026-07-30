proc ::Ermes::TreeOpenBranch { branchName } {
    # close all the customlib tree branches
    set root [customlib::GetBaseRoot]
    set xpath {//container} 
    set node_to_open ""
    foreach branch [$root selectNodes $xpath] {
        if { [string equal [$branch getAttribute n] $branchName] } {
            set node_to_open $branch
        } else {
            $branch setAttribute tree_state "close"
        }
    }
    if { [string equal $node_to_open ""] } {
        return
    }
    gid_groups_conds::open_conditions show_window -select_xpath [$node_to_open toXPath]
    
    
    gid_groups_conds::actualize_conditions_window
}

proc ::Ermes::GetMaterialList {} {
    set x_path {//container[@n="Properties"]/container[@n="materials"]}
    set x_path {//blockdata[@n="material"]}
    set dom_materials [[customlib::GetBaseRoot] selectNodes $x_path]
    if { $dom_materials == "" } {
        error [= "xpath '%s' not found in the spd file" $x_path]
    }
    set result [list]
    foreach dom_material $dom_materials {
        set name [$dom_material @name]
        lappend result $name
    }
    return [join $result ,]
}


proc ::Ermes::GetValueForName { name {baseXPath ""} } {
    if { $baseXPath == "" } {
        set root [customlib::GetBaseRoot] 
    } else {
        set root [[customlib::GetBaseRoot] selectNodes $baseXPath]
    }
    set dom_node [[customlib::GetBaseRoot] selectNodes "//value\[@n='$name'\]"]
    if { $dom_node == "" } {
        error [= "xpath '%s' not found in the spd file" $name]
    }
    set value [get_domnode_attribute $dom_node v]
    return $value
}