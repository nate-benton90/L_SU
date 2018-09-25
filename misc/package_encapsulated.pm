package package_encapsulated;
use Moose;


=head2 encapsualted variables

=cut

 my $package_encapsulated = {
		_package_name      => '',
		_subroutine_name   => '',
		_local_variable   => '',
    };

=head2 Default perl lines for  a subroutine 


=cut

 my @lines;

 $lines[0] = ("\n");
 $lines[1] = ("my $package_encapsulated->{_package_name}\n");

=head2 sub local_variables

  print("package_encapsulated,name,@lines\n");

=cut

sub local_variables {
 my ($self,$name_aref) = @_;
 my ($first,$last,$i,$package_name);

 $package_encapsulated->{_local_variable} = $$name_aref;

 #for (my $i=0; $i < $package->{_length}; $i++) {

  #      $encapsulated	   ->local_variables(\@{$package->{_param_names}}[$i]);


  #    } 
 #$first 	= 0;
 #$i  		= $first;
#
#  $lines[$i] 		= '_'.$$name_aref.'=>    \'\';'.("\n");
#  $lines[++$i] 		=  '    }'.("\n");
#  $lines[++$i] 		=  ("\n");
}


=head2 sub subroutine_name

  print("package_encapsulated,name,@lines\n");

=cut

sub subroutine_name {
 my ($self,$name_aref) = @_;
 my ($first,$last,$i,$sub_name);

 $package_encapsulated->{_subroutine_name} = $$name_aref;

  $first 	= 1;
  $i  		= $first;

  $lines[$i] 		= ("=head2 sub $$name_aref \n");
  $lines[++$i] 		=  ("\n");
  $lines[++$i] 		=  ("\n");
  $lines[++$i] 		= ("=cut\n");
}

=head2 sub package_name

  print("package_encapsulated,name,@lines\n");

=cut

sub package_name {
 my ($self,$name_href) = @_;
 $package_encapsulated->{_package_name} = $name_href;
 return();
}


=head2 sub section 

 print("package_encapsulated,section,@lines\n");

=cut

sub section {
 my $self = @_;
 return (\@lines);
}

1;
