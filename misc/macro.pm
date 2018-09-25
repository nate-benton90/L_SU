package macro;
use Moose;

	my @lines;


	$lines[0] =

'=head2 SYNOPSIS

 PACKAGE NAME: 

 AUTHOR:  

 DATE:

 DESCRIPTION:

 Version:

=head2 USE

=head3 NOTES

=head4 Examples

=head2 SYNOPSIS

=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES

=cut 

 use Moose;'."\declare_pkgn";
 

sub section {
	my $self =@_;

 	return (\@macro);

}

1;
