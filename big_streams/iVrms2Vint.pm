package iVrms2Vint;

use Moose;
our $VERSION = '1.0.0';
use message;
use flow;
use a2b;
use xgraph;
use manage_files_by2;
use seismics;
use Project;


=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PACKAGE NAME
 iVrms2Vint.pm
 Purpose: Convert Vrms to Vinterval  
 Juan M. Lorenzo
 April 7 2009 
 Nov. 19 2013

=head2 USE

=head2 NOTES 

=head4 

 Examples

=head2 SEISMIC UNIX NOTES  

=head4 CHANGES and their DATES

=cut


=head2 STEPS

 1. define the types of variables you are using
    these would be the values you enter into 
    each of the Seismic Unix programs  each of the 
    Seismic Unix programs

 2. build a list or hash with all the possible variable
    names you may use and you can even change them

=cut



=head2 instantiate programs


=cut

  my $log 				= new message();
  my $run    			= new flow();
  my $a2b				= new a2b();
  my $xgraph			= new xgraph();
  my $files             = new manage_files_by2();
  my $seismics          = new seismics();
  my $Project			= new Project;

=head2 set defaults

 VELAN DATA 
 m/s

 
=cut

  
 my $iVrms2Vint = {
          _cdp_num          			=> '',
          _first_velocity     			=> '',
          _number_of_velocities   		=> '',
          _tmax_s                 		=> '',
          _velocity_increment   		=> '',
      };



=head2 subroutine clear

  sets all variable strings to '' 

=cut

sub clear {
    $iVrms2Vint->{_cdp_num} 			= '';
    $iVrms2Vint->{_first_velocity} 		= '';
    $iVrms2Vint->{_number_of_velocities} 	= '';
    $iVrms2Vint->{_tmax_s} 			= '';
    $iVrms2Vint->{_velocity_increment} 		= '';
};

=head2 subroutine cdp

  sets cdp number to consider  

=cut

sub cdp_num {
   my($variable,$cdp_num)  		= @_;
   $iVrms2Vint->{_cdp_num} 		= $cdp_num if defined ($cdp_num);
   $iVrms2Vint->{_cdp_num_suffix}     = '_cdp'.$iVrms2Vint->{_cdp_num}
}



sub calcNdisplay {

=head2 variables of local scope


=cut

  my (@cdp_num,@items,@format);
  my (@num_samples_file, @num_sample_cols);
  my ($ref_T,$ref_Vrms,$num_points_Vrms,$ref_Tnew); 
  my ($ref_Vint);
  my (@ref_Vint,@ref_Tnew);
  my ($wbox,$hbox,$xbox,$ybox);	
  my ($xgraph_first_vel ,$xgraph_last_vel);
  my (@sorted_suffix,@plot_prefix);
  my (@suffix);
  my (@vpicks_stdin,@vint_std);
  my (@sortfile_in, @sortfile_out);
  my (@write_fileout,@Vint_outbound);
  my (@Vint_plot,@Time_plot);
  my (@flow,@xgraph,@a2b,@sort);
  my (@geometry);
  my ($Time_plot,$Vint_plot,$num_points_Vint_plot);
  my ($i,$j);
  my (@inbound);
  my (@sufile_in);
  my (@Vrmsfile_in, @Vrms_read_file);
  my (@Vint_plot_outbound );
  my ($num_points_Vint);
  my (@mkparfile,@parfile_out);
  my (@outbound);

  my ($PL_SEISMIC) 		= $Project->PL_SEISMIC();
  my ($date)            = $Project->date();
  use SeismicUnix qw ($on $off $in $out $to $go);

=head2  some SUB-STEPS in Vrms2Vint:


 1. sort i/p 'ivpicks_old'.'_'.$sufile_in[1].$suffix[3]
          o/p ivpicks_old'.'_'.'sorted'.'_'.$sufile_in[1].$suffix[3]

 2. convert rms to int 
          i/p 'ivpicks_old'.'_'.'sorted'
          o/p 'ivint_old'.'_'.$sufile_in[1].$suffix[3];

 3. generate a data file for plotting
          o/p 'plot'.'_'.'ivint_old'.'_'.$sufile_in[1].$suffix[3];

=cut 

  $cdp_num[1]	   		= $iVrms2Vint->{_cdp_num};
  #print("CDP in iVrms2Vint=$iVrms2Vint->{_cdp_num}\n\n");
# suffixes
  $plot_prefix[1]		= '.plot';
   $suffix[3]			= '_cdp'.$iVrms2Vint->{_cdp_num};

# su file names
   $sufile_in[1] 		= $iVrms2Vint->{_file_in};

#V file names
   $vpicks_stdin[1]        	= 'ivpicks_old';
   $vint_std[1]			= 'ivint_old';

# sort file names
   $sortfile_in[1] 		= 'ivpicks_old';
   $sortfile_out[1] 		= 'ivpicks_old'.'_'.'sorted';
   $inbound[1]	  		= $PL_SEISMIC.'/'.'ivpicks_old'.'_'.$sufile_in[1].$suffix[3];
  $outbound[1]	  		= $PL_SEISMIC.'/'.'ivpicks_old'.'_'.'sorted'.'_'.$sufile_in[1].$suffix[3];

# RMS Velocity file names
   $Vrmsfile_in[1] 		= 'ivpicks_old'.'_'.'sorted';
   $Vrms_read_file[1]		= $PL_SEISMIC.'/'.$Vrmsfile_in[1].'_'.$sufile_in[1].$suffix[3];

# a2b file names
   $num_samples_file[1]		= '.num_samples_Vrms_Vint';
   $num_sample_cols[1]		= 2;

# Interval Velocity write file names
  $Vint_outbound[1]  		= $PL_SEISMIC.'/'.'ivint_old'.'_'.$sufile_in[1].$suffix[3];

# plot file names
   $Vint_plot_outbound[1]	= $PL_SEISMIC.'/'.'plot'.'_'.'ivint_old'.'_'.$sufile_in[1].$suffix[3];
	
=head2 SORT a TEXT FILE

  
=cut

  	  $sort[1] 	=  (" sort 				\\
			-n					\\
			");
	 @items   = ($sort[1],$in,$inbound[1],$out,$outbound[1]);
         $flow[1] = $run->modules(\@items); 


=head2  RUN FLOW(S)

  Must run this flow BEFORE covnerting Vrms to Vint
 TOD create an individual sort package

=cut
 	$run -> flow(\$flow[1]);

=head2  LOG FLOW(S)TO SCREEN AND FILE


=cut

 #print  "$flow[1]\n";
 #$log->file($flow[1]);



=head2 TEXT to BINARY CONVERSION


=cut

	$a2b -> clear();
	$a2b -> outpar($num_samples_file[1]);
	$a2b -> floats_per_line($num_sample_cols[1]);
  	$a2b[1] =  $a2b->Step();
  	#print("first a2b is  $a2b[1]\n\n");

=head2 

 read Vrms file
  i/p 
    'ivpicks_old'.'_'.'sorted'.'_'.$sufile_in[1].$suffix[3];

=cut

    ($ref_T,$ref_Vrms,$num_points_Vrms) = $files->read_2cols(\$Vrms_read_file[1]);
	 #print("\ntime=$$ref_T[1]\nVrms=$$ref_Vrms[1]\nn=$num_points_Vrms \n");

=head2  CONVERT VRMS to VINT FILE


=cut
   	
	 ($ref_Vint,$ref_Tnew,$num_points_Vint) = $seismics->Vrms2Vint($ref_T,$ref_Vrms,$num_points_Vrms);
	#print("Vint num points out is $num_points_Vint\n");
	for ($i=1; $i<=$num_points_Vint; $i++) {
		#print("\n$$ref_Vint[$i]\n");
		#print("\n$$ref_Tnew[$i]\n");
	}

=head2  CREATE PLOTTING VALUES

 normally, first time i value is  >0

=cut

	 if($$ref_Tnew[1] > 0.) {
		$Time_plot[1] = 0;
 		$Vint_plot[1] = $$ref_Vint[1];
		for ($i=1; $i<$num_points_Vint; $i++) {
			$j		   = 2 * $i;
			$Time_plot[$j]     = $$ref_Tnew[$i];
			$Time_plot[$j+1]   = $$ref_Tnew[$i];
			$Vint_plot[$j]     = $$ref_Vint[$i];
			$Vint_plot[$j+1]   = $$ref_Vint[$i+1];
		}
		$num_points_Vint_plot = $j+1;
	 }	
		
	 if($$ref_Tnew[1] == 0.) {
		$Time_plot[1] = 0;
 		$Vint_plot[1] = $$ref_Vint[1];
		for ($i=2; $i<=$num_points_Vint; $i++) {
		        $j		   = 2 * $i;
			$Time_plot[$j]     = $$ref_Tnew[$i];
			$Time_plot[$j+1]   = $$ref_Tnew[$i];
			$Vint_plot[$j]     = $$ref_Vint[$i];
			$Vint_plot[$j+1]   = $$ref_Vint[$i];
		}
		 $num_points_Vint_plot = $j+1;
	  }	

=head2 write Vint
		
 file for plotting

=cut
        $format[1] = '%10.3f  %10.3f';
        #print("num points in Vint plot are/is $num_points_Vint_plot\n\n");
    	$files->write_2cols(\@Time_plot,\@Vint_plot,$num_points_Vint_plot,\$Vint_plot_outbound[1],\$format[1]);

=head2 XGRAPH FILE(s)	


=cut
 	$wbox		= 550;
 	$hbox		= 450;
 	$xbox   	= 600;
	$ybox   	= 600;	

 	$geometry[1]    = $wbox.'x'.$hbox.'+'.$xbox.'+'.$ybox;
        #print(" geometry is quotemeta($geometry[1])\n\n"); 

	$xgraph_first_vel = $iVrms2Vint->{_first_velocity};
	$xgraph_last_vel  = $iVrms2Vint->{_first_velocity} + $iVrms2Vint->{_number_of_velocities} * $iVrms2Vint->{_velocity_increment};

        my $num_points_per_plot = $num_points_Vrms.','.$num_points_Vint_plot;
        $xgraph -> clear();
        $xgraph -> num_points($num_points_per_plot);
        $xgraph -> x1_min(0);
        $xgraph -> x1_max($iVrms2Vint->{_tmax_s});
        $xgraph -> x2_min($xgraph_first_vel);
        $xgraph -> x2_max($xgraph_last_vel);
        $xgraph -> windowtitle($sufile_in[1].' '.$date.' '.$suffix[3]);
        $xgraph -> title($Vrmsfile_in[1].'Vrms\(Green\)Vint\(Red\)');
        $xgraph ->grid1_type('solid');
        $xgraph ->grid2_type('solid');
        $xgraph ->mark_indices('0,8');
        $xgraph ->mark_size_pix('12,8');
        $xgraph ->box_width($wbox);
        $xgraph ->box_height($hbox); 
	$xgraph ->geometry($geometry[1]);
	$xgraph ->label1('Time\(sec\)');
	$xgraph ->label2('Velocity\(m/s\)');
	$xgraph ->line_widths('2,2');
	$xgraph ->line_color('3,2');
	$xgraph ->axes_style('seismic');
	$xgraph[1] = $xgraph ->Step();

=head2 DEFINE FLOW(S)
 

=cut 
        @items = ("cat"," ",$Vrms_read_file[1],
                       " ",$Vint_plot_outbound[1],$to,
                       $a2b[1],$to,$xgraph[1],$go);
	$flow[2] = $run->modules(\@items);

=head2 RUN FLOW(S)


=cut
 	$run -> flow(\$flow[2]);

=head2 LOG FLOW(S)

  TO SCREEN AND FILE

=cut

 #print  "$flow[2]\n";
 #$log->file($flow[2]);

=head2 WRITE OUTPUT FILE

 write Vint file 

=cut
    	$files->write_2cols($ref_T,$ref_Vint,$num_points_Vint,\$Vint_outbound[1],\$format[1]);
}
# END calcNdisplay 


=head2 subroutine file_in

 Required file name
 on which to perform velocity analyses 

=cut

sub file_in {
    my ($variable,$file_in) 	= @_;
    $iVrms2Vint->{_file_in} 		= $file_in if defined($file_in); 
    #print("file name is $iVrms2Vint->{_file_in} \n\n");
}



=head2 subroutine first_velocity


=cut

sub first_velocity {
    my ($variable,$first_velocity) 	= @_;
    $iVrms2Vint->{_first_velocity} 		= $first_velocity if defined($first_velocity); 
    #print("first velocity is $iVrms2Vint->{_first_velocity} \n\n");
}



=head2 subroutine number_of_velocities


=cut

sub  number_of_velocities{
    my ($variable,$number_of_velocities) 	= @_;
    $iVrms2Vint->{_number_of_velocities} 		= $number_of_velocities if defined $number_of_velocities; 
    #print(" number_of_velocities is $iVrms2Vint->{_number_of_velocities} \n\n");
}


=head2 subroutine tmax_s


=cut

sub  tmax_s {
 my ($self, $tmax_s)        = @_;
    if ($tmax_s) {
       $iVrms2Vint->{_tmax_s}  	= $tmax_s;
     }
}

=head2 subroutine velocity increment 


=cut

sub velocity_increment {
    my ($variable,$velocity_increment) 		= @_;
    $iVrms2Vint->{_velocity_increment} 		= $velocity_increment if defined($velocity_increment); 
    #print("velocity_increment is $iVrms2Vint->{_velocity_increment} \n\n");
}


1;
