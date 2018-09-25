package suxgraph;

=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME: suxgraph.pm 							

 AUTHOR: Juan Lorenzo
 DATE:  Jan 25, 2018 
 DESCRIPTION: package for sunix module suxgraph
 Version: 1.0.0 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES

=cut

=head2
		
 SUXGRAPH - X-windows GRAPH plot of a segy data set			
 									
 suxgraph <stdin [optional parameters] | ...				
 									
 Optional parameters: 							
 (see xgraph selfdoc for optional parametes)				
 									
 nplot= number of traces (ntr is an acceptable alias for nplot) 	
 									
 d1=tr.d1 or tr.dt/10^6	sampling interval in the fast dimension	
   =.004 for seismic 		(if not set)				
   =1.0 for nonseismic		(if not set)				
 							        	
 d2=tr.d2			sampling interval in the slow dimension	
   =1.0 			(if not set)				
 							        	
 f1=tr.f1 or tr.delrt/10^3 or 0.0  first sample in the fast dimension	
 							        	
 f2=tr.f2 or tr.tracr or tr.tracl  first sample in the slow dimension	
   =1.0 for seismic		    (if not set)			
   =d2 for nonseismic		    (if not set)			
 							        	
 verbose=0              =1 to print some useful information		
									
 tmpdir=	 	if non-empty, use the value as a directory path	
		 	prefix for storing temporary files; else if the	
	         	the CWP_TMPDIR environment variable is set use	
	         	its value for the path; else use tmpfile()	
 									
 Note that for seismic time domain data, the "fast dimension" is	
 time and the "slow dimension" is usually trace number or range.	
 Also note that "foreign" data tapes may have something unexpected	
 in the d2,f2 fields, use segyclean to clear these if you can afford	
 the processing time or use d2= f2= to over-ride the header values if	
 not.									
 									
 See the xgraph selfdoc for the remaining parameters.			
 									
 On NeXT:     suxgraph < infile [optional parameters]  | open  


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
 									
 Optional resource parameters (defaults taken from resource database):	

 windowtitle=      	 title on window				

 wbox or
 width=                 width in pixels of window			

 hbox or
 height=                height in pixels of window			

 nTic1=                 number of tics per numbered tic on axis 1	
 grid1=                 grid lines on axis 1 - none, dot, dash, or solid

 ylabel or
 label1=                label on axis 1				
 nTic2=                 number of tics per numbered tic on axis 2	
 grid2=                 grid lines onwidth axis 2 - none, dot, dash, or solid

 xlabel or
 label2=                label on axis 2				

 labelFont=             font name for axes labels			

 title=                 title of plot					

 titleFont=             font name for title				
 titleColor=            color for title				
 axesColor=             color for axes					
 gridColor=             color for grid lines				

 style=                 normal (axis 1 horizontal, axis 2 vertical) or	
                        seismic (axis 1 vertical, axis 2 horizontal)	
									
 Data formats supported:						
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

	use Moose;
	my $VERSION = '1.0.0';

 	my $on = 1;

 my $suxgraph = {
        _ftr		=> '',
        _dtr		=> '',
        _label1 	=> '',
        _ylabel 	=> '',
        _label2 	=> '',
        _xlabel 	=> '',
        _n2   		=> '',
        _note		=> '',
        _d1   		=> '',
        _d2   		=> '',
        _f1   		=> '',
        _f2   		=> '',
        _orientation=> '',
        _style   	=> '',
        _title		=> '',
        _verbose   	=> '',
        _tmpdir   	=> '',
        _Step   	=> ':',
    };

=head2

 sub clear 
     clear global variables from the memory

=cut

sub clear {
    $suxgraph->{_Step} 			= ':';
    $suxgraph->{_box_width} 	= 0;
    $suxgraph->{_box_height} 	= 0;
    $suxgraph->{_box_X0} 		= 0;
    $suxgraph->{_box_Y0} 		= 0;
    $suxgraph->{_note} 			= '';
    $suxgraph->{_orientation}   = '';
    $suxgraph->{_style}  		= '';
    $suxgraph->{_title} 		= '';
}

=head2


=cut

sub box_width {
    my ($suxgraph,$box_width) 	= @_;
    
    if ($box_width) {
    	
    	$suxgraph->{_box_width}     = $box_width;  
    	$suxgraph->{_note}          = $suxgraph->{_note};
    	
    } else {
    	print("suxgraph, missing box_width \n");
    }

}


=head2


=cut

sub box_height {
    my ($suxgraph,$box_height) 	= @_;
    $suxgraph->{_box_height}    = $box_height if defined($box_height);
    $suxgraph->{_note}          = $suxgraph->{_note};
}


=head2


=cut

sub box_X0 {
    my ($suxgraph, $box_X0)        = @_;
    $suxgraph->{_box_X0}        = $box_X0 if defined($box_X0);
    $suxgraph->{_note}       	= $suxgraph->{_note};
}

=head2


=cut

sub box_Y0 {
    my ($suxgraph, $box_Y0) 	= @_;
    $suxgraph->{_box_Y0}        = $box_Y0 if defined($box_Y0);  
    $suxgraph->{_note}       	= $suxgraph->{_note};
}


=head2 sub f1


=cut

sub f1 {
    my ($suxgraph, $f1 )    = @_;
    $suxgraph->{_f1}        = $f1 if defined($f1);
    $suxgraph->{_Step}      = $suxgraph->{_Step}.' f1='.$suxgraph->{_f1};
}

=head2


=cut


sub f2 {
    my ($suxgraph, $f2 )    = @_;
    $suxgraph->{_f2}        = $f2 if defined($f2);
    $suxgraph->{_Step}      = $suxgraph->{_Step}.' f2='.$suxgraph->{_f2};
}

=head2


=cut


sub note {
    my ($suxgraph) 	      = @_;
    $suxgraph->{_note}        =  $suxgraph->{_note};
    return $suxgraph->{_note};
}



=head2 sub style

  can be seismic type RHS
  or normal type LHS
  
   normal (axis 1 horizontal, axis 2 vertical) or	
   seismic (axis 1 vertical, axis 2 horizontal)

=cut


sub style {
    my ($self,$style) 	      = @_;
    
    if ($style) {
    	
    	print("suxgraph, style:$style \n ");
		$suxgraph->{_style}  =  $style;
		$suxgraph->{_Step}      = $suxgraph->{_Step}.' style='.$suxgraph->{_style};    
        $suxgraph->{_note}      = $suxgraph->{_note}.' style='.$suxgraph->{_style};
    	
    }else {
    	print("suxgraph, missing style\n ");
    	
    }
}

=head2 sub orientation

  can be seismic type RHS
  or normal type LHS
  
   normal (axis 1 horizontal, axis 2 vertical) or	
   seismic (axis 1 vertical, axis 2 horizontal)

=cut


sub orientation {
    my ($self,$orientation) 	      = @_;
    
    if ($orientation) {
    	
    	print("suxgraph, orientation:$orientation \n ");
		$suxgraph->{_orientation}  =  $orientation;
		$suxgraph->{_Step}      = $suxgraph->{_Step}.' style='.$suxgraph->{_orientation};    
        $suxgraph->{_note}      = $suxgraph->{_note}.' style='.$suxgraph->{_orientation};
    	
    }else {
    	print("suxgraph, missing orientation\n ");
    	
    }
}

=head2


=cut


sub Step {
    my ($suxgraph) 	   	= @_;
  
    if ( $suxgraph->{_box_width} && $suxgraph->{_box_height} && $suxgraph->{_box_X0} && $suxgraph->{_box_Y0}) {
       $suxgraph->{_Step}      = $suxgraph->{_Step}.' -geometry ' .$suxgraph->{_box_width}.'x'.$suxgraph->{_box_height}.'+'.$suxgraph->{_box_X0}.'+'.$suxgraph->{_box_Y0}; 	
    } else {   
    	 $suxgraph->{_Step}     	= 'suxgraph '.$suxgraph->{_Step};
    	#print("suxgraph, Step, needs box dimensions \n");
    }
 
    return $suxgraph->{_Step};
}


=head2

 sub title allows for a default graph title ($on) or
 a user-defined plot title

=cut


sub title {
    my ($suxgraph,$title)       = @_;

    if ($title ) {  # assume not numeric
    
           	# print (" 1 suxgraph, title, Step:  $suxgraph->{_Step}\n");
           # 	print (" 1 suxgraph, title, title: $suxgraph->{_title},\n");

       $suxgraph->{_title}      = $title;
           	# print (" 2 suxgraph, title, Step:  $suxgraph->{_Step}\n");
           	print (" 2 suxgraph, title, title: $suxgraph->{_title},\n");
       $suxgraph->{_note}       = $title;
       $suxgraph->{_Step}       = $suxgraph->{_Step}.' title='.$suxgraph->{_title};
       $suxgraph->{_note}       = $suxgraph->{_note}.' title='.$suxgraph->{_title};
       
    } else {
       print (" missing title \n\n");
    }

}

sub verbose {
    my ($suxgraph, $verbose )   = @_;
    
    $suxgraph->{_verbose}       = $verbose if defined($verbose);
    $suxgraph->{_Step}    	 	= $suxgraph->{_Step}.' verbose='.$suxgraph->{_verbose};
}

=head2


=cut


sub windowtitle {
    my ($suxgraph, $windowtitle) = @_;
    $suxgraph->{_windowtitle}    = $windowtitle if defined($windowtitle);
    $suxgraph->{_Step}           = $suxgraph->{_Step}.' windowtitle='.$suxgraph->{_windowtitle}; 
    $suxgraph->{_note}       	 = $suxgraph->{_note};
}

=head2


=cut


sub xlabel {
    my ($suxgraph, $xlabel)     = @_;
    $suxgraph->{_label2}        = $xlabel if defined($xlabel);
    $suxgraph->{_Step}          = $suxgraph->{_Step}.' label2='.$suxgraph->{_label2}; 
    $suxgraph->{_note}       	= $suxgraph->{_note};
}

=head2


=cut


sub ylabel {
    my ($suxgraph, $ylabel)     = @_;
    $suxgraph->{_label1}        = $ylabel if defined($ylabel);
    $suxgraph->{_Step}          = $suxgraph->{_Step}.' label1='.$suxgraph->{_label1}; 
    $suxgraph->{_note}       	= $suxgraph->{_note};
}
   
=head2 sub get_max_index
  max index = number of input variables -1

=cut

 sub get_max_index {
 	my ($self) = @_;
 	# only file_name : index=44
 	my $max_index = 44;
 	
 	return($max_index);
 }



1;
