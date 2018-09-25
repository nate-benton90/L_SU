#!/usr/bin/perl

package suvelan;
use Moose;

=pod

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: suvelan 
 AUTHOR: Chang Liu
 DATE:   Dec 1 2013,
 DESCRIPTION: 
 Version: 1.1

=head2 USE

=head3 NOTES 

=head4 
 Examples

=head3 SEISMIC UNIX NOTES  

SUVELAN - compute stacking velocity semblance for cdp gathers		     
									     
 suvelan <stdin >stdout [optional parameters]				     
									     
 Optional Parameters:							     
 nv=50                   number of velocities				     
 dv=50.0                 velocity sampling interval			     
 fv=1500.0               first velocity				     
 anis1=0.0               quartic term, numerator of an extended quartic term
 anis2=0.0               in denominator of an extended quartic term         
 smute=1.5               samples with NMO stretch exceeding smute are zeroed
 dtratio=5               ratio of output to input time sampling intervals   
 nsmooth=dtratio*2+1     length of semblance num and den smoothing window   
 verbose=0               =1 for diagnostic print on stderr		     
 pwr=1.0                 semblance value to the power      		     
									     
 Notes:								     
 Velocity analysis is usually a two-dimensional screen for optimal values of
 the vertical two-way traveltime and stacking velocity. But if the travel-  
 time curve is no longer close to a hyperbola, the quartic term of the      
 traveltime series should be considered. In its easiest form (with anis2=0) 
 the optimizion of all parameters requires a three-dimensional screen. This 
 is done by a repetition of the conventional two-dimensional screen with a  
 variation of the quartic term. The extended quartic term is more accurate, 
 though the function is no more a polynomial. When screening for optimal    
 values the theoretical dependencies between these paramters can be taken   
 into account. The traveltime function is defined by                        
                                                                            
                1            anis1                                          
 t^2 = t_0^2 + --- x^2 + ------------- x^4                                  
               v^2       1 + anis2 x^2                                      
                                                                            
 The coefficients anis1, anis2 are assumed to be small, that means the non- 
 hyperbolicity is assumed to be small. Triplications cannot be handled.  
Semblance is defined by the following quotient:			     
									     
                 n-1                 					     
               [ sum q(t,j) ]^2      					     
                 j=0                 					     
       s(t) = ------------------     					     
                 n-1                 					     
               n sum [q(t,j)]^2      					     
                 j=0                 					     
									     
 where n is the number of non-zero samples after muting.		     
 Smoothing (nsmooth) is applied separately to the numerator and denominator 
 before computing this semblance quotient.				     
									     
 Then, the semblance is set to the power of the parameter pwr. With pwr > 1 
 the difference between semblance values is stretched in the upper half of  
 the range of semblance values [0,1], but compressed in the lower half of   
 it; thus, the few large semblance values are enhanced. With pwr < 1 the    
 many small values are enhanced, thus more discernible against background   
 noise. Of course, always at the expanse of the respective other feature.   
									     
 Input traces should be sorted by cdp - suvelan outputs a group of	     
 semblance traces every time cdp changes.  Therefore, the output will	     
 be useful only if cdp gathers are input.	



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

 my $suvelan = {
          _Step     => '',
          _anis1    => '',
          _anis2    => '',
          _dtratio  => '',
    	  _dv       => '',
          _first_velocity   => '',
          _fv  	    => '',
          _number_of_velocities => '',
          _note     => '',
          _nsmooth  => '',
          _nv       => '',    
	  _pwr	    => '',
          _smute    => '',
          _velocity_increment    => '',
          _verbose  => ''
        };

# define a value
my $newline  = '';
  
#sub test {
# my ($test,@value) = @_;
# print("\$test or the first scalar  'holds' a  HASH $test 
# that represents the name of the  
# subroutine you are trying to use and all its needed components\n");
# print("\@value, the second scalar is something 'real' you put in, i.e., @value\n\n");
# print("new line is $newline\n");
#my ($suvelan->{_Step}) = $suvelan->{_Step} +1;
#print("Share step is first $suvelan->{_Step}\n");
#}

=pod

=head2 subroutine clear

  sets all variable strings to '' 

=cut

sub clear {
    $suvelan->{_anis1} 		= '';
    $suvelan->{_anis2} 		= '';
    $suvelan->{_dtratio} 	= '';
    $suvelan->{_dv} 		= '';
    $suvelan->{_file} 		= '';
    $suvelan->{_fv} 		= '';
    $suvelan->{_first_velocity} 	= '';
    $suvelan->{_note}       	= '';
    $suvelan->{_nsmooth}	= '';
    $suvelan->{_number_of_velocities} 	= '';
    $suvelan->{_nv} 		= '';
    $suvelan->{_pwr}		= '';
    $suvelan->{_smute} 		= '';
    $suvelan->{_velocity_increment} 	= '';
    $suvelan->{_verbose}	= '';
    $suvelan->{_Step}           = '';
}

=pod

=head2 subroutine setdt 

  sets value of sampling interval 

=cut

=pod =head3

 subroutine nv:
   sets the number of velocities 

=cut 

sub nv {
    my ($variable,$dt)   = @_;
    $suvelan->{_dt}       = $dt if defined($dt);
    $suvelan->{_note}     = $suvelan->{_note}.' dt='.$suvelan->{_dt};
    $suvelan->{_Step}     = $suvelan->{_Step}.' dt='.$suvelan->{_dt};
}


=pod =head3

 subroutine number_of_velocities 

=cut

sub  number_of_velocities{
   my ($variable,$number_of_velocities) 	= @_;
   $suvelan->{_number_of_velocities} 		= $number_of_velocities if defined($number_of_velocities); 
   $suvelan->{_note}     = $suvelan->{_note}.' nv='.$suvelan->{_number_of_velocities};
   $suvelan->{_Step}     = $suvelan->{_Step}.' nv='.$suvelan->{_number_of_velocities};
}

=pod =head3

 subroutine dv 
    defines the velocity steps to use in the semblance analysis

=cut

sub dv {
    my ($variable,$dv)   = @_;
    $suvelan->{_dv}         = $dv if defined($dv);
    $suvelan->{_note}       = $suvelan->{_note}.' dv='.$suvelan->{_dv};
    $suvelan->{_Step}       = $suvelan->{_Step}.' dv='.$suvelan->{_dv};
}

=pod =head3

 subroutine velocity_increment
    defines the velocity steps to use in the semblance analysis

=cut

sub velocity_increment {
    my ($variable,$velocity_increment)   = @_;
    $suvelan->{_velocity_increment}         = $velocity_increment if defined($velocity_increment);
    $suvelan->{_note}       = $suvelan->{_note}.' dv='.$suvelan->{_velocity_increment};
    $suvelan->{_Step}       = $suvelan->{_Step}.' dv='.$suvelan->{_velocity_increment};
}


=pod =head3

 subroutine fv 
    defines the first velocity value to use in the semblance analysis

=cut

sub fv {
    my ($variable,$fv)   = @_;
    $suvelan->{_fv}       = $fv if defined($fv);
    $suvelan->{_note}       = $suvelan->{_note}.' fv='.$suvelan->{_fv};
    $suvelan->{_Step}       = $suvelan->{_Step}.' fv='.$suvelan->{_fv};
}

=pod =head3

 subroutine first_velocity 
    defines the first velocity value to use in the semblance analysis

=cut

sub first_velocity {
    my ($variable,$first_velocity)   = @_;
    $suvelan->{_first_velocity}       = $first_velocity if defined($first_velocity);
    $suvelan->{_note}       = $suvelan->{_note}.' fv='.$suvelan->{_first_velocity};
    $suvelan->{_Step}       = $suvelan->{_Step}.' fv='.$suvelan->{_first_velocity};
}


sub anis1 {
    my ($variable,$anis1)   = @_;
    $suvelan->{_anis1} 	   = $anis1 if defined($anis1);		
    $suvelan->{_note}  	   = $suvelan->{_note}.' anis1='.$suvelan->{_anis1};
    $suvelan->{_Step}  	   = $suvelan->{_Step}.' anis1='.$suvelan->{_anis1};
}

sub anis2 {
    my ($sub,$anis2)         = @_;
    $suvelan->{_anis2}        = $anis2 if defined($anis2);
    $suvelan->{_note}       = $suvelan->{_note}.' anis2='.$suvelan->{_anis2};
    $suvelan->{_Step}       = $suvelan->{_Step}.' anis2='.$suvelan->{_anis2};
}

sub smute {
    my ($sub,$smute)	   = @_;
    print("smute is $smute\n\n");
    $suvelan->{_smute} 	   = $smute if defined($smute);		
    $suvelan->{_note}  	   = $suvelan->{_note}.' smute='.$suvelan->{_smute};
    $suvelan->{_Step}  	   = $suvelan->{_Step}.' smute='.$suvelan->{_smute};
}

sub Step{
    $suvelan->{_Step}       = 'suvelan'.$suvelan->{_Step};
    return $suvelan->{_Step};
}

sub note {
    $suvelan->{_note}       =  $suvelan->{_note};
    return $suvelan->{_note};
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
