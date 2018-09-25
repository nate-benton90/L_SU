package oop_text;

=head2 object-oriented perl lines of text
		2018 V 0.0.1
       
	V 0.0.2 July 24 2018 include data_in and data_out
	 add \t to pod_prog_param
	
=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL PROGRAM NAME: oop_text
 AUTHOR: 	Juan Lorenzo
 DATE: 		June 22 2017 

 DESCRIPTION 
     

 BASED ON:


=cut

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES

=cut 

 
	use Moose;
	our $VERSION = '0.0.2';
 	use misc::declare_data;
 	use misc::declare_pkg;
 	use misc::flows;  # corrects data-program order for seismic unix
 	use misc::pod_header;
 	use misc::inbound;
 	use misc::instantiation;
	use misc::log_flows;
 	use misc::pod_declare;
 	use misc::pod_flows;
 	use misc::pod_log_flows;
 	use misc::pod_prog_param_setup;
 	use misc::pod_run_flows;
	use misc::print_flows;
 	use misc::prog_params;
	use misc::run_flows;
 	use misc::use_pkg;
	use SeismicUnixPlTk_global_constants;
# 	use misc::pod_tail;

	my $get  					= new SeismicUnixPlTk_global_constants();
 	my $declare_data_in 		= declare_data->new();
 	my $declare_data_out 		= declare_data->new();
 	my $file_out;
 	my $file_in;
 	my $flows 					= flows->new();
 	my $get_declare_pkg 		= declare_pkg->new();
 	my $get_pod_header 			= pod_header->new();
 	my $get_inbound 			= inbound->new();
 	my $get_instantiation 		= instantiation->new();
 	my $get_run_flows 			= run_flows->new();
 	my $get_log_flows 			= log_flows->new();
 	my $get_pod_declare 		= pod_declare->new();
 	my $get_pod_flows 			= pod_flows->new();
 	my $get_pod_log_flows 		= pod_log_flows->new();
 	my $get_pod_run_flows 		= pod_run_flows->new();
 	my $get_pod_prog_param_setup = pod_prog_param_setup->new();
 	my $get_print_flows 		= print_flows->new();
	my $prog_params     		= prog_params->new();
 	my $get_use_pkg 			= use_pkg->new();
 	my @lines=();
 	my $self;

	my $var						= $get->var();

	my $true               		= $var->{_true};
	my $false               	= $var->{_false};

=head2 private hash

=cut


	my $oop_text = {
		_data_type						=> '',
		_data_type_in					=> '',
		_data_type_out					=> '',
		_filehandle   					=> '',
		_file_name_in  					=> '',
		_is_config						=> $false,
		_is_data						=> $false,
		_is_data_in						=> $false,
		_is_data_out					=> $false,
		_message_w						=> '',
		_num_progs4flow					=> '',
   		_prog_name 						=> '',
   		_prog_names_aref				=> '',
   		_prog_param_labels_aref 		=> '',
   		_prog_param_values_aref 		=> '',
   		_prog_version 					=> '',
   		_prog_version_aref 				=> '',
	};
	
			# normally filehandle is undefined
			# unless overwritten with another filehandle 
			# before use
	$oop_text->{_filehandle} = undef; # for future use perhaps


=head2 sub set_data

	  foreach my $key (keys %$hash_ref) {
	 		  print("oop_text,set_data $key is $hash_ref->{$key}\n");
	 }

=cut

sub set_data {
	my ($self,$hash_ref) 		= @_;
	use SeismicUnix qw ($segy $su $txt $text $bin);
	
	$oop_text->{_data_type_in}		= $hash_ref->{_data_type_in};
	$oop_text->{_data_type_out}		= $hash_ref->{_data_type_out};
	$oop_text->{_is_data_in}		= $hash_ref->{_is_data_in};
	$oop_text->{_is_data_out}		= $hash_ref->{_is_data_out};

			# print("oop_text,set_data made it\n");

	my $type_in 					= $oop_text->{_data_type_in};	
	my $type_out 					= $oop_text->{_data_type_out};	
	my $data_out 					= $oop_text->{_is_data_out};	
	my $data_in 					= $oop_text->{_is_data_in};
		
	if ($data_in) {

		if($type_in eq $su ) {
			# print("oop_text,set_data, is data_in type eq $su\n");
			$declare_data_in->set_type_in($su);
			$declare_data_in->set_su_in();
		}

		if($type_in eq $bin ) {
			# print("oop_text,set_data_in type eq $bin\n");
			$declare_data_in->set_type_in($bin);
			$declare_data_in->set_bin_in();
		}

		if($type_in eq $txt || $type_in eq $text) {
			# print("oop_text,set_data_in type eq $txt\n");
			$declare_data_in->set_type_in($txt);
			$declare_data_in->set_text_in();
		}


	}
	elsif ($data_out) {

			#print("oop_text,set_data out\n");
			# do not repeat delarations
		if ($type_in ne $type_out) {
			# print("oop_text,in and out data different types\n");

			if($type_out eq $su ) {
			 	# print("oop_text,set_data,out type eq $su\n");
				$declare_data_out->set_type_out($su);
				$declare_data_out->set_su_out();
			}

			elsif($type_out eq $bin ) {
			 	# print("oop_text,set_data out type eq $bin\n");
				$declare_data_out->set_type_out($bin);
				$declare_data_out->set_bin_out();
			}

			elsif($type_out eq $text || $type_out eq $txt) {
			 	# print("oop_text,set_data out type eq 'txt'\n");
				$declare_data_out->set_type_out($txt);
				$declare_data_out->set_text_out();
			}
			elsif($type_out eq $segy ) {
			 	# print("oop_text,set_data out type eq $segy\n");
				$declare_data_out->set_type_out($segy);
				$declare_data_out->set_text_out();
			}
			else {
				
				print("oop_text,set_data out type missing \n");
			}

			# when input and output formats are the same
		} elsif ($type_in eq $type_out) {

			# print("oop_text,in and out data same types\n");
			if($type_out eq $su ) {
				$declare_data_out->empty();
				$declare_data_out->set_su_out();
			}

			elsif($type_out eq $bin ) {
				$declare_data_out->empty();
				$declare_data_out->set_bin_out();
			}

			elsif($type_out eq $text ||  $type_out eq $txt ) {
				$declare_data_out->empty();
				$declare_data_out->set_text_out();
			} 
			else {
				print("oop_text,in and out data same types, missing type_out\n");
				
			}
		} else {
			
			print("oop_text,in and out data types are neight the same or different\n");
		}
	}
	else {
		print("oop_text,neither data_in nor data_out\n");
	}
	
	return();
}

sub set_file_name_in {
	my ($self,$file_name) = @_;
		if ($file_name) {
		 	# print("oop_text,set_file_name_in = $file_name\n");
			$oop_text->{_file_name_in} = $file_name;
		}

	return();
}

sub set_file_name_out{
	my ($self,$file_name) = @_;
		if ($file_name) {
		 	# print("oop_text,set_file_name_out = $file_name\n");
			$oop_text->{_file_name_out} = $file_name;
		}

	return();
}


=pod sub declare_data_in 
 
 write declare_data_in 
 data can be indifferent formats,
 e.g. su, text, binary etc. 

 data can be for input or output

=cut

sub declare_data_in {
	my $self = @_;
				#print("oop_text,declare_data_in\n");

	my $ref_array 	= $declare_data_in->inbound_section();
	my @array       = @$ref_array;
	my $filehandle 	= $oop_text->{_filehandle};
	my $length 		= scalar @array; 

    print $filehandle $array[0]."\n";
    print $filehandle $array[1]."\n";

	print $filehandle "\t".'$file_in[1]'."\t".'= '."'".$oop_text->{_file_name_in}."'".';'."\n";

	for (my $i=2; $i < $length; $i++) { 
   		print $filehandle $array[$i]."\n";
 	}

 	return();
}



=pod sub declare_data_out 
 
 write declare_data_out 
 data can be indifferent formats,
 e.g. su, text, binary etc. 

 data can be for input or output

=cut

sub declare_data_out {
	my $self = @_;
				#print("oop_text,declare_data_out\n");
	my $ref_array = $declare_data_out->outbound_section();
	my $filehandle = $oop_text->{_filehandle};

 	foreach  (@$ref_array) {
   		print $filehandle "$_\n";
 	}


 	return();
}


=pod sub declare_pkg 
 
  write declare_pkgs 
  V0.0.2 July 24 2018, includes data_out includes data_in

=cut

sub declare_pkg {
	my $self = @_;

	my $ref_array = $get_declare_pkg->section();
	my $filehandle = $oop_text->{_filehandle};
   
 	foreach  (@$ref_array) {
   		print $filehandle "$_\n";
 	}

    my $num_progs4flow = $oop_text->{_num_progs4flow};

	for (my $j=0;  $j<$num_progs4flow; $j++){

					# exclude declaring data files here
					# data file declarations are handled by declare_data
		my $prog_name 		= @{$oop_text->{_prog_names_aref}}[$j];

				#if ($prog_name ne 'data_out') { # removed in V 0.0.2
		print $filehandle "\t".'my (@'.$prog_name.');'."\n";
				#}
	}


 	return();
}


=pod sub flows 

  write built flows 
		  print("oop_text,flows,prog_version_aref=@{$oop_text->{_prog_version_aref}}\n");

=cut

sub flows {
	my $self = @_;

	 $flows	->set_message($oop_text);
	 $flows	->set_prog_version_aref($oop_text);
	 $flows	->set_num_progs4flow($oop_text);
	 $flows	->set_prog_names_aref($oop_text);
	 $flows	->set_specs();

	 my $ref_array  = $flows	->get_section();
	 my $filehandle = $oop_text	->{_filehandle};
   
 	foreach  (@$ref_array) {
   		print $filehandle "$_\n";
   		# print "$_\n";
 	}

 	return();
}

=pod sub pod_header 
 
 import standard perl
 pod_headers 
 and write to output file

=cut

sub pod_header {
	my $self = @_;

	my $ref_array 	= $get_pod_header->section();
	my $filehandle 	= $oop_text->{_filehandle};
		# my $length 		= scalar @$ref_array;
   
 	foreach  (@$ref_array) {
   		print $filehandle "$_\n";
 	}

 	return();
}

#=head2 sub write_inbound 
#
# import standard perl
# inbound files and their paths 
#
#=cut
#
#sub write_inbound {
# my ($file_in) = @_;
# print (" 3. file in is $self->{_file_in}\n"); 
# my $ref_array = $get_inbound->section($self->{_file_in});
#  foreach (@$ref_array) {
#    print $file_out "$_\n";
#  }
#	return();
#}


=head2 sub instantiation

=cut
 
 sub instantiation{
	my $self = @_;

    $get_instantiation	->set_prog_names_aref($oop_text);
 	my $ref_array 		= $get_instantiation->section();
	my $filehandle 		= $oop_text->{_filehandle};

 	foreach  (@$ref_array) {
   		print $filehandle "$_\n";
 	}

	return();
 } 



=head2 sub log_flows

=cut


 sub log_flows {
	my $self = @_;

	my  $ref_array = $get_log_flows->section();
	my $filehandle = $oop_text->{_filehandle};

 	foreach  (@$ref_array) {
   		print $filehandle "$_\n";
 	}
	return();

 } 


=head2 sub pod_delcare

=cut
 
 sub pod_declare {
	my $self = @_;

	my  $ref_array = $get_pod_declare->section();
	my $filehandle = $oop_text->{_filehandle};
   
 	foreach  (@$ref_array) {
   		print $filehandle "$_\n";
 	}
	return();
 }

=head2 sub pod_flows

=cut
 
sub pod_flows {
	my $self = @_;

   	my  $ref_array = $get_pod_flows->section();
	my $filehandle = $oop_text->{_filehandle};
   
 	foreach  (@$ref_array) {
   		print $filehandle "$_\n";
 	}
	return();
}

=head2 sub pod_log_flows

=cut
 
sub pod_log_flows {
	my $self = @_;

   	my  $ref_array = $get_pod_log_flows->section();
	my $filehandle = $oop_text->{_filehandle};
   
 	foreach  (@$ref_array) {
   		print $filehandle "$_\n";
 	}
	return();
}



=head2 sub pod_prog_param_setup

	write pod on
	Setup

=cut
 
sub pod_prog_param_setup {
	my ($self) = @_;
	my $program_name 	= $oop_text->{_prog_name};

   	my $ref_array 		= $get_pod_prog_param_setup->section();
	my @array     		= @$ref_array; 
	my $filehandle 		= $oop_text->{_filehandle};
  	my $length     		= scalar @$ref_array; 
	my $i;

 	for ($i=0; $i < ($length-1); $i++) {
   		print $filehandle $array[$i]."\n";
 	}
	print $filehandle "\t".$program_name.' parameter values'."\n";
	print $filehandle  $array[$i];
	return();
}


=head2 sub pod_run_flows

=cut
 
sub pod_run_flows {
	my $self = @_;

   	my  $ref_array = $get_pod_run_flows->section();
	my $filehandle = $oop_text->{_filehandle};
   
 	foreach  (@$ref_array) {
   		print $filehandle "$_\n";
 	}
	return();
}


=head2 sub print_flows

=cut


 sub print_flows {
	my $self = @_;

	my  $ref_array = $get_print_flows->section();
	my $filehandle = $oop_text->{_filehandle};

 	foreach  (@$ref_array) {
   		print $filehandle "$_\n";
 	}
	return();

 } 

=head2 sub prog_params
	 	print("oop_text,prog_params,version=$oop_text->{_prog_version}\n");
	 	print("oop_text,prog_params,labels=@{$oop_text->{_prog_param_labels_aref}}\n");
	 	print("oop_text,prog_param,values=@{$oop_text->{_prog_param_values_aref}}\n");
	 	print("oop_text,prog_params,prog_name=$oop_text->{_prog_name}\n");

=cut


 sub prog_params {
	my $self = @_;
	my $filehandle 	= $oop_text->{_filehandle};
					
	$prog_params	->set_prog_name($oop_text);
	$prog_params	->set_prog_version($oop_text);
	$prog_params	->set_param_labels($oop_text);
	$prog_params	->set_param_values($oop_text);

	my $ref_array = $prog_params->get_section();

	if ((@$ref_array[0])) {  # test empty case

		#print("1. oop_text,prog_params, flow item detected \n");
 		foreach  (@$ref_array) {
   			print $filehandle "$_\n";  # NOT FORMATTED
 		}
	} else {
		print("Warning: oop_text,prog_params, no flow item detected\n");
	}
		return();

 } 


=head2 sub run_flows

=cut

 sub run_flows {
	my ($self) = @_;

	my  $ref_array = $get_run_flows->section();
	my $filehandle 	= $oop_text->{_filehandle};

 	foreach  (@$ref_array) {
   		print $filehandle "$_\n";
 	}

	return();
 } 


=head2 sub set_message

=cut

sub set_message {
	my ($self,$hash_ref) = @_;

	if ( $hash_ref) {
    	$oop_text->{_message_w} = $hash_ref->{_message_w}; 
				# my $message_w     = $oop_text->{_message_w};
				# my	$m          = "oop_text,set_message,$message_w\n";
 	  			# $message_w->delete("1.0",'end');
 	  			# $message_w->insert('end', $m);
		# print("oop_text,set_message, message=$oop_text->{_message}\n");
	}
	return();
}


=head2 sub set_filehandle

=cut

sub set_filehandle {
	my ($self,$filehandle) = @_;

	if ( $filehandle) {
    	$oop_text->{_filehandle} = $filehandle; 
		# print("oop_text,set_filehandle, filehandle=$oop_text->{_filehandle}\n");
	}
	return();
}

=head2 sub set_prog_name

=cut

sub set_prog_name {
	my ($self,$prog_name) = @_;

	if ( $prog_name ) {
    	$oop_text->{_prog_name} = $prog_name; 
		 # print("oop_text,set_prog_name,prog_name=$oop_text->{_prog_name}\n");
	}
	return();
}

=head2 sub set_prog_version

=cut

sub set_prog_version {
	my ($self,$prog_version) = @_;

	if ( $prog_version ) {
    	$oop_text->{_prog_version} = $prog_version; 
		 # print("oop_text,set_prog_version,prog_version=$oop_text->{_prog_version}\n");
	}
	return();
}

=head2 sub set_prog_version_aref

		  print("oop_text,set_prog_version_aref,prog_version_aref=@{$hash_aref->{_items_versions_aref}}\n");
		  print("oop_text,set_prog_version_aref,prog_version_aref=@{$oop_text->{_prog_version_aref}}\n");

=cut

sub set_prog_version_aref {
	my ($self,$hash_aref) = @_;

	if ( $hash_aref ) {
    	$oop_text->{_prog_version_aref} = $hash_aref->{_items_versions_aref}; 
	}
	return();
}



=head2 sub set_num_progs4flow

=cut

sub set_num_progs4flow {
	my ($self,$prog_names_aref) = @_;

	if ( $prog_names_aref ) {
     	$oop_text->{_num_progs4flow} = scalar @$prog_names_aref;
		# print("oop_text,set_num_progs4flow,num_progs4flow =$oop_text->{_num_progs4flow}\n");
	}
	return();
}



=head2 sub set_prog_names_aref

=cut
sub set_prog_names_aref {
	my ($self,$prog_names_aref) = @_;

	if ( $prog_names_aref ) {
    	$oop_text->{_prog_names_aref} = $prog_names_aref; 
		  # print("oop_text,set_prog_names_aref, prog_names=@{$oop_text->{_prog_names_aref}}\n");
	}
	return();
}


=head2 sub set_prog_param_values_aref

=cut

sub set_prog_param_values_aref {
	my ($self,$prog_param_values_aref) = @_;
		 # print("oop_text,set_prog_param_values_aref, prog_param_values=@{$prog_param_values_aref}\n");

	if ( $prog_param_values_aref ) {
    	$oop_text->{_prog_param_values_aref} = $prog_param_values_aref; 
		 # print("oop_text,set_prog_param_values_aref, prog_param_values=@{$oop_text->{_prog_param_values_aref}}\n");
	}
	return();
}


=head2 sub set_prog_param_labels_aref

=cut

sub set_prog_param_labels_aref {
	my ($self,$prog_param_labels_aref) = @_;

	if ( $prog_param_labels_aref ) {
    	$oop_text->{_prog_param_labels_aref} = $prog_param_labels_aref; 
		 # print("oop_text,set_prog_param_labels_aref, prog_param_labels=@{$oop_text->{_prog_param_labels_aref}}\n");
	}
	return();
}


=head2 sub use_pkg

e.g., 	use misc::message;
		use misc::flow;

=cut

sub use_pkg {
	my $self = @_;

   	my $ref_array 		= $get_use_pkg->section();
	my $length 			= scalar @$ref_array;
    my $num_progs4flow = $oop_text->{_num_progs4flow};

	my $filehandle = $oop_text->{_filehandle};
				# print("oop,text,use_pkg,length=$length\n");
				
   	for (my $i=0; $i < $length; $i++ ) {
     	print $filehandle  @$ref_array[$i];
   	}
   	
	for (my $j=0;  $j<$num_progs4flow; $j++){
		 my $prog_name 		= @{$oop_text->{_prog_names_aref}}[$j];
		if($prog_name ne 'data_in' && $prog_name ne 'data_out') { 
			
     	   print $filehandle  "\t".'use sunix::'.$prog_name.';'."\n";
     	   
		} elsif ($prog_name ne 'data_in' or $prog_name ne 'data_out')  {# added  in V 0.0.2
		
			print $filehandle  "\t".'use misc::'.$prog_name.';'."\n";
			
		} else {
			print("oop_text,use_pkg, missing prog name \n");
		}
	}
	return();
} 


1;

