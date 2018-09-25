#!/usr/bin/perl  -w

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PERL PROGRAM NAME: iVA_config.pl 
 AUTHOR: Juan Lorenzo
 DATE: Aug 18 2016 
       July 19 2017
 DESCRIPTION Combines configuration variables
     both from a simple text file and from
     from additional packages.

 USED FOR IVA2 (interactive velocity analysis)

 Version 2 based on Sucat.pm June 29 2016
    Added a simple configuration file readable 
    and writable using Config::Simple (CPAN)

    package control replaces commas in strings
    needed by Seismic Unix

  July 19 2017 - added tmax_s parameter to configuration file
     

=cut

=head2 Notes from bash

  cat file1 file2 >output file
 	#my $cfg 		= new Config::Simple('iVA.config');
 
=cut 

 	use Moose;
 	use Config::Simple;
 	use SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su);
 	use control;
	use SeismicUnixPlTk_global_constants;
	my $get  	= new SeismicUnixPlTk_global_constants();
 	my $alias_superflow_config_name  = $get->alias_superflow_config_names_aref();
			#WARNING---- watch out for missing underscore!!
			  print("1. iVA_config, alias_superflow_config_name : $$alias_superflow_config_name[3].'.config'\n");

 	my $cfg 					= new Config::Simple($$alias_superflow_config_name[3].'.config');
 	my $control 	= new control;

=head2 Example LOCAL VARIABLES FOR THIS PROJECT

 Values taken from the simple,local
 file: iVA.config called
 LOCAL VARIABLES FOR THIS PROJECT
     file_name  		= 'All_cmp'
     cdp_first   		= 15
     cdp_inc    		= 1
     cdp_last    		= 100
     tmax_s                     = .2
     data_scale    		= 1
     dt_s    			= .004
     freq    		        = '0,3,100,200'
     number_of_velocities   	= 300
     first_velocity   	        = 3
     velocity_increment   	= 10
     min_semblance    	        = .0
     max_semblance    	        = .75
     
 #print(" file name is $file_name\n\n");
 #print ("Variable1 is $key\n\n"); 
 #
   
=cut 
 
 my $file_name 				= $cfg->param("file_name"); 
 my $cdp_first  			= $cfg->param("cdp_first"); 
 my $cdp_inc  				= $cfg->param("cdp_inc"); 
 my $cdp_last  				= $cfg->param("cdp_last"); 
 my $data_scale  			= $cfg->param("data_scale"); 
 my $dt_s  					= $cfg->param("dt_s"); 
 my $tmax_s  				= $cfg->param("tmax_s"); 
 my $freq  					= $cfg->param("freq"); 
 my $number_of_velocities  	= $cfg->param("number_of_velocities"); 
 my $first_velocity  		= $cfg->param("first_velocity"); 
 my $velocity_increment  	= $cfg->param("velocity_increment"); 
 my $min_semblance  		= $cfg->param("min_semblance"); 
 my $max_semblance  		= $cfg->param("max_semblance"); 

     $freq 		= $control->commas(\$freq);
     #print(" 1. readfiles,config, for iVA, file_name is $file_name\n\n");
     $file_name 		= $control->su_file_name(\$file_name);
     #print(" 1. readfiles,config, for iVA, file_name is $file_name \n\n");


 our $CFG = {
    iva => {
         1 => {
		file_name 					=> $file_name, 
        	cdp_first  				=> $cdp_first,
        	cdp_inc 				=> $cdp_inc,
        	cdp_last 				=> $cdp_last,
        	tmax_s 					=> $tmax_s,
        	data_scale 				=> $data_scale,
        	dt_s 					=> $dt_s,
        	freq 					=> $freq,
        	first_velocity 			=> $first_velocity,
        	min_semblance 			=> $min_semblance,
        	max_semblance 			=> $max_semblance,
        	number_of_velocities 	=> $number_of_velocities,
        	velocity_increment 		=> $velocity_increment
         }      
    }
 };  
  
