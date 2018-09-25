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
 	my $data_name			= $var->{_data_name};
 	my $on         			= $var->{_on};
 	my $off        			= $var->{_off};
 	my $nu         			= $var->{_nu};
 	my $true         		= $var->{_on};
 	my $false         		= $var->{_off};

=head2 private hash


=cut


 my $iFile = {
	_entry_button_label			 	=> '',
	_last_flow_listbox_touched_w	=> '',
	_last_flow_index_touched		=> '',
	_last_flow_index_touched		=> '',
	_prog_name						=> '',
	_is_prog_name					=> $false,
	_is_entry_button_label			=> $false,
 };

=head2 sub close 
	
	close out File Dialog and highlight the next
	location in the GUI
   			 # print("iFile,close, superflow=$hash_ref->{_is_superflow_select_button}\n");
   			 #  print("iFile,close, flowleft=$hash_ref->{_is_flow_listbox_l}\n");

=cut


sub  close { 
  	my ($self,$hash_ref) = @_;

	$iFile->{_last_flow_listbox_touched_w}  = $hash_ref->{_last_flow_listbox_touched_w};
 	$iFile->{_last_flow_index_touched} 		= $hash_ref->{_last_flow_index_touched};

	if( $hash_ref->{_is_flow_listbox_l} || $hash_ref->{_is_flow_listbox_r} ) {
		private_close4flow();
	}

	if($hash_ref->{_is_superflow_select_button}) {
		private_close4superflow();
	}

   return();
}

=head2 sub get_Open_path 

=cut

sub  get_Open_path { 

  	my ($self) 				= @_;
	 use Project;
  my $Project = new Project();
	my $PL_SEISMIC 	= $Project->PL_SEISMIC();
    
   	$iFile->{_path}  = $PL_SEISMIC ;

	my $path = $iFile->{_path};
   	return($path);
}

=head2 sub get_SaveAs_path 

=cut

sub  get_SaveAs_path { 

  	my ($self) 				= @_;
	use Project;
    my $Project = new Project();
	my $PL_SEISMIC 	= $Project->PL_SEISMIC();
    
   	$iFile->{_path}  = $PL_SEISMIC ;

	my $path = $iFile->{_path};
   	return($path);
}



=head2 sub get_Select_path 
 make sure to remove unneeded ticks in strings
=cut

sub  get_Select_path { 

  	my ($self) 				= @_;
  	my $entry_label 		= $iFile->{_entry_button_label};
  	use SeismicUnixPlTk_global_constants;
  	
	use Project;
    my $Project 			= new Project();
	my $DATA_SEISMIC_SU 	= $Project->DATA_SEISMIC_SU();
	my $PL_SEISMIC 			= $Project->PL_SEISMIC();			
    
	if ($entry_label eq $data_name ) {
					 # print("iFile,get_path,entry_button_label= $entry_label\n");			
					 # print("2. iFile,get_Select_path,$DATA_SEISMIC_SU\n");
		$iFile->{_path}  = $DATA_SEISMIC_SU;
		
	} else {
					 print("iFile,get_path,generic file path chosen, i.e. n");
    	$iFile->{_path}  = $default_path ;
   					 print("iFile,get_path,path=$iFile->{_path}\n");
	}

	if( $entry_label eq '' ) {
		     	 print("iFile,get_path, entry_label is empty \n");
		     	 print("iFile,get_path, PL_SEISMIC path chose \n");
	
    	$iFile->{_path}  = $PL_SEISMIC;

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

		print("iFile,get_prog_name,first_name=$first_name\n");

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

=head2 sub private_close4flow 

=cut

sub  private_close4flow { 
  my ($self) = @_;

	$iFile	->{_last_flow_listbox_touched_w}    
			->selectionSet(
                 $iFile->{_last_flow_index_touched}, 
	          );
   return();
}




=head2 sub private_close4superflow 

=cut

sub  private_close4superflow { 

  my ($self) = @_;

   return();
}

=head2 sub private_set4getpath

=cut

sub  private_set4get_path { 

	my ($self) = @_;
	my $conditions;


	return($conditions);
}


=head2 sub set_entry 

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

=head2 sub set_prog_name 

=cut

sub  set_prog_name { 

	my ($self,$hash_ref) = @_;
	if($hash_ref->{_prog_name}) {
		$iFile->{_prog_name} = ${$hash_ref->{_prog_name}};
   			 # print("iFile,set_program_name, =${$hash_ref->{_prog_name}}\n");
   	} else {
		 print("iFile,set_program_name, no prog name given\n");
	}
   	return();
 }

1;
