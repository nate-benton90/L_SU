#!/usr/bin/perl
package suaddhead;

=pod

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: suaddhead 
 AUTHOR: Juan Lorenzo
 DATE: June 7 2013 
 REQUIRES:  Seismic Unix modules (CSM)
 DESCRIPTION suaddhead 
 Version .1
								
  									
 SUADDHEAD - put headers on bare traces and set the tracl and ns fields
 									
 suaddhead <stdin >stdout ns= ftn=0					
 									
 Required parameter:							
 	ns=the number of samples per trace				
 									
 Optional parameter:							
 	ftn=0		Fortran flag					
 			0 = data written unformatted from C		
 			1 = data written unformatted from Fortran	
       tsort=3         trace sorting code:				
                                1 = as recorded (no sorting)		
                                2 = CDP ensemble			
                                3 = single fold continuous profile	
                                4 = horizontally stacked		
       ntrpr=1         number of data traces per record		
                       if tsort=2, this is the number of traces per cdp
 									
 Trace header fields set: ns, tracl					
 Use suaddhead/suchw to set other needed fields.				
 									
 Caution: An incorrect ns field will munge subsequent processing.	
 Note:    n1 and nt are acceptable aliases for ns.			
 									
 Example:								
 suaddhead ns=1024 <bare_traces | suaddhead key=dt a=4000 >segy_traces	
 									
 This command line adds headers with ns=1024 samples.  The second part	
 of the pipe sets the trace header field dt to 4 ms.

 STEPS ARE:

=cut

sub new
{
    my $class = shift;
    my $suaddhead = {
        _clear,           => shift,
        _number_samples,  => shift,
        _initiate,        => shift,
        _Step,            => shift,
    };         
         bless $suaddhead, $class;
         initiate();
         return $suaddhead;

}

sub clear {
    my ($suaddhead)     = @_;
    $suaddhead->{_Step} = '';
    $suaddhead->{_note} = '';
}


sub number_samples {
    my ($suaddhead, $number_samples ) = @_;
    $suaddhead->{_number_samples} = $number_samples if defined($number_samples);    
    $suaddhead->{_Step}           = $suaddhead->{_Step}.' ns='.$suaddhead->{_number_samples};    
    #print(" $suaddhead->{_Step} \n ");
    $suaddhead->{_note}           = $suaddhead->{_note}.' ns='.$suaddhead->{_};
}

sub initiate {
    my($suaddhead)        = @_;
    $suaddhead->{_Step} = ' suaddhead ';
    #print(" $suaddhead->{_Step} \n ");
    $newline    = '
';
}



sub Step{
    my ($suaddhead)     = @_;
    $suaddhead->{_Step} = ' suaddhead '.$suaddhead->{_Step};
    return    $suaddhead->{_Step};
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
