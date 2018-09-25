package localParams;

=pod

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PACKAGE NAME: localParams.pm
 AUTHOR: Juan Lorenzo
 DATE:   
         Sept. 2015, V 1
 DESCRIPTION:3
 define local directory and paramterfile 

=head2 USE

=head3 NOTES 

=head4 
 Examples

=cut

 use Moose;
 use SU;

=pod

 inherit subroutines from a 
 parent package

=cut

 my $localParams 		= new readParams();
 my ($PL_SEISMIC)               = System_Variables::PL_SEISMIC();

=pod

 define the local directory

=cut

=pod
  hash array of important variables used within
  this package

=cut 

 my $local = {
      _dir                => '',
      _file                => ''
    };

=pod

 subroutine clear
         to blank out hash array values

=cut

 sub clear {
     $localParams->{_dir }        = '';
     $localParams->{_file}        = '';
    }

 print("1.$PL_SEISMIC\n\n");
 
 $localParams->dir($PL_SEISMIC.'/libAll');

=head2 subroutine file 

  set up file to read   

=cut

sub file {
   my($variable,$file)  	= @_;
   $localParams->{_file} 	= $file if defined ($file);
   #print("file is $localParams->{_file} \n\n");
}

=head2 subroutine sufilter 

  sets cdp number to consider  

=cut

sub sufilter {
  my($variable,$value)  	= @_;
  require $localParams->{_file};
  $localParams->{_file} -> import (qw ( $href_sufilter ) );
  #print("file is $localParams->{_file}\n\n");
  #print("sufilter is $href_sufilter\n\n");
}


1;
