package iTopMute_spec;
 	our $VERSION = '1.00';
	use Moose;
	use Project;
	use SeismicUnixPlTk_global_constants;
	use iTopMute_config;
	use SeismicUnix qw ($su $suffix_su);
	
 	my $get					= new SeismicUnixPlTk_global_constants();
 	my $var					= $get->var();
 	my $file_dialog_type	= $get->file_dialog_type_href();
 	my $flow_type			= $get->flow_type_href();
 	
	my $true      			= $var->{_true};
	my $false      			= $var->{_false};
	
	my $Project 			= new Project;
	my $DATA_SEISMIC_SU  	= $Project->DATA_SEISMIC_SU();   # output data directory

	my $iTopMute_config     = new iTopMute_config;
	my $max_index           = $iTopMute_config->get_max_index();


	my $iTopMute_spec = {
	_DATA_DIR_IN		    => $DATA_SEISMIC_SU,
	_DATA_DIR_OUT		    => $DATA_SEISMIC_SU,
	_binding_index_aref	    => '',
	_data_type_in			=> $su,
	_data_suffix_in			=> $suffix_su,
	_data_type_out			=> $su,
	_data_suffix_out		=> $suffix_su,
	_file_dialog_type_aref	=> '',
	_flow_type_aref			=> '',
	_has_infile				=> $false,	
	_has_pipe_in			=> $false,	
	_has_pipe_out           => $false,	 
	_has_redirect_in		=> $false,
	_has_redirect_out		=> $false,
	_has_subin_in			=> $false,
	_has_subin_out			=> $false,
	_is_data				=> $false,
	_is_first_of_2			=> $false,
	_is_first_of_3or_more	=> $false,
	_is_first_of_4or_more	=> $false,
	_is_last_of_2			=> $false,
	_is_last_of_3or_more	=> $false,
	_is_last_of_4or_more	=> $false,
	_is_suprog				=> $false,
	_is_superflow			=> $true,
	_max_index              => $max_index,
};
 
=head2 sub binding_index_aref

=cut

 sub binding_index_aref {
	my $self 	= @_;
	my @index;
	
	$index[0]	= 0;
	
	$iTopMute_spec->{_binding_index_aref} = \@index;
	
	return();
 }
 
=head2 sub get_binding_index_aref

=cut

 sub get_binding_index_aref{
	my $self 	= @_;
	my @index;
	
	if ($iTopMute_spec->{_binding_index_aref} ) {
		my $index_aref = $iTopMute_spec->{_binding_index_aref};
		return($index_aref);
		
	}else {
		print("iTopMute_spec, get_binding_index_aref, missing binding_index_aref\n");
		return();
	}

	my $index_aref = $iTopMute_spec->{_binding_index_aref};
	
	
 }
 
 
=head2 sub get_max_index

=cut

sub get_max_index {
	my $self	= @_;
	
	if ( $iTopMute_spec->{_max_index} ) {		

		my $max_idx           	  = $iTopMute_config->get_max_index();
		return($max_idx);
		
	} else {
		print("iTopMute_spec, get_max_index, missing max_index\n");
		return();
	}
} 

 
=head2 sub file_dialog_type_aref

=cut 

 sub file_dialog_type_aref{
	my $self = @_;
	
	my @type;
	
	$type[0]= $file_dialog_type->{_Data};
	
	$iTopMute_spec->{_file_dialog_type_aref} = \@type;
	
	return();
	
 } 
 
=head2 sub get_file_dialog_type_aref

=cut 

 sub get_file_dialog_type_aref{
	my $self = @_;
	
	if ( $iTopMute_spec->{_file_dialog_type_aref}) {
		my @type	  =  @{$iTopMute_spec->{_file_dialog_type_aref}};	
		return(\@type);
	} else {
		print("iTopMute_spec,get_file_dialog_type_aref, missing file_dialog_type_aref\n");
		return();
	}
 }
 
=head2 sub flow_type_aref

=cut 

 sub flow_type_aref{
	my $self = @_;
	
	my @type;
	
	$type[0]		= $flow_type->{_pre_built_superflow};
	
	$iTopMute_spec	->{_flow_type_aref} = \@type;
	
	return();
	
 }
  
=head2 sub get_flow_type_aref

=cut 

 sub get_flow_type_aref{
	my $self = @_;
	
	if ( $iTopMute_spec->{_flow_type_aref} ) { 				
		my $type_aref = $iTopMute_spec->{_flow_type_aref};
		return($type_aref);			
	} else {
		
		print("iTopMute_spec, get_flow_type_aref, missing flow_type_aref \n");
		return();
	}	
 }
 
=head2 sub get_binding_length

=cut 

 sub get_binding_length{
	my $self = @_;
		
	if ( $iTopMute_spec->{_binding_index_aref} ) { 		
		my $length;
		$length = scalar @{$iTopMute_spec->{_binding_index_aref}};
		return($length);
		
	} else {
		
		print("iTopMute_spec, get_binding_length, missing length \n");
		return();
	}
	
 }
 
=head2 sub variables

	return a hash array 
	with definitions

=cut

sub variables {
	my $self = @_;
						# print("iTopMute_spec,variables,
						# first_of_2,$iTopMute_spec->{_is_first_of_2}\n");
	my $hash_ref = $iTopMute_spec;
	return ($hash_ref);
}

1;
