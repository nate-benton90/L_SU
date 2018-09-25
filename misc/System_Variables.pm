package System_Variables;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

	NAME:     System_Variables.pm 
	Author:   Juan M. Lorenzo 
	Date:     December 15, 2011 
	Purpose:  Define all user directories  


 ALSO USES:

   Project_Variables package

 AS FOLLOWS:

  ($date) 		    = Project_Variables::date();
  ($line) 		    = Project_Variables::line();
  ($component();
  ($stage) 		    = Project_Variables::stage();
  ($process) 	  	    = Project_Variables::process();
  ($PROJECT_HOME)	    = Project_Variables::PROJECT_HOME();


 DIRECTORY DEFINITIONS
 Be careful in changing the following order
 because successive lines inherit from each other
   $DATE_LINE_COMPONENT_STAGE_PROCESS = $date.'/'.$line.'/'.$component.'/'.$stage.'/'.$process.'/'.$subUser;
   $GEOMAPS             = $PROJECT_HOME.'/geomaps';
   $WELL                = $PROJECT_HOME.'/well';
   $SEISMIC             = $PROJECT_HOME.'/seismics';
   $DATA_GEOMAPS    	= $GEOMAPS.'/data';
   $ANTELOPE		= $SEISMIC.'/antelope'; 
   $DATA_SEISMIC    	= $SEISMIC.'/data';
   $SEISMIC_SQLITE      = $SEISMIC.'/sqlite';
   $DATA_WELL    	= $WELL.'/data';
   $DATA_TYPE 		= 'raw/text';	

DATABASES
   $DATABASE_SEISMIC_SQLITE 	= $SEISMIC_SQLITE.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

 FAST DIRECTORY for TOMOGRAPHIC MODELING
   $FAST_TOMO           	= $SEISMIC.'/fast_tomo/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

GEOPSY DIRECTORY SURFACE WAVE MODELING
   $GEOPSY              	= $SEISMIC.'/geopsy/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;


IMAGES 
   $IMAGES_SEISMIC      	= $SEISMIC.'/images';
   $IMAGES_WELL	      		= $WELL.'/images';
   $GIF_SEISMIC		        = $IMAGES_SEISMIC.'/gif';
   $PS_SEISMIC         		= $IMAGES_SEISMIC.'/'.'ps';
   $PS_WELL         	        = $IMAGES_WELL.'/'.'ps'.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/;

JPEG IMAGE STORAGE DIRECTORY
   $JPEG              		= $IMAGES_SEISMIC.'/jpeg/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

INNOVATION INTEGRATION 


ISOLA DIRECTORY
 $ISOLA                         = $SEISMIC.'/isola/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;


MATLAB DIRECTORIES
   $MATLAB_SEISMIC      	= $SEISMIC.'/matlab/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;
   $MATLAB_WELL         	= $WELL.'/matlab/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

GMT SEISMIC
   $GMT_SEISMIC              = $SEISMIC.'/gmt/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

MMODPG DIRECTORY
   $MMODPG              	= $SEISMIC.'/mmodpg/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

# FAST DIRECTORY for 2D RAYTRACING
   $MOD2D_TOMO          	= $SEISMIC.'/fast_tomo/All/mod2d';

PERL DIRECTOIES
   $PL_SEISMIC          	= $SEISMIC.'/pl/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;
   $PL_WELL	        	= $WELL.'/pl/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

R DIRECTOIES
   $R_SEISMIC          	        = $SEISMIC.'/r/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;
   $R_WELL	        	= $WELL.'/r/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;


RAYGUI DIRECTORY for 2D RAYTRACING
   $RAYGUI              	= $SEISMIC.'/raygui/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

RAYINVR DIRECTORY for 2D RAYTRACING
   $RAYINVR             	= $SEISMIC.'/rayinvr/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

SH DIRECTORY
   $SH_SEISMIC          	= $SEISMIC.'/sh/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

# INNOVATION INTEGRATION
# SEISMIC DIRECTORY
  $DATA_SEISMIC_BIN         = $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/bin'.'/'.$subUser;

  $DATA_SEISMIC_DAT         = $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/dat'.'/'.$subUser;


  $DATA_SEISMIC_ININT         = $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/inint'.'/'.$subUser;


MATLAB SEISMIC DIRECTORY
   $DATA_SEISMIC_MATLAB         = $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/matlab'.'/'.$subUser;


PASSCAL SEGY DIRECTORY
   $DATA_SEISMIC_PASSCAL_SEGY   = $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/passcal_segy'.'/'.$subUser;

R DIRECTORY
   $DATA_SEISMIC_R   	= $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/r'.'/'.$subUser;

RSEIS DIRECTORY
   $DATA_SEISMIC_RSEIS   	= $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/rseis'.'/'.$subUser;

SAC DIRECTORY
   $DATA_SEISMIC_SAC   		= $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/sac'.'/'.$subUser;

SEG2 DIRECTORY
   $DATA_SEISMIC_SEG2   	= $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/dat'.'/'.$subUser;

SEGD DIRECTORY
   $DATA_SEISMIC_SEGD    	= $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/segd'.'/'.$subUser;

SIERRA SEGY DIRECTORY
   $DATA_SEISMIC_SIERRA_SEGY    = $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/sierra_segy'.'/'.$subUser;

SU DIRECTORY
   $DATA_SEISMIC_SU     	= $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/su'.'/'.$subUser;

SU DIRECTORY
   $DATA_SEISMIC_SU_RAW     	= $DATA_SEISMIC_SU.'/raw'.'/'.$subUser;

SEGY DIRECTORY
   $DATA_SEISMIC_SEGY   	= $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/segy'.'/'.$subUser;

SEGY DIRECTORY
   $DATA_SEISMIC_SEGY_RAW   	= $DATA_SEISMIC_SEGY.'/raw'.'/'.$subUser;

SEISMIC VELOCITY DIRECTORY
   $DATA_SEISMIC_VEL   		= $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/vel'.'/'.$subUser;

RAW SU DIRECTORY
  $DATA_SEISMIC_SU_RAW  	= $DATA_SEISMIC_SU.'/raw'.'/'.$subUser;

RAW SEGY DIRECTORY
  $DATA_SEISMIC_SEGY_RAW 	= $DATA_SEISMIC_SEGY.'/raw'.'/'.$subUser;

RAW TEXT DIRECTORY
  $DATA_SEISMIC_TXT 		= $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/txt'.'/'.$subUser;

GEOMAPS TEXT DIRECTORY
   $DATA_GEOMAPS_TEXT	 	= $DATA_GEOMAPS.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/text'.'/'.$subUser;

GEOMAPS BIN DIRECTORY
   $DATA_GEOMAPS_BIN	 	= $DATA_GEOMAPS.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/bin'.'/'.$subUser;

GEOMAPS IMAGES DIRECTORY
   $DATA_GEOMAPS_IMAGES	 	= $DATA_GEOMAPS.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/images'.'/'.$subUser;

# GEOMAPS IMAGES DIRECTORY
   my $DATA_GEOMAPS_IMAGES_JPEG	       	= $DATA_GEOMAPS.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/images'.'/jpeg'.'/'.$subUser;


# GEOMAPS IMAGES DIRECTORY
   my $DATA_GEOMAPS_IMAGES_TIF	       	= $DATA_GEOMAPS.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/images'.'/tif'.'/'.$subUser;


GEOMAPS TEMP DIRECTORY
   $TEMP_DATA_GEOMAPS	 	= $DATA_GEOMAPS.'/g'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/temp'.'/'.$subUser;

TEMPORARY SEISMIC DATA DIRECTORY
   $TEMP_DATA_SEISMIC    	= $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/temp'.'/'.$subUser;

TEMPORARY SEISMIC DATA DIRECTORY
   $TEMP_DATA_SEISMIC_SU    	= $DATA_SEISMIC_SU.'/.temp'.'/'.$subUser;

TOMO TEMP DIRECTORY
   $TEMP_FAST_TOMO	 	= $FAST_TOMO.'/temp'.'/'.$subUser;

WELL DATA DIRECTORY
   $DATA_WELL	 		= $WELL.'/data'.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

 
 USES the following classes:
 sucat
 and packages of subroutines
 System_Variables
 SeismicUnix

=cut

use Moose;

	use SeismicUnixPlTk_global_constants;
    use readfiles; 

=head2 Instantiate classes:

 Create a new version of the package 
 with a unique name
 read has containing configuration values 
 keys have the same name as the value they contain
 #my $fileNpath = `locate System_Viables_config.pl`;
 #my ($err,$CFG)       = $read ->cfg(\$fileNpath);
 #print("System_Variables, CFG is $CFG\n");
  #my ($err,$CFG)       = $read -> cfg("/usr/local/pl/System_Variables_config.pl");
  #chomp($fileNpath);

=cut

 	my $get				= new SeismicUnixPlTk_global_constants();
 	my $global_libs		= $get->global_libs();

    my $read             = new readfiles();
 	my $fileNpath        = $global_libs->{_param}."/System_Variables_config.pl";
 	my ($err,$CFG)       = $read ->cfg($fileNpath);

=head2 Subroutines
 
  are for older configuration files

=cut

=head2 Declare variables in namespace

 
=cut

 my($component,$stage,$process);
 my($HOME,$PROJECT_HOME,$site,$spare_dir,$date,$line,$subUser);


=head2 Initialize variables 

 
=cut

    $component		= '';
    $stage			= '';
    $process		= '';

=head2 Get new-style configuration information

  gets only values, not indices
  keys/indices have to be known
  beforehand

 DB
  print ("2.System_Variables, spare dir is $CFG->{Project_Variables}{1}{spare_dir}\n\n");
  print ("2.System_Variables,HOME is $CFG->{Project_Variables}{1}{HOME}\n\n");
  
=cut

  $HOME 		= $CFG->{Project_Variables}{1}{HOME};
  $PROJECT_HOME = $CFG->{Project_Variables}{1}{PROJECT_HOME};
  $site 		= $CFG->{Project_Variables}{1}{site};
  $spare_dir   	= $CFG->{Project_Variables}{1}{spare_dir};
  $date  		= $CFG->{Project_Variables}{1}{date};
  $component	= $CFG->{Project_Variables}{1}{component};
  $line			= $CFG->{Project_Variables}{1}{line};
  $subUser		= $CFG->{Project_Variables}{1}{subUser};



=head2 Check configuration file for errors

=cut

if ( $err) {
     print(STDERR $err, "\n");
         exit(1);
         }

=head2

 current conversion  
 from hydraulic fracturing format
 into seismic format

=cut

    my $site_bck      = $site;
    my $date_bck      = $date;
    my $line_bck      = $line;
    my $component_bck = $component;
    my $spare_dir_bck = $spare_dir;

    $date      		= $site_bck;
    $stage     		= $component_bck;
    $component 		= $date_bck;
    $process   		= $line_bck;
    $line      		= $spare_dir_bck;

=head2 for old-stype Project_Variable files 

 defaults to the local directory

=cut

 my $old_configuration_file = './Project_Variables.pm';

 if (-e  $old_configuration_file) {
   #print ("Looking for old-style configuration file\n\n");
   print("Using old-style configuration file\n\n");

   use Project_Variables;

    ($date) 		= Project_Variables::date();
    ($line) 		= Project_Variables::line();
    ($component) 	= Project_Variables::component();
    ($stage) 		= Project_Variables::stage();
    ($process) 		= Project_Variables::process();
    ($PROJECT_HOME)	= Project_Variables::PROJECT_HOME();
     $subUser           = ''; #only in  new configuration files;

}


=head2 DIRECTORY DEFINITIONS

 Be careful in changing the following order
 because successive lines inherit from each other

=cut

# META-DATA FILE STRUCTRUE
   my $DATE_LINE_COMPONENT_STAGE_PROCESS = $date.'/'.$line.'/'.$component.'/'.$stage.'/'.$process;

# BASE DATA TYPES
   my $GEOMAPS             		= $PROJECT_HOME.'/geomaps';
   my $WELL                		= $PROJECT_HOME.'/well';
   my $SEISMIC             		= $PROJECT_HOME.'/seismics';
   my $SURFACE             		= $PROJECT_HOME.'/surface';
   my $GAMMA_WELL    			= $WELL.'/gamma';
   my $RESISTIVITY_SURFACE    	= $SURFACE.'/resistivity';
   my $RESISTIVITY_WELL    		= $WELL.'/resistivity';

   my $DATA_WELL    			= $WELL.'/data';
   my $DATA_SEISMIC    			= $SEISMIC.'/data';
   my $DATA_RESISTIVITY_SURFACE = $RESISTIVITY_SURFACE.'/data';
   my $DATA_GEOMAPS    			= $GEOMAPS.'/data';
   my $DATA_TYPE 				= 'raw/text';	

# TOOL DATA TYPES
   my $DATA_GAMMA_WELL    		= $GAMMA_WELL.'/data';
   my $DATA_RESISTIVITY_WELL    = $RESISTIVITY_WELL.'/data';

   # database
   my $SEISMIC_SQLITE      		= $SEISMIC.'/sqlite';
   my $SQLITE_SEISMIC     		= $SEISMIC.'/sqlite';

# SOFTWARE ANTELOPE 
   my $ANTELOPE					= $SEISMIC.'/antelope'; 

# DATABASES
   my $DATABASE_SEISMIC_SQLITE 	= $SEISMIC_SQLITE.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;
   my $DATABASE_SQLITE_SEISMIC 	= $SQLITE_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

# FAST DIRECTORY for TOMOGRAPHIC MODELING
   my $FAST_TOMO           	= $SEISMIC.'/fast_tomo/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

# GEOPSY DIRECTORY SURFACE WAVE MODELING
   my $GEOPSY              	= $SEISMIC.'/geopsy/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

# IMAGES 
   my $IMAGES_SEISMIC      	= $SEISMIC.'/images';
   my $IMAGES_WELL	      	= $WELL.'/images';
   my $GIF_SEISMIC			= $IMAGES_SEISMIC.'/gif';
   my $PS_SEISMIC         	= $IMAGES_SEISMIC.'/'.'ps'.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;
   my $PS_WELL         	  	= $IMAGES_WELL.'/'.'ps'.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

# JPEG IMAGE STORAGE DIRECTORY
   my $JPEG              	= $IMAGES_SEISMIC.'/jpeg/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

# ISOLA DIRECTORY
   my $ISOLA              	= $SEISMIC.'/isola/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

# GMT SEISMIC
   my $GMT_SEISMIC              = $SEISMIC.'/gmt/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

# GMT GEOMAPS 
   my $GMT_GEOMAPS              = $GEOMAPS.'/gmt/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

# PROGRAMMING LANGUAGES
  my $C_SEISMIC                 = $SEISMIC.'/c/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;
  my $CPP_SEISMIC               = $SEISMIC.'/cpp/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

# MATLAB DIRECTORIES
   my  $MATLAB_SEISMIC      	= $SEISMIC.'/matlab/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;
   my  $MATLAB_WELL         	= $WELL.'/matlab/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;
   my  $MATLAB_GEOMAPS         	= $GEOMAPS.'/matlab/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

# MMODPG DIRECTORY
    my  $MMODPG              	= $SEISMIC.'/mmodpg/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

# FAST DIRECTORY for 2D RAYTRACING
    my $MOD2D_TOMO          	= $SEISMIC.'/fast_tomo/All/mod2d';

# PERL DIRECTOIES
   my $PL_SEISMIC          	   	= $SEISMIC.'/pl/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;
   my $PL_GEOMAPS          	   	= $GEOMAPS.'/pl/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;
   my $PL_WELL	        		= $WELL.'/pl/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

# R DIRECTORIES
   my $R_RESISTIVITY_WELL	    = $RESISTIVITY_WELL.'/r/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;
   my $R_RESISTIVITY_SURFACE    = $RESISTIVITY_SURFACE.'/r/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;
   my $R_GAMMA_WELL	    		= $GAMMA_WELL.'/r/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;
   my $R_SEISMIC          	    = $SEISMIC.'/r/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;
   my $R_WELL	        		= $WELL.'/r/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;


# RAYGUI DIRECTORY for 2D RAYTRACING
   my $RAYGUI              	      = $SEISMIC.'/raygui/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

# RAYINVR DIRECTORY for 2D RAYTRACING
   my $RAYINVR             	     = $SEISMIC.'/rayinvr/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

# SH DIRECTORY
   my $SH_SEISMIC          	     = $SEISMIC.'/sh/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

# WELL RESITIVITY DATA in TXT format
   my $DATA_RESISTIVITY_WELL_TXT        = $DATA_RESISTIVITY_WELL.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/txt'.'/'.$subUser;

# SURFACE RESITIVITY
  my $DATA_RESISTIVITY_SURFACE_TXT        = $DATA_RESISTIVITY_SURFACE.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/txt'.'/'.$subUser;

# WELL RESITIVITY DATA in TXT format
   my $DATA_GAMMA_WELL_TXT        		= $DATA_GAMMA_WELL.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/txt'.'/'.$subUser;

# SEISMIC DIRECTORY
   my $DATA_SEISMIC_BIN              = $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/bin'.'/'.$subUser;

   my $DATA_SEISMIC_DAT              = $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/dat'.'/'.$subUser;

# INNOVATION INTEGRATION
   my $DATA_SEISMIC_ININT            = $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/inint'.'/'.$subUser;

# MATLAB SEISMIC DIRECTORY
   my $DATA_SEISMIC_MATLAB          = $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/matlab'.'/'.$subUser;

# PASSCAL SEGY DIRECTORY
   my $DATA_SEISMIC_PASSCAL_SEGY    = $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/passcal_segy'.'/'.$subUser;

# R DIRECTORY
   my $DATA_SEISMIC_R   	      = $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/r'.'/'.$subUser;

# SAC DIRECTORY
# RSEIS DIRECTORY
   my $DATA_SEISMIC_RSEIS   	      = $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/rseis'.'/'.$subUser;

# SAC DIRECTORY
   my $DATA_SEISMIC_SAC   		      = $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/sac'.'/'.$subUser;

# SEG2 DIRECTORY
   my $DATA_SEISMIC_SEG2   	      = $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/dat'.'/'.$subUser;

# SEGD DIRECTORY
   my $DATA_SEISMIC_SEGD   	      = $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/segd'.'/'.$subUser;

# SIERRA SEGY DIRECTORY
   my $DATA_SEISMIC_SIERRA_SEGY  = $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/sierra_segy'.'/'.$subUser;

# SU DIRECTORY
   my $DATA_SEISMIC_SU     	     = $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/su'.'/'.$subUser;

# SU DIRECTORY
   my $DATA_SEISMIC_SU_RAW     	  = $DATA_SEISMIC_SU.'/raw'.'/'.$subUser;

# SEGY DIRECTORY
   my $DATA_SEISMIC_SEGY   	     = $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/segy'.'/'.$subUser;

# SEGY DIRECTORY
   my $DATA_SEISMIC_SEGY_RAW      = $DATA_SEISMIC_SEGY.'/raw'.'/'.$subUser;

# SEISMIC VELOCITY DIRECTORY
   my $DATA_SEISMIC_VEL   		  = $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/vel'.'/'.$subUser;

# RAW TXT DIRECTORY
   my $DATA_SEISMIC_TXT     	  = $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/txt'.'/'.$subUser;

# GEOMAPS TEXT DIRECTORY
   my $DATA_GEOMAPS_TEXT	 	   = $DATA_GEOMAPS.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/text'.'/'.$subUser;

# GEOMAPS TOPOGRAPHY DIRECTORY
   my $DATA_GEOMAPS_TOPO	 	   = $DATA_GEOMAPS.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/topo'.'/'.$subUser;

# GEOMAPS BIN DIRECTORY
   my $DATA_GEOMAPS_BIN	       	   = $DATA_GEOMAPS.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/bin'.'/'.$subUser;

# GEOMAPS IMAGES DIRECTORY
   my $GEOMAPS_IMAGES	       	= $GEOMAPS.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/images'.'/'.$subUser;

# GEOMAPS IMAGES DIRECTORY
   my $GEOMAPS_IMAGES_JPEG	       	= $GEOMAPS.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/images'.'/jpeg'.'/'.$subUser;

# GEOMAPS IMAGES DIRECTORY
   my $GEOMAPS_IMAGES_TIF	       	= $GEOMAPS.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/images'.'/tif'.'/'.$subUser;

# GEOMAPS IMAGES DIRECTORY
   my $GEOMAPS_IMAGES_PS	       	= $GEOMAPS.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/images'.'/ps'.'/'.$subUser;

# GEOMAPS TEMP DIRECTORY
   my $TEMP_DATA_GEOMAPS	 	      = $DATA_GEOMAPS.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/temp'.'/'.$subUser;

# TEMPORARY SEISMIC DATA DIRECTORY
   my $TEMP_DATA_SEISMIC    	    = $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/temp'.'/'.$subUser;
 

# TEMPORARY SEISMIC DATA DIRECTORY
   my $TEMP_DATA_SEISMIC_SU    		= $DATA_SEISMIC_SU.'/.temp'.'/'.$subUser;

# TOMO TEMP DIRECTORY
   my $TEMP_FAST_TOMO	 	        = $FAST_TOMO.'/temp'.'/'.$subUser;

# WELL DATA DIRECTORY
     $DATA_WELL	 	             	= $WELL.'/data'.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;


sub date{
        return ($date);
}

sub ANTELOPE{
        return ($ANTELOPE);
}

sub DATA_GEOMAPS{
        return ($DATA_GEOMAPS);
}


sub DATA_GEOMAPS_BIN{
        return ($DATA_GEOMAPS_BIN);
}

sub DATA_GEOMAPS_TOPO{
        return ($DATA_GEOMAPS_TOPO);
}

sub GEOMAPS_IMAGES{
        return ($GEOMAPS_IMAGES);
}

sub GEOMAPS_IMAGES_JPEG{
        return ($GEOMAPS_IMAGES_JPEG);
}

sub GEOMAPS_IMAGES_TIF{
        return ($GEOMAPS_IMAGES_TIF);
}

sub GEOMAPS_IMAGES_PS{
        return ($GEOMAPS_IMAGES_PS);
}

sub DATA_GEOMAPS_TEXT {
        return ($DATA_GEOMAPS_TEXT);
}

sub PROJECT_HOME{
        return ($PROJECT_HOME);
}


sub DATA_GAMMA_WELL {
       return ($DATA_GAMMA_WELL);
}

sub DATA_GAMMA_WELL_TXT {
       return ($DATA_GAMMA_WELL_TXT);
}

sub DATA_RESISTIVITY_SURFACE {
       return ($DATA_RESISTIVITY_SURFACE);
}

sub DATA_RESISTIVITY_SURFACE_TXT {
       return ($DATA_RESISTIVITY_SURFACE_TXT);
}

sub DATA_RESISTIVITY_WELL {
       return ($DATA_RESISTIVITY_WELL);
}

sub DATA_RESISTIVITY_WELL_TXT {
       return ($DATA_RESISTIVITY_WELL_TXT);
}

sub DATA_SEISMIC_BIN {
        return ($DATA_SEISMIC_BIN);
}

sub DATA_SEISMIC_DAT {
        return ($DATA_SEISMIC_DAT);
}


sub DATA_SEISMIC_ININT {
        return ($DATA_SEISMIC_ININT);
}

sub DATA_SEISMIC_MATLAB {
        return ($DATA_SEISMIC_MATLAB);
}

sub  GMT_SEISMIC {
        return ($GMT_SEISMIC);
}            

sub  GMT_GEOMAPS {
        return ($GMT_GEOMAPS);
}  

sub MMODPG {
        return ($MMODPG);
}

sub DATA_SEISMIC {
        return ($DATA_SEISMIC);
}

sub DATA_SEISMIC_PASSCAL_SEGY {
        return ($DATA_SEISMIC_PASSCAL_SEGY);
}

sub DATA_SEISMIC_R {
        return ($DATA_SEISMIC_R);
}


sub DATA_SEISMIC_RSEIS {
        return ($DATA_SEISMIC_RSEIS);
}

sub DATA_SEISMIC_SAC {
        return ($DATA_SEISMIC_SAC);
}

sub DATA_SEISMIC_SEG2 {
        return ($DATA_SEISMIC_SEG2);
}

sub DATA_SEISMIC_SEGD {
        return ($DATA_SEISMIC_SEGD);
}

sub DATA_SEISMIC_SEGY {
        return ($DATA_SEISMIC_SEGY);
}

sub DATA_SEISMIC_SEGY_RAW {
        return ($DATA_SEISMIC_SEGY_RAW);
}

sub DATA_SEISMIC_SIERRA_SEGY {
        return ($DATA_SEISMIC_SIERRA_SEGY);
}

sub DATA_SEISMIC_SU {
        return ($DATA_SEISMIC_SU);
}

sub DATA_SEISMIC_SU_RAW {
        return ($DATA_SEISMIC_SU_RAW);
}

sub DATA_SEISMIC_TXT {
        return ($DATA_SEISMIC_TXT);
}

sub DATA_SEISMIC_VEL {
        return ($DATA_SEISMIC_VEL);
}


sub DATABASE_SEISMIC_SQLITE {
        return ($DATABASE_SEISMIC_SQLITE);
}

sub DATA_WELL {
        return ($DATA_WELL);
}


sub FAST_TOMO {
	# This subroutine returns the value of FAST_TOMO 
	#print ("\n$FAST_TOMO\n");
        return ($FAST_TOMO);
}

sub GEOPSY {
        return ($GEOPSY);
}

sub GIF_SEISMIC {
        return ($GIF_SEISMIC);
}

sub ISOLA {
        return ($ISOLA);
}

sub JPEG {
        return ($JPEG);
}

sub C_SEISMIC {
        return ($C_SEISMIC);
}

sub CPP_SEISMIC {
        return ($CPP_SEISMIC);
}


sub MATLAB_GEOMAPS {
        return ($MATLAB_GEOMAPS);
}

sub MATLAB_WELL {
        return ($MATLAB_WELL);
}


sub MATLAB_SEISMIC {
        return ($MATLAB_SEISMIC);
}


sub MOD2D_TOMO {
        return ($MOD2D_TOMO);
}

sub PL_SEISMIC {
	# This subroutine returns the value of PL_SEISMIC 
	#print ("\n$PL_SEISMIC\n");
        return ($PL_SEISMIC);
}

sub PL_GEOMAPS {
        return ($PL_GEOMAPS);
}

sub PL_WELL {
        return ($PL_WELL);
}

sub RESISTIVITY_SURFACE {
       return ($RESISTIVITY_SURFACE);
}

sub R_GAMMA_WELL {
        return ($R_GAMMA_WELL);
}

sub R_RESISTIVITY_SURFACE {
        return ($R_RESISTIVITY_SURFACE);
}

sub R_RESISTIVITY_WELL {
        return ($R_RESISTIVITY_WELL);
}

sub R_SEISMIC {
        return ($R_SEISMIC);
}

sub R_WELL {
        return ($R_WELL);
}

sub SH_SEISMIC {
        return ($SH_SEISMIC);
}

sub PS_SEISMIC {
        return ($PS_SEISMIC);
}

sub PS_WELL {
        return ($PS_WELL);
}


sub RAYINVR {
	# This subroutine returns the value of RAYINVR 
	#print ("\n$RAYINVR\n");
        return ($RAYINVR);
}
sub  SURFACE {
        return ($SURFACE);
}


sub TEMP_DATA_GEOMAPS {
        return ($TEMP_DATA_GEOMAPS);
}

sub TEMP_DATA_SEISMIC {
        return ($TEMP_DATA_SEISMIC);
}

sub TEMP_DATA_SEISMIC_SU {
        return ($TEMP_DATA_SEISMIC_SU);
}

sub TEMP_FAST_TOMO {
        return ($TEMP_FAST_TOMO);
}


sub WELL {
        return ($WELL);
}

1;
