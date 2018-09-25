package xgraph;
use Moose;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

=head3

 PACKAGE NAME: xgraph
 Purpose: line graph
 Author: Juan M. Lorenzo
 Date: July 29 2015
 Version: 0.1head2 USE

=head3 NOTES 

=head4 
  Examples

=head3 SEISMIC UNIX NOTES  
XGRAPH - X GRAPHer							
 Graphs n[i] pairs of (x,y) coordinates, for i = 1 to nplot.		
 									
 xgraph n= [optional parameters] <binaryfile 				
 									
 X Functionality:                                                      
 q or Q key    Quit                                                    
 									
 Required Parameters:							
 n                      array containing number of points per plot	
 									
 Optional Parameters:							
 nplot=number of n's    number of plots				
 d1=0.0,...             x sampling intervals (0.0 if x coordinates input)
 f1=0.0,...             first x values (not used if x coordinates input)
 d2=0.0,...             y sampling intervals (0.0 if y coordinates input)
 f2=0.0,...             first y values (not used if y coordinates input)
 pairs=1,...            =1 for data pairs in format 1.a, =0 for format 1.b
 linewidth=1,1,...      line widths in pixels (0 for no lines)		
 linecolor=2,3,...      line colors (black=0, white=1, 2,3,4 = RGB, ...)
 mark=0,1,2,3,...       indices of marks used to represent plotted points
 marksize=0,0,...       size of marks in pixels (0 for no marks)	
 x1beg=x1min            value at which axis 1 begins			
 x1end=x1max            value at which axis 1 ends			
 x2beg=x2min            value at which axis 2 begins			
 x2end=x2max            value at which axis 2 ends			
 reverse=0              =1 to reverse sequence of plotting curves	
ptional resource parameters (defaults taken from resource database):	
 windowtitle=      	 title on window				
 width=                 width in pixels of window			
 height=                height in pixels of window			
 nTic1=                 number of tics per numbered tic on axis 1	
 grid1=                 grid lines on axis 1 - none, dot, dash, or solid
 label1=                label on axis 1				
 nTic2=                 number of tics per numbered tic on axis 2	
 grid2=                 grid lines on axis 2 - none, dot, dash, or solid
 label2=                label on axis 2				
 labelFont=             font name for axes labels			
 title=                 title of plot					
 titleFont=             font name for title				
 titleColor=            color for title				
 axesColor=             color for axes					
 gridColor=             color for grid lines				
 style=                 normal (axis 1 horizontal, axis 2 vertical) or	
                        seismic (axis 1 vertical, axis 2 horizontal)	
 									
ta formats supported:						
 	1.a. x1,y1,x2,y2,...,xn,yn					
 	  b. x1,x2,...,xn,y1,y2,...,yn					
 	2. y1,y2,...,yn (must give non-zero d1[]=)			
 	3. x1,x2,...,xn (must give non-zero d2[]=)			
 	4. nil (must give non-zero d1[]= and non-zero d2[]=)		
   The formats may be repeated and mixed in any order, but if		
   formats 2-4 are used, the d1 and d2 arrays must be specified including
   d1[]=0.0 d2[]=0.0 entries for any internal occurences of format 1.	
   Similarly, the pairs array must contain place-keeping entries for	
   plots of formats 2-4 if they are mixed with both formats 1.a and 1.b.
   Also, if formats 2-4 are used with non-zero f1[] or f2[] entries, then
   the corresponding array(s) must be fully specified including f1[]=0.0
   and/or f2[]=0.0 entries for any internal occurences of format 1 or	
   formats 2-4 where the zero entries are desired.			
 mark index:                                                           
 1. asterisk                                                           
 2. x-cross                                                            
 3. open triangle                                                      
 4. open square                                                        
 5. open circle                                                        
 6. solid triangle                                                     
 7. solid square                                                       
 8. solid circle                                                       
 									
 Note:	n1 and n2 are acceptable aliases for n and nplot, respectively.	

									
 Example:								
 xgraph n=50,100,20 d1=2.5,1,0.33 <datafile				
   plots three curves with equally spaced x values in one plot frame	
   x1-coordinates are x1(i) = f1+i*d1 for i = 1 to n (f1=0 by default)	
   number of x2's and then x2-coordinates for each curve are read	
   sequentially from datafile.		

=cut


=head3 STEPS

 1. build a list or hash with all the possible variable
    names you may use and you can even change them

=cut

 my $xgraph = {
          _num_points     		=>'',
          _height     			=>'',
		  _nTic2				=>'',
          _width     			=>'',
          _x1_min     			=>'',
          _x1beg     			=>'',
          _x1_max     			=>'',
          _x1end     			=>'',
          _x2_min     			=>'',
          _x2beg     			=>'',
          _x2_max     			=>'',
          _x2end     			=>'',
          _windowtitle     		=>'',
          _title     			=>'',
          _grid1_type     		=>'',
          _grid2    			=>'',
          _grid2_type    		=>'',
          _mark_indices     	=>'',
          _mark_size_pix     	=>'',
          _box_width     		=>'',
          _box_height     		=>'',
          _geometry     		=>'',
          _label1     			=>'',
          _label2     			=>'',
          _line_widths     		=>'',
          _line_color     		=>'',
          _axes_style     		=>'',
          _style  	   			=>'',
          _note   				=>'',
          _Step          		=>''
      };



=head2 subroutine clear

  sets all variable strings to '' 

=cut


sub clear {
    $xgraph->{_cdp_num} 		= '';
    $xgraph->{_grid2_type} 		= '';
    $xgraph->{_grid2} 		= '';
    $xgraph->{_height} 		= '';
    $xgraph->{_width} 		= '';
    $xgraph->{_num_points} 		= '';
    $xgraph->{_nTic2} 		= '';
    $xgraph->{_x1_min} 			= '';
    $xgraph->{_x1_max} 			= '';
    $xgraph->{_x1beg} 			= '';
    $xgraph->{_x1end} 			= '';
    $xgraph->{_x2_min} 			= '';
    $xgraph->{_x2_max} 			= '';
    $xgraph->{_x2beg} 			= '';
    $xgraph->{_x2end} 			= '';
    $xgraph->{_windowtitle} 		= '';
    $xgraph->{_title} 			= '';
    $xgraph->{_grid1_type} 		= '';
    $xgraph->{_mark_indices} 		= '';
    $xgraph->{_mark_size_pix} 		= '';
    $xgraph->{_box_width} 		= '';
    $xgraph->{_box_height} 		= '';
    $xgraph->{_geometry} 		= '';
    $xgraph->{_label1} 			= '';
    $xgraph->{_label2} 			= '';
    $xgraph->{_line_widths} 		= '';
    $xgraph->{_line_color} 		= '';
    $xgraph->{_axes_style} 		= '';
    $xgraph->{_style}	 		= '';
    $xgraph->{_Step} 			= '';
    $xgraph->{_note} 			= '';
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
 #my ($xgraph->{_Step}) = $xgraph->{_Step} +1;
 #print("Share step is first $xgraph->{_Step}\n");
}



=head2 subroutine  height 


=cut

sub height {
    my ($variable,$height)   = @_;
    $xgraph->{_height}     = $height if defined($height);
    $xgraph->{_note}       = $xgraph->{_note}.' height='.$xgraph->{_height};
    $xgraph->{_Step}       = $xgraph->{_Step}.' height='.$xgraph->{_height};
}


=head2 subroutine  width 


=cut

sub width {
    my ($variable,$width)   = @_;
    $xgraph->{_width}     = $width if defined($width);
    $xgraph->{_note}       = $xgraph->{_note}.' width='.$xgraph->{_width};
    $xgraph->{_Step}       = $xgraph->{_Step}.' width='.$xgraph->{_width};
}



=head2 subroutine  num_points 


=cut

sub num_points {
    my ($variable,$num_points)   = @_;
    $xgraph->{_num_points}     = $num_points if defined($num_points);
    $xgraph->{_note}       = $xgraph->{_note}.' n='.$xgraph->{_num_points};
    $xgraph->{_Step}       = $xgraph->{_Step}.' n='.$xgraph->{_num_points};
}


=head2 sub grid2 


=cut

sub grid2 {
    my ($variable,$grid2)   = @_;
    $xgraph->{_grid2}     = $grid2 if defined($grid2);
    $xgraph->{_note}       = $xgraph->{_note}.' grid2='.$xgraph->{_grid2};
    $xgraph->{_Step}       = $xgraph->{_Step}.' grid2='.$xgraph->{_grid2};
}



=head2 subroutine  nTic2 


=cut

sub nTic2 {
    my ($variable,$nTic2)   = @_;
    $xgraph->{_nTic2}     = $nTic2 if defined($nTic2);
    $xgraph->{_note}       = $xgraph->{_note}.' nTic2='.$xgraph->{_nTic2};
    $xgraph->{_Step}       = $xgraph->{_Step}.' nTic2='.$xgraph->{_nTic2};
}



=head2 subroutine  x1_min

value at which axis 1 begins

=cut

sub  x1_min{
    my ($variable,$x1_min)   = @_;
    $xgraph->{_x1_min}     = $x1_min if defined($x1_min);
    $xgraph->{_note}       = $xgraph->{_note}.'  x1beg='.$xgraph->{_x1_min};
    $xgraph->{_Step}       = $xgraph->{_Step}.' x1beg='.$xgraph->{_x1_min};
}

=head2 subroutine  x1_beg

value at which axis 1 begins

=cut

sub  x1beg{
    my ($variable,$x1beg)   = @_;
    $xgraph->{_x1beg}     = $x1beg if defined($x1beg);
    $xgraph->{_note}       = $xgraph->{_note}.'  x1beg='.$xgraph->{_x1beg};
    $xgraph->{_Step}       = $xgraph->{_Step}.' x1beg='.$xgraph->{_x1beg};
}



=head2 subroutine  x1_max

value at which axis 1 ends

=cut

sub  x1_max{
    my ($variable,$x1_max)   = @_;
    $xgraph->{_x1_max}     = $x1_max if defined($x1_max);
    $xgraph->{_note}       = $xgraph->{_note}.'  x1end='.$xgraph->{_x1_max};
    $xgraph->{_Step}       = $xgraph->{_Step}.' x1end='.$xgraph->{_x1_max};
}

=head2 subroutine  x1_end

value at which axis 1 ends

=cut

sub  x1end{
    my ($variable,$x1end)   = @_;
    $xgraph->{_x1end}     = $x1end if defined($x1end);
    $xgraph->{_note}       = $xgraph->{_note}.'  x1end='.$xgraph->{_x1end};
    $xgraph->{_Step}       = $xgraph->{_Step}.' x1end='.$xgraph->{_x1end};
}



=head2 subroutine  x2_min

value at which axis 2 begins

=cut

sub  x2_min{
    my ($variable,$x2_min)   = @_;
    $xgraph->{_x2_min}     = $x2_min if defined($x2_min);
    $xgraph->{_note}       = $xgraph->{_note}.'  x2beg='.$xgraph->{_x2_min};
    $xgraph->{_Step}       = $xgraph->{_Step}.' x2beg='.$xgraph->{_x2_min};
}


=head2 subroutine  x2_beg

value at which axis 2 begins

=cut

sub  x2beg{
    my ($variable,$x2beg)   = @_;
    $xgraph->{_x2beg}     = $x2beg if defined($x2beg);
    $xgraph->{_note}       = $xgraph->{_note}.'  x2beg='.$xgraph->{_x2beg};
    $xgraph->{_Step}       = $xgraph->{_Step}.' x2beg='.$xgraph->{_x2beg};
}



=head2 subroutine  x2_max

value at which axis 2 ends	

=cut

sub  x2_max{
    my ($variable,$x2_max)   = @_;
    $xgraph->{_x2_max}     = $x2_max if defined($x2_max);
    $xgraph->{_note}       = $xgraph->{_note}.'  x2end='.$xgraph->{_x2_max};
    $xgraph->{_Step}       = $xgraph->{_Step}.' x2end='.$xgraph->{_x2_max};
}

=head2 subroutine  x2_end

value at which axis 2 ends	

=cut

sub  x2end{
    my ($variable,$x2end)   = @_;
    $xgraph->{_x2end}     = $x2end if defined($x2end);
    $xgraph->{_note}       = $xgraph->{_note}.'  x2end='.$xgraph->{_x2end};
    $xgraph->{_Step}       = $xgraph->{_Step}.' x2end='.$xgraph->{_x2end};
}




=head2 subroutine  windowtitle


=cut

sub windowtitle {
    my ($variable,$windowtitle)   = @_;
    $xgraph->{_windowtitle}     = $windowtitle if defined($windowtitle);
    $xgraph->{_note}       = $xgraph->{_note}.' windowtitle='.$xgraph->{_windowtitle};
    $xgraph->{_Step}       = $xgraph->{_Step}.' windowtitle='.$xgraph->{_windowtitle};
}


=head2 subroutine  title

  title for plot

=cut

sub  title {
    my ($variable,$title)   = @_;
    $xgraph->{_title}     = $title if defined($title);
    $xgraph->{_note}       = $xgraph->{_note}.' title='.$xgraph->{_title};
    $xgraph->{_Step}       = $xgraph->{_Step}.' title='.$xgraph->{_title};
}


=head2 subroutine  grid1_type

grid lines on axis 1 - none, dot, dash, or solid


=cut

sub  grid1_type {
    my ($variable,$grid1_type)   = @_;
    $xgraph->{_grid1_type}     = $grid1_type if defined($grid1_type);
    $xgraph->{_note}       = $xgraph->{_note}.' grid1='.$xgraph->{_grid1_type};
    $xgraph->{_Step}       = $xgraph->{_Step}.' grid1='.$xgraph->{_grid1_type};
}


=head2 subroutine  grid2_type
grid lines on axis 2 - none, dot, dash, or solid


=cut

sub  grid2_type {
    my ($variable,$grid2_type)   = @_;
    $xgraph->{_grid2_type}     = $grid2_type if defined($grid2_type);
    $xgraph->{_note}       = $xgraph->{_note}.' grid2='.$xgraph->{_grid2_type};
    $xgraph->{_Step}       = $xgraph->{_Step}.' grid2='.$xgraph->{_grid2_type};
}


=head2 subroutine  mark_indices
ndices of marks used to represent plotted points

=cut

sub  mark_indices {
    my ($variable,$mark_indices)   = @_;
    $xgraph->{_mark_indices}     = $mark_indices if defined($mark_indices);
    $xgraph->{_note}       = $xgraph->{_note}.' mark='.$xgraph->{_mark_indices};
    $xgraph->{_Step}       = $xgraph->{_Step}.' mark='.$xgraph->{_mark_indices};
}


=head2 subroutine mark_size_pix
 size of marks in pixels (0 for no marks)

=cut

sub  mark_size_pix {
    my ($variable,$mark_size_pix)   = @_;
    $xgraph->{_mark_size_pix}     = $mark_size_pix if defined($mark_size_pix);
    $xgraph->{_note}       = $xgraph->{_note}.' marksize='.$xgraph->{_mark_size_pix};
    $xgraph->{_Step}       = $xgraph->{_Step}.' marksize='.$xgraph->{_mark_size_pix};
}



=head2 subroutine  box_width 


=cut

sub box_width  {
    my ($variable,$box_width )   = @_;
    $xgraph->{_box_width}     = $box_width if defined($box_width);
    $xgraph->{_note}       = $xgraph->{_note}.' width='.$xgraph->{_box_width};
    $xgraph->{_Step}       = $xgraph->{_Step}.' width='.$xgraph->{_box_width};
}


=head2 subroutine  box_height

 height in pixels of window

=cut

sub  box_height{
    my ($variable,$box_height)   = @_;
	
    $xgraph->{_box_height}     = $box_height if defined($box_height);
    $xgraph->{_note}       = $xgraph->{_note}.' height='.$xgraph->{_box_height};
    $xgraph->{_Step}       = $xgraph->{_Step}.' height='.$xgraph->{_box_height};
}


=head2 subroutine geometry
  low-level layout not commented in 
  seismic unix notes

=cut

sub  geometry {
    my ($variable,$geometry)   = @_;
    $xgraph->{_geometry}     = $geometry if defined($geometry);
    $xgraph->{_note}       = $xgraph->{_note}.' -geometry '.$xgraph->{_geometry};
    $xgraph->{_Step}       = $xgraph->{_Step}.' -geometry '.$xgraph->{_geometry};
}


=head2 subroutine  label1
 label on axis 1

=cut

sub label1 {
    my ($variable,$label1)   = @_;
    $xgraph->{_label1}     = $label1 if defined($label1);
    $xgraph->{_note}       = $xgraph->{_note}.' label1='.$xgraph->{_label1};
    $xgraph->{_Step}       = $xgraph->{_Step}.' label1='.$xgraph->{_label1};
}


=head2 subroutine  label2
  label on axis 2

=cut

sub label2 {
    my ($variable,$label2)   = @_;
    $xgraph->{_label2}     = $label2 if defined($label2);
    $xgraph->{_note}       = $xgraph->{_note}.' label2='.$xgraph->{_label2};
    $xgraph->{_Step}       = $xgraph->{_Step}.' label2='.$xgraph->{_label2};
}


=head2 subroutine  line_widths
 line widths in pixels (0 for no lines

=cut

sub line_widths {
    my ($variable,$line_widths)   = @_;
    $xgraph->{_line_widths}     = $line_widths if defined($line_widths);
    $xgraph->{_note}       = $xgraph->{_note}.' linewidth='.$xgraph->{_line_widths};
    $xgraph->{_Step}       = $xgraph->{_Step}.' linewidth='.$xgraph->{_line_widths};
}


=head2 subroutine  line_color
line colors (black=0, white=1, 2,3,4 = RGB, ...)

=cut

sub line_color {
    my ($variable,$line_color)   = @_;
    $xgraph->{_line_color}     = $line_color if defined($line_color);
    $xgraph->{_note}       = $xgraph->{_note}.' linecolor='.$xgraph->{_line_color};
    $xgraph->{_Step}       = $xgraph->{_Step}.' linecolor='.$xgraph->{_line_color};
}


=head2 subroutine  axes_style

normal (axis 1 horizontal, axis 2 vertical) or	
                        seismic (axis 1 vertical, axis 2 horizontal)

=cut

sub axes_style {
    my ($variable,$axes_style)   = @_;
    $xgraph->{_axes_style}     = $axes_style if defined($axes_style);
    $xgraph->{_note}       = $xgraph->{_note}.' style='.$xgraph->{_axes_style};
    $xgraph->{_Step}       = $xgraph->{_Step}.' style='.$xgraph->{_axes_style};
}


=head2 subroutine  style

normal (axis 1 horizontal, axis 2 vertical) or	
                        seismic (axis 1 vertical, axis 2 horizontal)

=cut

sub style {
    my ($variable,$style)   = @_;
    if($style) {
     $xgraph->{_style}      = $style;
     $xgraph->{_note}       = $xgraph->{_note}.' style='.$xgraph->{_style};
     $xgraph->{_Step}       = $xgraph->{_Step}.' style='.$xgraph->{_style};
    }
}


=head2 subroutine Step 
 adds the program name

=cut


sub Step{
    $xgraph->{_Step}       = 'xgraph'.$xgraph->{_Step};
    return $xgraph->{_Step};
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

