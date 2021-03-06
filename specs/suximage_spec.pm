package suximage_spec;
 	our $VERSION = '1.00';
	use Moose;
	use SeismicUnixPlTk_global_constants;
	
	use Project;
	use suximage;
	use SeismicUnix qw ($su $suffix_su);
	
 	my $get					= new SeismicUnixPlTk_global_constants();
 	my $var					= $get->var();

	my $true      			= $var->{_true};
	my $false      			= $var->{_false};
 	my $file_dialog_type	= $get->file_dialog_type_href();
 	my $flow_type			= $get->flow_type_href();
 	
	
	my $Project 			= new Project;
	my $suximage			= new suximage;
	
	my $DATA_SEISMIC_SU  	= $Project->DATA_SEISMIC_SU();   # output data directory
	my $max_index           = $suximage->get_max_index();
	
	my $is_absclip 			= $false;
	my $is_loclip 			= $false;
	my $is_hiclip 			= $false;
	
	my $suximage_spec = {
	_DATA_DIR_IN		    => $DATA_SEISMIC_SU,
	_DATA_DIR_OUT		    => $DATA_SEISMIC_SU,
	_binding_index_aref	    => '',
	_data_type_in			=> $su,
	_data_suffix_in			=> $suffix_su,
	_data_type_out			=> $su,
	_data_suffix_out		=> $suffix_su,
	_good_labels_aref		=> '',  # new
	_file_dialog_type_aref	=> '',
	_flow_type_aref			=> '',
	_has_infile				=> $true,	
	_has_pipe_in			=> $true,	
	_has_pipe_out           => $false,	 
	_has_redirect_in		=> $true,
	_has_redirect_out		=> $false,
	_has_subin_in			=> $false,
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
 
 # print("suximage_spec, _incompatibles: @{$suximage_spec->{_incompatibles}} \n");
 
=head2 sub binding_index_aref

=cut

 sub binding_index_aref {
	my $self 	= @_;
	my @index;
	
	$index[0]	= 0;
	
	$suximage_spec->{_binding_index_aref} = \@index;
	
	return();
 }
 
 
   
=head2 sub get_max_index

=cut

sub get_max_index {
	my $self	= @_;
	
	if ( $suximage_spec->{_max_index} ) {		

		my $max_idx           	  = $suximage->get_max_index();
		return($max_idx);
		
	} else {
		print("suximage_spec, get_max_index, missing max_index\n");
		return();
	}
} 
 
=head2 sub set_good_labels       
	 
	set value labels that are good

=cut

 sub set_good_labels{
	my ($self,$good_labels_aref) 	= @_;
	
	$suximage_spec->{_good_labels_aref} = $good_labels_aref;
	
	return();
 }
 

 
=head2 sub find_incompatibles
	not_compatible for the following cases
	is_absclip && (is_loclip || is_hiclip)
	     1             1         
	 
	set value labels that are good

=cut

 sub set_incompatibles{
	my ($self) 	= @_;
	
	my @good_labels_aref 	= $suximage_spec->{_good_labels_aref};
	
	my $length 				= scalar @good_labels_aref;
				
	for (my $j=0; $j < $length; $j++ ) {
		
		my $good_label = $good_labels_aref[$j];
		
		if 		( $good_label eq  'absclip')    { 	$is_absclip 	= $true;
			
		} elsif ( $good_label eq  'hiclip' ) 	{	$is_hiclip 		= $true;
									
		} elsif ( $good_label eq  'loclip' )	{ 	$is_loclip 		= $true;
							
		} else {
			print("suximage_spec, set_incompatibles, NONE \n");					
		}
	}
			
 }
 
=head2 sub get_incompatibles
	not_compatible for the following cases
	is_absclip && (is_loclip || is_hiclip)
	     1             1         
	 
	set value labels that are good

=cut

sub get_incompatibles {
	
	my ($self) 	= @_;
		
	if ($is_absclip && ($is_loclip || $is_hiclip)) {		
		print("Warning: Can not have absclip and (hiclip or loclip)\n");
		return();
	} else {		
		print("No incompatibles\n");
	}	
 }
 
 
=head2 sub get_binding_index_aref

=cut

 sub get_binding_index_aref{
	my $self 	= @_;
	my @index;
	
	if ($suximage_spec->{_binding_index_aref} ) {
		my $index_aref = $suximage_spec->{_binding_index_aref};
		return($index_aref);
		
	}else {
		print("suximage_spec, get_binding_index_aref, missing binding_index_aref\n");
		return();
	}

	my $index_aref = $suximage_spec->{_binding_index_aref};
	
	
 }
 
=head2 sub file_dialog_type_aref

=cut 

 sub file_dialog_type_aref{
	my $self = @_;
	
	my @type;
	
	$type[0]= '';
	
	$suximage_spec->{_file_dialog_type_aref} = \@type;
	
	return();
	
 } 
 
=head2 sub get_file_dialog_type_aref

=cut 

 sub get_file_dialog_type_aref{
	my $self = @_;
	
	if ( $suximage_spec->{_file_dialog_type_aref}) {
		my @type	  =  @{$suximage_spec->{_file_dialog_type_aref}};	
		return(\@type);
	} else {
		print("suximage_spec,get_file_dialog_type_aref, missing file_dialog_type_aref\n");
		return();
	}
 }

=head2 sub flow_type_aref

=cut 

 sub flow_type_aref{
	my $self = @_;
	
	my @type;
	
	$type[0]		= $flow_type->{_user_built};
	
	$suximage_spec	->{_flow_type_aref} = \@type;
	
	return();
	
 }
  
=head2 sub get_flow_type_aref

=cut 

 sub get_flow_type_aref{
	my $self = @_;
	
	if ( $suximage_spec->{_flow_type_aref} ) { 				
		my $type_aref = $suximage_spec->{_flow_type_aref};
		return($type_aref);			
	} else {
		
		print("suximage_spec, get_flow_type_aref, missing flow_type_aref \n");
		return();
	}	
 }
 
=head2 sub get_binding_length

=cut 

 sub get_binding_length{
	my $self = @_;
		
	if ( $suximage_spec->{_binding_index_aref} ) { 		
		my $length;
		$length = scalar @{$suximage_spec->{_binding_index_aref}};
		return($length);
		
	} else {
		
		print("suximage_spec, get_binding_length, missing length \n");
		return();
	}
	
 }
 
=head2 incompatible parameters
	whose product is 1

=cut
	my @compatible_clips  = ('hiclip','loclip');
	my @incomp_clips = ('hiclip','loclip','perc','abs');
	
	my $incompatibles = {
		_clips  	 	=> \@incomp_clips,
	};

=head2 sub variables

	return a hash array 
	with definitions

=cut

sub variables {
	my $self = @_;
						# print("suximage_spec,variables,
						# first_of_2,$suximage_spec->{_is_first_of_2}\n");
	my $hash_ref = $suximage_spec;
	return ($hash_ref);
}

1;
