package writefiles;
use Moose;

=pod

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PACKAGE NAME: writefiles 
 AUTHOR: Juan Lorenzo
 DATE: Oct 29 2012
 DESCRIPTION write file operations
 Version 1

 STEPS ARE:
=cut

my $newline    = '
';

  my $writefiles = {
        _format  	=> '',
  };

=pod

 sub clear 
     clear global variables from the memory

=cut

 sub clear {
	$writefiles->{_format} = '';
}

 my (@col1,@col2);
 my ($num_rows,$file_out,$fmt);


sub setfile {
    my ($variables, $ref_filename) = @_;
    $file_out = $$ref_filename if defined ($ref_filename);
    print("filename out is: $file_out\n\n");
}

sub file {
    my ($variables, $ref_filename) = @_;
    $file_out = $$ref_filename if defined ($ref_filename);
    #print("filename out is: $file_out\n\n");
}

sub data {
    my ($variables, $ref_array_data1, $ref_array_data2 ) = @_;

    @col1 = @$ref_array_data1 if defined ($ref_array_data1);
    @col2 = @$ref_array_data2 if defined ($ref_array_data2);
    $num_rows = scalar(@col1) -1;
    print("length of data goes from 1 : $num_rows points\n\n");
}

sub setcol_1 {
    my ($variables, $ref_array_data1) = @_;
    @col1 = @$ref_array_data1 if defined ($ref_array_data1);
    $num_rows = scalar(@col1) -1;
    print("length of data goes from 1 : $num_rows points\n\n");
}

sub format {
    my ($variables, $format ) = @_;
    $writefiles->{_format}     = $format if defined($format);
    $fmt = $writefiles->{_format};
    my @cols		       = split(/%/,$format);
    my $num_cols	       = scalar(@cols) -1;	
    # only use element =1 through i<=$num_cols 
    # do not use i=0
    #print("#cols = $num_cols\n\n");
    #print("format is = $writefiles->{_format}\n\n");
}
sub outcol_1 {
    #WRITE OUT FILE
    #open and write 1 cols to output file
    open(OUT,">$file_out");
    my $j;
    #print("format is: $fmt\n\n");
    for($j=1; $j<=$num_rows; $j++) {
       printf OUT "$fmt\n", $col1[$j], $col2[$j];
       #print("$col1[$j] \n");
    }
    close(OUT);
}
sub cols_2 {
    #WRITE OUT FILE
    #open and write 2 cols to output file

    open(OUT,">$file_out");
    my $j;
    print("format is: $fmt\n\n");
    for($j=1; $j<=$num_rows; $j++) {
       printf OUT "$fmt\n", $col1[$j], $col2[$j];
       #print("$col1[$j] $col2[$j]\n");
    }
    close(OUT);
}

=head2 sub new 

 write new configuration files

=cut

 sub new {



 return();
 }

=head2 sub config_LSU 

=cut

sub config_LSU {

 	my ($self,$array_ref) = @_;
 	#my ($self,$array_ref) = @_;
	#print ("@$array_ref\n");
    #foreach (@$array_ref) {
	#  print "$_\n";
	##}
	print("$self\n");

 	return();
}

1;
