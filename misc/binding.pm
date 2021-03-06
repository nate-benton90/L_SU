 package binding;

 use Moose;
 use Tk;
 use SeismicUnixPlTk_global_constants;
 my $get  = new SeismicUnixPlTk_global_constants();
 my $var  = $get->var();

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PERL PROGRAM NAME: binding.pm 
 AUTHOR: Juan Lorenzo
 DATE: May 21 2018 

 DESCRIPTION: 
 
Create bindings
between values and buttons an actions
Make a binding based on the paramters
 inside the spec file for that progam
 (prog_name = $package)
 e.g. a package can be data_in_spec.pm
 $length is the number of bound Entry/Values widgets
 Each value or Entry widget is bound by MB3 to a
 FileDialog_button such as 'Data' = opening a data file
 The type of file to open or save (e.g. *su or text or bin etc.
 ) also exists in the _spec file
 and can be used later (TODO)
 
 calls FileButton within this package
 otherwise well-encapsulated
     
 USED FOR: 

 BASED ON:

 NEEDS:

 for binding, we need to know 
 the program name
    the program.spec requirements
 connect bindings of a specific file to the 
 parameter wiudget value/Entry
 Not all programs have these bindings
 the bindig type may be for opening a data file
 or for saving a file
 or for plotting a file
 the binding has a data type:
 	package binding_superflows
 	package bindings_flows
 	set_program_name
 	set the widget handles locally
 	set values
 	set_labels
 	
 a_ref = get_binding_types  <ButtonRelease-3>
 a_ref = get_data_types      su / text
 a_ref = get_command names    open/save/view/plot etc.
 a_ref = get_command_settings 1,2,3,4  etc. or empty



#sub bind_flow_item {
#	my $self = @_;
#	  
#  # temporary TODO 
#  # eventually move into the main Tk 
#  # Bind first entry: empty text for only the case of datain (label) to MB-3
#  
#  	my @values_w	= @{$param_widgets->{_values_w_aref}};
#  
#  	$values_w[0]->bind('<ButtonRelease-3>' => [\&_callback],);
#	
#	return();	
#}


=head2 private hash

=cut

	my $binding= {	
		_prog_name_sref				=> '',
		_sub_ref					=> '',
		_values_w_aref				=> '',
	};
	
=head2 sub set_prog_name_sref

	in order to know what
	_spec file to read for
	behaviors
	
=cut

 sub set_prog_name_sref {
 	my ($self,$name_sref) = @_;
 	
 	if ( $name_sref) {		
 		$binding->{_prog_name_sref} = $name_sref;
 			# print("binding, set_prog_name_sref , $binding->{_prog_name_sref}\n");
 			
 	} else {		
 		print("binding, set_prog_name_sref , missing name\n");
 	}
 	return();
 }
 
=head2 sub setFileDialog_button_sub_ref 

set reference to a subroutine in upper levels 
i.e., L_SU, _FileDialog_button, 
that connects to the Filebutton for opening directories

=cut

 sub setFileDialog_button_sub_ref {
 	my ($self,$sub_ref) = @_;
 	
 	if ($sub_ref) {
 				# print("binding  set_sub_ref, $sub_ref\n");
 		$binding->{_sub_ref} = $sub_ref;
 		
 	} else{
		print("binding, set_FileDialog_button_sub_ref, missing sub ref\n");
 	}
 	
 	return();
 }
 
 
=head2  sub set_values_w_aref

=cut
 
  sub set_values_w_aref{
 	my ($self,$values_w_aref) = @_;
 	
 	if ( $values_w_aref) {		
 		$binding->{_values_w_aref} = $values_w_aref;
 		#print("binding, set_values_w_aref, $binding->{_values_w_aref}\n");
 			
 	} else {		
 		print("binding, set_values_w_aref, missing values\n");
 	}
 	return();
 }
 
  
=head2  sub set 

	bring in a different module for each binding
	each module has its own rules through *_spec.pm

=cut
 
 sub set {
 	my ($self) = @_;
 	use SeismicUnixPlTk_global_constants;
 	
 	my $prog_name 				= ${$binding->{_prog_name_sref}};
 			# print("binding,prog_name: $prog_name \n");
	my $module					= $prog_name.'_spec';
 	my $module_pm      			= $module.'.pm';
 	
 	require $module_pm;		
 	my $package				= $module->new;
 	my $get					= SeismicUnixPlTk_global_constants->new;
 	
 	my $file_dialog_type	= $get->file_dialog_type_href();
 	my $flow_type			= $get->flow_type_href();
 		
 	$package				->binding_index_aref();
 	$package				->flow_type_aref();
 	$package				->file_dialog_type_aref();
 	
#  # Bind each entry: empty text for only the case of data_in (label) to MB-3
	my $values_w_aref		= $binding->{_values_w_aref};
	my @values_w			= @$values_w_aref;
	
	my $sub_ref				= $binding->{_sub_ref};
	
	my $binding_index_aref 	= $package->get_binding_index_aref();
	my @index               = @$binding_index_aref;
	
   	my $file_dialog_type_aref  	= $package->get_file_dialog_type_aref();
   	my @file_dialog_type		= @$file_dialog_type_aref;
   	
   					# from *_spec.pm file, e.g. pre_built_superflow, a user_built_flow
	my $flow_type_aref			= $package->get_flow_type_aref(); 

    my $length					= $package->get_binding_length();
 		  		# print("binding,set, no. bound items=length:$length\n");
 		  		
  	for (my $i=0; $i<$length ; $i++) {
  		my $dial_type	= $file_dialog_type[$i];
  				# print("binding,set,file_dialog_type: $dial_type\n");
  				# print("binding,set,prog_name: ${$binding->{_prog_name_sref}}\n");
  				
  				# actual binding takes place here... 
  				# TODO dynamic binding as a function of input from user in flow
  			if ($dial_type ne '' or $dial_type) {
  					# print("binding,set,file_dialog_type: $dial_type\n");
  				$values_w[ $index[$i] ]->bind('<ButtonRelease-3>' => [$sub_ref,\$dial_type],);
  				# sub_ref can be: "L_SU, _FileDialog_button"for suprflows
  				# sub_ref can be: "grey_flow, _FileDialog_button"for  user-built flow that is grey
  				
  			} else {
  				# print("binding,set, no bindings\n");
  			}
  	}
 }
1;
