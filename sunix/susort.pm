package susort;
use Moose;


=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: susort
 AUTHOR: Masoud Safari-Zanjani
       : Juan Lorenzo
 DATE:   Dec 10 2013,
         July 24, 2015
 DESCRIPTION: 
 Version: 0.1
 Version: 0.2 - made workable and reduced the number of inputs to one from 10
 June 2, 2016 Version 0.3 Juan Lorenzo, more perlpod

=head2 USAGE

  susort->su.h();
  susort->segy.h();
  susort->signal.h();

=head3 NOTES 

  This program derives from susort in Seismic Unix
 
=head4 Notes from Seismic Unix 
 		
Example 1
					
  To sort traces by cdp gather and within each gather		
  by offset with both sorts in ascending order:			

	susort <INDATA >OUTDATA cdp offset

Example 2

        susort < SH_geom_2s.su  –tracf |suximage 

  tracf is the header value that is used to reorder the traces. In this case tracf is the trace number. The negative sign implies that the reordered file will have the traces ordered according to the decreasing value of tracf.   So if tracf = 1,2 ,3…. 24 in the input file, tracf=24,23,22,21,20 in the output file
Here we reverse the order of the traces according to their sequential trace number in the file (tracf) and traces 1 through 24 will be plotted in reverse order, i.e. 24 through 1.



 SUSORT - sort on any segy header headerwordwords			,
 								,
 susort <stdin >stdout [[+-]headerword1 [+-]headerword2 ...]			,
 								,
 Susort supports any number of (secondary) headerwords with either	,
 ascending (+, the default) or descending (-) directions for 	,
 each.  The default sort headerword is cdp.				,
 								,
 Note:	Only the following types of input/output are supported	,
	Disk input --> any output				,
	Pipe input --> Disk output				,
 								,
 Caveat:  On some Linux systems Pipe input and or output often  ,
		fails						,
	Disk input ---> Disk output is recommended		,
 								,
 Note: If the the CWP_TMPDIR environment variable is set use	,
	its value for the path; else use tmpfile()		,
 								,
								,
 Caveat: In the case of Pipe input a temporary file is made	,
	to hold the ENTIRE data set.  This temporary is		,
	either an actual disk file (usually in /tmp) or in some	,
 implementations, a memory buffer.  It is left to the	        ,
	user to be SENSIBLE about how big a file to pipe into	,
	susort relative to the user's computer.			,
 								,


/* Credits:
 *	SEP: Einar Kjartansson , Stew Levin
 *	CWP: Shuki Ronen,  Jack K. Cohen
 *
 * Caveats:
 *	Since the algorithm depends on sign reversal of the headerword value
 *	to obtain a descending sort, the most significant figure may
 *	be lost for unsigned data types.  The old SEP support for tape
 *	input was removed in version 1.16---version 1.15 is in the
 *	Portability directory for those who may want to input SU data
 *	stored on tape.
 *
 * Trace header fields modified: tracl, tracr

=cut

my $susort = {
          _headerword       		  => '', 
          _note       		          => '',
          _Step      		          => ''
        };

=pod sub clear

 clears hashes

=cut
		
sub clear {
    $susort ->{_headerword} 			= '';
    $susort ->{_note} 				= '';
    $susort ->{_Step} 				= '';
}


=head2 subroutine headerword

   selects which headerword on which to sort in the order provided
  multiple calls to this subroutine
  will work

=cut


sub  headerword {
    my ($variable,$headerword)       = @_;
    $susort->{_headerword}           = $headerword if defined($headerword);
    $susort->{_note}          	     = $susort->{_note}.' '.$susort->{_headerword};
    $susort->{_Step}                 = $susort->{_Step}.' '.$susort->{_headerword};
}

=head2 subroutine Step

  pastes program name to head of strings

=cut

sub Step {
    $susort->{_Step}       = 'susort'.$susort->{_Step};
    return $susort->{_Step};
}

=head2 subroutine note
 
 create a list of instructions for archival 

=cut

sub note {
    $susort->{_note}       =  $susort->{_note};
    return $susort->{_note};
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
