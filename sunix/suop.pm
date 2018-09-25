#!/usr/bin/perl

package suop;
use Moose;


=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: suop 
 AUTHOR: Juan Lorenzo
 DATE:   Oct 14 2013,
 DESCRIPTION: 
 Version: 0.1

=head2 USE

  suop->clear();
  suop->neg();
  $suop[1] = suop->Step();

=head3 NOTES 

  This program derives from suop in Seismic Unix
  "notes" keeps track of actions for possible use in graphics
  "steps" keeps track of actions for execution in the system

=head4 

 Examples

=head3 SEISMIC UNIX NOTES  

SUOP - do unary arithmetic operation on segys 		
 								
 suop <stdin >stdout op=abs					
 								
 Required parameters:						
	none							
								
 Optional parameter:						
	op=abs		operation flag				
			abs   : absolute value			
			avg   : remove average value		
			ssqrt : signed square root		
			sqr   : square				
			ssqr  : signed square			
			sgn   : signum function			
			exp   : exponentiate			
			slog  : signed natural log		
			slog2 : signed log base 2		
			slog10: signed common log		
			cos   : cosine				
			sin   : sine				
			tan   : tangent		
			cosh  : hyperbolic cosine		
			sinh  : hyperbolic sine			
			tanh  : hyperbolic tangent		
			norm  : divide trace by Max. Value	
			db    : 20 * slog10 (data)		
			neg   : negate value			
			posonly : pass only positive values	
			negonly : pass only negative values	
                       sum   : running sum trace integration   
                       diff  : running diff trace differentiation
                       refl  : (v[i+1] - v[i])/(v[i+1] + v[i]) 
			mod2pi : modulo 2 pi			
			inv   : inverse				
			rmsamp : rms amplitude			
                       s2v   : sonic to velocity (ft/s) conversion     
                       s2vm  : sonic to velocity (m/s) conversion     
                       d2m   : density (g/cc) to metric (kg/m^3) convers
ion 
                       drv2  : 2nd order vertical derivative 
                       drv4  : 4th order vertical derivative 
                       integ : top-down integration            
                       spike : local extrema to spikes         
                       saf   : spike and fill to next spike    
                       freq  : local dominant freqeuncy        
                       lnza  : preserve least non-zero amps    
                       --------- window operations ----------- 
                       mean  : arithmetic mean                 
                       std   : standard deviation              
                       var   : variance                        
       nw=21           number of time samples in window        
                       --------------------------------------- 
			nop   : no operation			
								
 Note:	Binary ops are provided by suop2.			
 Operations inv, slog, slog2, and slog10 are "punctuated",	
 meaning that if, the input contains 0 values,			
 0 values are returned.					

 For file operations on non-SU format binary files use:  farith


=head4 CHANGES and their DATES


=cut
 


=head3 STEPS

 1. define the types of variables you are using
    these would be the values you enter into 
    each of the Seismic Unix programs    each of the Seismic Unix programs

 2. build a list or hash with all the possible variable
    names you may use and you can even change them

=cut

 my $suop = {
          _neg 	   	=> '',
          _abs	   	=> '',
          _despike	=> '',
          _note	   	=> '',
          _Step    	=> ''
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
 #my ($suop->{_Step}) = $suop->{_Step} +1;
 #print("Share step is first $suop->{_Step}\n");
}


=head2 subroutine clear

  sets all variable strings to '' 

=cut

sub clear {
    $suop->{_abs}           = '';
    $suop->{_despike}       = '';
    $suop->{_neg}           = '';
    $suop->{_Step}          = '';
}



=head2 subroutine abs 

 take the absolute value 

=cut



sub abs {
   my ($variable, $abs) = @_;
   
    $suop->{_note}     = $suop->{_note}.' op=abs ';
    $suop->{_Step}     = $suop->{_Step}.' op=abs ';

 
}


=head2 subroutine despike 

 take the spikes out  

=cut



sub despike {

    $suop->{_note}     = $suop->{_note}.' op=despike ';
    $suop->{_Step}     = $suop->{_Step}.' op=despike ';

 
}


=head2 subroutine neg 

 multiply amplitudes by -1

=cut

sub neg {
    $suop->{_note}     = $suop->{_note}.' op=neg ';
    $suop->{_Step}     = $suop->{_Step}.' op=neg ';
}


sub Step{
    $suop->{_Step}       = 'suop'.$suop->{_Step};
    return $suop->{_Step};
}

sub note {
    $suop->{_note}       =  $suop->{_note};
    return $suop->{_note};
}

=head3 Warnings for programmers
   
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
