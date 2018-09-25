package iSurf4;

=head1 DOCUMENTATION
=head2 SYNOPSIS

	PACKAGE NAME: 	iSurf4.pm
	Purpose: 	interactive Dispersion Curve
	AUTHOR:  	Juan Lorenzo	
	DATE:           January 26 2017		
	DESCRIPTION:	Version 1.0
			
=head2 Uses

=head2 DESCRIPTION:
 tau-p info
 "p"     "p"  "p"
  m/s     km/s    s/km  s/m
  2000    2       0.5   .0005   
  1500    1.50    0.666 .000666
  330     0.33    3.03  .00303 
  200     0.20    5.0   .005    
  100     0.10   10.0   .01     
   50     0.05   20.0   .02     
  infinity inf    0.0    .0 

=head2 STEPS

  1) convert X-T data to P-Tau data
  2) fft(p-tau) ---> p-freq data
  3) extract rms(frequency) $ each p
  4) normalize p-freq data against rms
  5) pick p-freq data
  6) invert p-freq data
  7) mute tau-p data
  8) mute f-p data

=head2 Create hash

  of shared, common, variables
=cut


 my $iSurf4 = {
          	_binheader_type 		=>'',
          	_offset_type 			=>'',
          	_max_offset 			=>'',
          	_min_offset 			=>'',
	  		_exists               	=>'',
          	_file_in	        	=>'',
          	_file_out	        	=>'',
          	_mute_picks_file_out  	=>'',
          	_freq  	        		=>'',
          	_gather_num          	=>'',
          	_gather_num_suffix    	=>'',
          	_gather_type 			=>'',
	  		_min_amplitude        	=>'',
	  		_max_amplitude       	=>'',
	  		_next_step            	=>'',
          	_number_of_tries     	=>'',
          	_purpose      			=>'',
          	_tmin     				=>'',
          	_tmax     				=>'',
          	_TX_inbound           	=>'',
          	_taup_inbound        	=>'',
          	_taup_outbound        	=>'',
          	_inv_taup_outbound    	=>'',
          	_textfile_in          	=>'',
          	_textfile_out         	=>''
        };



=head2 subroutine clear

  sets all variable strings to '' 

=cut

sub clear {
    $iSurf4->{_gather_num} 		= '';
    $iSurf4->{_gather_type} 	= '';
    $iSurf4->{_binheader_type} 	= '';
    $iSurf4->{_offset_type} 	= '';
    $iSurf4->{_min_offset} 		= '';
    $iSurf4->{_max_offset} 		= '';
    $iSurf4->{_gather_num_suffix} 	= '';
    $iSurf4->{_exists} 			= '';
    $iSurf4->{_file_in} 		= '';
    $iSurf4->{_file_out} 		= '';
    $iSurf4->{_mute_picks_file_out} 	= '';
    $iSurf4->{_freq} 			= '';
    $iSurf4->{_min_amplitude} 	= '';
    $iSurf4->{_max_amplitude} 	= '';
    $iSurf4->{_next_step} 		= '';
    $iSurf4->{_number_of_tries} = '';
    $iSurf4->{_purpose}         = '';
    $iSurf4->{_textfile_in} 	= '';
    $iSurf4->{_textfile_out} 	= '';
    $iSurf4->{_tmin} 			= '';
    $iSurf4->{_tmax} 			= '';
    $iSurf4->{_TX_inbound} 	      = '';
    $iSurf4->{_inv_taup_outbound} = '';
    $iSurf4->{_taup_inbound} 	  = '';
    $iSurf4->{_taup_outbound} 	  = '';
};


=head2 USE classes


=cut

 use Moose;
 use iApply_mute;
 use iSave_mute_picks;
 use Project;

 use flow;
 use iSelect_tr_Sumute;
 use iMutePicks2par;
 use manage_files_by;
 use message;
 use readfiles; 
 use suifft;
 use suamp;
 use sufft;
 use sufilter;
 use sugain;
 use suinterp;
 use sushw;
 use sutaup;
 use suwind;
 use suximage;
 use suxwigb;

 use SeismicUnix qw ($on $off 
 	        $gather_num_suffix
		$itemp_surf_picks_sorted_par_  
		$in $out $on $go $to 
		$suffix_ascii 
		$suffix_bin 
		$suffix_fp 
		$suffix_taup 
		$suffix_su); 

=head2  Instanitiate Classes

	Give them a new name if convenient 
    Use classes:
	flow
	log
	message
	sufilter
	sufft
	sugain
	sinterp
	suximage
	suamp
	suwind
	sushw

=cut

 my $iApply_mute 			= new iApply_mute();
 my $iSelect_tr_Sumute 		= new iSelect_tr_Sumute();
 my $iMutePicks2par 		= new iMutePicks2par();
 my $iSave_mute_picks       = new iSave_mute_picks();
 my $log 					= new message();
 my $read             		= new readfiles();
 my $run    				= new flow();
 my $suximage				= new suximage();
 my $suxwigb				= new suxwigb();
 my $suamp					= new suamp();
 my $suifft					= new suifft();
 my $sufft					= new sufft();
 my $sufilter				= new sufilter();
 my $sugain					= new sugain();
 my $suinterp				= new suinterp();
 my $suwind					= new suwind();
 my $smooth					= new sufilter();
 my $sutaup					= new sutaup();
 my $sushw					= new sushw();
 my $Project 				= new Project();

=head2 Get configuration information

  print("file name is $CFG->{file_name}\n\n");
  print(" inc is  $CFG->{suwind}{1}{inc}\n\n");;

=cut

  my  ($err,$CFG) 	     = $read ->cfg("/usr/local/pl/iSurf4_config.pl");
  $iSurf4->{_file_in}        = $CFG->{file_name};

=head2 Declare variable scope
	
=cut

my ($sufile_in,$inbound);
my (@outbound,@file_out);


=head2 Use directory navigation system
	
=cut

 my ($DATA_SEISMIC_SU) = $Project->DATA_SEISMIC_SU();

=head2 Define the input and output file names
  
   and directory path 

=cut

  $sufile_in			= $iSurf4->{_file_in}.$suffix_su;
  $inbound			= $DATA_SEISMIC_SU.'/'.$sufile_in;


  #$file_out[1]			= $iSurf4->{_file_in}.$suffix_fp;
  #$outbound[1]			= $DATA_SEISMIC_SU.'/'.$file_out[1].$suffix_su;

  $iSurf4->{_mute_picks_file_out}= $iSurf4->{_file_in}.$suffix_taup;
  $iSurf4->{_file_out}		 = $iSurf4->{_file_in};
  print("mute picks file out is $iSurf4->{_mute_picks_file_out} in iApply-mute \n\n");

=head2 sub binheader_type

  define the message family to use

=cut

sub binheader_type{
   my($variable,$type)  	= @_;
   $iSurf4->{_binheader_type} 	= $type if defined($type);
}

=head2 subroutine gather_type

  sets gather type to consider 
  e.g., 'ep', 'cdp', etc. 

=cut

sub gather_type {
   my($variable,$gather_type)  	= @_;
   $iSurf4->{_gather_type} 	= $gather_type if defined ($gather_type);
}


=head2 subroutine gather_num

  sets gather number to consider  
  print("1. first_gather is $iSurf4->{_gather_num} \n\n");

=cut

sub gather_num {

   my($variable,$gather_num)  	= @_;
   $iSurf4->{_gather_num} 	= $gather_num if defined ($gather_num);
   $iSurf4->{_gather_num_suffix}= $gather_num_suffix.$iSurf4->{_gather_num};

}


=head2 subroutine purpose

 are the picks for a future top mute
 or a future bottom mute ? 
 e.g.= _bottom_mute
 
=cut

sub purpose{

  my($variable,$purpose)  	= @_;

  if (defined($purpose)) {
    $iSurf4->{_purpose} = $purpose;
	print("mute type is $iSurf4->{_purpose}\n\n");
  }
}

=head2 subroutine iApply_mute

  Mute the data using selected parameters 
 
=cut

sub iApply_mute {
 $iApply_mute->purpose($iSurf4->{_purpose});
 $iApply_mute->binheader_type($iSurf4->{_binheader_type});
 $iApply_mute->gather_type($iSurf4->{_gather_type});
 $iApply_mute->gather_num($iSurf4->{_gather_num});
print(" mute picks file out in iSurf4.pm is $iSurf4->{_mute_picks_file_out}\n\n");
 $iApply_mute->file_in($iSurf4->{_mute_picks_file_out});
 $iApply_mute->offset_type('tracl');
 #$iApply_mute->freq($iSurf4->{_freq});
 #$iApply_mute->min_amplitude($iSurf4->{_min_amplitude});
 #$iApply_mute->max_amplitude($iSurf4->{_max_amplitude});
 $iApply_mute->calcNdisplay();
}



=head2 subroutine iMutePicks2par

 convert format of pick files for use later
 into "par" format 
 
=cut

sub iMutePicks2par{
 $iMutePicks2par->gather_type($iSurf4->{_gather_type});
 $iMutePicks2par->gather_num($iSurf4->{_gather_num});
 $iMutePicks2par->purpose($iSurf4->{_purpose});
 $iMutePicks2par->file_in($iSurf4->{_mute_picks_file_out});
 $iMutePicks2par->calc();
}


=head2 subroutine iSave_mute_picks

 save pick files for later use
 
=cut

sub iSave_mute_picks{
 $iSave_mute_picks->gather_num($iSurf4->{_gather_num});
 $iSave_mute_picks->binheader_type($iSurf4->{_binheader_type});
 $iSave_mute_picks->gather_type($iSurf4->{_gather_type});
 $iSave_mute_picks->purpose($iSurf4->{_purpose});
 $iSave_mute_picks->file_in($iSurf4->{_mute_picks_file_out});
 $iSave_mute_picks->calc();
}



=head2 subroutine iSelect_tr_Sumute

 Select mute points in traces
 provide file name
  print("2. first_gather is $iSurf4->{_gather_num} \n\n");
 
=cut


sub iSelect_tr_Sumute{
 $iSelect_tr_Sumute->gather_type($iSurf4->{_gather_type}); 
 $iSelect_tr_Sumute->offset_type($iSurf4->{_offset_type}); 
 $iSelect_tr_Sumute->gather_num($iSurf4->{_gather_num});
 $iSelect_tr_Sumute->purpose($iSurf4->{_purpose});
 #$iSelect_tr_Sumute->binheader_type($iSurf4->{_binheader_type});
 $iSelect_tr_Sumute->file_in($iSurf4->{_mute_picks_file_out});
# $iSelect_tr_Sumute->freq($iSurf4->{_freq});
# $iSelect_tr_Sumute->min_amplitude($iSurf4->{_min_amplitude});
# $iSele ct_tr_Sumute->max_amplitude($iSurf4->{_max_amplitude});
 $iSelect_tr_Sumute->number_of_tries($iSurf4->{_number_of_tries});
 $iSelect_tr_Sumute->calcNdisplay();
}

=head2 sub number_of_tries

    keep track of the number of attempts
    at picking top mute

=cut

sub number_of_tries {
  my ($variable, $number_of_tries)        = @_;
     $iSurf4->{_number_of_tries}        = $number_of_tries if defined($number_of_tries);
}

=head2 subroutine offset_type

  define which values  to use in the xaxis 

=cut

sub offset_type {
   my($variable, $offset_type)  = @_;
   $iSurf4->{_offset_type} 	= $offset_type if defined($offset_type);
 #print("offset type -2 $offset_type\n\n");
}

=head2 sub display_common_plots


=cut

sub display_common_plots {

=head2 Declare local variables
  print("4. first_gather is $iSurf4->{_gather_num} \n\n");

=cut

 my (@flow, @items);
 my (@suamp, @suximage, @suxwigb);
 my (@suinterp,@suinterp_note);
 my (@suifft,@sufft,@sutaup);
 my (@sufilter,@sufilter_note);
 my (@sugain, @sugain_note);
 my (@suwind,@smooth,@sushw);

 $iSurf4->{_taup_outbound} = $DATA_SEISMIC_SU.'/'.
			     $iSurf4->{_file_out}.$suffix_taup.'_'.
                             $iSurf4->{_gather_type}.
                             $iSurf4->{_gather_num}.$suffix_su;

=head2 Set up interpolation parameters

 print("suinterp is $suinterp[1]\n");
 print(" new trace_separation is $trace_separation\n");
 print(" new num_traces is $num_traces\n");
 my $test = $CFG->{suinterp}{1}{current_trace_separation}  + 1;
 print("current trace separation is $CFG->{suinterp}{1}{current_trace_separation}\n\n");
 print("n for suinterp  is $CFG->{suinterp}{1}{num_new_traces2interp}\n\n");

=cut
 my ($num_traces,$trace_separation);

 $suinterp->		clear();
 $suinterp->		num_new_traces2interp($CFG->{suinterp}{1}{number_new_traces2interpolate});
 $trace_separation = 	$suinterp->update_trace_separation($CFG->{suinterp}{1}{current_trace_separation});

 $num_traces 	   = 	$suinterp->update_num_traces($CFG->{suinterp}{1}{traces_per_gather});
 $suinterp->		fmin($CFG->{suinterp}{1}{min_freq_Hz});
 $suinterp->		smooth_ns_t($CFG->{suinterp}{1}{number_of_samples_to_smooth});
 $suinterp->		smooth_ntr($CFG->{suinterp}{1}{number_of_traces_to_smooth});
 $suinterp[1] 	   = 	$suinterp->Step();
 $suinterp_note[1] = 	$suinterp->note();

=head2 Set up taup parameters

  sutaup->dp needs a previous sutaup->dx 

=cut


my @sutaup_outbound_pickfile;


 $sutaup			->clear();
 $sutaup			->pmax($CFG->{sutaup}{1}{pmax});
 $sutaup			->pmin($CFG->{sutaup}{1}{pmin});
 $sutaup			->fmin($CFG->{sutaup}{1}{min_freq_Hz});
 $sutaup			->np($num_traces);
 $sutaup_outbound_pickfile[1]   = $sutaup->outbound_pickfile($iSurf4->{_file_in});
 $sutaup			->dx($trace_separation);
 my $dp 			= $sutaup->dp(); 
 $sutaup			->option($CFG->{sutaup}{1}{transform_type});
 $sutaup[1] 			= $sutaup->Step();

=head2 Set up inverse taup parameters

=cut

 $sutaup			->clear();
 $sutaup			->pmax($CFG->{sutaup}{2}{pmax});
 $sutaup			->pmin($CFG->{sutaup}{2}{pmin});
 $sutaup			->fmin($CFG->{sutaup}{2}{min_freq_Hz});
 $sutaup			->np($num_traces);
 $sutaup			->npoints(369);
 $sutaup			->option($CFG->{sutaup}{2}{transform_type});
 $sutaup[2] 			= $sutaup->Step();


=head2 Set sufft 

 print("sufft is $sufft[1]\n\n");

=cut

 $sufft-> clear();
 $sufft[1] = $sufft->Step();

=head2 Set type of traces to output

	amp gives amplitude traces
	phase gives phase traces...
	see suamp.pm for further instruction
    -> Here, none are really neccessary
    -> amp is default

=cut

 $suamp-> clear();
 $suamp-> mode('amp');
 $suamp[1] = $suamp->Step();

=head2 Set  header values

 change offset to scaled "p" values 

 print("sufft is $sufft[1]\n\n");

=cut

 $sufft-> clear();
 $sufft[1] = $sufft->Step();

=head2 Set Filtering Parameters

 print("sufilter note iis $sufilter_note[1]\n\n");

=cut

 $sufilter		-> clear();
 $sufilter		-> freq($CFG->{sufilter}{1}{freq});
 $sufilter		-> amps($CFG->{sufilter}{1}{amplitude});
 $sufilter_note[1]	=  $sufilter->note();
 $sufilter[1]   	=  $sufilter->Step();
=head2 Add Gain to traces

=cut

 $sugain	-> clear();
 $sugain	-> agc($CFG->{sugain}{1}{agc_switch});
 $sugain	-> width($CFG->{sugain}{1}{wagc});
 $sugain_note[1] = $sugain->note();
 $sugain[1]   	 =  $sugain->Step();

=head2 Add Gain to output of suamps

=cut

 $sugain	-> clear();
 $sugain	-> pbal($on);
 $sugain[2]   	=  $sugain->Step();

=head2 Window by type and number of gather 

      only one gather at a time
  print("3. first_gather is $iSurf4->{_gather_num} \n\n");
=cut

 $suwind	-> clear();
 $suwind	-> key($iSurf4->{_gather_type});
 $suwind	-> min($iSurf4->{_gather_num});
 $suwind	-> max($iSurf4->{_gather_num});
 $suwind[1]      = $suwind->Step();

=head2  Window by trace
        according to their offset

  in meters 
=cut

 #my $min_offset 	= 1 ;
 #my $max_offset 	= 24 ;

 $suwind	-> clear();
 $suwind->key($CFG->{suwind}{2}{key});
 $suwind->min($CFG->{suwind}{2}{min});
 $suwind->max($CFG->{suwind}{2}{max});
 $suwind[2] 	= $suwind->Step();

=head2 Window by time 

  Window by time 

=cut

 $suwind	-> clear();
 $suwind	-> tmin($CFG->{suwind}{3}{tmin});
 $suwind	-> tmax($CFG->{suwind}{3}{tmax});
 $suwind[3] 	= $suwind->Step();

=head2 Set suximage parameters

 top-left image plot of dispersion

 These default settings will generate an image of
 the dispersion curve for viewing
 For actual data output

 $suximage-> style('normal'); # y axis is phase velocity
 $suximage-> style('seismic'); # y axis is phase velocity
 my $new_d2 = $dv;

 in interactive mode:
  first time you see the image, number_of_tries =0
  second, third, etc. times number_of_tries >0
  The pick file can be saved

  top left image

=cut

 $suximage-> clear(); 
 $suximage->defaults('iSurf4','top_left');
 $suximage-> title(''); 
 $suximage-> cmap("hsv6"); #hsv0 for black and white
 $suximage-> legend($on); #hsv0 for black and white
 $suximage-> hiclip(9); 
 $suximage-> loclip(0); 
 $suximage-> legend($on);
 $suximage ->d2($dp);
 $suximage[2]  = $suximage->Step();


=head2 Set wiggle plot 
	
	for raw data 
        top_right_wiggle
=cut
  
 $suxwigb-> clear(); 
 $suxwigb->defaults('iSurf4','top_right');
 #$suxwigb -> key('tracf');
 $suxwigb-> title(quotemeta($suinterp_note[1])); 
 $suxwigb-> first_x(1);
 $suxwigb-> trace_inc(1);
 #$suxwigb-> percent(99.9);
 $suxwigb-> clip(1);
 $suxwigb-> windowtitle(quotemeta($iSurf4->{_file_in}));
 $suxwigb[1]  = $suxwigb->Step();

=head2 Set suximage parameters

 top-right image
 raw X-T data
 hsv0 for black and white

=cut

 $suximage	-> clear(); 
 $suximage	-> defaults('iSurf4','top_right');
 $suximage	-> title(quotemeta($sugain_note[1].
				   $sufilter_note[1])); 
 $suximage	-> cmap("hsv0"); 
 $suximage	-> legend($on);
 $suximage	-> hiclip(3); 
 $suximage	-> loclip(-3); 
 $suximage	-> legend($on);
 $suximage 	-> d2($dp);
 $suximage[1]    = $suximage->Step();


=head2 Set wiggle plot 
	
	for tau-p data
        top_middle_wiggle
=cut

 $suxwigb 	-> clear(); 
 $suxwigb 	-> defaults('iSurf4','top_middle');
 $suxwigb 	-> key('tracl');
 $suxwigb 	-> title(quotemeta($iSurf4->{_file_in}.$sufilter_note[1])); 
print("$iSurf4->{_file_in}.$sufilter_note[1])\n\n");
 $suxwigb 	-> pmin($CFG->{sutaup}{1}{pmin});
 $suxwigb 	-> dp($dp);
 $suxwigb 	-> picks($sutaup_outbound_pickfile[1]); 
 #$suxwigb	-> percent(99.9);
 $suxwigb 	-> clip(2);
 $suxwigb[2]  	= $suxwigb->Step();

=head2 Set wiggle plot 
	
	for inverted taup plot
	bottom_right_wiggle
=cut

 $suxwigb-> clear(); 
 #$suxwigb -> key('tracf');
 $suxwigb->defaults('iSurf4','bottom_right');
 $suxwigb-> title(quotemeta($iSurf4->{_file_in})); 
 $suxwigb-> first_x(1);
 $suxwigb-> trace_inc(1);
 #$suxwigb-> percent(99.9);
 $suxwigb-> clip(.01);
 $suxwigb[3]  = $suxwigb->Step();


=head2 DEFINE FLOWS 

=cut

=head2 Produce wiggle plot of input shot record

	 top-right wiggle plot	
	   $to,$sugain[1],
r[2],

=cut

 @items = ($suwind[1],$in,$inbound,
           $to,$suwind[3],
	   $to,$sufilter[1],
           $to,$suinterp[1],
	   $to,$suxwigb[1],
	   $go);
 $flow[1]  = $run -> modules(\@items);

=head2 Produce image plot of input shot record

	 top-right image plot	
r[2],

=cut

 @items = ($suwind[1],$in,$inbound,
           $to,$suwind[3],
	   $to,$sufilter[1],
           $to,$suinterp[1],
	   $to,$sugain[1],
	   $to,$suximage[1],
	   $go);
 $flow[11]	= $run -> modules(\@items);

=head2 Produce tau-p plot 

       top-middle wiggle plot

	   $to,$sugain[1],

=cut

 @items = ($suwind[1],$in,$inbound,
           $to,$suwind[3],
	   $to,$sufilter[1],
           $to,$suinterp[1],
           $to,$sutaup[1],
	   $to,$suxwigb[2],
	   $go);
 $flow[2]	= $run -> modules(\@items);

=head2 Produce fft plot 
	   $to,$sufilter[2],
	   $to,$sugain[1],

=cut

 @items = ($suwind[1],$in,$inbound,
           $to,$suwind[3],
	   $to,$sufilter[1],
           $to,$suinterp[1],
           $to,$sutaup[1],
           $to,$sufft[1],
	   $to,$suamp[1],
	   $to,$sugain[2],
	   $to,$suximage[2],
	   $go);
 $flow[3]	= $run -> modules(\@items);


=head2 evaluate amplitude

=cut

@items = ($suwind[1],$in,$inbound, 
           $to,$suwind[3],
	   $to,$sufilter[1],
           $to,$suinterp[1],
           $to,$sutaup[1],
	   $to,$sutaup[2],
	   $to,' sumax',
           $go);
 $flow[4]	= $run -> modules(\@items);


=head2 Produce inverse taup plot 
       bottom-right plot
	   $to,$sugain[1],

=cut

 @items = ($suwind[1],$in,$inbound, 
           $to,$suwind[3],
	   $to,$sufilter[1],
           $to,$suinterp[1],
           $to,$sutaup[1],
	   $to,$sutaup[2],
	   $to,$suxwigb[3],
           $go);
 $flow[5]	= $run -> modules(\@items);

=head2 Output tau-p file 
       
       top-middle plot

	   $to,$sugain[1],

=cut

 @items = ($suwind[1],$in,$inbound,
           $to,$suwind[3],
	   $to,$sufilter[1],
           $to,$suinterp[1],
           $to,$sutaup[1],
	   $out,$iSurf4->{_taup_outbound},
	   $go);
 $flow[6]  = $run -> modules(\@items);

=head2 Phasevel dispersion image w filter or gain, Windowed

Phasevel dispersion image w filter or gain, Windowed

=cut

=head2  RUN FLOW(S)

=cut

 $run->flow(\$flow[1]);
 $run->flow(\$flow[11]);
 $run->flow(\$flow[2]);
 $run->flow(\$flow[3]);
 $run->flow(\$flow[4]);
 $run->flow(\$flow[5]);
 $run->flow(\$flow[6]);


=head2  LOG FLOW(S)
 
 TO SCREEN AND FILE

=cut

 #print $flow[1]."\n";
 print $flow[11]."\n";
 #print $flow[2]."\n";
 #print $flow[3]."\n";
 #print $flow[4]."\n";
 #print $flow[5]."\n";
 #print $flow[6]."\n";
 #$log->file($flow[1]);
 #$log->file($flow[11]);
 #$log->file($flow[2]);
 #$log->file($flow[3]);
 #$log->file($flow[4]);
 #$log->file($flow[5]);
 #$log->file($flow[6]);
 #
} # end of displaying common plots


=head2 sub isutaup 

 calcualte and display inverse sutaup

=cut

sub  isutaup {

=head2 Declare local variables

=cut

 my (@flow, @items);
 my (@suamp, @suximage, @suxwigb);
 my (@suinterp,@suinterp_note);
 my (@suifft,@sufft,@sutaup);
 my (@sufilter, @sufilter_note);
 my (@sugain, @sugain_note);
 my (@suwind,@smooth,@sushw);


  $iSurf4->{_inv_taup_outbound} = $DATA_SEISMIC_SU.'/'.
				  'inv_taup_'.
				  $iSurf4->{_file_out}.'_'.
				  $iSurf4->{_gather_type}.
				  $iSurf4->{_gather_num}.
				  $suffix_su;

  $iSurf4->{_taup_inbound}       = $DATA_SEISMIC_SU.'/'.
			          $iSurf4->{_file_out}.
				  $suffix_taup.'_'.
                                  $iSurf4->{_gather_type}.
                                  $iSurf4->{_gather_num}.
				  '_mute'.
				  $suffix_su;

=head2 Set up interpolation parameters

=cut

 my ($num_traces,$trace_separation);

 $suinterp->		clear();
 $suinterp->		num_new_traces2interp($CFG->{suinterp}{1}{number_new_traces2interpolate});
 $trace_separation = 	$suinterp->update_trace_separation($CFG->{suinterp}{1}{current_trace_separation});
 $num_traces 	   = 	$suinterp->update_num_traces($CFG->{suinterp}{1}{traces_per_gather});
 $suinterp->		fmin($CFG->{suinterp}{1}{min_freq_Hz});
 $suinterp->		smooth_ns_t($CFG->{suinterp}{1}{number_of_samples_to_smooth});
 $suinterp->		smooth_ntr($CFG->{suinterp}{1}{number_of_traces_to_smooth});
 $suinterp[1] 	   = 	$suinterp->Step();
 $suinterp_note[1] = 	$suinterp->note();

=head2 Set up taup parameters

  sutaup->dp needs a previous sutaup->dx 

=cut


my @sutaup_outbound_pickfile;


 #$sutaup			->clear();
 #$sutaup			->pmax($CFG->{sutaup}{1}{pmax});
 #$sutaup			->pmin($CFG->{sutaup}{1}{pmin});
 #$sutaup			->fmin($CFG->{sutaup}{1}{min_freq_Hz});
 #$sutaup			->np($num_traces);
 #$sutaup_outbound_pickfile[1]   = $sutaup->outbound_pickfile($iSurf4->{_file_in});
 #$sutaup			->dx($trace_separation);
 #my $dp 			= $sutaup->dp(); 
 #$sutaup			->option($CFG->{sutaup}{1}{transform_type});
 #$sutaup[1] 			= $sutaup->Step();

=head2 Set up inverse taup parameters

=cut

 $sutaup			->clear();
 $sutaup			->pmax($CFG->{sutaup}{2}{pmax});
 $sutaup			->pmin($CFG->{sutaup}{2}{pmin});
 $sutaup			->fmin($CFG->{sutaup}{2}{min_freq_Hz});
 $sutaup			->np($num_traces);
 $sutaup			->npoints(369);
 $sutaup			->option($CFG->{sutaup}{2}{transform_type});
 $sutaup[1] 			= $sutaup->Step();

=head2 Set wiggle plot 
	
	for inverted taup plot
=cut

 $suxwigb-> clear(); 
 $suxwigb->defaults('iSurf4','bottom_right');
 $suxwigb -> key('tracl');
 $suxwigb-> first_x(1);
 $suxwigb-> trace_inc(1);
 #$suxwigb-> percent(99.9);
 $suxwigb-> clip(.01);
 $suxwigb-> windowtitle(quotemeta('Inverted-muted-taup Data'));
 $suxwigb[1]  = $suxwigb->Step();

=head2 DEFINE FLOWS 

=cut


=head2 Output inverse taup plot 

=cut

 @items = ($sutaup[1],$in,
	   $iSurf4->{_taup_inbound}, 
	   $to,$suxwigb[1],
           $go);
 $flow[1]= $run -> modules(\@items);


=head2 Output inverse taup file 

=cut

 @items = ($sutaup[1],$in,
	   $iSurf4->{_taup_inbound}, 
	   $out,$iSurf4->{_inv_taup_outbound},
           $go);
 $flow[2]= $run -> modules(\@items);


=head2  RUN FLOW(S)

=cut

 $run->flow(\$flow[1]);
 $run->flow(\$flow[2]);
 


=head2  LOG FLOW(S)
 
 TO SCREEN AND FILE

=cut

 print $flow[1]."\n";
 #print $flow[2]."\n";
 #$log->file($flow[1]);
 #$log->file($flow[2]);
  #
} # end of isutaup 


1;
