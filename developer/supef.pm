 package supef;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUACOR - auto-correlation						
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUACOR - auto-correlation						

 suacor <stdin >stdout [optional parms]				

 Optional Parameters:							
 ntout=101	odd number of time samples output			
 norm=1	if non-zero, normalize maximum absolute output to 1	
 sym=1		if non-zero, produce a symmetric output from		
			lag -(ntout-1)/2 to lag +(ntout-1)/2		

 Credits:
	CWP: Dave Hale

 Trace header fields accessed:  ns
 Trace header fields modified:  ns and delrt

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '1.0.1';

	my $supef		= {
		_ntout					=>    '',
		_norm					=>    '',
		_sym					=>    '',
    };


=head2 sub ntout 


=cut

 sub ntout {
   my ( $self,$ntout )		= @_;
   if ( $ntout ) {
     $supef->{_ntout}		= $ntout;
     $supef->{_note}	= $supef->{_note}.'ntout'.$supef->{_ntout};
     $supef->{_Step}	= $supef->{_Step}.'ntout'.$supef->{_ntout};
   }
 }


=head2 sub norm 


=cut

 sub norm {
   my ( $self,$norm )		= @_;
   if ( $norm ) {
     $supef->{_norm}		= $norm;
     $supef->{_note}	= $supef->{_note}.'norm'.$supef->{_norm};
     $supef->{_Step}	= $supef->{_Step}.'norm'.$supef->{_norm};
   }
 }


=head2 sub sym 


=cut

 sub sym {
   my ( $self,$sym )		= @_;
   if ( $sym ) {
     $supef->{_sym}		= $sym;
     $supef->{_note}	= $supef->{_note}.'sym'.$supef->{_sym};
     $supef->{_Step}	= $supef->{_Step}.'sym'.$supef->{_sym};
   }
 }

=head2 sub get_max_index
   max index = number of input variables -1
 
=cut
 
  sub get_max_index {
 	my ($self) = @_;
	# only file_name : index=36
 	my $max_index = 36;
	
 	return($max_index);
 }
 
 
1; 