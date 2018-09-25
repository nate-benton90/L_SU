#!/usr/bin/perl
package sushw;

=pod

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: sushw 
 AUTHOR: Juan Lorenzo
 DATE: June 7 2013 
 REQUIRES:  Seismic Unix modules (CSM)
 DESCRIPTION sushw 
 Version .1

=head3

sub headerword
Example 1: 
     $sushw->headerword('tracl')
     $sushw->first_val(1)
     $sushw->inter_gather_inc(1)
     $sushw->Step()


Usage: 
     $sushw  -> headerword("dt")


=cut 


=pod

Notes from sushw:

SUSHW - Set one or more Header Words using trace number, mod and	
	 integer divide to compute the header word values or input	
	 the header word values from a file				
 									
 ... compute header fields						
   sushw <stdin >stdout key=cdp,.. a=0,..  b=0,.. c=0,.. d=0,.. j=..,..
 									
 ... or read headers from a binary file				
   sushw <stdin > stdout  key=key1,..    infile=binary_file		
 									
 									
 Required Parameters for setting headers from infile:			
 key=key1,key2 ... is the list of header fields as they appear in infile
 infile= 	binary file of values for field specified by		
 		key1,key2,...						
 									
 Optional parameters ():						
 key=cdp,...			header key word(s) to set 		
 a=0,...			value(s) on first trace			
 b=0,...			increment(s) within group		
 c=0,...			group increment(s)	 		
 d=0,...			trace number shift(s)			
 j=ULONG_MAX,ULONG_MAX,...	number of elements in group		
 									
 Notes:								
 Fields that are getparred must have the same number of entries as key	
 words being set. Any field that is not getparred is set to the default
 value(s) above. Explicitly setting j=0 will set j to ULONG_MAX.	
 									
 The value of each header word key is computed using the formula:	
 	i = itr + d							
 	val(key) = a + b * (i % j) + c * (int(i / j))			
 where itr is the trace number (first trace has itr=0, NOT 1)		
 									
 Examples:								
 1. set every dt field to 4ms						
 	sushw <indata key=dt a=4000 |...				
 2. set the sx field of the first 32 traces to 6400, the second 32 traces
    to 6300, decrementing by -100 for each 32 trace groups		
   ...| sushw key=sx a=6400 c=-100 j=32 |...				
 3. set the offset fields of each group of 32 traces to 200,400,...,6400
   ...| sushw key=offset a=200 b=200 j=32 |...				
 4. perform operations 1., 2., and 3. in one call			
  ..| sushw key=dt,sx,offset a=4000,6400,200 b=0,0,200 c=0,-100,0 j=0,32,32 |
 									
 In this example, we set every dt field to 4ms.  Then we set the first	
 32 shotpoint fields to 6400, the second 32 shotpoint fields to 6300 and
 so forth.  Next we set each group of 32 offset fields to 200, 400, ...,
 6400.									
 									
 Example of a typical processing sequence using suchw:			
  sushw <indata key=dt a=4000 |					
  sushw key=sx a=6400 c=-100 j=32 |					
  sushw key=offset a=200 b=200 j=32 |			     		
  suchw key1=gx key2=offset key3=sx b=1 c=1 |		     		
  suchw key1=cdp key2=gx key3=sx b=1 c=1 d=2 >outdata	     		
 									
 Again, it is possible to eliminate the multiple calls to both sushw and
 sushw, as in Example 4.						
 									
 Reading header values from a binary file:				
 If the parameter infile=binary_file is set, then the values that are to
 be set for the fields specified by key=key1,key2,... are read from that
 file. The values are read sequentially from the file and assigned trace
 by trace to the input SU data. The infile consists of C (unformated)	
 binary floats in the form of an array of size (nkeys)*(ntraces) where	
 nkeys is the number of floats in the first (fast) dimension and ntraces
 is the number of traces.						
 									
 Comment: 								
 Users wishing to edit one or more header fields (as in geometry setting)
 may do this via the following sequence:				
     sugethw < sudata output=geom  key=key1,key2 ... > hdrfile 	
 Now edit the ASCII file hdrfile with any editor, setting the fields	
 appropriately. Convert hdrfile to a binary format via:		
     a2b < hdrfile n1=nfields > binary_file				
 Then set the header fields via:					
     sushw < sudata infile=binary_file key=key1,key2,... > sudata.edited
 									
 Caveat: 								
 If the (number of traces)*(number of key words) exceeds the number of	
 values in the infile then the user may still set a single header field
 on the remaining traces via the parameters key=keyword a,b,c,d,j.	
  									
 Example:								
    sushw < sudata=key1,key2 ... infile=binary_file [Optional Parameters]

 STEPS ARE:

=cut

sub new
{
    my $class = shift;
    my $sushw = {
        _clear,               => shift,
        _first_val,           => shift,
        _sample_interval_s,   => shift,
        _headerword,          => shift,
        _initiate,            => shift,
        _inter_gather_inc,    => shift,
        _verbose,             => shift,
        _output,              => shift,
        _file,                => shift,
        _Step,                => shift,
        _Steps,               => shift
    };         
         bless $sushw, $class;
         initiate();
         return $sushw;

}
#   			    c=$inter_gather_inc[1]	\\
#   			    j=$gather_size[1]		\\

sub clear {
    my ($sushw)     = @_;
    $sushw->{_Step} = '';
    $sushw->{_note} = '';
}


sub first_val {
    my ($sushw, $first_val ) = @_;
    $sushw->{_first_val}     = $first_val if defined($first_val);    
    $sushw->{_Step}      = $sushw->{_Step}.' a='.$sushw->{_first_val};    
    $sushw->{_note}     = $sushw->{_note}.' a='.$sushw->{_first_val};
    #print(" $sushw->{_Step} \n ");
}




sub headerword {
    my ($sushw, $headerword ) = @_;
    $sushw->{_headerword}     = $headerword if defined($headerword);    
    $sushw->{_Step}           = $sushw->{_Step}.' key='.$sushw->{_headerword};    
    #print(" $sushw->{_Step} \n ");
    $sushw->{_note}           = $sushw->{_note}.' key='.$sushw->{_headerword};
}

sub initiate {
    my($sushw)        = @_;
    $sushw->{_Step} = ' sushw ';
    #print(" $sushw->{_Step} \n ");
    $newline    = '
';
}

sub inter_gather_inc {
    my ($sushw, $inter_gather_inc ) = @_;
    $sushw->{_inter_gather_inc}     = $inter_gather_inc if defined($inter_gather_inc);    
    $sushw->{_Step}           = $sushw->{_Step}.' b='.$sushw->{_inter_gather_inc};    
    #print(" $sushw->{_Step} \n ");
    $sushw->{_note}           = $sushw->{_note}.' b='.$sushw->{_inter_gather_inc};
}

# in clase that you only want to change a single value
# in all the traces
sub sample_interval_s {
    my ($sushw, $sample_interval_s ) = @_;
# convert to microseconds
    $sushw->{_sample_interval_s}  = ($sample_interval_s *1000000 )if defined($sample_interval_s);    
    $sushw->{_Step}      = $sushw->{_Step}.' key=dt a='.$sushw->{_sample_interval_s};    
    $sushw->{_note}      = $sushw->{_note}.' key=dt a='.$sushw->{_sample_interval_s};
    #print(" $sushw->{_Step} \n ");
}

sub verbose {
    my ($sushw, $verbose )  = @_;
    $sushw->{_verbose}      = $verbose if defined($verbose);
    $sushw->{_Step}         = $sushw->{_Step}.' verbose='.$sushw->{_verbose};    
    $sushw->{_note}         = $sushw->{_note}.' verbose='.$sushw->{_verbose};
    return           $sushw->{_verbose};
}

sub Step{
    my ($sushw)     = @_;
    $sushw->{_Step} = ' sushw '.$sushw->{_Step};
    return    $sushw->{_Step};
}

sub Steps{
    my ($sushw ) = @_;

# for the first time
    $sushw->{_Steps} = ' sushw'.
			 ' key='.$headerword_list[0];
			 ' verbose='.$sushw->{_verbose}.
			 ' output='.$sushw->{_output};
                         ' < '.
                         $sushw->{_file}.
                         ' \\'.$newline;

# repeated occasions 
    for ($i=1; $i < $len; $i++) {
       $sushw->{_Steps} = $sushw->{_Steps}.
			   ' | '.
                           ' sushw'.
			   ' key='.@headerword_list.
			   ' verbose='.$sushw->{_verbose}.
			   ' output='.$sushw->{_output};
			   ' \\'.$newline;
    }
    $sushw->{_Steps} = $sushw->{_Steps};
    return $sushw->{_Steps};
}

1;
