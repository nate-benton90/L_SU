package Project;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

	NAME:     Project 
	Author:   Juan M. Lorenzo 
	Date:     December 31, 2017 
	Purpose:  Helps create Project Directores  
 		      Helps establish system-wide and local directories

=head2 NEEDS

 System_Variables package
 manage_dirs_by package

=cut

=head2 CHANGES and their DATES

 V. 1.0.2 May 3, 2018  Project.config also exists in
 ~/home/user/.LSU/configuration/Project_name/Project/Project.config

=head2 Declare variables in namespace

 
=cut

	use Moose;
	our $VERSION = '1.0.2';
	
	use manage_dirs_by;
	use control;
	use readfiles;
	use SeismicUnixPlTk_global_constants;
	my $read    				= new readfiles;
	my $control					= control->new;
	my $get  					= new SeismicUnixPlTk_global_constants();
	my $global_lib  			= $get->global_libs();
 	my $GLOBAL_CONFIG_LIB      	= $global_lib->{_param};

	my $Project = {
	_ref_DIR 						=> '',
	_ref_DIR_FUNCTION 				=> '',
	_HOME               			=> '',
	_date 							=> '',
	_geomaps_is_selected			=> '',
	_sqlite_is_selected				=> '',
	_line 							=> '',
	_component 						=> '',
	_stage 							=> '',
	_process 						=> '', 
	_PROJECT_HOME 					=> '', 
	_subUse  						=> '',
	_ANTELOPE  						=> '',
	_DATA_GEOMAPS					=> '',
	_DATA_GEOMAPS_BIN				=> '',
	_DATA_GEOMAPS_TEXT				=> '',
	_DATA_GEOMAPS_TOPO				=> '',
	_GEOMAPS_IMAGES					=> '',
	_GEOMAPS_IMAGES_JPEG			=> '',
	_GEOMAPS_IMAGES_TIF				=> '',
	_GEOMAPS_IMAGES_PS				=> '',
	_PROJECT_HOME					=> '',
	_DATA_GAMMA_WELL				=> '',
	_DATA_GAMMA_WELL_TXT			=> '',
	_DATA_RESISTIVITY_SURFACE		=> '',
	_DATA_RESISTIVITY_SURFACE_TXT	=> '',
	_DATA_RESISTIVITY_WELL			=> '',
	_DATA_RESISTIVITY_WELL_TXT		=> '',
	_GMT_SEISMIC					=> '',
	_GMT_GEOMAPS					=> '',
	_GRASS_GEOMAPS					=> '',
	_MMODPG							=> '',
	_DATA_SEISMIC					=> '',
	_DATA_SEISMIC_BIN				=> '',
	_DATA_SEISMIC_DAT				=> '',
	_DATA_SEISMIC_ININT				=> '',
	_DATA_SEISMIC_MATLAB			=> '',
	_DATA_SEISMIC_PASSCAL_SEGY		=> '',
	_DATA_SEISMIC_R					=> '',
	_DATA_SEISMIC_RSEIS				=> '',
	_DATA_SEISMIC_SAC				=> '',
	_DATA_SEISMIC_SEG2				=> '',
	_DATA_SEISMIC_SEGD				=> '',
	_DATA_SEISMIC_SEGY				=> '',
	_DATA_SEISMIC_SEGY_RAW			=> '',
	_DATA_SEISMIC_SIERRA_SEGY		=> '',
	_DATA_SEISMIC_SU				=> '',
	_DATA_SEISMIC_SU_RAW			=> '',
	_DATA_SEISMIC_TXT				=> '',
	_DATA_SEISMIC_VEL				=> '',
	_DATABASE_SEISMIC_SQLITE		=> '',
	_DATA_WELL						=> '',
	_FAST_TOMO						=> '',
	_GEOPSY							=> '',
	_GIF_SEISMIC					=> '',
	_ISOLA							=> '',
	_JPEG							=> '',
	_C_SEISMIC						=> '',
	_CPP_SEISMIC					=> '',
	_MATLAB_GEOMAPS					=> '',
	_MATLAB_WELL					=> '',
	_MATLAB_SEISMIC					=> '',
	_MOD2D_TOMO						=> '',
	_PL_SEISMIC						=> '',
	_PL_GEOMAPS						=> '',
	_PL_WELL						=> '',
	_RESISTIVITY_SURFACE			=> '',
	_R_GAMMA_WELL					=> '',
	_R_RESISTIVITY_SURFACE			=> '',
	_R_RESISTIVITY_WELL_R_SEISMIC	=> '',
	_R_WELL							=> '',
	_SH_SEISMIC						=> '',
	_PS_SEISMIC						=> '',
	_PS_WELL						=> '',
	_RAYINVR						=> '',
	_SURFACE						=> '',
	_TEMP_DATA_GEOMAPS				=> '',
	_TEMP_DATA_SEISMIC				=> '',
	_TEMP_DATA_SEISMIC_SU			=> '',
	_TEMP_FAST_TOMO					=> '',
	_WELL							=> '',
};


=head2 sub _basic_dirs

    	e.g., $GLOBAL_CONFIG_LIB:  as /usr/local/pl/L_SU/big_streams/config
=cut

sub _basic_dirs {
	my ($self) = @_;
	use L_SU_local_user_constants;
	
	my $user_constants   	= L_SU_local_user_constants->new();	
	my $ACTIVE_PROJECT		= $user_constants->get_ACTIVE_PROJECT();
	
	my $prog_name 			= '';
	my $prog_name_new 		= 'Project';
	my $prog_name_old 		= 'Project_Variables';
	my $prog_name_config 	= '';
    
    	# 1. check local directory first LEGACY Project_Variables file
    if(-e $prog_name_old.'.config') { 
    	
    	$prog_name 			= $prog_name_old;
     	    	print("Project,_basic_dirs,using local $prog_name.config\n");      	
    	$prog_name_config	= $prog_name_old.'.config';
     	
    	my ($ref_DIR_FUNCTION,$ref_DIR) = $read->configs(($prog_name.'.config'));
    	$Project->{_ref_DIR} 			= $ref_DIR;
    	    print(" 1. Project,basic_dirs,ref_DIR:@{$Project->{_ref_DIR}}\n");
    	$Project->{_ref_DIR_FUNCTION} 	= $ref_DIR_FUNCTION;
    	_change_basic_dirs();
    	   	
    	# 2. then, check local directory for Project.config
    } elsif (-e $prog_name_new.'.config') {
    	
    	$prog_name 			= $prog_name_new;       # system uses $GLOBAL_CONFIG_LIB.'/'.$prog_name_new
    	$prog_name_config	= $prog_name_new.'.config';  # i.e. Project.config
    	
    	# 3. then check user configuration directory for Project.config
    } elsif (-e $ACTIVE_PROJECT.'/'.$prog_name_new.'.config') {
    	 	
    	$prog_name 			= $prog_name_new;  # system uses $GLOBAL_CONFIG_LIB.'/'.$prog_name_new
    	$prog_name_config	= $ACTIVE_PROJECT.'/'.$prog_name_new.'.config';    # i.e. /home/gom/.L_SU/configuration/active/Project.config
    	my ($ref_DIR_FUNCTION,$ref_DIR) = $read->configs(($ACTIVE_PROJECT.'/'.$prog_name_new.'.config'));
    	$Project->{_ref_DIR} 			= $ref_DIR;
    	    	    print(" 2. Project,basic_dirs,ref_DIR:@{$Project->{_ref_DIR}}\n");
    	$Project->{_ref_DIR_FUNCTION} 	= $ref_DIR_FUNCTION;
    	_change_basic_dirs();
    	
    }else { # 4. If nothing exists so you will have to 
    		# a. create the correct files and directories
    		# B. set THE PATH NAME as the user configuration path
    		# copy a default Project configuration file from
    		# the GLOBAL_LIBS directory defined in
    		# SeismicUnixPlTk_global_constants.pm		
				print ("Project, _basic_dirs, no configuration files exist\n");

    	
    	# make the default configuration directory for the user
    	$user_constants		->mkconfig();
    	
    	if (($user_constants->user_configuration_Project_config_exists)) { 
    		print ("Project, _basic_dirs, Project.config in user configuration dir. created\n");
    	}else
    	{
    		print ("Project,  _basic_dirs, Project.config not created in user configuration dir.\n");
    	}
    }

     	# print("1. Project,_basic_dirs, prog_name_config: $prog_name_config \n");
     	
    
    if ($prog_name ne '') {  # safe condition
    			# print("Project,_basic_dirs,reading $prog_name_config\n");
    	my ($ref_DIR_FUNCTION,$ref_DIR) = $read->configs(($prog_name_config));
    	$Project->{_ref_DIR} 			= $ref_DIR;
    	    	# print("4. Project,_basic_dirs,ref_DIR: @{$Project->{_ref_DIR}}\n");
    	$Project->{_ref_DIR_FUNCTION} 	= $ref_DIR_FUNCTION;
    	_change_basic_dirs();
    } else {
    		# print("3. Project,_basic_dirs,$prog_name_config is missing\n");
    }	

	return();
} 


sub basic_dirs {
	my ($self) = @_;
	use L_SU_local_user_constants;
	
	# Find out HOME directory and configuration path for user    
	my $user_constants   	= L_SU_local_user_constants->new();
	my $ACTIVE_PROJECT	= $user_constants->get_ACTIVE_PROJECT();
	
	my $prog_name 		 = '';
    	my $prog_name_new    	= 'Project';
    	my $prog_name_old    	= 'Project_Variables'; 
    
   # 1. check local directory first LEGACY Project_Variables file
    if (-e $prog_name_new.'.config') { 

    	$prog_name 			= $prog_name_new;
    	    	print("Project,basic_dirs,using local $prog_name.config\n");    	
    	my ($ref_DIR_FUNCTION,$ref_DIR) = $read->configs(($prog_name.'.config'));
    	$Project->{_ref_DIR} 			= $ref_DIR;
    	    	    print(" 3. Project,basic_dirs,ref_DIR:@{$Project->{_ref_DIR}}\n");
    	$Project->{_ref_DIR_FUNCTION} 	= $ref_DIR_FUNCTION;
    	_change_basic_dirs();

      
      # in local user directory
    } elsif (-e ($ACTIVE_PROJECT.'/'.$prog_name_new.'.config') ) { 

    	$prog_name 						= $prog_name_new;
      	    	print("Project,basic_dirs,using local $ACTIVE_PROJECT/$prog_name .config\n");  	
    	my ($ref_DIR_FUNCTION,$ref_DIR) = $read->configs(($ACTIVE_PROJECT.'/'.$prog_name_new.'.config'));
    	$Project->{_ref_DIR} 			= $ref_DIR;
    	    	    print(" 2. Project,basic_dirs,ref_DIR:@{$Project->{_ref_DIR}}\n");
    	$Project->{_ref_DIR_FUNCTION} 	= $ref_DIR_FUNCTION;
    	_change_basic_dirs();

    	
    	# in user configuration directory
    } elsif (-e $prog_name_old.'.config')  {
    	
    	$prog_name 						= $prog_name_old;
    	    	print("Project,basic_dirs,using local $prog_name.config\n");

    	my ($ref_DIR_FUNCTION,$ref_DIR) = $read->configs(($prog_name.'.config'));
    	$Project->{_ref_DIR} 			= $ref_DIR;
    	    print(" 1. Project,basic_dirs,ref_DIR:@{$Project->{_ref_DIR}}\n");
    	$Project->{_ref_DIR_FUNCTION} 	= $ref_DIR_FUNCTION;
    	_change_basic_dirs();

    } else {
    	print("Project,basic_dirs,$prog_name.config is missing\n");
    }	

	return();
}
=head2  Up-to-date
	
	 configuration file

=cut 

sub _change_basic_dirs {
	my ($self) = @_;
	use control;
	my $control = control->new();
	
	my @CFG; 
	my($component,$stage,$process);	
	my($date,$line,$subUser);
    my($HOME,$PROJECT_HOME,$site,$spare_dir);
    my ($geomaps_logic,$sqlite_logic,$gmt_logic,$grass_logic);
    # TODO my ()$matlab,$fast,$mmodpg,gmt); 
    # print(" 5. Project,make_local_dirs,ref_DIR:@{$Project->{_ref_DIR}}\n");
	my $length = scalar @{$Project->{_ref_DIR}};
	
	for (my $i=0, my $j=0; $i < $length; $i++, $j=$j+2) {
					#print(" 6. Project,make_local_dirs,ref_DIR:@{$Project->{_ref_DIR}}[$i]\n");
		$CFG[$j]     	=  @{$Project->{_ref_DIR_FUNCTION}}[$i];
		$CFG[($j+1)] 	=  @{$Project->{_ref_DIR}}[$i];
					# print("$CFG[$j] = $CFG[($j+1)]\n");
	}
	
	$HOME 						= $CFG[1];
  	$PROJECT_HOME 				= $CFG[3];
  	$site 						= $CFG[5];
  	# use scalar ref
  	$spare_dir   				= $control->empty_directory(\$CFG[7]);
  	$date  						= $CFG[9];
  	$component					= $CFG[11];
  	$line						= $CFG[13];
  	$subUser					= $CFG[15];
  	# for (my $i=0; $i < 21; $i++ ) {
  		# print("Project,CFG[($i)],CFG[($i+1)]: $CFG[$i], $CFG[($i+1)]\n");
  	# }
  	$geomaps_logic				= $control->set_str2logic($CFG[17]);
  	$sqlite_logic				= $control->set_str2logic($CFG[19]);
  	$gmt_logic					= $control->set_str2logic($CFG[21]);
  	$grass_logic				= $control->set_str2logic($CFG[23]);
  	
				# print("1. Project.pm,PROJECT_HOME=$Project->{_PROJECT_HOME}\n");
				# print("1. Project.pm,spare_dir=----$spare_dir----\n");
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

=head3 for old-stype Project_Variable files 

 defaults in the local directory

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
     $subUser       = ''; #only in  new configuration files;

 }
 
    # assumes an up-to-date locally available
 	# configuration file
 	
 	$Project->{_HOME} 				= $HOME;
	$Project->{_date} 				= $date;
	$Project->{_line} 				= $line;	
	$Project->{_component} 			= $component;	
	$Project->{_stage} 				= $stage;	
	$Project->{_process} 			= $process;
	$Project->{_PROJECT_HOME} 		= $PROJECT_HOME;
	$Project->{_subUser} 			= $subUser;
	$Project->{_geomaps_is_selected}= $geomaps_logic;
	$Project->{_sqlite_is_selected} = $sqlite_logic;
	$Project->{_gmt_is_selected}    = $gmt_logic;
 	$Project->{_grass_is_selected}  = $grass_logic;	
	
	return();
}
   
=head2 DIRECTORY DEFINITIONS

 Be careful in changing the following order
 clean ticks if needed

=cut

sub _system_dirs {
	
    my $HOME 			= $Project->{_HOME};
	my $date 			= $Project->{_date};
	my $line 			= $Project->{_line};	
	my $component 		= $Project->{_component};	
	my $stage 			= $Project->{_stage};	
	my $process 		= $Project->{_process};
	my $PROJECT_HOME 	= $Project->{_PROJECT_HOME};
	$PROJECT_HOME 		=~ s/\'//g; 
	my $subUser 		= $Project->{_subUser};
	$subUser 			=~ s/\'//g; 

# META-DATA FILE STRUCTRUE
   my $DATE_LINE_COMPONENT_STAGE_PROCESS = $date.'/'.$line.'/'.$component.'/'.$stage.'/'.$process;
   $DATE_LINE_COMPONENT_STAGE_PROCESS =~ s/\'//g;

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

# GRASS GEOMAPS 
   my $GRASS_GEOMAPS              = $GEOMAPS.'/grass/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

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
   my $DATA_SEISMIC_SEG2   	      = $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/seg2'.'/'.$subUser;

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
	 #print("2. Project,DATA_GEOMAPS_TEXT=$DATA_GEOMAPS_TEXT\n");

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


	$Project->{_ANTELOPE}					= $ANTELOPE;					
 	$Project->{_DATA_GEOMAPS}				= $DATA_GEOMAPS;					
 	$Project->{_DATA_GEOMAPS_BIN}			= $DATA_GEOMAPS_BIN;				
 	$Project->{_DATA_GEOMAPS_TOPO}			= $DATA_GEOMAPS_TOPO;		
 	$Project->{_GEOMAPS_IMAGES}				= $GEOMAPS_IMAGES;					
 	$Project->{_GEOMAPS_IMAGES_JPEG}		= $GEOMAPS_IMAGES_JPEG;			
 	$Project->{_GEOMAPS_IMAGES_TIF}			= $GEOMAPS_IMAGES_TIF;				
 	$Project->{_GEOMAPS_IMAGES_PS}			= $GEOMAPS_IMAGES_PS;				
 	$Project->{_DATA_GEOMAPS_TEXT}			= $DATA_GEOMAPS_TEXT;				
	#print("3. Project,DATA_GEOMAPS_TEXT=$DATA_GEOMAPS_TEXT\n");

 	$Project->{_PROJECT_HOME}				= $PROJECT_HOME;					
 	$Project->{_DATA_GAMMA_WELL}			= $DATA_GAMMA_WELL;			
 	$Project->{_DATA_GAMMA_WELL_TXT}		= $DATA_GAMMA_WELL_TXT;	
 	$Project->{_DATA_RESISTIVITY_SURFACE}	= $DATA_RESISTIVITY_SURFACE;		
 	$Project->{_DATA_RESISTIVITY_SURFACE_TXT}	= $DATA_RESISTIVITY_SURFACE_TXT;	
 	$Project->{_DATA_RESISTIVITY_WELL}		= $DATA_RESISTIVITY_WELL;		
 	$Project->{_DATA_RESISTIVITY_WELL_TXT}	= $DATA_RESISTIVITY_WELL_TXT;	
 	$Project->{_DATA_SEISMIC_BIN}			= $DATA_SEISMIC_BIN;				
 	$Project->{_DATA_SEISMIC_DAT}			= $DATA_SEISMIC_DAT;				
 	$Project->{_DATA_SEISMIC_ININT}			= $DATA_SEISMIC_ININT;				
 	$Project->{_DATA_SEISMIC_MATLAB}		= $DATA_SEISMIC_MATLAB;			
 	$Project->{_GMT_SEISMIC}				= $GMT_SEISMIC;					
 	$Project->{_GMT_GEOMAPS}				= $GMT_GEOMAPS;
  	$Project->{_GRASS_GEOMAPS}				= $GRASS_GEOMAPS;				
 	$Project->{_MMODPG}						= $MMODPG;							
 	$Project->{_DATA_SEISMIC}				= $DATA_SEISMIC;					
 	$Project->{_DATA_SEISMIC_PASSCAL_SEGY}	= $DATA_SEISMIC_PASSCAL_SEGY;		
 	$Project->{_DATA_SEISMIC_R}				= $DATA_SEISMIC_R;					
 	$Project->{_DATA_SEISMIC_RSEIS}			= $DATA_SEISMIC_RSEIS;				
 	$Project->{_DATA_SEISMIC_SAC}			= $DATA_SEISMIC_SAC;					
 	$Project->{_DATA_SEISMIC_SEG2}			= $DATA_SEISMIC_SEG2;				
 	$Project->{_DATA_SEISMIC_SEGD}			= $DATA_SEISMIC_SEGD;				
 	$Project->{_DATA_SEISMIC_SEGY}			= $DATA_SEISMIC_SEGY;				
 	$Project->{_DATA_SEISMIC_SEGY_RAW}		= $DATA_SEISMIC_SEGY_RAW;			
 	$Project->{_DATA_SEISMIC_SIERRA_SEGY}	= $DATA_SEISMIC_SIERRA_SEGY;		
 	$Project->{_DATA_SEISMIC_SU}			= $DATA_SEISMIC_SU;				
 	$Project->{_DATA_SEISMIC_SU_RAW}		= $DATA_SEISMIC_SU_RAW;			
 	$Project->{_DATA_SEISMIC_TXT}			= $DATA_SEISMIC_TXT;				
 	$Project->{_DATA_SEISMIC_VEL}			= $DATA_SEISMIC_VEL;				
 	$Project->{_DATABASE_SEISMIC_SQLITE}	= $DATABASE_SEISMIC_SQLITE;		
 	$Project->{_DATA_WELL}					= $DATA_WELL;						
 	$Project->{_FAST_TOMO}					= $FAST_TOMO;						
 	$Project->{_GEOPSY}						= $GEOPSY;							
 	$Project->{_GIF_SEISMIC}				= $GIF_SEISMIC;					
 	$Project->{_ISOLA}						= $ISOLA;							
 	$Project->{_JPEG}						= $JPEG;							
 	$Project->{_C_SEISMIC}					= $C_SEISMIC;						
 	$Project->{_CPP_SEISMIC}				= $CPP_SEISMIC;					
 	$Project->{_MATLAB_GEOMAPS}				= $MATLAB_GEOMAPS;					
 	$Project->{_MATLAB_WELL}				= $MATLAB_WELL;				
 	$Project->{_MATLAB_SEISMIC}				= $MATLAB_SEISMIC;					
 	$Project->{_MOD2D_TOMO}					= $MOD2D_TOMO;						
 	$Project->{_PL_SEISMIC}					= $PL_SEISMIC;						
 	$Project->{_PL_GEOMAPS}					= $PL_GEOMAPS;						
 	$Project->{_PL_WELL}					= $PL_WELL;						
 	$Project->{_RESISTIVITY_SURFACE}		= $RESISTIVITY_SURFACE;			
 	$Project->{_R_GAMMA_WELL}				= $R_GAMMA_WELL;					
 	$Project->{_R_RESISTIVITY_SURFACE}		= $R_RESISTIVITY_SURFACE;			
 	$Project->{_R_RESISTIVITY_WELL}			= $R_RESISTIVITY_WELL;	
 	$Project->{_R_SEISMIC}					= $R_SEISMIC;
 	$Project->{_R_WELL}						= $R_WELL;							
 	$Project->{_SH_SEISMIC}					= $SH_SEISMIC;						
 	$Project->{_PS_SEISMIC}					= $PS_SEISMIC;						
 	$Project->{_PS_WELL}					= $PS_WELL;						
 	$Project->{_RAYINVR}					= $RAYINVR;						
 	$Project->{_SURFACE}					= $SURFACE;						
 	$Project->{_TEMP_DATA_GEOMAPS}			= $TEMP_DATA_GEOMAPS;				
 	$Project->{_TEMP_DATA_SEISMIC}			= $TEMP_DATA_SEISMIC;				
 	$Project->{_TEMP_DATA_SEISMIC_SU}		= $TEMP_DATA_SEISMIC_SU;			
 	$Project->{_TEMP_FAST_TOMO}				= $TEMP_FAST_TOMO;					
 	$Project->{_WELL}						= $WELL;							
	
	return();
}



    
=head2 DIRECTORY DEFINITIONS

 Be careful in changing the following order

=cut

sub system_dirs {
	
    my $HOME 			= $Project->{_HOME};
	my $date 			= $Project->{_date};
	my $line 			= $Project->{_line};	
	my $component 		= $Project->{_component};	
	my $stage 			= $Project->{_stage};	
	my $process 		= $Project->{_process};
	my $PROJECT_HOME 	= $Project->{_PROJECT_HOME};
	my $subUser 		= $Project->{_subUser};

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
   my $JPEG_SEISMIC			= $JPEG;

# ISOLA DIRECTORY
   my $ISOLA              	= $SEISMIC.'/isola/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

# GMT SEISMIC
   my $GMT_SEISMIC              = $SEISMIC.'/gmt/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

# GMT GEOMAPS 
   my $GMT_GEOMAPS              = $GEOMAPS.'/gmt/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

# GRASS GEOMAPS 
   my $GRASS_GEOMAPS            = $GEOMAPS.'/grass/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/'.$subUser;

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

# PERL DIRECTORIES
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
   my $DATA_SEISMIC_SEG2   	      = $DATA_SEISMIC.'/'.$DATE_LINE_COMPONENT_STAGE_PROCESS.'/seg2'.'/'.$subUser;

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
	 #print("2. Project,DATA_GEOMAPS_TEXT=$DATA_GEOMAPS_TEXT\n");

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


	$Project->{_ANTELOPE}					= $ANTELOPE;					
 	$Project->{_DATA_GEOMAPS}				= $DATA_GEOMAPS;					
 	$Project->{_DATA_GEOMAPS_BIN}			= $DATA_GEOMAPS_BIN;				
 	$Project->{_DATA_GEOMAPS_TOPO}			= $DATA_GEOMAPS_TOPO;		
 	$Project->{_GEOMAPS_IMAGES}				= $GEOMAPS_IMAGES;					
 	$Project->{_GEOMAPS_IMAGES_JPEG}		= $GEOMAPS_IMAGES_JPEG;			
 	$Project->{_GEOMAPS_IMAGES_TIF}			= $GEOMAPS_IMAGES_TIF;				
 	$Project->{_GEOMAPS_IMAGES_PS}			= $GEOMAPS_IMAGES_PS;				
 	$Project->{_DATA_GEOMAPS_TEXT}			= $DATA_GEOMAPS_TEXT;				
	#print("3. Project,DATA_GEOMAPS_TEXT=$DATA_GEOMAPS_TEXT\n");

 	$Project->{_PROJECT_HOME}				= $PROJECT_HOME;					
 	$Project->{_DATA_GAMMA_WELL}			= $DATA_GAMMA_WELL;			
 	$Project->{_DATA_GAMMA_WELL_TXT}		= $DATA_GAMMA_WELL_TXT;	
 	$Project->{_DATA_RESISTIVITY_SURFACE}	= $DATA_RESISTIVITY_SURFACE;		
 	$Project->{_DATA_RESISTIVITY_SURFACE_TXT}	= $DATA_RESISTIVITY_SURFACE_TXT;	
 	$Project->{_DATA_RESISTIVITY_WELL}		= $DATA_RESISTIVITY_WELL;		
 	$Project->{_DATA_RESISTIVITY_WELL_TXT}	= $DATA_RESISTIVITY_WELL_TXT;	
 	$Project->{_DATA_SEISMIC_BIN}			= $DATA_SEISMIC_BIN;				
 	$Project->{_DATA_SEISMIC_DAT}			= $DATA_SEISMIC_DAT;				
 	$Project->{_DATA_SEISMIC_ININT}			= $DATA_SEISMIC_ININT;				
 	$Project->{_DATA_SEISMIC_MATLAB}		= $DATA_SEISMIC_MATLAB;			
 	$Project->{_GMT_SEISMIC}				= $GMT_SEISMIC;					
 	$Project->{_GMT_GEOMAPS}				= $GMT_GEOMAPS;
  	$Project->{_GRASS_GEOMAPS}				= $GRASS_GEOMAPS;					
 	$Project->{_MMODPG}						= $MMODPG;							
 	$Project->{_DATA_SEISMIC}				= $DATA_SEISMIC;					
 	$Project->{_DATA_SEISMIC_PASSCAL_SEGY}	= $DATA_SEISMIC_PASSCAL_SEGY;		
 	$Project->{_DATA_SEISMIC_R}				= $DATA_SEISMIC_R;					
 	$Project->{_DATA_SEISMIC_RSEIS}			= $DATA_SEISMIC_RSEIS;				
 	$Project->{_DATA_SEISMIC_SAC}			= $DATA_SEISMIC_SAC;				
 	$Project->{_DATA_SEISMIC_SEG2}			= $DATA_SEISMIC_SEG2;				
 	$Project->{_DATA_SEISMIC_SEGD}			= $DATA_SEISMIC_SEGD;				
 	$Project->{_DATA_SEISMIC_SEGY}			= $DATA_SEISMIC_SEGY;				
 	$Project->{_DATA_SEISMIC_SEGY_RAW}		= $DATA_SEISMIC_SEGY_RAW;			
 	$Project->{_DATA_SEISMIC_SIERRA_SEGY}	= $DATA_SEISMIC_SIERRA_SEGY;		
 	$Project->{_DATA_SEISMIC_SU}			= $DATA_SEISMIC_SU;				
 	$Project->{_DATA_SEISMIC_SU_RAW}		= $DATA_SEISMIC_SU_RAW;			
 	$Project->{_DATA_SEISMIC_TXT}			= $DATA_SEISMIC_TXT;				
 	$Project->{_DATA_SEISMIC_VEL}			= $DATA_SEISMIC_VEL;				
 	$Project->{_DATABASE_SEISMIC_SQLITE}	= $DATABASE_SEISMIC_SQLITE;		
 	$Project->{_DATA_WELL}					= $DATA_WELL;						
 	$Project->{_FAST_TOMO}					= $FAST_TOMO;						
 	$Project->{_GEOPSY}						= $GEOPSY;							
 	$Project->{_GIF_SEISMIC}				= $GIF_SEISMIC;					
 	$Project->{_ISOLA}						= $ISOLA;							
 	$Project->{_JPEG}						= $JPEG;
 	$Project->{_JPEG_SEISMIC}				= $JPEG_SEISMIC;							
 	$Project->{_C_SEISMIC}					= $C_SEISMIC;						
 	$Project->{_CPP_SEISMIC}				= $CPP_SEISMIC;					
 	$Project->{_MATLAB_GEOMAPS}				= $MATLAB_GEOMAPS;					
 	$Project->{_MATLAB_WELL}				= $MATLAB_WELL;				
 	$Project->{_MATLAB_SEISMIC}				= $MATLAB_SEISMIC;					
 	$Project->{_MOD2D_TOMO}					= $MOD2D_TOMO;						
 	$Project->{_PL_SEISMIC}					= $PL_SEISMIC;						
 	$Project->{_PL_GEOMAPS}					= $PL_GEOMAPS;						
 	$Project->{_PL_WELL}					= $PL_WELL;						
 	$Project->{_RESISTIVITY_SURFACE}		= $RESISTIVITY_SURFACE;			
 	$Project->{_R_GAMMA_WELL}				= $R_GAMMA_WELL;					
 	$Project->{_R_RESISTIVITY_SURFACE}		= $R_RESISTIVITY_SURFACE;			
 	$Project->{_R_RESISTIVITY_WELL}			= $R_RESISTIVITY_WELL;	
 	$Project->{_R_SEISMIC}					= $R_SEISMIC;
 	$Project->{_R_WELL}						= $R_WELL;							
 	$Project->{_SH_SEISMIC}					= $SH_SEISMIC;						
 	$Project->{_PS_SEISMIC}					= $PS_SEISMIC;						
 	$Project->{_PS_WELL}					= $PS_WELL;						
 	$Project->{_RAYINVR}					= $RAYINVR;						
 	$Project->{_SURFACE}					= $SURFACE;						
 	$Project->{_TEMP_DATA_GEOMAPS}			= $TEMP_DATA_GEOMAPS;				
 	$Project->{_TEMP_DATA_SEISMIC}			= $TEMP_DATA_SEISMIC;				
 	$Project->{_TEMP_DATA_SEISMIC_SU}		= $TEMP_DATA_SEISMIC_SU;			
 	$Project->{_TEMP_FAST_TOMO}				= $TEMP_FAST_TOMO;					
 	$Project->{_WELL}						= $WELL;							
	
	return();
}

sub date{
	_basic_dirs();

	my $date = $Project->{_date};
        return ($date);
}

sub ANTELOPE{
	_basic_dirs();
	_system_dirs();

	my $ANTELOPE= $Project->{_ANTELOPE};
        return ($ANTELOPE);
}

sub DATA_GEOMAPS{
	_basic_dirs();
	_system_dirs();

		my $DATA_GEOMAPS= $Project->{_DATA_GEOMAPS};
        return ($DATA_GEOMAPS);
}


sub DATA_GEOMAPS_BIN{
	_basic_dirs();
	_system_dirs();

		my $DATA_GEOMAPS_BIN= $Project->{_DATA_GEOMAPS_BIN};
        return ($DATA_GEOMAPS_BIN);
}

sub DATA_GEOMAPS_TEXT {
	_basic_dirs();
	_system_dirs();

		my $DATA_GEOMAPS_TEXT= $Project->{_DATA_GEOMAPS_TEXT};
	#print("4. Project,DATA_GEOMAPS_TEXT,DATA_GEOMAPS_TEXT=$DATA_GEOMAPS_TEXT\n");
        return ($DATA_GEOMAPS_TEXT);
}

sub DATA_GEOMAPS_TOPO{
	_basic_dirs();
	_system_dirs();

		my $DATA_GEOMAPS_TOPO= $Project->{_DATA_GEOMAPS_TOPO};
        return ($DATA_GEOMAPS_TOPO);
}

sub GEOMAPS_IMAGES{
	_basic_dirs();
	_system_dirs();

		my $GEOMAPS_IMAGES= $Project->{_GEOMAPS_IMAGES};
        return ($GEOMAPS_IMAGES);
}

sub GEOMAPS_IMAGES_JPEG{
	_basic_dirs();
	_system_dirs();

		my $GEOMAPS_IMAGES_JPEG= $Project->{_GEOMAPS_IMAGES_JPEG};
        return ($GEOMAPS_IMAGES_JPEG);
}

sub GEOMAPS_IMAGES_TIF{
	_basic_dirs();
	_system_dirs();

		my $GEOMAPS_IMAGES_TIF= $Project->{_GEOMAPS_IMAGES_TIF};
        return ($GEOMAPS_IMAGES_TIF);
}

sub GEOMAPS_IMAGES_PS{
	_basic_dirs();
	_system_dirs();

		my $GEOMAPS_IMAGES_PS= $Project->{_GEOMAPS_IMAGES_PS};
        return ($GEOMAPS_IMAGES_PS);
}

sub PROJECT_HOME{
	_basic_dirs();
	_system_dirs();

		my $PROJECT_HOME= $Project->{_PROJECT_HOME};
        return ($PROJECT_HOME);
}


sub DATA_GAMMA_WELL {
	_basic_dirs();
	_system_dirs();

		my $DATA_GAMMA_WELL= $Project->{_DATA_GAMMA_WELL};
       return ($DATA_GAMMA_WELL);
}

sub DATA_GAMMA_WELL_TXT {
	_basic_dirs();
	_system_dirs();

		my $DATA_GAMMA_WELL_TXT= $Project->{_DATA_GAMMA_WELL_TXT};
       return ($DATA_GAMMA_WELL_TXT);
}

sub DATA_RESISTIVITY_SURFACE {
	_basic_dirs();
	_system_dirs();

		my $DATA_RESISTIVITY_SURFACE= $Project->{_DATA_RESISTIVITY_SURFACE};
       return ($DATA_RESISTIVITY_SURFACE);
}

sub DATA_RESISTIVITY_SURFACE_TXT {
	_basic_dirs();
	_system_dirs();

		my $DATA_RESISTIVITY_SURFACE_TXT= $Project->{_DATA_RESISTIVITY_SURFACE_TXT};
       return ($DATA_RESISTIVITY_SURFACE_TXT);
}

sub DATA_RESISTIVITY_WELL {
	_basic_dirs();
	_system_dirs();

		my $DATA_RESISTIVITY_WELL= $Project->{_DATA_RESISTIVITY_WELL};
       return ($DATA_RESISTIVITY_WELL);
}

sub DATA_RESISTIVITY_WELL_TXT {
	_basic_dirs();
	_system_dirs();

		my $DATA_RESISTIVITY_WELL_TXT= $Project->{_DATA_RESISTIVITY_WELL_TXT};
       return ($DATA_RESISTIVITY_WELL_TXT);
}

sub DATA_SEISMIC_BIN {
	_basic_dirs();
	_system_dirs();

		my $DATA_SEISMIC_BIN= $Project->{_DATA_SEISMIC_BIN};
        return ($DATA_SEISMIC_BIN);
}

sub DATA_SEISMIC_DAT {
	_basic_dirs();
	_system_dirs();

		my $DATA_SEISMIC_DAT= $Project->{_DATA_SEISMIC_DAT};
        return ($DATA_SEISMIC_DAT);
}

sub DATA_SEISMIC_ININT {
	_basic_dirs();
	_system_dirs();

		my $DATA_SEISMIC_ININT= $Project->{_DATA_SEISMIC_ININT};
        return ($DATA_SEISMIC_ININT);
}

sub DATA_SEISMIC_MATLAB {
	_basic_dirs();
	_system_dirs();

		my $DATA_SEISMIC_MATLAB= $Project->{_DATA_SEISMIC_MATLAB};
        return ($DATA_SEISMIC_MATLAB);
}

sub  GMT_SEISMIC {
	_basic_dirs();
	_system_dirs();

		my $GMT_SEISMIC= $Project->{_GMT_SEISMIC};
        return ($GMT_SEISMIC);
}            

sub  GMT_GEOMAPS {
	_basic_dirs();
	_system_dirs();

		my $GMT_GEOMAPS= $Project->{_GMT_GEOMAPS};
        return ($GMT_GEOMAPS);
} 
sub  GRASS_GEOMAPS {
	_basic_dirs();
	_system_dirs();

		my $GRASS_GEOMAPS= $Project->{_GRASS_GEOMAPS};
        return ($GRASS_GEOMAPS);
}  

sub MMODPG {
	_basic_dirs();
	_system_dirs();

		my $MMODPG= $Project->{_MMODPG};
        return ($MMODPG);
}

sub DATA_SEISMIC {
	_basic_dirs();
	_system_dirs();

		my $DATA_SEISMIC= $Project->{_DATA_SEISMIC};
        return ($DATA_SEISMIC);
}

sub DATA_SEISMIC_PASSCAL_SEGY {
	_basic_dirs();
	_system_dirs();

		my $DATA_SEISMIC_PASSCAL_SEGY= $Project->{_DATA_SEISMIC_PASSCAL_SEGY};
        return ($DATA_SEISMIC_PASSCAL_SEGY);
}

sub DATA_SEISMIC_R {
	_basic_dirs();
	_system_dirs();

		my $DATA_SEISMIC_R= $Project->{_DATA_SEISMIC_R};
        return ($DATA_SEISMIC_R);
}


sub DATA_SEISMIC_RSEIS {
	_basic_dirs();
	_system_dirs();

		my $DATA_SEISMIC_RSEIS= $Project->{_DATA_SEISMIC_RSEIS};
        return ($DATA_SEISMIC_RSEIS);
}

sub DATA_SEISMIC_SAC {
	_basic_dirs();
	_system_dirs();

		my $DATA_SEISMIC_SAC= $Project->{_DATA_SEISMIC_SAC};
        return ($DATA_SEISMIC_SAC);
}

sub DATA_SEISMIC_SEG2 {
	_basic_dirs();
	_system_dirs();

		my $DATA_SEISMIC_SEG2= $Project->{_DATA_SEISMIC_SEG2};
        return ($DATA_SEISMIC_SEG2);
}

sub DATA_SEISMIC_SEGD {
	_basic_dirs();
	_system_dirs();

		my $DATA_SEISMIC_SEGD= $Project->{_DATA_SEISMIC_SEGD};
        return ($DATA_SEISMIC_SEGD);
}

sub DATA_SEISMIC_SEGY {
	_basic_dirs();
	_system_dirs();

		my $DATA_SEISMIC_SEGY= $Project->{_DATA_SEISMIC_SEGY};
        return ($DATA_SEISMIC_SEGY);
}

sub DATA_SEISMIC_SEGY_RAW {
	_basic_dirs();
	_system_dirs();

		my $DATA_SEISMIC_SEGY_RAW= $Project->{_DATA_SEISMIC_SEGY_RAW};
        return ($DATA_SEISMIC_SEGY_RAW);
}

sub DATA_SEISMIC_SIERRA_SEGY {
	_basic_dirs();
	_system_dirs();

		my $DATA_SEISMIC_SIERRA_SEGY= $Project->{_DATA_SEISMIC_SIERRA_SEGY};
        return ($DATA_SEISMIC_SIERRA_SEGY);
}

sub DATA_SEISMIC_SU {
	_basic_dirs();
	_system_dirs();

		my $DATA_SEISMIC_SU= $Project->{_DATA_SEISMIC_SU};
		
		control->set_infection($DATA_SEISMIC_SU); 
		$DATA_SEISMIC_SU = $control->get_ticksBgone;
		
        return ($DATA_SEISMIC_SU);
}

sub DATA_SEISMIC_SU_RAW {
	_basic_dirs();
	_system_dirs();
		my $DATA_SEISMIC_SU_RAW= $Project->{_DATA_SEISMIC_SU_RAW};
        return ($DATA_SEISMIC_SU_RAW);
}

sub DATA_SEISMIC_TXT {
	_basic_dirs();
	_system_dirs();
		my $DATA_SEISMIC_TXT= $Project->{_DATA_SEISMIC_TXT};
        return ($DATA_SEISMIC_TXT);
}

sub DATA_SEISMIC_VEL {
	_basic_dirs();
	_system_dirs();
		my $DATA_SEISMIC_VEL= $Project->{_DATA_SEISMIC_VEL};
        return ($DATA_SEISMIC_VEL);
}


sub DATABASE_SEISMIC_SQLITE {
	_basic_dirs();
	_system_dirs();
		my $DATABASE_SEISMIC_SQLITE= $Project->{_DATABASE_SEISMIC_SQLITE};
        return ($DATABASE_SEISMIC_SQLITE);
}

sub DATA_WELL {
	_basic_dirs();
	_system_dirs();
		my $DATA_WELL= $Project->{_DATA_WELL};
        return ($DATA_WELL);
}


sub FAST_TOMO {
	_basic_dirs();
	_system_dirs();
		my $FAST_TOMO= $Project->{_FAST_TOMO};
	# This subroutine returns the value of FAST_TOMO 
	#print ("\n$FAST_TOMO\n");
        return ($FAST_TOMO);
}

sub GEOPSY {
	_basic_dirs();
	_system_dirs();
		my $GEOPSY= $Project->{_GEOPSY};
        return ($GEOPSY);
}

sub GIF_SEISMIC {
	_basic_dirs();
	_system_dirs();
		my $GIF_SEISMIC= $Project->{_GIF_SEISMIC};
        return ($GIF_SEISMIC);
}

sub ISOLA {
	_basic_dirs();
	_system_dirs();
		my $ISOLA= $Project->{_ISOLA};
        return ($ISOLA);
}

sub JPEG {
	_basic_dirs();
	_system_dirs();
		my $JPEG= $Project->{_JPEG};
        return ($JPEG);
}

sub JPEG_SEISMIC {
	_basic_dirs();
	_system_dirs();
		my $JPEG_SEISMIC= $Project->{_JPEG_SEISMIC};
        return ($JPEG_SEISMIC);
}

sub C_SEISMIC {
	_basic_dirs();
	_system_dirs();
		my $C_SEISMIC= $Project->{_C_SEISMIC};
        return ($C_SEISMIC);
}

sub CPP_SEISMIC {
	_basic_dirs();
	_system_dirs();
		my $CPP_SEISMIC= $Project->{_CPP_SEISMIC};
        return ($CPP_SEISMIC);
}


sub MATLAB_GEOMAPS {
	_basic_dirs();
	_system_dirs();
		my $MATLAB_GEOMAPS= $Project->{_MATLAB_GEOMAPS};
        return ($MATLAB_GEOMAPS);
}

sub MATLAB_WELL {
	_basic_dirs();
	_system_dirs();
		my $MATLAB_WELL= $Project->{_MATLAB_WELL};
        return ($MATLAB_WELL);
}


sub MATLAB_SEISMIC {
	_basic_dirs();
	_system_dirs();
		my $MATLAB_SEISMIC= $Project->{_MATLAB_SEISMIC};
        return ($MATLAB_SEISMIC);
}


sub MOD2D_TOMO {
	_basic_dirs();
	_system_dirs();
		my $MOD2D_TOMO= $Project->{_MOD2D_TOMO};
        return ($MOD2D_TOMO);
}

sub PL_SEISMIC {
	_basic_dirs();
	_system_dirs();
	my $PL_SEISMIC= $Project->{_PL_SEISMIC};
	control->set_infection($PL_SEISMIC); 
	$PL_SEISMIC = $control->get_ticksBgone;
	# This subroutine returns the value of PL_SEISMIC 
	# print ("\nProject, PL_SEISMIC: $PL_SEISMIC\n");
        return ($PL_SEISMIC);
}

sub PL_GEOMAPS {
	_basic_dirs();
	_system_dirs();
		my $PL_GEOMAPS= $Project->{_PL_GEOMAPS};
        return ($PL_GEOMAPS);
}

sub PL_WELL {
	_basic_dirs();
	_system_dirs();
		my $PL_WELL= $Project->{_PL_WELL};
        return ($PL_WELL);
}

sub RESISTIVITY_SURFACE {
	_basic_dirs();
	_system_dirs();
		my $RESISTIVITY_SURFACE= $Project->{_RESISTIVITY_SURFACE};
       return ($RESISTIVITY_SURFACE);
}

sub R_GAMMA_WELL {
	_basic_dirs();
	_system_dirs();
		my $R_GAMMA_WELL= $Project->{_R_GAMMA_WELL};
        return ($R_GAMMA_WELL);
}

sub R_RESISTIVITY_SURFACE {
	_basic_dirs();
	_system_dirs();
		my $R_RESISTIVITY_SURFACE= $Project->{_R_RESISTIVITY_SURFACE};
        return ($R_RESISTIVITY_SURFACE);
}

sub R_RESISTIVITY_WELL {
	_basic_dirs();
	_system_dirs();
		my $R_RESISTIVITY_WELL= $Project->{_R_RESISTIVITY_WELL};
        return ($R_RESISTIVITY_WELL);
}

sub R_SEISMIC {
	_basic_dirs();
	_system_dirs();
		my $R_SEISMIC= $Project->{_R_SEISMIC};
        return ($R_SEISMIC);
}

sub R_WELL {
	_basic_dirs();
	_system_dirs();
		my $R_WELL= $Project->{_R_WELL};
        return ($R_WELL);
}

sub SH_SEISMIC {
	_basic_dirs();
	_system_dirs();
		my $SH_SEISMIC= $Project->{_SH_SEISMIC};
        return ($SH_SEISMIC);
}

sub PS_SEISMIC {
	_basic_dirs();
	_system_dirs();
		my $PS_SEISMIC= $Project->{_PS_SEISMIC};
        return ($PS_SEISMIC);
}

sub PS_WELL {
	_basic_dirs();
	_system_dirs();
		my $PS_WELL= $Project->{_PS_WELL};
        return ($PS_WELL);
}


sub RAYINVR {
	_basic_dirs();
	_system_dirs();
		my $RAYINVR= $Project->{_RAYINVR};
	# This subroutine returns the value of RAYINVR 
	#print ("\n$RAYINVR\n");
        return ($RAYINVR);
}
sub  SURFACE {
	_basic_dirs();
	_system_dirs();
		my $SURFACE= $Project->{_SURFACE};
        return ($SURFACE);
}


sub TEMP_DATA_GEOMAPS {
	_basic_dirs();
	_system_dirs();
		my $TEMP_DATA_GEOMAPS= $Project->{_TEMP_DATA_GEOMAPS};
        return ($TEMP_DATA_GEOMAPS);
}

sub TEMP_DATA_SEISMIC {
	_basic_dirs();
	_system_dirs();
		my $TEMP_DATA_SEISMIC= $Project->{_TEMP_DATA_SEISMIC};
        return ($TEMP_DATA_SEISMIC);
}

sub TEMP_DATA_SEISMIC_SU {
	_basic_dirs();
	_system_dirs();
		my $TEMP_DATA_SEISMIC_SU= $Project->{_TEMP_DATA_SEISMIC_SU};
        return ($TEMP_DATA_SEISMIC_SU);
}

sub TEMP_FAST_TOMO {
	_basic_dirs();
	_system_dirs();
		my $TEMP_FAST_TOMO= $Project->{_TEMP_FAST_TOMO};
        return ($TEMP_FAST_TOMO);
}


sub WELL {
	_basic_dirs();
	_system_dirs();
		my $WELL= $Project->{_WELL};
        return ($WELL);
}

=head2

=cut



=head2 Creates necessary directories
 
=cut

sub make_local_dirs {
		
		# Always create basic types		
	my $PROJECT_HOME  = $Project->{_PROJECT_HOME};
	my $HOME  		  = $Project->{_HOME};
	manage_dirs_by::make_dir($HOME);
	manage_dirs_by::make_dir($PROJECT_HOME);

		
		# BY data type
		# CATEGORY GEOMAPS images and data
	my $DATA_GEOMAPS  		= $Project->{_DATA_GEOMAPS};
	my $GEOMAPS_IMAGES  	= $Project->{_GEOMAPS_IMAGES};
	my $GEOMAPS_IMAGES_JPEG = $Project->{_GEOMAPS_IMAGES_JPEG};
	my $GEOMAPS_BIN  		= $Project->{_GEOMAPS_BIN};
	my $GEOMAPS_IMAGES_TIF  = $Project->{_GEOMAPS_IMAGES_TIF};
	my $GEOMAPS_IMAGES_PS  	= $Project->{_GEOMAPS_IMAGES_PS};
	my $DATA_GEOMAPS_TEXT  	= $Project->{_DATA_GEOMAPS_TEXT};
	my $DATA_GEOMAPS_TOPO  	= $Project->{_DATA_GEOMAPS_TOPO};
	my $TEMP_DATA_GEOMAPS  	= $Project->{_TEMP_DATA_GEOMAPS};
	my $GMT_GEOMAPS 	    = $Project->{_GMT_GEOMAPS};
	my $GRASS_GEOMAPS 	    = $Project->{_GRASS_GEOMAPS};	
	my $GMT_SEISMIC 		= $Project->{_GMT_SEISMIC};
 
	#manage_dirs_by::make_dir($GEOMAPS_BIN); 
 	#manage_dirs_by::make_dir($GEOMAPS_IMAGES_TIF); 
	# print("1. Project,DATA_GEOMAPS_TEXT=$DATA_GEOMAPS_TEXT\n");
	# manage_dirs_by::make_dir($DATA_GEOMAPS_TOPO);  
	#manage_dirs_by::make_dir($TEMP_DATA_GEOMAPS);
	
	
					  # pl programs and geomaps 
	my $PL_GEOMAPS  		= $Project->{_PL_GEOMAPS};	
 
	    # matlab and geomaps
	my $MATLAB_GEOMAPS      = $Project->{_MATLAB_GEOMAPS};
	# manage_dirs_by::make_dir($MATLAB_GEOMAPS);
	
	if ( $Project->{_geomaps_is_selected} ) {
		manage_dirs_by::make_dir($DATA_GEOMAPS); 
 		manage_dirs_by::make_dir($GEOMAPS_IMAGES); 
 		manage_dirs_by::make_dir($GEOMAPS_IMAGES_JPEG);
		manage_dirs_by::make_dir($GEOMAPS_IMAGES_PS);
		manage_dirs_by::make_dir($DATA_GEOMAPS_TEXT);
		manage_dirs_by::make_dir($PL_GEOMAPS);
	}
		
	if ( $Project->{_grass_is_selected} ) { 
 		manage_dirs_by::make_dir($GEOMAPS_IMAGES); 
 		manage_dirs_by::make_dir($GEOMAPS_IMAGES_JPEG);
		manage_dirs_by::make_dir($GEOMAPS_IMAGES_PS);
		manage_dirs_by::make_dir($PL_GEOMAPS);
	}
	
	    # matlab and seismic	
	my $MATLAB_SEISMIC  = $Project->{_MATLAB_SEISMIC};
	# manage_dirs_by::make_dir($MATLAB_SEISMIC);
	
		# sh scripts and seismic
	my $SH_SEISMIC  	= $Project->{_SH_SEISMIC};
	
		# Always create
 	manage_dirs_by::make_dir($SH_SEISMIC);
	
		  # CATEGORY well data and R and Perl and Matlab
	my $R_WELL     					= $Project->{_R_WELL}; 
	my $WELL       					= $Project->{_WELL};
	my $PL_WELL       				= $Project->{_PL_WELL};
	my $MATLAB_WELL       			= $Project->{_MATLAB_WELL};
	# manage_dirs_by::make_dir($R_WELL)
	# manage_dirs_by::make_dir($WELL);
						  # pl programs and wells
	# manage_dirs_by::make_dir($PL_WELL);
						  # matlab programs and wells
	# manage_dirs_by::make_dir($MATLAB_WELL);
								  	
			  # CATEGORY well and images
	my $PS_WELL    = $Project->{_PS_WELL};
	# manage_dirs_by::make_dir($PS_WELL);
		  
		  # CATEGORY seismic data
	my $DATA_SEISMIC  				= $Project->{_DATA_SEISMIC};
		  # CATEGORY seismics and images
	my $PS_SEISMIC  				= $Project->{_PS_SEISMIC};
	my $GIF_SEISMIC  				= $Project->{_GIF_SEISMIC};
	my $JPEG_SEISMIC  				= $Project->{_JPEG_SEISMIC};
	# manage_dirs_by::make_dir($PS_SEISMIC);
	# manage_dirs_by::make_dir($GIF_SEISMIC);
	
	# Always create
	manage_dirs_by::make_dir($JPEG_SEISMIC); 
	
	# manage_dirs_by::make_dir($TEMP_DATA_SEISMIC); 
	
	my $DATA_SEISMIC_DAT 		  = $Project->{_DATA_SEISMIC_DAT};
	my $DATA_SEISMIC_SEG2		  = $Project->{_DATA_SEISMIC_SEG2};
			# Always create
	# manage_dirs_by::make_dir($DATA_SEISMIC_DAT);
  	manage_dirs_by::make_dir($DATA_SEISMIC_SEG2); 
  	
			  # Format nint and seismic data
	my $DATA_SEISMIC_ININT  	= $Project->{_DATA_SEISMIC_ININT};
	# manage_dirs_by::make_dir($DATA_SEISMIC_ININT);
	 	 	
			  # Format matlab and seismic data
	# manage_dirs_by::make_dir($DATA_SEISMIC_MATLAB);
	
				  # gmt programs with map and seismic data
	if ( $Project->{_gmt_is_selected} ) {
	   manage_dirs_by::make_dir($GMT_GEOMAPS);
	}			  
					# grass programs with map  data
	if ( $Project->{_grass_is_selected} ) {
	   manage_dirs_by::make_dir($GRASS_GEOMAPS);
	}
				  # pl programs and seismic data
	# Always create
	my $PL_SEISMIC  		= $Project->{_PL_SEISMIC};	
	manage_dirs_by::make_dir($PL_SEISMIC); 
	 	
			  # Format segy and seismic data
	my $DATA_SEISMIC_SEGY  		= $Project->{_DATA_SEISMIC_SEGY};
	my $DATA_SEISMIC_SEGY_RAW  	= $Project->{_DATA_SEISMIC_SEGY_RAW};
	# Always create
	manage_dirs_by::make_dir($DATA_SEISMIC_SEGY);
	manage_dirs_by::make_dir($DATA_SEISMIC_SEGY_RAW); 
			
			  # program R and format rseis seismic data
	my $DATA_SEISMIC_R  			= $Project->{_DATA_SEISMIC_R};
	my $DATA_SEISMIC_RSEIS  		= $Project->{_DATA_SEISMIC_RSEIS};
	# manage_dirs_by::make_dir($DATA_SEISMIC_RSEIS); 
	# manage_dirs_by::make_dir($DATA_SEISMIC_R);
	
		      # program R and seismic data
	my $R_SEISMIC  = $Project->{_R_SEISMIC}; 
 	# manage_dirs_by::make_dir($R_SEISMIC);
	
			  # Format passcal segy and seismic data
	my $DATA_SEISMIC_PASSCAL_SEGY  = $Project->{_DATA_SEISMIC_PASSCAL_SEGY};
	# manage_dirs_by::make_dir($DATA_SEISMIC_PASSCAL_SEGY);	
		
			  # Format sierra segy and seismic data
	my $DATA_SEISMIC_SIERRA_SEGY  	= $Project->{_DATA_SEISMIC_SIERRA_SEGY};
	# manage_dirs_by::make_dir($DATA_SEISMIC_SIERRA_SEGY); 	
		
			  # Format segd and seismic data
	my $DATA_SEISMIC_SEGD  			= $Project->{_DATA_SEISMIC_SEGD};	
	# manage_dirs_by::make_dir($DATA_SEISMIC_SEGD); 
		
			  # Format sac and seismic data
	my $DATA_SEISMIC_SAC  			= $Project->{_DATA_SEISMIC_SAC};	
	# manage_dirs_by::make_dir($DATA_SEISMIC_SAC);
		
			  # Format su and seismic data
	my $DATA_SEISMIC_SU  			= $Project->{_DATA_SEISMIC_SU};
	my $DATA_SEISMIC_SU_RAW  		= $Project->{_DATA_SEISMIC_SU_RAW};
	my $TEMP_DATA_SEISMIC_SU  		= $Project->{_TEMP_DATA_SEISMIC_SU};
	
			# Always create
	manage_dirs_by::make_dir($DATA_SEISMIC_SU); 
	#manage_dirs_by::make_dir($DATA_SEISMIC_SU_RAW);
	# manage_dirs_by::make_dir($TEMP_DATA_SEISMIC_SU);
		
			  # Format txt and seismic data
	my $DATA_SEISMIC_TXT  = $Project->{_DATA_SEISMIC_TXT};
	# manage_dirs_by::make_dir($DATA_SEISMIC_TXT); 		
	
				#Format bin	 and seismic data 			  			  				  		  			  			  
	my $DATA_SEISMIC_BIN  = $Project->{_DATA_SEISMIC_BIN};
	# Always create	
	manage_dirs_by::make_dir($DATA_SEISMIC_BIN);
  	
		  # CATEGORY resistivity data
		  # location surface
		  # and program R
	my $R_RESISTIVITY_SURFACE  			= $Project->{_R_RESISTIVITY_SURFACE};
	my $DATA_RESISTIVITY_SURFACE  		= $Project->{_DATA_RESISTIVITY_SURFACE};
	my $DATA_RESISTIVITY_SURFACE_TXT  	= $Project->{_DATA_RESISTIVITY_SURFACE_TXT};
	# manage_dirs_by::make_dir($R_RESISTIVITY_SURFACE);
	# manage_dirs_by::make_dir($DATA_RESISTIVITY_SURFACE); 
	# manage_dirs_by::make_dir($DATA_RESISTIVITY_SURFACE_TXT);
	
			# CATEGORY resistivity data
			# location well
			# and program R
	my $R_RESISTIVITY_WELL 			= $Project->{_R_RESISTIVITY_WELL}; 
	my $DATA_RESISTIVITY_WELL  		= $Project->{_DATA_RESISTIVITY_WELL};
	my $DATA_RESISTIVITY_WELL_TXT  	= $Project->{_DATA_RESISTIVITY_WELL_TXT};
	# manage_dirs_by::make_dir($R_RESISTIVITY_WELL); 
	# manage_dirs_by::make_dir($DATA_RESISTIVITY_WELL); 
	# manage_dirs_by::make_dir($DATA_RESISTIVITY_WELL_TXT); 
	
			#CATEGORY GAMMA data
			# location well
			# and program R		
	my $R_GAMMA_WELL  		 = $Project->{_R_GAMMA_WELL};
	my $DATA_GAMMA_WELL_TXT  = $Project->{_DATA_GAMMA_WELL_TXT};
	# manage_dirs_by::make_dir($R_GAMMA_WELL);
	# manage_dirs_by::make_dir($DATA_GAMMA_WELL_TXT); 

		# By programs
		# sqlite
	my $DATABASE_SEISMIC_SQLITE  = $Project->{_DATABASE_SEISMIC_SQLITE};
	
	if ($Project->{_sqlite_is_selected}) {
		manage_dirs_by::make_dir($DATABASE_SEISMIC_SQLITE); 
	}
		# sioseis
			
		# modmod
	my $MMODPG  			= $Project->{_MMODPG};	
	# manage_dirs_by::make_dir($MMODPG);
		
		# fast tomography
	my $TEMP_FAST_TOMO  	= $Project->{_TEMP_FAST_TOMO};
	# manage_dirs_by::make_dir($TEMP_FAST_TOMO);
		
		# isola
	my $ISOLA  				= $Project->{_ISOLA};
 	# manage_dirs_by::make_dir($ISOLA);
	
		# antelope
	my $ANTELOPE  			= $Project->{_ANTELOPE};
		# manage_dirs_by::make_dir($ANTELOPE);
	
	# manage_dirs_by::make_dir($DATA_WELL);
	
		# geopsy
 	my $GEOPSY  			= $Project->{_GEOPSY};
	# manage_dirs_by::make_dir($GEOPSY); 

		# c PROGRAMS
	# manage_dirs_by::make_dir($C_SEISMIC); 
	
		# C ++ PROGRAMS
	# manage_dirs_by::make_dir($CPP_SEISMIC); 

	return();
}

=head2 sub get_max_index
  max index = number of input variables -1

=cut

 sub get_max_index {
 	my ($self) = @_;
 	# only file_name : index=11
 	my $max_index = 11;
 	
 	return($max_index);
 }
 

1;
