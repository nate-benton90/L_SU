#!/usr/bin/perl

package suxcor;

use Moose;

=pod

=head1 DOCUMENTATION

=head2 SYNOPSIS

  PROGRAM NAME: suxcor
  AUTHOR:  Derek Goff
  DATE:  NOV 21 2014
  DESCRIPTION:  A package to use Suxcor
  VERSION: 0.1

=head2 Use

=head2 Notes

	This Program derives from suxcor in Seismic Unix
	'_note' keeps track of actions for use in graphics
	'_Step' keeps track of actions for execution in the system

=head2 Example

=head2 Seismic Unix Notes

 SUXCOR - correlation with user-supplied filter
 
 suxcor <stdin >stdout  filter= [optional parameters]
 
 Required parameters: ONE of
 sufile=                file containing SU traces to use as filter
 filter=                user-supplied correlation filter (ascii)
 
 Optional parameters:
 vibroseis=0            =nsout for correlating vibroseis data
 first=1                supplied trace is default first element of
                        correlation.  =0 for it to be second.
 panel=0                use only the first trace of sufile as filter 
                        =1 xcor trace by trace an entire gather
 ftwin=0                first sample on the first trace of the window 
                                (only with panel=1)              
 ltwin=0                first sample on the last trace of the window 
                                (only with panel=1)              
 ntwin=nt               number of samples in the correlation window
                                (only with panel=1)              
 ntrc=48                number of traces on a gather 
                                (only with panel=1)              
 
 Trace header fields accessed: ns
 Trace header fields modified: ns
 
 Notes: It is quietly assumed that the time sampling interval on the
 single trace and the output traces is the same as that on the traces
 in the input file.  The sufile may actually have more than one trace,
 but only the first trace is used when panel=0. When panel=1 the number
 of traces in the sufile MUST be the same as the number of traces in 
 the input.
 
 Examples:
        suplane | suwind min=12 max=12 >TRACE
        suxcor<DATA sufile=TRACE |...
 Here, the su data file, "DATA", is correlated trace by trace with the
 the single su trace, "TRACE".
 
        suxcor<DATA filter=1,2,1 | ...
 Here, the su data file, "DATA", is correlated trace by trace with the
 the filter shown.
 
 Correlating vibroseis data with a vibroseis sweep:
 suxcor < data sufile=sweep vibroseis=nsout  |...
 
 is equivalent to, but more efficient than:
 
 suxcor < data sufile=sweep |
 suwind itmin=nsweep itmax=nsweep+nsout | sushw key=delrt a=0.0 |...   
 
 sweep=vibroseis sweep in SU format, nsweep=number of samples on
 the vibroseis sweep, nsout=desired number of samples on output
 
 or
 suxcor < data sufile=sweep |
 suwind itmin=nsweep itmax=nsweep+nsout | sushw key=delrt a=0.0 |...   
 
 tsweep=sweep length in seconds, tout=desired output trace length in seconds
 
 In the spatially variant case (panel=1), a window with linear slope 
 can be defined:                                                 
        ftwin is the first sample of the first trace in the gather,  
        ltwin is the first sample of the last trace in the gather,
        ntwin is the lengthe of the window, 
        ntrc is the the number of traces in a gather. 
 
        If the data consists of a number gathers which need to be 
        correlated with the same number gathers in the sufile, ntrc
        assures that the correlating window re-starts for each gather.
 
        The default window is non-sloping and takes the entire trace
        into account (ftwin=ltwin=0, ntwin=nt).

=cut


my $suxcor = {
	_Step	=> '',
	_note	=> '',
	_sufile	=> '',
	_filter	=> '',
	_first	=> '',
	_panel	=> '',
	_ftwin	=> '',
	_ltwin	=> ''
};


=pod

=head1 Description of Subroutines

=head2 Subroutine clear
	
	Sets all variable strings to '' (nothing) 

=cut

sub clear {
	$suxcor->{_Step}	= '';
	$suxcor->{_note}	= '';
	$suxcor->{_sufile}	= '';
	$suxcor->{_filter}	= '';
	$suxcor->{_first}	= '';
	$suxcor->{_panel}	= '';
	$suxcor->{_ftwin}	= '';
	$suxcor->{_ltwin}	= '';
}


=pod

=head2 Subroutine sufile

	Define the data to be used as the correlation
	This is the 'filter'

=cut

#May need to change "my $sufile" to "my ($sub,$fv)
#And do the same for other subroutines

sub sufile {
	my ($sub, $sufile)			= @_;
	$suxcor->{_sufile}	= $sufile if defined($sufile);
	$suxcor->{_note}	= $suxcor->{_note}.' sufile='.$suxcor->{_sufile};
	$suxcor->{_Step}	= $suxcor->{_Step}.' sufile='.$suxcor->{_sufile};
}


=pod

=head2 Filter

	ASCII data filter

=cut


sub filter {
	my ($sub, $filter)			= @_;
	$suxcor->{_filter}	= $filter if defined($filter);
	$suxcor->{_note}	= $suxcor->{_note}.' filter='.$suxcor->{_filter};
	$suxcor->{_Step}	= $suxcor->{_Step}.' filter='.$suxcor->{_filter};
}


=pod

=head2 Subroutine first

	supplied trace is default first element of correlation if 1
	0 for it to be second

=cut

sub first {
	my ($sub, $first)			= @_;
	$suxcor->{_first}	= $first if defined($first);
	$suxcor->{_note}	= $suxcor->{_note}.' first='.$suxcor->{_first};
	$suxcor->{_Step}	= $suxcor->{_Step}.' first='.$suxcor->{_first};
}


=pod

=head2 Subroutine ftwin

	first sample on the first trace of the window
	panel =1

=cut

sub ftwin {
	my ($sub, $ftwin)		= @_;
	$suxcor->{_ftwin}	= $ftwin if defined($ftwin);
	$suxcor->{_note}	= $suxcor->{_note}.' ftwin='.$suxcor->{_ftwin};
	$suxcor->{_Step}	= $suxcor->{_Step}.' ftwin='.$suxcor->{_ftwin};
}


=pod

=head2 Subroutine ltwin

	first sample on the last trace of the window
	panel =1

=cut

sub ltwin {
	my ($sub, $ltwin)		= @_;
	$suxcor->{_ltwin}	= $ltwin if defined($ltwin);
	$suxcor->{_note}	= $suxcor->{_note}.' ltwin='.$suxcor->{_ltwin};
	$suxcor->{_Step}	= $suxcor->{_Step}.' ltwin='.$suxcor->{_ltwin};
}


=pod

=head2 Subroutine panel

	decide whether to use first trace of sufile as filter (=0) 
	or to xcor trace by trace an entire gather

=cut

sub panel {
	my ($sub, $panel)		= @_;
	$suxcor->{_panel}	= $panel if defined($panel);
	$suxcor->{_note}	= $suxcor->{_note}.' panel='.$suxcor->{_panel};
	$suxcor->{_Step}	= $suxcor->{_Step}.' panel='.$suxcor->{_panel};
}


#Need to add sub ntrc if you want to use panel=1 for gather comparison

=pod

=head2 Subroutine Step

	Keeps track of actions for execution in the system

=cut

sub Step {
	$suxcor->{_Step}	= 'suxcor'.$suxcor->{_Step};
	return $suxcor->{_Step};
}

=pod

=head2 Subroutine note

	Keeps track of actions for possible use in graphics

=cut

sub note {
	$suxcor->{_note}	= $suxcor->{_note};
	return $suxcor->{_note};
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
