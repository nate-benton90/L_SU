package a2b;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PACKAGE NAME: a2b 
 AUTHOR: Juan Lorenzo
 DATE:   Nov 1 2012,
         sept. 13 2013
         oct. 21 2013
         July 15 2015

 DESCRIPTION: 
 Version: 1.1
 Package used for interactive velocity analysis

=head2 USE

=head3 NOTES 

=head4 
 Examples

=head3 SEISMIC UNIX NOTES  

A2B - convert ascii floats to binary 				
 								
 a2b <stdin >stdout outpar=/dev/null 				
 								
 Required parameters:						
 	none							
 								
 Optional parameters:						
 	n1=2		floats per line in input file		
 								
 	outpar=/dev/null output parameter file, contains the	
			number of lines (n=)			
 			other choices for outpar are: /dev/tty,	
 			/dev/stderr, or a name of a disk file	


=head4 CHANGES and their DATES


=cut

=pod

=head3 STEPS

 1. define the types of variables you are using
    these would be the values you enter into 
    each of the Seismic Unix programs  each of the 
    Seismic Unix programs

 2. build a list or hash with all the possible variable
    names you may use and you can even change them

=cut

=pod

set defaults

VELAN DATA 
 m/s

 
=cut

 use Moose;

 my $a2b = {
          _floats_per_line     	=>'',
          _n1     				=>'',
          _outpar    			=>'',
          _Step    				=>'',
          _note                 =>''
        };


=head2 subroutine clear

  sets all variable strings to '' 

=cut

sub clear {
    $a2b->{_floats_per_line} 		= '';
    $a2b->{_n1} 		= '';
    $a2b->{_outpar} 			= '';
    $a2b->{_Step} 			= '';
    $a2b->{_note} 			= '';
  };

# define a value
my $newline  = '
';
 
sub test {
 my ($test,@value) = @_;
 print("\$test or the first scalar  'holds' a  HASH $test 
 that represents the name of the  
 subroutine you are trying to use and all its needed components\n");
 print("\@value, the second scalar is something 'real' you put in, i.e., @value\n\n");
 print("new line is $newline\n");
 #my ($a2b->{_Step}) = $a2b->{_Step} +1;
 #print("Share step is first $a2b->{_Step}\n");
}

=pod

=head2 subroutine  floats_per_line

  you need to know how many numbers per line
  will be in the output file 

=cut

sub floats_per_line {
    my ($variable,$floats_per_line)   = @_;
    $a2b->{_floats_per_line}     = $floats_per_line if defined($floats_per_line);
    $a2b->{_note}       = $a2b->{_note}.' n1 ='.$a2b->{_floats_per_line};
    $a2b->{_Step}       = $a2b->{_Step}.' n1='.$a2b->{_floats_per_line};
}

=pod

=head2 subroutine  n1

  you need to know how many numbers per line
  will be in the output file 

=cut

sub n1 {
    my ($variable,$n1)   = @_;
    $a2b->{_n1}     = $n1 if defined($n1);
    $a2b->{_note}       = $a2b->{_note}.' n1 ='.$a2b->{_n1};
    $a2b->{_Step}       = $a2b->{_Step}.' n1='.$a2b->{_n1};
}

=pod

=head2 subroutine  outpar

  sets  how to redirect metadata
  to either screen, a file, stderr, or 
  to be lost.

=cut

sub outpar {
    my ($variable,$outpar)   = @_;

=pod

determine whether we have a string or a reference to an array

=cut

if ($outpar) {

 if(ref($outpar) eq "SCALAR") {
  #  print("success\n\n") ;
    $a2b->{_outpar}     = $$outpar;
    $a2b->{_note}       = $a2b->{_note}.' outpar ='.$a2b->{_outpar};
    $a2b->{_Step}       = $a2b->{_Step}.' outpar='.$a2b->{_outpar};
  }

 else {
  # not a scalar reference to an array
    $a2b->{_outpar}= $outpar;
    $a2b->{_note}       = $a2b->{_note}.' outpar ='.$a2b->{_outpar};
    $a2b->{_Step}       = $a2b->{_Step}.' outpar='.$a2b->{_outpar};

 }

 #  print("outpar is  a reference to ref($a2b->{_outpar})\n\n");

 # unless (ref($a2b->{_outpar})) {
  #print("outpar should be a reference\n\n"); 
 #}
  }
}

sub note {
    my ($variable,$note) 	      = @_;
    $a2b->{_note}        =  $a2b->{_note};
    return $a2b->{_note};
}

=pod

=head2 subroutine Step 
 adds the program name

=cut


sub Step{
    $a2b->{_Step}       = 'a2b'.$a2b->{_Step};
    return $a2b->{_Step};
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
