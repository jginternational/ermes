proc ::Ermes::WriteNodalSingular { filename } {

    set nodal_filename [file rootname $filename]-3.dat
    customlib::InitWriteFile $nodal_filename
    customlib::WriteString "// List of singular nodes (ungaged layers formulation)"

    set condition_list [list "Singularity"]
    set condition_formats [list {"No[%d]" "node" "id"} {".Sg.Fix(%d);" "property" "Ungaged_layers"}]
    customlib::WriteNodes $condition_list $condition_formats
    customlib::EndWriteFile
}
