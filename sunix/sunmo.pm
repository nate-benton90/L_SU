package sunmo;
use Moose;

=pod

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: sunmo 
 AUTHOR: Chang Liu
 DATE:   Dec 1 2013
 DESCRIPTION: 
 Version: 1.1
          i1.2 July 15, 2015 (JML)

=head2 USE

=head3 NOTES 

=head4 
 Examples

=head3 SEISMIC UNIX NOTES  


SUNMO - NMO for an arbitrary velocity function of time and CDP	     
									     
  sunmo <stdin >stdout [optional parameters]				     
									     
 Optional Parameters:							     
 tnmo=0,...		NMO times corresponding to velocities in vnmo	     
 vnmo=1500,...		NMO velocities corresponding to times in tnmo	     
 cdp=			CDPs for which vnmo & tnmo are specified (see Notes) 
 smute=1.5		samples with NMO stretch exceeding smute are zeroed  
 lmute=25		length (in samples) of linear ramp for stretch mute  
 sscale=1		=1 to divide output samples by NMO stretch factor    
 invert=0		=1 to perform (approximate) inverse NMO		     
 upward=0		=1 to scan upward to find first sample to kill	     
 voutfile=		if set, interplolated velocity function v[cdp][t] is 
			output to named file.			     	     
 Notes:								     
 For constant-velocity NMO, specify only one vnmo=constant and omit tnmo.   
									     
 NMO interpolation error is less than 1% for frequencies less than 60% of   
 the Nyquist frequency.						     
									     
 Exact inverse NMO is impossible, particularly for early times at large
offsets and for frequencies near Nyquist with large interpolation errors.  
 								     	     
 The "offset" header field must be set.				     
 Use suazimuth to set offset header field when sx,sy,gx,gy are all	     
 nonzero. 							   	     
									     
 For NMO with a velocity function of time only, specify the arrays	     
	   vnmo=v1,v2,... tnmo=t1,t2,...				     
 where v1 is the velocity at time t1, v2 is the velocity at time t2, ...    
 The times specified in the tnmo array must be monotonically increasing.    
 Linear interpolation and constant extrapolation of the specified velocities
 is used to compute the velocities at times not specified.		     
 The same holds for the anisotropy coefficients as a function of time only. 
									     

 For NMO with a velocity function of time and CDP, specify the array	     
	   cdp=cdp1,cdp2,...						     
 and, for each CDP specified, specify the vnmo and tnmo arrays as described 
 above. The first (vnmo,tnmo) pair corresponds to the first cdp, and so on. 
 Linear interpolation and constant extrapolation of 1/velocity^2 is used    
 to compute velocities at CDPs not specified.				     
									     
 The format of the output interpolated velocity file is unformatted C floats
 with vout[cdp][t], with time as the fast dimension and may be used as an  
input velocity file for further processing.				     
									     
 Note that this version of sunmo does not attempt to deal with	anisotropy.  
 The version of sunmo with experimental anisotropy support is "sunmo_a"  


=head4 CHANGES and their DATES

 Juan Lorenzo July 15 2015
 introduced "par" subroutine

=cut
 

=pod

=head3 STEPS

 1. define the types of variables you are using
    these would be the values you enter into 
    each of the Seismic Unix programs 

 2. build a list or hash with all the possible variable
    names you may use and you can even change them

=cut

 my $sunmo = {
          _tnmo       => '',    
    	  _vnmo       => '',
          _cdp        => '',
          _smute      => '',
          _lmute      => '',
          _sscale     => '',
          _invert     => '',
          _par        => '',
          _upward     => ''
        };

# define a value
my $newline  = '';
  
#sub test {
# my ($test,@value) = @_;
#print("\$test or the first scalar  'holds' a  HASH $test 
# that represents the name of the  
# subroutine you are trying to use and all its needed components\n");
# print("\@value, the second scalar is something 'real' you put in, i.e., @value\n\n");
# print("new line is $newline\n");
 #my ($sugain->{_Step}) = $sugain->{_Step} +1;
 #print("Share step is first $sugain->{_Step}\n");

=pod

=head2 subroutine clear

  sets all variable strings to '' 

=cut

sub clear {
   $sunmo->{_tnmo} 		= '';
   $sunmo->{_vnmo} 		= '';
   $sunmo->{_cdp} 		= '';
   $sunmo->{_smute} 		= '';
   $sunmo->{_lmute} 		= '';
   $sunmo->{_sscale} 		= '';
   $sunmo->{_invert}		= '';
   $sunmo->{_upward}		= '';
   $sunmo->{_par}		= '';
   $sunmo->{_note}       	= '';
   $sunmo->{_Step}              = '';
}

=pod

=head2 subroutine setdt 

  sets value of sampling interval 

=cut

sub dt {
    my ($variable,$dt)   = @_;
    $sunmo->{_dt}       = $dt if defined($dt);
    $sunmo->{_note}     = $sunmo->{_note}.' dt='.$sunmo->{_dt};
    $sunmo->{_Step}     = $sunmo->{_Step}.' dt='.$sunmo->{_dt};
}

=pod

=head2 subroutine par 

  read in a formatted parameter file

=cut

sub par {
    my($variable,$par)   = @_;
    $sunmo->{_par}       = $par if defined($par);
    $sunmo->{_note}     = $sunmo->{_note}.' par='.$sunmo->{_par};
    $sunmo->{_Step}     = $sunmo->{_Step}.' par='.$sunmo->{_par};
}

sub tnmo {
    my ($variable,$tnmo)   = @_;
    $sunmo->{_tnmo}     = $tnmo if defined($tnmo);
    $sunmo->{_note}       = $sunmo->{_note}.' tnmo='.$sunmo->{_tnmo};
    $sunmo->{_Step}       = $sunmo->{_Step}.' tnmo='.$sunmo->{_tnmo};
}

sub vnmo {
    my ($variable,$vnmo)   = @_;
    $sunmo->{_vnmo}       = $vnmo if defined($vnmo);
    $sunmo->{_note}       = $sunmo->{_note}.' vnmo='.$sunmo->{_vnmo};
    $sunmo->{_Step}       = $sunmo->{_Step}.' vnmo='.$sunmo->{_vnmo};
}

sub cdp {
    my ($variable,$cdp)   = @_;
    $sunmo->{_cdp} 	   = $cdp if defined($cdp);		
    $sunmo->{_note}  	   = $sunmo->{_note}.' cdp='.$sunmo->{_cdp};
    $sunmo->{_Step}  	   = $sunmo->{_Step}.' cdp='.$sunmo->{_cdp};
}

sub smute {
    my ($sub,$smute)         = @_;
    $sunmo->{_smute}        = $smute if defined($smute);
    $sunmo->{_note}       = $sunmo->{_note}.' smute='.$sunmo->{_smute};
    $sunmo->{_Step}       = $sunmo->{_Step}.' smute='.$sunmo->{_smute};
}

sub lmute {
    my ($sub,$lmute)	   = @_;
    $sunmo->{_lmute} 	   = $lmute if defined($lmute);		
    $sunmo->{_note}  	   = $sunmo->{_note}.' lmute='.$sunmo->{_lmute};
    $sunmo->{_Step}  	   = $sunmo->{_Step}.' lmute='.$sunmo->{_lmute};
}

sub Step{
    $sunmo->{_Step}       = 'sunmo'.$sunmo->{_Step};
    return $sunmo->{_Step};
}

sub note {
    $sunmo->{_note}       =  $sunmo->{_note};
    return $sunmo->{_note};
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
