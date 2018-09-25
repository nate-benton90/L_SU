package package_pod;
use Moose;


=head2 encapsualted variables

=cut

 my $package_pod = {
		_package_name		=> '',
		_subroutine_name	=> '',
		_sudoc				=> '',
		_num_lines			=> '',
		_local_variables	=> '',
    };

=head2 Default perl lines for  a subroutine 


=cut

 my @lines;

 $lines[0] = ("\n");

=head2 sub sudoc 

 	Complete sunix documentation

=cut

 sub sudoc {

  my ($self,$aref) 					= @_;
  $package_pod->{_sudoc} 		= $aref;
  #print("package_pod,sudoc,whole @{$package_pod->{_sudoc}} \n");
  #$package_pod->{_num_lines} 	= scalar (@{$aref});

 }


=head2 sub header

	Introductory header for each package

=cut

sub header {
  my ($self,$name_href) = @_;
  my ($first,$last,$i,$name);
  my @h_lines;
  $package_pod->{_package_name} = $name_href;
  $name				= $package_pod->{_package_name};
  $first 			= 0;
  $i  				= $first;

  $h_lines[$i] 		= ("=head1 DOCUMENTATION\n\n");
  $h_lines[++$i] 		= ("=head2 SYNOPSIS\n\n");
  $h_lines[++$i] 		= (" PACKAGE NAME: $name\n");
  $h_lines[++$i] 		= (" AUTHOR: Juan Lorenzo\n");
  $h_lines[++$i] 		= (" DATE:   \n");
  $h_lines[++$i] 		= (" DESCRIPTION:\n");
  $h_lines[++$i] 		= (" Version: \n\n");
  $h_lines[++$i] 		= ("=head2 USE\n\n");
  $h_lines[++$i] 		= ("=head3 NOTES\n\n");
  $h_lines[++$i] 		= ("=head4 Examples\n\n");
  $h_lines[++$i] 		= ("=head2 SYNOPSIS\n");
  $h_lines[++$i] 		= ("=head3 SEISMIC UNIX NOTES\n");
	print(" i is $i\n");
   for (my $j=$i; $j<($i+5); $j++) {
	print(" i is $i\n");

  $h_lines[$j] 		= ("write \n");
 
 }
  $h_lines[++$i] 		= ("=head2 CHANGES and their DATES\n\n");
  $h_lines[++$i] 		= ("=cut\n");
  my $size = scalar @h_lines;
  print("package_pod,num_lines,$size\n");
  print("package_pod,header @h_lines\n");
 #return(\@h_lines);
}


=head2 sub subroutine_name

  print("package_pod,name,@lines\n");

=cut

sub subroutine_name {
 my ($self,$name_aref) = @_;
 my ($first,$last,$i,$sub_name);

 $package_pod->{_subroutine_name} = $$name_aref;

  $first 	= 1;
  $i  		= $first;

  $lines[$i] 		= ("=head2 sub $$name_aref \n");
  $lines[++$i] 		=  ("\n");
  $lines[++$i] 		=  ("\n");
  $lines[++$i] 		= ("=cut\n");
}

=head2 sub package_name

  print("package_pod,name,@lines\n");

=cut

sub package_name {
 my ($self,$name_href) = @_;
 $package_pod->{_package_name} = $name_href;
 return();
}


=head2 sub section 

 print("package_pod,section,@lines\n");

=cut

sub section {
 my $self = @_;
 return (\@lines);
}

1;
