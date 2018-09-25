package iFile;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 Perl package: iFile.pm 
 AUTHOR: Juan Lorenzo
 DATE: Nov 3 2017 

 DESCRIPTION: 
 V 0.1 

 USED FOR:
 
 interactive file and path manipulation

 BASED ON:

=cut

	use Moose;

 	use SeismicUnixPlTk_global_constants;
 	my $get					= new SeismicUnixPlTk_global_constants();
 	my $global_libs			= $get->global_libs();
 	my $alias_superflow_config_names_aref 	
							= $get->alias_superflow_config_names_aref();
 	my $superflow_config_names_aref 	
							= $get->superflow_config_names_aref();

 	my $default_path  		= $global_libs->{_default_path};
 	my $var					= $get->var();
 	my $base_file_name		= $var->{_base_file_name};
 	# my $data_name			= $var->{_data_name};
 	my $on         			= $var->{_on};
 	my $off        			= $var->{_off};
 	my $nu         			= $var->{_nu};
 	my $true         		= $var->{_on};
 	my $false         		= $var->{_off};
 	my $flow_type_h			= $get->flow_type_href();

=head2 private hash

10 keys and values

=cut

 my $iFile = {
 	
	_entry_button_label			 	=> '',
	_is_flow_listbox_grey_w         => '',
	_is_flow_listbox_pink_w         => '',
	_is_flow_listbox_green_w        => '',
	_is_flow_listbox_blue_w         => '',
	_is_flow_listbox_color_w		=> '',
	_is_superflow_select_button     => '',
	_last_parameter_index_touched_color => '',
	_last_flow_listbox_touched_w	=> '',
	_last_flow_index_touched		=> '',
	_prog_name						=> '',
	_prog_name_sref					=> '',
	_values_aref					=> '',

 };
 

=head2 sub close 
	
	close out File Dialog and highlight the next
	location in the GUI
   			 # print("iFile,close, superflow=$hash_ref->{_is_superflow_select_button}\n");
   			 #  print("iFile,close, flowleft=$hash_ref->{_is_flow_listbox_grey_w}\n");

=cut


sub  close { 
  	my ($self,$hash_ref) = @_;

	if ($hash_ref->{_last_flow_listbox_touched_w}) {
		
		$iFile->{_last_flow_listbox_touched_w}  = $hash_ref->{_last_flow_listbox_touched_w};
 		$iFile->{_last_flow_index_touched} 		= $hash_ref->{_last_flow_index_touched};
 		
		print("1. iFile,close, _last_flow_listbox_touched_w = $iFile->{_last_flow_listbox_touched_w}\n");
		print("2. iFile,close, _last_flow_index_touched = $hash_ref->{_last_flow_index_touched}\n");
				
		if ( $hash_ref->{_is_flow_listbox_grey_w}  || 
			$hash_ref->{_is_flow_listbox_pink_w}  ||
			$hash_ref->{_is_flow_listbox_green_w} ||
			$hash_ref->{_is_flow_listbox_blue_w}  ||
			$hash_ref->{_is_flow_listbox_color_w} ) {
			# print("3 of 3 iFile,close, is grey listbox  =$hash_ref->{_is_flow_listbox_grey_w}\n");

			_close4flow();
		}

		if($hash_ref->{_is_superflow_select_button}) {
			
			_close4superflow();
			
		}	
		
	} else {
		print("iFile,close, missing _last_flow_listbox_touched_w \n");
	} 

   return();
}

=head2 sub get_Open_perl_flow_path 

=cut

sub  get_Open_perl_flow_path { 

	my ($self) 		 = @_;
	use Project;
	my $Project		 = new Project();
	my $PL_SEISMIC 	 = $Project->PL_SEISMIC();

    
   	$iFile->{_path}  = $PL_SEISMIC ;

	my $path = $iFile->{_path};
	
   	return($path);
}

=head2 sub get_Open_path 

=cut

sub  get_Open_path { 

	my ($self) 		 = @_;
	use Project;
	my $Project		 = new Project();
	my $PL_SEISMIC 	 = $Project->PL_SEISMIC();
    
   	$iFile->{_path}  = $PL_SEISMIC ;

	my $path = $iFile->{_path};
   	return($path);
}

=head2 sub get_SaveAs_path 

=cut

sub  get_SaveAs_path { 

  	my ($self) 			= @_;
	use Project;
    my $Project 		= new Project();
	my $PL_SEISMIC 		= $Project->PL_SEISMIC();
    
   	$iFile->{_path} 	= $PL_SEISMIC ;

	my $path = $iFile->{_path};
   	return($path);
}



=head2 sub get_Data_path

 make sure to remove unneeded ticks in strings
 get DATA path from SPEC file
 corresponding to the program name
 
=cut

sub  get_Data_path { 

  	my ($self) 				= @_;
  	my $entry_label 		= $iFile->{_entry_button_label};
  	use SeismicUnixPlTk_global_constants;
 
 		# print("iFile,get_path,entry_button_label= $entry_label\n");
  		# print("iFile,get_path,base_file_name    = $base_file_name\n");
	use Project;
    my $Project 			= new Project();
    my $DATA_SEISMIC_BIN 	= $Project->DATA_SEISMIC_BIN();
	my $DATA_SEISMIC_SU 	= $Project->DATA_SEISMIC_SU();
	my $PL_SEISMIC 			= $Project->PL_SEISMIC();
	my $DATA_SEISMIC_SEGY 	= $Project->DATA_SEISMIC_SEGY();
	my $DATA_SEISMIC_TXT 	= $Project->DATA_SEISMIC_TXT();
	
	# assume second label/name = 'type' &&  value = 'su', segy etc.
	if ($iFile->{_flow_type} eq $flow_type_h->{_user_built} && $entry_label eq $base_file_name) {
		
		my $data_type	 		= @{$iFile->{_values_aref}}[1]; 			
  		# print("iFile,get_path,data_type = $data_type\n"); 
							
			# if second label/name = 'type' &&  value = 'su'
		if ( $data_type eq 'su' or $data_type eq "'su'") { 
			# print("iFile,get_path,entry_button_label= $entry_label\n");			
			# print("2. iFile,get_Data_path,$DATA_SEISMIC_SU\n");
			$iFile->{_path}  = $DATA_SEISMIC_SU;
			
		 } elsif ( $data_type eq 'segy'or $data_type eq 'SEGY' or $data_type eq "'SEGY'" or $data_type eq "'SEGY'" 
		 		or $data_type eq 'sgy' or $data_type eq 'SGY'or $data_type eq "'SGY'"or $data_type eq "'SGY'") {
		 			
			# print("iFile,get_path,entry_button_label= $entry_label\n");			
			# print("3. iFile,get_Data_path,$DATA_SEISMIC_SEGY\n");
			$iFile->{_path}  = $DATA_SEISMIC_SEGY;
				
		 }  elsif ( $data_type eq 'txt'or $data_type eq 'TXT' or $data_type eq "'txt'" or $data_type eq "'TXT'" 
		 		or $data_type eq 'text' or $data_type eq 'TEXT'or $data_type eq "'text'"or $data_type eq "'TEXT'" 
		 		or $data_type eq 'ascii' or $data_type eq 'ASCII'or $data_type eq "'ascii'"or $data_type eq "'ASCII'" ) {
		 			
			# print("iFile,get_path,entry_button_label= $entry_label\n");			
			# print("4. iFile,get_Data_path,$DATA_SEISMIC_TXT\n");
			$iFile->{_path}  = $DATA_SEISMIC_TXT;
				
		 } 	elsif ( $data_type eq 'bin'or $data_type eq 'BIN' or $data_type eq "'bin'" or $data_type eq "'BIN'") {
		 			
			# print("iFile,get_path,entry_button_label= $entry_label\n");			
			# print("5. iFile,get_Data_path,$DATA_SEISMIC_BIN\n");
			$iFile->{_path}  = $DATA_SEISMIC_BIN;
				
		 }
		 
		 else {
		 	print("2. iFile,get_Data_path, unrecognized data type ... TB Added\n");		 	
		 }
		 		 
	} elsif	($iFile->{_flow_type} eq $flow_type_h->{_pre_built_superflow} && $entry_label eq $base_file_name)	 {
					# print("2. iFile,get_Data_path,$DATA_SEISMIC_SU\n");
			$iFile->{_path}  = $DATA_SEISMIC_SU;
		
	} elsif	( $entry_label eq '' ) {		
		     	 print("iFile,get_Data_path, entry_label is empty \n");
		     	 print("iFile,get_Data_path, PL_SEISMIC path chose \n");	
    	$iFile->{_path}  = $PL_SEISMIC;

	} else {
				 
    	$iFile->{_path}  = $default_path ;
    			print("iFile,get_path, unsuitable or missing entry label; type generic file path chosen, i.e.: \n");
   				print("iFile,get_path,path=$iFile->{_path}\n");
	}
	my $path = $iFile->{_path};
   	return($path);
}



=head2 sub get_prog_name_href


=cut

sub get_prog_name_href {

	my ($self,$hash_ref) = @_;
	my ($program_name);
	if ($hash_ref) {
		my ($ans,$first_name,$suffix,$length);
		my @names     	= @$alias_superflow_config_names_aref;
		$length         = scalar (@names);
		$first_name 	= $hash_ref->{_selected_first_name};

		print("iFile,get_prog_name_href,first_name=$first_name\n");

			for ( my $i=0; $i < $length; $i++) {
				if ($names[$i] eq  $first_name) {
						$ans = $i;	
				}
			}
		$program_name	=	$names[$ans];
		print("iFile,get_prog_name,superflow name = $names[$ans]\n");
	}
	return($program_name); 
}


=head2 sub get_prog_name_s

	match the names of configuration files using aliases,
	which have hyphens, e.g. Project_Variables

	However, program names may be different: e.g. ProjectVariables


=cut

sub get_prog_name_s {

	my ($self,$scalar) = @_;
	my ($alias_program_name,$program_name);
	if ($scalar) {
		my ($ans,$first_name,$length);
		$first_name 	= $scalar;
		my @alias_names = @$alias_superflow_config_names_aref;
		my @names     	= @$superflow_config_names_aref;
		$length         = scalar (@names);

					# print("iFile,get_prog_name_s,first_name=$first_name\n");
			
			for ( my $i=0; $i < $length; $i++) {
				if ($alias_names[$i] eq  $first_name) {
						$ans = $i;	
        				$program_name		= 	$names[$ans];
				}
			}
		if($program_name) {
			 print("iFile,get_prog_name_s,superflow name = $program_name\n");
		} else {
			 print("iFile,get_prog_name_s,superflow name = NO MATCH\n");
		}
	}
	return($program_name); 
}

=head2 sub _close4flow 

	highlight the last index touched

=cut

sub  _close4flow { 
  my ($self) = @_;
  
  			print("iFile,_close4flow, iFile->{_last_flow_index_touched}: $iFile->{_last_flow_index_touched} \n");
   			print("iFile,_close4flow, iFile->{_last_flow_listbox_touched_w}: $iFile->{_last_flow_listbox_touched_w} \n");
   			
	if($iFile->{_last_flow_listbox_touched_w}  && ( $iFile->{_last_flow_index_touched}  >= 0) ) {  # -1 does exist as default in L_SU.pm
			$iFile->{_last_flow_listbox_touched_w}    
			->selectionSet(
                 $iFile->{_last_flow_index_touched}, 
	          );		
	} else {
			print("iFile, _close4flow, missing widget and or index (integer)\n");
	}
   return();
}




=head2 sub _close4superflow 

=cut

sub  _close4superflow { 

  my ($self) = @_;

   return();
}

=head2 sub _set4getpath

=cut

sub  _set4get_path { 

	my ($self) = @_;
	my $conditions;


	return($conditions);
}


=head2 sub set_entry 

	force entry point from gui to be an Entry widget

=cut

sub  set_entry { 

  my ($self,$hash_ref) = @_;

	if( $hash_ref ) {
			#if ($hash_ref->{_entry_button_label} ne '' ){
			# print("iFile,set_entry, entry_button label=$hash_ref->{_entry_button_label}___\n");
		if ($hash_ref->{_entry_button_label} ne '' ) {
			$iFile->{_entry_button_label} = $hash_ref->{_entry_button_label}; 
		}
	}
   	
  return();
}

	
=head2 sub set_flow_type_h

	user_built_flow
	or
	pre_built_superflow
	
=cut
 sub set_flow_type_h {
 	my ($self,$how_built) = @_;
 	
 	if ( $how_built ) {
 			 		
 		$iFile->{_flow_type} = $how_built->{_flow_type};
 			# print("iFile, set_flow_type : $iFile->{_flow_type}\n");
 		
 	} else {		
 		print("iFile, set_flow_type , missing how_built\n");
 	}
 	return();
 }


=head2 sub set_prog_name_sref

	give scalar reference to program name 

=cut

sub  set_prog_name_sref { 

	my ($self,$hash_ref) = @_;
	if($hash_ref->{_prog_name_sref}) {
		
				 # print("iFile,set_prog_name_sref,raw: $hash_ref->{_prog_name_sref}\n");
				 # print("iFile,set_prog_name_sref,-- if assumed a scalar ref: ${$hash_ref->{_prog_name_sref}}\n");
		$iFile->{_prog_name_sref} = $hash_ref->{_prog_name_sref};

   	} else {
		 print("iFile,set_prog_name_sref, no prog name given\n");
	}
   	return();
 }
 
=head2 sub set_values_aref

	introduce array or parameter values

=cut

sub  set_values_aref { 

	my ($self,$hash_ref) = @_;
	if($hash_ref->{_values_aref}) {
		
				 # print("iFile,set_values_aref,raw: @{$hash_ref->{_values_aref}}[0],@{$hash_ref->{_values_aref}}[1]\n");
		$iFile->{_values_aref} = $hash_ref->{_values_aref};

   	} else {
		 print("iFile,set_values_aref, missing values_aref \n");
	}
   	return();
 }

1;
