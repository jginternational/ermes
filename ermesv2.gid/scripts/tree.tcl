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
