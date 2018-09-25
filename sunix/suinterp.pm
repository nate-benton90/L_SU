package suinterp;

use Moose;

=head2

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: suinterp
 AUTHOR: Masoud Safari-Zanjani
 DATE:   Dec 10 2013,
 DESCRIPTION: 
 Version: 0.1
 Juan Lorenzo 0.2 June 3, 2016  Juan lorenzo
 Juan Lorenzo 0.3 July 11 2016 start adding 
               remaining options
 TODO: complete task

=head2 USE

  suinterp->su.h();
  suinterp->segy.h();
  suinterp->signal.h();

=head3  DESCRIPTION 
SUINTERP - interpolate traces using automatic event picking		
									
           suinterp < stdin > stdout					
									
 ninterp=1    number of traces to output between each pair of input traces
 nxmax=500    maximum number of input traces				
 freq1=4.     starting corner frequency of unaliased range		
 freq2=20.    ending corner frequency of unaliased range		
 deriv=0      =1 means take vertical derivative on pick section        
              (useful if interpolating velocities instead of seismic)  
 linear=0     =0 means use 8 point sinc temporal interpolation         
              =1 means use linear temporal interpolation               
              (useful if interpolating velocities instead of seismic)  
 lent=5       number of time samples to smooth for dip estimate	
 lenx=1       number of traces to smooth for dip estimate		
 lagc=400     number of ms agc for dip estimate			
 xopt=0       0 compute spatial derivative via FFT			
                 (assumes input traces regularly spaced and relatively	
                  noise-free)						
              1 compute spatial derivative via differences		
                 (will work on irregulary spaced data)			
 iopt=0     0 = interpolate
            1 = output low-pass model: useful for QC if interpolator failing
            2 = output dip picks in units of samples/trace		
									
 verbose=0	verbose = 1 echoes information				
									
 tmpdir= 	 if non-empty, use the value as a directory path	
		 prefix for storing temporary files; else if the	
	         the CWP_TMPDIR environment variable is set use		
	         its value for the path; else use tmpfile()		
 									
 Notes:								
 This program outputs 'ninterp' interpolated traces between each pair of
 input traces.  The values for lagc, freq1, and freq2 are only used for
 event tracking. The output data will be full bandwidth with no agc.  The
 default parameters typically will do a satisfactory job of interpolation
 for dips up to about 12 ms/trace.  Using a larger value for freq2 causes
 the algorithm to do a better job on the shallow dips, but to fail on the
 steep dips.  Only one dip is assumed at each time sample between each pair
 of input traces.							
 									
 The key assumption used here is that the low frequency data are unaliased
 and can be used for event tracking. Those dip picks are used to interpolate
 the original full-bandwidth data, giving some measure of interpolation
 at higher frequencies which otherwise would be aliased.  Using iopt equal
 to 1 allows you to visually check whether the low-pass picking model is
 aliased.								
 									
 Trace headers for interpolated traces are not updated correctly.	
 The output header for an interpolated traces equals that for the preceding
 trace in the original input data.  The original input traces are passed
 through this module without modification.				
									
 The place this code is most likely to fail is on the first breaks.	
									
 Example run:    suplane | suinterp | suxwigb &		

 
=head4 EXAMPLE
 		
	
 

=cut

my $suinterp = {
          _ninterp       		  	=> '',
          _num_new_traces2interp       	  	=> '',
          _freq1       	  			=> '',
          _fmin       	  			=> '',
          _freq2       	  			=> '',
          _fmax       	  			=> '',
          _deriv       	  			=> '',
          _linear         			=> '',
          _lent       	  			=> '',
          _lagc       	  			=> '',
          _xopt       	  			=> '',
          _verbose     	  			=> '',
          _iopt       	  			=> '',
          _nxmax       	  			=> '',
          _tmpdir       	  		=> '',
          _original_trace_separation     	=> '',
          _interpolated_trace_separation       	=> '',
          _note			       	  	=> '',
          _Step			       	  	=> ''    
        };

sub clear {
     $suinterp->{_ninterp} 			= '';    
     $suinterp->{_num_new_traces2interp}        = '';
     $suinterp->{_freq1}		        = '';
     $suinterp->{_fmin}		        	= '';
     $suinterp->{_freq1}		        = '';
     $suinterp->{_fmax}		        	= '';
     $suinterp->{_freq2}		        = '';
     $suinterp->{_deriv}		        = '';
     $suinterp->{_linear}		        = '';
     $suinterp->{_lent}		        	= '';
     $suinterp->{_lagc}			        = '';
     $suinterp->{_xopt}			        = '';
     $suinterp->{_iopt}			        = '';
     $suinterp->{_nxmax}			= '';
     $suinterp->{_tmpdir}			= '';
     $suinterp->{_original_trace_separation}	= '';
     $suinterp->{_interpolated_trace_separation}= '';
     $suinterp->{_interpolation_factor}	= '';
     $suinterp->{_verbose}			= '';
     $suinterp->{_note}			        = '';
     $suinterp->{_Step}			        = '';
}

=head2 sub ninterp

=cut

sub  ninterp {
    my ($variable,$ninterp)     = @_;
    $suinterp->{_ninterp}       = $ninterp if defined($ninterp);
    $suinterp->{_note}          = $suinterp->{_note}.' ninterp='.$suinterp->{_ninterp};
    $suinterp->{_Step}          = $suinterp->{_Step}.' ninterp='.$suinterp->{_ninterp};
    #print("$suinterp->{_Step}\n\n");
}
=head2 sub num_new_traces2interp

     same as ninterp
     number of new traces
     to crate between existant pairs
=cut

sub  num_new_traces2interp {
    my ($variable,$num_new_traces2interp)     = @_;
    if(defined($num_new_traces2interp)) {
      $suinterp->{_ninterp}       = $num_new_traces2interp;
      $suinterp->{_note}          = $suinterp->{_note}.' ninterp='.$suinterp->{_ninterp};
      $suinterp->{_Step}          = $suinterp->{_Step}.' ninterp='.$suinterp->{_ninterp};
    #print("$suinterp->{_Step}\n\n");
    }
}

=head2 subxi freq1

=cut

sub freq1{
  my ($variable,$freq1) = @_;
    if  ($freq1) {
	$suinterp->{_freq1}	    	= $freq1;
    	$suinterp->{_Step}        = $suinterp->{_Step}.' freq1='.$suinterp->{_freq1};
    	$suinterp->{_note} 	= $suinterp->{_note}.' freq1='.$suinterp->{_freq1};
     }
}

=head2 subxi fmin

 same as freq1

=cut

sub fmin{
  my ($variable,$fmin) = @_;
    if  ($fmin) {
	$suinterp->{_fmin}	    	= $fmin;
    	$suinterp->{_Step}        = $suinterp->{_Step}.' freq1='.$suinterp->{_fmin};
    	$suinterp->{_note} 	= $suinterp->{_note}.' fmin='.$suinterp->{_fmin};
     }
}

=head2 subxi freq2

=cut

sub freq2{
  my ($variable,$freq2) = @_;
    if  ($freq2) {
	$suinterp->{_freq2}	    	= $freq2;
    	$suinterp->{_Step}        = $suinterp->{_Step}.' freq2='.$suinterp->{_freq2};
    	$suinterp->{_note} 	= $suinterp->{_note}.' freq2='.$suinterp->{_freq2};
     }
}

=head2 sub fmax
 
 same as freq2

=cut

sub fmax{
  my ($variable,$fmax) = @_;
    if  ($fmax) {
	$suinterp->{_fmax}	    	= $fmax;
    	$suinterp->{_Step}        = $suinterp->{_Step}.' fmax='.$suinterp->{_fmax};
    	$suinterp->{_note} 	= $suinterp->{_note}.' fmax='.$suinterp->{_fmax};
     }
}



=head2 sub deriv

=cut

sub deriv{
  my ($variable,$deriv) = @_;
    if  ($deriv) {
	$suinterp->{_deriv}	    	= $deriv;
    	$suinterp->{_Step}        = $suinterp->{_Step}.' deriv='.$suinterp->{_deriv};
    	$suinterp->{_note} 	= $suinterp->{_note}.' deriv='.$suinterp->{_deriv};
     }
}


=head2 sub linear

=cut

sub linear{
  my ($variable,$linear) = @_;
    if  ($linear) {
	$suinterp->{_linear}	    	= $linear;
    	$suinterp->{_Step}        = $suinterp->{_Step}.' linear='.$suinterp->{_linear};
    	$suinterp->{_note} 	= $suinterp->{_note}.' linear='.$suinterp->{_linear};
     }
}


=head2 sub lent

=cut

sub lent{
  my ($variable,$lent) = @_;
    if  ($lent) {
	$suinterp->{_lent}	    	= $lent;
    	$suinterp->{_Step}        = $suinterp->{_Step}.' lent='.$suinterp->{_lent};
    	$suinterp->{_note} 	= $suinterp->{_note}.' lent='.$suinterp->{_lent};
     }
}


=head2 sub smooth_ns_t 

  same as lent
  number of samples to smooth in time

=cut

sub smooth_ns_t{
  my ($variable,$smooth_ns_t) = @_;
    if  ($smooth_ns_t) {
	$suinterp->{_smooth_ns_t}	    	= $smooth_ns_t;
    	$suinterp->{_Step}        = $suinterp->{_Step}.' lent='.$suinterp->{_smooth_ns_t};
    	$suinterp->{_note} 	= $suinterp->{_note}.' smooth_ns_t='.$suinterp->{_smooth_ns_t};
     }
}


=head2 sub lenx

  same as lenx
  number of traces to smooth 

=cut

sub lenx{
  my ($variable,$lenx) = @_;
    if  ($lenx) {
	$suinterp->{_lenx}	    	= $lenx;
    	$suinterp->{_Step}        = $suinterp->{_Step}.' lenx='.$suinterp->{_lenx};
    	$suinterp->{_note} 	= $suinterp->{_note}.' lenx='.$suinterp->{_lenx};
     }
}

=head2 sub smooth_ntr

  same as lenx
  number of traces to smooth 

=cut

sub smooth_ntr{
  my ($variable,$smooth_ntr) = @_;
    if  ($smooth_ntr) {
	$suinterp->{_smooth_ntr}	    	= $smooth_ntr;
    	$suinterp->{_Step}        = $suinterp->{_Step}.' lenx='.$suinterp->{_smooth_ntr};
    	$suinterp->{_note} 	= $suinterp->{_note}.' smooth_ntr='.$suinterp->{_smooth_ntr};
     }
}



=head2 sub lagc

=cut

sub lagc{
  my ($variable,$lagc) = @_;
    if  ($lagc) {
	$suinterp->{_lagc}	    	= $lagc;
    	$suinterp->{_Step}        = $suinterp->{_Step}.' lagc='.$suinterp->{_lagc};
    	$suinterp->{_note} 	= $suinterp->{_note}.' lagc='.$suinterp->{_lagc};
     }
}


=head2 sub xopt

=cut

sub xopt{
  my ($variable,$xopt) = @_;
    if  ($xopt) {
	$suinterp->{_xopt}	    	= $xopt;
    	$suinterp->{_Step}        = $suinterp->{_Step}.' xopt='.$suinterp->{_xopt};
    	$suinterp->{_note} 	= $suinterp->{_note}.' xopt='.$suinterp->{_xopt};
     }
}


=head2 sub iopt

=cut

sub iopt{
  my ($variable,$iopt) = @_;
    if  ($iopt) {
	$suinterp->{_iopt}	    	= $iopt;
    	$suinterp->{_Step}        = $suinterp->{_Step}.' iopt='.$suinterp->{_iopt};
    	$suinterp->{_note} 	= $suinterp->{_note}.' iopt='.$suinterp->{_iopt};
     }
}


=head2 sub verbose

=cut

sub verbose{
  my ($variable,$verbose) = @_;
    if  ($verbose) {
	$suinterp->{_verbose}	    	= $verbose;
    	$suinterp->{_Step}        = $suinterp->{_Step}.' verbose='.$suinterp->{_verbose};
    	$suinterp->{_note} 	= $suinterp->{_note}.' verbose='.$suinterp->{_verbose};
     }
}


=head2 sub tmpdir

=cut

sub tmpdir{
  my ($variable,$tmpdir) = @_;
    if  ($tmpdir) {
	$suinterp->{_tmpdir}	    	= $tmpdir;
    	$suinterp->{_Step}        = $suinterp->{_Step}.' tmpdir='.$suinterp->{_tmpdir};
    	$suinterp->{_note} 	= $suinterp->{_note}.' tmpdir='.$suinterp->{_tmpdir};
     }
}


=head2 sub update_num_traces

 calculate if we know the original trace separation 
 .e.g. 2 m or 2 feet
 input the original trace separation
 return the update trace separation
 estimate the new trace separation after interpolation
 confirm that interpolation parameters exist

=cut

sub update_num_traces{

  my ($variable,$old_num_traces) = @_;
  if  (defined($old_num_traces)) {
	$suinterp->{_old_num_traces} = $old_num_traces;
	if(defined($suinterp->{_ninterp}))  {
           $suinterp->{_update_num_traces} = ($suinterp->{_old_num_traces} -1 ) * $suinterp->{_ninterp} + $suinterp->{_old_num_traces};

        }
	else {
	print("Warning: required number of new interpolated traces\n\n");
	}

    	$suinterp->{_note} 	= $suinterp->{_note}.' updated_num_traces='.$suinterp->{_update_num_traces};
      print("updated number of traces is $suinterp->{_update_num_traces}\n\n");

  return $suinterp->{_update_num_traces};
  }
}



=head2 sub update_trace_separation

 calculate if we know the original trace separation 
 e.g., 2 m or 2 feet
 input the original trace separation
 return the update trace separation
 estimate the new trace separation after interpolation
 confirm that interpolation parameters exist

 When ninterp=1 
 and interpolation factor=1
	print ("interpolated trace separation is $suinterp->{_update_trace_separation}\n\n");
	print ("interpolation factor  is $suinterp->{_interpolation_factor}\n\n");

=cut

sub update_trace_separation{

  my ($variable,$old_trace_separation) = @_;
  if  (defined($old_trace_separation)) {
      $suinterp->{_old_trace_separation} = $old_trace_separation;
	if(defined($suinterp->{_ninterp} ))  {
           $suinterp->{_interpolation_factor}    = $suinterp->{_ninterp} + 1 ;
           $suinterp->{_update_trace_separation} = $suinterp->{_old_trace_separation}/$suinterp->{_interpolation_factor};
    	   $suinterp->{_note} 	= $suinterp->{_note}.' updated_trace_separation='.$suinterp->{_update_trace_separation};
  return $suinterp->{_update_trace_separation};
        }
        else {
	    print("Warning: requires number of new traces to interpolate \n\n");
	}
  }
}


=head2

subroutine Step is used to build the correct
syntax for using program suninterp

=cut


sub Step{
    $suinterp->{_Step}       = 'suinterp'.$suinterp->{_Step};
    return $suinterp->{_Step};
}


=head2

 stores the  same syntax as Step
 for additional uses 

=cut

sub note {
    $suinterp->{_note}       =  'suinterp'.$suinterp->{_note};
    return $suinterp->{_note};
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
