package suxgraph;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  XGRAPH - X GRAPHer							

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

use Moose;

=head2 sub n 


=cut

 sub n {
   my ( $self,$n )		= @_;
   if ( $n ) {
     $suxgraph->{_n}		= $n;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'n='.$suxgraph->{_n};
   }
 }


=head2 sub nplot 


=cut

 sub nplot {
   my ( $self,$nplot )		= @_;
   if ( $nplot ) {
     $suxgraph->{_nplot}		= $nplot;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'nplot='.$suxgraph->{_nplot};
   }
 }


=head2 sub d1 


=cut

 sub d1 {
   my ( $self,$d1 )		= @_;
   if ( $d1 ) {
     $suxgraph->{_d1}		= $d1;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'d1='.$suxgraph->{_d1};
   }
 }


=head2 sub f1 


=cut

 sub f1 {
   my ( $self,$f1 )		= @_;
   if ( $f1 ) {
     $suxgraph->{_f1}		= $f1;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'f1='.$suxgraph->{_f1};
   }
 }


=head2 sub d2 


=cut

 sub d2 {
   my ( $self,$d2 )		= @_;
   if ( $d2 ) {
     $suxgraph->{_d2}		= $d2;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'d2='.$suxgraph->{_d2};
   }
 }


=head2 sub f2 


=cut

 sub f2 {
   my ( $self,$f2 )		= @_;
   if ( $f2 ) {
     $suxgraph->{_f2}		= $f2;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'f2='.$suxgraph->{_f2};
   }
 }


=head2 sub pairs 


=cut

 sub pairs {
   my ( $self,$pairs )		= @_;
   if ( $pairs ) {
     $suxgraph->{_pairs}		= $pairs;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'pairs='.$suxgraph->{_pairs};
   }
 }


=head2 sub linewidth 


=cut

 sub linewidth {
   my ( $self,$linewidth )		= @_;
   if ( $linewidth ) {
     $suxgraph->{_linewidth}		= $linewidth;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'linewidth='.$suxgraph->{_linewidth};
   }
 }


=head2 sub linecolor 


=cut

 sub linecolor {
   my ( $self,$linecolor )		= @_;
   if ( $linecolor ) {
     $suxgraph->{_linecolor}		= $linecolor;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'linecolor='.$suxgraph->{_linecolor};
   }
 }


=head2 sub mark 


=cut

 sub mark {
   my ( $self,$mark )		= @_;
   if ( $mark ) {
     $suxgraph->{_mark}		= $mark;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'mark='.$suxgraph->{_mark};
   }
 }


=head2 sub marksize 


=cut

 sub marksize {
   my ( $self,$marksize )		= @_;
   if ( $marksize ) {
     $suxgraph->{_marksize}		= $marksize;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'marksize='.$suxgraph->{_marksize};
   }
 }


=head2 sub x1beg 


=cut

 sub x1beg {
   my ( $self,$x1beg )		= @_;
   if ( $x1beg ) {
     $suxgraph->{_x1beg}		= $x1beg;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'x1beg='.$suxgraph->{_x1beg};
   }
 }


=head2 sub x1end 


=cut

 sub x1end {
   my ( $self,$x1end )		= @_;
   if ( $x1end ) {
     $suxgraph->{_x1end}		= $x1end;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'x1end='.$suxgraph->{_x1end};
   }
 }


=head2 sub x2beg 


=cut

 sub x2beg {
   my ( $self,$x2beg )		= @_;
   if ( $x2beg ) {
     $suxgraph->{_x2beg}		= $x2beg;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'x2beg='.$suxgraph->{_x2beg};
   }
 }


=head2 sub x2end 


=cut

 sub x2end {
   my ( $self,$x2end )		= @_;
   if ( $x2end ) {
     $suxgraph->{_x2end}		= $x2end;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'x2end='.$suxgraph->{_x2end};
   }
 }


=head2 sub reverse 


=cut

 sub reverse {
   my ( $self,$reverse )		= @_;
   if ( $reverse ) {
     $suxgraph->{_reverse}		= $reverse;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'reverse='.$suxgraph->{_reverse};
   }
 }


=head2 sub windowtitle 


=cut

 sub windowtitle {
   my ( $self,$windowtitle )		= @_;
   if ( $windowtitle ) {
     $suxgraph->{_windowtitle}		= $windowtitle;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'windowtitle='.$suxgraph->{_windowtitle};
   }
 }


=head2 sub width 


=cut

 sub width {
   my ( $self,$width )		= @_;
   if ( $width ) {
     $suxgraph->{_width}		= $width;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'width='.$suxgraph->{_width};
   }
 }


=head2 sub height 


=cut

 sub height {
   my ( $self,$height )		= @_;
   if ( $height ) {
     $suxgraph->{_height}		= $height;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'height='.$suxgraph->{_height};
   }
 }


=head2 sub nTic1 


=cut

 sub nTic1 {
   my ( $self,$nTic1 )		= @_;
   if ( $nTic1 ) {
     $suxgraph->{_nTic1}		= $nTic1;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'nTic1='.$suxgraph->{_nTic1};
   }
 }


=head2 sub grid1 


=cut

 sub grid1 {
   my ( $self,$grid1 )		= @_;
   if ( $grid1 ) {
     $suxgraph->{_grid1}		= $grid1;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'grid1='.$suxgraph->{_grid1};
   }
 }


=head2 sub label1 


=cut

 sub label1 {
   my ( $self,$label1 )		= @_;
   if ( $label1 ) {
     $suxgraph->{_label1}		= $label1;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'label1='.$suxgraph->{_label1};
   }
 }


=head2 sub nTic2 


=cut

 sub nTic2 {
   my ( $self,$nTic2 )		= @_;
   if ( $nTic2 ) {
     $suxgraph->{_nTic2}		= $nTic2;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'nTic2='.$suxgraph->{_nTic2};
   }
 }


=head2 sub grid2 


=cut

 sub grid2 {
   my ( $self,$grid2 )		= @_;
   if ( $grid2 ) {
     $suxgraph->{_grid2}		= $grid2;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'grid2='.$suxgraph->{_grid2};
   }
 }


=head2 sub label2 


=cut

 sub label2 {
   my ( $self,$label2 )		= @_;
   if ( $label2 ) {
     $suxgraph->{_label2}		= $label2;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'label2='.$suxgraph->{_label2};
   }
 }


=head2 sub labelFont 


=cut

 sub labelFont {
   my ( $self,$labelFont )		= @_;
   if ( $labelFont ) {
     $suxgraph->{_labelFont}		= $labelFont;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'labelFont='.$suxgraph->{_labelFont};
   }
 }


=head2 sub title 


=cut

 sub title {
   my ( $self,$title )		= @_;
   if ( $title ) {
     $suxgraph->{_title}		= $title;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'title='.$suxgraph->{_title};
   }
 }


=head2 sub titleFont 


=cut

 sub titleFont {
   my ( $self,$titleFont )		= @_;
   if ( $titleFont ) {
     $suxgraph->{_titleFont}		= $titleFont;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'titleFont='.$suxgraph->{_titleFont};
   }
 }


=head2 sub titleColor 


=cut

 sub titleColor {
   my ( $self,$titleColor )		= @_;
   if ( $titleColor ) {
     $suxgraph->{_titleColor}		= $titleColor;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'titleColor='.$suxgraph->{_titleColor};
   }
 }


=head2 sub axesColor 


=cut

 sub axesColor {
   my ( $self,$axesColor )		= @_;
   if ( $axesColor ) {
     $suxgraph->{_axesColor}		= $axesColor;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'axesColor='.$suxgraph->{_axesColor};
   }
 }


=head2 sub gridColor 


=cut

 sub gridColor {
   my ( $self,$gridColor )		= @_;
   if ( $gridColor ) {
     $suxgraph->{_gridColor}		= $gridColor;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'gridColor='.$suxgraph->{_gridColor};
   }
 }


=head2 sub style 


=cut

 sub style {
   my ( $self,$style )		= @_;
   if ( $style ) {
     $suxgraph->{_style}		= $style;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'style='.$suxgraph->{_style};
   }
 }


=head2 sub n 


=cut

 sub n {
   my ( $self,$n )		= @_;
   if ( $n ) {
     $suxgraph->{_n}		= $n;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'n='.$suxgraph->{_n};
   }
 }


=head2 sub i 


=cut

 sub i {
   my ( $self,$i )		= @_;
   if ( $i ) {
     $suxgraph->{_i}		= $i;
     $suxgraph->{_Step}		= $suxgraph->{_Step}.'i='.$suxgraph->{_i};
   }
 }

1; 