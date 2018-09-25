#!/usr/bin/perl

package suchw;
use Moose;

=pod

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: suchw 
 AUTHOR: Juan Lorenzo
 DATE:   Nov 3 2013,
 DESCRIPTION: 
 Version: 0.1

=head2 USE

  suchw->clear();
  suchw->();
  $suchw[1] = suchw->Step();

=head3 NOTES 

  This program derives from suchw in Seismic Unix
  "notes" keeps track of actions for possible use in graphics
  "steps" keeps track of actions for execution in the system

=head4 

 Examples

=head3 SEISMIC UNIX NOTES  

SUCHW - Change Header Word using one or two header word fields	

  suchw <stdin >stdout [optional parameters]				
 Required parameters:							
 none									
 Optional parameters:							
 key1=cdp,...	output key(s) 						
 key2=cdp,...	input key(s) 						
 key3=cdp,...	input key(s)  						
 a=0,...	overall shift(s)				
 b=1,...	scale(s) on first input key(s) 			
 c=0,...	scale on second input key(s) 			
 d=1,...	overall scale(s)				
 e=1,...	exponent on first input key(s)
 f=1,...	exponent on second input key(s)

 The value of header word key1 is computed from the values of		
 key2 and key3 by:							
   val(key1) = (a + b * val(key2)^e + c * val(key3)^f) / d	
								
 Examples:								
 Shift cdp numbers by -1:						
	suchw <data >outdata a=-1					
 Add 1000 to tracr value:						
 	suchw key1=tracr key2=tracr a=1000 <infile >outfile		
 We set the receiver point (gx) field by summing the offset		
 and shot point (sx) fields and then we set the cdp field by		
 averaging the sx and gx fields (we choose to use the actual		
 locations for the cdp fields instead of the conventional		
 1, 2, 3, ... enumeration):						
   suchw <indata key1=gx key2=offset key3=sx b=1 c=1 |			
   suchw key1=cdp key2=gx key3=sx b=1 c=1 d=2 >outdata			
 Do both operations in one call:					
 suchw<indata key1=gx,cdp key2=offset,gx key3=sx,sx b=1,\
       1 c=1,1 d=1,2 >outdata


=head4 CHANGES and their DATES


=cut
 

=pod

=head3 STEPS

 1. define the types of variables you are using
    these would be the values you enter into 
    each of the Seismic Unix programs    

 2. build a list or hash with all the possible variable
    names you may use and you can even change them

=cut

 my $suchw = {
          _a		    	=> '',
          _b		    	=> '',
          _c		    	=> '',
          _d		    	=> '',
          _e		    	=> '',
          _f		    	=> '',
          _add_to_all    	=> '',
          _divide_all_by  	=> '',
          _first_header		=> '',
          _hdr1_exponent    	=> '',
          _hdr2_exponent    	=> '',
          _key1 		=> '',
          _key2 		=> '',
          _key3 		=> '',
          _multiply_hdr1_by    	=> '',
          _multiply_hdr2_by    	=> '',
          _note	   		=> '',
          _result_header	=> '',
 	  _second_header	=> '',
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
 #my ($suchw->{_Step}) = $suchw->{_Step} +1;
 #print("Share step is first $suchw->{_Step}\n");
}

=pod

=head2 subroutine clear

  sets all variable strings to '' 

=cut

sub clear {
    $suchw->{_a}	          	= '';
    $suchw->{_b}        	  	= '';
    $suchw->{_c}          		= '';
    $suchw->{_e}          		= '';
    $suchw->{_add_to_all}          	= '';
    $suchw->{_d}          		= '';
    $suchw->{_divide_all_by}            = '';
    $suchw->{_f}          		= '';
    $suchw->{_first_header} 	   	= '';
    $suchw->{_hdr1_exponent}  		= '';
    $suchw->{_hdr2_exponent}  		= '';
    $suchw->{_key1}	  		= '';
    $suchw->{_key2}	  		= '';
    $suchw->{_key3}	  		= '';
    $suchw->{_multiply_hdr1_by}       	= '';
    $suchw->{_multiply_hdr2_by}       	= '';
    $suchw->{_note}            		= '';
    $suchw->{_result_header}  		= '';
    $suchw->{_second_header} 	   	= '';
    $suchw->{_Step}    			= '';
}

=pod =head4 sub b

 Multiply first header values by
 this constant
 
=cut

sub b{
    my @multiply_hdr1_by        =  @_;
    $suchw->{_b} = @multiply_hdr1_by if @multiply_hdr1_by;

   # get possible array length
   my $multiply_hdr1_by_num     = scalar($suchw->{_b})-1;

   # first case
   $suchw->{_note}   = $suchw->{_note}.' b='.$multiply_hdr1_by[1];
   $suchw->{_Step}   = $suchw->{_Step}.' b='.$multiply_hdr1_by[1];

   # if there is more than a single key name word
   for (my $i=2; $i<=$multiply_hdr1_by_num; $i++) {
       $suchw->{_note}     = $suchw->{_note}.','.$multiply_hdr1_by[$i];
       $suchw->{_Step}     = $suchw->{_Step}.','.$multiply_hdr1_by[$i];
    }

}

=pod =head4 sub c

 Multiply second header values by
 this constant
 
=cut


sub c{
    my @multiply_hdr2_by        =  @_;
    $suchw->{_c} = @multiply_hdr2_by if @multiply_hdr2_by;

   # get possible array length
   my $multiply_hdr2_by_num     = scalar($suchw->{_c})-1;

   # first case
   $suchw->{_note}   = $suchw->{_note}.' c='.$multiply_hdr2_by[1];
   $suchw->{_Step}   = $suchw->{_Step}.' c='.$multiply_hdr2_by[1];

   # if there is more than a single key name word
   for (my $i=2; $i<=$multiply_hdr2_by_num; $i++) {
       $suchw->{_note}     = $suchw->{_note}.','.$multiply_hdr2_by[$i];
       $suchw->{_Step}     = $suchw->{_Step}.','.$multiply_hdr2_by[$i];
    }

}

=pod =head4 sub  e

 Raise the first header values to
 a given power
 
=cut


sub e{
    my @hdr1_exponent       =  @_;
    $suchw->{_e} = @hdr1_exponent if @hdr1_exponent;

   # get possible array length
   my $hdr1_exponent_num     = scalar($suchw->{_e})-1;

   # first case
   $suchw->{_note}   = $suchw->{_note}.' e='.$hdr1_exponent[1];
   $suchw->{_Step}   = $suchw->{_Step}.' e='.$hdr1_exponent[1];

   # if there is more than a single key name word
   for (my $i=2; $i<=$hdr1_exponent_num; $i++) {
       $suchw->{_note}     = $suchw->{_note}.','.$hdr1_exponent[$i];
       $suchw->{_Step}     = $suchw->{_Step}.','.$hdr1_exponent[$i];
   }

}


=pod =head4 sub f 

 Raise the second header values to
 a given power
 
=cut


sub f{
    my @hdr2_exponent        =  @_;
    $suchw->{_f} = @hdr2_exponent if @hdr2_exponent;

   # get possible array length
   my $hdr2_exponent_num     = scalar($suchw->{_f})-1;

   # first case
   $suchw->{_note}   = $suchw->{_note}.' f='.$hdr2_exponent[1];
   $suchw->{_Step}   = $suchw->{_Step}.' f='.$hdr2_exponent[1];

   # if there is more than a single key name word
   for (my $i=2; $i<=$hdr2_exponent_num; $i++) {
       $suchw->{_note}     = $suchw->{_note}.','.$hdr2_exponent[$i];
       $suchw->{_Step}     = $suchw->{_Step}.','.$hdr2_exponent[$i];
   }

}

=pod =head4

 sub a 
 add the following
 value after 
 all other operations
 are complete

=cut

sub a{
    my @constant           = @_;
    $suchw->{_a}  = @constant if @constant;   

    # get possible array length
    my $first_val_num     = scalar($suchw->{_a})-1;

    # first case
    $suchw->{_note}   = $suchw->{_note}.' a='.$constant[1];
    $suchw->{_Step}   = $suchw->{_Step}.' a='.$constant[1];

    # if there is more than a single key name word
    for (my $i=2; $i<=$first_val_num; $i++) {
       $suchw->{_note}     = $suchw->{_note}.','.$constant[$i];
       $suchw->{_Step}     = $suchw->{_Step}.','.$constant[$i];

    }
}

=pod

 sub add_to_all 
 add the following
 value after 
 all other operations
 are complete

=cut

sub add_to_all{
    my @constant           = @_;
    $suchw->{_add_to_all}  = @constant if @constant;   

    # get possible array length
    my $first_val_num     = scalar($suchw->{_add_to_all})-1;

    # first case
    $suchw->{_note}   = $suchw->{_note}.' a='.$constant[1];
    $suchw->{_Step}   = $suchw->{_Step}.' a='.$constant[1];

    # if there is more than a single key name word
    for (my $i=2; $i<=$first_val_num; $i++) {
       $suchw->{_note}     = $suchw->{_note}.','.$constant[$i];
       $suchw->{_Step}     = $suchw->{_Step}.','.$constant[$i];
    }
}

=pod 

=head4 sub d 

 After all calculations are complete
 divide the result by

=cut


sub  d{
    my @divide_all_by	      = @_;
    $suchw->{_d}  = @divide_all_by if @divide_all_by;   

    # get possible array length
    my $first_val_num      = scalar($suchw->{_d})-1;

  # first case
    $suchw->{_note}   = $suchw->{_note}.' d='.$divide_all_by[1];
    $suchw->{_Step}   = $suchw->{_Step}.' d='.$divide_all_by[1];

    # if there is more than a single key name word
    for (my $i=2; $i<=$first_val_num; $i++) {
       $suchw->{_note}     = $suchw->{_note}.','.$divide_all_by[$i];
       $suchw->{_Step}     = $suchw->{_Step}.','.$divide_all_by[$i];
    }
}



=pod 

=head4 sub divide_all_by 

 After all calculations are complete
 divide the result by

=cut


sub  divide_all_by{
    my @divide_all_by	      = @_;
    $suchw->{_divide_all_by}  = @divide_all_by if @divide_all_by;   

    # get possible array length
    my $first_val_num      = scalar($suchw->{_divide_all_by})-1;

  # first case
    $suchw->{_note}   = $suchw->{_note}.' d='.$divide_all_by[1];
    $suchw->{_Step}   = $suchw->{_Step}.' d='.$divide_all_by[1];

    # if there is more than a single key name word
    for (my $i=2; $i<=$first_val_num; $i++) {
       $suchw->{_note}     = $suchw->{_note}.','.$divide_all_by[$i];
       $suchw->{_Step}     = $suchw->{_Step}.','.$divide_all_by[$i];
    }
}

=pod

=head2 subroutine first_header 

 select the first header value to use 

=cut

sub first_header {
   my @names         = @_;
   $suchw->{_first_header}   = @names if @names;

   #get possible array length
   my $hdr_num       = scalar($suchw->{_first_header})-1;

   # first case
   $suchw->{_note}   = $suchw->{_note}.' key2='.$names[1];
   $suchw->{_Step}   = $suchw->{_Step}.' key2='.$names[1];

   # if there is more than a single key name word
   for (my $i=2; $i<=$hdr_num; $i++) {
       $suchw->{_note}     = $suchw->{_note}.','.$names[$i];
       $suchw->{_Step}     = $suchw->{_Step}.','.$names[$i];
   }
}

=pod =head4 sub  hdr1_exponent

 Raise the first header values to
 a given power
 
=cut

sub hdr1_exponent{
    my @hdr1_exponent       =  @_;
    $suchw->{_hdr1_exponent} = @hdr1_exponent if @hdr1_exponent;

   # get possible array length
   my $hdr1_exponent_num     = scalar($suchw->{_hdr1_exponent})-1;

   # first case
   $suchw->{_note}   = $suchw->{_note}.' e='.$hdr1_exponent[1];
   $suchw->{_Step}   = $suchw->{_Step}.' e='.$hdr1_exponent[1];

   # if there is more than a single key name word
   for (my $i=2; $i<=$hdr1_exponent_num; $i++) {
       $suchw->{_note}     = $suchw->{_note}.','.$hdr1_exponent[$i];
       $suchw->{_Step}     = $suchw->{_Step}.','.$hdr1_exponent[$i];
   }

}


=pod =head4 sub  hdr2_exponent

 Raise the second header values to
 a given power
 
=cut


sub hdr2_exponent{
    my @hdr2_exponent        =  @_;
    $suchw->{_hdr2_exponent} = @hdr2_exponent if @hdr2_exponent;

   # get possible array length
   my $hdr2_exponent_num     = scalar($suchw->{_hdr2_exponent})-1;

   # first case
   $suchw->{_note}   = $suchw->{_note}.' f='.$hdr2_exponent[1];
   $suchw->{_Step}   = $suchw->{_Step}.' f='.$hdr2_exponent[1];

   # if there is more than a single key name word
   for (my $i=2; $i<=$hdr2_exponent_num; $i++) {
       $suchw->{_note}     = $suchw->{_note}.','.$hdr2_exponent[$i];
       $suchw->{_Step}     = $suchw->{_Step}.','.$hdr2_exponent[$i];
   }

}

=pod

=head2 subroutine key1 

 select the result header value to use 

=cut

sub key1 {
   my @names         = @_;
   $suchw->{_key1}   = @names if @names;

   #get possible array length
   my $hdr_num       = scalar($suchw->{_key1})-1;

   # first case
   $suchw->{_note}   = $suchw->{_note}.' key1='.$names[1];
   $suchw->{_Step}   = $suchw->{_Step}.' key1='.$names[1];

   # if there is more than a single key name word
   for (my $i=2; $i<=$hdr_num; $i++) {
       $suchw->{_note}     = $suchw->{_note}.','.$names[$i];
       $suchw->{_Step}     = $suchw->{_Step}.','.$names[$i];
   }
}


=pod

=head2 subroutine key2 

 select the first header value to use 

=cut

sub key2 {
   my @names         = @_;
   $suchw->{_key2}   = @names if @names;

   #get possible array length
   my $hdr_num       = scalar($suchw->{_key2})-1;

   # first case
   $suchw->{_note}   = $suchw->{_note}.' key2='.$names[1];
   $suchw->{_Step}   = $suchw->{_Step}.' key2='.$names[1];

   # if there is more than a single key name word
   for (my $i=2; $i<=$hdr_num; $i++) {
       $suchw->{_note}     = $suchw->{_note}.','.$names[$i];
       $suchw->{_Step}     = $suchw->{_Step}.','.$names[$i];
   }
}

=pod

=head2 subroutine key3 

 select the second header value to use 

=cut

sub key3 {
   my @names         = @_;
   $suchw->{_key3}   = @names if @names;

   #get possible array length
   my $hdr_num       = scalar($suchw->{_key3})-1;

   # first case
   $suchw->{_note}   = $suchw->{_note}.' key3='.$names[1];
   $suchw->{_Step}   = $suchw->{_Step}.' key3='.$names[1];

   # if there is more than a single key name word
   for (my $i=2; $i<=$hdr_num; $i++) {
       $suchw->{_note}     = $suchw->{_note}.','.$names[$i];
       $suchw->{_Step}     = $suchw->{_Step}.','.$names[$i];
   }
}



=pod =head4 sub multiply_hdr1_by

 Multiply first header values by
 this constant
 
=cut


sub multiply_hdr1_by{
    my @multiply_hdr1_by        =  @_;
    $suchw->{_multiply_hdr1_by} = @multiply_hdr1_by if @multiply_hdr1_by;

   # get possible array length
   my $multiply_hdr1_by_num     = scalar($suchw->{_multiply_hdr1_by})-1;

   # first case
   $suchw->{_note}   = $suchw->{_note}.' b='.$multiply_hdr1_by[1];
   $suchw->{_Step}   = $suchw->{_Step}.' b='.$multiply_hdr1_by[1];

   # if there is more than a single key name word
   for (my $i=2; $i<=$multiply_hdr1_by_num; $i++) {
       $suchw->{_note}     = $suchw->{_note}.','.$multiply_hdr1_by[$i];
       $suchw->{_Step}     = $suchw->{_Step}.','.$multiply_hdr1_by[$i];
    }

}


=pod =head4 sub multiply_hdr2_by

 Multiply second header values by
 this constant
 
=cut


sub multiply_hdr2_by{
    my @multiply_hdr2_by        =  @_;
    $suchw->{_multiply_hdr2_by} = @multiply_hdr2_by if @multiply_hdr2_by;

   # get possible array length
   my $multiply_hdr2_by_num     = scalar($suchw->{_multiply_hdr2_by})-1;

   # first case
   $suchw->{_note}   = $suchw->{_note}.' c='.$multiply_hdr2_by[1];
   $suchw->{_Step}   = $suchw->{_Step}.' c='.$multiply_hdr2_by[1];

   # if there is more than a single key name word
   for (my $i=2; $i<=$multiply_hdr2_by_num; $i++) {
       $suchw->{_note}     = $suchw->{_note}.','.$multiply_hdr2_by[$i];
       $suchw->{_Step}     = $suchw->{_Step}.','.$multiply_hdr2_by[$i];
    }

}

sub note {
    $suchw->{_note}       =  $suchw->{_note};
    return $suchw->{_note};
}

sub result_header {
   my @names         = @_;
   $suchw->{_result_header}   = @names if @names;

   #get possible array length
   my $hdr_num       = scalar($suchw->{_result_header})-1;

   # first case
   $suchw->{_note}   = $suchw->{_note}.' key1='.$names[1];
   $suchw->{_Step}   = $suchw->{_Step}.' key1='.$names[1];

   # if there is more than a single key name word
   for (my $i=2; $i<=$hdr_num; $i++) {
       $suchw->{_note}     = $suchw->{_note}.','.$names[$i];
       $suchw->{_Step}     = $suchw->{_Step}.','.$names[$i];
   }
}

=pod

=head2 subroutine second header 

 select the second header value to use 

=cut


sub second_header {
   my @names         = @_;
   $suchw->{_second_header}   = @names if @names;

   #get possible array length
   my $hdr_num       = scalar($suchw->{_second_header})-1;

   # first case
   $suchw->{_note}   = $suchw->{_note}.' key3='.$names[1];
   $suchw->{_Step}   = $suchw->{_Step}.' key3='.$names[1];

   # if there is more than a single key name word
   for (my $i=2; $i<=$hdr_num; $i++) {
       $suchw->{_note}     = $suchw->{_note}.','.$names[$i];
       $suchw->{_Step}     = $suchw->{_Step}.','.$names[$i];
   }
}


sub Step{
    $suchw->{_Step}       = 'suchw '.$suchw->{_Step};
    return $suchw->{_Step};
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
