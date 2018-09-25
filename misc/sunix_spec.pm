 package sunix_spec;
 use Moose;

=head2 initialize shared anonymous hash 

  key/value pairs

=cut

 my $sunix_spec = {
  	  _config_file_out	=> '',
  	  _spec_file_out	=> '',
  	  _file_in			=> '',
  	  _file_out			=> '',
  	  _length			=> '',
  	  _package_name				=> '',
  	  _num_lines		=> '',
  	  _path_out			=> '',
  	  _sudoc			=> '',
  	  _outbound_pm		=> '',
    };


=head2  sub _sub_binding_index_aref_section

=cut

 sub _sub_binding_index_aref_section {
	my $self = @_;
	
	my @section;	
	my $package_name = $sunix_spec->{_package_name}; 
  
	$section[0] = '=head2  sub _sub_binding_index_aref'."\n\n".
	'=cut'."\n\n".
	' sub binding_index_aref {'."\n\n".
	"\t".'my $self 	= @_;'."\n\n".
	"\t".'my @index;'."\n\n".	
	"\t".'$index[0]	= 0;'."\n\n".
	"\t".'$'.$package_name.'_spec ->{_binding_index_aref} = \@index;'."\n".	
	"\t".'return();'."\n\n".
 	' }'."\n\n\n";
 
 	return(\@section);
		
 }


=head2  sub  _get_Moose_section

=cut

sub _get_Moose_section {
 	my ($self) = @_;
	my @head;
 	$head[0] = ("\tuse Moose;\n");

 	
=head2 sub _get_declare_section


=cut

sub _get_declare_section {
	my ($self) = @_;
	my @declare;
	my $name = $sunix_spec->{_package_name}; 
		
	$declare[0] = "\n\t".'my $var					= $get->var();'."\n\n".
					"\t".'my $true      			= $var->{_true};'."\n".
					"\t".'my $false      			= $var->{_false};'."\n".
					"\t".'my $file_dialog_type	= $get->file_dialog_type_href();'."\n".
 					"\t".'my $flow_type			= $get->flow_type_href();'."\n";										
						
	return (\@declare);
	
}


=head2 sub _get_instantiation_section


=cut

sub _get_instantiation_section {
	my ($self) = @_;
	my @instantiate;
	my $package_name = $sunix_spec->{_package_name}; 
		
	$instantiate[0] = "\n\t".'use Project;'."\n".
						"\t".'use SeismicUnix qw ($su $suffix_su);'."\n".
						"\t".'use SeismicUnixPlTk_global_constants;'."\n".					
						"\t".'use '.$package_name.';'."\n".					
						"\n\t".'my $get					= new SeismicUnixPlTk_global_constants();'."\n".
						"\t".'my $Project 			= new Project;'."\n".
						"\t".'my $'.$package_name.'			    = new '.$package_name.';'."\n";
											
	return (\@instantiate);
	
}


=head2 sub _get_package_section

 a small section of the file
 print ("sunix_package_header,section:name $name\n");

=cut

sub _get_package_section {
 	my ($self) = @_;
	my @head;
	my $name = $sunix_spec->{_package_name}; 
	if($name) {
		$head[0] = 'package '.$name.'_spec;'."\n"; 
		return \@head;
	} else {
		print ("sunix_spec, get_package_section, package name missing");
	}
}

return (\@head);
}
 
=head2 sub _sub_file_dialog_type_aref

=cut 

 sub _sub_file_dialog_type_aref{
 	
 	my $self = @_;
	
	my @section;	
	my $package_name = $sunix_spec->{_package_name};
 	
	$section[0] = '=head2 sub file_dialog_type_aref'."\n\n".
	'=cut'."\n\n".
	"\t".'sub file_dialog_type_aref {'."\n".
	"\t".'my $self 	= @_;'."\n\n".
	"\t".'my @type ;'."\n\n".
	"\t".'$type[0]='.' \'\';'."\n\n".
	"\t".'$'.$package_name.'_spec->{_file_dialog_type_aref} = \@type;'."\n\n".
	"\t".
	"\t".'return();'."\n".
	"\t"."\n".
 	' }'."\n\n\n";
 
 	return(\@section);
		
 } 	
 
=head2 sub _sub_flow_type_aref

=cut  

 sub _sub_flow_type_aref {
 	
 	my $self = @_;
	
	my @section;	
	my $package_name = $sunix_spec->{_package_name};
	
	$section[0] = '=head2 sub flow_type_aref'."\n\n".
	'=cut'."\n\n". 
 	' sub flow_type_aref{'."\n\n".
	"\t".'my $self = @_;'."\n\n".	
	"\t".'my @type;'."\n\n".
	"\t".'$type[0]		= $flow_type->{_user_built};'."\n\n".	
	"\t".'$'.$package_name.'_spec	->{_flow_type_aref} = \@type;'."\n\n".	
	"\t".'return();'."\n\n".
 	'}'."\n\n\n";
	
 	return(\@section);
				
 }
 

=head2  sub _sub_get_binding_index_aref

=cut
 
 sub _sub_get_binding_index_aref {
	my $self = @_;
	
	my @section;	
	my $package_name = $sunix_spec->{_package_name};
	
	$section[0] = '=head2 sub get_binding_index_aref'."\n\n".
	'=cut'."\n\n".
	' sub get_binding_index_aref{'."\n\n".
	"\t".'my $self 	= @_;'."\n".
	"\t".'my @index;'."\n\n".	
	"\t".'if ($'.$package_name.'_spec->{_binding_index_aref} ) {'."\n\n".
	"\t\t".'	my $index_aref = $'.$package_name.'_spec->{_binding_index_aref};'."\n".
	"\t\t".'	return($index_aref);'."\n\n".		
	"\t".'} else {'."\n".
	"\t\t".'print("'.$package_name.'_spec, get_binding_index_aref, missing binding_index_aref\n");'."\n".
	"\t\t".'return();'."\n".
	"\t".'}'."\n\n".
	"\t".'my $index_aref = $'.$package_name.'_spec->{_binding_index_aref};'."\n\n".
 	' }'."\n\n\n";
 
 	return(\@section);
		
 }


=head2 sub _sub_get_binding_length

=cut

sub _sub_get_binding_length {
	my $self = @_;
	
	my @section;	
	my $package_name = $sunix_spec->{_package_name};


	$section[0] = '=head2 sub get_binding_length'."\n\n".
	'=cut'."\n\n". 
 	' sub get_binding_length{'."\n".
	"\t".'my $self = @_;'."\n\n".	
	"\t".'if ( $'.$package_name.'_spec->{_binding_index_aref} ) {'."\n\n".		
	"\t\t".'my $length;'."\n\n".
	"\t\t".'$length = scalar @{$'.$package_name.'_spec->{_binding_index_aref}};'."\n\n".
	"\t\t".'return($length);'."\n\n".		
	"\t".'} else {'."\n".	
	"\t\t".'print("'.$package_name .'_spec, get_binding_length, missing length \n");'."\n".
	"\t\t".'return();'."\n".
	"\t".'}'."\n\n".
 	' }'."\n\n\n";

 	return(\@section);
		
 }

=head2 sub _sub_get_file_dialog_type_aref

=cut

 sub _sub_get_file_dialog_type_aref {
	my $self = @_;
	
	my @section;	
	my $package_name = $sunix_spec->{_package_name};
	
	$section[0] = '=head2 sub get_file_dialog_type_aref'."\n\n".
	'=cut'."\n\n".	 
 	' sub get_file_dialog_type_aref{'."\n\n".
	"\t".'my $self = @_;'."\n".	
	"\t".'if ( $'.$package_name.'_spec->{_file_dialog_type_aref}) {'."\n\n".
	"\t".'	my @type	  =  @{$'.$package_name.'_spec->{_file_dialog_type_aref}};'."\n\n".	
	"\t\t".'return(\@type);'."\n\n".
	"\t".'} else {'."\n".
	"\t\t".'print("'.$package_name.'_spec,get_file_dialog_type_aref, missing file_dialog_type_aref\n");'."\n".
	"\t\t".'return();'."\n".
	"\t".' }'."\n\n".
	' }'."\n\n\n";
	
 	return(\@section);
		
 }
 
 
=head2 sub _sub_get_max_index

=cut

sub _sub_get_max_index{
	my $self = @_;
	
	my @section;	
	my $package_name = $sunix_spec->{_package_name};
		
	$section[0] = '=head2 sub _sub_get_max_index'."\n\n".
	'=cut'."\n\n".
	' sub get_max_index {'."\n\n".
	"\t".'my $self	= @_;'."\n".
	"\t"."\n".
	"\t".'if ( $'.$package_name.'_spec->{_max_index} ) {'."\n".		
	"\t"."\n".
	"\t".'	my $max_idx           	  = $'.$package_name.'->get_max_index();'."\n".
	"\t".'	return($max_idx);'."\n".
	"\t"."\n".	
	"\t".'} else {'."\n".
	"\t".'	print("'.$package_name.'_spec, get_max_index, missing max_index\n");'."\n".
	"\t".'return();'."\n".
	"\t".'}'."\n". 
	' }'."\n\n\n"; 

 	return(\@section);
		
 } 

 
=head2 sub _sub_get_flow_type_aref

=cut

sub _sub_get_flow_type_aref {
	my $self = @_;
	
	my @section;	
	my $package_name = $sunix_spec->{_package_name}; 

	$section[0] = '=head2 sub get_flow_type_aref'."\n\n".
	'=cut '."\n\n".
	' sub get_flow_type_aref{'."\n".
	"\t".'my $self = @_;'."\n".	
	"\t".'if ( $'.$package_name.'_spec->{_flow_type_aref} ) {'."\n\n". 				
	"\t\t".'	my $type_aref = $'.$package_name.'_spec->{_flow_type_aref};'."\n\n".
	"\t\t".'	return($type_aref);'."\n\n".			
	"\t".'} else {'."\n".		
	"\t\t".'	print("'.$package_name.'_spec, get_flow_type_aref, missing flow_type_aref \n");'."\n".
	"\t\t".'	return();'."\n".
	"\t".'}'."\n".	
 	' }'."\n\n\n";

 	return(\@section);
		
 } 
 

 
=head2 sub _sub_variables

=cut

sub _sub_variables{
	my $self = @_;
	
	my @section;	
	my $package_name = $sunix_spec->{_package_name};

	$section[0] = '=head2 sub variables'."\n".
	"\t".'return a hash array'."\n". 
	"\t".'with definitions'."\n\n".
	'=cut'."\n\n".
	' sub variables {'."\n\n".
	"\t".'my $self = @_;'."\n\n".
	"\t".'my $hash_ref = $'.$package_name.'_spec;'."\n\n".
	"\t".'return ($hash_ref);'."\n\n".
	' }'."\n\n\n";

 	return(\@section);
		
 } 

=head2  sub  get_version_section

=cut

sub _get_version_section {
 	my ($self) = @_;
	my @head;
 	$head[0] = ("\tour \$VERSION = '0.0.1';\n");

 	return (\@head);
}


=head2 sub get_body_section

 a small section of the file
 print ("sunix_package_header,section:name $name\n");

=cut

sub get_body_section {
 	my ($self) = @_;
	my @head;
	my $package_name;
	$package_name = $sunix_spec->{_package_name};
	
    $head[0]    = '	my $'.$package_name.'_spec'.' = {'."\n";
    $head[1]    = '		_DATA_DIR_IN		    => $DATA_SEISMIC_SU,'."\n";
    $head[2]    = '	 	_DATA_DIR_OUT		    => $DATA_SEISMIC_SU,'."\n";
    $head[3]    = '		_binding_index_aref	    => \'\','."\n";
    $head[4]    = '	 	_data_type_in			=> $su,'."\n";
    $head[5]    = '		_data_suffix_in			=> $suffix_su,'."\n";
    $head[6]    = '		_data_type_out			=> $su,'."\n";
    $head[7]    = '	 	_data_suffix_out		=> $suffix_su,'."\n";
 	$head[8]    = '	 	_file_dialog_type_aref	=> \'\','."\n";
	$head[9]    = '	 	_flow_type_aref			=> \'\','."\n";		
    $head[10]   = '	 	_has_infile				=> $true,'."\n";	
    $head[11]   = '	 	_has_pipe_in			=> $true,	'."\n";
    $head[12]   = '	 	_has_pipe_out           => $false,'."\n";	 
    $head[13]   = '	 	_has_redirect_in		=> $true,'."\n";
    $head[14]   = '	 	_has_redirect_out		=> $false,'."\n";
    $head[15]   = '	 	_has_subin_in			=> $true,'."\n";
    $head[16]   = '	 	_has_subin_out			=> $false,'."\n";
    $head[17]   = '	 	_is_data				=> $false,'."\n";
    $head[18]   = '		_is_first_of_2			=> $true,'."\n";
    $head[19]   = '		_is_first_of_3or_more	=> $false,'."\n";
    $head[20]   = '		_is_first_of_4or_more	=> $false,'."\n";
    $head[21]   = '	 	_is_last_of_2			=> $false,'."\n";
    $head[22]   = '	 	_is_last_of_3or_more	=> $true,'."\n";
    $head[23]   = '		_is_last_of_4or_more	=> $true,'."\n";
    $head[24]   = '		_is_suprog				=> $true,'."\n";
    $head[25]   = '	 	_is_superflow			=> $false,'."\n";
    $head[26]   = '	 	_max_index              => $max_index,'."\n";
    $head[27]   = '	};'."\n";
    $head[28]   = ''."\n\n\n".
    
    "\t".'my $incompatibles = {'."\n".
	"\t\t"."clip              => ['mbal', 'pbal'],\n".	
	"\t".'};'."\n\n";
    
    
    # print ("sunix_spec, get_body_section:\n @head\n");
 	return (\@head);
}


=head2 sub get_header_section

 a small section of the file
 print ("sunix_package_header,section:name $name\n");

=cut

sub get_header_section {
 	my ($self,$name) = @_;
	my @head;
	
	my $package_name;
	$package_name 		= $sunix_spec->{_package_name} ;
 	my @package 		= @{_get_package_section()};	
    my @Moose 			= @{_get_Moose_section()};
    my @version 		= @{_get_version_section()};
    my @instantiate  	= @{_get_instantiation_section()};
    my @declare			= @{_get_declare_section()};
    
    $head[0]    = $package[0];
    $head[1]    = $Moose[0];
    $head[2]    = $version[0];
    $head[3]    = $instantiate[0];
    $head[4]    = $declare[0];
	$head[5]    = ''."\n";
	$head[6]   = '	my $DATA_SEISMIC_SU  	= $Project->DATA_SEISMIC_SU();   # output data directory'."\n";
	$head[7]   = '	my $max_index           = $'.$package_name.'->get_max_index();'."\n";
	$head[8]   = ''."\n";	
    
    # print ("sunix_spec, get_header_section:\n @head\n");
 	return (\@head);
}



=head2 sub get_subroutine_section


=cut

sub get_subroutine_section {
 	my ($self,$name) = @_;
	my @head;
	
	my $package_name;
	$package_name 			= $sunix_spec->{_package_name} ;
	
 	my @binding 			= @{_sub_binding_index_aref_section()};
 	my @file_dialog 		= @{_sub_file_dialog_type_aref()};
    my @flow_type			= @{_sub_flow_type_aref()};
    my @get_binding_index 	= @{_sub_get_binding_index_aref()};
    my @get_binding_length 	= @{_sub_get_binding_length()};
 	my @get_file_dialog 	= @{_sub_get_file_dialog_type_aref()};
    my @get_flow_type		= @{_sub_get_flow_type_aref()};
    my @get_max_index		= @{_sub_get_max_index()}; 
    my @variables			= @{_sub_variables()}; 
          
    $head[0]    = $binding[0];
    $head[1]    = $file_dialog[0];
    $head[2]    = $flow_type[0];
    $head[3]    = $get_binding_index[0];
   	$head[4]    = $get_binding_length[0];
    $head[5]    = $get_file_dialog[0];
	$head[6]    = $get_flow_type[0];
    $head[7]    = $get_max_index[0];
	$head[8]    = $variables[0]; 
	      
    # print ("sunix_spec, get_subroutine_section:\n @head\n");
 	return (\@head);
}

=head2 sub set_package_name

 a small section of the file


=cut

sub set_package_name {
 	my ($self,$package_name) = @_;
	if($package_name) {
		$sunix_spec->{_package_name} = $package_name;
		# print ("sunix_spec,set_package_name,name: $package_name\n");
	} else {
		print ("sunix_spec, set_package_namen, package name missing");
	}

}


=head2 sub get_tail_section

 a small section of the file

=cut

sub get_tail_section {
 	my ($self) = @_;
	my @head;
#    $head[0]   = '=head2 sub variables'."\n";
#    $head[1]   = ''."\n";
#    $head[2]   = ' 	return a hash array '."\n";
#    $head[3]   = ' 	with definitions'."\n";
#    $head[4]   = ' '."\n";
#    $head[5]   = '=cut'."\n";
#    $head[6]   = ' '."\n";
#    $head[7]   = ' sub variables {'."\n";
#    $head[8]   = ' 	my $self = @_;'."\n";
#    $head[9]   = ' 	my $hash_ref = $suxgraph_spec;'."\n";
#    $head[10]  = ' 	return ($hash_ref);'."\n";
#    $head[11]  = ' }'."\n";
#    $head[12]  = ''."\n";
    $head[0]  = "\n".'1;'."\n";
    # print ("sunix_spec, get_tail_section:\n @head\n");
 	return (\@head);
}
	

1;
