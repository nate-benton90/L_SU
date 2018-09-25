package package_tail;
use Moose;

=head2 Default perl lines for theend of a package 


=cut

 my @lines;

 $lines[0] = ("1; ");

sub section {
 my ($self) = @_;
 return (\@lines);
}


1;
