 use Moose;
 use sunix_pl;
 #use write_psunix;
 use Test::Simple tests => 2;
     
 use Math qw(compute);
     
    ok( compute('+', 2, 3) == 5 );
    ok( compute('-', 5, 2) == 3 );

 my @file_in;
 my @file_out;
 my $i;

 $file_in[0]  = 'Xamine.pl';
 $file_out[0] = 'out.pl';

 my $sunix_pl   = sunix_pl->new();
 $sunix_pl		->set_file_in(\@file_in);
 $sunix_pl		->set_file_out(\@file_out);

=pod
 read perl file line by line
=cut

 $sunix_pl->whole();
 $sunix_pl->set_progs_start_with('clear');
 $sunix_pl->set_progs_end_with('Step()');
 
 my $all_sunix_names_ref =  $sunix_pl->get_all_sunix_names();
     print("main, all sunix_names, @{$all_sunix_names_ref}\n");
    
 #$sunix_pl->versions();
 #my $length = $sunix_pl->length;
 #print("main, $length->{_num_progs} programs have been found in $file_in[0]\n"); 
 my $sunix_params_href    = $sunix_pl->get_sunix_params();
 
 my $sunix_pl->{_labels_aref2} = $sunix_params_href->{_labels_aref2}
  my $sunix_pl->_values_aref2} = $sunix_params_href->_values_aref2} 
 	#$sunix_pl->{_labels_aref2} = \@labels_aref_holder;
	#$sunix_pl->{_values_aref2} = \@values_aref_holder;
	
	my $new_num_progs = scalar @{$sunix_pl->{_values_aref2}};	
	for(my $i=0; $i < $new_num_progs; $i++) {
		my $num_params = scalar @{$values_aref_holder[$i]};
				# print("sunix_pl, prog: $i---num_params: $num_params---\n");
				# print("sunix_pl, original good program index: $good_prog_index[$i]\n");
		
		#for (my $j=0; $j <$num_params; $j++ ){	
		#			print("sunix_pl,get_sunix_params,labels: @{@{$sunix_pl->{_labels_aref2}}[$i]}[$j]\n");
		#			print("sunix_pl,get_sunix_params,values: @{@{$sunix_pl->{_values_aref2}}[$i]}[$j]\n");
		#		}
	}
 	
 my $good_sunix_names_ref = $sunix_pl->get_good_sunix_names();
     print("main, good_sunix_names, @{$good_sunix_names_ref}\n");
=pod writing section
=cut 
