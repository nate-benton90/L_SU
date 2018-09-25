 package sunix_package;
 use Moose;

=head2 initialize shared anonymous hash 

  key/value pairs

=cut

 my $sunix_package = {
  	  _config_file_out	=> '',
  	  _spec_file_out	=> '',
  	  _file_in			=> '',
  	  _file_out			=> '',
  	  _length			=> '',
  	  _package_name		=> '',
  	  _num_lines		=> '',
  	  _path_out			=> '',
  	  _sudoc			=> '',
  	  _outbound_pm		=> '',
    };

=head2 sub get_file_out

  		 print("1. sunix_package,get_file_out is $sunix_package->{_file_out}\n");

=cut

sub get_file_out {
  my($self) = @_;
  my $file_out = $sunix_package->{_file_out} ;
  return($file_out);
}


=head2 sub set_config_file_out

   		 print("sunix_package,config_file_out,_config_file_out:  $sunix_package->{_config_file_out}\n");

=cut

sub set_config_file_out {
  my($self,$file_aref) = @_;
  $sunix_package->{_config_file_out} =  @$file_aref[0];
}
 
 
 
=head2 sub set_file_in

  print("file_in is $sunix_package->{_file_in}\n");
=cut

sub set_file_in {
  my($self,$file_aref) = @_;
  $sunix_package->{_file_in} =  @$file_aref[0];
}




=head2 sub set_file_out

   		 print("1. sunix_package,file_out is $sunix_package->{_file_out}\n");

=cut

sub set_file_out {
  my($self,$file_aref) = @_;
  $sunix_package->{_file_out} =  @$file_aref[0];
}


=head2 sub set_package_name
  print("name is $sunix_package->{_name}\n");

=cut

sub set_package_name {
  my($self,$file_aref) = @_;
  
  $sunix_package->{_package_name} =  @$file_aref[0];
  
}


=head2 sub set_path_out

  print("path_out is $sunix_package->{_path_out}\n");

=cut

sub set_path_out {
  my($self,$file_aref) = @_;
  
  $sunix_package->{_path_out} =  @$file_aref[0];
  
}


=head2 sub set_param_names


=cut

sub set_param_names {
	
  my($self,$names_aref) = @_;
  
  if ($names_aref) {
  	
  	$sunix_package->{_param_names}  = $names_aref ;
  	$sunix_package->{_length} 		=  scalar @$names_aref;
  	
#  	print("sunix_package,set_param_names,names: @{$names_aref}\n");
# 	print("sunix_package,set_param_names,length:$sunix_package->{_length} \n");
  
  } else {
  	 print("sunix_package,set_param_names,param_names are missing\n");
  }

}


=head2 sub set_param_values

  				 print("sunix_package,param_values @{$sunix_package->{_param_values}}\n");

=cut

sub set_param_values {
	
  my($self,$values_aref) = @_;
  
  if ($values_aref) { 
  	
  	$sunix_package->{_param_values} 	=  $values_aref;
  	$sunix_package->{_length} 		   =  scalar @$values_aref;
  	
#  	print("sunix_package,set_param_values,values: @{$values_aref}\n");
# 	print("sunix_package,set_param_values,length:$sunix_package->{_length} \n");
   
  } else {
  	print("sunix_package,set_param_values,param_values are missing\n");
  }
}


=head2 sub set_spec_file_out



=cut

sub set_spec_file_out {
  my($self,$file_aref) = @_;
  $sunix_package->{_spec_file_out} =  @$file_aref[0];
  #print("sunix_package,set_spec_file_out,_spec_file_out:  $sunix_package->{_spec_file_out}\n");
}

=head2 sub set_sudoc_aref

  print("sunix_package,sudoc @{$sunix_package->{_sudoc_aref}}\n");

=cut

sub set_sudoc_aref {
  my($self,$sudoc_aref) = @_;
  
  if ($sudoc_aref) {
  	
	$sunix_package->{_sudoc_aref} =  $sudoc_aref;
  
#  	 my $length = scalar @$sudoc_aref;  
#	  for (my $i=0; $i < $length; $i++) {
#	  	
#		 	  print ("@{$sudoc_aref}[$i]\n");
#	  	
#	  }
   	$sunix_package->{_num_lines} =  scalar @$sudoc_aref;  
 
  } else {
  	print("sunix_package,missing set_sudoc_aref\n");
  }
  
}



=pod sub write_config 

 open and write configuration 
 file

=cut

sub write_config {
 	my($self) = shift;

 	if ($sunix_package->{_config_file_out} && $sunix_package->{_length} ) { # avoids errors

   		my $OUT;
    	my $outbound	= $sunix_package->{_path_out}.$sunix_package->{_config_file_out};
   				# print ("sunix_package,write_config $outbound\n");

    	open  $OUT, '>', $outbound or die;
    	for (my $i=0; $i < $sunix_package->{_length}; $i++) {
        	printf $OUT "    %-35s%1s%-20s\n",@{$sunix_package->{_param_names}}[$i],'= ',
        	@{$sunix_package->{_param_values}}[$i];
    	}     
    	close($OUT);
   	}
 }


=pod sub write_pm 

 open  and write 
 to the package

=cut

 sub write_pm {
	my($self) = shift;

		# print("sunix_package, write_pm: sunix_package->{_file_out}= $sunix_package->{_file_out}\n");
		# print("sunix_package, write_pm: sunix_package->{_length}= $sunix_package->{_length}\n");
	 	
	if ($sunix_package->{_file_out} && $sunix_package->{_length} ) { # avoids errors
		my $name = $sunix_package->{_package_name};
		my $OUT;
		use sunix_package_encapsulated;
    	use sunix_package_header;
    	use sunix_package_pod;
    	use sunix_package_subroutine;
    	use sunix_package_tail;
     	
    	my $encapsulated 			    = sunix_package_encapsulated->new();
    	my $header 	    				= sunix_package_header		->new();
    	my $pod 	       				= sunix_package_pod			->new();
    	my $subroutine					= sunix_package_subroutine	->new();
    	my $tail						= sunix_package_tail		->new();
     
    	$header							->set_package_name($name);
    	$encapsulated					->set_package_name($name);
    	$encapsulated	        		->set_param_names($sunix_package->{_param_names});
    	$pod							->sunix_package_name($name);
    	$pod							->sudoc($sunix_package->{_sudoc_aref});
    	$subroutine						->set_name($name);
	
     	$sunix_package->{_outbound_pm}	= $sunix_package->{_path_out}.$sunix_package->{_file_out};

      	open  $OUT, '>', $sunix_package->{_outbound_pm} or die;
      	
		# prints out to file: package name
        print $OUT @{$header->get_package_name_section()};
        
        # prints out to file: Sunix documentation

        print $OUT @{$pod->header($sunix_package->{_sudoc_aref})};
 
         		#print ("sunix_package, write_pm, su documentation: @{$sunix_package->{_sudoc_aref}}[0]\n");
         
		# prints out to file: call to Moose      
      	print $OUT @{$header->get_Moose_section()};

  		# prints out to file: Version       
      	print $OUT @{$header->get_version_section()};    	
          		   	    
      	print $OUT @{$encapsulated->get_section};

      	for (my $i=0; $i < $sunix_package->{_length}; $i++) {

        	$subroutine->set_param_name_aref(\@{$sunix_package->{_param_names}}[$i]);
        	$pod	   ->subroutine_name(\@{$sunix_package->{_param_names}}[$i]);

        	print $OUT @{$pod->section};
        	print $OUT @{$subroutine->section};
      	}
      	
      	#      pod_declare();
		#	      declare();
		#      declare_external();
		#
     	print $OUT @{$tail->section};
     	      		# print ("sunix_package outbound $sunix_package->{_outbound_pm}\n");;
     	close($OUT);
      	
	}	else {
		print ("sunix_package,write_pm, misssing:  sunix_package->{_file_out} and sunix_package->{_length}\n");	
	}  


 }


=pod sub write_spec

 open and write specification file 
 file
 
 TODO

=cut

sub write_spec {
 	my($self) = shift;
 	use sunix_spec;
 	my $sunix_spec  	= sunix_spec->new();  
 	my $name 			= $sunix_package->{_package_name};
 	$sunix_spec			->set_package_name($name);
 	my $header			= $sunix_spec->get_header_section();
 	my $body 		    = $sunix_spec->get_body_section();
 	my $tail 			= $sunix_spec->get_tail_section();
 	my $subs			= $sunix_spec->get_subroutine_section();

 	if ($sunix_package->{_spec_file_out} ) { # avoids errors
 
    	my $outbound_spec	= $sunix_package->{_path_out}.$sunix_package->{_spec_file_out};
   		# print ("sunix_package,write_spec outbound_spec= $outbound_spec \n");
   		# print ("sunix_package,write_spec, header=\n @{$header}\n");  	
   		# print ("sunix_package,write_spec, body=\n @{$body}\n");  
      	open (my $OUT, '>', $outbound_spec) or die "Could not open file '$outbound_spec' $!";
      	
      	# print out the header
		print $OUT @{$header};
		print $OUT @{$sunix_spec->get_body_section()};
		print $OUT @{$sunix_spec->get_subroutine_section()};
		print $OUT @{$tail};
    	close $OUT;
   	}
 }

1;
