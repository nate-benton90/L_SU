 package suxgraph;
 use Moose;
 our $VERSION = '1.0.1';


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUPEF - Wiener predictive error filtering				

 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES

=cut

	my $suxgraph		= {
		_cdp					=>    '',
		_minlag					=>    '',
		_maxlag					=>    '',
		_pnoise					=>    '',
		_mincorr					=>    '',
		_maxcorr					=>    '',
		_showwiener					=>    '',
		_mix					=>    '',
		_outpar					=>    '',
		_showwiener					=>    '',
		_method					=>    '',
		_perc					=>    '',
		_maxlag					=>    '',
		_ntout					=>    '',
		_MAXLAG_PEF					=>    '',
		_minlag					=>    '',
		_cdp					=>    '',
		_minlag					=>    '',
		_showweiner					=>    '',
    };


=head2 sub cdp 


=cut

 sub cdp {
   my ( $self,$cdp )		= @_;
   if ( $cdp ) {
     $suxgraph->{_cdp}		= $cdp;
     $suxgraph->{_note}	= $suxgraph->{_note}.'cdp'.$suxgraph->{_cdp};
     $suxgraph->{_Step}	= $suxgraph->{_Step}.'cdp'.$suxgraph->{_cdp};
   }
 }


=head2 sub minlag 


=cut

 sub minlag {
   my ( $self,$minlag )		= @_;
   if ( $minlag ) {
     $suxgraph->{_minlag}		= $minlag;
     $suxgraph->{_note}	= $suxgraph->{_note}.'minlag'.$suxgraph->{_minlag};
     $suxgraph->{_Step}	= $suxgraph->{_Step}.'minlag'.$suxgraph->{_minlag};
   }
 }


=head2 sub maxlag 


=cut

 sub maxlag {
   my ( $self,$maxlag )		= @_;
   if ( $maxlag ) {
     $suxgraph->{_maxlag}		= $maxlag;
     $suxgraph->{_note}	= $suxgraph->{_note}.'maxlag'.$suxgraph->{_maxlag};
     $suxgraph->{_Step}	= $suxgraph->{_Step}.'maxlag'.$suxgraph->{_maxlag};
   }
 }


=head2 sub pnoise 


=cut

 sub pnoise {
   my ( $self,$pnoise )		= @_;
   if ( $pnoise ) {
     $suxgraph->{_pnoise}		= $pnoise;
     $suxgraph->{_note}	= $suxgraph->{_note}.'pnoise'.$suxgraph->{_pnoise};
     $suxgraph->{_Step}	= $suxgraph->{_Step}.'pnoise'.$suxgraph->{_pnoise};
   }
 }


=head2 sub mincorr 


=cut

 sub mincorr {
   my ( $self,$mincorr )		= @_;
   if ( $mincorr ) {
     $suxgraph->{_mincorr}		= $mincorr;
     $suxgraph->{_note}	= $suxgraph->{_note}.'mincorr'.$suxgraph->{_mincorr};
     $suxgraph->{_Step}	= $suxgraph->{_Step}.'mincorr'.$suxgraph->{_mincorr};
   }
 }


=head2 sub maxcorr 


=cut

 sub maxcorr {
   my ( $self,$maxcorr )		= @_;
   if ( $maxcorr ) {
     $suxgraph->{_maxcorr}		= $maxcorr;
     $suxgraph->{_note}	= $suxgraph->{_note}.'maxcorr'.$suxgraph->{_maxcorr};
     $suxgraph->{_Step}	= $suxgraph->{_Step}.'maxcorr'.$suxgraph->{_maxcorr};
   }
 }


=head2 sub showwiener 


=cut

 sub showwiener {
   my ( $self,$showwiener )		= @_;
   if ( $showwiener ) {
     $suxgraph->{_showwiener}		= $showwiener;
     $suxgraph->{_note}	= $suxgraph->{_note}.'showwiener'.$suxgraph->{_showwiener};
     $suxgraph->{_Step}	= $suxgraph->{_Step}.'showwiener'.$suxgraph->{_showwiener};
   }
 }


=head2 sub mix 


=cut

 sub mix {
   my ( $self,$mix )		= @_;
   if ( $mix ) {
     $suxgraph->{_mix}		= $mix;
     $suxgraph->{_note}	= $suxgraph->{_note}.'mix'.$suxgraph->{_mix};
     $suxgraph->{_Step}	= $suxgraph->{_Step}.'mix'.$suxgraph->{_mix};
   }
 }


=head2 sub outpar 


=cut

 sub outpar {
   my ( $self,$outpar )		= @_;
   if ( $outpar ) {
     $suxgraph->{_outpar}		= $outpar;
     $suxgraph->{_note}	= $suxgraph->{_note}.'outpar'.$suxgraph->{_outpar};
     $suxgraph->{_Step}	= $suxgraph->{_Step}.'outpar'.$suxgraph->{_outpar};
   }
 }


=head2 sub showwiener 


=cut

 sub showwiener {
   my ( $self,$showwiener )		= @_;
   if ( $showwiener ) {
     $suxgraph->{_showwiener}		= $showwiener;
     $suxgraph->{_note}	= $suxgraph->{_note}.'showwiener'.$suxgraph->{_showwiener};
     $suxgraph->{_Step}	= $suxgraph->{_Step}.'showwiener'.$suxgraph->{_showwiener};
   }
 }


=head2 sub method 


=cut

 sub method {
   my ( $self,$method )		= @_;
   if ( $method ) {
     $suxgraph->{_method}		= $method;
     $suxgraph->{_note}	= $suxgraph->{_note}.'method'.$suxgraph->{_method};
     $suxgraph->{_Step}	= $suxgraph->{_Step}.'method'.$suxgraph->{_method};
   }
 }


=head2 sub perc 


=cut

 sub perc {
   my ( $self,$perc )		= @_;
   if ( $perc ) {
     $suxgraph->{_perc}		= $perc;
     $suxgraph->{_note}	= $suxgraph->{_note}.'perc'.$suxgraph->{_perc};
     $suxgraph->{_Step}	= $suxgraph->{_Step}.'perc'.$suxgraph->{_perc};
   }
 }


=head2 sub maxlag 


=cut

 sub maxlag {
   my ( $self,$maxlag )		= @_;
   if ( $maxlag ) {
     $suxgraph->{_maxlag}		= $maxlag;
     $suxgraph->{_note}	= $suxgraph->{_note}.'maxlag'.$suxgraph->{_maxlag};
     $suxgraph->{_Step}	= $suxgraph->{_Step}.'maxlag'.$suxgraph->{_maxlag};
   }
 }


=head2 sub ntout 


=cut

 sub ntout {
   my ( $self,$ntout )		= @_;
   if ( $ntout ) {
     $suxgraph->{_ntout}		= $ntout;
     $suxgraph->{_note}	= $suxgraph->{_note}.'ntout'.$suxgraph->{_ntout};
     $suxgraph->{_Step}	= $suxgraph->{_Step}.'ntout'.$suxgraph->{_ntout};
   }
 }


=head2 sub MAXLAG_PEF 


=cut

 sub MAXLAG_PEF {
   my ( $self,$MAXLAG_PEF )		= @_;
   if ( $MAXLAG_PEF ) {
     $suxgraph->{_MAXLAG_PEF}		= $MAXLAG_PEF;
     $suxgraph->{_note}	= $suxgraph->{_note}.'MAXLAG_PEF'.$suxgraph->{_MAXLAG_PEF};
     $suxgraph->{_Step}	= $suxgraph->{_Step}.'MAXLAG_PEF'.$suxgraph->{_MAXLAG_PEF};
   }
 }


=head2 sub minlag 


=cut

 sub minlag {
   my ( $self,$minlag )		= @_;
   if ( $minlag ) {
     $suxgraph->{_minlag}		= $minlag;
     $suxgraph->{_note}	= $suxgraph->{_note}.'minlag'.$suxgraph->{_minlag};
     $suxgraph->{_Step}	= $suxgraph->{_Step}.'minlag'.$suxgraph->{_minlag};
   }
 }


=head2 sub cdp 


=cut

 sub cdp {
   my ( $self,$cdp )		= @_;
   if ( $cdp ) {
     $suxgraph->{_cdp}		= $cdp;
     $suxgraph->{_note}	= $suxgraph->{_note}.'cdp'.$suxgraph->{_cdp};
     $suxgraph->{_Step}	= $suxgraph->{_Step}.'cdp'.$suxgraph->{_cdp};
   }
 }


=head2 sub minlag 


=cut

 sub minlag {
   my ( $self,$minlag )		= @_;
   if ( $minlag ) {
     $suxgraph->{_minlag}		= $minlag;
     $suxgraph->{_note}	= $suxgraph->{_note}.'minlag'.$suxgraph->{_minlag};
     $suxgraph->{_Step}	= $suxgraph->{_Step}.'minlag'.$suxgraph->{_minlag};
   }
 }


=head2 sub showweiner 


=cut

 sub showweiner {
   my ( $self,$showweiner )		= @_;
   if ( $showweiner ) {
     $suxgraph->{_showweiner}		= $showweiner;
     $suxgraph->{_note}	= $suxgraph->{_note}.'showweiner'.$suxgraph->{_showweiner};
     $suxgraph->{_Step}	= $suxgraph->{_Step}.'showweiner'.$suxgraph->{_showweiner};
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