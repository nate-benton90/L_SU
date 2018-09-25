package package_subroutine;
use Moose;


=head2 encapsualted variables

=cut

 my $package_subroutine = {
		_name   => '',
    };

=head2 Default perl lines for  a subroutine 


=cut

 my @lines;

 $lines[0] = ("\n");

=head2 sub name

 print("package_subroutine,name $name_href\n");

=cut

sub name {

 my ($self,$name_href) = @_;
 $package_subroutine->{_name} = $name_href;

}

=head2 sub param_name

  print("package_subroutine,name,@lines\n");

=cut

sub param_name {
 my ($self,$name_aref) = @_;
 my ($first,$last,$i,$sub_name);

 $sub_name = $package_subroutine->{_name};

  $first 	= 1;
  $last  	= 5;
  $i  		= $first;

  $lines[$i] 		= (" sub $$name_aref {\n");
  $lines[++$i]		=  '   my ( $self,$'.$$name_aref.' )'.("\t\t").'= @_;'.("\n");
  $lines[++$i]		=  '   if ( $'.$$name_aref.' ) {'.("\n");
  $lines[++$i]		=  '     $'.$sub_name.'->{_'.$$name_aref.'}'.("\t\t").'= $'.$$name_aref.';'.("\n"); 
#  $lines[++$i] 		= '     $'.$sub_name.'->{_note} = $'.$$name_aref.';'.("\n"); 

  $lines[++$i] 		=  '     $'.$sub_name.'->{_Step}'.("\t\t").'= $'.$sub_name.'->{_Step}.'.'\''. $$name_aref.'=\'.$'.$sub_name.'->{_'.$$name_aref.'};'.("\n"); 
  $lines[++$i] 		= '   }'.("\n");
  $lines[++$i] 		= (" }\n");
  $lines[++$i] 		= ("\n");
}

=head2 sub section 

 print("package_subroutine,section,@lines\n");

=cut

sub section {
 my $self = @_;
 return (\@lines);
}

1;
