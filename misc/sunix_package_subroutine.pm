package sunix_package_subroutine;
use Moose;


=head2 encapsualted variables

=cut

 my $sunix_package_subroutine = {
		_package_name   => '',
    };

=head2 Default perl lines for  a subroutine 


=cut

 my @lines;

 $lines[0] = ("\n");



=head2 sub set_name


=cut

sub set_name {

 my ($self,$name_href) = @_;
 $sunix_package_subroutine->{_package_name} = $name_href;
 # print("1. sunix_package_subroutine,name $name_href\n");

}


=head2 sub set_param_name_aref

  print("sunix_package_subroutine,name,@lines\n");

=cut

sub set_param_name_aref {
 my ($self,$name_aref) = @_;
 my ($first,$i,$package_name);

 $package_name = $sunix_package_subroutine->{_package_name};

  $first 	= 1;
  $i  		= $first;

  $lines[$i] 		= (" sub $$name_aref {\n");
  $lines[++$i]		=  '   my ( $self,$'.$$name_aref.' )'.("\t\t").'= @_;'.("\n");
  $lines[++$i]		=  '   if ( $'.$$name_aref.' ) {'.("\n");
  $lines[++$i]		=  '     $'.$package_name.'->{_'.$$name_aref.'}'.("\t\t").'= $'.$$name_aref.';'.("\n"); 
  $lines[++$i] 		=  '     $'.$package_name.'->{_note}'.("\t").'= $'.$package_name.'->{_note}.'.'\''. $$name_aref.'\'.$'.$package_name.'->{_'.$$name_aref.'};'.("\n") ; 
  $lines[++$i] 		=  '     $'.$package_name.'->{_Step}'.("\t").'= $'.$package_name.'->{_Step}.'.'\''. $$name_aref.'\'.$'.$package_name.'->{_'.$$name_aref.'};'.("\n"); 
  $lines[++$i] 		= '   }'.("\n");
  $lines[++$i] 		= (" }\n");
  $lines[++$i] 		= ("\n");
}

=head2 sub section 

 print("sunix_package_subroutine,section,@lines\n");

=cut

sub section {
 my $self = @_;
 return (\@lines);
}

1;
