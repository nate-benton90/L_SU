package SeismicUnixPlTk_global_constants;

use Moose;

=head2 Default Tk settings 

 _first_entry_num is normally 1
 _max_entry_num is defaulted to 

=cut

	my $alias_superflow_names_h = {
           fk		 			=> 'Sudipfilt',
           ProjectVariables 	=> 'Project_Variables',
           SetProject 			=> 'SetProject',
           iSpectralAnalysis	=> 'iSpectralAnalysis',      
           iVelAnalysis 		=> 'iVA',
           iTopMute 	        => 'iTopMute',
           iBottomMute       	=> 'iBottomMute',
           Project       		=> 'Project',
           synseis				=> 'synseis',
           Sseg2su				=> 'Sseg2su',
           Sucat				=> 'Sucat',
           temp					=> 'temp',
    };
    
    	my $alias_superflow_spec_names_h = {
           fk		 			=> 'Sudipfilt',
           ProjectVariables 	=> 'Project_Variables',
           SetProject 			=> 'SetProject',
           iSpectralAnalysis	=> 'iSpectralAnalysis',      
           iVelAnalysis 		=> 'iVA',
           iTopMute 	        => 'iTopMute',
           iBottomMute       	=> 'iBottomMute',
           Project       		=> 'Project',
           synseis				=> 'synseis',
           Sseg2su				=> 'Sseg2su',
           Sucat				=> 'Sucat',
           temp					=> 'temp',
    };
    

	#print("my constants, alias for fk: $alias_h->{fk}\n");

	my $superflow_names_h	= {
		 _fk					=> 'fk',
		 _ProjectVariables		=> 'ProjectVariables',
		 _SetProject			=> 'SetProject',
		 _iSpectralAnalysis		=> 'iSpectralAnalysis',
		 _iVelAnalysis			=> 'iVelAnalysis',
		 _iTopMute				=> 'iTopMute',
		 _iBottomMute			=> 'iBottomMute',
		 _Project				=> 'Project',
		 _synseis				=> 'synseis',
		 _Sseg2su				=> 'Sseg2su',
		 _Sucat					=> 'Sucat',
		 _temp					=> 'temp',
	};

=head2

 as shown in gui

=cut
	my @superflow_names_gui;
	$superflow_names_gui[7]				= 'fk';
	$superflow_names_gui[3]     		= 'iSpectralAnalysis';
	$superflow_names_gui[4]     		= 'iVelAnalysis';
	$superflow_names_gui[5]     		= 'iTopMute';
	$superflow_names_gui[6]     		= 'iBottomMute';
	$superflow_names_gui[0]     		= 'Project';
	$superflow_names_gui[8]     		= 'synseis';
	$superflow_names_gui[1]     		= 'Sseg2su';
	$superflow_names_gui[2]     		= 'Sucat';	           	
	$superflow_names_gui[9]     		= 'temp';
	
	
	my @superflow_names;
	$superflow_names[0]				= 'fk';
	$superflow_names[1]				= 'ProjectVariables';
	$superflow_names[2]     		= 'SetProject' ;
	$superflow_names[3]     		= 'iSpectralAnalysis';
	$superflow_names[4]     		= 'iVelAnalysis';
	$superflow_names[5]     		= 'iTopMute';
	$superflow_names[6]     		= 'iBottomMute';
	$superflow_names[7]     		= 'Project';
	$superflow_names[8]     		= 'synseis';
	$superflow_names[9]     		= 'Sseg2su';	
	$superflow_names[10]     		= 'Sucat';
	$superflow_names[11]     		= 'temp';
			
	my @alias_superflow_names;
	$alias_superflow_names[0]		= 'Sudipfilt';
	$alias_superflow_names[1]		= 'SetProject';
	$alias_superflow_names[2]      	= 'SetProject' ;
	$alias_superflow_names[3]      	= 'iSpectralAnalysis';
	$alias_superflow_names[4]      	= 'iVA';
	$alias_superflow_names[5]      	= 'iTopMute';
	$alias_superflow_names[6]      	= 'iBottomMute';
	$alias_superflow_names[7]      	= 'Project';
 	$alias_superflow_names[8]      	= 'synseis';	
 	$alias_superflow_names[9]      	= 'Sseg2su';
 	$alias_superflow_names[10]      = 'Sucat';
  	$alias_superflow_names[11]      = 'temp';

	
	my @superflow_config_names;
	$superflow_config_names[0]	 	= 'fk';
	$superflow_config_names[1]	 	= 'ProjectVariables';
	$superflow_config_names[2]	 	= 'ProjectVariables';
	$superflow_config_names[3]      = 'iSpectralAnalysis';
	$superflow_config_names[4]      = 'iVelAnalysis';
	$superflow_config_names[5]      = 'iTopMute';
	$superflow_config_names[6]      = 'iBottomMute';
	$superflow_config_names[7]      = 'Project';
 	$superflow_config_names[8]      = 'synseis';
  	$superflow_config_names[9]      = 'Sseg2su';
  	$superflow_config_names[10]      = 'Sucat';
  	$superflow_config_names[11]     = 'temp';
  	  			
	my @alias_superflow_config_names;
	$alias_superflow_config_names[0]		= 'Sudipfilt';
	$alias_superflow_config_names[1]		= 'Project_Variables';
	$alias_superflow_config_names[2]		= 'Project_Variables';
	$alias_superflow_config_names[3]      	= 'iSpectralAnalysis';
	$alias_superflow_config_names[4]      	= 'iVA';
	$alias_superflow_config_names[5]      	= 'iTopMute';
	$alias_superflow_config_names[6]      	= 'iBottomMute';
	$alias_superflow_config_names[7]      	= 'Project';
	$alias_superflow_config_names[8]      	= 'synseis';
	$alias_superflow_config_names[9]      	= 'Sseg2su';	
	$alias_superflow_config_names[10]      	= 'Sucat';	
	$alias_superflow_config_names[11]      	= 'temp';
	
 		
	my @alias_FileDialog_button_label;
	$alias_FileDialog_button_label[0]	 	= 'Data';
	$alias_FileDialog_button_label[1]	 	= 'Flow';
	$alias_FileDialog_button_label[2]       = 'SaveAs';

 	my @file_dialog_type;
 	$file_dialog_type[0]					= 'Data';
 	$file_dialog_type[1]					= 'Flow'; 	
  	$file_dialog_type[2]					= 'SaveAs';
  	
 	my $file_dialog_type_h		= 	{
 		_Data					=>  'Data',
 		_Flow					=>  'Flow', 	
  		_SaveAs					=>  'SaveAs',
  		_Save					=>  'Save',	
 	};
 		
 	my @flow_type;
 	$flow_type[0]						= 'user_built';
 	$flow_type[1]						= 'pre_built_superflow'; 	
  	
 	my $flow_type_h						= 	{
 		_user_built						=>  'user_built',
 		_pre_built_superflow			=>  'pre_built_superflow', 		
 	};
 		
  		 	 		
  my $var = {
	_13_characters				=> '13',
	_12_characters				=> '12',
	_11_characters				=> '11',
	_10_characters				=> '10',
	_15_characters				=> '15',
    _base_file_name             => 'base_file_name',
	_box_position     			=> '850x400+12+12',
	_clear_text     			=> '',
 	_eight_characters   		=> '8',
	_failure       				=> -1,
	_false       				=> 0,
    _data_name             		=> 'data_name',
    _base_file_name				=> 'base_file_name',
 	_five_pixels       			=> '5',
	_five_pixel_borderwidth 	=>  5,
 	_five_lines					=> '5',
  	_1_line						=> '1',
 	_3_lines					=> '3',
  	_2_lines					=> '2',
 	_4_lines					=> '4',
 	_24_pixels					=> '24',
	_12_pixels					=> '12',
	_five_characters   			=> '5',
	_flow                  		=> 'frame',
	_half_tiny_width       		=> '6',
	_hundred_characters   		=> '100',
	_large__width      			=> '200',
	_light_gray       			=> 'gray90',
	_medium_width     			=> '100',
	_my_purple	    			=> 'MediumPurple1',
	_my_white        			=> 'white',
	_my_yellow        			=> 'LightGoldenrod1',
	_my_dark_grey              	=> 'DarkGrey',
	_my_black              		=> 'black',
	_my_light_green				=> 'LightGreen',
	_my_light_grey            	=> 'LightGrey',
	_my_pink				    => 'pink',
	_my_light_blue             	=> 'LightBlue',
	_no_pixel       			=> '0',
	_no_borderwidth    			=> '0',
	_nu    						=> 'nu',
	_no							=> 'no',
	_on    						=> 'on',
	_off    					=> 'off',
	_one_character   			=> '1',
	_one_pixel       			=> '1',
	_one_pixel_borderwidth 		=>  '1',
	_program_title    			=> 'L_SU V0.3.4',
	_project_selector_title    	=> 'Project Selector',
	_project_selector_box_position  => '600x600+100+100',
	_null_sunix_value         	=> '',
	_superflow             		=> 'menubutton',
	_small_width      			=> '50',
	_standard_width   			=> '20', 
	_ten_characters   			=> '10',
	_eleven_characters			=> '11',
	_five_characters			=> '5',
	_thirty_characters			=> '30',
	_thirty_five_characters	    => '35',	
	_tiny_width       			=> '12',
	_true						=> 1,
	_twenty_characters			=> '20',	 
	_very_small_width 			=> '25',
	_very_large_width 			=> '500',
	_yes						=> 'yes',
	_white        				=> 'white',
 };

=pod
    _length = (max number of entries + 1)

=cut

 my     $param = {
   	 	 _max_entry_num	 		=> 60,
    	 _first_entry_num       => 0, 
    	 _first_entry_idx       => 0, 
    	 _final_entry_num	 	=> 60,
    	 _final_entry_idx	 	=> 60,
    	 _default_index         => 0, 
    	 _length        		=> 61,   # max number of allowable parameters in GUI
        };

 my     $global_libs  = {
        _param                   => '/usr/local/pl/configs/',
        _superflows        		 => '/usr/local/pl/big_streams/',
        _images					 => '/usr/local/pl/images/',
		_default_path            => './',
       };

  # for seismic unix program options
  my @names = ("data_in", 
            "data_out", 
            "suximage", 
            "suxgraph", 
            "suxwigb",
            "sugain",
            "sufilter",
            "suwind",
            "supef",
            "suacor",
            "sufft",
            "suamp"
            );

  my @sunix_data_programs = (
            "data_in", 
            "data_out",
            "a2b",
            "b2a",     
            );
#            "mkparfile",
#            "segyread", ,
#            "segywrite",
#            "segyhdrs",
#            "segyclean",
#            "supaste",
#            "sustrip", 
            
  my @sunix_display_programs = (
            "suximage", 
            "suxgraph", 
            "suxwigb",
            "sugain",
#            "xgraph",
            "ximage",
#            "xwigb",
            );
            
  my @sunix_plot_programs = (
            "suximage", 
            "suxgraph", 
            "suxwigb",
#            "xgraph",
            "ximage",
#            "xwigb",
            );

  my @sunix_filter_programs = (
            "sufilter",

            );
#             "sudipfilt",            
  my @sunix_model_programs = (
            "supef", 
            );          
  my @sunix_transform_programs = (
            "supef", 
            "suacor", 
            "sufft",
            "suamp",
            ); 
#             "suconv",
#            "suxcor",
#            "sutaup"           
   my @sunix_velocity_programs = (
#            "supef",          
            );                 
 
    my @sunix_statsMath_programs = (
#			"smooth2",
#			"sumax",
#			"sunormalize",
#			"suinterp",
#			"sumean",
#			"suhistogram",
#			"supolar",
#			"sumath",
#			"suop",
#			"suop2"		
            );     
                   
   my @sunix_metadata_programs = (
#            "sushw",
#            "suchw",
#            "sucountkey",
#            "surange",
#            "supaste",
#            "sustrip",
#            "sugethw"
            ); 
   my @sunix_migration_programs = (
            "sustolt", 
            ); 
  $var->{_sunix_choices}     		= \@names;
  $var->{_sunix_data_programs} 		= \@sunix_data_programs;
  $var->{_sunix_display_programs} 	= \@sunix_display_programs;   
  $var->{_sunix_plot_programs} 		= \@sunix_plot_programs;
  $var->{_sunix_filter_programs} 	= \@sunix_filter_programs;
  $var->{_sunix_transform_programs} = \@sunix_transform_programs;
  $var->{_sunix_velocity_programs} 	= \@sunix_velocity_programs;
  $var->{_sunix_model_programs} 	= \@sunix_model_programs;    	
  $var->{_sunix_statsMath_programs} = \@sunix_statsMath_programs; 
  $var->{_sunix_metadata_programs} 	= \@sunix_metadata_programs; 
  $var->{_sunix_migration_programs} = \@sunix_migration_programs; 


sub alias_superflow_names_h {   
	my ($self) = @_;
	return ($alias_superflow_names_h);
}

sub alias_FileDialog_button_label_aref  {  # array ref
	#my 	$self = @_;
   	return (\@alias_FileDialog_button_label);
}


sub alias_superflow_names_aref {

	return(\@alias_superflow_names);

}

sub alias_superflow_spec_names_h{
	
	return($alias_superflow_spec_names_h);
}

sub file_dialog_type_aref{
	
	return(\@file_dialog_type);
}

sub file_dialog_type_href{
	
	return($file_dialog_type_h);
}

sub flow_type_aref{
	
	return(\@flow_type);
}

sub flow_type_href{
	
	return($flow_type_h);
}

sub alias_superflow_config_names_aref  {
   return (\@alias_superflow_config_names);
}

sub superflow_config_names_aref  {
   return (\@superflow_config_names);
}


sub superflow_names_aref{
	return(\@superflow_names);
}


sub superflow_names_gui_aref{

	return(\@superflow_names_gui);

}
 sub global_libs  {
   return ($global_libs);
 }

 sub superflow_names_h {
   return ($superflow_names_h );
 }

 sub var {
   return ($var);
 }

 sub param {
  return ($param);
 }

1;
