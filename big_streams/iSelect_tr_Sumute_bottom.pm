package iSelect_tr_Sumute_bottom;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PACKAGE NAME: iSelect_tr_Sumute_bottom.pm
 AUTHOR: Juan Lorenzo
 DATE:   April 2 2009 V1.
         Aug 9, 2011 V1.2
         Sept. 2015, V 3
	 August 2016, V 3.1 
         June 12, 2017 V 3.1 
	 adapted from iSelect_tr_Sumute_top3.pm

 DESCRIPTION:
 plot data to select bottom mute values

=head2 USE

=head3 NOTES 

=head4 

 Examples

=cut

 use Moose;
 my $VERSION = '1.0.3';
 use Project;
 use SeismicUnix qw ($on $off $go $in $true $false $itemp_bot_mute_picks_ $itemp_bot_mute_picks_sorted_par_ $itop_mute_par_ $itop_mute_check_pickfile_ $suffix_su $to);

=head2 Instantiate 

 	other packages
    Create a new version of the package
    Personalize to give it a new name if you wish
     Use the following classes:

=cut

  my $log 				= new message();
  my $run    			= new flow();
  my $sufilter			= new sufilter();
  my $sugain			= new sugain();
  my $suwind            = new suwind;
  my $suxwigb			= new suxwigb();
  my $suximage			= new suximage();
  my $SuMessages		= new SuMessages();
  my $Project			= new Project();
  my ($DATA_SEISMIC_SU) = $Project->DATA_SEISMIC_SU();
  my ($PL_SEISMIC)      = $Project->PL_SEISMIC();


=head2 Establish
 
 just the localally scoped variables

=cut

my (@parfile_in,@file_in,@suffix,@inbound);
my (@suwind_min,@suwind_max);
my (@items,@flow,@sugain,@sufilter,@suwind);
my (@suximage);
my (@windowtitle,@base_caption);


=head2  hash array 

 of important variables used within
  this package

=cut 

 my $iSelect_tr_Sumute_bottom = {
      _TX_outbound            => '',
      _gather_num             => '',
      _file_in                => '',
      _freq                   => '',
      _inbound                => '',
      _message_type           => '',
      _binheader_type         => '',
      _offset_type            => '',
      _gather_type            => '',
      _number_of_tries        => '',
      _textfile_in            => ''
    };

=head2 sub clear

         to blank out hash array values

=cut

 sub clear {
     $iSelect_tr_Sumute_bottom->{_TX_outbound}    	= '';
     $iSelect_tr_Sumute_bottom->{_gather_num }   	= '';
     $iSelect_tr_Sumute_bottom->{_file_in}			= '';
     $iSelect_tr_Sumute_bottom->{_freq}        	= '';
     $iSelect_tr_Sumute_bottom->{_inbound}      	= '';
     $iSelect_tr_Sumute_bottom->{_message_type} 	= '';
     $iSelect_tr_Sumute_bottom->{_gather_type} 	= '';     
     $iSelect_tr_Sumute_bottom->{_offset_type}    	= '';
     $iSelect_tr_Sumute_bottom->{_binheader_type} 	= '';
     $iSelect_tr_Sumute_bottom->{_number_of_tries}	= '';
     $iSelect_tr_Sumute_bottom->{_file_in}        	= '';
     $iSelect_tr_Sumute_bottom->{_textfile_in}    	= '';
    }




=head2 subroutine gather

  sets gather number to consider  

=cut

sub gather_num {
   my($variable,$gather_num)  	= @_;
   $iSelect_tr_Sumute_bottom->{_gather_num} 		= $gather_num if defined ($gather_num);
}


=head2 sub binheader_type

  define the message family to use

=cut

sub binheader_type{
   my($variable,$type)  	= @_;
   $iSelect_tr_Sumute_bottom->{_binheader_type} 	= $type if defined($type);
}



=head2 sub gather_type

  define the message family to use

=cut

sub gather_type{
   my($variable,$type)  	= @_;
   $iSelect_tr_Sumute_bottom->{_gather_type} 	= $type if defined($type);
}


=head2 sub offset_type

  define the message family to use

=cut

sub offset_type{
   my($variable,$type)  	= @_;
   $iSelect_tr_Sumute_bottom->{_offset_type} 	= $type if defined($type);
}



=head2 sub file_in

 Required file name
 on which to pick top mute values

=cut

sub file_in {
    my ($variable,$file_in) 	= @_;
    $iSelect_tr_Sumute_bottom->{_file_in} 		= $file_in if defined($file_in); 
  
  #$file_out[$N] 		= $iSelect_tr_Sumute_bottom->{_file_in}.$itop_mute_par_;
  $iSelect_tr_Sumute_bottom->{_inbound}	  		= $DATA_SEISMIC_SU.'/'.$iSelect_tr_Sumute_bottom->{_file_in}.$suffix_su;
    #print("file name is $iSelect_tr_Sumute_bottom->{_file_in} \n\n");
}



=head2 sub freq

  creates the bandpass frequencies to filter data before
  conducting semblance analysis
  e.g., "3,6,40,50"
 
=cut


sub  freq {
 my ($variable, $freq)      = @_;
    $iSelect_tr_Sumute_bottom->{_freq}        = $freq  if defined($freq);
#print("freq is $iSelect_tr_Sumute_bottom->{_freq}\n\n");
     }


=head3 sub min_amplitude

 minumum amplitude to plot 

=cut

sub  min_amplitude {
 my ($variable, $min_amplitude)         = @_;
    $iSelect_tr_Sumute_bottom->{_min_amplitude}        = $min_amplitude  if defined($min_amplitude);
 #print("min_amplitude is $iSelect_tr_Sumute_bottom->{_min_amplitude}\n\n");
     }


=head2 sub max_amplitude

 maximum amplitude to plot 

=cut


sub  max_amplitude {
 my ($variable, $max_amplitude)         = @_;
    $iSelect_tr_Sumute_bottom->{_max_amplitude}        = $max_amplitude  if defined($max_amplitude);
 #print("max_amplitude is $iSelect_tr_Sumute_bottom->{_max_amplitude}\n\n");
     }



=head2 sub number_of_tries

    keep track of the number of attempts
    at picking top mute

=cut

sub number_of_tries {
  my ($variable, $number_of_tries)        = @_;
     $iSelect_tr_Sumute_bottom->{_number_of_tries}        = $number_of_tries if defined($number_of_tries);
  #print("num of tries is $iSelect_tr_Sumute_bottom->{_number_of_tries}\n\n");

}


=head2 subroutine calcNdisplay 

 main processing flow
  calculate mute and display results 

=cut

sub calcNdisplay {

=head2 GAIN 

 DATA

=cut

 $sugain     -> clear();
 $sugain     -> pbal($on);
 $sugain[1]   = $sugain->Step();

 $sugain     -> clear();
 $sugain     -> agc($on);
 $sugain     -> width(0.1);
 $sugain[2]   = $sugain->Step();

 $sugain     -> clear();
 $sugain     -> tpower(3);
 $sugain[3]   = $sugain->Step();


=head2 WINDOW  DATA 

 by  

=cut

 $suwind   		-> clear();
 $suwind   		-> setheaderword($iSelect_tr_Sumute_bottom->{_binheader_type});
 $suwind   		-> min($iSelect_tr_Sumute_bottom->{_gather_num});
 $suwind   		-> max($iSelect_tr_Sumute_bottom->{_gather_num});
#print("gather num is $iSelect_tr_Sumute_bottom->{_gather_num}\n\n");
 $suwind[1] 		 = $suwind->Step();


 $suwind   		-> clear();
 #$suwind   		-> setheaderword('time');
 $suwind   		-> tmin(0);
 $suwind   		-> tmax(1);
 $suwind[2] 		 = $suwind->Step();


=head2  Set 

 filtering parameters 

  use lib "./libAll";
  use iTop_Mute_config qw ( $href_sufilter);
  

=cut
  #use iTop_Mute_config qw ($href_sufilter);
=head2
  print has reference value
=cut
  #print("sufilter is $href_sufilter->{freq}\n\n");
 $sufilter    -> clear();
 $sufilter    -> freq($iSelect_tr_Sumute_bottom->{_freq});
 $sufilter[1]  = $sufilter->Step();


=head2 DISPLAY 

 DATA

=cut

 $base_caption[1]	  = $iSelect_tr_Sumute_bottom->{_file_in}.quotemeta('  ').quotemeta('f=').$iSelect_tr_Sumute_bottom->{_freq};

 $windowtitle[1]	  = quotemeta('GATHER = ').$iSelect_tr_Sumute_bottom->{_gather_num};

 $suximage -> clear();
 $suximage -> box_width(300);    
 $suximage -> box_height(700);    
 $suximage -> box_X0(70);    
 $suximage -> box_Y0(120);    
 $suximage -> title($base_caption[1]);    
 $suximage -> windowtitle($windowtitle[1]);    
 $suximage -> ylabel(quotemeta('TWTT s'));    
 $suximage -> xlabel($iSelect_tr_Sumute_bottom->{_offset_type});    
 $suximage -> legend($on);    
 $suximage -> cmap('rgb0');    
 $suximage -> loclip($iSelect_tr_Sumute_bottom->{_min_amplitude});
 $suximage -> hiclip($iSelect_tr_Sumute_bottom->{_max_amplitude});
 $suximage -> verbose($off);
 
if ($iSelect_tr_Sumute_bottom->{_number_of_tries} > 0) {
  $iSelect_tr_Sumute_bottom->{_TX_outbound} = $itemp_bot_mute_picks_.$iSelect_tr_Sumute_bottom->{_file_in};
  $suximage -> picks(\$iSelect_tr_Sumute_bottom->{_TX_outbound});
  #print("Writing picks to $itemp_bot_mute_picks_ $iSelect_tr_Sumute_bottom->{_file_in}  \n\n"); 
  #print("number of tries is $iSelect_tr_Sumute_bottom -> {_number_of_tries}\n\n");
  #print can not write the hash of "_TX_outbound"
} 
 $suximage[1]  = $suximage -> Step();
 #print("suximage is $suximage[1]\n\n");

# TBD
# change to suxwigb
# or convert to oops
#
#		$suxwigb_windowtitle[$N]	= '\('.$N.'\)\ '.'S\ 14\ Hz\ '.$date.'\ panel\(s\)\ '.$panel.'\ of\ '.$panel_last;
#		$suxwigb_title[$N]		= $$ref_suinterp_note[1].'\ '.$$ref_sugain_note[1]; 
#		$suxwigb_box_width[$N] 		= 300;
#		$suxwigb_box_height[$N] 	= 700;
#		$suxwigb_tlabel[$N]    		= 'TWTT\ \(s\)';
#		$suxwigb_xlabel[$N]    		= 'offset';
#		$suxwigb_X0[$N]        		=  0 + ($P-1) * 25;
#		$suxwigb_Y0[$N]			=  0 + ($P-1) * 25;
#		$suxwigb_key[$N]		= 'offset';
#		$suxwigb_hiclip[$N]             = 1;
#		$suxwigb_mute_picks_file[$N] 	= $DATA_SEISMIC_SU.'/'.$itemp_bot_mute_picks_.$sufile_in[1];
#
#	$suxwigb[$P][$N] =  (" suxwigb				\\
#		key=$suxwigb_key[$N]				\\
#		title=$suxwigb_title[$N]			\\
#		windowtitle=$suxwigb_windowtitle[$N]		\\
#		hbox=$suxwigb_box_height[$N]			\\
#		label1=$suxwigb_tlabel[$N]			\\
#		label2=$suxwigb_xlabel[$N]			\\
#		xbox=$suxwigb_X0[$N]				\\
#		ybox=$suxwigb_Y0[$N]				\\
#         	wbox=$suxwigb_box_width[$N]			\\
#		va=1						\\
#		xcur=2						\\
#		clip=$suxwigb_hiclip[$N]			\\
#		mpicks=$suxwigb_mute_picks_file[$N]		\\
#		");
#$N=0;
#}

=head2 DEFINE FLOW(S)
 
  in interactive mode:
  first time you see the image, number_of_tries =0
  second, third, etc. times number_of_tries >0
  The pick file can be saved

=cut

 @items   = ($suwind[1],$in,$iSelect_tr_Sumute_bottom->{_inbound},$to,$suwind[2],$to,$sufilter[1],$to,$sugain[2],$to,$suximage[1],$go);
 $flow[1] = $run->modules(\@items);


=head2 RUN FLOW(S)

  output copy of picked data points
  only occurs after the number of tries
  is updated

=cut

  $run -> flow(\$flow[1]);

=head2 LOG FLOW(S)

 TO SCREEN AND FILE

=cut

  # print  "$flow[1]\n";
  #$log->file($flow[1]);
  

} # end calcNdisplay subroutine
  
1;

