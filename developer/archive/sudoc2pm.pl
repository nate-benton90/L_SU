=head1 DOCUMENTATION

=head2 SYNOPSIS

PROGRAM NAME:  sudoc2pm.pl							

 AUTHOR: Juan Lorenzo
 DATE:   Jan 25 2018 
 DESCRIPTION: generate (1) package for sunix module
 			  and (2) configuration file for the same sunix module
 Version: 1.0.0

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES


=cut
 	
 	use Moose;

 	use sudoc;
 	use sunix_package;

 	my $sudoc			= sudoc			->new();
 	my $package 		= sunix_package	->new();

 	my (@file_in,@pm_file_out,@package_name);
 	my (@config_file_out);
 	my (@spec_file_out);
 	my (@inbound,@path_out);
 	my ($i);

 	my $sudoc2pm = {
		_names			=> '',
		_values			=> '',
		_line_contents  => '',
	};

=head2 SET UP sunix package to build


=cut

	$package_name[0] 		= 'a2b';
 	$package_name[0] 		= 'suxgraph';
 	$package_name[0] 		= 'supef';
 	$package_name[0]		= 'suacor';
 	$package_name[0]		= 'sugain';
  	$package_name[0]		= 'xwigb';
 	$package_name[0]		= 'suxwigb';
 	$package_name[0]		= 'sufilter'; 
  	$package_name[0]		= 'sufft';		
   	$package_name[0]		= 'suamp';	 	
		
 	$file_in[0] 			= 'a2b.par.main';
 	$file_in[0] 			= 'suxgraph.su.graphics.xplot';
 	$file_in[0] 			= 'xgraph.Xtcwp.main';
 	$file_in[0] 			= 'supef.su.main.decon_shaping';
 	$file_in[0]				= 'suacor.su.main.convolution_correlation';
	$file_in[0]				= 'sugain.su.main.amplitudes';
	$file_in[0]				= 'xwigb.xplot.main';
	$file_in[0]				= 'suxwigb.su.graphics.xplot';
	$file_in[0]				= 'sufilter.su.main.filters';
	$file_in[0]				= 'sufft.su.main.transforms';	
	$file_in[0]				= 'sufft.su.main.transforms';	
	$file_in[0]				= 'suamp.su.main.transforms';
	
 			#print("sudoc2pm, reading $file_in[0]\n");
 			
 	my $path 			= '/usr/local/cwp_su_all_48/src/doc/Stripped';

 	$pm_file_out[0] 		= $package_name[0].'.pm';
 	$config_file_out[0] 	= $package_name[0].'.config';
 	$spec_file_out[0] 		= $package_name[0].'_spec.pm';
 	$path_out[0] 			= './';

	# print("sudoc2pm.pl, reading $path/$file_in[0]\n");
	# print("sudoc2pm.pl, writing $path_out[0]$pm_file_out[0]\n");
	# print("sudoc2pm.pl, writing $path_out[0]$config_file_out[0]\n");
    # print("sudoc2pm.pl, writing $path_out[0]$spec_file_out[0]\n");
    
=head2 Read in sunix documentaion


=cut

 	$sudoc						->set_file_in(\@file_in);
 	$sudoc						->set_perl_path($path);
	$sudoc						->whole();
 	my $whole_aref      		= $sudoc->get_whole();
 	
 		# my $length 			= scalar @$whole_aref;
 	 	# print("sudoc2pm.pl,num_lines= $length\n");	 
 	 	# for (my $i=0; $i <$length; $i++) {
 	 	# 	print("sudoc2pm.pl,All sunix documentation @{$whole_aref}[$i]\n");
 	 	# }
	
 	$sudoc2pm->{_line_contents} = $sudoc->lines_with('='); 
 	
 	my $sudoc_namVal  			= $sudoc->parameters($sudoc2pm->{_line_contents});
 		
	my $length 					= scalar @{$sudoc_namVal->{_names}};
#	print("sudoc2pm.pl, num names = $length\n");	
#				for (my $i=0; $i < $length; $i++) {
#  	 			 print("\n3. sudoc2pm,_names = _values, 
#     			 line#$i @{$sudoc_namVal->{_names}}[$i] = ");
#  				print("@{$sudoc_namVal->{_values}}[$i]\n");
#				}

	$package				->set_file_out(\@pm_file_out);
	$package				->set_config_file_out(\@config_file_out);
	$package				->set_spec_file_out(\@spec_file_out);
	$package				->set_package_name(\@package_name);
	$package				->set_path_out(\@path_out);
	$package				->set_param_names($sudoc_namVal->{_names});
	$package				->set_param_values($sudoc_namVal->{_values});
	$package				->set_sudoc_aref($whole_aref);
	$package				->write_pm();
	$package				->write_config();
    $package				->write_spec();
