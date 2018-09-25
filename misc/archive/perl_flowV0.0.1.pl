
		
		
		
		
		
					for (my $j=0; $j <$num_good_params; $j++ ){			
		
				my @good_labels 			= @{@{$perl_flow->{_good_labels_aref2}}[$prog_idx]};
				my @good_values 			= @{@{$perl_flow->{_good_values_aref2}}[$prog_idx]};
				my $this_good_label  		= $good_labels[$j];
				my $this_good_value  		= $good_values[$j];
									

						
   				for (my $k=0; $k < $param_sunix_length; $k++) {  #  <= k, k is for ALL possible program parameters  
   																 # j is only for parameter labels with non-empty values   			 							
   			 		if (@$labels_aref[$k] eq $this_good_label ) {
   			 		
   			 			$all_labels[$k] 			= @$labels_aref[$k];
   			 			$all_values[$k] 			= $this_good_value;
   			 			$check_buttons_settings[$k] = $on;		

   			 			 # print("1. perl_flow,parse,MATCH! of $this_good_value to @$labels_aref[$k], index=$k\n");
   			 			
   			 		} elsif (@$labels_aref[$k] ne $this_good_label)  {
						$all_labels[$k] 			= @$labels_aref[$k];
						$check_buttons_settings[$k] = $off;
   			 		# DO NADA to values. Because for a curnon-matching label a good value may have already been inserted.
   			 				# print("perl_flow,parse, No MATCH check_buttons_settings:$check_buttons_settings[$k]\n");
  			 			# print("2. perl_flow,parse,No MATCH! label=@$labels_aref[$k], value=null,index=$k\n");

   					} else {
   						print("perl_flow,parse: should never get here\n");
   					} 				
   				
   				} # for good values and names, specifically	
  				
		} # for all good parameter values and labels, i.e. from perl flow and <= max number
#		