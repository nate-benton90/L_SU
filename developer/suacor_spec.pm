package suacor_spec;
	use Moose;
	our $VERSION = '0.0.1';

	use Project;
	use SeismicUnix qw ($su $suffix_su);
	use SeismicUnixPlTk_global_constants;
	use suacor;

	my $get					= new SeismicUnixPlTk_global_constants();
	my $Project 			= new Project;
	my $suacor			    = new suacor;

	my $var					= $get->var();

	my $true      			= $var->{_true};
	my $false      			= $var->{_false};
	my $file_dialog_type	= $get->file_dialog_type_href();
	my $flow_type			= $get->flow_type_href();

	my $DATA_SEISMIC_SU  	= $Project->DATA_SEISMIC_SU();   # output data directory
	my $max_index           = $suacor->get_max_index();

	my $suacor_spec = {
		_DATA_DIR_IN		    => $DATA_SEISMIC_SU,
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
	 	_has_pipe_out           => $false,
	 	_has_redirect_in		=> $true,
	 	_has_redirect_out		=> $false,
	 	_has_subin_in			=> $true,
	 	_has_subin_out			=> $false,
	 	_is_data				=> $false,
		_is_first_of_2			=> $true,
		_is_first_of_3or_more	=> $false,
		_is_first_of_4or_more	=> $false,
	 	_is_last_of_2			=> $false,
	 	_is_last_of_3or_more	=> $true,
		_is_last_of_4or_more	=> $true,
		_is_suprog				=> $true,
	 	_is_superflow			=> $false,
	 	_max_index              => $max_index,
	};



	my $incompatibles = {
		clip              => ['mbal', 'pbal'],
	};

=head2  sub _sub_binding_index_aref

=cut

 sub binding_index_aref {

	my $self 	= @_;

	my @index;

	$index[0]	= 0;

	$suacor_spec ->{_binding_index_aref} = \@index;
	return();

 }


=head2 sub  	file_dialog_type_aref{

	my $self 	= @_;
	my @type ;

	$type[0]=;

	$suacor_spec->{_file_dialog_type_aref} = \@type;

		return();

	
 }


=head2 sub flow_type_aref

=cut

 sub flow_type_aref{

	my $self = @_;

	my @type;

	$type[0]		= $flow_type->{_user_built};

	$suacor_spec	->{_flow_type_aref} = \@type;

	return();

}


=head2 sub get_binding_index_aref

=cut

 sub get_binding_index_aref{

	my $self 	= @_;
	my @index;

	if ($suacor_spec->{_binding_index_aref} ) {

			my $index_aref = $suacor_spec->{_binding_index_aref};
			return($index_aref);

	} else {
		print("suacor_spec, get_binding_index_aref, missing binding_index_aref\n");
		return();
	}

	my $index_aref = $suacor_spec->{_binding_index_aref};

 }


=head2 sub get_binding_length

=cut

 sub get_binding_length{
	my $self = @_;

	if ( $suacor_spec->{_binding_index_aref} ) {

		my $length;

		$length = scalar @{$suacor_spec->{_binding_index_aref}};

		return($length);

	} else {
		print("suacor_spec, get_binding_length, missing length \n");
		return();
	}

 }


=head2 sub get_file_dialog_type_aref

=cut

 sub get_file_dialog_type_aref{

	my $self = @_;
	if ( $suacor_spec->{_file_dialog_type_aref}) {

		my @type	  =  @{$suacor_spec->{_file_dialog_type_aref}};

		return(\@type);

	} else {
		print("suacor_spec,get_file_dialog_type_aref, missing file_dialog_type_aref\n");
		return();
	 }

 }


=head2 sub get_flow_type_aref

=cut 

 sub get_flow_type_aref{
	my $self = @_;
	if ( $suacor_spec->{_flow_type_aref} ) {

			my $type_aref = $suacor_spec->{_flow_type_aref};

			return($type_aref);

	} else {
			print("suacor_spec, get_flow_type_aref, missing flow_type_aref \n");
			return();
	}
 }


=head2 sub _sub_get_max_index

=cut

 sub get_max_index {

	my $self	= @_;
	
	if ( $suacor_spec->{_max_index} ) {
	
		my $max_idx           	  = $suacor->get_max_index();
		return($max_idx);
	
	} else {
		print("suacor_spec, get_max_index, missing max_index\n");
	return();
	}
 }


=head2 sub variables
	return a hash array
	with definitions

=cut

 sub variables {

	my $self = @_;

	my $hash_ref = $suacor_spec;

	return ($hash_ref);

 }



1;