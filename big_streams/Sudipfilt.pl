#! /usr/local/bin/perl

=pod

=head1 DOCUMENTATION

=head2 SYNOPSIS

  PROGRAM NAME: Sudipfilt.pl
  Purpose: f-k spectral analysis 
  AUTHOR:  Juan M. Lorenzo
  DEPENDS: Seismic Unix modules from CSM 
  DATE:    Feb 15 2008 V0.1
           V0.2 June 30 2016 make oop
  DESCRIPTION:  based upon non-oop Xamine.pl  

=head2 USES

 (for subroutines) 
     manage_files_by 

     (for variable definitions)
     SeismicUnix (Seismic Unix modules)

 use SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su); 

=head2 USAGE
 
 Sucat 

=head2 NEEDS 
 

=head2 EXAMPLES 
 
=head2 NOTES 

 We are using moose 
 moose already declares that you need debuggers turned on
 so you don't need a line like the following:

 use warnings;

 
  sample rate = 125 us
  d1 = sample rate in ms = .000125

=cut

	use Moose;
	our $VERSION = '1.0.2';
 	use flow;
 	use message;
 	use sudipfilt;
 	use Sudipfilt_config;
 	use suspecfk;
 	use suxwigb;
 	use suximage;
 	use sugain;
 	use sufilter;
 	use suwind;
 	use readfiles;
	use SeismicUnixPlTk_global_constants;
	
	use SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su);
	
=head2 Instantiate classes

     Create a new version of the package
     Personalize to give it a new name if you wish

     Use classes:
     flow
     log
     message
     sufilter
     sugain
     sureduce
     suspecfkp
     suxwigb
     suximage
     sudipfilt

=cut

	my $get				  	= new SeismicUnixPlTk_global_constants();
  	my $log 				= new message();
  	my $run    				= new flow();
 	my $sudipfilter			= new sudipfilt();
 	my $Sudipfilt_config	= new Sudipfilt_config();
  	my $suspecfk			= new suspecfk();
  	my $suxwigb				= new suxwigb();
  	my $suximage			= new suximage();
  	my $sufilter			= new sufilter();
  	my $sugain				= new sugain();
  	my $suwind				= new suwind();
  	my $read				= new readfiles();

=head2 use local libAll too

  print("Sudipfilt,HOME=$CFG_h->{Project_Variables}{1}{HOME}\n");

=cut
 
  	my (@flow,@sufile_out,@inbound,@outbound);
  	my (@suxwigb,@sufilter,@suximage,@sugain,@items,@suspecfk);
  	my (@sudipfilter,@suwind);
  	my ($sufile_in);

=head2 Get configuration information

=cut

	my ($CFG_h,$CFG_aref) 			= $Sudipfilt_config->get_values();
	
=head2 TOP LEFT PLOT

  includes sugain variables

=cut

  my $TOP_LEFT_sugain_pbal_switch 		= $CFG_h->{TOP_LEFT}{sugain}{pbal_switch};
  my $TOP_LEFT_sugain_agc_switch 		= $CFG_h->{TOP_LEFT}{sugain}{agc_switch};
  my $TOP_LEFT_sugain_agc_width 		= $CFG_h->{TOP_LEFT}{sugain}{agc_width};

  my $BOTTOM_RIGHT_suximage_absclip 	= $CFG_h->{BOTTOM_RIGHT}{suximage}{absclip};

  my $sudipfilter_1_dt					= $CFG_h->{sudipfilter}{1}{dt} ;
  my $sudipfilter_1_dx					= $CFG_h->{sudipfilter}{1}{dx}   ;
  my $sudipfilter_1_slopes				= $CFG_h->{sudipfilter}{1}{slopes} ;
  my $sudipfilter_1_bias				= $CFG_h->{sudipfilter}{1}{bias};
  my $sudipfilter_1_amps				= $CFG_h->{sudipfilter}{1}{amps};

  my $sudipfilter_2_dt					= $CFG_h->{sudipfilter}{2}{dt} ;
  my $sudipfilter_2_dx					= $CFG_h->{sudipfilter}{2}{dx}  ; 
  my $sudipfilter_2_slopes				= $CFG_h->{sudipfilter}{2}{slopes} ;
  my $sudipfilter_2_bias				= $CFG_h->{sudipfilter}{2}{bias};
  my $sudipfilter_2_amps				= $CFG_h->{sudipfilter}{2}{amps};

  my $suwind_1_tmin						= $CFG_h->{suwind}{1}{tmin};
  my $suwind_1_tmax						= $CFG_h->{suwind}{1}{tmax};

  my $suwind_2_min						= $CFG_h->{suwind}{2}{min};
  my $suwind_2_max						= $CFG_h->{suwind}{2}{max};
  my $suwind_2_key						= $CFG_h->{suwind}{2}{key};

  my $sufilter_1_freq					= $CFG_h->{sufilter}{1}{freq};
  my $sufilter_1_amplitude				= $CFG_h->{sufilter}{1}{amplitude};

  my $suspecfk_1_dt						= $CFG_h->{suspecfk}{1}{dt};
  my $suspecfk_1_dx						= $CFG_h->{suspecfk}{1}{dx};
  
  my $file_in							= $CFG_h->{data_name};
  my $inbound_directory  				= $CFG_h->{inbound_directory};

  				# print("2. Sudipfilt,inbound_directory : $inbound_directory\n\n");
  				 
=head2 Declare file names 

=cut

  $sufile_in            	= $file_in.$suffix_su;
  $sufile_out[1] 			= $file_in.'_fk'.$suffix_su;
  $inbound[1]  		    	= $inbound_directory.'/'.$sufile_in;
  $outbound[1]  			= $inbound_directory.'/'.$sufile_out[1];

=head2 sugain
  
 Set gain variables for TOP LEFT PLOT

=cut

 	if($TOP_LEFT_sugain_pbal_switch eq $on) {
 		
 		$sugain     	-> clear();
 		$sugain     	-> pbal($TOP_LEFT_sugain_pbal_switch);
 		$sugain[1]   	= $sugain->Step();

 	} else {

 		$sugain     	-> clear();
 		$sugain     	-> agc($TOP_LEFT_sugain_agc_switch);
 		$sugain     	-> width($TOP_LEFT_sugain_agc_width);
		# $sugain     	-> setdt(1000);
 		$sugain[1]   	= $sugain->Step();
 	}

=head2 sufilter
  
 Set frequency filter ing parameters

=cut

 	$sufilter    -> clear();
 	$sufilter    -> freq($sufilter_1_freq);
 	$sufilter    -> amplitude($sufilter_1_amplitude);
 	$sufilter[1]  = $sufilter->Step();

=head2 suwind
  
 Set windowing parameters

=cut


=head2 Window 
   
   by time

=cut

 $suwind      ->clear();
 $suwind      ->tmin($suwind_1_tmin);
 $suwind      ->tmax($suwind_1_tmax);
 $suwind[1]   = $suwind->Step();


=head2  Window 
   
   by field record 

=cut

 $suwind      -> clear();
 $suwind      -> key($suwind_2_key);
 $suwind      -> min($suwind_2_min);
 $suwind      -> max($suwind_2_max);
 $suwind[2]    =  $suwind->Step();

=head2 f-k analysis 

  make non-dimensional 

=cut

 $suspecfk      -> clear();
 $suspecfk      -> dt($suspecfk_1_dt);
 $suspecfk      -> dx($suspecfk_1_dx);
 $suspecfk[1]   =  $suspecfk-> Step();

=head2 TODO linear moveout 

# LINEAR MOVEOUT 
	@sureduce[1] =  (" sureduce 	            		\\
			rv=1.5					\\
               ");

# LINEAR MOVEOUT 
	@sureduce[2] =  (" sureduce 	            		\\
			rv=-1.5					\\
               ");

=cut

=head2 Dip filter 

  set parameters 

=cut

 $sudipfilter      -> clear();
 $sudipfilter      -> dt($sudipfilter_1_dt);
 $sudipfilter      -> dx($sudipfilter_1_dx);
 $sudipfilter      -> slopes($sudipfilter_1_slopes);
 $sudipfilter      -> bias($sudipfilter_1_bias);
 $sudipfilter      -> amps($sudipfilter_1_amps);
 $sudipfilter[1]   = $sudipfilter-> Step();

=head2 Dip filter 

  set parameters 

=cut

 $sudipfilter      -> clear();
 $sudipfilter      -> dt($sudipfilter_2_dt);
 $sudipfilter      -> dx($sudipfilter_2_dx);
 $sudipfilter      -> slopes($sudipfilter_2_slopes);
 $sudipfilter      -> bias($sudipfilter_2_bias);
 $sudipfilter      -> amps($sudipfilter_2_amps);
 $sudipfilter[2]   = $sudipfilter-> Step();

=head2 DISPLAY DATA as wiggles

  Set parameters

=cut

 $suxwigb-> clear(); 
 $suxwigb-> title($sufile_in); 
 $suxwigb-> windowtitle('RAW'); 
 $suxwigb-> xlabel('No .traces');  
 $suxwigb-> ylabel('No. samples'); 
 $suxwigb-> box_width(300); 
 $suxwigb-> box_height(370);
 $suxwigb-> dt(1); 
 $suxwigb-> dx(1); 
 $suxwigb-> x_tick_increment(20);
 $suxwigb-> first_time_sample_value(1); 
 #$suxwigb-> first_distance_sample_value(0); 
 $suxwigb-> box_X0(370); 
 $suxwigb-> box_Y0(0); 
 $suxwigb-> absclip(25);
 $suxwigb-> xcur(3);
 $suxwigb-> va(1);
 $suxwigb-> num_minor_ticks_betw_distance_ticks(1);
 $suxwigb[1] = $suxwigb->Step();
 #$suxwigb-> wigclip(1);
 
=head2 DISPLAY DATA as wiggles

  Set parameters

=cut

 $suxwigb-> clear(); 
 $suxwigb-> title($sufile_in); 
 $suxwigb-> windowtitle(quotemeta('Dip-filtered')); 
 $suxwigb-> xlabel(quotemeta('No. traces'));  
 $suxwigb-> ylabel(quotemeta('No. samples')); 
 $suxwigb-> box_width(300); 
 $suxwigb-> box_height(370);
 $suxwigb-> box_X0(370); 
 $suxwigb-> box_Y0(440); 
 $suxwigb-> dt(1); 
 $suxwigb-> dx(1); 
 $suxwigb-> first_time_sample_value(1); 
 $suxwigb-> first_distance_sample_value(1); 
 $suxwigb-> absclip(30);
 $suxwigb-> xcur(3);
 $suxwigb-> va(1);
 $suxwigb-> num_minor_ticks_betw_distance_ticks(1);
 $suxwigb-> x_tick_increment(20);
 $suxwigb[5] = $suxwigb->Step();

=head2 DISPLAY DATA as IMAGE

  Set parameters

=cut

 $suximage-> clear(); 
 $suximage-> title($sufile_in); 
 $suximage-> box_width(300); 
 $suximage-> box_height(370); 
 $suximage-> box_X0(0); 
 $suximage-> box_Y0(0); 
 $suximage-> tstart_s(0.5); 
 $suximage-> tend_s(0); 
 $suximage-> num_minor_ticks_betw_distance_ticks(1); 
 $suximage-> x_tick_increment(0.2); 
 $suximage-> first_distance_tick_num(-0.5); 
 $suximage-> num_minor_ticks_betw_time_ticks(1); 
 $suximage-> y_tick_increment(0.1); 
 $suximage-> xlabel(quotemeta('Frequency Hz dt=1 Nf=0.5')); 
 $suximage-> ylabel(quotemeta('k 1/m dx=1 Nk=0.5')); 
 $suximage-> absclip(1000);
 $suximage-> style('seismic');
 #$suximage-> wigclip(1);
 $suximage-> windowtitle(quotemeta('f-k analysis'));
 $suximage[1]  = $suximage->Step();

=head2 DISPLAY DATA as IMAGE

  Set parameters

=cut
	
 $suximage-> clear(); 
 $suximage-> title($sufile_in); 
 $suximage-> xlabel(quotemeta('No. traces'));  
 $suximage-> ylabel(quotemeta('Time s')); 
 $suximage-> box_width(300); 
 $suximage-> box_height(370); 
 $suximage-> box_X0(670); 
 $suximage-> box_Y0(0); 
 #$suximage-> tstart_s(0.5); 
 #$suximage-> tend_s(0); 
 $suximage-> num_minor_ticks_betw_distance_ticks(1); 
 $suximage-> x_tick_increment(5); 
 #$suximage-> first_distance_tick_num(-0.5); 
 #$suximage-> num_minor_ticks_betw_time_ticks(1); 
 $suximage-> y_tick_increment(1); 
 #$suximage-> label1('Frequency (Hz) dt=1 Nf=0.5'); 
 $suximage-> absclip(3);
 #$suximage-> style('seismic');
 #$suximage-> wigclip(1);
 #$suximage-> windowtitle("filtered_data");
 $suximage[2]  = $suximage->Step();#

=head2 DISPLAY DATA as IMAGE

  Set parameters

=cut

 $suximage-> clear(); 
 $suximage-> title($sufile_in); 
 $suximage-> box_width(300); 
 $suximage-> box_height(370); 
 $suximage-> box_X0(0); 
 $suximage-> box_Y0(440); 
 $suximage-> tstart_s(0.5); 
 $suximage-> tend_s(0); 
 $suximage-> num_minor_ticks_betw_time_ticks(1); 
 $suximage-> num_minor_ticks_betw_distance_ticks(1); 
 $suximage-> x_tick_increment(0.2); 
 $suximage-> first_distance_tick_num(-0.5); 
 $suximage-> y_tick_increment(0.1); 
 $suximage-> ylabel(quotemeta('Frequency (Hz) dt=1 Nf=0.5')); 
 $suximage-> xlabel(quotemeta('k (1/m) dx=1 Nk=0.5')); 
 #$suximage-> absclip(30);
 #$suximage-> style('seismic');
 #$suximage-> wigclip(1);
 $suximage-> windowtitle(quotemeta('Dip-filtered'));
 $suximage[4]  = $suximage->Step();

=head2 DISPLAY DATA as IMAGE

  Set parameters

=cut

 $suximage-> clear(); 
 $suximage-> title($sufile_in); 
 $suximage-> xlabel(quotemeta('No. traces'));  
 $suximage-> ylabel(quotemeta('Time (s)')); 
 $suximage-> box_width(300); 
 $suximage-> box_height(370); 
 $suximage-> box_X0(670); 
 $suximage-> box_Y0(440); 
 #$suximage-> tstart_s(0); 
 #$suximage-> tend_s(26.5); 
 $suximage-> num_minor_ticks_betw_distance_ticks(1); 
 $suximage-> x_tick_increment(5); #0.2 
 #$suximage-> first_distance_tick_num(-0.5); 
 #$suximage-> num_minor_ticks_betw_time_ticks(1); 
 $suximage-> y_tick_increment(1); 
 #$suximage-> dt(0.001); 
 $suximage-> first_time_sample_value(0); 
 $suximage-> absclip($BOTTOM_RIGHT_suximage_absclip);
 #$suximage-> style('seismic');
 #$suximage-> wigclip(1);
 #$suximage-> windowtitle("filtered_data");
 $suximage[6]  = $suximage->Step();

=head2
 
  Standard:
  1. DEFINE FLOW(S)

=cut

 @items   = ($suwind[1],$in,$inbound[1],$to,
             $suwind[2],$to,$sugain[1],$to,$sufilter[1],
             $to,$suspecfk[1],$to,$suximage[1],$go);
 $flow[1] = $run->modules(\@items);

 @items   = ($suwind[1],$in,$inbound[1],$to,
             $suwind[2],$to,$sugain[1],$to,$sufilter[1],
             $to,$suxwigb[1],$go);
 $flow[2] = $run->modules(\@items);

 @items   = ($suwind[1],$in,$inbound[1],$to,
             $suwind[2],$to,$sugain[1],$to,$sufilter[1],
             $to,$suximage[2],$go);
 $flow[3] = $run->modules(\@items);

 @items   = ($suwind[1],$in,$inbound[1],$to,
             $suwind[2],$to,$sugain[1],$to,$sufilter[1],
             $to,$sudipfilter[1],
             $to,$sudipfilter[2],$to,$suspecfk[1],$to,$suximage[4],$go);
 $flow[4] = $run->modules(\@items);

 @items   = ($suwind[1],$in,$inbound[1],$to,
             $suwind[2],$to,$sugain[1],$to,$sufilter[1],
		$to,$sudipfilter[1],
             	$to,$sudipfilter[2],$to,$sugain[1],$to,$suxwigb[5],$go);
 $flow[5] = $run->modules(\@items);

 @items   = ($suwind[1],$in,$inbound[1],$to,
             $suwind[2],$to,$sufilter[1],
		$to,$sudipfilter[1],
             	$to,$sudipfilter[2],$to,$sugain[1],$to,$suximage[6],$go);
 $flow[6] = $run->modules(\@items);
#$sugain[1],$to,

 @items   = ($suwind[1],$in,$inbound[1],$to,
             $suwind[2],$to,$sufilter[1],$to,$sudipfilter[1],
             $to,$sudipfilter[2],$out,$outbound[1],$go);
 $flow[7] = $run->modules(\@items);
#$sugain[1],$to,

=pod

  2. RUN FLOW(S)

=cut

 # $run->flow(\$flow[1]);
 #$run->flow(\$flow[2]);
 #$run->flow(\$flow[3]);
 #$run->flow(\$flow[4]);
 #$run->flow(\$flow[5]);
 #$run->flow(\$flow[6]);
 #$run->flow(\$flow[7]);

=pod

  3. LOG FLOW(S)TO SCREEN AND FILE

=cut

 print  "$flow[1]\n";
#$log->file($flow[1]);

# print  "$flow[2]\n";
#$log->file($flow[2]);

# print  "$flow[3]\n";
#$log->file($flow[3]);

# print  "$flow[4]\n";
#$log->file($flow[4]);

# print  "$flow[5]\n";
#$log->file($flow[5]);

# print  "$flow[6]\n";
#$log->file($flow[6]);

# print  "$flow[7]\n";
#$log->file($flow[7]);
