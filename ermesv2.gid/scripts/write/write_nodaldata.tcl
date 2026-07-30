proc ::Ermes::WriteNodalData { filename } {
    set nodal_filename [file rootname $filename]-1.dat

    customlib::InitWriteFile $nodal_filename
    customlib::WriteString "// List of nodes (Ids and XYZ coordinates)"
    customlib::WriteCoordinates "No\[%d\] = p(%e,%e,%e);\n"
    # No[1] = p(-0.547000000000000042,0.547000000000000042,0.200000000000000011);
    customlib::EndWriteFile
}