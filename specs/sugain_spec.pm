package sugain_spec;
 	our $VERSION = '0.0.1';
	use Moose;
	use SeismicUnixPlTk_global_constants;
	use Project;
	use sugain;
	use SeismicUnix qw ($su $suffix_su);
	
 	my $get					= new SeismicUnixPlTk_global_constants();
 	my $var					= $get->var();
 	my $file_dialog_type	= $get->file_dialog_type_href();
 	my $flow_type			= $get->flow_type_href();
 	
	my $true      			= $var->{_true};
	my $false      			= $var->{_false};
	
	my $Project 			= new Project;
	my $sugain				= new sugain;
	
	my $DATA_SEISMIC_SU  	= $Project->DATA_SEISMIC_SU();   # output data directory
	my $max_index           = $sugain->get_max_index();

	my $sugain_spec = {
	_DATA_DIR_OUT		    => $DATA_SEISMIC_SU,
	_DATA_DIR_OUT		    => $DATA_SEISMIC_SU,
	_binding_index_aref	    => '',
	_data_type_in			=> $su,
	_data_suffix_in			=> $suffix_su,
	_data_type_out			=> $su,
	_data_suffix_out		=> $suffix_su,
	_file_dialog_type_aref	=> '',
	_flow_type_aref			=> '',	
	_has_infile				=> $true,	
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


=head2  sub get_incompatible 

	parameters

=cut

sub get_incompatibles {
	my $self = @_;
	
	my (@needed);
	my @_need_both		= ();
	my @_need_only_1	= ();
	my @_none_needed 	= ();
	my @_all_needed	 	= ();
	
	my $params = {
		_need_both		=> \@_need_both,
		_need_only_1	=> \@_need_only_1,
		_none_needed	=> \@_none_needed,
		_all_needed		=> \@_all_needed,		
	};
	
	#my $number_groups  = 6;
	
	my @of_seven 				= 	('pbal','mbal','agc','tpow','epow','etpow','gpow');		
	push $params->{_need_only_1}	,	\@of_seven;
	
	my @of_two          		= 	('tpow','jon');
	push $params->{_need_only_1}	,	\@of_two;
		
	my @of_two_2           		= 	('gpow','jon');
	push $params->{_need_only_1}	,	\@of_two_2;
		
	my @of_two_3           		= 	('qclip','jon');
	push $params->{_need_only_1}	,	\@of_two_3;
	
	my @of_two_4    			= 	('agc','wagc');
	push $params->{_need_both}	, 	\@of_two_4;
	
	my @of_two_5   				= 	('agc','gagc');
	push $params->{_need_both}	, 	\@of_two_5;


#	print("sugain, get_incomatpibles  $length \n");
	
	my $len_1_needed = scalar @{$params->{_need_only_1}};
	
	for (my $i=0; $i < $len_1_needed; $i++) {
		
		print("sugain, get_incompatibles,need_only_1:  @{@{$params->{_need_only_1}}[$i]}\n");
		
	}
	
	my $len_2_needed = scalar @{$params->{_need_both}};
	
	for (my $i=0; $i < $len_2_needed; $i++) {
		
		print("sugain, get_incompatibles,need_both:  @{@{$params->{_need_both}}[$i]}\n");
		
	}
	
#	print("sugain, get_incomatpibles only_one: @only_one\n");
	

	return($params);
	
}
 		
=head2 sub binding_index_aref

=cut

 sub binding_index_aref {
	my $self 	= @_;
	my @index;
	
	$index[0]	= 0;
	
	$sugain_spec->{_binding_index_aref} = \@index;
	
	return();
 }
 
=head2 sub get_binding_index_aref

=cut

 sub get_binding_index_aref{
	my $self 	= @_;
	my @index;
	
	if ($sugain_spec->{_binding_index_aref} ) {
		my $index_aref = $sugain_spec->{_binding_index_aref};
		return($index_aref);
		
	}else {
		print("sugain_spec, get_binding_index_aref, missing binding_index_aref\n");
		return();
	}

	my $index_aref = $sugain_spec->{_binding_index_aref};
	
	
 }
 
=head2 sub file_dialog_type_aref

=cut 

 sub file_dialog_type_aref{
	my $self = @_;
	
	my @type;
	
	$type[0]= '';
	
	$sugain_spec->{_file_dialog_type_aref} = \@type;
	
	return();
	
 }
 
   
=head2 sub get_max_index

=cut

sub get_max_index {
	my $self	= @_;
	
	if ( $sugain_spec->{_max_index} ) {		

		my $max_idx           	  = $sugain->get_max_index();
		return($max_idx);
		
	} else {
		print("sugain_spec, get_max_index, missing max_index\n");
		return();
	}
} 
 
=head2 sub get_file_dialog_type_aref

=cut 

 sub get_file_dialog_type_aref{
	my $self = @_;
	
	if ( $sugain_spec->{_file_dialog_type_aref}) {
		my @type	  =  @{$sugain_spec->{_file_dialog_type_aref}};	
		return(\@type);
	} else {
		print("sugain_spec,get_file_dialog_type_aref, missing file_dialog_type_aref\n");
		return();
	}
 }
 
=head2 sub flow_type_aref

=cut 

 sub flow_type_aref{
	my $self = @_;
	
	my @type;
	
	$type[0]		= $flow_type->{_user_built};
	
	$sugain_spec	->{_flow_type_aref} = \@type;
	
	return();
	
 }
  
=head2 sub get_flow_type_aref

=cut 

 sub get_flow_type_aref{
	my $self = @_;
	
	if ( $sugain_spec->{_flow_type_aref} ) { 				
		my $type_aref = $sugain_spec->{_flow_type_aref};
		return($type_aref);			
	} else {
		
		print("sugain_spec, get_flow_type_aref, missing flow_type_aref \n");
		return();
	}	
 }
 
=head2 sub get_binding_length

=cut 

 sub get_binding_length{
	my $self = @_;
		
	if ( $sugain_spec->{_binding_index_aref} ) { 		
		my $length;
		$length = scalar @{$sugain_spec->{_binding_index_aref}};
		return($length);
		
	} else {
		
		print("sugain_spec, get_binding_length, missing length \n");
		return();
	}
	
 }
 
=head2 sub variables

	return a hash array 
	with definitions

=cut

sub variables {
	my $self = @_;
	my $hash_ref = $sugain_spec;
	return ($hash_ref);
}

1;	
