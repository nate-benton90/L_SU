#!/usr/bin/perl

package sushw;
use Moose;

=pod

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: sushw 
 AUTHOR: Juan Lorenzo
 DATE:   Oct 27 2013,
 DESCRIPTION: 
 Version: 0.1

=head2 USE

  sushw->clear();
  sushw->neg();
  $sushw[1] = sushw->Step();

=head3 NOTES 

  This program derives from sushw in Seismic Unix
  "notes" keeps track of actions for possible use in graphics
  "steps" keeps track of actions for execution in the system

=head4 

 Examples

=head3 SEISMIC UNIX NOTES  
SUSHW - Set one or more Header Words using trace number, mod and	
	 integer divide to compute the name word values or input	
	 the name word values from a file				
 									
 ... compute name fields						
   sushw <stdin >stdout key=cdp,.. a=0,..  b=0,.. c=0,.. d=0,.. j=..,..
 									
 ... or read names from a binary file				
   sushw <stdin > stdout  key=key1,..    infile=binary_file		
 									
 									
 Required Parameters for setting names from infile:			
 key=key1,key2 ... is the list of name fields as they appear in infile
 infile= 	binary file of values for field specified by		
 		key1,key2,...						
 									
 Optional parameters ():						
 key=cdp,...			name key word(s) to set 		
 a=0,...			value(s) on first trace			
 b=0,...			increment(s) within group		
 c=0,...			group increment(s)	 		
 d=0,...			trace number shift(s)	
j=ULONG_MAX,ULONG_MAX,...	number of elements in group		
 									
 Notes:								
 Fields that are getparred must have the same number of entries as key	
 words being set. Any field that is not getparred is set to the default
 value(s) above. Explicitly setting j=0 will set j to ULONG_MAX.	
 									
 The value of each name word key is computed using the formula:	
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
 									
 Reading name values from a binary file:				
 If the parameter infile=binary_file is set, then the values that are to
 be set for the fields specified by key=key1,key2,... are read from that
 file. The values are read sequentially from the file and assigned trace
 by trace to the input SU data. The infile consists of C (unformated)
binary floats in the form of an array of size (nkeys)*(ntraces) where	
 nkeys is the number of floats in the first (fast) dimension and ntraces
 is the number of traces.						
 									
 Comment: 								
 Users wishing to edit one or more name fields (as in geometry setting)
 may do this via the following sequence:				
     sugethw < sudata output=geom  key=key1,key2 ... > hdrfile 	
 Now edit the ASCII file hdrfile with any editor, setting the fields	
 appropriately. Convert hdrfile to a binary format via:		
     a2b < hdrfile n1=nfields > binary_file				
 Then set the name fields via:					
     sushw < sudata infile=binary_file key=key1,key2,... > sudata.edited
									
 Caveat: 								
 If the (number of traces)*(number of key words) exceeds the number of	
 values in the infile then the user may still set a single name field
 on the remaining traces via the parameters key=keyword a,b,c,d,j.	
  									
 Example:								
    sushw < sudata=key1,key2 ... infile=binary_file [Optional Parameters]


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

 my $sushw = {
          _a 		      	=> '',
          _b 		      	=> '',
          _first_val       	=> '',
          _first_value       	=> '',
          _gather_size       	=> '',
          _header_bias  	=> '',
          _inter_gather_inc  	=> '',
          _intra_gather_inc  	=> '',
          _key         		=> '',
          _headerwords		=> '',
          _name    		=> '',
          _infile    		=> '',
          _note	   		=> '',
          _sample_interval_s  	=> '',
          _Step    		=> ''
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
 #my ($sushw->{_Step}) = $sushw->{_Step} +1;
 #print("Share step is first $sushw->{_Step}\n");
}

=pod

=head2 subroutine clear

  sets all variable strings to '' 

=cut

sub clear {
    $sushw->{_a}          		= '';
    $sushw->{_b}          		= '';
    $sushw->{_key}          		= '';
    $sushw->{_headerwords}          	= '';
    $sushw->{_name}          		= '';
    $sushw->{_infile}          		= '';
    $sushw->{_note}            		= '';
    $sushw->{_Step}            		= '';
    $sushw->{_header_bias}  		= '';
    $sushw->{_inter_gather_inc}  	= '';
    $sushw->{_intra_gather_inc}  	= '';
    $sushw->{_first_val}       		= '';
    $sushw->{_first_value}     		= '';
    $sushw->{_gather_size}       	= '';
    $sushw->{_sample_interval_s}  	= '';
    $sushw->{_Step}    			= '';
}


=pod

=head2 subroutine name 

 select the names to change 

=cut

sub name {
   my (@names)         = @_;
   $sushw->{_names}   = @names if @names;

   #get possible array length
   my $hdr_num       = scalar($sushw->{_names})-1;

   # first case
   $sushw->{_note}   = $sushw->{_note}.' key='.$names[1];
   $sushw->{_Step}   = $sushw->{_Step}.' key='.$names[1];

   # if there is more than a single key name word
   for (my $i=2; $i<=$hdr_num; $i++) {
       $sushw->{_note}     = $sushw->{_note}.','.$names[$i];
       $sushw->{_Step}     = $sushw->{_Step}.','.$names[$i];
   }
}

=pod

=head2 subroutine infile 

 select the names to change 

=cut

sub infile {
   my ($variable,$ref_file_name)             = @_;
   $sushw->{_file_name}            = $$ref_file_name if ($ref_file_name);
       #print("infile is $sushw->{_file_name}\n\n");
       $sushw->{_Step}     = $sushw->{_Step}.' infile='.$sushw->{_file_name};
       $sushw->{_note}     = $sushw->{_note}.' infile = '.$sushw->{_file_name};
}

=head2 subroutine key 

 select the names to change 

=cut

sub key {
   my (@name)         = @_;
   $sushw->{_name}     = @name if @name;

   #get possible array length
   my $hdr_num       = scalar($sushw->{_name})-1;

   # first case
   $sushw->{_note}   = $sushw->{_note}.' key='.$name[1];
   $sushw->{_Step}   = $sushw->{_Step}.' key='.$name[1];

   # if there is more than a single key name word
   for (my $i=2; $i<=$hdr_num; $i++) {
       $sushw->{_note}     = $sushw->{_note}.','.$name[$i];
       $sushw->{_Step}     = $sushw->{_Step}.','.$name[$i];
   }
}

=head2 subroutine headerwords 

 select the names to change 

=cut

sub headerwords {
   my (@names)      	= @_;
   $sushw->{_name}      = @names if (@names);

   #get possible array length
   my $hdr_nums          = scalar($sushw->{_name})-1;

   # first case
   $sushw->{_note}      = $sushw->{_note}.' headerwords='.$names[1];
   $sushw->{_Step}      = $sushw->{_Step}.' key='.$names[1];

   # if there is more than a single headerword
   for (my $j=2; $j<=$hdr_nums; $j++) {
       $sushw->{_note}     = $sushw->{_note}.','.$names[$j];
       $sushw->{_Step}     = $sushw->{_Step}.','.$names[$j];
   }
}

=head4

 sub first_val
 handles first value of the trace

=cut

sub first_val{
    my (@first_val)         = @_;
    $sushw->{_first_val}  = @first_val if @first_val;   

    # get possible array length
    my $first_val_num     = scalar($sushw->{_first_val})-1;

    # first case
    $sushw->{_note}   = $sushw->{_note}.' a='.$first_val[1];
    $sushw->{_Step}   = $sushw->{_Step}.' a='.$first_val[1];

    # if there is more than a single key name word
    for (my $i=2; $i<=$first_val_num; $i++) {
       $sushw->{_note}     = $sushw->{_note}.','.$first_val[$i];
       $sushw->{_Step}     = $sushw->{_Step}.','.$first_val[$i];
  }
}

=head4

 sub first_value
 handles first value of the trace

=cut

sub first_value{
    my (@first_value)         = @_;
    $sushw->{_first_value}  = @first_value if @first_value;   

    # get possible array length
    my $first_value_num     = scalar($sushw->{_first_value})-1;

    # first case
    $sushw->{_note}   = $sushw->{_note}.' a='.$first_value[1];
    $sushw->{_Step}   = $sushw->{_Step}.' a='.$first_value[1];

    # if there is more than a single key name word
    for (my $i=2; $i<=$first_value_num; $i++) {
       $sushw->{_note}     = $sushw->{_note}.','.$first_value[$i];
       $sushw->{_Step}     = $sushw->{_Step}.','.$first_value[$i];
    }
}

=head4

 sub a 
 handles first value of the trace

=cut

sub a{
    my (@first_val)         = @_;
    $sushw->{_a}  = @first_val if @first_val;   

    # get possible array length
    my $first_val_num     = scalar($sushw->{_a})-1;

    # first case
    $sushw->{_note}   = $sushw->{_note}.' a='.$first_val[1];
    $sushw->{_Step}   = $sushw->{_Step}.' a='.$first_val[1];

    # if there is more than a single key name word
    for (my $i=2; $i<=$first_val_num; $i++) {
       $sushw->{_note}     = $sushw->{_note}.','.$first_val[$i];
       $sushw->{_Step}     = $sushw->{_Step}.','.$first_val[$i];
    }
}



=head4 sub sample_interval_s

 In clase that you only want to 
 change a single value
 in all the traces


=cut


sub sample_interval_s {
    my ($test,$sample_interval_s) 	 = @_;
    #print("num sample interval in s is $sample_interval_s\n\n");
    #print("test is $test\n\n");
    # convert to microseconds
    $sushw->{_sample_interval_s} = ($sample_interval_s *1000000 )if defined($sample_interval_s);    
    #print("num sample interval in us is $sushw->{_sample_interval_s}\n\n");
    $sushw->{_Step}              = $sushw->{_Step}.' key=dt a='.$sushw->{_sample_interval_s};  
    $sushw->{_note}              = $sushw->{_note}.' key=dt a='.$sushw->{_sample_interval_s};
}

=head4 sub intra_gather_inc 

 Increment between traces within a single
 gather

=cut


sub intra_gather_inc{
    my (@intra_gather_inc)        =  @_;
    $sushw->{_intra_gather_inc} = @intra_gather_inc if @intra_gather_inc;

   # get possible array length
   my $intra_gather_inc_num     = scalar($sushw->{_intra_gather_inc})-1;

   # first case
   $sushw->{_note}   = $sushw->{_note}.' b='.$intra_gather_inc[1];
   $sushw->{_Step}   = $sushw->{_Step}.' b='.$intra_gather_inc[1];

   # if there is more than a single key name word
   for (my $i=2; $i<=$intra_gather_inc_num; $i++) {
       $sushw->{_note}     = $sushw->{_note}.','.$intra_gather_inc[$i];
       $sushw->{_Step}     = $sushw->{_Step}.','.$intra_gather_inc[$i];
   }

}

=head4 sub b 

 Increment assigned to all traces within a single
 gather; this increment is assigned when moving on to
 a subsequent gather.

=cut

sub b{
    my (@intra_gather_inc)        =  @_;
    $sushw->{_b} = @intra_gather_inc if @intra_gather_inc;

   # get possible array length
   my $intra_gather_inc_num     = scalar($sushw->{_b})-1;

   # first case
   $sushw->{_note}   = $sushw->{_note}.' b='.$intra_gather_inc[1];
   $sushw->{_Step}   = $sushw->{_Step}.' b='.$intra_gather_inc[1];

   # if there is more than a single key name word
   for (my $i=2; $i<=$intra_gather_inc_num; $i++) {
       $sushw->{_note}     = $sushw->{_note}.','.$intra_gather_inc[$i];
       $sushw->{_Step}     = $sushw->{_Step}.','.$intra_gather_inc[$i];
   }

}

=head4 sub c 

 Increment assigned to all traces within a single
 gather; this increment is assigned when moving on to
 a subsequent gather.

=cut

sub c{
    my (@inter_gather_inc)        =  @_;
    $sushw->{_c} = @inter_gather_inc if @inter_gather_inc;

   # get possible array length
   my $inter_gather_inc_num     = scalar($sushw->{_c})-1;

   # first case
   $sushw->{_note}   = $sushw->{_note}.' c='.$inter_gather_inc[1];
   $sushw->{_Step}   = $sushw->{_Step}.' c='.$inter_gather_inc[1];

   # if there is more than a single key name word
   for (my $i=2; $i<=$inter_gather_inc_num; $i++) {
       $sushw->{_note}     = $sushw->{_note}.','.$inter_gather_inc[$i];
       $sushw->{_Step}     = $sushw->{_Step}.','.$inter_gather_inc[$i];
    }

}

=head4 sub inter_gather_inc 

 Increment assigned to all traces within a single
 gather; this increment is assigned when moving on to
 a subsequent gather.

=cut


sub inter_gather_inc{
    my (@inter_gather_inc)        =  @_;
    $sushw->{_inter_gather_inc} = @inter_gather_inc if @inter_gather_inc;

   # get possible array length
   my $inter_gather_inc_num     = scalar($sushw->{_inter_gather_inc})-1;

   # first case
   $sushw->{_note}   = $sushw->{_note}.' c='.$inter_gather_inc[1];
   $sushw->{_Step}   = $sushw->{_Step}.' c='.$inter_gather_inc[1];

   # if there is more than a single key name word
   for (my $i=2; $i<=$inter_gather_inc_num; $i++) {
       $sushw->{_note}     = $sushw->{_note}.','.$inter_gather_inc[$i];
       $sushw->{_Step}     = $sushw->{_Step}.','.$inter_gather_inc[$i];
    }

}

=head4 sub j

 how many traces are in  gather
 or group of traces of interest 

=cut

sub j{
    my (@gather_size)         = @_;
    $sushw->{_j}  	    = @gather_size if @gather_size;

    # get possible array length
    my $gather_size_num     = scalar($sushw->{_j})-1;

   # first case
   $sushw->{_note}   = $sushw->{_note}.' j='.$gather_size[1];
   $sushw->{_Step}   = $sushw->{_Step}.' j='.$gather_size[1];

   # if there is more than a single key name word
   for (my $i=2; $i<=$gather_size_num; $i++) {
       $sushw->{_note}     = $sushw->{_note}.','.$gather_size[$i];
       $sushw->{_Step}     = $sushw->{_Step}.','.$gather_size[$i];
   }
}

=head4 sub gather_size 

 how many traces are in  gather
 or group of traces of interest 

=cut


sub gather_size{
    my @gather_size         = @_;
    $sushw->{_gather_size}  = @gather_size if @gather_size;

    # get possible array length
    my $gather_size_num     = scalar($sushw->{_gather_size})-1;

   # first case
   $sushw->{_note}   = $sushw->{_note}.' j='.$gather_size[1];
   $sushw->{_Step}   = $sushw->{_Step}.' j='.$gather_size[1];

   # if there is more than a single key name word
   for (my $i=2; $i<=$gather_size_num; $i++) {
       $sushw->{_note}     = $sushw->{_note}.','.$gather_size[$i];
       $sushw->{_Step}     = $sushw->{_Step}.','.$gather_size[$i];
   }
}


=head4 sub header_bias 

 value to add to words 

=cut


sub header_bias{
    my @header_bias          = @_;
    $sushw->{_header_bias}   = @header_bias if @header_bias;

    # get possible array length
    my $header_bias_num          = scalar($sushw->{_header_bias})-1;

   # first case
   $sushw->{_note}   = $sushw->{_note}.' d='.$header_bias[1];
   $sushw->{_Step}   = $sushw->{_Step}.' d='.$header_bias[1];
   # if there is more than a single key name word
   for (my $i=2; $i<=$header_bias_num; $i++) {
       $sushw->{_note}     = $sushw->{_note}.','.$header_bias[$i];
       $sushw->{_Step}     = $sushw->{_Step}.','.$header_bias[$i];
   }
}


sub Step{
    $sushw->{_Step}       = 'sushw '.$sushw->{_Step};
    return $sushw->{_Step};
}

sub note {
    $sushw->{_note}       =  $sushw->{_note};
    return $sushw->{_note};
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
