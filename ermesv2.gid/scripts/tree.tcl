proc ::Ermes::TreeOpenBranch { branchName } {
    # close all the customlib tree branches
    set document [$::gid_groups_conds::doc documentElement]
    set xpath {//container} 
    set node_to_open ""
    foreach branch [$document selectNodes $xpath] {
        if { [string equal [$branch getAttribute n] $branchName] } {
            W "Set to open [$branch @n]"
            set node_to_open $branch
        } else {
            $branch setAttribute tree_state close
            W "Closing [$branch @n]"
        }
    }
    if { [string equal $node_to_open ""] } {
        W "Branch [$branchName] not found"
        return
    }
    
    
    # open all the containers to reach the node to open
    while { ! [string equal $node_to_open ""] } {
        $node_to_open setAttribute tree_state open
        if {[$node_to_open hasAttribute n]} {
            
            W "Opening [$node_to_open @n]"
            set node_to_open [$node_to_open parentNode]
        } else {
            set node_to_open ""
        }
    }
    W "Opened all path"
    
    gid_groups_conds::actualize_conditions_window
}