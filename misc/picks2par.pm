package picks2par;

# CLASSES 
use Moose;
use SU;
=head2

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PACKAGE NAME: picks2par 
 AUTHOR: Juan Lorenzo
 DATE:  July 18 2016

 DESCRIPTION: 
 Version: 0.1

=head2 USE

=head2 NOTES 
   Based on iVpicks2par.pm

=head4 

 Examples

=head2 SEISMIC UNIX NOTES  

=head2 CHANGES and their DATES

=cut


=head2 STEPS

=cut




=head2 Set shared defaults

    in anonymous hash
 
=cut

 my $picks2par = {
          _file_in	    	=>'',
          _Step	    		=>'',
          _drectory_in	    	=>'',
        };

=head2 subroutine clear

  sets all variable strings to '' 

=cut

sub clear {
    $picks2par->{_directory_in} 		= '';
    $picks2par->{_Step} 			= '';
    $picks2par->{_file_in} 			= '';
};


=head2 Import

 Directory definitions

=cut 

  use SeismicUnix qw ($on $off $in $to $go);

=head2 Instantiate 

 instantiate programs

=cut
  my $iWrite_All_iva_out                = new iWrite_All_iva_out();
  my $test                               = new manage_files_by2();
 

 my (@suffix,@file_in,@sortfile_in,@inbound);
 my (@parfile_out,@outbound, @sort, @mkparfile);
 my (@flow);



=head2 Import

 Directory definitions

=cut 

sub directory_in {
   my($variable,$directory_in)  	= @_;
   $picks2par->{_directory_in} 		= $cdp_num if defined ($cdp_num);
}


=head2 

 subroutine file_in
 Required file name
 on which to perform velocity analyses 

=cut

sub file_in {
    my ($variable,$file_in) 	= @_;
    $picks2par->{_file_in} 	= $file_in if defined($file_in); 
    #print("file name is $picks2par->{_file_in} \n\n");
}

=head2 Sort,format
 
 and finally convert picks
 into a par file for
 seismic unix

=cut

 sub Step {

  use Moose;

=head2 Bring in

  useful packages

=cut

  use mkparfile;
  use flow;

=head2 Instantiate

  useful packages

=cut

  my $mkparfile 	= new mkparfile();
  my $run    		= new flow();

=head2 Declare

   arrays
   and file names

=cut

  my (@mkparfile,@sort,@inbound,@parfile_out,@outbound,@flow);

  $inbound [1]  	= $picks2par->{_directory_in}.'/'.$sortfile_in[1];
  $parfile_out[1] 	= 'picks_sorted_par_'.$file_in[1];
  $outbound[1]  	= $PL_SEISMIC.'/'.$parfile_out[1];

  	$sort[1] 	=  (" sort 			\\
				-n			\\
				");

=head2 Convert 

   picks to par file
  
=cut

 $mkparfile 	->clear();
 $mkparfile 	->string1();
 $mkparfile 	->string2();
 $mkparfile[1] 	= $mkparfile->Step(); 

=head2  DEFINE FLOW(S)

=cut

 @items   = ($sort[1],$in,$inbound[1],$to,$outbound[1]);
  $flow[1] = $run->modules(\@items);

return \@flow;

# RUN FLOW(S)
#       system $flow[1]; 
#       system 'echo', $flow[1];	
}

=head2 For all packages:

 The following line returns a 
 "true" logical value to the program

=cut

1;
