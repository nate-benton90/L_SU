package suwind_spec;
 	our $VERSION = '1.00';
	use Moose;
	use SeismicUnixPlTk_global_constants;
	use Project;
	use suwind;
	use SeismicUnix qw ($su $suffix_su);
	
 	my $get					= new SeismicUnixPlTk_global_constants();
 	my $var					= $get->var();
 	my $file_dialog_type	= $get->file_dialog_type_href();
 	my $flow_type			= $get->flow_type_href();
 	

	my $true      			= $var->{_true};
	my $false      			= $var->{_false};
	
	my $Project 			= new Project;
	my $suwind				= new suwind;
	
	my $DATA_SEISMIC_SU  	= $Project->DATA_SEISMIC_SU();   # output data directory
	my $max_index           = $suwind->get_max_index();
	
	my $suwind_spec = {
	_DATA_DIR_IN		    => $DATA_SEISMIC_SU,
	_DATA_DIR_OUT		    => $DATA_SEISMIC_SU,
	_binding_index_aref	    => '',
	_data_type_in			=> $su,
	_data_suffix_in			=> $suffix_su,
	_data_type_out			=> $su,
	_data_suffix_out		=> $suffix_su,
	_file_dialog_type_aref	=> '',
	_flow_type_aref			=> '',
	_has_pipe_in			=> $true,	
	_has_pipe_out           => $true,	 
	_has_redirect_in		=> $true,
	_has_redirect_out		=> $true,
	_has_subin_in			=> $false,
	_has_subin_out			=> $false,
	_is_data				=> $false,
	_is_first_of_2			=> $false,
	_is_first_of_3or_more	=> $true,
	_is_first_of_4or_more	=> $true,
	_is_last_of_2			=> $false,
	_is_last_of_3or_more	=> $false,
	_is_last_of_4or_more	=> $false,
	_is_suprog				=> $true,
	_is_superflow			=> $false,
	_max_index              => $max_index,
};
 
=head2 sub binding_index_aref

	starts at index=0, as per perl
	but index refers to the index of the value in
	the listbox. e.g. the fifth value down is index=4
	of the  listbox, although it may be in the index
	0 of the variable index only because there is only 1
	of variable that needs binding

=cut

 sub binding_index_aref {
	my $self 	= @_;
	my @listbox_index;
	
	$listbox_index[0]	= 0; #
	
	$suwind_spec->{_binding_index_aref} = \@listbox_index;
	
	return();
 }
 
=head2 sub get_binding_index_aref

=cut

 sub get_binding_index_aref{
	my $self 	= @_;
	my @index;
	
	if ($suwind_spec->{_binding_index_aref} ) {
		my $index_aref = $suwind_spec->{_binding_index_aref};
		return($index_aref);
		
	}else {
		print("suwind_spec, get_binding_index_aref, missing binding_index_aref\n");
		return();
	}

	my $index_aref = $suwind_spec->{_binding_index_aref};
	
	
 }
 
 
=head2 sub get_max_index

=cut

sub get_max_index {
	my $self	= @_;
	
	if ( $suwind_spec->{_max_index} ) {		

		my $max_idx           	  = $suwind->get_max_index();
		return($max_idx);
		
	} else {
		print("suwind_spec, get_max_index, missing max_index\n");
		return();
	}
} 

=head2 sub file_dialog_type_aref

    starts at type[0] but 
    refers to an index
    within a listbox and not the idnex of the
    variable: type
    
=cut 

 sub file_dialog_type_aref{
	my $self = @_;
	
	my @type;
	
	$type[0]= ''; # $file_dialog_type->{_Data}; # starts at index=0
	
	$suwind_spec->{_file_dialog_type_aref} = \@type;
	
	return();
	
 } 
 
=head2 sub get_file_dialog_type_aref

=cut 

 sub get_file_dialog_type_aref{
	my $self = @_;
	
	if ( $suwind_spec->{_file_dialog_type_aref}) {
		my @type	  =  @{$suwind_spec->{_file_dialog_type_aref}};	
		return(\@type);
	} else {
		print("suwind_spec,get_file_dialog_type_aref, missing file_dialog_type_aref\n");
		return();
	}
 }
 
=head2 sub flow_type_aref

=cut 

 sub flow_type_aref{
	my $self = @_;
	
	my @type;
	
	$type[0]		= $flow_type->{_user_built};
	
	$suwind_spec	->{_flow_type_aref} = \@type;
	
	return();
	
 }
  
=head2 sub get_flow_type_aref

=cut 

 sub get_flow_type_aref{
	my $self = @_;
	
	if ( $suwind_spec->{_flow_type_aref} ) { 				
		my $type_aref = $suwind_spec->{_flow_type_aref};
		return($type_aref);			
	} else {
		
		print("suwind_spec, get_flow_type_aref, missing flow_type_aref \n");
		return();
	}	
 }
 
=head2 sub get_binding_length

=cut 

 sub get_binding_length{
	my $self = @_;
		
	if ( $suwind_spec->{_binding_index_aref} ) { 		
		my $length;
		$length = scalar @{$suwind_spec->{_binding_index_aref}};
		return($length);
		
	} else {
		
		print("suwind_spec, get_binding_length, missing length \n");
		return();
	}
	
 }
 
=head2 sub variables

	return a hash array 
	with definitions

=cut

sub variables {
	my $self = @_;
	my $hash_ref = $suwind_spec;
	return ($hash_ref);
}

1;
