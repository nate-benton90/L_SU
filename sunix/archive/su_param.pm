package su_param;
	use Moose;
	
=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL PACKAGE NAME: su_param 
 AUTHOR: 	Juan Lorenzo
 DATE: 		May 5 2018 

 DESCRIPTION V 0.2
     

 BASED ON: 0.1


=cut

=head2 USE

=head3 NOTES

=head4 Examples


=head2 CHANGES and their DATES
	May 5 2018 looks for configurations
	first in the local directory
	then in the default configuration
	directory /usr/local/pl/big_streams/config

=cut 
	
	

=head2

 parameters for seismic unix programs
 both macros and individual modules
  
=cut


 	use SeismicUnixPlTk_global_constants;
 	my $get  				= new SeismicUnixPlTk_global_constants();
 	my $lib  				= $get->global_libs();
 	my $lib_path   			= $lib->{_param};
 	my $local_path   		= $lib->{_default_path};

 	my $var					= $get->var();

	my %name_space;
	my $true   				= $var->{_true};
	my $false  				= $var->{_false};
	
	use L_SU_local_user_constants;
    my $usr_config 			= L_SU_local_user_constants->new();
    my $ACTIVE_PROJECT		= $usr_config->get_ACTIVE_PROJECT();
	my $user_config_path 	= $ACTIVE_PROJECT;

	my $su_param = {
    	_name_space 		=> 'name_space',
    	_lib_path			=> $lib_path,		
    	_local_path			=> $local_path,
    	_user_config_path   => $user_config_path,
    	_names_aref			=> '',		
	    };



#=head2 sub get 
#
#  NO:LONGER IN USE
#  
#  returns values of namespace hash
#  as an array
#  input is a scalar reference
#  use Config::Simple;
#  
#  Config::Simple	->import_from($this,$su_param->{_name_space});
#  $size               = keys#  %name_space:: ;
#  print("we have $size keys\n\n");
#  print(" param is @$ref_param\n\n");
#  print("name/value pairs :  @$ref_name[$i] $value[$i]\n");
#
#  becuase hashes are not ordered, we take therr names/keys
#  from an array and locate the values through the hash
#  brought in by Config::Simple
#
#=cut
#
# sub get {
#
#  my ($self,$program_sref)  = @_;
#  my (@CFG,@value);
#  my ($this,$cfg,$length,$names_aref);
#  my ($i,$j);
#
#  if (defined $program_sref) {
#    $this 		= $su_param->{_path}.$$program_sref.'_param'; 
#    print("su_param,get: program is $this\n");
#    $cfg        	= new Config::Simple($this);
#    $names_aref         = names_in($this);
#    $length             = scalar @$names_aref; 
#    
#    $i=0;
#    foreach my $name (@$names_aref) {
#       $value[$i] 	=  $cfg->param($name);
#       #print("su_param,name is $name  \n\n");
#       #print("su_param,value is $value[$i]  \n\n");
#       $i++;
#    }
#
#    #print("su_param,get:we have $length keys\n\n");
#    for ($i=0,$j=0; $i <$length; $i++,$j=$j+2 ) {
#     $CFG[$j]     = $$names_aref[$i]; 
#     $CFG[($j+1)] = $value[$i]; 
#    }
#    return(\@CFG);
#   } 
# return();
#}



=head2 sub get

  returns values
  as an array
  input is a scalar reference
  
 Read a default specification file 
 If default specification file# does not exist locally
 then look in the suer's configuration directory
 ~HOME/.L_SU/configuration/active and if that does not exist
 then use the default one defined under global libs

  Debug with
    print ("this is $this\n");
    print ("self is $self,program is $program\n");

  Changing the name space variables to lower
  case is not a general solution because
  original variables can have mixed upper and lower
  case names
    my $a = Config::Simple->import_from($this,'Z');
     foreach my $key ( keys %Z:: )
    {
       my $x = lc $key;
        print "key is $x\n";
        print "$cfg->param($key)\n";
    }


=cut

sub get {
	my ($self,$program_sref)  = @_;

  	if (defined $program_sref) {
    	my (@CFG);
    	my ($length,$names_aref,$values_aref);
    	my ($i,$j,$program,$path);

    	use readfiles;
    	my $read 		= new readfiles();
    	
    	# reset the following test
    	my $local_config_exists = check4local_config('',$program_sref);
    	my $user_config_exists 	= check4user_config('',$program_sref);
    	
			 print("su_param,get,check4local_config $local_config_exists\n");
		if( $local_config_exists) {
			$path 					= $su_param->{_local_path};
			 print("1.1 su_param,get,local configuration files exists\n");
			 print("1.2 su_param,get,path is now $su_param->{_local_path} \n");
			 
		} elsif ( $user_config_exists ){
			  $path 					= $su_param->{_user_config_path};
			 print("2.1su_param,get,userconfiguration files exists\n");
			 print("2.2 su_param,get,path is now $su_param->{_user_config_path} \n");
			 
		}else {
			$path 					= $su_param->{_lib_path};
			print("3.1 su_param,get,using global lib-- default path \n");
			print("3.2 su_param,get,path is now $su_param->{_lib_path} \n");
		}
		
    	$program 					= $path.$$program_sref.'.config'; 
    	 			print("su_param,get,program=$program\n");

    	($names_aref,$values_aref) 	= $read->configs($program);
    	$su_param->{_names_aref} 	= $names_aref;
    	$length                    	= scalar @$names_aref;

    					 print("su_param,get:we have $length pairs\n\n");
    	for ( $i=0,$j=0; $i <$length; $i++,$j=$j+2 ) {

     		$CFG[$j]     	= $$names_aref[$i]; 
     		$CFG[($j+1)] 	= $$values_aref[$i]; 
    	}
    		return(\@CFG);
	}
}

=head2 sub check4local_config

 check for local versions of the configuration files

=cut


sub check4local_config {

 	my ($self,$name_sref) 	= @_;
 	
	my $ans 				= $false;
	
	if($name_sref) {
		if (-e ($$name_sref.'.config') ) {
			$ans  = $true;
			   print("su_param,check4local_config,$$name_sref.config found,Using local configuration file\n");
			   print("su_param,check4local_config=$ans\n");
		} else {
			$ans = $false;
			  print("su_param,check4local_config,$$name_sref not found. Using default configuration file\n")
		}
	}
	return($ans);
}

=head2 sub check4user_config

 check for versions of the configuration files
 in the user's configuration directory:
 .L_SU/configuration/active

=cut


sub check4user_config {

 	my ($self,$name_sref) 	= @_;

 	
	my $ans 				= $false;
	
	if($name_sref) {
		if (-e ($ACTIVE_PROJECT.'/'.$$name_sref.'.config') ) {
			$ans  = $true;
			   print("su_param,check4user_config,$$name_sref.config found,Using local configuration file\n");
			   print("su_param,check4user_config=$ans\n");
		} else {
			$ans = $false;
			   print("su_param,check4user_config,$$name_sref not found. Using default (GLOBAL LIBS) configuration file\n")
		}
	}
	return($ans);
}


=head2 sub length 

 This length is twice the number of parameter
  names
  print("su_param,length: is $length\n");


=cut

 sub length {

   my ($self)  = @_;
   if ($su_param->{_names_aref}) {
   	   my $length = (scalar @{$su_param->{_names_aref}}) *2;
   		return($length);
   } else {
   		# print ("su_param,length, empty names array reference\n");
   }

 }

#sub length {
#
# my ($self,$program_sref)  = @_;
#
#  if (defined $program_sref) {
#    use Config::Simple;
#
#    my ($this,$cfg,$length,$names_aref);
#    $this 		= $su_param->{_path}.$$program_sref.'_param'; 
#    $cfg        	= new Config::Simple($this);
#    $names_aref         = names_in($this);
#    $length               = (scalar @$names_aref) *2;; 
##    my ($this,$size);
##    $this 		= $su_param->{_path}.$$program_sref.'_param'; 
##
##    #print("this is $this \n");
##    #
##    # import key and value pairs into the current namespace
##    Config::Simple	->import_from($this,$su_param->{_name_space});
##    $size               = (keys %name_space::) ; 
##
#    return($length);
#  }
# return();
# } 

=head2 sub names_in 

  returns parameter names only 
  in order to maintain the correct parameter
  order. N.B. that hash arrays are not ordered.
  so we have to read in the names independently of using VOnfig::Simple to guarantee
  order
  print("@$ref_param\n\n");

=cut
 
# sub names_in {
#   my ($program)  = @_;
#   if (defined $program) {
#     my $ref_names;
#     use readfiles;
#     my $read 		= new readfiles();
#     $ref_names  	= $read->params($program);
#     return($ref_names);
#   }
# }

1;
