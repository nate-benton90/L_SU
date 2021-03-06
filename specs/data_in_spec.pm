package data_in_spec;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PERL PROGRAM NAME: data_in_spec.pm 
 AUTHOR: 	Juan Lorenzo
 DATE: 		June 22 2017
  

 DESCRIPTION 
     

 BASED ON:
 Version 0.0.1 June 22 2017

 Version 0.0.2 July 22 2018


=cut

=head2 USE

=head3 NOTES

=head4 Examples


=head2 CHANGES and their DATES
  Version 0.0.2 July 22 2018 added subs: 
  	type, inbound  _get_inbound
  	_get_suffix, _get_DIR

=cut 
 
 	our $VERSION = '0.0.2';
	use Moose;
	use data_in;
	use SeismicUnixPlTk_global_constants;
	
	use SeismicUnix qw ($su $suffix_su);
	
 	my $get					= new SeismicUnixPlTk_global_constants();
 	my $var					= $get->var();
 	my $file_dialog_type	= $get->file_dialog_type_href();
 	my $flow_type			= $get->flow_type_href();
 	
	my $true      			= $var->{_true};
	my $false      			= $var->{_false};
	my $Project 			= new Project;
	
	my $DATA_SEISMIC_SU  	= $Project->DATA_SEISMIC_SU();   # output data directory

	
	my $data_in             = new data_in;
	my $max_index           = $data_in->get_max_index();

	my $data_in_spec = {
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
	_is_data				=> $true,
	_is_first_of_2			=> $false,
	_is_first_of_3or_more	=> $false,
	_is_first_of_4or_more	=> $false,
	_is_last_of_2			=> $true,
	_is_last_of_3or_more	=> $false,
	_is_last_of_4or_more	=> $false,
	_is_suprog				=> $false,
	_is_superflow			=> $false,
	_max_index              => $max_index,
};
 
=head2 sub binding_index_aref

	help bind a parameter (in calling module) 
	to a callback via a mouse-click

=cut

 sub binding_index_aref {
	my $self 	= @_;
	my @index;
	
	$index[0]	= 0;  # first item is bound to DATA_SEISMIC_SU
	
	$data_in_spec->{_binding_index_aref} = \@index;
	
	return();
 }
 
=head2 sub get_binding_index_aref

=cut

 sub get_binding_index_aref{
	my $self 	= @_;
	my @index;
	
	if ($data_in_spec->{_binding_index_aref} ) {
		my $index_aref = $data_in_spec->{_binding_index_aref};
		return($index_aref);
		
	}else {
		print("data_in_spec, get_binding_index_aref, missing binding_index_aref\n");
		return();
	}

	my $index_aref = $data_in_spec->{_binding_index_aref};
	
	
 }

 
=head2 sub get_max_index

=cut

sub get_max_index {
	my $self	= @_;
	
	if ( $data_in_spec->{_max_index} ) {		

		my $max_idx           	  = $data_in->get_max_index();
		return($max_idx);
		
	} else {
		print("data_in_spec, get_max_index, missing max_index\n");
		return();
	}
}
 
=head2 sub file_dialog_type_aref

=cut 

 sub file_dialog_type_aref{
	my $self = @_;
	
	my @type;
	
	$type[0]= $file_dialog_type->{_Data};
	
	$data_in_spec->{_file_dialog_type_aref} = \@type;
	
	return();
	
 } 
 
=head2 sub get_file_dialog_type_aref

=cut 

 sub get_file_dialog_type_aref{
	my $self = @_;
	
	if ( $data_in_spec->{_file_dialog_type_aref}) {
		my @type	  =  @{$data_in_spec->{_file_dialog_type_aref}};	
		return(\@type);
	} else {
		print("data_in_spec,get_file_dialog_type_aref, missing file_dialog_type_aref\n");
		return();
	}
 }
 
=head2 sub flow_type_aref

=cut 

 sub flow_type_aref{
	my $self = @_;
	
	my @type;
	
	$type[0]		= $flow_type->{_user_built};
	
	$data_in_spec	->{_flow_type_aref} = \@type;
	
	return();
	
 }
  
=head2 sub get_flow_type_aref

=cut 

 sub get_flow_type_aref{
	my $self = @_;
	
	if ( $data_in_spec->{_flow_type_aref} ) { 				
		my $type_aref = $data_in_spec->{_flow_type_aref};
		return($type_aref);			
	} else {
		
		print("data_in_spec, get_flow_type_aref, missing flow_type_aref \n");
		return();
	}	
 }
 
=head2 sub get_binding_length

=cut 

 sub get_binding_length{
	my $self = @_;
		
	if ( $data_in_spec->{_binding_index_aref} ) { 		
		my $length;
		$length = scalar @{$data_in_spec->{_binding_index_aref}};
		return($length);
		
	} else {
		
		print("data_in_spec, get_binding_length, missing length \n");
		return();
	}
	
 }
 
=head2 sub variables

	return a hash array 
	with definitions

=cut

sub variables {
	my $self = @_;
	my $hash_ref = $data_in_spec;
	return ($hash_ref);
}

1;
