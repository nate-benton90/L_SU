#!/usr/bin/perl

package sudipfilt;
use Moose;

=head1 DOCUMENTATION

=head2 SYNOPSIS

  PROGRAM NAME: sudipfilt
  AUTHOR: Juan Lorenzo 
  DATE:   July 1 2016 
  DESCRIPTION:  A package that makes using and understanding sudipfilt easier
  VERSION: 0.1

=head2 USE 

=head2 Notes

	This Program derives from sudipfilt in Seismic Unix
	'_note' keeps track of actions for use in graphics
	'_Step' keeps track of actions for execution in the system

=head2 Example

=head2 Seismic Unix Notes

 SUDIPFILT - DIP--or better--SLOPE Filter in f-k domain	
 								
 sudipfilt <infile >outfile [optional parameters]		
								
 Required Parameters:						
 dt=(from header)	if not set in header then mandatory	
 dx=(from header, d1)	if not set in header then mandatory	
								
 Optional parameters:						
 slopes=0.0		monotonically increasing slopes		
 amps=1.0		amplitudes corresponding to slopes	
 bias=0.0		slope made horizontal before filtering	
								
 verbose=0	verbose = 1 echoes information			
								
 tmpdir= 	 if non-empty, use the value as a directory path
		 prefix for storing temporary files; else if the
	         the CWP_TMPDIR environment variable is set use	
	         its value for the path; else use tmpfile()	
 								
 Notes:							

s an acceptable alias for dx in the getpar		
								
 Slopes are defined by delta_t/delta_x, where delta		
 means change. Units of delta_t and delta_x are the same	
 as dt and dx. It is sometimes useful to fool the program	
 with dx=1 dt=1, thus avoiding units and small slope values.	
								
 Linear interpolation and constant extrapolation are used to	
 determine amplitudes for slopes that are not specified.	
 Linear moveout is removed before slope filtering to make	
 slopes equal to bias appear horizontal.  This linear moveout	
 is restored after filtering.  The bias parameter may be	
 useful for spatially aliased data.  The slopes parameter is	
 compensated for bias, so you need not change slopes when you	
 change bias.					

=cut

my $sudipfilt = {
	_amps		=> '',
	_bias		=> '',
	_dt		=> '',
	_dx		=> '',
	_note		=> '',
	_slopes		=> '',
	_Step		=> '',
	_tmpdir		=> '',
	_verbose	=> ''
};


=pod

=head1 Description of Subroutines

=head2 Subroutine clear
	
	Sets all variable strings to '' (nothing) 

=cut

sub clear {
	$sudipfilt->{_amps}	= '';
	$sudipfilt->{_bias}	= '';
	$sudipfilt->{_dt}	= '';
	$sudipfilt->{_dx}	= '';
	$sudipfilt->{_note}	= '';
	$sudipfilt->{_slopes}	= '';
	$sudipfilt->{_Step}	= '';
	$sudipfilt->{_tmpdir}	= '';
	$sudipfilt->{_verbose}	= '';
}



=head2 Subroutine amps

       Defines strength of filter at each slope

=cut


sub amps {
	my ($sub, $amps)			= @_;
       if($amps) {
	   $sudipfilt->{_amps}	= $amps if defined($amps);
	   $sudipfilt->{_note}	= $sudipfilt->{_note}.' amps='.$sudipfilt->{_amps};
	   $sudipfilt->{_Step}	= $sudipfilt->{_Step}.' amps='.$sudipfilt->{_amps};
        }
}


=head2 Subroutine bias

      makes all slope horizontal prior to filtering 

=cut


sub bias {
	my ($sub, $bias)			= @_;
        if($bias) {
	   $sudipfilt->{_bias}	= $bias if defined($bias);
	   $sudipfilt->{_note}	= $sudipfilt->{_note}.' bias='.$sudipfilt->{_bias};
	   $sudipfilt->{_Step}	= $sudipfilt->{_Step}.' bias='.$sudipfilt->{_bias};
        }
}



=head2 Subroutine dt

      sampling interval

=cut


sub dt {
	my ($sub, $dt)			= @_;
        if($dt) {
	   $sudipfilt->{_dt}	= $dt if defined($dt);
	   $sudipfilt->{_note}	= $sudipfilt->{_note}.' dt='.$sudipfilt->{_dt};
	   $sudipfilt->{_Step}	= $sudipfilt->{_Step}.' dt='.$sudipfilt->{_dt};
        }
}



=head2 Subroutine dx

      sparation between traces

=cut


sub dx {
	my ($sub, $dx)			= @_;
        if($dx) {
	   $sudipfilt->{_dx}	= $dx if defined($dx);
	   $sudipfilt->{_note}	= $sudipfilt->{_note}.' dx='.$sudipfilt->{_dx};
	   $sudipfilt->{_Step}	= $sudipfilt->{_Step}.' dx='.$sudipfilt->{_dx};
        }
}


=head2 Subroutine slopes

     defines slopes for filter in samples/trace (non-dimensional) or s/m etc. 

=cut


sub slopes {
	my ($sub, $slopes)			= @_;
        if($slopes) {
	   $sudipfilt->{_slopes}	= $slopes if defined($slopes);
	   $sudipfilt->{_note}	= $sudipfilt->{_note}.' slopes='.$sudipfilt->{_slopes};
	   $sudipfilt->{_Step}	= $sudipfilt->{_Step}.' slopes='.$sudipfilt->{_slopes};
        }
}



=head2 Subroutine tmpdir

      work directory which can be defined 

=cut


sub tmpdir {
	my ($sub, $tmpdir)			= @_;
        if($tmpdir) {
	   $sudipfilt->{_tmpdir}	= $tmpdir if defined($tmpdir);
	   $sudipfilt->{_note}	= $sudipfilt->{_note}.' tmpdir='.$sudipfilt->{_tmpdir};
	   $sudipfilt->{_Step}	= $sudipfilt->{_Step}.' tmpdir='.$sudipfilt->{_tmpdir};
        }
}



=head2 Subroutine verbose

      echoes steps during progress of filtering 

=cut


sub verbose {
	my ($sub, $verbose)			= @_;
        if($verbose) {
	   $sudipfilt->{_verbose}	= $verbose if defined($verbose);
	   $sudipfilt->{_note}	= $sudipfilt->{_note}.' verbose='.$sudipfilt->{_verbose};
	   $sudipfilt->{_Step}	= $sudipfilt->{_Step}.' verbose='.$sudipfilt->{_verbose};
        }
}



=head2 Subroutine Step

	Keeps track of actions for execution in the system

=cut

sub Step {
	$sudipfilt->{_Step}	= 'sudipfilt'.$sudipfilt->{_Step};
	return $sudipfilt->{_Step};
}


=head2 Subroutine note

	Keeps track of actions for possible use in graphics

=cut

sub note {
	$sudipfilt->{_note}	= $sudipfilt->{_note};
	return $sudipfilt->{_note};
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
