#!/usr/bin/perl

package suphasevel;
use Moose;

=pod

=head1 DOCUMENTATION

=head2 SYNOPSIS

  PROGRAM NAME: suphasevel
  AUTHOR:  Derek Goff
  DATE:  OCT 24 2013
  DESCRIPTION:  A package that makes using and understanding suphasevel easier
  VERSION: 0.1

=head2 Use

=head2 Notes

	This Program derives from suphasevel in Seismic Unix
	'_note' keeps track of actions for use in graphics
	'_Step' keeps track of actions for execution in the system

=head2 Example

=head2 Seismic Unix Notes


 SUPHASEVEL - Multi-mode PHASE VELocity dispersion map computed
              from shot record(s)
 
 suphasevel <infile >outfile [optional parameters]

 Optional parameters:
 
 fv=330 	minimum phase velocity (m/s)
 nv=100 	number of phase velocities
 dv=25          phase velocity step (m/s)
 fmax=50        maximum frequency to process (Hz)
     =0 	process to nyquist
 norm=0 	do not normalize by amplitude spectrum
     =1 	normalize by amplitude spectrum
 verbose=0      verbose = 1 echoes information
 
 Notes:  Offsets read from headers.                      
  1. output is complex frequency data
  2. offset header word must be set (signed offset is ok)
  3. norm=1 tends to blow up aliasing and other artifacts
  4. For correct suifft later, use fmax=0
  5. For later processing outtrace.dt=domega
  6. works for 2D or 3D shots in any offset order

 Example:
   suphasevel < shotrecord.su | suamp | suximage          

 Reference: Park, Miller, and Xia (1998, SEG Abstracts)

 Trace header fields accessed: dt, offset, ns
 Trace header fields modified: nx,dt,trid,d1,f1,d2,f2,tracl

=cut


#Before this can be run, the trace offset must be set
#This is done by using the command 'sushw' to adjust
#the headers


my $suphasevel = {
	_Step	=> '',
	_note	=> '',
	_fv	=> '',
	_nv	=> '',
	_dv	=> '',
	_fmax	=> '',
	_norm	=> '',
	_verb	=> '', #AKA Verbose
};


=pod

=head1 Description of Subroutines

=head2 Subroutine clear
	
	Sets all variable strings to '' (nothing) 

=cut

sub clear {
	$suphasevel->{_Step}	= '';
	$suphasevel->{_note}	= '';
	$suphasevel->{_fv}	= '';
	$suphasevel->{_nv}	= '';
	$suphasevel->{_dv}	= '';
	$suphasevel->{_fmax}	= '';
	$suphasevel->{_norm}	= '';
	$suphasevel->{_verb}	= '';
}


=pod

=head2 Subroutine fv

	Defines the minimum phase velocity to process
	AKA first phase velocity

=cut

#May need to change "my $fv" to "my ($sub,$fv)
#And do the same for other subroutines

sub fv {
	my ($sub, $fv)			= @_;
	$suphasevel->{_fv}	= $fv if defined($fv);
	$suphasevel->{_note}	= $suphasevel->{_note}.' fv='.$suphasevel->{_fv};
	$suphasevel->{_Step}	= $suphasevel->{_Step}.' fv='.$suphasevel->{_fv};
}


=pod

=head2 Subroutine nv

	Defines the number of phase velocities to test
	AKA total number of steps to take

=cut


sub nv {
	my ($sub, $nv)			= @_;
	$suphasevel->{_nv}	= $nv if defined($nv);
	$suphasevel->{_note}	= $suphasevel->{_note}.' nv='.$suphasevel->{_nv};
	$suphasevel->{_Step}	= $suphasevel->{_Step}.' nv='.$suphasevel->{_nv};
}


=pod

=head2 Subroutine dv

	Defines the step size between phase velocities while
	performing the integral transformation

=cut

sub dv {
	my ($sub, $dv)			= @_;
	$suphasevel->{_dv}	= $dv if defined($dv);
	$suphasevel->{_note}	= $suphasevel->{_note}.' dv='.$suphasevel->{_dv};
	$suphasevel->{_Step}	= $suphasevel->{_Step}.' dv='.$suphasevel->{_dv};
}


=pod

=head2 Subroutine fmax

	Defines maximum frequency to process
	(or =0 for nyquist)

=cut

sub fmax {
	my ($sub, $fmax)		= @_;
	$suphasevel->{_fmax}	= $fmax if defined($fmax);
	$suphasevel->{_note}	= $suphasevel->{_note}.' fmax='.$suphasevel->{_fmax};
	$suphasevel->{_Step}	= $suphasevel->{_Step}.' fmax='.$suphasevel->{_fmax};
}


=pod

=head2 Subroutine norm

	Determine whether to use amplitude spectrum to normalize
	=0 is off (do not normalize by amplitude spectrum)
	=1 is on (normalize by amplitude spectrum)

=cut

sub norm {
	my ($sub, $norm)		= @_;
	$suphasevel->{_norm}	= $norm if defined($norm);
	$suphasevel->{_note}	= $suphasevel->{_note}.' norm='.$suphasevel->{_norm};
	$suphasevel->{_Step}	= $suphasevel->{_Step}.' norm='.$suphasevel->{_norm};
}


=pod

=head2 Subroutine verb

	Decide whether to echo information

=cut

sub verb {
	my ($sub, $verb)		= @_;
	$suphasevel->{_verb}	= $verb if defined($verb);
	$suphasevel->{_note}	= $suphasevel->{_note}.' verbose='.$suphasevel->{_verb};
	$suphasevel->{_Step}	= $suphasevel->{_Step}.' verbose='.$suphasevel->{_verb};
}


=pod

=head2 Subroutine Step

	Keeps track of actions for execution in the system

=cut

sub Step {
	$suphasevel->{_Step}	= 'suphasevel'.$suphasevel->{_Step};
	return $suphasevel->{_Step};
}

=pod

=head2 Subroutine note

	Keeps track of actions for possible use in graphics

=cut

sub note {
	$suphasevel->{_note}	= $suphasevel->{_note};
	return $suphasevel->{_note};
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
