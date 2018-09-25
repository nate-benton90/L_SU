 package suxwigb;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUXWIGB - X-windows Bit-mapped WIGgle plot of a segy data set		
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUXWIGB - X-windows Bit-mapped WIGgle plot of a segy data set		
 This is a modified suxwigb that uses the depth or coordinate scaling	
 when such values are used as keys.					

 suxwigb <stdin [optional parameters] | ...				

 Optional parameters:							
 key=(keyword)		if set, the values of x2 are set from header field
			specified by keyword				
 n2=tr.ntr or number of traces in the data set (ntr is an alias for n2)
 d1=tr.d1 or tr.dt/10^6	sampling interval in the fast dimension 
   =.004 for seismic		(if not set)				
   =1.0 for nonseismic		(if not set)				
 d2=tr.d2			sampling interval in the slow dimension 
   =1.0			(if not set)				
 f1=tr.f1 or tr.delrt/10^3 or 0.0  first sample in the fast dimension	
 f2=tr.f2 or tr.tracr or tr.tracl  first sample in the slow dimension	
   =1.0 for seismic		    (if not set)			
   =d2 for nonseismic		    (if not set)			

 style=seismic		 normal (axis 1 horizontal, axis 2 vertical) or 
			 vsp (same as normal with axis 2 reversed)	
			 Note: vsp requires use of a keyword		
 verbose=0              =1 to print some useful information		


 tmpdir=	 	if non-empty, use the value as a directory path	
		 	prefix for storing temporary files; else if the	
	         	the CWP_TMPDIR environment variable is set use	
	         	its value for the path; else use tmpfile()	

 Note that for seismic time domain data, the "fast dimension" is	
 time and the "slow dimension" is usually trace number or range.	
 Also note that "foreign" data tapes may have something unexpected	
 in the d2,f2 fields, use segyclean to clear these if you can afford	
 the processing time or use d2= f2= to override the header values if	
 not.									

 If key=keyword is set, then the values of x2 are taken from the header
 field represented by the keyword (for example key=offset, will show	
 traces in true offset). This permit unequally spaced traces to be plotted.
 Type	 sukeyword -o	to see the complete list of SU keywords.	

 This program is really just a wrapper for the plotting program: xwigb	
 See the xwigb selfdoc for the remaining parameters.			


 Credits:

	CWP: Dave Hale and Zhiming Li (xwigb, etc.)
	   Jack Cohen and John Stockwell (suxwigb, etc.)
	Delphi: Alexander Koek, added support for irregularly spaced traces

	Modified by Brian Zook, Southwest Research Institute, to honor
	 scale factors, added vsp style

 Notes:
	When the number of traces isn't known, we need to count
	the traces for xwigb.  You can make this value "known"
	either by getparring n2 or by having the ntr field set
	in the trace header.  A getparred value takes precedence
	over the value in the trace header.

	When we must compute ntr, we don't allocate a 2-d array,
	but just content ourselves with copying trace by trace from
	the data "file" to the pipe into the plotting program.
	Although we could use tr.data, we allocate a trace buffer
	for code clarity.

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';

	my $suxwigb		= {
		_d1					=>    '',
		_d2					=>    '',
		_f1					=>    '',
		_f2					=>    '',
		_key					=>    '',
		_n2					=>    '',
		_style					=>    '',
		_tmpdir					=>    '',
		_verbose					=>    '',
		_Step					=>    '',
		_note					=>    '',
    };


=head2 sub Step

	collects switches and assembles bash instructions
	by adding the program name

=cut

 sub  Step {

	$suxwigb->{_Step}     = 'suxwigb'.$suxwigb->{_Step};
	return ( $suxwigb->{_Step} );

 }


=head2 sub note

	collects switches and assembles bash instructions
	by adding the program name

=cut

 sub  note {

	$suxwigb->{_note}     = 'suxwigb'.$suxwigb->{_note};
	return ( $suxwigb->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suxwigb->{_d1}			=    '';
		$suxwigb->{_d2}			=    '';
		$suxwigb->{_f1}			=    '';
		$suxwigb->{_f2}			=    '';
		$suxwigb->{_key}			=    '';
		$suxwigb->{_n2}			=    '';
		$suxwigb->{_style}			=    '';
		$suxwigb->{_tmpdir}			=    '';
		$suxwigb->{_verbose}			=    '';
		$suxwigb->{_Step}			=    '';
		$suxwigb->{_note}			=    '';
 }


=head2 sub d1 


=cut

 sub d1 {

	my ( $self,$d1 )		= @_;
	if ( $d1 ) {

		$suxwigb->{_d1}		= $d1;
		$suxwigb->{_note}		= $suxwigb->{_note}.' d1='.$suxwigb->{_d1};
		$suxwigb->{_Step}		= $suxwigb->{_Step}.' d1='.$suxwigb->{_d1};

	} else { 
		print("suxwigb, d1, missing d1,\n");
	 }
 }


=head2 sub d2 


=cut

 sub d2 {

	my ( $self,$d2 )		= @_;
	if ( $d2 ) {

		$suxwigb->{_d2}		= $d2;
		$suxwigb->{_note}		= $suxwigb->{_note}.' d2='.$suxwigb->{_d2};
		$suxwigb->{_Step}		= $suxwigb->{_Step}.' d2='.$suxwigb->{_d2};

	} else { 
		print("suxwigb, d2, missing d2,\n");
	 }
 }


=head2 sub f1 


=cut

 sub f1 {

	my ( $self,$f1 )		= @_;
	if ( $f1 ) {

		$suxwigb->{_f1}		= $f1;
		$suxwigb->{_note}		= $suxwigb->{_note}.' f1='.$suxwigb->{_f1};
		$suxwigb->{_Step}		= $suxwigb->{_Step}.' f1='.$suxwigb->{_f1};

	} else { 
		print("suxwigb, f1, missing f1,\n");
	 }
 }


=head2 sub f2 


=cut

 sub f2 {

	my ( $self,$f2 )		= @_;
	if ( $f2 ) {

		$suxwigb->{_f2}		= $f2;
		$suxwigb->{_note}		= $suxwigb->{_note}.' f2='.$suxwigb->{_f2};
		$suxwigb->{_Step}		= $suxwigb->{_Step}.' f2='.$suxwigb->{_f2};

	} else { 
		print("suxwigb, f2, missing f2,\n");
	 }
 }


=head2 sub key 


=cut

 sub key {

	my ( $self,$key )		= @_;
	if ( $key ) {

		$suxwigb->{_key}		= $key;
		$suxwigb->{_note}		= $suxwigb->{_note}.' key='.$suxwigb->{_key};
		$suxwigb->{_Step}		= $suxwigb->{_Step}.' key='.$suxwigb->{_key};

	} else { 
		print("suxwigb, key, missing key,\n");
	 }
 }


=head2 sub n2 


=cut

 sub n2 {

	my ( $self,$n2 )		= @_;
	if ( $n2 ) {

		$suxwigb->{_n2}		= $n2;
		$suxwigb->{_note}		= $suxwigb->{_note}.' n2='.$suxwigb->{_n2};
		$suxwigb->{_Step}		= $suxwigb->{_Step}.' n2='.$suxwigb->{_n2};

	} else { 
		print("suxwigb, n2, missing n2,\n");
	 }
 }


=head2 sub style 


=cut

 sub style {

	my ( $self,$style )		= @_;
	if ( $style ) {

		$suxwigb->{_style}		= $style;
		$suxwigb->{_note}		= $suxwigb->{_note}.' style='.$suxwigb->{_style};
		$suxwigb->{_Step}		= $suxwigb->{_Step}.' style='.$suxwigb->{_style};

	} else { 
		print("suxwigb, style, missing style,\n");
	 }
 }


=head2 sub tmpdir 


=cut

 sub tmpdir {

	my ( $self,$tmpdir )		= @_;
	if ( $tmpdir ) {

		$suxwigb->{_tmpdir}		= $tmpdir;
		$suxwigb->{_note}		= $suxwigb->{_note}.' tmpdir='.$suxwigb->{_tmpdir};
		$suxwigb->{_Step}		= $suxwigb->{_Step}.' tmpdir='.$suxwigb->{_tmpdir};

	} else { 
		print("suxwigb, tmpdir, missing tmpdir,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ) {

		$suxwigb->{_verbose}		= $verbose;
		$suxwigb->{_note}		= $suxwigb->{_note}.' verbose='.$suxwigb->{_verbose};
		$suxwigb->{_Step}		= $suxwigb->{_Step}.' verbose='.$suxwigb->{_verbose};

	} else { 
		print("suxwigb, verbose, missing verbose,\n");
	 }
 }


=head2 sub get_max_index
   max index = number of input variables -1
 
=cut
 
  sub get_max_index {
 	my ($self) = @_;
	# only file_name : index=36
 	my $max_index = 36;
	
 	return($max_index);
 }
 
 
1; 