proc ::Ermes::WriteVolumeElements { filename } {

    ::Ermes::OverwriteCustomlibMaterials

    set nodal_filename [file rootname $filename]-3.dat
    customlib::InitWriteFile $nodal_filename
    customlib::WriteString "// Volumetric elements"
    
    set elements_conditions [list "bodies"]
    customlib::InitMaterials $elements_conditions active

    set element_formats [list {"VE(" "element" "id"}  {"%10d," "element" "connectivities"} {"%10d);" "material" "MID"}]
    customlib::WriteConnectivities $elements_conditions $element_formats active 
    
    customlib::EndWriteFile
}
# VE(17148,16672,16415,16375,3);