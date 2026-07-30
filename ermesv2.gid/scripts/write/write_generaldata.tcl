
proc ::Ermes::WriteGeneralInformation { filename } {

    customlib::InitWriteFile $filename

    customlib::WriteString "GENERAL INFORMATION"

    
    customlib::EndWriteFile 
}