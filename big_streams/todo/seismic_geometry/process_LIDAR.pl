#! /usr/bin/perl -w

# import system variables
	require SetGmtDefaults;
	use include qw($HOME $DATA_LIDAR $PS $landscape $no_head $no_tail $portrait $projection $smoothcontour $ticks $verbose );
#
# set system gmt defaults
   	SetGmtDefaults::system();

#  initialize values of variables for comparisons
	$X_min = 180;
	$X_max = -180;
	$Y_min = 90;
	$Y_max = -90;

#  initialize values of variables for comparisons
        $x_min = 1000000;
        $x_max = 0;
        $y_min = 5000000;
        $y_max = 0;


#  SUB-ROUTINES
	require  "files.pm";
	require  "strain.pm";

#  defaults for this project
	$sheet          =       $DATA_LIDAR.'/'.<$ARGV[0]>;
	$metadata       =       $sheet.'/metadata/'.<$ARGV[1]>;
	$PL             =	$HOME.'pl/LIDAR/gmt';

#determining the limits of the sheet in UTM Easting and Northings
        $array[1] = 'NE.corners';
        $array[2] = 'NW.corners';
        $array[3] = 'SE.corners';
        $array[4] = 'SW.corners';
        $number_UTM = 4;

        for ($i = 1   ; $i< $number_UTM +1; $i=$i+1) {
                ($E_min,$E_max,$N_min,$N_max) = strain::read_corners_NE("$sheet/$array[$i]");
                $quad_limits  =         $E_min.'/'.$E_max.'/'.$N_min.'/'.$N_max;
                print "quad_limits are $E_min/$E_max/$N_min/$N_max\n";

                # determine limits for the sheet:
                if($E_min < $x_min) {$x_min = $E_min};
                if($E_max > $x_max) {$x_max = $E_max};
                if($N_min < $y_min) {$y_min = $N_min};
                if($N_max > $y_max) {$y_max = $N_max};
}

        $sheet_UTM_limits = $x_min.'/'.$x_max.'/'.$y_min.'/'.$y_max;
        print "sheet limits are $sheet_UTM_limits \n";


#determining the limits of the sheet in geographic coordinates
        (@array) = files::file_names("$sheet/metadata mtd");
	$number = $array[0];
  
	for ($i = 1   ; $i< $number+1; $i=$i+1) { 
        	($lon_min,$lon_max,$lat_min,$lat_max) = strain::read_corners_ll("$sheet/metadata/ $array[$i]");
	   	$quad_limits  = 	$lon_min.'/'.$lon_max.'/'.$lat_min.'/'.$lat_max;
		print "quad_limits are $lon_min/$lon_max/$lat_min/$lat_max\n";

		# determine limits for the sheet:
		if($lon_min < $X_min) {$X_min = $lon_min}; 
		if($lon_max > $X_max) {$X_max = $lon_max};
		if($lat_min < $Y_min) {$Y_min = $lat_min};
		if($lat_max > $Y_max) {$Y_max = $lat_max};
}

	$sheet_limits = $X_min.'/'.$X_max.'/'.$Y_min.'/'.$Y_max;
	print "sheet limits are $sheet_limits \n";
	

	$first_quadrant = 	0;   
# 0 is first
	$num_quad   =		4;   
# put 4 for last,ie one value beyond 

	
# for 1280 x1440 pixel values -F
#   $grid_spacing = '0.17578125c/0.15625c ';
#   for a whole sheet make the grid at 30 m spacing
#   each 5 *6 = 30 m
#	$x_scale = 1; # 0.17578125 * 6;  about 1 second
#	$y_scale = 1; # 0.15625 * 6; about 1 second
#
#  	$grid_spacing = $x_scale.'c/'.$y_scale.'c ';

# for UTM 5m by 5m 
  	$grid_spacing = '2.5/2.5';
        $grid_spacing_surface   = $grid_spacing;
	$grid_spacing_blockmean = $grid_spacing;
	print " Nodes every 5 meters: $grid_spacing \n";
############# DON'T CHANGE BELOW THIS LINE

	$quadrant[0]= 'NW';
	$quadrant[1]= 'SW';
	$quadrant[2]= 'NE';
	$quadrant[3]= 'SE';


# Do all quadrants
# process quadrant[i] 

	for ($i = $first_quadrant   ; $i< $num_quad; $i=$i+1) { 
		$Q=$quadrant[$i];

	## for NW 
	if ($Q eq 'NW'){
           ($lon_min,$lon_max,$lat_min,$lat_max) = strain::read_corners_ll("$metadata nw.mtd");
	   $quadrant_limits  = 	$lon_min.'/'.$lon_max.'/'.$lat_min.'/'.$lat_max;
	   ($yshift_in,$xwidth_in,$xmin_m)   = strain::read_corners("$sheet/$Q.corners"); 
		print "Processing $Q quadrant\n";
	}
	

	## for SW 
	if ($Q eq 'SW'){
           ($lon_min,$lon_max,$lat_min,$lat_max) = strain::read_corners_ll("$metadata sw.mtd");
	   $quadrant_limits  = 	$lon_min.'/'.$lon_max.'/'.$lat_min.'/'.$lat_max;
	   ($yshift_in,$xwidth_in,$xmin_m)   = strain::read_corners("$sheet/$Q.corners"); 
		print "Processing $Q quadrant\n";
	}


	## for NE 
	if ($Q eq 'NE'){
           ($lon_min,$lon_max,$lat_min,$lat_max)   = strain::read_corners_ll("$metadata ne.mtd");
	   $quadrant_limits  = 	$lon_min.'/'.$lon_max.'/'.$lat_min.'/'.$lat_max;
	   ($yshift_in,$xwidth_in,$xmin_m)   = 	strain::read_corners("$sheet/$Q.corners"); 
		print "Processing $Q quadrant\n";
	}


	## for SE 
	if ($Q eq 'SE'){
           ($lon_min,$lon_max,$lat_min,$lat_max)   = strain::read_corners_ll("$metadata se.mtd");
	   $quadrant_limits  = $lon_min.'/'.$lon_max.'/'.$lat_min.'/'.$lat_max;
	   ($yshift_in,$xwidth_in,$xmin_m)   = 	strain::read_corners("$sheet/$Q.corners"); 
		print "Processing $Q quadrant\n";
	}

	print "Width of quadrant = $xwidth_in \n ";
	print "X minimum in meters Bot LHC= $xmin_m \n ";
	print "quadrant limits are $quadrant_limits \n";

}
#  	after the four quadrants have been processed cat
#  	them together
#
	@cat = (" cat  			\\
		$sheet/NW.xyz		\\
		$sheet/NE.xyz		\\
		$sheet/SW.xyz		\\
		$sheet/SE.xyz		\\
		> $sheet/$ARGV[0].xyz 	\\
	");

# replace -32767 with NaN
	@writeNaN_2 = ("$PL/writeNaN_2.pl	\\
		$sheet/$ARGV[0].xyz		 \\
		$sheet/$ARGV[0]_NaN.xyz   	\\
	");

	@regrid = ("$PL/regrid.pl		\\
		$sheet/$ARGV[0]_NaN.xyz 	\\
		$sheet/$ARGV[0]_2.5x2.5m.grd	\\
		$grid_spacing_blockmean		\\
		$sheet_UTM_limits		\\
		$grid_spacing_surface		\\
	");

	#-Cseland -T0/50/1
	@makecpt = ("makecpt			\\
		 -Crainbow 			\\
		-T-5/10/0.5 			\\
		>col.cpt			\\
	");

	@grdimage = ("grdimage 			\\
		$sheet/$ARGV[0]_2.5x2.5m.grd	\\
		-Ccol.cpt			\\
		$projection			\\
		$portrait			\\
		$no_tail			\\
		$verbose			\\
		> $PS/$ARGV[0]_2.5x2.5m.ps           \\
	");

	@grdcontour = ("grdcontour		\\
                $sheet/$ARGV[0]_2.5x2.5m.grd        \\
		-C./contours			\\
		$portrait			\\
		$projection			\\
		$smoothcontour			\\
		$no_head			\\
		$no_tail			\\
		>> $PS/$ARGV[0]_2.5x2.5m.ps		\\
	");

#plot basemap
	@psbasemap = ("psbasemap		\\
                $ticks				\\
                $no_head 	               	\\
                -R$limits 			\\
		$portrait			\\
		$projection            		\\
                $verbose   			\\
                >> $PS/$ARGV[0]_2.5x2.5m.ps         \\
        ");

#	system @cat;
#	system @writeNaN_2;
#	system @makecpt;
#	system @regrid;
	system @grdimage;
	#system @grdcontour;
	system @psbasemap;
        system("gs $PS/$ARGV[0]_2.5x2.5m.ps");
# printing outputs for debugging
#	print ("@regrid");
