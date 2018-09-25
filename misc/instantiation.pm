package instantiation;

use Moose;
our $VERSION = '0.0.2';

=head2 Default perl lines for instantiation
       of imported packages V 0.0.1
       ew 
	V 0.0.2 July 24 2018 include data_in, include data_out

=cut


=head2 program parameters
	 
  private hash
  
=cut


	my $instantiation = {
    	_prog_names_aref   	=> '',
 	};


 my @instantiation;


sub section {
 return (\@instantiation);
}

=head2 sub set_prog_names_aref

=cut
sub set_prog_names_aref {
	my ($self,$hash_aref) = @_;

	if ( $hash_aref ) {

    	$instantiation->{_prog_names_aref} 	= $hash_aref->{_prog_names_aref}; 
		my @prog_name    					= @{$instantiation->{_prog_names_aref}}; 
		my $length       = scalar @prog_name;

							# default programs
 		$instantiation[0] = 
 		"\n\t".'my $log'."\t\t\t\t\t".'= new message();';
 		$instantiation[1] = 
 		"\t".'my $run'."\t\t\t\t\t".'= new flow();';

		# user-defined programs
		for (my $i = 0, my $j = 2; $i <$length ; $i++) {
			# if(($prog_name[$i] ne 'data_out') )  {  # exclude data_out module removed in V 0.0.2
		 					#print("2. instantiation,set_prog_names_aref, prog_name=$prog_name[$i]\n");
 			$instantiation[$j] = 
 			"\t".'my $'.$prog_name[$i]."\t\t\t\t".'= new '.$prog_name[$i].'();';
			$j++;
			#} 
		}
	}
	return();
}

1;
