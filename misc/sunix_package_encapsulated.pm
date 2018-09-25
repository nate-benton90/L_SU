package sunix_package_encapsulated;
use Moose;

	my @lines;

=head2 encapsulated variables

=cut

 my $sunix_package_encapsulated = {
		_package_name      => '',
		_subroutine_name   => '',
		_param_names   	    => '',
    };

=head2 sub set_param_names

  print("sunix_package_encapsulated,name,@lines\n");

=cut

sub  set_param_names{
 	my ($self,$name_aref) = @_;
 	my ($first,$last,$i,$package_name);

 	$sunix_package_encapsulated->{_param_names} = $name_aref;
	$package_name				= $sunix_package_encapsulated->{_package_name};
	my $length 					= scalar @$name_aref; 
 	$lines[0] 					= ("\n");
 	$lines[1] 					= ("\tmy ").'$'.$package_name."\t\t".'='.(" {\n");

 	for ($i=2, my $j=0; $j < $length ; $i++,$j++) {
  		$lines[$i] 		= "\t\t".'_'.@$name_aref[$j]."\t\t\t\t\t".'=>    \'\','.("\n");
	}

	$lines[$i] 	=  '    };'.("\n");
    $lines[++$i] 		=  ("\n");
}


=head2 sub set_package_name

=cut

	sub set_package_name {
 		my ($self,$name_href) = @_;
 		$sunix_package_encapsulated->{_package_name} = $name_href;
 		 # print("sunix_package_encapsulated,set_package_name,$sunix_package_encapsulated->{_package_name}\n");
 		return();
	}


=head2 sub get_section 

 print("sunix_package_encapsulated,get_section,@lines\n");

=cut

	sub get_section {
 		my ($self) = @_;
 		return (\@lines);
	}

1;
