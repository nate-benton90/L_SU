#!/usr/bin/perl

package sustack;
use Moose;


=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: sustack 
 AUTHOR: Juan Lorenzo
 DATE:  July 31, 2013
 DESCRIPTION  horizontal summation across
              a file based on a header word
 Version 1

 STEPS ARE:

=head3 USE

Usage 1:
To stack an array of trace 

Example:
       $sustack ->clear();
       $sustack->headerword('cdp');
       $sustack[1] = $sustack->Step();


=cut


=head2 NOTES

								
 SUSTACK - stack adjacent traces having the same key header word
 								
     sustack <stdin >stdout [Optional parameters]		
 							        
 Required parameters:						
 	none							
 							        
 Optional parameters: 						
 	key=cdp		header key word to stack on		
 	normpow=1.0	each sample is divided by the		
			normpow'th number of non-zero values	
			stacked (normpow=0 selects no division)	
	repeat=0	=1 repeats the stack trace nrepeat times
	nrepeat=10	repeats stack trace nrepeat times in	
	          	output file				
 	verbose=0	verbose = 1 echos information		
 							        
 Notes:							
 ------							
 The offset field is set to zero on the output traces, unless	
 the user is stacking with key=offset. In that case, the value 
 of the offset field is left unchanged. 		        
 							        
 Sushw can be used afterwards if this is not acceptable.	
								
 For VSP users:						
 The stack trace appears ten times in the output file when	
 setting repeat=1 and nrepeat=10. Corridor stacking can be	
 achieved by properly muting the upgoing data with SUMUTE	
 before stacking.			


=cut

    my $sustack = {
        _clear          => '',
        _headerword     => '',
        _key     	=> '',
        _initiate       => '',
        _normpower      => '',
        _nrepeat        => '',
        _note           => '',
        _repeat         => '',
        _Step           => '',
        _verbose        => ''
    };

sub clear {
    $sustack->{_headerword} 		= '';
    $sustack->{_key} 			= '';
    $sustack->{_normpower} 		= '';
    $sustack->{_nrepeat} 		= '';
    $sustack->{_note} 			= '';
    $sustack->{_repeat} 		= '';
    $sustack->{_Step} 			= '';
    $sustack->{_verbose} 		= '';
}


sub headerword {   
    my ($value,$headerword) = @_;
    $sustack->{_headerword} = $headerword if defined($headerword);
    $sustack->{_Step} = $sustack->{_Step}.' key='.$sustack->{_headerword};
    $sustack->{_note} = $sustack->{_note}.' key='.$sustack->{_headerword};
     #print("sustack headerword is $sustack->{_headerword}\n\n");
     #print("sustack  Step is $sustack->{_Step}\n\n");
     #print("sustack  note is $sustack->{_note}\n\n");
}
 
sub key {   
    my ($value,$key) = @_;
     #print("sustack key is $key\n\n");
     #print("sustack is $sustack\n\n");
    if ($key){
        $sustack->{_key}  = $key;
    	$sustack->{_Step} = $sustack->{_Step}.' key='.$sustack->{_key};
    	$sustack->{_note} = $sustack->{_note}.' key='.$sustack->{_key};
     #print("sustack key is $sustack->{_key}\n\n");
     #print("sustack  Step is $sustack->{_Step}\n\n");
     #print("sustack  note is $sustack->{_note}\n\n");
    }
}

sub normpower {
    my ($value,$normpower ) = @_;
    $sustack->{_normpower}     = $normpower if defined($normpower);
    $sustack->{_Step}    = $sustack->{_Step}.' normpower='.$sustack->{_normpower};
    $sustack->{_note}    = $sustack->{_note}.' normpower='.$sustack->{_normpower};
}

sub nrepeat {
    my ($value, $nrepeat ) = @_;
    $sustack->{_nrepeat} = $nrepeat if defined($nrepeat);
    $sustack->{_Step}    = $sustack->{_Step}.' nrepeat='.$sustack->{_nrepeat};
    $sustack->{_note}    = $sustack->{_note}.' nrepeat='.$sustack->{_nrepeat};
}

sub repeat {
    my ($value, $repeat ) = @_;
    $sustack->{_repeat} = $repeat if defined($repeat);
    $sustack->{_Step}    = $sustack->{_Step}.' repeat='.$sustack->{_repeat};
    $sustack->{_note}    = $sustack->{_note}.' repeat='.$sustack->{_repeat};
}
sub note{
    $sustack->{_note} = ' sustack'.
                          $sustack->{_note};
    return $sustack->{_note};
}

sub Step{
    $sustack->{_Step} = ' sustack'.
                        $sustack->{_Step};
    return $sustack->{_Step};
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
