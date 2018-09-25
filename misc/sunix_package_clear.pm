package sunix_package_clear;
use Moose;

	my @lines;

=head2 encapsualted variables

=cut

 my $sunix_package_clear = {
		_package_name      => '',
		_param_names   		=> '',
    };

=head2 sub param_names

  print("sunix_package_clear,name,@lines\n");

=cut

sub  param_names{
 	my ($self,$name_aref) = @_;
 	my ($first,$last,$i,$package_name);

 	$sunix_package_clear->{_param_names} = $name_aref;
	$package_name				= $sunix_package_clear->{_package_name};

	my $length 					= scalar @$name_aref; 
 	$lines[0] 					= ("\n");
 	$lines[1] 					= ("\tsub clear")." {\n";

 	for ($i=2, my $j=0; $j < $length ; $i++,$j++) {
  		$lines[$i] 		= "\t\t".'$'.$package_name.'->{_'.@$name_aref[$j].'}'."\t\t\t".'=    \'\';'.("\n");
	}

	$lines[$i] 	=  "\t".'}'.("\n");
    $lines[++$i] 		=  ("\n");
}


=head2 sub package_name

  print("sunix_package_clear,name,@lines\n");

=cut

	sub package_name {
 		my ($self,$name_href) = @_;
 		$sunix_package_clear->{_package_name} = $name_href;
 		return();
	}


=head2 sub section 

 print("sunix_package_clear,section,@lines\n");

=cut

	sub section {
 		my ($self) = @_;
 		return (\@lines);
	}

1;
