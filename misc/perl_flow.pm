 package perl_flow;


=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL PROGRAM NAME: perl_flow 
 AUTHOR: 	Juan Lorenzo
 DATE: 		June 22 2017 

 DESCRIPTION  Parse perl scripts written by L_SU
     

 BASED ON:


=cut

=head2 USE

=head3 NOTES  Needs sunix_pl.pm

=head4 Examples


=head2 CHANGES and their DATES 

 
=cut 

 use Moose;
 our $VERSION = '0.0.2';
 use sunix_pl;
 use Project;
 use SeismicUnixPlTk_global_constants;

 my $Project	= Project ->new(); 
 my $sunix_pl   = sunix_pl->new();
 my $get		= new SeismicUnixPlTk_global_constants();
 my $var		= $get->var();
 

=head2 declare variables

=cut
						
 my $nu      			= $var->{_nu};
 my $on      			= $var->{_on};
 my $off     			= $var->{_off};
 my $null_sunix_value 	= $var->{_null_sunix_value};

 my ($PL_SEISMIC) 	= $Project->PL_SEISMIC();
 my @file_in;
 my @file_out;
 my $i;
 
=head2 set private hash

=cut
 
 my $perl_flow = {
 	
  	_all_labels_aref2			=> '',	
 	_all_prog_versions_aref		=> '',
 	_all_prog_names_aref 		=> '',
 	_all_values_aref2			=> '',
 	_check_buttons_settings_aref=> '',
 	_file_in					=> '',
 	_good_labels_aref2			=> '',
  	_good_prog_names_aref 		=> '',
 	_good_prog_versions_aref	=> '', 
 	_good_values_aref2			=> '',
 	_labels_aref				=> '',
	_num_progs					=> '',
	_param_sunix_first_idx		=> '',
	_param_sunix_length			=> '',
	_prog_index					=> '',
	_prog_num					=> '',
	_values_aref				=> '',

 };


=head2 sub get_all_names_aref
	
=cut

sub get_all_names_aref {

	my ($self) = @_;

   if ($perl_flow->{_all_labels_aref2} && ($perl_flow->{_prog_index} >= 0 ) ) {
    	
    	my $all_labels_aref = @{$perl_flow->{_all_labels_aref2}}[$perl_flow->{_prog_index}];
    	
    	    	# my $length = scalar @{$all_labels_aref};
    			# print("perl_flow,get_all_names_aref,@{$all_labels_aref} \n");
				# print("perl_flow,get_all_names_aref,length = $length \n");
				
		return($all_labels_aref);
		
	} else {
		print("perl_flow,get_names,missing labels(names)\n");
		return();
	}
}


=head2 sub get_all_values_aref

 parameter values
	
=cut

sub get_all_values_aref {

	my ($self) = @_;

   if ($perl_flow->{_all_values_aref2} && ($perl_flow->{_prog_index} >= 0 ) ) {
    	
    	my $all_values_aref = @{$perl_flow->{_all_values_aref2}}[$perl_flow->{_prog_index}];
    	# print("perl_flow,get_all_values_aref,@{$all_values_aref} \n");
		return($all_values_aref);
		
	} else {
		print("perl_flow,get_all_values_aref, missing valuesor program index\n");
			return();
	}
}


=head2 sub get_check_buttons_settings_aref 


=cut

 sub get_check_buttons_settings_aref {
	my ($self) 	= @_ ;
	
  	if ( $perl_flow->{_check_buttons_settings_aref2} && ($perl_flow->{_prog_index} >= 0) ) {
    	
    	my $check_buttons_settings_aref = @{$perl_flow->{_check_buttons_settings_aref2}}[$perl_flow->{_prog_index}];
    		# print("perl_flow,get_check_buttons_settings_aref,@{$check_buttons_settings_aref} \n");
		return($check_buttons_settings_aref);
		
	} else {
		print("perl_flow,missing check_buttons_settings_aref\n");
		return();
	}	
      # print("perl_flow: get_check_buttons_settings_aref\n");
 }


=head2 sub get_num_prog_names

 working file name
	
=cut

sub get_num_prog_names{

	my ($self) = @_;
    		# print("perl_flow,get_num_prog_names,$perl_flow->{_num_progs}\n");
    if ($perl_flow->{_num_progs} ) {
    	
    	my $num_progs = $perl_flow->{_num_progs};
		return($num_progs);
		
	} else {
		
		print("perl_flow,missing num_progs\n");
			return();
	}
}


=head2 sub get_prog_name_sref
@{$perl_flow->{_all_prog_names_aref}}

=cut

 sub get_prog_name_sref {
 	my $self = @_;
 	
 			# print("perl_flow,get_prog_name_sref,  _prog_index:$perl_flow->{_prog_index}\n");
  			# print("perl_flow,get_prog_name_sref,  prog_name:@{$perl_flow->{_all_prog_names_aref}}[$perl_flow->{_prog_index}]\n");	
 	if ( $perl_flow->{_all_prog_names_aref} && ($perl_flow->{_prog_index} >= 0) )    {
 		my $prog_index 				= $perl_flow ->{_prog_index};
 		my @all_prog_names			= @{$perl_flow ->{_all_prog_names_aref}};
 		my $program_name  		    = $all_prog_names[$prog_index];
 			# print("perl_flow,get_prog_name_sref, $program_name \n");
 	 	return(\$program_name);
 	
 	} else {
 		print("perl_flow,get_prog_name_sref, missing prog_name\n");		
 	}
	
 }


=head2 sub parse

 read perl file line by line
 
 Always, 
 FIRST:  get_good_sunix_params
 THEN:   $sunix_pl->get_good_sunix_names(); 
  		for names of programs
 "good" values and labels are usually a subset of a much
  larger available set of 
  values and labels for that program
  
   	 	 foreach my $key (sort keys %$var) {
   			print (" grey_flow key is $key, value is $var\n");
  		}
  
 
=cut

sub parse {	
	my ($self) = @_;

 	use param_sunix;
 
	my $param_sunix	= param_sunix -> new();
 
 	my (@all_labels_aref2, @all_values_aref2,@check_buttons_settings_aref2);  # array of arrays
 
	$sunix_pl      	->set_perl_path($PL_SEISMIC);
	$sunix_pl		->whole();
	$sunix_pl		->set_progs_start_with('clear'); # 1st identifier
	$sunix_pl		->set_progs_end_with('Step()');	 # last identifier
	$sunix_pl		->set_num_progs();
 
	$perl_flow	->{_all_prog_names_aref} 		= $sunix_pl->get_all_sunix_names();
	$perl_flow	->{_all_prog_versions_aref} 	= $sunix_pl->get_all_versions();

	my $length 									= $sunix_pl->get_num_progs;
	$perl_flow->{_num_progs}					= $sunix_pl->get_num_progs;

				# print("perl_flow,o/p num_progs: $length\n");
				
	my $hash_ref   								= $sunix_pl->get_good_sunix_params();
	$perl_flow	->{_good_prog_names_aref} 	 	= $sunix_pl->get_good_sunix_names();
	$perl_flow	->{_good_prog_versions_aref}  	= $sunix_pl->get_good_prog_versions();
	my $new_num_progs 							= $sunix_pl->get_num_good_progs();
	my @good_prog_names  						= @{$perl_flow->{_good_prog_names_aref}};
	my @good_prog_versions  					= @{$perl_flow->{_good_prog_versions_aref}};
	
	$perl_flow ->{_good_labels_aref2}			= $hash_ref->{_labels_aref2};
	$perl_flow ->{_good_values_aref2}			= $hash_ref->{_values_aref2};
	
   				# print("perl_flow,all prog versions: @{$perl_flow->{_all_prog_versions_aref}}\n");
				# print("perl_flow,all program names: @{$perl_flow->{_all_prog_names_aref}}\n");
				# print("perl_flow,good program names: @{$perl_flow->{_good_prog_names_aref}}\n");
				# print("perl_flow,good program versions: @{$perl_flow->{_good_prog_versions_aref}}\n");
			 	# print("perl_flow,o/p new_num_progs: $new_num_progs\n");	 
			 	 	   	
    		# incorporate good labels/names and their values into a full set of labels
    		# and values belonging to each program
			#$new_num_progs = 1;
			# extract one program at a time 
		for(my $prog_idx =0; $prog_idx < $new_num_progs; $prog_idx++) {
			
			my (@all_labels, @all_values, @check_buttons_settings);
			my (@all_labels_aref,  @all_values_aref);
			
			# number of values (good values and good names) for each program in a perl flow
			# is usually less than the maximum possible
			# e.g. num_good_params <= $param_sunix_length, i.e., j <= k
			# e.g. if only one label carries a value then the num_good_params=1 although there may
			# be many more labels that are empty.
			
			my $num_good_params 		= scalar @{@{$perl_flow->{_good_values_aref2}}[$prog_idx]};		
			my $good_prog_name      	= $good_prog_names[$prog_idx];
			my $good_prog_version     	= $good_prog_versions[$prog_idx];
		
				 # print("perl_flow, parse prog: $prog_idx--num_good_params: $num_good_params---\n");
				 # print("perl_flow, program name: prog_name, $good_prog_name\n");

			# info about a sunix program from its configuration file e.g.,  suximage.config
			$param_sunix   					->set_program_name(\$good_prog_name);
   			my $sunix_first_idx  			= $param_sunix->first_idx();
   			my $param_sunix_length  		= $param_sunix->get_length4perl_flow();  # N.B. = # values or labels
   			my $labels_aref 				= $param_sunix->get_names();
 	  		my $values_aref 				= $param_sunix->get_values();
   			
				# print("perl_flow,parse,labels @$labels_aref\n");
				# print("0. perl_flow,parse,param_sunix_length,$param_sunix_length\n");
				
			# for a single program, assign values (if they exist) to their appropriate labels
			#  <= k, k is for ALL possible program parameters  
   	 		# j is only for parameter labels with non-empty values		
			for (my $k=0; $k < $param_sunix_length; $k++){	

				my $a_label	=	@$labels_aref[$k];
   			 	# print("perl_flow, parse, a_label $a_label\n");
   			 											
   				for (my $j=0; $j <$num_good_params; $j++ ) {
 
   		   			my @good_labels 			= @{@{$perl_flow->{_good_labels_aref2}}[$prog_idx]};
					my @good_values 			= @{@{$perl_flow->{_good_values_aref2}}[$prog_idx]};
					my $this_good_label  		= $good_labels[$j];
					my $this_good_value  		= $good_values[$j];					
								
   					# compare the label in the standard program config files 
					# against the labels read from the perl flow
  					if ($a_label eq $this_good_label)  {
  					
   						
						$all_labels[$k] 			= $this_good_label;
 						$all_values[$k] 			= $this_good_value;
 						$check_buttons_settings[$k] = $on;
 						
 							# print("2. perl_flow,parse, MATCH of good label and a_label\n");
   							# print("perl_flow,parse,good value: $all_values[$k] k=$k, j=$j\n");
   							# print("perl_flow,parse, good label: $all_labels[$k], k=$k, j=$j\n");
 						
   					} elsif ($a_label ne $this_good_label) {
   						
   						if($all_labels[$k]) {  # don't overwrite 
   							#NADA
   							# print("2. perl_flow,parse, don't overwrite all_labels[$k] = $all_labels[$k]\n");
   							
   						} else {  # CASE of label with empty space in the value column
   							$all_labels[$k] 			= $a_label;
							$all_values[$k]				= ();
 							$check_buttons_settings[$k] = $off;
 						   	# print("2. perl_flow,parse, MISMATCH of this_good_label $this_good_label and a_label: $a_label, k=$k, j=$j\n");
 				
   						}
 													
 					} else {	  						
   						print("perl_flow,parse: should never get here\n");
   					} 

   				} # for good parameter labels, i.e. from perl flow and <= max number
   				

			} # for all labels
					$all_labels_aref2[$prog_idx] 				= \@all_labels;  # save one array of labels for each program
					$all_values_aref2[$prog_idx] 				= \@all_values;  # save one array of values for each program
					$check_buttons_settings_aref2[$prog_idx] 	= \@check_buttons_settings; # save one array on|off for each program	

				# print("3. perl_flow,parse,prog_idx:$prog_idx, all_values[0]: $all_values[0]  and all_labels[0]: $all_labels[0]\n");
		
		} # for each program
		
		$perl_flow->{_all_labels_aref2}				= \@all_labels_aref2;	
		$perl_flow->{_all_values_aref2} 			= \@all_values_aref2;
		$perl_flow->{_check_buttons_settings_aref2} = \@check_buttons_settings_aref2;
}


=head2 sub set_perl_file_in

 working file name
	
=cut

sub set_perl_file_in {

	my ($self,$file_in) = @_;
    		# print("perl_flow,set_perl_file_in, $file_in\n");
    
	if ($file_in) {
		
		$perl_flow->{_file_in} 	= $file_in;
 		$sunix_pl				->set_perl_file_in($perl_flow->{_file_in});
		
	} else {
		print("perl_flow,missing file_in\n");		
	}
	return();
}



=head2 sub set_prog_index

=cut

 sub set_prog_index {
 	my ($self, $index) = @_;
 	
 	if ($index >=0) {
 		$perl_flow ->{_prog_index} = $index;
 		# print("perl_flow,set_prog_index: $index\n");
 	} else { 		
 		print("perl_flow,set_prog_index, missing prog index\n");
 	} 	
 return();
 }
1;
