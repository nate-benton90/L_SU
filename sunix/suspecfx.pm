#!/usr/bin/perl

package suspecfx;
use Moose;


=head1 DOCUMENTATION

=head2 SYNOPSIS

  PROGRAM NAME: suspecfx
  AUTHOR: Juan Lorenzo 
  DATE:   July 1 2016 
  DESCRIPTION:  A package that makes using and understanding suspecfx easier
  VERSION: 0.1

=head2 USE 

=head2 Notes

	This Program derives from suspecfx in Seismic Unix
	'_note' keeps track of actions for use in graphics
	'_Step' keeps track of actions for execution in the system

=head2 Example

=head2 Seismic Unix Notes

SUSPECFX - Fourier SPECtrum (T -> F) of traces 		
 								
 suspecfx <infile >outfile 					
 Note: To facilitate further processing, the sampling interval	
       in frequency and first frequency (0) are set in the	
	output header.		
=cut


=pod

   1. Use packages:

     (for variable definitions)
     SeismicUnix (Seismic Unix modules)

=cut

my $on = 1;

 my $suspecfx = {
   _note      => '',
   _Step      => ''
 };


=pod

 sub clear 
     clear global variables from the memory

=cut
sub clear {
    $suspecfx->{_Step} 		= '';
    $suspecfx->{_note} 		= '';
}
 
sub note {
    $suspecfx->{_note}        =  $suspecfx->{_note};
    return $suspecfx->{_note};
}


sub Step{
    $suspecfx->{_Step}     	= 'suspecfx '.$suspecfx->{_Step};
    return $suspecfx->{_Step};
}

   
=head2 sub get_max_index
  max index = number of input variables -1

=cut

 sub get_max_index {
 	my ($self) = @_;
 	# only file_name : index=6
 	my $max_index = 6;
 	
 	return($max_index);
 }



1;
