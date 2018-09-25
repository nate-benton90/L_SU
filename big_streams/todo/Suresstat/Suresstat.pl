#!/usr/bin/perl
use Moose;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: Suresstat.pl 
 AUTHOR: Juan Lorenzo
 DESCRIPTION: script  to calculate residual statics
 DATE Version 1 June 3, 2016

 MODIFIED BY: Martial Morrison
 DATE: Version 1.1 June 14, 2016

=head2 Simple pseudo code
   
  suresstat < file i
              ssol=output file  
              rsol=output file  
              number_of_traces= 

  | sustatic hdrs=3  
  | suximage

=cut

=head2 Import 

 perl classes container and system variables
 take variables and packages directly from
 the path to the library, so as to minimize memory use

=cut

  use Project;
  use sufilter;
  use sugain;
  use message;
  use flow;
  use suxwigb;
  use suresstat;
  use sustatic;
  use susort;
                
  use SeismicUnix qw ($suffix_geom $suffix_su $go $in $on $off $to $out); 

=head2 Instantiate classes

  message,flow,susort,sucat,readfiles 

=cut

 my $filter			= new sufilter();
 my $gain			= new sugain();
 my $log			= new message();
 my $run    		= new flow();
 my $plot_wig       = new suxwigb();
 my $resstat		= new suresstat();
 my $statics		= new sustatic();
 my $sort			= new susort();
 my $Project 		= new Project;
 
=head2 Declare variables

  Make  local 

=cut
 my ($DATA_SEISMIC_SU)			= $Project->DATA_SEISMIC_SU();
 
 my (@file,@file_stat,@file_resstat,@sufile_in,@sufile_out,@stat_file);
 my (@sort_inbound,@sort_outbound,@resstat_inbound);
 my (@filter,@gain,@statics,@plot_wig,@resstat,@sort);
 my (@flow,@items);

=head2 Establish

 file names and directories
 inbound and outbound refer to complete paths 

=cut

  $file[1]              = 'All_line1_interp_fk2_mute_cmp300_tracf_nmocorrected_wind';
  $file_stat[1]		= 'All_line1_interp_fk2_mute_cmp300_tracf_nmocorrected_wind_stat';
  $file_resstat[1]	= 'All_line1_interp_fk2_mute_cmp300_tracf_nmocorrected_wind_fldr';

  $sufile_in[1] 	= $file[1].$suffix_su;
  $sufile_out[1] 	= $file_stat[1].$suffix_su;
  $resstat_inbound[1]	= $file_resstat[1].$suffix_su;

  $sort_inbound[1] 	= $DATA_SEISMIC_SU.'/'.$sufile_in[1];
  $sort_outbound[1]	= $DATA_SEISMIC_SU.'/'.$resstat_inbound[1];
  $stat_file[1]		= $DATA_SEISMIC_SU.'/'.$sufile_out[1];

=head2 Information about data files

 Data consists of alternating hammer and seisgun shotgathers 
 file headers have fldr=ep and tracf=gx in order to run surrestat

=cut

=head2 Set filter parameters


=cut

 $filter    -> freq("0,3,70,120");
 $filter[1]  = $filter->Step();


=head2 Set gain parameters

 this is how to use a subroutine from the sugain 'package' 
 $on =1
 $width is the width of the window in seconds
 $setdt creates a new dt value in the header
 $gain-> Step() generates the instructions to run this single module with 
 the correct syntax for perl

 $gain     -> agc($on);
 $gain     -> width(0.1);
# $gain     -> setdt(1000);
 $gain[2]   = $gain->Step();

=cut

 $gain->clear();
 $gain->agc($on);
 $gain->width(0.1);
# $gain->setdt(1000);
 $gain[1]   = $gain->Step();


 $gain     -> clear();
 $gain     -> pbal($on);
 $gain[2]   = $gain->Step();

=head2 Apply statics

=cut

  $statics->clear();
  $statics->hdrs('3');
  $statics->sou_file('shot_stats');
  $statics->rec_file('geo_stats');
  $statics->num_sources('150');
  $statics->num_receivers('345');
  $statics->num_offsets('2400');
  $statics[1] = $statics->Step();

=head2 calculate receiver-source statics

 files by using a list array 

 imax/max_fldr_cmp_tracf can be greater than or equal to max value.
 If the number is less than, it won't work.

=cut

  $resstat->clear();
  $resstat->input_file($sort_outbound[1]);
  $resstat->receiver_statics_file_output('geo_stats');
  $resstat->source_statics_file_output('shot_stats');
  $resstat->imax('20000');
  $resstat->iterations('20');
  $resstat->max_sample_shift('50');
  $resstat->subtract($on);
  $resstat->mode($off);
  $resstat->verbose($on);
  $resstat[1] = $resstat->Step();

=head2 Sort

 input file is sorted to 'fldr tracf'

=cut

  $sort->clear();
  $sort->headerword('fldr tracf');
  $sort[1] = $sort->Step();


=head2 Plot

 prior to static corrections
 set suxwigb parameters 

=cut

 $plot_wig-> clear(); 
 $plot_wig-> title($sufile_in[1]); 
 $plot_wig-> xlabel("TWTT s");  
 $plot_wig-> ylabel("No.traces"); 
 $plot_wig-> box_width(800); 
 $plot_wig-> box_height(700); 
 $plot_wig-> box_X0(0); 
 $plot_wig-> box_Y0(0); 
 $plot_wig-> absclip(1);
 #$plot_wig-> wigclip(1);
 $plot_wig-> windowtitle("uncorrected_data");
 $plot_wig[1]  = $plot_wig->Step();

=head2 Plot

 result of static corrections
 set suxwigb parameters 

=cut

 $plot_wig-> clear(); 
 $plot_wig-> title($sufile_out[1]); 
 $plot_wig-> xlabel("TWTT s");  
 $plot_wig-> ylabel("No.traces"); 
 $plot_wig-> box_width(800); 
 $plot_wig-> box_height(700); 
 $plot_wig-> box_X0(0); 
 $plot_wig-> box_Y0(0); 
 $plot_wig-> absclip(1);
 #$plot_wig-> wigclip(1);
 $plot_wig-> windowtitle("corrected_data");
 $plot_wig[2]  = $plot_wig->Step();

=head2 DEFINE FLOW(S)
 
 flow 1: sorts the nmo-corrected file into shor gathers (fldr tracf)
 flow 2: runs suresstat, creating two files with static corrections
 flow 3: runs sustatic, adding the calculated static corrections to the headers of the seismic traces
 flow 4: plots uncorrected data to the screen
 flow 5: plots corrected data to the screen

=cut

 @items   = ($sort[1],$in,$sort_inbound[1],$out,$sort_outbound[1]);
 $flow[1] = $run->modules(\@items);

 @items   = ($resstat[1]);
 $flow[2] = $run->modules(\@items);

 @items   = ($statics[1],$in,$sort_inbound[1],$out,$stat_file[1]);
 $flow[3] = $run->modules(\@items);

 @items   = ($gain[1],$in,$sort_inbound[1],$to,$filter[1],$to,$plot_wig[1],$go);
 $flow[4] = $run->modules(\@items);

 @items   = ($gain[1],$in,$stat_file[1],$to,$filter[1],$to,$plot_wig[2],$go);
 $flow[5] = $run->modules(\@items);


=head2 RUN FLOW(S)
 

=cut

  $run->flow(\$flow[1]);
  $run->flow(\$flow[2]);
  $run->flow(\$flow[3]);
  $run->flow(\$flow[4]);
  $run->flow(\$flow[5]);

=head2 LOG FLOW(S)


=cut

#  print $flow[1]."\n\n";
# $log->file($flow[1]);

#  print $flow[2]."\n\n";
# $log->file($flow[2]);

#  print $flow[3]."\n\n";
# $log->file($flow[3]);
#  print $flow[4]."\n\n";
# $log->file($flow[4]);

#  print $flow[5]."\n\n";
# $log->file($flow[5]);
