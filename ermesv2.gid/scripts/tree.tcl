proc ::Ermes::TreeOpenBranch { branchName } {
    # close all the customlib tree branches
    set document [$::gid_groups_conds::doc documentElement]
    set xpath {//container} 
    foreach branch [$document selectNodes $xpath] {
        if { [string equal [$branch getAttribute n] $branchName] } {
            W "Opening [$branch @n]"
            $branch setAttribute tree_state open
        } else {
            $branch setAttribute tree_state close
            W "Closing [$branch @n]"
        }
    }
    gid_groups_conds::actualize_conditions_window
}