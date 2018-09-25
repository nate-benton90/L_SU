package suop2;


=pod

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: suop2 
 AUTHOR: Juan Lorenzo
 DATE:   Feb. 19 2015,
 DESCRIPTION: 
 Version: 0.1

=head2 USE
  $file[1] = 'fileA'
  $file[2]= 'fileB'
  suop2->clear();
  suop2->AminusB();
  suop2->fileA(\$file[1]);
  suop2->fileB(\$file[2]);
  $suop[1] = suop2->Step();

=head3 NOTES 

  This program derives from suop in Seismic Unix
  "notes" keeps track of actions for possible use in graphics
  "steps" keeps track of actions for execution in the system

=head4 

 Examples

=head3 SEISMIC UNIX NOTES  
UOP2 - do a binary operation on two data sets			
 									
 suop2 data1 data2 op=diff [trid=111] >stdout				
 									
 Required parameters:							
 	none								
 									
 Optional parameter:							
 	op=diff		difference of two panels of seismic data	
 			=sum  sum of two panels of seismic data		
 			=prod product of two panels of seismic data	
 			=quo quotient of two panels of seismic data	
 			=ptdiff differences of a panel and single trace	
 			=ptsum sum of a panel and single trace		
 			=ptprod product of a panel and single trace	
 			=ptquo quotient of a panel and single trace	
 			=zipper do "zipper" merge of two panels	
 								

 trid=FUNPACKNYQ	output trace identification code. (This option  
 			is active only for op=zipper)			
			For SU version 39-43 FUNPACNYQ=111		
 			(See: sukeyword trid     for current value)	
 									
 									
 Note1: Output = data1 "op" data2 with the header of data1		
 									
 Note2: For convenience and backward compatibility, this		
 	program may be called without an op code as:			
 									
 For:  panel "op" panel  operations: 				
 	susum  file1 file2 == suop2 file1 file2 op=sum			
 	sudiff file1 file2 == suop2 file1 file2 op=diff			
 	suprod file1 file2 == suop2 file1 file2 op=prod			
 	suquo  file1 file2 == suop2 file1 file2 op=quo			
 									
 For:  panel "op" trace  operations: 				
 	suptsum  file1 file2 == suop2 file1 file2 op=ptsum		
 	suptdiff file1 file2 == suop2 file1 file2 op=ptdiff		
 	suptprod file1 file2 == suop2 file1 file2 op=ptprod		
 	suptquo  file1 file2 == suop2 file1 file2 op=ptquo		
 									
 Note3: If an explicit op code is used it must FOLLOW the		
	filenames.						

Note4: With op=quo and op=ptquo, divide by 0 is trapped and 0 is returned.
 									
 Note5: Weighted operations can be specified by setting weighting	
	coefficients for the two datasets:				
	w1=1.0								
	w2=1.0								
 									
 Note6: With op=zipper, it is possible to set the output trace id code 
 		(See: sukeyword trid)					
  This option processes the traces from two files interleaving its samples.
  Both files must have the same trace length and must not longer than	
  SU_NFLTS/2  (as in SU 39-42  SU_NFLTS=32768).			
			  						
  Being "tr1" a trace of data1 and "tr2" the corresponding trace of
  data2, The merged trace will be :		

tr[2*i]= tr1[i]							
  tr[2*i+1] = tr2[i]							
 									
  The default value of output tr.trid is that used by sufft and suifft,
  which is the trace id reserved for the complex traces obtained through
  the application of sufft. See also, suamp.				
 									
 For operations on non-SU binary files  use:farith 	




=head4 CHANGES and their DATES


=cut

=pod

=head3 STEPS

 1. define the types of variables you are using
    these would be the values you enter into 
    each of the Seismic Unix programs    each of the Seismic Unix programs

 2. build a list or hash with all the possible variable
    names you may use and you can even change them

=cut

use Moose;

 my $suop2 = {
          _AminusB    => '',
          _AplusB     => '',
          _diffOrSum  => '',
          _fileA      => '',
          _fileB      => '',
          _note	      => '',
          _Step       => ''
        };


# define a value
my $newline  = '
';

# serves for testing  
sub test {
 my ($test,@value) = @_;
 print("\$test or the first scalar  'holds' a  HASH $test 
 that represents the name of the  
 subroutine you are trying to use and all its needed components\n");
 print("\@value, the second scalar is something 'real' you put in, i.e., @value\n\n");
 print("new line is $newline\n");
 #my ($suop2->{_Step}) = $suop2->{_Step} +1;
 #print("Share step is first $suop2->{_Step}\n");
}

=pod

=head2 subroutine clear

  sets all variable strings to '' 

=cut

sub clear {
    my ($suop2)               = @_;
    $suop2->{_AminusB}        = '';
    $suop2->{_AplusB}         = '';
    $suop2->{_diffOrSum}      = '';
    $suop2->{_fileA}          = '';
    $suop2->{_fileB}          = '';
    $suop2->{_note}           = '';
    $suop2->{_Step}           = '';
}


=pod

=head2 subroutine neg 

 multiply amplitudes by -1

=cut

sub AminusB {
    my ($suop2)         = @_;
    $suop2->{_note}     = $suop2->{_note}.' op=diff ';
    $suop2->{_Step}     = $suop2->{_Step}.' op=diff ';
    $suop2->{_diffOrSum}     = 1;
    #print("$suop2->{_diffOrSum} dif  in AminusB\n\n");
}

sub AplusB {
    my ($suop2)         = @_;
    $suop2->{_note}     = $suop2->{_note}.' op=sum ';
    $suop2->{_Step}     = $suop2->{_Step}.' op=sum ';
    $suop2->{_diffOrSum}      = 1;
    #print("$suop2->{_sum} dif  in AplusB\n\n");
}



sub fileA {
       my ($suop2, $ref_fileA ) = @_;
       $suop2->{_fileA}         = $$ref_fileA if defined($ref_fileA);
      # print("fileA is $suop2->{_fileA}\n\n");
      # print("$suop2->{_diffOrSum} dif  in fileA\n\n");
}


sub fileB {
      my ($suop2,  $ref_fileB ) = @_;
      $suop2->{_fileB}          = $$ref_fileB if defined($ref_fileB);
      #print("fileB is $suop2->{_fileB}\n\n");
      #print("$suop2->{_diffOrSum} diff  in fileB\n\n");
}

sub Step{
   my ($suop2)             = @_;

       #print("$suop2->{_diffOrSum} diff 1\n\n");
   if ($suop2->{_diffOrSum} == 1) {
       $suop2->{_note}     = $suop2->{_fileA}.' '.$suop2->{_fileB}.' '.$suop2->{_note};
       $suop2->{_Step}     = $suop2->{_fileA}.' '.$suop2->{_fileB}.' '.$suop2->{_Step};
       #print("$suop2->{_Step} in Step a\n\n");
       #print("$suop2->{_fileB} fileB\n\n");
      # print("$suop2->{_diffOrSum} diff 2\n\n");
  }
    $suop2->{_Step}       = 'suop2'.' '.$suop2->{_Step};
    $suop2->{_note}       = 'suop2'.' '.$suop2->{_note};
       #print("$suop2->{_Step} in Step b\n\n");
       return $suop2->{_Step};
}

sub note {
    $suop2->{_note}       =  $suop2->{_note};
    return $suop2->{_note};
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
