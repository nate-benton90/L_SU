package suxgraph_spec;
	use Moose;
	our $VERSION = '1.0.1';
	use SeismicUnix qw ($su $suffix_su);

	my $get					= new SeismicUnixPlTk_global_constants();
	my $var					= $get->var();

	my $true      			= $var->{_true};
	my $false      			= $var->{_false};

	my $Project 			= new Project;
	my $suxgraph			= new suxgraph;

	my $DATA_SEISMIC_SU  	= $Project->DATA_SEISMIC_SU();   # output data directory
	my $max_index           = $suxgraph->get_max_index();

	my $suxgraph_spec = {
		_DATA_DIR_IN		    => $DATA_SEISMIC_SU,
	 	_DATA_DIR_OUT		    => $DATA_SEISMIC_SU,
	 	_data_type_in			=> $su,
		_data_suffix_in			=> $suffix_su,
		_data_type_out			=> $su,
	 	_data_suffix_out		=> $suffix_su,
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

=head2 sub variables

 	return a hash array 
 	with definitions
 
=cut
 
 sub variables {
 	my $self = @_;
 	my $hash_ref = $suxgraph_spec;
 	return ($hash_ref);
 }

1;
