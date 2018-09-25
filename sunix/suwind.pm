package suwind;

=pod

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: suwind 
 AUTHOR: Juan Lorenzo
 DATE: Nov 1 2012
 DESCRIPTION suwind a lists of header words
 or an single value
 Version 1

=cut


=head2  Notes from Seismic Unix
SUWIND - window traces by key word					
									
  suwind <stdin >stdout [options]					
									
 Required Parameters:							
  none 								
									
 Optional Parameters:							
 verbose=0		=1 for verbose					
 key=tracl		Key header word to window on (see segy.h)	
 min=LONG_MIN		min value of key header word to pass		
 max=LONG_MAX		max value of key header word to pass		
									
 abs=0			=1 to take absolute value of key header word	
 j=1			Pass every j-th trace ...			
 s=0			... based at s  (if ((key - s)%j) == 0)		
 skip=0		skip the initial N traces                       
 count=ULONG_MAX	... up to count traces				
 reject=none		Skip traces with specified key values		
 accept=none		Pass traces with specified key values(see notes)
			processing, but do no window the data		
 ordered=0		=1 if traces sorted in increasing keyword value 
			=-1  if traces are sorted in a decreasing order 
									
 Options for vertical windowing (time gating):				
 dt=tr.dt (from header) time sampling interval (sec)	(seismic data)	
 			 =tr.d1  (nonseismic)				
 f1=tr.delrt (from header) first sample		(seismic data)	
 			 =tr.f1  (nonseismic)				
									
 tmin=0.0		min time to pass				
 tmax=(from header)	max time to pass				
 itmin=0		min time sample to pass				
 itmax=(from header)   max time sample to pass				
 nt=itmax-itmin+1	number of time samples to pass			
									
 Notes:								
 On large data sets, the count parameter should be set if		
 possible.  Otherwise, every trace in the data set will be		
 examined.  However, the count parameter overrides the accept		
 parameter, so you can't specify count if you want true		
 unconditional acceptance.						
                                                                       
 The skip= option allows the user to skip over traces, which helps	
 for selecting traces far from the beginning of the dataset.		
 Caveat: skip only works with disk input.                        	
                                                                       
 The ordered= option will speed up the process if the data are   	
 sorted in according to the key.                                 	
									
 The accept option is a bit strange--it does NOT mean accept ONLY	
 the traces on the accept list!  It means accept these traces,   	
 even if they would otherwise be rejected (except as noted in the	
 previous paragraph).  To implement accept-only, you can use the 	
 max=0 option (rejecting everything).  For example, to accept    	
 only the tracl values 4, 5 and 6:					
	... | suwind max=0 accept=4,5,6 | ...		   		
									
 Another example is the case of suppressing nonseismic traces in 	
 a seismic data set. By the SEGY standard header field trace id, 	
 trid=1 designates traces as being seismic traces. Other traces, 	
 such as calibration traces may be designated by another value.

Example:  trid=1 seismic and trid=0 is nonseismic. To reject    	
       nonseismic traces						
       ... | suwind key=trid reject=0 | ...				
      									
 On most 32 bit machines, LONG_MIN, LONG_MAX and ULONG_MAX are   	
 about -2E9,+2E9 and 4E9, they are defined in limits.h.		
									
 Selecting times beyond the maximum in the data induces		
 zero padding (up to SU_NFLTS).					
									
 The time gating here is to the nearest neighboring sample or    	
 time value. Gating to the exact temporal value requires	 	
 resampling if the selected times fall between samples on the    	
 trace. Use suresamp to perform the time gating in this case.    	
									
 It doesn't really make sense to specify both itmin and tmin,		
 but specifying itmin takes precedence over specifying tmin.		
 Similarly, itmax takes precedence over tmax and tmax over nt.		
 If dt in header is not set, then dt is mandatory

=cut

sub new
{
    my $class = shift;
    my $suwind = {
        _accept_only_tracl,  => shift,
        _accept_only_list,   => shift,
        _setheaderword,      => shift,
        _key,     	     => shift,
        _list,               => shift,
        _min,                => shift,
        _max,                => shift,
        _note,               => shift,
        _tmax,               => shift,
        _tmin,               => shift,
        _Step,               => shift,
        _file,               => shift,
    };
         bless $suwind, $class;
	 initiate();
         return $suwind;
 }

=head2 sub accept_only_tracl

 when selecting multiple traces
 all at once
 use a list 

=cut

sub accept_only_tracl {
    my ($suwind, $ref_list) = @_;    
    @list            = @$ref_list if defined($ref_list);
#   perl starts lists at 0
    $length_list     = scalar(@list);
    $end             = $length_list;
    $start           = 0;

# init
    $suwind->{_Step} = $suwind->{_Step}.' max=0 accept='.$list[$start];
# rest
    for ($i = $start + 1; $i<$end; $i++) {
      $suwind->{_Step} = $suwind->{_Step}.','.$list[$i];
    }

}

=pod

sub accept_only_list: when selecting multiple traces
                  all at once
                  should be used with list,setheaderword 

=cut

sub accept_only_list {
    my ($suwind, $ref_list) = @_;    
    @list            = @$ref_list if defined($ref_list);
#   perl starts lists at 0
    $length_list     = scalar(@list);
    $end             = $length_list;
    $start           = 0;

# init
    $suwind->{_Step} = $suwind->{_Step}.' max=0 accept='.$list[$start];
# rest
    for ($i = $start + 1; $i<$end; $i++) {
      $suwind->{_Step} = $suwind->{_Step}.','.$list[$i];
    }

}



sub initiate {
   $newline    = '
';
}


sub clear {
    my ($suwind) 		= @_;
    $suwind->{_file} 		= '';
    $suwind->{_key} 		= '';
    $suwind->{_setheaderword} 	= '';
    $suwind->{_list} 	        = '';
    $suwind->{_min} 		= '';
    $suwind->{_note} 		= '';
    $suwind->{_tmin} 		= '';
    $suwind->{_max} 		= '';
    $suwind->{_tmax} 		= '';
    $suwind->{_Step} 		= '';
}


=pod sub setheaderword

 set which header word to use as the x-coordinate for plotting

=cut

sub setheaderword {
    my ($suwind, $setheaderword ) = @_;
    $suwind->{_setheaderword} = $setheaderword if defined($setheaderword); 
    if ($suwind->{_setheaderword} eq 'time') {
       $suwind->{_setheaderword} = 'dt';
    }
    else {
           $suwind->{_setheaderword}  = $setheaderword;
           #print(" print $setheaderword \n\n");
    } 
    $suwind->{_Step} = $suwind->{_Step}.' key='.$suwind->{_setheaderword};
}

=pod sub key

 set which header word to use as the x-coordinate for plotting

=cut

sub  key {
    my ($suwind, $key ) = @_;
    $suwind->{_key} = $key if defined($key); 
    if ($suwind->{_key} eq 'time') {
       $suwind->{_key} = 'dt';
    }
    else {
           $suwind->{_key}  = $key;
           #print(" print $key \n\n");
    } 
    $suwind->{_Step} = $suwind->{_Step}.' key='.$suwind->{_key};
}


sub file {
    my ($suwind, $ref_file ) = @_;
    $suwind->{_file} = ' <'.$$ref_file if defined($ref_file);
}

=head2 sub list

 input a list of trace numbers as a referenced array 

Example 1:
 $value[0]  = 2;
 suwind->list(\@value);
 suwind->setheaderword('tracf');
 $suwind[1] = suwind->Step();

=cut

sub list {
    my ($suwind, $ref_list) = @_;    
    @list            = @$ref_list if defined($ref_list);
#   perl starts lists at 0
    $length_list     = scalar(@list);
    $end             = $length_list;
    $start           = 0;

    for ($i = $start; $i<$end; $i++) {
      $suwind->{_Step} = $suwind->{_Step}.' min='.$list[$i].' max='.$list[$i].' \\'.$newline;
    }
}

sub min {
    my ($suwind, $min ) = @_;
    $suwind->{_min} = $min if defined($min);
    $suwind->{_Step} = $suwind->{_Step}.' min='.$suwind->{_min};
}

sub max {
    my ($suwind, $max ) = @_;
    $suwind->{_max} = $max if defined($max);
    $suwind->{_Step} = $suwind->{_Step}.' max='.$suwind->{_max};
}

;
sub tmin {
    my ($suwind, $tmin ) = @_;
    $suwind->{_tmin} = $tmin if defined($tmin);
    $suwind->{_Step} = $suwind->{_Step}.' tmin='.$suwind->{_tmin};
    #print("tmin $suwind->{_Step}\n\n");
}

=head2 sub tmax

    print("$suwind->{_Step}\n\n");

=cut

sub tmax {
    my ($suwind, $tmax ) = @_;
    $suwind->{_tmax} = $tmax if defined($tmax);
    $suwind->{_Step} = $suwind->{_Step}.' tmax='.$suwind->{_tmax};
}


sub Step{
    my ($suwind) 		= @_;
    $suwind->{_Step} 		= ' suwind '.$suwind->{_Step};
   #print '1 is '. $suwind->{_Step}."\n\n";
    return $suwind->{_Step};
}


=pod

=head2 subroutine note 

=cut


sub note {
    $suwind->{_note}       =  $suwind->{_note};
    return $suwind->{_note};
}

   
=head2 sub get_max_index
  max index = number of input variables -1

=cut

 sub get_max_index {
 	my ($self) = @_;
 	# only file_name : index=9
 	my $max_index = 9;
 	
 	return($max_index);
 }




1;
