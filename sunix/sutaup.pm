package sutaup;

use Moose;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: sutaup.pm, 
 AUTHOR: Juan Lorenzo
 DATE:   Jan 12 2017 
 Version 1

=cut


=head2 DESCRIPTION

SUTAUP - forward and inverse T-X and F-K global slant stacks		
                                                                       
    sutaup <infile >outfile  [optional parameters]                 	
                                                                       
 Optional Parameters:                                                  
 option=1			=1 for forward F-K domian computation	
				=2 for forward T-X domain computation	
				=3 for inverse F-K domain computation	
				=4 for inverse T-X domain computation	
 dt=tr.dt (from header) 	time sampling interval (secs)           
 nx=ntr   (counted from data)	number of horizontal samples (traces)	
 dx=1				horizontal sampling interval (m)	
 npoints=71			number of points for rho filter		
 pmin=0.0			minimum slope for Tau-P transform (s/m)	
 pmax=.006			maximum slope for Tau-P transform (s/m)	
 np=nx				number of slopes for Tau-P transform	
 ntau=nt			number of time samples in Tau-P domain  
 fmin=3			minimum frequency of interest 	        
 xmin=0			offset on first trace	 	        
                                                                       
 verbose=0	verbose = 1 echoes information				
									
 tmpdir= 	 if non-empty, use the value as a directory path	
		 prefix for storing temporary files; else if the	
	         the CWP_TMPDIR environment variable is set use		
	         its value for the path; else use tmpfile()		
 									
 Notes:                                                                
 The cascade of a forward and inverse  tau-p transform preserves the	
 relative amplitudes in a data panel, but not the absolute amplitudes  
 meaning that a scale factor must be applied to data output by such a  
 a cascade before the output may be compared to the original data.	
 This is a characteristic of the algorithm employed in this program.	
 (Suradon does not have this problem.)					


=cut


my $sutaup = {
         _option        	=>'',
         _inverse_via_fk        =>'3',
         _inverse_via_tx        =>'4',
         _forward_via_fk        =>'1',
         _forward_via_tx        =>'2',
         _compute_via_in    	=>'',
         _Step          	=>'',
	 _dp            	=>'',
	 _dt            	=>'',
	 _dx            	=>'',
	 _npoints		=>'',
	 _pmin          	=>'',
	 _pmax          	=>'',
	 _np            	=>'',
	 _nx            	=>'',
	 _outbound_pickfile    	=>'',
	 _ntau          	=>'',
	 _vmin          	=>'',
	 _vmax          	=>'',
	 _fmin          	=>'',
	 _xmin          	=>'',
	 _verbose       	=>'',
	 _tmpdir        	=>'',
         _note      		=>'',
	 _Step			=>''
};
   
my $newline    = '
';


sub clear {
    $sutaup->{_option} 			= '';
    $sutaup->{_compute_in} 		= '';
    $sutaup->{_inverse_via_fk}        	= '';
    $sutaup->{_inverse_via_tx}        	= '';
    $sutaup->{_forward_via_fk}        	= '';
    $sutaup->{_forward_via_tx }       	= '';
    $sutaup->{_dp} 			= '';
    $sutaup->{_dt} 			= '';
    $sutaup->{_dx} 			= '';
    $sutaup->{_npoints} 		= '';
    $sutaup->{_pmin} 			= '';
    $sutaup->{_pmax} 			= '';
    $sutaup->{_np} 			= '';
    $sutaup->{_nx} 			= '';
    $sutaup->{_outbound_pickfile} 	= '';
    $sutaup->{_ntau} 			= '';
    $sutaup->{_fmin} 			= '';
    $sutaup->{_vmin} 			= '';
    $sutaup->{_vmax} 			= '';
    $sutaup->{_xmin} 			= '';
    $sutaup->{_verbose} 		= '';
    $sutaup->{_tmpdir}			= '';
    $sutaup->{_Step} 			= '';
    $sutaup->{_note} 			= '';
}

sub Step{
    my ($variable,$Step) = @_;
    $sutaup->{_Step} = ' sutaup'.$sutaup->{_Step};
    return $sutaup->{_Step};
}

sub note{
    my ($variable, $note) = @_;
    $sutaup->{_note} =  $sutaup->{_note};
    return $sutaup->{_note};
}

=head2 sub inverse_via_fk
       
        same as subroutine option
	up to 4

=cut 

sub inverse_via_fk {
 
    $sutaup->{_inverse_via_fk}        	= 3 ;
    $sutaup->{_Step}       		= $sutaup->{_Step}.' option='.$sutaup->{_inverse_via_fk};
    $sutaup->{_note} 	   		= $sutaup->{_note}.' calculate inverse_via_fk';

}

=head2 sub optioninverse_via_tx
       
        same as subroutine option
	up to 4

=cut

sub inverse_via_tx {
 
    $sutaup->{_inverse_via_tx}        	= 4 ;
    $sutaup->{_Step}       		= $sutaup->{_Step}.' option='.$sutaup->{_inverse_via_tx};
    $sutaup->{_note} 	   		= $sutaup->{_note}.' calculate inverse_via_tx';

}


=head2 sub forward_via_fk
       
        same as subroutine option
	up to 4

=cut

sub forward_via_fk {
 
    $sutaup->{_forward_via_fk}        	= 1 ;
    $sutaup->{_Step}       		= $sutaup->{_Step}.' option='.$sutaup->{forward_via_fk};
    $sutaup->{_note} 	   		= $sutaup->{_note}.' calculate forward_via_fk';

}



=head2 sub forward_via_tx
       
        same as subroutine option
	up to 4

=cut

sub forward_via_tx {
 
    $sutaup->{_forward_via_tx}        	= 2 ;
    $sutaup->{_Step}       		= $sutaup->{_Step}.' option='.$sutaup->{_forward_via_tx};
    $sutaup->{_note} 	   		= $sutaup->{_note}.' calculate forward_via_tx';

}


=head2 sub option

	up to 4

=cut


sub option{
  my ($variable,$option) = @_;
    if ($option) {
	$sutaup->{_option}	   = $option;
    	$sutaup->{_Step}           = $sutaup->{_Step}.' option='.$sutaup->{_option};
    	$sutaup->{_note} 	   = $sutaup->{_note}.' option='.$sutaup->{_option};
     }
 }

=head2 sub compute_in

	up to 4

=cut

sub compute_in{
  my ($variable,$compute_in) = @_;
    if ($compute_in) {
	$sutaup->{_compute_in}	   = $compute_in;
    	$sutaup->{_Step}           = $sutaup->{_Step}.' option='.$sutaup->{_compute_in};
    	$sutaup->{_note} 	   = $sutaup->{_note}.' compute_in='.$sutaup->{_compute_in};
     }
 }

=head2 sub dp


=cut

sub dp{

    if (defined($sutaup->{_pmin}) && $sutaup->{_pmax} && $sutaup->{_np} ) {
       $sutaup->{_note} 	= $sutaup->{_note}.' dp='.$sutaup->{_dp};
       $sutaup->{_dp}	    	= ($sutaup->{_pmax} - $sutaup->{_pmin})/ ($sutaup->{_np} -1) ; 
	print("dp is $sutaup->{_dp}\n\n");
    }
    else {
	print("Warning: dp requires np, and pmax and pmin\n");
	print("Declare pmax and pmin and np earlier \n\n");
	print("\tnp is $sutaup->{_np}\n\n");
	print("\tpmax is $sutaup->{_pmax} and pmin is $sutaup->{_pmin}\n\n");
    }
    return $sutaup->{_dp};
}


=head2 sub dt

	up to 4

=cut

sub dt{
  my ($variable,$dt) = @_;
    if  ($dt) {
	$sutaup->{_dt}	    	= $dt;
    	$sutaup->{_Step}        = $sutaup->{_Step}.' dt='.$sutaup->{_dt};
    	$sutaup->{_note} 	= $sutaup->{_note}.' dt='.$sutaup->{_dt};
     }
}

=head2 sub dx

=cut

sub dx {
  my ($variable,$dx) = @_;
    if  ($dx) {
	$sutaup->{_dx}	    	= $dx;
    	$sutaup->{_Step}        = $sutaup->{_Step}.' dx='.$sutaup->{_dx};
    	$sutaup->{_note} 	= $sutaup->{_note}.' dx='.$sutaup->{_dx};
     }
}

=head2 sub npoints

=cut

sub npoints {
  my ($variable,$npoints) = @_;
    if  ($npoints) {
	$sutaup->{_npoints}	    	= $npoints;
    	$sutaup->{_Step}        = $sutaup->{_Step}.' npoints='.$sutaup->{_npoints};
    	$sutaup->{_note} 	= $sutaup->{_note}.' npoints='.$sutaup->{_npoints};
     }
}

=head2 sub outbound_pickfile 

  Provides a default output file name
  for picking data points

  i/p requires a base-file name (i.e. no *.su extension)
	e.g. All_cmp
  o/p  ~/seismics_LSU/FalseRiver/seismics/pl/Bueche/All/H/1/gom/All_cmp_fp_picks

=cut

sub outbound_pickfile {
  my ($variable,$file_in) = @_;

    if  ($file_in) {

=head2 Use directory navigation system
        and default parameter file names from
	SeismicUnix class

=cut
		use Project;
		my $Project = new Project;
        my ($DATA_SEISMIC_SU) = $Project->DATA_SEISMIC_SU();
        my ($PL_SEISMIC)      = $Project->PL_SEISMIC();
        use SeismicUnix qw ($suffix_fp $suffix_su); 

        my $sufile_in			= $file_in.$suffix_su;
  	my $inbound			= $DATA_SEISMIC_SU.'/'.$sufile_in;
  	my $file_out			= $file_in.$suffix_fp;
        $sutaup->{_outbound_pickfile}	= $PL_SEISMIC.'/'.$file_out.'_picks';

	return ($sutaup->{_outbound_pickfile});

     }
}


=head2 sub pmin

     print("pmin is $sutaup->{_pmin}}\n\n");

=cut

sub pmin {
  my ($variable,$pmin) = @_;
	if (defined($pmin)) {
	$sutaup->{_pmin}	   = $pmin;
    	$sutaup->{_Step}           = $sutaup->{_Step}.' pmin='.$sutaup->{_pmin};
    	$sutaup->{_note} 	   = $sutaup->{_note}.' pmin='.$sutaup->{_pmin};
    } 
 }

=head2 sub pmax

=cut

sub pmax{
  my ($variable, $pmax) = @_;
    if  ($pmax) {
	$sutaup->{_pmax}	    = $pmax;
    	$sutaup->{_Step}            = $sutaup->{_Step}.' pmax='.$sutaup->{_pmax};
    	$sutaup->{_note} 	    = $sutaup->{_note}.' pmax='.$sutaup->{_pmax};
     }

 }

=head2 sub vmin

     print("vmin is $sutaup->{_vmin}}\n\n");

=cut

sub vmin {
  my ($variable,$vmin) = @_;
	if (defined($vmin)) {
	$sutaup->{_vmin}	   = $vmin;
       $sutaup->{_pmax}           = 1 / $sutaup->{_vmin};
    	$sutaup->{_Step}           = $sutaup->{_Step}.' pmax='.$sutaup->{_pmax};
    	$sutaup->{_note} 	   = $sutaup->{_note}.' vmin='.$sutaup->{_vmin}.' pmax='.$sutaup->{_pmax};
    } 
 }

=head2 sub vmax

=cut

sub vmax{
  my ($variable, $vmax) = @_;
    if  ($vmax) {
	$sutaup->{_vmax}	    = $vmax;
       $sutaup->{_pmin}           = 1 / $sutaup->{_vmax};
    	$sutaup->{_Step}            = $sutaup->{_Step}.' pmin='.$sutaup->{_pmin};
    	$sutaup->{_note} 	    = $sutaup->{_note}.' vmax='.$sutaup->{_vmax}.' pmin='.$sutaup->{_pmin};
     }

 }


=head2 sub np
  
  usually, = number of traces

=cut

sub np{
  my ($variable, $np) = @_;
    if  ($np) {
	$sutaup->{_np}	          = $np;
    	$sutaup->{_Step}          = $sutaup->{_Step}.' np='.$sutaup->{_np};
    	$sutaup->{_note} 	  = $sutaup->{_note}.' np='.$sutaup->{_np};
     }

 }

=head2 sub nx

=cut

sub nx{
  my ($variable, $nx) = @_;
    if  ($nx) {
	$sutaup->{_nx}	    	= $nx;
    	$sutaup->{_Step}        = $sutaup->{_Step}.' nx='.$sutaup->{_nx};
    	$sutaup->{_note} 	= $sutaup->{_note}.' nx='.$sutaup->{_nx};
     }

 }

=head2 sub ntau

=cut

sub ntau{
  my ($variable, $ntau) = @_;
    if  ($ntau) {
	$sutaup->{_ntau}	 = $ntau;
    	$sutaup->{_Step}         = $sutaup->{_Step}.' ntau='.$sutaup->{_ntau};
    	$sutaup->{_note} 	 = $sutaup->{_note}.' ntau='.$sutaup->{_ntau};
     }

 }

=head2 sub fmin

=cut

sub fmin{
  my ($variable, $fmin) = @_;
    if  ($fmin) {
	$sutaup->{_fmin}	  = $fmin;
    	$sutaup->{_Step}          = $sutaup->{_Step}.' fmin='.$sutaup->{_fmin};
    	$sutaup->{_note} 	  = $sutaup->{_note}.' fmin='.$sutaup->{_fmin};
     }

 }

=head2 sub xmin

=cut

sub xmin{
  my ($variable, $xmin) = @_;
    if  ($xmin) {
	$sutaup->{_xmin}	  = $xmin;
    	$sutaup->{_Step}          = $sutaup->{_Step}.' xmin='.$sutaup->{_xmin};
    	$sutaup->{_note} 	  = $sutaup->{_note}.' xmin='.$sutaup->{_xmin};
     }

 }

=head2 sub verbose

=cut

 sub verbose{
  my ($variable, $verbose) = @_;
    if  ($verbose) {
	$sutaup->{_verbose}	  = $verbose;
    	$sutaup->{_Step}          = $sutaup->{_Step}.' verbose='.$sutaup->{_verbose};
    	$sutaup->{_note} 	  = $sutaup->{_note}.' verbose='.$sutaup->{_verbose};
     }

 }
=head2 sub tmpdir

=cut

sub tmpdir{
  my ($variable, $tmpdir) = @_;
    if  ($tmpdir) {
	$sutaup->{_tmpdir}	  = $tmpdir;
    	$sutaup->{_Step}          = $sutaup->{_Step}.' tmpdir='.$sutaup->{_tmpdir};
    	$sutaup->{_note} 	  = $sutaup->{_note}.' tmpdir='.$sutaup->{_tmpdir};
     }
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
