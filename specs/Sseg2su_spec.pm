package Sseg2su_spec;
 	our $VERSION = '1.00';
	use Moose;
    use Project;
    use Sseg2su_config;
	use SeismicUnixPlTk_global_constants;
    use SeismicUnix qw ($seg2 $su $suffix_DAT $suffix_su);
    	
 	my $get					= new SeismicUnixPlTk_global_constants();
 	my $var					= $get->var();
 	my $file_dialog_type	= $get->file_dialog_type_href();
 	my $flow_type			= $get->flow_type_href();
 	
	my $true      			= $var->{_true};
	my $false      			= $var->{_false};
	my $Project 			= new Project;
	my $Sseg2su_config		= new Sseg2su_config;
	
	my $DATA_SEISMIC_SU  	= $Project->DATA_SEISMIC_SU();   # output data directory
	my $DATA_SEISMIC_SEG2   = $Project->DATA_SEISMIC_SEG2(); # input data directory
	my $max_index           = $Sseg2su_config->get_max_index();
	
	
=pod

   
    max_index from local Sseg2su.config file

=cut
	my $Sseg2su_spec = {
	_DATA_DIR_IN		    => $DATA_SEISMIC_SEG2,
	_DATA_DIR_OUT		    => $DATA_SEISMIC_SU,
	_binding_index_aref	    => '',
	_data_type_in			=> $seg2,
	_data_suffix_in			=> $suffix_DAT,
	_data_type_out			=> $su,
	_data_suffix_out		=> $suffix_su,	
	_file_dialog_type_aref	=> '',
	_flow_type_aref			=> '',
	_has_infile				=> $false,	# internally yes but not in the superflow list
	_has_pipe_in			=> $false,	# internally yes but not in the superflow list
	_has_pipe_out           => $false,	# internally yes but not in the superflow list 
	_has_redirect_in		=> $false,  # internally yes but not in the superflow list
	_has_redirect_out		=> $false,  # internally yes but not in the superflow list
	_has_subin_in			=> $false,  # internally yes but not in the superflow list
	_has_subin_out			=> $false,  # not in the superflow list
	_is_data				=> $false,  # superflow
	_is_first_of_2			=> $false,  # not part of a list of sunix programs
	_is_first_of_3or_more	=> $false,  # not part of a list of sunix programs
	_is_first_of_4or_more	=> $false,  # not part of a list of sunix programs
	_is_last_of_2			=> $false,  # not part of a list of sunix programs
	_is_last_of_3or_more	=> $false,  # not part of a list of sunix programs
	_is_last_of_4or_more	=> $false,  # not part of a list of sunix programs
	_is_suprog				=> $false,  # not a direct sunix program
	_is_superflow			=> $true,
	_max_index              => $max_index,		# max 2 variables
};
 
=head2 sub binding_index_aref

=cut

 sub binding_index_aref {
	my $self 	= @_;
	my @index;
	
	$index[0]	= 0;
	
	$Sseg2su_spec->{_binding_index_aref} = \@index;
	
	return();
 }
 
=head2 sub get_binding_index_aref

=cut

 sub get_binding_index_aref{
	my $self 	= @_;
	my @index;
	
	if ($Sseg2su_spec->{_binding_index_aref} ) {
		my $index_aref = $Sseg2su_spec->{_binding_index_aref};
		return($index_aref);
		
	}else {
		print("Sseg2su_spec, get_binding_index_aref, missing binding_index_aref\n");
		return();
	}

	my $index_aref = $Sseg2su_spec->{_binding_index_aref};
	
	
 }

 
=head2 sub get_max_index

=cut

sub get_max_index {
	my $self	= @_;
	
	if ( $Sseg2su_spec->{_max_index} ) {		

		my $max_idx           	  = $Sseg2su_config->get_max_index();
		return($max_idx);
		
	} else {
		print("Sseg2su_spec, get_max_index, missing max_index\n");
		return();
	}
} 

 
=head2 sub file_dialog_type_aref

=cut 

 sub file_dialog_type_aref{
	my $self = @_;
	
	my @type;
	
	$type[0]= '';
	
	$Sseg2su_spec->{_file_dialog_type_aref} = \@type;
	
	return();
	
 } 
 
=head2 sub get_file_dialog_type_aref

=cut 

 sub get_file_dialog_type_aref{
	my $self = @_;
	
	if ( $Sseg2su_spec->{_file_dialog_type_aref}) {
		my @type	  =  @{$Sseg2su_spec->{_file_dialog_type_aref}};	
		return(\@type);
	} else {
		print("Sseg2su_spec,get_file_dialog_type_aref, missing file_dialog_type_aref\n");
		return();
	}
 }
 
=head2 sub flow_type_aref

=cut 

 sub flow_type_aref{
	my $self = @_;
	
	my @type;
	
	$type[0]		= $flow_type->{_pre_built_superflow};
	
	$Sseg2su_spec	->{_flow_type_aref} = \@type;
	
	return();
	
 }
  
=head2 sub get_flow_type_aref

=cut 

 sub get_flow_type_aref{
	my $self = @_;
	
	if ( $Sseg2su_spec->{_flow_type_aref} ) { 				
		my $type_aref = $Sseg2su_spec->{_flow_type_aref};
		return($type_aref);			
	} else {
		
		print("Sseg2su_spec, get_flow_type_aref, missing flow_type_aref \n");
		return();
	}	
 }
 
=head2 sub get_binding_length

=cut 

 sub get_binding_length{
	my $self = @_;
		
	if ( $Sseg2su_spec->{_binding_index_aref} ) { 		
		my $length;
		$length = scalar @{$Sseg2su_spec->{_binding_index_aref}};
		return($length);
		
	} else {
		
		print("Sseg2su_spec, get_binding_length, missing length \n");
		return();
	}
	
 }
 
=head2 sub variables

	return a hash array 
	with definitions

=cut

sub variables {
	my $self = @_;
						# print("Sseg2su_spec,variables,
						# first_of_2,$Sseg2su_spec->{_is_first_of_2}\n");
	my $hash_ref = $Sseg2su_spec;
	return ($hash_ref);
}

1;
