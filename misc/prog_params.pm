package prog_params;

=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL PACKAGE NAME: prog_params
 AUTHOR: 	Juan Lorenzo
 DATE: 		2018

 DESCRIPTION 
     

 BASED ON:
 Version 0.0.2 July 26 2018   
 changed _private_* to _*
 removed exceptions to data_in and data_out
      

=cut

=head2 USE

=head3 NOTES

=head4 Examples

=head2 CHANGES and their DATES

=cut 
use Moose;
our $VERSION = '0.0.3';

=head2 program parameters
	 
  private hash
  
=cut


	my $prog_params = {
    	_prog_name 	   		    	=> '',
    	_prog_version 	   		    => '',
    	_param_labels_aref 	   		=> '',
    	_param_values_aref 	   		=> '',
 	};


=head2 sub _get_exceptions

	to detect data in flows

=cut

sub _get_exceptions {
	my $self 		= @_;
	my $ans         = 1;
	my $prog_name 	= $prog_params->{_prog_name};

#	if ($prog_name eq 'data_in') {
#		$ans         = 0;
#	};

#	if ($prog_name eq 'data_out') {
#		$ans         = 0;
#	};

 	return($ans);
}


=head2 sub get_section

 e.g., 
 	$sugain		->clear();
	$sugain				->pbal(1);
	$sugain[1] 			= $sugain->Step();

=cut

sub get_section {
	my $self 		= @_;
	
	use control;
	my $control		= new control();
	
	my $prog_name 	= $prog_params->{_prog_name};
	my $j 			= 0;
	
 	my @prog_params;
	my $ok = _get_exceptions();
	if ($ok) {
 		$prog_params[$j] = "\t".'$'.$prog_name."\t\t\t\t"."->clear();";

		my $length = scalar @{$prog_params->{_param_labels_aref}}; # same as for values
		my $version = $prog_params->{_prog_version};

    	for (my $param_idx=0,$j=1; $param_idx < $length; $j++,$param_idx++ ) {
			my $label 	= @{$prog_params->{_param_labels_aref}}[$param_idx];
					# print("1. prog_params,get_section, label = $label\n");
			 $label		= $control->ors($label);
					# print("2. prog_params,get_section, label = $label\n");
			my $value = @{$prog_params->{_param_values_aref}}[$param_idx];

			$prog_params[$j] = "\t".'$'.$prog_name."\t\t\t\t".'->'.$label.'('.
			$value.');';
					# print("2. prog_params,get_section, label,value = $prog_params[$j]\n");
		}
 		$prog_params[$j] = "\t".'$'."$prog_name".'['.
		$version.'] '."\t\t\t".'= $'."$prog_name".'->Step();';
 		return (\@prog_params);

	} else {

		print("prog_params,get_section, data detected\n");
 		$prog_params[0] = "\t".'place data here'."\n";
 		return (\@prog_params);

	}# no exceptions
}

sub set_param_labels {

	my ($self,$param_labels_href)  = @_;

	if ($param_labels_href) {
		$prog_params->{_param_labels_aref} = $param_labels_href->{_prog_param_labels_aref};
			# print("prog_params,set_param_labels,param_labels,@{$prog_params->{_param_labels_aref}}\n");
	}
 	return ();
}


sub set_param_values {

	my ($self,$param_values_href)  = @_;

	if ($param_values_href) {
		$prog_params->{_param_values_aref} = $param_values_href->{_prog_param_values_aref};
			# print("prog_params,set_param_values,param_values,@{$prog_params->{_param_values_aref}}\n");
	}
 	return ();
}


sub set_prog_name {

	my ($self,$prog_name_href)  = @_;

	if ($prog_name_href) {
		$prog_params->{_prog_name} = $prog_name_href->{_prog_name};
			# print("1. prog_params,set_prog_name,prog_name,$prog_params->{_prog_name}\n");
	}
 	return ();
}


sub set_prog_version {

	my ($self,$prog_version_href)  = @_;

	if ($prog_version_href) {
		$prog_params->{_prog_version} = $prog_version_href->{_prog_version};
			# print("1. prog_params,set_prog_version,prog_version,$prog_params->{_prog_version}\n");
	}
 	return ();
}





1;
