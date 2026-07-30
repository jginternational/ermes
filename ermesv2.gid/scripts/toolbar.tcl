
proc ::Ermes::CreateToolbar { {type "DEFAULT INSIDELEFT"} } {
    set dir [::Ermes::GetDir]

    set ::Ermes::BitmapsNames(0) "
			images/toolbar/RWTE10.gif \ 
            images/toolbar/CoaxTEM.gif \
            images/toolbar/RobinCoeff.gif \  
            images/toolbar/SourceProp.gif \ 
			--- \
			images/toolbar/Materials.gif \
			images/toolbar/Plasma.gif \ 
            images/toolbar/Dirichlet.gif \
            images/toolbar/RobinCond.gif \
            images/toolbar/Source.gif \ 
			--- \
			images/toolbar/Projection.gif \
			images/toolbar/ProblemData.gif \
            images/toolbar/Results.gif \ 
			--- \
            images/toolbar/Mesh.gif \
            images/toolbar/Compute.gif"

    set ::Ermes::BitmapsCommands(0) [list \
	    [list -np- ::Ermes::TreeOpenBranch RWPort_TE10] \
		[list -np- ::Ermes::TreeOpenBranch CoaxialPort_TEM] \
	    [list -np- ::Ermes::TreeOpenBranch Robin_condition_coefficients] \
        [list -np- ::Ermes::TreeOpenBranch Current_sources_properties] \
		    [ list "" ] \
        [list -np- ::Ermes::TreeOpenBranch IHL_materials] \
        [list -np- ::Ermes::TreeOpenBranch Plasma] \
	    [list -np- ::Ermes::TreeOpenBranch Dirichlet_conditions] \
	    [list -np- ::Ermes::TreeOpenBranch Robin_conditions] \
	    [list -np- ::Ermes::TreeOpenBranch Current_sources] \
            [ list "" ] \
        [list -np- ::Ermes::TreeOpenBranch Field_integrals] \
	    [list -np- ::Ermes::TreeOpenBranch Solving_parameters] \
	    [list -np- ::Ermes::TreeOpenBranch Results] \
	        [ list "" ] \
	    "Meshing generate" \
	    "Utilities Calculate"]

    set ::Ermes::BitmapsHelp(0) { 
        "Rectangular waveguide - TE10 properties"\
        "Coaxial waveguide - TEM properties"\
        "Robin condition coefficients"\
        "Current sources properties" 
		""\
	    "IHL materials"\
	    "Plasma"\
		"Dirichlet boundary conditions"\
		"Robin boundary conditions"\
		"Current sources"
		""\
        "Results integrals"\
        "Solving parameters"\
	    "Results" 
		""\
        "Generate mesh"\
        "Calculate" }
    

    set kratosPriv(toolbarwin) [CreateOtherBitmaps Ermes "ERMES toolbar" ::Ermes::BitmapsNames ::Ermes::BitmapsCommands ::Ermes::BitmapsHelp $dir ::Ermes::CreateToolbar $type Pre]
    AddNewToolbar "ERMES bar" PreErmesWindowGeom ::Ermes::CreateToolbar
}

proc ::Ermes::DestoyToolbar {} {
    global kratosPriv    
    ReleaseToolbar "ERMES bar"
    rename ErmesCreateToolbar ""    
    catch { destroy $kratosPriv(toolbarwin) }
}