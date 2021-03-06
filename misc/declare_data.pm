package declare_data;
use Moose;

=pod

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PACKAGE NAME: data_in 
 AUTHOR: Juan Lorenzo
 DATE:   Nov 29 2017,

 DESCRIPTION: 
 Version: 1.1

=head2 USE

=head3 NOTES 

=head4 
 Examples

=head3 SEISMIC UNIX NOTES  


=head4 CHANGES and their DATES


=cut

=head2 Default perl lines for

     declaring required packages

=cut

=head2 data
	 
  private hash

=cut


	my $declare_data = {
    	_type 	   			    	=> '',
    	_type_in    		    	=> '',
    	_type_out	 	   		    => '',
    	_param_labels_aref 	   		=> '',
    	_param_values_aref 	   		=> '',
 	};

	my (@data_in,@data_out,@inbound_notes,@outbound_notes);

=head2 sub get_section


=cut

sub empty {
	my $self =@_;

    $outbound_notes[0] 	= "";

 	return ();
}

sub inbound_section {
	my $self =@_;
				# print("declare_data,inbound_section,notes:\n @inbound_notes\n");

 	return (\@inbound_notes);

}


sub outbound_section {
	my $self =@_;
					# print("declare_data,outbound_section,notes:\n @outbound_notes\n");
 	return (\@outbound_notes);

}

sub set_bin_in {

 	$inbound_notes[1] = "\t".'my (@file_in);'.
	"\n\t".'my (@bin_file_in,@inbound);';
	$inbound_notes[2] 	= "\t".'$bin_file_in[1]'."\t".'= $file_in[1].$suffix_bin;';
	$inbound_notes[3] 	= "\t".'$inbound[1]'."\t".'= $DATA_SEISMIC_BIN.'."'/'".'.$bin_file_in[1];';
}

sub set_bin_out {
 	$outbound_notes[1] = "\t".'my (@file_out);'.
	"\n\t".'my (@bin_file_out,@outbound);';

	$outbound_notes[2] 	= "\t".'$bin_file_out[1]'."\t".'= $file_out[1].$suffix_bin;';
	$outbound_notes[3] 	= "\t".'$outbound[1]'."\t".'= $DATA_SEISMIC_BIN.'."'/'".'.$bin_file_out[1];';
}

sub set_text_in {

 	$inbound_notes[1] = "\t".'my (@file_in);'.
	"\n\t".'my (@text_file_in,@inbound);';
	$inbound_notes[2] = "\t".'$text_data_in[1]'."\t".'= $file_in[1].$suffix_text;';
	$inbound_notes[3] = "\t".'$inbound[1]'."\t".'= $DATA_SEISMIC_TXT.'."'/'".'.$text_data_in[1];';

}

sub set_text_out {
 	$outbound_notes[1] = "\t".'my (@file_out);'.
	"\n\t".'my (@text_file_out,@outbound);';

	$outbound_notes[2] = "\t".'$text_data_out[1]'."\t".'= $file_out[1].$suffix_text;';
	$outbound_notes[3] = "\t".'$outbound[1]'."\t".'= $DATA_SEISMIC_TXT.'."'/'".'.$text_data_out[1];';

}

sub set_su_in {
 	$inbound_notes[1] = "\t".'my (@file_in);'.
	"\n\t".'my (@sudata_in,@inbound);';

	$inbound_notes[2] = "\t".'$sudata_in[1]'."\t".'= $file_in[1].$suffix_su;';
	$inbound_notes[3] = "\t".'$inbound[1]'."\t".'= $DATA_SEISMIC_SU.'."'/'".'.$sudata_in[1];';

}

sub set_su_out {

 	$outbound_notes[1] = "\t".'my (@file_out);'.
	"\n\t".'my (@sudata_out,@outbound);';
	$outbound_notes[2] = "\t".'$sudata_out[1]'."\t".'= $file_out[1].$suffix_su;';
	$outbound_notes[3] = "\t".'$outbound[1]'."\t".'= $DATA_SEISMIC_SU.'."'/'".'.$sudata_out[1];';

}


=head2 sub private_set_su_out   

prepare to use su files

=cut

sub private_set_su_out {
    my ($self)  = @_;
    $outbound_notes[0] 	= "\n\t".'my ($DATA_SEISMIC_SU) = $Project->DATA_SEISMIC_SU();';
	

}

=head2 sub private_set_text_out   

prepare to use su files

=cut

sub private_set_text_out {
    my ($self)   = @_;
    $outbound_notes[0] = "\n\t".'my ($DATA_SEISMIC_TXT) = $Project->DATA_SEISMIC_TXT();';

}


=head2 sub private_set_bin_out   

prepare to use su files

=cut

sub private_set_bin_out {
    my ($variable)   = @_;
    $outbound_notes[0] = "\n\t".'my ($DATA_SEISMIC_BIN) = $Project->DATA_SEISMIC_BIN();';


}

=head2 sub private_set_su_in   

prepare to use su files

=cut

sub private_set_su_in {
    my ($self)  = @_;
    $inbound_notes[0] 	= "\n\t".'my ($DATA_SEISMIC_SU) = $Project->DATA_SEISMIC_SU();';
}


=head2 sub private_set_text_in   

prepare to use su files

=cut

sub private_set_text_in {
    my ($self)   = @_;
    $inbound_notes[0] = "\n\t".'my ($DATA_SEISMIC_TXT) = $Project->DATA_SEISMIC_TXT();';

}


=head2 sub private_set_bin_in   

prepare to use su files

=cut

sub private_set_bin_in {
    my ($variable)   = @_;
    $inbound_notes[0] = "\n\t".'my ($DATA_SEISMIC_BIN) = $Project->DATA_SEISMIC_BIN();';


}



=pod

=head2 subroutine  set_type_in

  you need to know how many numbers per line
  will be in the output file 

=cut

sub set_type_in {
    my ($variable,$type_in)   = @_;
	if( $type_in ) {
 		
		if ( $type_in eq 'su'  ) { 

			# print("declare-data,set_type_in,type_in:$type_in\n");
			private_set_su_in(); 	
		}
		if ( $type_in eq 'text') { private_set_text_in();  	}
		if ( $type_in eq 'bin' ) { private_set_bin_in();  	}
	}
 }

=head2 subroutine  set_typeout_

  you need to know how many numbers per line
  will be in the output file 

=cut

sub set_type_out {
    my ($variable,$type_out)   = @_;
	if( $type_out ) {
 		
		if ( $type_out eq 'su'  ) { 

			 print("declare-data,set_type_out,type_out:$type_out\n");
			private_set_su_out(); 	
		}
		if ( $type_out eq 'text') { private_set_text_out();  	}
		if ( $type_out eq 'bin' ) { private_set_bin_out();  	}
	}
 }



1;
