package iSunmo;

=head1 DOCUMENTATION

=head2 SYNOPSIS

  PCKAGE NAME: iSunmo

  Purpose:  interactive sunmo
  AUTHOR:  Juan M. Lorenzo
  DEPENDS: Seismic Unix modules from CSM 
  DATE:    April 2 2009
  DESCRIPTION:    Moveout data
  MODIFIED  
            July 24 2015   now uses oop


=head2 NOTES 
  
=head2 INSTANTIATE PACKAGES 


=cut

 use Moose;
 use Project;
 use SeismicUnix qw ($on $off $in $to $go);
 use flow;
 use sufilter;
 use sugain;
 use susort;
 use sunmo;
 use suwind; 
 use suxwigb;
 use suximage;

=head2

 inherit other packages
   1. Instantiate classes 
       Create a new version of the package
       Personalize to give it a new name if you wish
     Use the following classes:

=cut

  my $run    			= new flow();
  my $sufilter			= new sufilter();
  my $sugain			= new sugain();
  my $susort			= new susort();
  my $sunmo             = new sunmo;
  my $suwind            = new suwind;
  my $suxwigb			= new suxwigb();
  my $suximage			= new suximage();
  my $Project           = new Project();
  my ($DATA_SEISMIC_SU) = $Project->DATA_SEISMIC_SU();
  my ($PL_SEISMIC)      = $Project->PL_SEISMIC();

 
=head2
 
 establish just the localally scoped variables

=cut
my (@parfile_in,@sufile_in,@suffix,@inbound,@cdp_num);
my (@suwind_min,@suwind_max,@vel_in);
my (@items,@flow,@sugain,@sufilter,@suwind,@susort);
my (@sunmo,@suximage);
my (@windowtitle,@mute_picks_file,@base_caption);
my $time_inc_minor;
my $time_inc_major;
my $number_minor_time_divisions ;
my @suximage_col_bar_max ;
my @suximage_col_bar_min;
my $N;

=head2


  hash array of important variables used within
  this package

=cut 

 my $iSunmo = {
      _cdp_num                	=> '',
      _file_in                	=> '',
      _freq                   	=> '',
      _inbound                	=> '',
      _sufile_in              	=> '',
      _textfile_in            	=> '',
      _textfile_out           	=> '',
      _tmax_s               	=> '',
    };

=head2

 subroutine clear 
         to blank out hash array values

=cut

 sub clear {
     $iSunmo->{_cdp_num }      	= '';
     $iSunmo->{_file_in}        = '';
     $iSunmo->{_freq}        	= '';
     $iSunmo->{_inbound}      	= '';
     $iSunmo->{_sufile_in}      = '';
     $iSunmo->{_textfile_in}    = '';
     $iSunmo->{_tmax_s}   	= '';
    }


=head2

 subroutine cdp_num
  establishes the CDP number being worked
  Also establishes'cdp'# as a recognizable suffix
  for file names

=cut

sub  cdp_num {
 my ($variable, $cdp_num)          = @_;
    $iSunmo->{_cdp_num_suffix}   = '_cdp'.$cdp_num if defined($cdp_num);
    $iSunmo->{_cdp_num}          = $cdp_num if defined($cdp_num);
     }

=head2

 subroutine file_in
   gets the file name
   creates the sufile name to read
   creates the full path for reading the sufile

=cut

sub  file_in {
 my ($variable, $file_in)        = @_;
    $iSunmo->{_file_in}        = $file_in       if defined($file_in);
    $iSunmo->{_sufile_in}       = $file_in.'.su' if defined($file_in);
    $iSunmo->{_inbound} 	  = $DATA_SEISMIC_SU.'/'.$iSunmo->{_sufile_in}; 
    #print("iSunmo_inbound is $iSunmo->{_inbound}\n\n");
     }


=head2

 subroutine freq
  creates the bandpass frequencies to filter data before
  conducting semblance analysis
  e.g., "3,6,40,50"
 
=cut


sub  freq {
 my ($variable, $freq)         = @_;
    $iSunmo->{_freq}        = $freq       if defined($freq);
     }

=head2 subroutine calcNdisplay

  calculate semblance and display results 

=cut



sub calcNdisplay { 

 #print(" calc and display\n\n");
# suffixes
  $suffix[1]			= '_cdp'.$iSunmo->{_cdp_num};

# su file names
  $sufile_in[1] 		= $iSunmo->{_file_in};
  $parfile_in[1] 		= 'ivpicks_sorted_par_'.$sufile_in[1].$suffix[1];
  $inbound[1]	  		= $DATA_SEISMIC_SU.'/'.$sufile_in[1].'.su';

# SUWIND data cdp
  $suwind_min[1] 		= $iSunmo->{_cdp_num};
  $suwind_max[1] 		= $iSunmo->{_cdp_num};

# par file names
  $vel_in[1] 	 		= $PL_SEISMIC.'/'.$parfile_in[1];


=head2

 WINDOW  DATA by  shot point

=cut

 $suwind_min[1] 	= $iSunmo->{_cdp_num};
 $suwind_max[1] 	= $iSunmo->{_cdp_num};

 $suwind   		-> clear();
 $suwind   		-> setheaderword('cdp');
 $suwind   		-> min($suwind_min[1]);
 $suwind   		-> max($suwind_max[1]);
 $suwind[1] 		 = $suwind->Step();


=head2

 WINDOW  DATA by time 

=cut

 $suwind   -> clear();
 $suwind   -> tmin(0);
 $suwind   -> tmax($iSunmo->{_tmax_s});
 $suwind[2] = $suwind->Step();

# SORT data into CDP before calcualting semblance
 $susort   -> clear();
 $susort   -> headerword('cdp');
 $susort   -> headerword('offset');
 $susort[1] = $susort->Step();

=head2

 GAIN DATA

=cut

 $sugain     -> clear();
 $sugain     -> pbal($on);
 $sugain[1]   = $sugain->Step();

 $sugain     -> clear();
 $sugain     -> agc($on);
 $sugain     -> width(0.1);
# $sugain     -> setdt(1000);
 $sugain[2]   = $sugain->Step();

 $sugain     -> clear();
 $sugain     -> tpower(3);
 $sugain[3]   = $sugain->Step();

=head2

  set filtering parameters 

=cut

 $sufilter    -> clear();
 $sufilter    -> freq($iSunmo->{_freq});
 $sufilter[1]  = $sufilter->Step();

=head2

 sub sunmo  
   moves out the data

=cut

 $sunmo         -> clear();
 $sunmo         -> par($vel_in[1]);
 $sunmo         -> smute(3); #300% max. stretch allowed 
 $sunmo[1]       = $sunmo ->Step();

=head2

 DISPLAY DATA

=cut

 $time_inc_minor	  =  0.1;
 $time_inc_major 	  =  0.2;
 $number_minor_time_divisions =  $time_inc_major/$time_inc_minor;
 $suximage_col_bar_max[1] = .5;
 $suximage_col_bar_min[1] = 0;
 $base_caption[1]	     ="f=$iSunmo->{_freq}";
 $mute_picks_file[1]       = '.itemp_mute_picks_'.$sufile_in[1];

$N=3;
   $windowtitle[1]		 ='\('.$N.'\)\ '.$iSunmo->{_sufile_in}.'\ CDP=\ '.$iSunmo->{_cdp_num};

 $suximage -> clear();
 $suximage -> box_width(300);    
 $suximage -> box_height(450);    
 $suximage -> box_X0(1200);    
 $suximage -> box_Y0(0);    
 $suximage -> title($base_caption[1]);    
 $suximage -> windowtitle($windowtitle[1]);    
 $suximage -> ylabel("TWTT-s");    
 $suximage -> xlabel("tracl");    
 $suximage -> legend($on);    
 $suximage -> cmap('hsv2');    
 $suximage -> first_x(1);  #d2=1,f2=1
 $suximage -> dx(1);
 $suximage -> loclip($suximage_col_bar_max[1]);
 $suximage -> hiclip($suximage_col_bar_min[1]);
 $suximage -> verbose($off);
 #$suximage -> dx_major_divisions(($iSunmo->{_velocity_increment}*10));
 #$suximage -> dy_minor_divisions($number_minor_time_divisions); 
 #$suximage -> dy_major_divisions($time_inc_major);
 #$suximage -> percent4clip(95.0);
 #$suximage -> first_tick_number_x($iSunmo->{_first_velocity});
 # $suximage -> picks(\$iSunmo->{_Tvel_outbound});
 #print("Writing picks to $iSunmo->{_Tvel_outbound}\n\n");

 $suximage[1]  = $suximage -> Step();


=head2
 
  DEFINE FLOW(S)
  in interactive mode:
  first time you see the image number_of_tries =0
  The image is not connected to flow
  second, third, etc. times number_of_tries >0
  The image halts the flow

=cut

   @items   = ($susort[1],$in,$iSunmo->{_inbound},$to,$suwind[1],$to,$suwind[2],
             $to,$sunmo[1],$to,$sufilter[1],$to,$sugain[1],$to,$sugain[2],$to,$suximage[1],$go);
   $flow[1] = $run->modules(\@items);

=head2

  RUN FLOW(S)
  output copy of picked data points
  only occurs after the number of tries
  is updated

=cut

  $run -> flow(\$flow[1]);

=head2

  LOG FLOW(S)TO SCREEN AND FILE

=cut

  #print  "$flow[1]\n";
 #$log->file($flow[1]);
}
 # end of calc_display subroutine


=head2 subroutine tmax_s


=cut

sub  tmax_s {
 my ($self, $tmax_s)        = @_;
    if ($tmax_s) {
       $iSunmo->{_tmax_s}  	= $tmax_s;
     }
}


=head2 

 subroutine  TV pick file in

=cut

sub  Tvel_inbound{
    my ($variable,$Tvel_inbound) 	= @_;
    $iSunmo->{_Tvel_inbound} 		= $Tvel_inbound if defined $Tvel_inbound; 
}

#end of iSunmo
1;

