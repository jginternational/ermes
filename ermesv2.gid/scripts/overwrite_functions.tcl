proc ::Ermes::OverwriteCustomlibMaterials { } {
    # elements_conditions is a list of every <condition> where we use a material
    # unit_mode can be default or active or none
    proc ::customlib::InitMaterials {elements_conditions {unit_mode "default"} } {
        variable mat_dict
        set unit_conversion_system convert_value_to_default
        if {$unit_mode ne "default"} {set unit_conversion_system convert_value_to_active}
        set root [customlib::GetBaseRoot]
        set xp2 {.//blockdata[@n="material"]}
        set matnodes [$root selectNodes $xp2]
        if {$matnodes eq ""} {error [_ "No materials block found"]}
        foreach matnode $matnodes {
            set mat_name [$matnode @name]
            #if {[dict exists $mat_dict $mat_name] } {set props_dict [dict get $mat_dict $mat_name]} {set props_dict [dict create] }
            set props_dict [dict create]
            foreach prop_node [$matnode selectNodes value] {
                set value [get_domnode_attribute $prop_node v]
                if {$unit_mode ne "none"} {set value [gid_groups_conds::$unit_conversion_system $prop_node]}
                dict set props_dict [$prop_node @n] $value
            }
            dict set mat_dict $mat_name $props_dict
        }
        set material_number 0
        set condNodes [[customlib::GetBaseRoot] getElementsByTagName condition]
        foreach condNode $condNodes {
            if {[$condNode @n] in $elements_conditions} {
                set groups [$condNode getElementsByTagName group]
                set xp2 {.//value[@n="material"]}
                foreach gNode $groups {
                    set valueNode [lindex [$gNode selectNodes $xp2] 0]
                    set material_name [get_domnode_attribute $valueNode v]
                    if {![dict exists $mat_dict $material_name MID]} {
                        incr material_number
                        dict set mat_dict $material_name MID $material_number
                    }
                }
            }
        }
    }

}