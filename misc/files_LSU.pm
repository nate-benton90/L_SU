package files_LSU;

=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL PACKAGE NAME: files_LSU
 AUTHOR: 	Juan Lorenzo
 DATE: 		May 6 2018

 DESCRIPTION 
     

 BASED ON:
 Version 0.0.2 May 6 2018   
 changed _private_* to _*
      
	V 0.0.3 July 24 2018 include data_in, exclude data_out

=cut

=head2 USE

=head3 NOTES

=head4 Examples

=head2 CHANGES and their DATES

=cut 
 
	use Moose;
	our $VERSION = '0.0.3';
	use SeismicUnixPlTk_global_constants;
	use Project;
  	my $Project = new Project();
	use misc::oop_text;

	my $get  					= new SeismicUnixPlTk_global_constants();
	my $oop_text				= new oop_text;
 	my $alias_superflow_name  	= $get->alias_superflow_names_h();
 	my $alias_superflow_spec_names_h = $get ->alias_superflow_spec_names_h(); 
	my $var						= $get->var();
	my $global_lib  			= $get->global_libs();
 	my $GLOBAL_CONFIG_LIB      	= $global_lib->{_param};
			#WARNING---- watch out for missing underscore!!
			# print("files_LSU,alias_superflow_name : $alias_superflow_name->{ProjectVariables}\n");

	my $alias_PV 			= $alias_superflow_name->{ProjectVariables};
	my $filehandle;

 	my $on 					= $var->{_on};
 	my $off               	= $var->{_off};
 	my $nu                	= $var->{_nu};
	my $true               	= $var->{_true};
	my $false               = $var->{_false};
 	my (@param, @values,@checkbutton_on_off);
 	my ($i,$j,$k,$size,$ref_cfg);
 	
 			# print("files_LSU, starting, about to get PL_SEISMIC\n");
    my $PL_SEISMIC 			=  $Project->PL_SEISMIC();

	my $files_LSU = {
		_CFG					=> '',
		_data_type_in			=> '',
		_data_type_out			=> '',
		_flow_name_out			=> '',
		_filehandle				=> '',
		_is_config				=> $false,
		_is_Project_config		=> $false,
		_is_data				=> $false,
		_is_data_in				=> $false,
		_is_data_out			=> $false,
		_is_data_type			=> $false,
		_is_pl					=> $false,
  		_items_versions_aref 	=> '',
  		_message_w			 	=> '',
    	_note 		   			=> '',
		_num_params_in_prog		=> '',
		_num_progs_in_flow		=> '',
 		_outbound				=> '',
 		_outbound2				=> '',
		_prog_names_aref 		=> '', 
		_prog_param_values_aref2 		=> '', 
		_prog_param_labels_aref2 		=> '', 
    	_program_name 	   		=> '',
    	_prog_name_sref			=> '',
    	_program_name_config   	=> '',
    	_program_name_pl   		=> '',
    	_ref_file  		   		=> '',
    	_Step 		   			=> '',
 	};

   $files_LSU->{_filehandle} = undef;	

=head2 sub _close 


=cut

sub _close {
	my ($self) = @_;

   	close($files_LSU->{_filehandle});

	return();
}


=head2  sub _get_prog_name_config

  needs $L_SU->{_prog_name_sref}
 
=cut 

 sub _get_prog_name_config {
	my $self = @_;
	
	if ( $files_LSU->{_prog_name_config} ) {
		
		my $prog_name_config = $files_LSU->{_prog_name_config} ;
 		return($prog_name_config);
		
	} else {
		 print("files_LSU,_get_prog_name_config, missing prog_name\n");
		 return();
	}
 }



=head2 _open2write


=cut

sub _open2write {
	my ($self) = @_;

   	# open($files_LSU->{_filehandle},">$files_LSU->{_outbound}") ||
	# die ("Can't open file name, $!\n");
	open($files_LSU->{_filehandle},'>',$files_LSU->{_outbound}) or
	die ("Can't open file name, $!\n");

	return();
}




=head2 _set_data_type_in


=cut

sub _set_data_type_in {
 	my ($type) 			= @_;
	_set_data();
	$files_LSU->{_data_type_in} 	= $type;	
	$files_LSU->{_is_data_type} 	= $true;	

	return();
}

=head2 _set_data_type_out_


=cut

sub _set_data_type_out {
 	my ($type) 			= @_;
	_set_data();
	$files_LSU->{_data_type_out} 	= $type;	
	$files_LSU->{_is_data_type} 	= $true;	

	return();
}


=head2 _set_data_direction_in


=cut

sub _set_data_direction_in {
 	my ($self) 					= @_;
	$files_LSU->{_is_data_in} 	= $true;	
	_set_data();

	return();
}

=head2 _set_data_direction_out


=cut

sub _set_data_direction_out {
 	my ($self) 					= @_;
	$files_LSU->{_is_data_out} 	= $true;	
	_set_data();

	return();
}



=head2 sub _set_data


=cut 

sub _set_data {

 	my ($self) 	= @_;
	
	$files_LSU->{_is_data} = $true;
		# print("files_LSU,_set_data,is_data: $files_LSU->{_is_data}\n");
		  
	return();
}


=head2 sub _set_data_in


=cut 

sub _set_data_in {

 	my ($self) 	= @_;

    
	$files_LSU->{_is_data_in} = $true;
		print("files_LSU,_set_data_in,is_data_in: $files_LSU->{_is_data}\n");
		  
	return();
}


=head2 sub _set_data_out


=cut 

sub _set_data_out {

 	my ($self) 	= @_;

    
	$files_LSU->{_is_data_out} = $true;
		   # print("files_LSU,_set_data_out,
		   # is_data_out: $files_LSU->{_is_data}\n");
		  
	return();
}



=head2  sub _set_prog_name_config

  needs $L_SU->{_prog_name_sref}
 
=cut 

 sub _set_prog_name_config {
	my $self = @_;
	
	if ( $files_LSU->{_prog_name_sref} ) {
		
		$files_LSU->{_prog_name_config} = ${$files_LSU->{_prog_name_sref}}.'.config';
 		return();
		
	} else {
		 print("files_LSU,_set_prog_name_config, missing prog_name_sref \n");
		 return();
	}
 }

=head2 sub _set_prog_names_aref 


=cut

sub _set_prog_names_aref {
	my ($self) = @_;

   $oop_text -> set_prog_names_aref($files_LSU->{_prog_names_aref});

   return();
}


=head2 sub _set_prog_version_aref 


=cut

sub _set_prog_version_aref {
	my ($self) = @_;

    $oop_text ->set_prog_version_aref($files_LSU);
	# print("files_LSU,_set_prog_version_aref,versions 
  		# 	@{$files_LSU->{_items_versions_aref}} \n");

   return();
}


=head2 sub _set_outbound2pl

       #print("files_LSU,_set_outbound2pl,program_name $files_LSU->{_program_name}\n");
       #print("files_LSU,_set_outbound2pl,program_name_config $files_LSU->{_program_name_config}\n");
       #print("files_LSU,_set_outbound2pl,outbound $files_LSU->{_outbound}\n");

=cut 

sub _set_outbound2pl {

 	my ($self) 	= @_;

	if ( $files_LSU->{_is_pl} ) {
 		$files_LSU->{_outbound}  			= $PL_SEISMIC.'/'.$files_LSU->{_flow_name_out};
	}
		  # print("files_LSU,_set_outbound2pl,i
		  # $files_LSU->{_outbound}\n");
		  
	return();
}


=head2 sub outbound

 needs prog_name_sref
       is_Project_config or _is_config
       TODO: make exclusive for cases that are NOT Project_config

=cut

sub outbound {

 	my ($self) 	= @_;
	
  	if ( $files_LSU->{_prog_name_sref} ) { 

   		use name;
   		my $name 				= new name();

		$files_LSU->{_program_name} 			= ${$files_LSU->{_prog_name_sref}};
		my $program_name						= $files_LSU->{_program_name}; #conveniently shorter
		
		if ( $files_LSU->{_is_Project_config} ) {
			$files_LSU->{_program_name_config} 	= $name->change_config($program_name);
			
			use L_SU_local_user_constants;
			# Find out HOME directory and configuration path for user    
			my $user_constants   	= L_SU_local_user_constants->new();	
			my $exists	 			= $user_constants->user_configuration_Project_config_exists;
			my $ACTIVE_PROJECT	 	= $user_constants->get_ACTIVE_PROJECT();
			$user_constants			->set_user_configuration_Project_config;			
			my $Project_config		= $user_constants->get_user_configuration_Project_config;
						
			if ($exists ) { # if it exists: .L_SU/configuration/active/Project.config
				 	$files_LSU->{_outbound}		=  	$Project_config;
				 			print("files_LSU, outbound, outbounds are Project_config: $Project_config\n");
			} else {
				print("files_LSU, outbound, WARNING, no user configuration Project.config exists\n");
				print("TEMP solution is to write Project.config locally\n");
			}
 			
		} elsif ( $files_LSU->{_is_config} ) {
			# $PL_SEISMIC
			$files_LSU->{_program_name_config} 	= $name->change_config($program_name);
 			$files_LSU->{_outbound}  			= $PL_SEISMIC.'/'.$files_LSU->{_program_name_config};
							 			print("files_LSU, outbound, outbound _is_config: $files_LSU->{_outbound} \n");
			
		} elsif ( $files_LSU->{_is_pl} ) {
			$files_LSU->{_program_name_pl} 		= $program_name;
 			$files_LSU->{_outbound}  			= $PL_SEISMIC.'/'.$files_LSU->{_program_name_pl};;
							 			print("files_LSU, outbound, outbound _is_pl: $files_LSU->{_is_pl} \n");
		} else {
			
			print("WARNING: files_LSU,set_outbound,$files_LSU->{_outbound}\n");	
		}	
		 	# print("files_LSU, outbound,$files_LSU->{_outbound}\n");	
	}

	return();
}


=head2 sub outbound2

 needs prog_name_sref
       is_Project_config or _is_config
       TODO: make exclusive for cases that are NOT Project_config

=cut

sub outbound2 {

 	my ($self) 	= @_;
	
  	if ( $files_LSU->{_prog_name_sref} ) { 

   		use name;
   		my $name 				= new name();

		$files_LSU->{_program_name} 			= ${$files_LSU->{_prog_name_sref}};
		my $program_name						= $files_LSU->{_program_name}; #conveniently shorter
		
		if ( $files_LSU->{_is_Project_config} ) {
			$files_LSU->{_program_name_config} 	= $name->change_config($program_name);
			
			use L_SU_local_user_constants;
			# Find out HOME directory and configuration path for user    
			my $user_constants   	= L_SU_local_user_constants->new();	
			my $exists	 			= $user_constants->user_configuration_Project_config_exists;
			my $ACTIVE_PROJECT	 	= $user_constants->get_ACTIVE_PROJECT();
			$user_constants			->set_user_configuration_Project_config2;			
			my $Project_config2		= $user_constants->get_user_configuration_Project_config2;
						
			if ($exists ) { # if it exists: .L_SU/configuration/active/Project.config
				 	$files_LSU->{_outbound2}	=  	$Project_config2;
				 			print("files_LSU, outbound, outbounds are Project_config2: $Project_config2\n");
			
			} elsif ( $files_LSU->{_is_config} ) {
			# $PL_SEISMIC
			$files_LSU->{_program_name_config} 	= $name->change_config($program_name);
 			$files_LSU->{_outbound2}  			= $PL_SEISMIC.'/'.$files_LSU->{_program_name_config};
							 			print("files_LSU, outbound2, outbound2 _is_config: $files_LSU->{_outbound2} \n");
			} else {
				print("files_LSU, outbound, WARNING, no user configuration Project.config exists\n");
				print("TEMP solution is to write Project.config locally\n");
			}
		} else {
			
			print("WARNING: files_LSU,outbound2\n");	
		}	
		 	# print("files_LSU, outbound,$files_LSU->{_outbound2}\n");	
	}

	return();
}

=head2 set_Project_config
turn file type
definitions on and off 

=cut

sub set_Project_config {
 	my ($self) 					= @_;
 	$files_LSU->{_is_config} 			= $false;
	$files_LSU->{_is_Project_config} 	= $true;	

	return();
}


=head2 set_config


=cut

sub set_config {
 	my ($self) 							= @_;
	$files_LSU->{_is_config} 			= $true;
	$files_LSU->{_is_Project_config} 	= $false;

	return();
}

=head2 set_data

		detects and attempts to rectify program order error
			#$oop_text->set_bin_out();
=cut

sub set_data {
 	my ($self) 	= @_;
    my $num_progs4flow 	= scalar @{$files_LSU->{_prog_names_aref}};
	my @prog_names		= @{$files_LSU->{_prog_names_aref}};

	for (my $i=0; $i < $num_progs4flow; $i++ ) {

		if ( $prog_names[$i] eq 'data_in') {
			my $first_2_char = substr($prog_names[$i], 0 ,2); 

			if ($first_2_char eq 'da') {
					# print("1. files_LSU,set_data,data_in detected\n");
					# print("1. files_LSU,set_data,flow_item=$i\n");
			}
			
							# 2nd program must exist
			if ($num_progs4flow >1)  {
							# suprog must follow
				my $first_2_char =  substr($prog_names[($i+1)], 0 ,2); 
				if ($first_2_char eq 'su' ){ 
					# print("1. files_LSU,set_data,su data_in detected\n");
					_set_data_type_in('su'); 
					_set_data_direction_in(); 

				} else {
					_set_data_type_in('su');  # TODO
					_set_data_direction_in(); 
				}
			} else {
				# print("files_LSU,only data and no sunix program\n");
					_set_data_type_in('su');  # TODO
					_set_data_direction_in(); 
			}
		} else {
				# print("1. files_LSU,set_data,program detected\n");
		} 

		if ( $prog_names[$i] eq 'data_out') {

							# prior program must exist
			if ($num_progs4flow >1) {

							# suprog must follow
				my $first_2_char =  substr($prog_names[($i-1)], 0 ,2);  
				if ($first_2_char eq 'su' ){ 
					# print("2. files_LSU,set_data,su data_out detected\n");
					_set_data_type_out('su');
					_set_data_direction_out(); 

				} else {

					_set_data_type_out('su'); # TODO
					_set_data_direction_out(); 
				}
			} else {

				print("files_LSU,only data and no prior sunix program\n");
					_set_data_type_out('su');  # TODO
					_set_data_direction_out(); 
			}

		} else {
			# print("2. files_LSU,set_data,program detected\n");
			
		} 
	}
	return();
}


=head2 set_message

	relay messages via the main message widget in GUI

=cut

sub set_message {
 	my ($self,$hash_ref) 			= @_;
 	
 	if ($hash_ref) {
 		
		$files_LSU->{_message_w} = $hash_ref->{_message_w};
 			
 	} else {
 		print("files_LSU, set_message, missing message widget \n");		
 	}
	return();
}


=head2 set2pl

	saved files are local perl flows

=cut

sub set2pl{
 	my ($self,$hash_ref) 			= @_;
	$files_LSU->{_is_pl} 			= $true;	
	$files_LSU->{_flow_name_out} 	= $hash_ref->{_flow_name_out};
				# print("files_LSU,set2pl, is $files_LSU->{_is_pl} \n
				#	self,hash_ref: $self,$hash_ref\n");
				# print("files_LSU,set2pl, _flow_name_out is 
				#$hash_ref->{_flow_name_out} \n");
				
	_set_outbound2pl();

	return();
}



=head2 sub set_outbound

       #print("files_LSU,set_outbound,program_name $files_LSU->{_program_name}\n");
       #print("files_LSU,set_outbound,program_name_config $files_LSU->{_program_name_config}\n");
       #print("files_LSU,set_outbound,outbound $files_LSU->{_outbound}\n");

=cut 

sub set_outbound {

 	my ($self,$out_scalar_ref) 	= @_;
    my $program_name  			= $$out_scalar_ref;
	
  	if ( $out_scalar_ref ) { 

   		use name;
   		my $name 				= new name();

		$files_LSU->{_program_name} 			= $$out_scalar_ref;
		
		if ( $files_LSU->{_is_Project_config} ) {
			$files_LSU->{_program_name_config} 	= $name->change_config($program_name);
			
			use L_SU_local_user_constants;
			# Find out HOME directory and configuration path for user    
			my $user_constants   	= L_SU_local_user_constants->new();	
			my $exists	 			= $user_constants->user_configuration_Project_config_exists;
			my $ACTIVE_PROJECT	 	= $user_constants->get_ACTIVE_PROJECT();
			$user_constants			->set_user_configuration_Project_config;			
			my $Project_config		= $user_constants->get_user_configuration_Project_config;
						
			if ($exists ) { # if it exists: .L_SU/configuration/active/Project.config
				 	$files_LSU->{_outbound}		=  	$Project_config;
				 			# print("files_LSU, set_outbound, outbounds is $Project_config\n");
			} else {
				print("files_LSU, set_outbound, WARNING, no user configuration Project.config exists\n");
				print("TEMP solution is to write Project.config locally\n");
			}
 			
		} elsif ( $files_LSU->{_is_config} ) {
			$files_LSU->{_program_name_config} 	= $name->change_config($program_name);
 			$files_LSU->{_outbound}  			= $files_LSU->{_program_name_config};
			
		}elsif ( $files_LSU->{_is_pl} ) {
			$files_LSU->{_program_name_pl} 		= $program_name;
 			$files_LSU->{_outbound}  			= $PL_SEISMIC.'/'.$files_LSU->{_program_name_pl};
 			
		} else {
			
			print("WARNING: files_LSU,set_outbound,$files_LSU->{_outbound}\n");	
		}	
		 	# print("files_LSU,set_outbound,$files_LSU->{_outbound}\n");	
	}

	return();
}


=head2 sub set_outbound2



=cut 

sub set_outbound2 {

 	my ($self,$out_scalar_ref) 	= @_;
    my $program_name  			= $$out_scalar_ref;
	
  	if ( $out_scalar_ref ) { 

   		use name;
   		my $name 				= new name();

		$files_LSU->{_program_name} 			= $$out_scalar_ref;
		
		if ( $files_LSU->{_is_Project_config} ) {
			$files_LSU->{_program_name_config} 	= $name->change_config($program_name);
			
			use L_SU_local_user_constants;
			# Find out HOME directory and configuration path for user    
			my $user_constants   	= L_SU_local_user_constants->new();	
			my $exists	 			= $user_constants->user_configuration_Project_config_exists;
			my $ACTIVE_PROJECT	 	= $user_constants->get_ACTIVE_PROJECT();
			$user_constants			->set_user_configuration_Project_config2;			
			my $Project_config2		= $user_constants->get_user_configuration_Project_config2;
						
			if ($exists ) { # if it exists: .L_SU/configuration/active/Project.config
				 	$files_LSU->{_outbound2}		=  	$Project_config2;
				 			# print("files_LSU, set_outbound2, outbounds is: $Project_config2\n");
			} else {
				print("files_LSU, set_outbound, WARNING, no user configuration Project.config exists\n");
				print("TEMP solution is to write Project.config locally\n");
			}
 			
		} elsif ( $files_LSU->{_is_config} ) {
			$files_LSU->{_program_name_config} 	= $name->change_config($program_name);
 			$files_LSU->{_outbound2}  			= $files_LSU->{_program_name_config};
 			
		} else {
			
			print("WARNING: files_LSU,set_outbound,$files_LSU->{_outbound}\n");	
		}	
		 	# print("files_LSU,set_outbound,$files_LSU->{_outbound}\n");	
	}

	return();
}

=head2 sub set_items_versions_aref


=cut

sub set_items_versions_aref  {

 	my ($self,$hash_aref) 	= @_;
	$files_LSU->{_items_versions_aref}	= $hash_aref->{_items_versions_aref};
    # print("files_LSU,set_items_versions_aref,
	#	   @{$files_LSU->{_items_versions_aref}}\n");

	return();
}


=head2 sub set_prog_param_values_aref2
 #    my $num_progs4flow = scalar @{$files_LSU->{_prog_param_values_aref2}};
# 	print("\nfiles_LSU,set_prog_param_values_aref2, num_progs4flow: $num_progs4flow\n");

	# for (my $j=0; $j < $num_progs4flow; $j++ ) {
# 
# 		my $num_params4prog = scalar @{@{$files_LSU->{_prog_param_values_aref2}}[$j]};
# 		print("files_LSU,set_prog_param_values_aref2,num_params4prog in index=$j: $num_params4prog \n");
# 		print("\nfiles_LSU,_prog_param_values_aref2, values:\n");
# 		my @values = @{@{$files_LSU->{_prog_param_values_aref2}}[$j]};
# 		print("@values\n");
# 	}


=cut

sub set_prog_param_values_aref2 {

 	my ($self,$hash_aref2) 	= @_;
	$files_LSU->{_prog_param_values_aref2}	= $hash_aref2->{_good_values_aref2};

	return();
}


=head2 sub set_prog_param_labels_aref2
		#	my $num_progs4flow = scalar @{$files_LSU->{_prog_param_labels_aref2}};
        # 	print("\nfiles_LSU,set_prog_param_labels_aref2, num_progs4flow: $num_progs4flow\n");
		#		for (my $i=0; $i < $num_progs4flow; $i++ ) {
		#		print("files_LSU,set_prog_param_labels_aref2,
		#		@{@{$files_LSU->{_prog_param_labels_aref2}}[$i]}\n");
		#			}

# 	for (my $j=0; $j < $num_progs4flow; $j++ ) {
# 
# 		my $num_params4prog = scalar @{@{$files_LSU->{_prog_param_labels_aref2}}[$j]};
# 		print("files_LSU,set_prog_param_labels_aref2,num_params4prog in index=$j: $num_params4prog \n");
# 		print("\nfiles_LSU,_prog_param_labels_aref2, labels:\n");
# 		my @labels = @{@{$files_LSU->{_prog_param_labels_aref2}}[$j]};
# 		print("@labels\n");
# 	}


=cut

sub set_prog_param_labels_aref2{

 	my ($self,$hash_aref2) 	= @_;
	
	$files_LSU->{_prog_param_labels_aref2}	= $hash_aref2->{_good_labels_aref2};

	return();
}


=head2 sub set_prog_names_aref


=cut

sub set_prog_name_sref {
 	my ($self,$sref) 	= @_;
 	
 	if($sref) {
 		
 		$files_LSU->{_prog_name_sref}		= $sref;
 		
				# print("files_LSU, set_prog_name_sref, prog_name:${$files_LSU->{_prog_name_sref}}\n");
 		return();
 	}else {
 		print("files_LSU, set_prog_name_sref, prog name missing\n");
 		return();		
 	}
}



=head2 sub set_prog_names_aref


=cut

sub set_prog_names_aref {

 	my ($self,$hash_aref) 	= @_;
	$files_LSU->{_prog_names_aref}		= $hash_aref->{_prog_names_aref};
	# print("files_LSU, set_prog_names_aref, prog_names:@{$files_LSU->{_prog_names_aref}}\n");

	return();
}



=head2 sub set_superflow_specs 

  Output parameters for superflows
  A Tool is a superflow
  i/p $hash_ref to obtain entry labels and
  values and paramters from widgets to build @CFG 

DB
  print("prog name $program_name\n");
  print(" save_button,save,configure,write_LSU,tool_specs $files_LSU->{_program_name_config}\n");
  print("save,superflow,write_LSU, key/value pairs:$CFG[$i], $CFG[$j]\n");
  #use Config::Simple;
  #my $cfg 		= new Config::Simple(syntax=>'ini');
  #$cfg->write($files_LSU->{_program_name_config});   
  # print "@CFGpa\n";
     #$cfg->ram($CFG[$i] ,$CFG[$j]); 
	  #print "@CFG\n";
        # print("write_LSU,tool_specs \nprog_name:${$files_LSU->{_program_name}}\n");
        # print("\n   prog_name_config: $files_LSU->{_program_name_config}\n");
        # print("  labels: @{$hash_ref->{_ref_labels}}\n");
        # print("  values: @{$hash_ref->{_ref_values}}\n");
        
        # no. of variables comes from specs file directly
        $length = scalar @{$hash_ref->{_ref_labels}};-- old version

=cut

sub set_superflow_specs {
  	my ($self,$hash_ref)  = @_;
  	
#					foreach my $key (sort keys %$hash_ref) {
#      					print (" files_LSU,set_superflow_specs, key is $key, value is $hash_ref->{$key}\n");
# 					}
#  	
# 					print ("1. files_LSU,set_superflow_specs,prog_name_sref: $files_LSU->{_prog_name_sref} \n");
 	
  	if ($hash_ref && $files_LSU->{_prog_name_sref} ) {
  		
  		use name;
   		my $name 				= new name();
   		
  		my (@CFG,@info);
  		my $length;

		my $base_program_name 		= ${$files_LSU->{_prog_name_sref}};
		my $alias_program_name 		= $alias_superflow_spec_names_h->{$base_program_name};
		my $module_spec				= $alias_program_name.'_spec'; #conveniently shorter 	
	 	my $module_spec_pm     		= $module_spec.'.pm';
    	require $module_spec_pm;
    	
				# print ("1. files_LSU,set_superflow_specs, require $module_spec_pm\n");

					# INSTANTIATE
		my $program_name_spec		= ($module_spec)->new();
		
				# print ("2. files_LSU,set_superflow_specs, instantiate $program_namee_spec\n");
  		
		my $max_index           	 = $program_name_spec->get_max_index();
		$length					 	 = $max_index + 1;
					
		# get length from corresponding spec file
					# print("4. files_LSU, set_superflow_specs, length=$length\n");
				
			#
			
				# print("5. files_LSU, set_superflow_specs, length=$length\n");
				
   		for (my $i=0, my $j=0; $i<$length; $i++, $j=$j+2){
     		$CFG[$j] = @{$hash_ref->{_ref_labels}}[$i];
     		$CFG[($j+1)] = @{$hash_ref->{_ref_values}}[$i];
   		}
	 
		$files_LSU->{_CFG} = \@CFG;

   			# my $ref_lines  = $messages->get_config($files_LSU->{_program_name_config} )
   			# my $num_lines  = scalar @$ref_lines;
   			# my @lines      = @$ref_lines;
   			# for (my $i=0; $i<$num_lines; $i++) {
   			# printf OUT $lines[$i];

			# print("files_LSU,set_superflow_specs,program_name_config: $files_LSU->{_program_name_config}\n");

		if($files_LSU->{_program_name_config} eq $alias_PV.'.config') {

   			$info[0] =   (" # ENVIRONMENT VARIABLES FOR THIS PROJECT\n");
   			$info[1] =   (" # Notes:\n");
   			$info[2] =   (" # 1. Default DATE format is DAY MONTH YEAR\n");
   			$info[3] =   (" # 2. only change what lies between single\n");
   			$info[4] =   (" # inverted commas\n");
   			$info[5] =   (" # 3. the directory hierarchy is\n"); 
   			$info[6] =   (" # \$PROJECT_HOME/\$date/\$line\n");
   			$info[7] =   (" # Warning: Do not modify \$HOME\n");
   			$info[8] =   ("  \n");
		}

		$files_LSU->{_info} = \@info;
  	
  	} else {
  		print("files_LSU,set_superflow_specs, missing hash_ref or prog_name_sref\n");  	
  	}
    
  	return();
}


=head2 sub sizes 


=cut

sub sizes {
   $size 	  	= ((scalar @$ref_cfg) )/2;
   return($size);
}


=head2 sub check2write


=cut
 
sub check2write {
	my @self;
	
	if (not -e $files_LSU->{_outbound} ) { #if file does not exist
		
		use File::Copy;
		_set_prog_name_config();
 		my $prog_name_config   			= _get_prog_name_config();
		my $from 						= $GLOBAL_CONFIG_LIB.$prog_name_config;
		my $to   						= $files_LSU->{_outbound};
		
	 	copy ($from, $to);
	 		# print("files_LSU copy $from to $to \n");
	 	#Now you can overwrite the file 
	 	_write();
	 		
	} else {
		
		# print("files_LSU, write_config OK: $files_LSU->{_outbound}\n");
	 		# print("files_LSU, write_config, configuration file exists and will be overwritten\n");
	 	_write();
	}
return();

}

=head2 sub _write
	
	write out configuration files to script

=cut

sub _write {
	my ($self) = @_;
	my $length 			= (scalar @{$files_LSU->{_CFG}})/2;
	my $length_info 	= scalar @{$files_LSU->{_info}};
	my @info            = @{$files_LSU->{_info}};
	my @CFG             = @{$files_LSU->{_CFG}};
    
    open(my $fh, '>', $files_LSU->{_outbound}) or die "Can't open parameter file:$!";	

			# print("files_LSU,_write,length is $length\n");
	
	for (my $i=0;  $i<$length_info; $i++){
    	printf $fh $info[$i];
	}
	
	for (my $i=0, my $j=0;  $i<$length; $i++, $j=$j+2){
    	printf $fh "    %-35s%1s%-20s\n",$CFG[$j],"= ",$CFG[($j+1)];
    }
   close($fh);
}


=head2 sub write

  all files if outbound include the existing
  file path as well

=cut

sub write {
	my ($self) = @_;
	
	my $length 			= (scalar @{$files_LSU->{_CFG}})/2;
	my $length_info 	= scalar @{$files_LSU->{_info}};
	my @info            = @{$files_LSU->{_info}};
	my @CFG             = @{$files_LSU->{_CFG}};
	
	# print("files_LSU, write, length:$length,length_info:$length_info \n");
	# print("files_LSU,write,files_LSU->{_outbound}: $files_LSU->{_outbound} \n");
    
    open(my $fh, '>', $files_LSU->{_outbound}) or die "Can't open parameter file:$!";	

	for (my $i=0;  $i<$length_info; $i++){
    	printf $fh $info[$i];
	}

	for (my $i=0, my $j=0;  $i<$length; $i++, $j=$j+2){
		# printf ("    $CFG[$j],= ,$CFG[($j+1)]\n");;
    	printf $fh "    %-35s%1s%-20s\n",$CFG[$j],"= ",$CFG[($j+1)];
    	
    }
   close($fh);
}

=head2 sub write2 

 used for dealing with Project.config


=cut 


sub write2 {
	my ($self) = @_;
	use manage_dirs_by;
	use L_SU_local_user_constants;
	use File::Copy;
	
	my $user_constants   		= L_SU_local_user_constants->new();
	
	my $length 					= (scalar @{$files_LSU->{_CFG}})/2;
	my $length_info 			= scalar @{$files_LSU->{_info}};
	my @info            		= @{$files_LSU->{_info}};
	my @CFG            			= @{$files_LSU->{_CFG}};

	my $CONFIGURATION   		= $user_constants->get_CONFIGURATION();
	my $ACTIVE_PROJECT			= $user_constants->get_ACTIVE_PROJECT();
	my $Project_config			= $user_constants->get_Project_config();
	
	my $active_project_name 	= $user_constants->get_active_project_name(); 
	my $FROM					= $ACTIVE_PROJECT.'/'.$Project_config;
	my $TO						= $CONFIGURATION .'/'.$active_project_name.'/'.$Project_config;
	
	my $PATH					= $CONFIGURATION .'/'.$active_project_name ;
	
		#print("files_LSU,write2, created $PATH\n");
		
	manage_dirs_by::make_dir($PATH);
	copy($FROM, $TO);
	
		# print("files_LSU,write2, copy $FROM $TO \n");
	
    if ($files_LSU->{_outbound2}) {
    	
    	# print("files_LSU,write2,files_LSU->{_outbound2}: $files_LSU->{_outbound2} \n");
    	
    	open(my $fh, '>', $files_LSU->{_outbound2}) or die "Can't open parameter file:$!";
    	
		for (my $i=0;  $i<$length_info; $i++){
    		printf $fh $info[$i];
		}

		for (my $i=0, my $j=0;  $i<$length; $i++, $j=$j+2){
    		printf $fh "    %-35s%1s%-20s\n",$CFG[$j],"= ",$CFG[($j+1)];
    	}
		close($fh);
		
    } else {
    	print("files_LSU,write2, missing files_LSU->{_outbound2}\n");
    }
}


=head2 sub write_config


=cut 


sub write_config {
	my ($self) = @_;

	my $length 			= (scalar @{$files_LSU->{_CFG}})/2;
	my $length_info 	= scalar @{$files_LSU->{_info}};
	my @info            = @{$files_LSU->{_info}};
	my @CFG             = @{$files_LSU->{_CFG}};
    	
   	open(my $OUT,'>',$files_LSU->{_outbound});

	for (my $i=0;  $i<$length_info; $i++){
    	printf $OUT $info[$i];
	}

	for (my $i=0, my $j=0;  $i<$length; $i++, $j=$j+2){
    	printf $OUT "    %-SET_OU35s%1s%-20s\n",$CFG[$j],"= ",$CFG[($j+1)];
    }
   close($OUT);
}


=head2 sub save

	write *.pl flow files

	#for (my $i=0, my $j=0;  $i<$length; $i++, $j=$j+2){
    	#printf  $OUT "    %-35s%1s%-20s\n",$CFG[$j],"= ",$CFG[($j+1)];
    #}

=cut 

sub save {
	my ($self) = @_;

   	_open2write();
   	_set_prog_names_aref();
   	_set_prog_version_aref();# already collected in sub set_data

				# print("files_LSU-save, is data:$files_LSU->{_is_data}\n");
   	$oop_text->set_data($files_LSU); # already collected in sub set_data;
   	$oop_text->set_message($files_LSU); # already collected in sub set_data;
	$oop_text->set_filehandle($files_LSU->{_filehandle});
	$oop_text->set_num_progs4flow($files_LSU->{_prog_names_aref});
    my $num_progs4flow = scalar @{$files_LSU->{_prog_names_aref}};

# 			 # print("\nfiles_LSU,save,
#			 # num_progs4flow: $num_progs4flow\n");
#	
	# principal documentation for the program
   	$oop_text->pod_header();
   	
   	# for message and flow
	$oop_text->use_pkg();

	# for all programs in the flow
	$oop_text->instantiation();

	$oop_text->pod_declare();
	$oop_text->declare_pkg();

							# DECLARE DATA  
	
#	for (my $j=0;  $j<$num_progs4flow; $j++){
#		my $prog_name 	= @{$files_LSU->{_prog_names_aref}}[$j];
#
#		if ($prog_name eq 'data_in' ) {
#			if ($files_LSU->{_is_data_in} ) {
# 				my @params 		= @{@{$files_LSU->{_prog_param_values_aref2}}[$j]};
#				my $file_name 	= $params[0];
#				 $oop_text->set_file_name_in($file_name);
#					 # $oop_text->declare_data_in(); # removed in V 0.0.2
##				  print("2. files_LSU, got to declare data in\n");
#			} else {			
#				print("files_LSU, save, missing,files_LSU->{_is_data_in}\n ");
#			}				# we have data
#		}
#
#		if ($prog_name eq 'data_out') { ##TODO
#				# print("1. files_LSU, got to declare data \n");
#				# we have data
#			if ($files_LSU->{_is_data_out} ) {
# 				my @params 		= @{@{$files_LSU->{_prog_param_values_aref2}}[$j]};
#				my $file_name 	= $params[0];
#				 $oop_text->set_file_name_out($file_name);
##				 $oop_text->declare_data_out(); # removed in V 0.0.2
##				 # print("3. files_LSU, got to declare data out \n");
#			}
#		}
#	}
#	
#			#print $files_LSU->{_filehandle}  'here\n';
#	# pod_instantiation();	
#	# instantiation();
#	
						# declare programs and their parameters
	for (my $j=0;  $j<$num_progs4flow; $j++){

		my $prog_name 		= @{$files_LSU->{_prog_names_aref}}[$j];
		my $version			= @{$files_LSU->{_items_versions_aref}}[$j]; 	
 		my $num_params4prog = scalar @{@{$files_LSU->{_prog_param_values_aref2}}[$j]};

				 # fix one program name 
   			$oop_text->set_prog_name($prog_name);

						# fix current version 
   			$oop_text->set_prog_version($version);

						# pod setup of parameter values
			$oop_text->pod_prog_param_setup();

			my @values = @{@{$files_LSU->{_prog_param_values_aref2}}[$j]}; 	
			my @labels = @{@{$files_LSU->{_prog_param_labels_aref2}}[$j]}; 	
					# print("files_LSU,save,prog_name:$prog_name\n");
					# print("files_LSU,save,prog_values_aref:@values\n");
					# print("files_LSU,save,prog_labels_aref:@labels\n");
					# print("files_LSU,save,version:$version\n");
   			$oop_text->set_prog_version($version);
   			$oop_text->set_prog_param_values_aref(\@values);
   			$oop_text->set_prog_param_labels_aref(\@labels);

   				   				# printing to executable file
    		$oop_text->prog_params;

	}

	$oop_text->pod_flows();
	$oop_text->flows();

	$oop_text->pod_run_flows();
  	$oop_text->run_flows();

	$oop_text->pod_log_flows();
   	$oop_text->print_flows();
   	$oop_text->log_flows();

   _close();
}



=head2 sub  sunix_params

  #print("self is $self prog name is $prog_name\n");

  #foreach  my $key (sort keys %$hash_ref){ 
  #   print("parameter $key is $hash_ref->{$key} \n\n");
  #}
    #print("param is $param[$k]\n");
    #print("values is $values[$k]\n");
   all chebutton values are turned on by default
   checkbutton_on_off options are only for the checkbuttons to be green
   or red
   sunix buttons ca n be either on or off

=cut

#sub sunix_params {
#  my ($self,$hash_ref) = @_;
#  my $prog_name  	= $hash_ref;
#  $ref_cfg 		= $read->defaults($prog_name);
#  $size 	  	= ((scalar @$ref_cfg) )/2;
#
#   for ($k=0,$i=0; $k < $size; $k++,$i=$i+2) {
#     $param[$k] 	= @$ref_cfg[$i];
#   $j 		=  $i + 1;
#     $values[$k] 	= @$ref_cfg[$j];
#     if($values[$k] eq $nu) {
#       $checkbutton_on_off[$k]     = $off;
#     }
#     else {
#       $checkbutton_on_off[$k]      = $on;
#     }
#   }
#  return(\@param,\@values,\@checkbutton_on_off);
#}

1;
