#!/usr/bin/perl

use Moose;

=head1 DOCUMENTATION

=head2 SYNOPSIS

  PROGRAM NAME: Xamine.pl
  Purpose: Simple viewing of an su file 
  AUTHOR:  Juan M. Lorenzo
  DEPENDS: Seismic Unix modules from CSM 
  DATE:    June 18 2013 V0.1
           July 19 2016 V0.2 i
             Show processing notes on images
           Oct 27 2016
             Include windowing options
  DESCRIPTION:  based upon non-oop Xamine.pl  

=head 2 USES

 (for subroutines) 
     manage_files_by 
     System_Variables (for subroutines)

     (for variable definitions)
     SeismicUnix (Seismic Unix modules)


=head2 NOTES 

 We are using moose 
 moose already declares that you need debuggers turned on
 so you don't need a line like the following:

 use warnings;
 
=head2 USES

 (for subroutines) 
     manage_files_by 
     System_Variables (for subroutines)

     (for variable definitions)
     SeismicUnix (Seismic Unix modules)


 use SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su); 
  
=head3 STEPS IN THE PROGRAM 


=cut

 use message;
 use flow;
 use suxwigb;
 use sufilter;
 use sugain;
 use susort;
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
     suxwigb
     suwind
     susort
     suspecfx

=cut

  my $log 					= new message();
  my $run    				= new flow();
  my $suxwigb				= new suxwigb();
  my $suximage				= new suximage();
  my $sufilter				= new sufilter();
  my $sugain				= new sugain();
  my $susort				= new susort();
  my $suwind				= new suwind();
  my $suspecfx				= new suspecfx();

  my ($DATA_SEISMIC_SU) = System_Variables::DATA_SEISMIC_SU();

=head2 Declare

  local variables 

=cut

  my (@flow,@file_in,@sufile_in,@inbound);
  my (@suxwigb,@sufilter,@sufilterNote,@sugain,@sugainNote,$sugainVersion,@items,@suximage);
  my (@suwind,@suwindNote,$suwindVersion);
  my (@susort,@susortNote,$susortVersion);
  my (@suspecfx,@suspecfxNote,$suspecfxVersion);

=head2 Declare 

  file names
=cut

   $file_in[1] 		            = 'inv_taup_All_cmp_ep142';
   $file_in[1] 		            = 'All_cmp_kill_interp';
   $file_in[1] 		            = 'All_cmp_interp';
   $file_in[1] 		            = 'All_cmp_despike_interp';
   $file_in[1] 		            = 'All_cmp_mute_ep_1_238_fk_mute_ep_1_238';
   $file_in[1] 		            = 'All_cmp';
   $sufile_in[1]		    = $file_in[1].$suffix_su;
   $inbound[1]			    = $DATA_SEISMIC_SU.'/'.$sufile_in[1];

=head2 Set

 sugain

=cut

 #$sugainVersion = 2;
 #$sugainVersion = 3;
 $sugainVersion = 1;

 $sugain     	-> clear();
 $sugain     	-> agc($on);
 $sugain     	-> width(0.1);
# $sugain    	 -> setdt(1000);
 $sugain[1]   	= $sugain->Step();
 $sugainNote[1] = $sugain->note();


 $sugain     	-> clear();
 $sugain     	-> pbal($on);
 $sugain[2]   	= $sugain->Step();
 $sugainNote[2] = $sugain->note();

 $sugain     	-> clear();
 $sugain     	->tpower(-.5);
 $sugain[3]   	= $sugain->Step();
 $sugainNote[3] = $sugain->note();


=head2 Set

 suwind

=cut

 $suwindVersion = 2;

 $suwind     			-> clear();
 $suwind     			-> setheaderword('tracl');
 $suwind     			-> min(1);
 $suwind     			-> max(6000);
 $suwind[$suwindVersion]   	= $suwind->Step();
 $suwindNote[$suwindVersion] 	= $suwind->note();

=head2 Set

 susort

=cut

 $susortVersion = 1;

 $susort     			-> clear();
 $susort     			-> headerword('ep');
 $susort[$susortVersion]   	= $susort->Step();
 $susortNote[$susortVersion] 	= $susort->note();

=head2 Set

 suwind

=cut

 $suwindVersion = 1;

 $suwind     			-> clear();
 $suwind     			-> tmin(0);
 $suwind     			-> tmax(1);
 $suwind[$suwindVersion]   	= $suwind->Step();
 $suwindNote[$suwindVersion] 	= $suwind->note();
=head2 Set

 suwind

=cut

 $suwindVersion = 3;

 $suwind     			-> clear();
 $suwind     			-> key('offset');
 $suwind     			-> min(10);
 $suwind     			-> max(20);
 $suwind[$suwindVersion]   	= $suwind->Step();
 $suwindNote[$suwindVersion] 	= $suwind->note();

=head2

 set  suspecfx

=cut

 $suspecfx  -> clear();
 $suspecfx[1] = $suspecfx->Step();


=head2 set

filtering parameters 

=cut
 $sufilter		 -> clear();
 $sufilter    	 -> freq('0,1,21,22');
 $sufilter[1]  	 = $sufilter->Step();
 $sufilterNote[1]= $sufilter->note();

=head2 Set

  suxwigb parameters 

=cut

 $suxwigb-> clear(); 
 $suxwigb-> title(quotemeta($sufilterNote[1].$sugainNote[$sugainVersion])); 
 $suxwigb-> xlabel(quotemeta('TWTT s'));  
 $suxwigb-> ylabel(quotemeta('No.traces')); 
 $suxwigb-> box_width(800); 
 $suxwigb-> box_height(700); 
 $suxwigb-> box_X0(0); 
 $suxwigb-> box_Y0(0); 
 $suxwigb-> absclip(4);
 $suxwigb-> va(1);
 $suxwigb-> xcur(3);
 $suxwigb-> windowtitle($sufile_in[1]);
 $suxwigb[1]  = $suxwigb->Step();

=head2 Set

  suximage parameters 
  my $num_traces =24;
  my $cmp_per_trace = 1/$num_traces;
  my $first_cmp = 1;
  $suximage-> f2($first_cmp); 
  $suximage-> d2($cmp_per_trace); 

=cut

 $suximage-> clear(); 
 $suximage-> title(quotemeta($sufilterNote[1].$sugainNote[$sugainVersion])); 
 $suximage-> xlabel(quotemeta('No. traces'));  
 $suximage-> ylabel(quotemeta('TWTT s')); 
 $suximage-> box_width(800); 
 $suximage-> box_height(700); 

 $suximage-> key('tracl'); 
 $suximage-> box_X0(825); 
 $suximage-> box_Y0(0); 
 #$suximage-> absclip(3);
 #$suximage-> loclip(-2);
 #$suximage-> hiclip(2);
 $suximage-> perc(99);
 $suximage-> windowtitle($sufile_in[1]);
 $suximage[1]  = $suximage->Step();

=head2 Set

  suximage parameters 
  for suspecfx

=cut

 $suximage-> clear(); 
 $suximage-> title(quotemeta($sufilterNote[1].$sugainNote[$sugainVersion])); 
 $suximage-> xlabel(quotemeta('No. traces'));  
 $suximage-> ylabel(quotemeta('f Hz')); 
 $suximage-> box_width(800); 
 $suximage-> box_height(700); 

 $suximage-> key('tracl'); 
 $suximage-> box_X0(825); 
 $suximage-> box_Y0(0); 
 $suximage-> legend($on);
 $suximage-> windowtitle($sufile_in[1]);
 $suximage[2]  = $suximage->Step();


=head2 DEFINE FLOW(S)
 
=cut

 $sugainVersion = 1;

 @items   = ($susort[1],$in,$inbound[1],$to,
             $suwind[1],$to,$suwind[3],$to,
             $sufilter[1],$to,$sugain[$sugainVersion],$to,
             $suxwigb[1],$go);
 $flow[1] = $run->modules(\@items);

 @items   = ($susort[1],$in,$inbound[1],$to,
	     $suwind[1],$to,$suwind[3],$to,
             $sufilter[1],$to,$sugain[$sugainVersion],$to,
             $suximage[1],$go);
 $flow[2] = $run->modules(\@items);

 @items   = ($susort[1],$in,$inbound[1],$to,
	     $suwind[1],$to,$suwind[3],$to,
             $sufilter[1],$to,$sugain[$sugainVersion],$to,
             $suspecfx[1], $to,
             $suximage[1],$go);
 $flow[3] = $run->modules(\@items);

=head2 RUN FLOW(S)


=cut

 $run->flow(\$flow[1]);
 $run->flow(\$flow[2]);
 $run->flow(\$flow[3]);


=head2 LOG FLOW(S)

 TO SCREEN AND FILE

=cut

 #print  "$flow[1]\n";
#$log->file($flow[1]);

# print  "$flow[2]\n";
#$log->file($flow[2]);

 print  "$flow[3]\n";
#$log->file($flow[2]);

