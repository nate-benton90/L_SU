package a2b;
use Moose;

=head2 sub outpar 


=cut

 sub outpar {
   my ( $self,$outpar )		= @_;
   if ( $outpar ) {
     $a2b->{_outpar}		= $outpar;
     $a2b->{_Step}		= $a2b->{_Step}.'outpar='.$a2b->{_outpar};
   }
 }


=head2 sub n1 


=cut

 sub n1 {
   my ( $self,$n1 )		= @_;
   if ( $n1 ) {
     $a2b->{_n1}		= $n1;
     $a2b->{_Step}		= $a2b->{_Step}.'n1='.$a2b->{_n1};
   }
 }


=head2 sub outpar 


=cut

 sub outpar {
   my ( $self,$outpar )		= @_;
   if ( $outpar ) {
     $a2b->{_outpar}		= $outpar;
     $a2b->{_Step}		= $a2b->{_Step}.'outpar='.$a2b->{_outpar};
   }
 }

1; 