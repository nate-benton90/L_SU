package L_SU;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PERL PACKAGE NAME: L_SU.pm
 AUTHOR: 	Juan Lorenzo
 DATE: 		May 14 2018 

 DESCRIPTION 
     
 BASED ON:
 previous versions of the main L_SU.pl
  
=cut

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES
 V 0.1.0 refactoring of 2017 version of L_SU.pl
 
 V 0.1.1 May 16 2018
  moving FileDialog_button, FileDialog, FileDialog_close
  to file_dialog.pm
  
  making save_button redundant
  refactor superflow selection
  
  V0.1.2 refactoring superflows and user-built flows
 
=cut 

 	use Moose;
 	our $VERSION = '0.1.2';
 	
 	# potentially, in all packages
	use SeismicUnixPlTk_global_constants;				
	use param_widgets_grey;		
	# used extensively for whole-gui awareness
	use whereami;
	use flow_widgets;
	use conditions_gui;
	use file_dialog;

	use save_button;
	use run_button;
	use pre_built_superflow;
	use neutral_flow;
	use grey_flow;
	use blue_flow;
	use pink_flow;
	#use green_flow;
	
 	my $conditions_gui		= conditions_gui 		->new();
 	my $file_dialog 		= file_dialog 			->new();
 	my $flow_widgets		= flow_widgets			->new();
 	my $get					= SeismicUnixPlTk_global_constants->new();
 	my $param_widgets		= param_widgets_grey			->new();
 	my $whereami           	= whereami				->new();
 	my $pre_built_superflow = pre_built_superflow->new();
 	
 	my $file_dialog_type	= $get->file_dialog_type_href();
 	my $flow_type			= $get->flow_type_href();
 	my $save_button			= save_button 			->new();
 	my $run_button			= run_button 			->new();
 	my $grey_flow			= grey_flow				-> new();
 	my $pink_flow			= pink_flow				-> new();
 	my $green_flow			= grey_flow			-> new();
 	my $blue_flow			= blue_flow				-> new();
 	my $neutral_flow		= neutral_flow		    -> new();
 	
 	
=head2

 share the following parameters in same name 
 space

 flow_listbox_grey_w  -left listbox, input by user selection
 flow_listbox_green_w  -right listbox,input by user selection
 sunix_listbox   -choice of listed sunix modules in a listbox
 
36 off

=cut
 	my ($mw);
 	my ($parameter_values_button_frame );
 	my ($parameter_names_frame,$parameter_values_frame);
 	my ($flow_listbox_grey_w,$flow_listbox_pink_w,$flow_listbox_green_w,$flow_listbox_blue_w);
 	my ($flow_name_grey_w,$flow_name_pink_w,$flow_name_green_w,$flow_name_blue_w);
 	my ($flowNsuperflow_name_w);
 	
 	my  $is_pre_built_superflow;
  	my 	$is_user_built_flow;
 	my ($dnd_token_grey,$dropsite_token_grey);
 	my ($dnd_token_pink,$dropsite_token_pink);
 	my ($dnd_token_green,$dropsite_token_green);
 	my ($dnd_token_blue,$dropsite_token_blue);
 	my ($run_button_w,$save_button_w,$message_w);
 	my ($sunix_listbox); 
	my ($add2flow_button_grey,$add2flow_button_pink,$add2flow_button_green,$add2flow_button_blue);
	my ($check_code_button);
	my ($delete_from_flow_button);		
 	my ($file_menubutton);
 	my ($flow_item_down_arrow_button, $flow_item_up_arrow_button);
 	my $Data_menubutton;
	my $Flow_menubutton;
	my $SaveAs_menubutton;

	my $var								= $get->var();
	my $on         						= $var->{_on};
	my $true       						= $var->{_true};
	my $false      						= $var->{_false};
    my $superflow_names     			= $get->superflow_names_h();
    my $alias_superflow_names_h     	= $get->alias_superflow_names_h();
    
    my @empty_array = (0); # length=1
    
 
=head2 Default L_SU settings{
	
	114
	    	
=cut	

 my $L_SU   = { 

	_Data_menubutton				=> '',
	_Flow_menubutton				=> '',
	_FileDialog_option				=> '',
 	_FileDialog_sub_ref				=> '',
	_SaveAs_menubutton				=> '', 		
 	_add2flow_button_grey			=> '',
	_add2flow_button_pink			=> '',
 	_add2flow_button_green			=> '',
  	_add2flow_button_blue			=> '',
 	_check_code_button				=> '',
	_check_buttons_settings_aref    => '', 	
	_check_buttons_w_aref    		=> '',	 		
 	_delete_from_flow_button		=> '',
  	_destination_index	 			=> '',
 	_dialog_type					=> '',
 	_dnd_token_grey					=> '',
 	_dnd_token_pink					=> '', 
 	_dnd_token_green				=> '', 
 	_dnd_token_blue					=> '', 
 	_dropsite_token_grey			=> '',
  	_dropsite_token_pink			=> '', 
   	_dropsite_token_green			=> '', 
    _dropsite_token_blue			=> '', 
 	_file_menubutton				=> '', 
 	_flow_color						=> '',
 	_flow_item_down_arrow_button  	=> '',
 	_flow_item_up_arrow_button		=> '',	
 	_flow_listbox_grey_w			=> '',
 	_flow_listbox_pink_w			=> '', 
 	_flow_listbox_green_w			=> '',  	 	
  	_flow_listbox_blue_w			=> '',
    _flow_listbox_color_w			=> '', 
  	_flow_name_grey_w				=> '',
 	_flow_name_pink_w				=> '', 
  	_flow_name_green_w				=> '',
 	_flow_name_blue_w				=> '',
	_flow_name_in					=> '', 	
	_flow_name_out					=> '',  # will be replaced in L_SU.pm by _prog_name_sref for regular and superflows
	_flow_type						=> $flow_type->{_user_built},
	_flow_widget_index				=> '',
	_flowNsuperflow_name_w			=> '',
	_good_labels_aref2				=> '',
	_good_values_aref2 				=> '',
    _has_used_check_code_button		=> '',
    _has_used_open_perl_file_button => $false,
    _has_used_Save_button			=> $false,
    _has_used_Save_superflow		=> $false,
    _has_used_SaveAs_button			=> $false,
    _has_used_run_button			=> $false,
    _index2move	    				=> $false,
    _is_SaveAs_file_button			=> '',
   	_is_add2flow		   			=> '',
   	_is_add2flow_button	   			=> '',
	_is_check_code_button          	=> '',
	_is_delete_from_flow_button	   	=> '',
	_is_flow_item_down_arrow_button	=> '',
	_is_flow_item_up_arrow_button	=> '',	
	_is_flow_listbox_grey_w			=> 0,
	_is_flow_listbox_pink_w			=> 0,	
	_is_flow_listbox_green_w		=> 0,
	_is_flow_listbox_blue_w			=> 0,
	_is_flow_listbox_color_w		=> '',
	_is_last_flow_index_touched_grey 		=>  $false,
	_is_last_flow_index_touched_pink 		=>  $false,
	_is_last_flow_index_touched_green 		=>  $false,
	_is_last_flow_index_touched_blue 		=>  $false,
	_is_last_flow_index_touched 			=>  $false,
	_is_last_parameter_index_touched_grey 	=> $false,
	_is_last_parameter_index_touched_pink 	=> $false,
	_is_last_parameter_index_touched_green 	=> $false,
	_is_last_parameter_index_touched_blue 	=> $false,
	_is_last_parameter_index_touched 		=> $false,	
    _is_moveNdrop_in_flow				=> '',
    _is_pre_built_superflow				=> '',
   	_is_run_button          			=> '',
   	_is_sunix_listbox					=> $false,
	_is_superflow_select_button			=> 0,
	_is_superflow 						=> '',  # should it be _pre_built_superflow?
	_is_user_built_flow					=> '',
  	_items_checkbuttons_aref2 			=> '',
  	_items_names_aref2  				=> '',
    _items_values_aref2  				=> '',
	_items_versions_aref 				=> '',
	_labels_w_aref						=> '',
	_last_flow_index_touched	 		=> -1,
  	_last_flow_index_touched_grey   	=> -1,
   	_last_flow_index_touched_pink   	=> -1,
    _last_flow_index_touched_green   	=> -1,
    _last_flow_index_touched_blue   	=> -1,
	_last_flow_listbox_touched 			=> '',
	_last_flow_listbox_touched_w 		=> '',
	_last_path_touched					=> './',
 	_last_parameter_index_touched   	=> -1,
 	_last_parameter_index_touched_grey	=> -1,
  	_last_parameter_index_touched_pink	=> -1,
   	_last_parameter_index_touched_green	=> -1,
    _last_parameter_index_touched_blue	=> -1,
  	_message_w							=> '',  
   	_mw									=> '',
	_names_aref    						=> \@empty_array,
 	_param_flow_length        			=> '', 
 	_parameter_names_frame  			=> '',
 	_param_sunix_first_idx      		=> 0,
 	_param_sunix_length  				=> '', 
 	_parameter_values_frame 			=> '', 
 	_parameter_values_button_frame		=> '',
 	_parameter_value_index  			=> -1,
	_prog_name_sref						=> '',  # has pre-existing _spec.pm and *.pm
 	_prog_names_aref 					=> '', 	
 	_run_button							=> '',  	 	
 	_save_button						=> '', 
 	_sunix_listbox						=> '',  # pre-built-superflow or flow name as well
	_values_aref  						=> \@empty_array,
	_values_w_aref						=> '',	
	
    };


=head2

	superflow bindings use this private ('_') subroutine exclusively, 
	Also superflows that are opening Data files from GUI are directed here 
	
	FileDialog_button is mainly used for user-built flows and directs superflow
	here
	
	For saftey place set_hash_ref first
	$$dialog_type_sref can be Data Save or SaveAs
	
	print("2 L_SU,_FileDialog_button,delete_from_flow_button:$L_SU->{_delete_from_flow_button}\n");
	print("2 L_SU,_FileDialog_button,derefed _prog_name_sref: ${$L_SU->{_prog_name_sref}}\n");
	print("2 L_SU,_FileDialog_button,derefed option_ref: ${$option_sref}\n");
	print("2 L_SU,_FileDialog_button,option_ref: $option_sref\n"); 

=cut 

sub _FileDialog_button {
	my ($self,$dialog_type_sref) = @_;
		 # print("1 L_SU,_FileDialog_button (general superflows + their bindings), deref option_sref: $$dialog_type_sref\n");
		 # print("2 L_SU,_FileDialog_button,flow_type:$L_SU->{_flow_type}\n");
		 #print("2 L_SU,_FileDialog_button,parameter_values_frame: $L_SU->{_parameter_values_frame}\n");
		 # print("2 L_SU,_FileDialog_button,parameter_values_frame: $L_SU->{_parameter_values_frame}\n");  
			 
	if ($dialog_type_sref)  {
		$L_SU					->{_dialog_type}  = $$dialog_type_sref;
		$file_dialog 			->set_hash_ref($L_SU);  					# uses 7/ 111 in
		$file_dialog			->set_gui_widgets($L_SU);					# uses 18/ 111 in
		$file_dialog 			->FileDialog_director();
		$L_SU					= $file_dialog->get_hash_ref();				# returns 89
		# print("1. L_SU, _FileDialog_button, _values_aref:@{$L_SU->{_values_aref}}[0]\n");
		
	} else {		
		print("L_SU, for superflows only, _FileDialog_button (binding),option type missing ")
	}	
	return();
}


=head2 sub _get_flow_color


=cut 

 sub _get_flow_color {
	my ($self)   = @_;
	my $color;
	if ($L_SU->{_flow_color})	 {
		
		$color 		= $L_SU->{_flow_color};
		return($color);		
	} else {
		# print("L_SU, _get_flow_color, missing color\n");
		return ();
	}
 }



#=head2   _pre_built_superflow 
#  	
#  		for saftey, place set_hash_ref first
#=cut
#
# sub _pre_built_superflow {
# 	my $self = @_;
# 	
# 	use conditions_gui;
# 	my $conditions 				= conditions_gui->new();
#
# 	$conditions_gui				->set_hash_ref($L_SU);       # uses 49 / 111 in
#	$conditions_gui				->set_gui_widgets($L_SU);	 # uses 25 / 111 in
#	$conditions_gui   			->set4superflow_select();    # sets 3
#	
#	$L_SU						= $conditions_gui	->get_hash_ref();    # returns 98
# 	$L_SU->{_flow_type}   		= $flow_type		->{_pre_built_superflow};
#	# print("L_SU, _pre_built_superflow,flow_type $L_SU->{_flow_type}\n");
#	
# 	return();
#	
# }

=head2 sub _set_flow_color

set the folor even if it is blank (=no color))

=cut 

 sub _set_flow_color {
	my ($color)   = @_;
	
	if ($color or $color eq '') {
			$L_SU->{_flow_color}  			 = $color;
		# print("L_SU,_set_flow_color, color:$color \n");
		
	} else {
		print("L_SU,_set_flow_color, missing color \n");
	}	
	return();
 }


=head2 sub _set_flow_listbox_color_w


=cut 

 sub _set_flow_listbox_color_w {
	my ($color)   = @_;
	
	if ($color eq 'grey') {
		
		$L_SU -> {_is_flow_listbox_grey_w}	= $true;
		# print("L_SU,_set_flow_listbox, color:$color \n");
		
	} elsif  ($color eq 'pink'){
		
		$L_SU -> {_is_flow_listbox_pink_w}	= $true;
		# print("L_SU,_set_flow_listbox, color:$color\n");
		
	} elsif  ($color eq 'green') {
		
		# print("L_SU,_set_flow_listbox, color:$color\n");
		$L_SU -> {_is_flow_listbox_green_w}	= $true;
			
	} elsif  ($color eq 'blue') {
		
		# print("L_SU,_set_flow_listbox, color:$color\n");
		$L_SU -> {_is_flow_listbox_blue_w}	= $true;
		
	} else {
		# print("L_SU,_set_flow_listbox, missing color \n");
	}
		return();
 }


=head2 sub _unset_pre_built_userflow_type 

=cut

 sub _unset_pre_built_superflow_type {
 	
 	my ($self) = @_;
 	 
	$L_SU->{_is_pre_built_superflow}	 	= $false;
	
	return();
}

=head2 sub _set_user_built_flow_type 

=cut

 sub _set_user_built_flow_type {
 	
 	my ($self) = @_;
 	
	$L_SU->{_flow_type}   					= $flow_type->{_user_built}; 
	$L_SU->{_is_user_built_flow} 			= $true;
	#$L_SU->{_is_pre_built_superflow}	 	= $false;
	
	return();
}


=head2 sub _stack_superflow

  store an initial version of the parameters in another namespace for
  manipulation by the user
  the initial version comes from default parameter files
  Using the same code as for sunix_select
						 print("L_SU,_stack_superflow,last left listbox flow program touched had index = $L_SU->{_last_flow_index_touched}\n");

=cut


#sub _stack_superflow {#
		# store flow parameters in another namespace
#  $param_flow		->stack_superflow_item($L_SU->{_prog_name_sref});
#  $param_flow		->stack_values_aref2($L_SU->{_values_aref});
#  $param_flow		->stack_names_aref2($L_SU->{_names_aref});
#  $param_flow		->stack_checkbuttons_aref2($L_SU->{_check_buttons_settings_aref});
#
#  return();
#}




=head2 sub FileDialog_button

	Interactively choose a file name
    that will then be entered into the
    values of the parameter frame and 
	stored away via param_flow
	
	for colored flows: grey, pink, blue, green

	independently set conditions for the use of a FileDialog_button
    find out which prior widget invoked the FileDialog_button
    For example, was it a user_built flow or a superflow?

	print("L_SU,FileDialog_button	parameter_values_frame: $L_SU->{_parameter_values_frame}\n");
 	print("L_SU,FileDialog_button	parameter_values_frame: $parameter_values_frame\n");
 	
 	dialog_type is one of 3 topics:  'Data', (open a) 
 	Flow ( a user-built perl flow or 'SaveAs'( a user-built perl flow)
 	
 	the Save (main) option goes straight to the L_SU,save_button for both 'user_built' and 'pre_built_superflow'

 	flow_type can be 'user_built' or 'pre_built_superflow'
	for saftey place set_hash_ref first
	
	each colored flow will be directed to a different program

	 	foreach my $key (sort keys %$L_SU) {
      	print (" L_SU,FileDialog_button, key is $key, value is $L_SU->{$key}\n");
 	}
 	
 	The number of values and names = what is read from the configuration file
 	After FileDialog is run, the number of values and names = max default value, because param_widgets are chosen inside file_dialog
 	This is justified because I chose to determine independently # variables
 	from the param_widget which is defaulted to 61 (know in advance how many value are occupied without reading t)SeismicUnixPltTk_glocal_cosntants.pm

=cut

 sub FileDialog_button { # N.B., other FileDialog_button in "L_SU"color_flow.pm"" needs concurrent updating too!!!!!!!
	
	my ($self,$dialog_type_sref) = @_;
				# print("1 L_SU,FileDialog_button, _is_pre_built_superflow:$L_SU->{_is_pre_built_superflow}\n");
				# print("1 L_SU,FileDialog_button,dialog_type: $$dialog_type_sref\n");
				# print("1 L_SU,FileDialog_button,flow_type=$L_SU->{_flow_type}\n");
	
	my $color;
			
	if ($dialog_type_sref)  {

				# print("2 L_SU,FileDialog_button, _is_pre_built_superflow:$L_SU->{_is_pre_built_superflow}\n");
				# print("2 L_SU,FileDialog_button, _is_user_built_flow:$L_SU->{_is_user_built_flow}\n");
				# print("2 L_SU,FileDialog_button, _flow_type: $L_SU->{_flow_type}\n");
				# print("2 L_SU,FileDialog_button,dialog_type: $$dialog_type_sref\n");
				# print("2 L_SU,FileDialog_button,color: $color\n");
		
		# CASE 1 in prep for CASE 3
		# when coming from working with a pre-built superflow
		# but wanting to  open a user-built flow
		# 
		if ( $$dialog_type_sref eq 'Flow' && 
			 $L_SU->{_flow_type} eq 'pre_built_superflow') {   
					
		    # default is 'grey' for now 
		    # TODO to automatically select the unoccupied window
			my $which_color = 'grey'; 
			_set_flow_color($which_color);
			_set_flow_listbox_color_w($which_color);
			_unset_pre_built_superflow_type();
			_set_user_built_flow_type();			
		
		# CASE 2 in prep for CASE 3
		# when coming from only sunix-selected before FLow
		} elsif ( $$dialog_type_sref eq 'Flow') {
				 			 	       
			# default is 'grey' for now 
		    # TODO to automatically select the unoccupied window
			my $which_color = 'grey'; 
			_set_flow_color($which_color);
			_set_flow_listbox_color_w($which_color);
			_unset_pre_built_superflow_type();
			_set_user_built_flow_type();	
		
		# CASE 3	
		# } elsif ( $$dialog_type_sref eq 'Data' && 
			 # $L_SU->{_flow_type} eq 'pre_built_superflow') {
			#  print("4 L_SU, FileDialog_button, dialog type =  $$dialog_type_sref and flow_type = $L_SU->{_flow_type}  \n");
			 	
		} else {
			# print("5 L_SU, FileDialog_button, unknown dialog type (e.g., Data, Save (a Flow),  SaveAs) \n");					 
			# print("5 L_SU,FileDialog_button, _is_pre_built_superflow:$L_SU->{_is_pre_built_superflow}\n");
			# print("5 L_SU,FileDialog_button, _is_user_flow:$L_SU->{_is_user_built_flow}\n");
			# print("5 L_SU,FileDialog_button,dialog_type: $$dialog_type_sref\n");
			# print("5 L_SU,FileDialog_button,flow_type:$L_SU->{_flow_type} \n");						
		}
		
		
				
		if ( not $color) {
			
			$color = _get_flow_color();
			
		} else {			
			# print("L_SU, FileDialog_button, color exists: $color \n");
		}
		# CASE 4	user-buiilt flows in color	
 		# can = 'neutral', when flow listbox is not a color if onlu sunix_select has been chosen
 		# but add2flow_button has not been activated
 		# can = nothing if chosen before a colored flow exist
 		# when coming from a user-built flow								   
		if ( $color && ( $L_SU -> {_is_flow_listbox_grey_w}  	||
 						$L_SU -> {_is_flow_listbox_pink_w}  	||
 						$L_SU -> {_is_flow_listbox_green_w} 	||
 						$L_SU -> {_is_flow_listbox_blue_w}   	||
 					    ( $L_SU -> {_flow_type} eq 'user_built' && $color) 
 					   ) 
 			) {												   								   							  	
 			if ( $L_SU->{_is_flow_listbox_grey_w} ||  $color eq 'grey' ) {
 						 		
 		 		# mark the neutral-colored flow as unused		
 		 		# helps bind flow parameters to the opening files
 		 			# print("60 L_SU, FileDialog_button, color is $color\n");
				$grey_flow 				-> set_hash_ref($L_SU);  # uses 31/ 111 in	
					# print("61 L_SU,FileDialog_button,_flowNsuperflow_name_w:$L_SU->{_flowNsuperflow_name_w} \n");
 				$grey_flow 				-> FileDialog_button($dialog_type_sref);
 				$L_SU->{_flow_color} 	= $grey_flow->get_flow_color();
 					# print("62 L_SU,FileDialog_button,flow_type:$L_SU->{_flow_type} \n");
#				$L_SU->{_flow_type}		= $file_dialog->get_flow_type();
#				print("2 L_SU,FileDialog_button,_type:$L_SU->{_flow_type} \n");
 			
 			} elsif ($L_SU -> {_is_flow_listbox_pink_w} ||   $color eq 'pink') {	# needed?
 			
 				$pink_flow 				-> set_hash_ref($L_SU);	# uses 31/ 111 in
				$pink_flow 				-> FileDialog_button($dialog_type_sref);
				$L_SU->{_flow_color} 	= $pink_flow->get_flow_color();
 		
 			} elsif ($L_SU -> {_is_flow_listbox_green_w} || $color eq 'green') {	# needed?
  		
 				$green_flow 			-> set_hash_ref($L_SU);	# uses 31/ 111 in
 				$green_flow 			-> FileDialog_button($dialog_type_sref);
 				$L_SU->{_flow_color} 	= $green_flow->get_flow_color();;
 		
 			} elsif ($L_SU -> {_is_flow_listbox_blue_w}  || $color eq 'blue') { 	# needed?
 				$blue_flow 				-> set_hash_ref($L_SU);	# uses 31/ 111 in 
 				$blue_flow 				-> FileDialog_button($dialog_type_sref);
 				$L_SU->{_flow_color} 	= $blue_flow ->get_flow_color();

 			} else {
				print("L_SU, FileDialog_button, missing settings \n");
 			}
		
		# CASE 5
		# when GUI opens Data for a superflow			
 		} elsif ( $L_SU -> {_flow_type} eq 'pre_built_superflow' ) { 
						# print("L_SU, FileDialog_button, is a superflow\n");
						# print("L_SU, FileDialog_button, dialog type is $$dialog_type_sref \n");
						# my $think = scalar @{$L_SU->{_values_aref}};
						# print("L_SU, read from config file=length of values_aref is $think\n");
						# print("1. L_SU, FileDialog_button, _values_aref: @{$L_SU->{_values_aref}}[0]\n");
						
				$L_SU					->{_dialog_type}  = $$dialog_type_sref;
				$file_dialog 			->set_hash_ref($L_SU);  					# uses 7/ 111 in
				$file_dialog			->set_gui_widgets($L_SU);					# uses 18/111 in
				$file_dialog 			->FileDialog_director();
				$L_SU					= $file_dialog->get_hash_ref();
				
						# $think = scalar @{$L_SU->{_values_aref}};
						# print("L_SU, initialized # values = length of values_aref is $think\n");
						# print("2. L_SU, FileDialog_button, _values_aref: @{$L_SU->{_values_aref}}[0]\n");
						# print("7. L_SU, FileDialog_button, flow_type: $L_SU->{_flow_type}\n");
						
			
		# CASE 6
		# Flow when programs opens a (pre-existing) user-built perl flow 
		# and user flows are already in progress
		} elsif (not $color && ($L_SU->{_flow_type} eq 'user_built_flow') )  { # no color or colored listbox is active, 
			 
 				$L_SU -> {_is_flow_listbox_grey_w} = $true; # default to grey box
 				_set_flow_color('grey'); # assigns color to private hash L_SU
 				_set_user_built_flow_type();
  			    # print("1 L_SU, FileDialog_button, color,superflow, user_built =\n
 			    # $color, $L_SU->{_is_pre_built_superflow},$L_SU->{_is_user_built_flow}\n");
 			  	# print("1 L_SU,FileDialog_button,dialog_type: $$dialog_type_sref\n");
 			   
 				$grey_flow 				-> set_hash_ref($L_SU);	# uses 31/ 111 in 
 				$grey_flow 				-> FileDialog_button($dialog_type_sref);
 				$L_SU->{_flow_color} 	= $grey_flow ->get_flow_color();
 				
 		} else { 
 			print("6L_SU, FileDialog_button, not a color: $color \n");
 			print("6L_SU, FileDialog_button, missing color, and flow types \n");	
 		}  # end user-built (2 types) or superflow (or user) 1 type)
	} else {
		print("8L_SU, FileDialog_button, missing dialog type (Data, Save, Flow , SaveAs)\n");
	}# end dialog_type_sref
		
	return();
 }




=head2 sub help

 Callback sequence following MB3 click 
 activation of a sunix (Listbox) item
 program name is a scalar reference
 
 Let help decide whether it is a superflow
 or a user-created flow
 
 Show a window with the perldoc to the user
 

=cut 

sub help {
	my ($self) = @_;
   	use help;  	
   	use decisions;
   	
   	my $help 		= new help();
   	my $decisions	= decisions->new();
   	my $pre_req_ok;
   			   	 # print("L_SU, help\n");
   	
   	$L_SU->{_is_pre_built_superflow} = $true; #helps decisions
   	
   	$decisions		->set4help($L_SU);
	$pre_req_ok 	= $decisions->get4help();
	
	if ($pre_req_ok) {		
		my $prog_name 	= ${$L_SU->{_prog_name_sref}};	
		my $alias 		= $alias_superflow_names_h->{$prog_name};
			# print("L_SU,help,alias: $alias\n");
		$help			->set_name(\$alias);
		$help			->tkpod();
		
	} else {
		
		# print("L_SU, can not provide help\n");
	}

   	return();
}	


=head2 sub pre_built_superflows
 
 
    scalar reference:
      print("LSU_Tk,superflow_select,prog_name: ${$L_SU->{_prog_name_sref}}\n");
    array reference:
      print("LSU_Tk,superflow_select: _names_aref @{$L_SU->{_names_aref}}\n");
      
      sets flow type = pre-built superflow
      
       		 		# print complete hash
 		while (my ( $key,$value ) = each %{$L_SU} ){
 			print ("$key \t\t=> $value\n");
 		}

 		 
 		 binding needs:
 		  	$pre_built_superflow	->select(); 
			$pre_built_superflow	->set_sub_ref
			
		$pre_built_superflow	->set_flowNsuperflow_name_w  displays superflow name at top of gui 
			
	);
	
	  print("11. L_SU,pre_built_superflows,: $$superflow_name_sref \n");	
  	 print("11. L_SU,pre_built_superflows,flowNsuperflow_name_w: $flowNsuperflow_name_w\n");
  	
  	 				foreach my $key (sort keys %$L_SU) {
 					print (" file_dialog,key is $key, value is $L_SU->{$key}\n");
    			

=cut

 sub pre_built_superflows {
 	my ($self,$superflow_name_sref) = @_;
 	
  		# print("2. L_SU,select,should be NO values=@{$L_SU->{_values_aref}}\n");
  		
 	if ($superflow_name_sref) {
		use conditions_gui;
 		my $conditions 				= conditions_gui->new();
 		
 			# print("1. L_SU  pre_built_superflows: _is_last_flow_index_touched $L_SU->{_is_last_flow_index_touched}\n");
 			# print("1 L_SU,pre_built_superflows=$L_SU->{_flow_type}\n"); # may start as user-build

 		$L_SU->{_prog_name_sref}  = $superflow_name_sref;
 		
 		$conditions_gui				->set_hash_ref($L_SU);       				# uses 49 / 111 in
		$conditions_gui				->set_gui_widgets($L_SU);	 				# uses 25 / 111 in
		$conditions_gui   			->set4superflow_open_data_file_start();    	# sets 3	
		$L_SU						= $conditions_gui	->get_hash_ref();    	# returns 98
			
				# print("2 L_SU,pre_built_superflows=$L_SU->{_flow_type}\n"); #converst to super_flow flow_type			
  	 			# print("1. L_SU,pre_built_superflows, flow type: $L_SU->{_flow_type}\n");
  		  	 	# print("2 L_SU,pre_built_superflows, parameter_values_frame: $L_SU->{_parameter_values_frame}\n"); 	 			
	 	
 		$pre_built_superflow	->set_hash_ref($L_SU);     # 86 used but 111 in
 		$pre_built_superflow	->set_gui_widgets($L_SU);  # 25 used but 111 in
 		
		# displays superflow name at top of gui
 		$pre_built_superflow	->set_flowNsuperflow_name_w($flowNsuperflow_name_w);	
  		  	 	# print("3 L_SU,pre_built_superflows, parameter_values_frame: $L_SU->{_parameter_values_frame}\n");
  		  	 	# print("3 L_SU,pre_built_superflows, parameter_values_frame: $parameter_values_frame\n");
  	 			# print("2. L_SU,pre_built_superflows, flow type: $L_SU->{_flow_type}\n");
 		
 		# for binding to file dialog options
 		my $sub_ref 			=\&_FileDialog_button;  
 		$pre_built_superflow	->set_sub_ref($sub_ref);
 		
 		  	 	# print("4. L_SU,pre_built_superflows, flow type: $L_SU->{_flow_type}\n");
 		        # print("4 L_SU,pre_built_superflows, parameter_values_frame: $L_SU->{_parameter_values_frame}\n");
 		        # print("4 L_SU,pre_built_superflows, parameter_values_frame: $parameter_values_frame\n");
 		        		        
 		# Display of all the parameters and names occurs via select method
 		$pre_built_superflow	->select();
 				# print("41 L_SU,pre_built_superflows, parameter_values_frame: $L_SU->{_parameter_values_frame}\n");
 				# print("41 L_SU,pre_built_superflows, parameter_values_frame: $parameter_values_frame\n"); 
 														
 		# return changes to $L_SU without altering other original values
 		$L_SU 					= $pre_built_superflow->get_hash_ref(); # 96 returned
 				# print("5 L_SU,pre_built__superflows,_is_pre_built_superflow : $L_SU->{_is_pre_built_superflow}\n");
 				# print("5 L_SU,pre_built__superflows, flow type: $L_SU->{_flow_type}\n");
				# print("52 L_SU,pre_built_superflows, names_aref: @{$L_SU->{_names_aref}},\n");
				# print("52 L_SU,pre_built_superflows, values_aref: @{$L_SU->{_values_aref}},\n");
 				# print("5 L_SU,pre_built_superflows, parameter_values_frame: $L_SU->{_parameter_values_frame}\n");
  				# print("5 L_SU,pre_built_superflows, parameter_values_frame: $parameter_values_frame\n");				
 				# print("L_SU,pre_built_superflow,_is_flow_listbox_grey_w:	$L_SU->{_is_flow_listbox_grey_w} (should be blank or =0)\n");
 			    # print("5 L_SU,pre_built_superflows, check-buttons_settings: @{$L_SU->{_check_buttons_settings_aref}} \n");
 			    # print("5 L_SU,pre_built_superflows, param_flow_length: @{$L_SU->{_param_flow_length}} \n"); # does not exist within L_SU from pre-built flows
 	} else {
 				
 		print ("L_SU,pre_built_superflow, missing name \n");
 	} 	
 	return();
}



=head2 sub run_button

comes from MAIN and is used by superflow
     
    uses flow or pre_built superflow names  
	
	original L_SU plus changes is returned	

     
    for safety, place set_hash_ref first
    
 	foreach my $key (sort keys %$L_SU) {
      	print (" L_SU,run_button, key is $key, value is $L_SU->{$key}\n");
 	}
 				      	
     
=cut

 sub run_button {
 	my ($self,$value_ref) = @_;
 
  	# print("L_SU,run_button, value: ${$value_ref} \n");
  	
	if ($$value_ref eq 'Run') {  # i.e., 'Run'... double check
  	
  		if ($L_SU->{_flow_type}) {  # e.g. user-built or pre-built superflow
 			my $flow_type = $L_SU->{_flow_type};
 		
 			if ($flow_type eq 'user_built') {
 				
 				my $flow_color = $L_SU->{_flow_color};
 					# print("L_SU,run_button,flow_color: $L_SU->{_flow_color} \n");
 				my $color_flow  = $flow_color.'_flow';
 				
 				if ($flow_color) {   # e.g. grey, pink, green or blue flows
 					 				
 					my $temp_hash = $color_flow->get_hash_ref();					
 																		
 				    $L_SU->{_has_used_SaveAs_button} 			= $temp_hash->{_has_used_SaveAs_button};
 				    $L_SU->{ _has_used_open_perl_file_button} 	= $temp_hash->{_has_used_open_perl_file_button};
 				    $L_SU->{_has_used_Save_button} 			= $temp_hash->{_has_used_Save_button};
 				    $L_SU->{_flow_name_out}					= $temp_hash->{_flow_name_out};
 				    my $flow_name_out							= $L_SU->{_flow_name_out};
 				     
 				     
 				      	# print("L_SU,run_button, has_used_SaveAs_button: $L_SU->{_has_used_SaveAs_button} \n");
 				      	# print("L_SU,run_button, has_used_Save_button: $L_SU->{_has_used_Save_button} \n");
    					# print("L_SU,run_button, _has_used_Save_superflow: $L_SU->{_has_used_Save_superflow} \n");
    					# print("L_SU,run_button, _has_used_SaveAs_button: $L_SU->{_has_used_SaveAs_button} \n");
 				      	# print("L_SU,run_button, _flow_name_out:  $L_SU->{_flow_name_out} \n");
 				      	# print("L_SU,run_button,_is_flow_listbox_grey_w:	$L_SU->{_is_flow_listbox_grey_w} \n");
 				      	# print("L_SU,run_button,_is_flow_listbox_grey_w:	$L_SU->{_is_last_parameter_index_touched} \n");
 				      	# print("L_SU,run_button,_is_flow_listbox_grey_w:	$L_SU->{_is_flow_listbox_grey_w} \n");
					  	# print("1 L_SU,run_button,_is_last_parameter_index_touched:	$L_SU->{_is_last_parameter_index_touched} \n");
 				      
 				     if ($L_SU->{_has_used_SaveAs_button} || $L_SU->{_has_used_Save_button} 
 				      	|| $L_SU->{_flow_name_out} || $L_SU->{_has_used_open_perl_file_button}) {
 							# print("1 L_SU,run_button,_is_last_parameter_index_touched:	$L_SU->{_is_last_parameter_index_touched} \n");
 						$conditions_gui		->set_hash_ref($L_SU); 				# used  49 / 111 in 
						$conditions_gui		->set_gui_widgets($L_SU);			# used  25 / 111 in
						$conditions_gui		->set4start_of_run_button();	 	# sets  5
							# print("2 L_SU,run_button,_is_last_parameter_index_touched:	$L_SU->{_is_last_parameter_index_touched} \n");
 							#print("2 L_SU,run_button,_is_last_parameter_index_touched:	$L_SU->{_is_last_parameter_index_touched} \n");
 										      
 				      	$run_button 		->set_hash_ref($L_SU);       		 # used  36 / 111 in 
 							# print("3 L_SU,run_button,_is_last_parameter_index_touched:	$L_SU->{_is_last_parameter_index_touched} \n");
 						$run_button			->set_flow_type($L_SU->{_flow_type});
 							# print("4 L_SU,run_button,_is_last_parameter_index_touched:	$L_SU->{_is_last_parameter_index_touched} \n");
 						$run_button			->set_flow_name_out($flow_name_out);	
							# print("5 L_SU,run_button,_is_last_parameter_index_touched:	$L_SU->{_is_last_parameter_index_touched} \n");
						$run_button			->set_gui_widgets($L_SU);     		# used 23 / 111 in 
							# print("6 L_SU,run_button,_is_last_parameter_index_touched:	$L_SU->{_is_last_parameter_index_touched} \n");
						$run_button 		->director();
							# print("7 L_SU,run_button,_is_last_parameter_index_touched:	$L_SU->{_is_last_parameter_index_touched} \n");						
						$conditions_gui		->set4end_of_run_button();	 	     # sets 2

						
 				      	$L_SU				= $conditions_gui->get_hash_ref();	 # returns 98 
 				      	
 				      	} else {
 				      		print("L_SU,run_button, missing conditions\n");
 				      		use messages::message_director;
 							my $run_button_messages 	= message_director->new();
  							my $message          		= $run_button_messages->run_button(1);
  	
  							# a blank message
  							$message_w   				->delete("1.0",'end');
 							$message_w   				->insert('end', $message);
 		
 				      	}
					
 				} else {
 					print("L_SU, run_button, mising color\n");
 				}
 		
     		} elsif ($flow_type eq 'pre_built_superflow')  {
     	
   				# print("L_SU,run_button, (a pre_built_superflow, has_used_Save_superflow:	$L_SU->{_has_used_Save_superflow}: \n");    
				# print("L_SU,run_button, (a pre_built_superflow, has_used_SaveAs_button:	$L_SU->{_has_used_SaveAs_button}: \n");
	
			$run_button 		->set_hash_ref($L_SU);       		 # used  36 / 111 in 
 			$run_button			->set_flow_type($L_SU->{_flow_type});
			$run_button			->set_prog_name_sref($L_SU->{_prog_name_sref});	
			$run_button			->set_gui_widgets($L_SU);     		# used 23 / 111 in 
			$run_button 		->director();
	
			#$L_SU				= $run_button->get_all_hash_ref();  # returns 58
			

			#$conditions_gui		->set4end_of_run_button();
			#$L_SU 				= $conditions_gui->get_hash_ref();
					
			# print("L_SU,run_button, has_used_Save_superflow: $L_SU->{_has_used_Save_superflow} \n");
	
  			} else {		
 			print("L_SU,run_button , wrong flow type\n");
			}		
		} else {
 		print("L_SU,run_button , missing flow type user- or pre-built \n");
		}
	} else {
 		print("L_SU,run_button , missing flow type  Run \n");
	} 	 	 
 	return();	
 }

 
=head2 sub save_button

 called from MAIN

 foreach my $key (sort keys %$L_SU) {
      print (" L_SU,save_button, key is $key, value is $L_SU->{$key}\n");
 }	
          
         dialog_type for save_button is only 'Save'
         
   Because private hash does not have _dialog type
   it should be assigned to save_button after set_hash_ref tranfers LSU hash
   and not before
   i.e. for safety, transfer set_hash_ref first
         
   save can be for 2 situations: pre-built superflows and user-built flows
         
  collect changes to environmental indicator variables such as _has_used_SaveAs_button
         
    print("L_SU,save_button, flow_type : $L_SU->{_flow_type}\n");
    
    In:  save_button, uses topics
    	
    Topics originate as a dialog_type topic which can be  'Data', 'Flow' or 'SaveAs'
    
    Topic for save_button can also be 'Save'
    
    Flow types can be: user-built or pre-built superflow
    
    Logic for use: SaveAs_button must have been used previously or Save_button
    Once Save_button is used has_used_SaveAs_button = false
 	

=cut

 sub save_button {
 	my ($self,$topic_sref) = @_;	
 		# print("L_SU,save_button, topic: $$topic_sref\n");
 	use messages::message_director;
 	my $save_button_messages 	= message_director->new();
  	my $message          		= $save_button_messages->null_button(0);
  	
  	# a blank message
  	$message_w   				->delete("1.0",'end');
 	$message_w   				->insert('end', $message);
 		
 	if ($topic_sref) {  # i.e., topic is 'Save'
 		my $topic;
 		$topic= $$topic_sref;
 		
		if ($L_SU->{_flow_type}) {  # e.g. user-built or pre-built superflow
 			my $flow_type = $L_SU->{_flow_type};
 		
 			if ($flow_type eq 'user_built') {
 				
 				my $flow_color = $L_SU->{_flow_color};
 							# print("L_SU,save_button,flow_color: $L_SU->{_flow_color} \n");
 				my $flow_color_hname  = $flow_color.'_flow';
 				
 				if ($flow_color) {   # e.g. grey, pink, green or blue flows
 					 				
 					# collect information from the most recent updates to flow packages (e.g. grey_flow.pm)				
 					my $temp_hash = $flow_color_hname->get_hash_ref();					
 									
 				     $L_SU->{_has_used_SaveAs_button} 			= $temp_hash->{_has_used_SaveAs_button};
 				     $L_SU->{_has_used_Save_button} 			= $temp_hash->{_has_used_Save_button};
 				     $L_SU->{_flow_name_out} 					= $temp_hash->{_flow_name_out};   #TBD
 				     $L_SU->{_has_used_open_perl_file_button}   = $temp_hash->{_has_used_open_perl_file_button};
 				      # print("L_SU,save_button, has_used_SaveAs_button: $L_SU->{_has_used_SaveAs_button} \n");
 				      # print("L_SU,save_button, has_used_Save_button: $L_SU->{_has_used_Save_button} \n");
 				      # print("L_SU,save_button, _flow_name_out:  $L_SU->{_flow_name_out} \n");
 				      # print("L_SU,save_button, _has_used_open_perl_file_button:  $L_SU->{_has_used_open_perl_file_button} \n");
 				      				      
 					# check to see if the current user-built flow has used SaveAs or Save button
					if ($L_SU->{_has_used_SaveAs_button} || $L_SU->{_has_used_Save_button} 
						|| $L_SU->{_flow_name_out}  || $L_SU->{_has_used_open_perl_file_button} ) { 
					
					# store possible changes in parameter values
						# print("L_SU, save_button, saving flow \n");
						# print("L_SU, save_button,_last_parameter_index_touched, $L_SU->{_last_parameter_index_touched}\n");
						$flow_color_hname->save_button($topic);
					
							# reset states
							# N.B. Save_button can only be used if SaveAs is true
   							# But, after Save_button is used, reset _has_used_SaveAs_button to false
   							# and has_used_Save_button to true
					
						$conditions_gui	->set_hash_ref($L_SU);
						$conditions_gui	->set_gui_widgets($L_SU);
						$conditions_gui	->set4end_of_Save_button();
						$L_SU 			= $conditions_gui->get_hash_ref();
					
						# print("L_SU, save_button,user_built_flow, has_used_SaveAs_button $L_SU->{_has_used_SaveAs_button}\n");
 						# print("L_SU, save_button,user_built_flow, has_used_Save_superflow $L_SU->{_has_used_Save_superflow}\n");
 					    # print("L_SU, save_button,user_built_flow, has_used_Save_button $L_SU->{_has_used_Save_button}\n");	
							
					}	else {
					
  						my $message          	= $save_button_messages->save_button(1);
 						$message_w   			->insert('end', $message);			
							# print("L_SU,save_button, can not save user-built file\n");
					}	 				      
 
 				} else {
 					print("L_SU, save_button, missing color\n");
 				}
 			
 			} elsif ($flow_type eq 'pre_built_superflow')  {
 				
 				# collect latest values from a prior run of pre_built_superflow or FileDialog_button
						# print("2. L_SU, save_button, _values_aref[0]: @{$L_SU->{_values_aref}}[0]\n");

 				
 				$L_SU->{_dialog_type} 	= 'Save';
 
 						# print("2. L_SU, save_button, _names_aref: @{$L_SU->{_names_aref}}\n");  # equi to labels_aref
 				$save_button 			->set_hash_ref($L_SU);              				#  uses 41  / 111 in
 				$save_button 			->set_gui_widgets($L_SU);							#  uses 27 / 111 in
 				$save_button			->set_flow_type($L_SU->{_flow_type});        		# set 1      
				$save_button			->set_prog_name_sref($L_SU->{_prog_name_sref});    	# set 1

						# print("1. L_SU, save_button,last left listbox flow program touched had index = $L_SU->{_last_flow_index_touched}\n");
						# print("1. L_SU, save_button, flow_item_up_arrow_button= $L_SU->{_flow_item_up_arrow_button}\n");	
				$save_button 			->set_dialog_type($topic);  # set 1 of 3
						#	 print("1. L_SU, save_buttonlast left listbox flow program touched had index = $L_SU->{_last_flow_index_touched}\n");	

				$save_button 			->director();
#			
				$L_SU					= $save_button->get_all_hash_ref();  # returns 108
						# print("2. L_SU, save_button, flow_item_up_arrow_button= $L_SU->{_flow_item_up_arrow_button}\n");
						# print("L_SU, save_button,pre_built_flow,has_used_SaveAs_button $L_SU->{_has_used_SaveAs_button}\n");
 						# print("L_SU, save_button,pre_built_flow,has_used_Save_superflow $L_SU->{_has_used_Save_superflow}\n");
 					    # print("L_SU, save_button,pre_built_flow,has_used_Save_button $L_SU->{_has_used_Save_button}\n");
 					    # print("L_SU, save_button,pre_built_flow,is_Save_button $L_SU->{_is_Save_button}\n");	
 			
 			} else {		
 			print("L_SU,save_button , missing flow type\n");
			}
 		}
 		
 	} else {
 		print("L_SU,save_button , missing dialog_type, Save \n");
 	}
 	return();	
 }

 
=head2 sub set_hash_ref 

	imports external hash into private settings
	once at the start of the main loop
	Settings are lost thereafter and so it is good
	to store them with local names
	
	
	39 off 39 off
 
=cut

 	sub set_hash_ref {
 		my ($self,$hash_ref) 	= @_;
 
     	$Data_menubutton		= $hash_ref->{_Data_menubutton};		
      	$Flow_menubutton		= $hash_ref->{_Flow_menubutton};
     	$SaveAs_menubutton		= $hash_ref->{_SaveAs_menubutton};    	  			
 		$add2flow_button_grey	= $hash_ref->{_add2flow_button_grey};
 		$add2flow_button_pink	= $hash_ref->{_add2flow_button_pink};
 		$add2flow_button_green	= $hash_ref->{_add2flow_button_green};
 		$add2flow_button_blue	= $hash_ref->{_add2flow_button_blue};
 		$check_code_button		= $hash_ref->{_check_code_button}; 		 		
 		$delete_from_flow_button= $hash_ref->{_delete_from_flow_button};
 		$dnd_token_grey			= $hash_ref->{_dnd_token_grey};
  		$dnd_token_pink			= $hash_ref->{_dnd_token_pink};
  		$dnd_token_green		= $hash_ref->{_dnd_token_green};
   		$dnd_token_blue			= $hash_ref->{_dnd_token_blue};
 		$dropsite_token_grey	= $hash_ref->{_dropsite_token_grey};
  		$dropsite_token_pink	= $hash_ref->{_dropsite_token_pink};
   		$dropsite_token_green	= $hash_ref->{_dropsite_token_green};
    	$dropsite_token_blue	= $hash_ref->{_dropsite_token_blue};
 	 	$file_menubutton		= $hash_ref->{_file_menubutton};
 	  	$flow_item_down_arrow_button	= $hash_ref->{_flow_item_down_arrow_button};
 		$flow_item_up_arrow_button		= $hash_ref->{_flow_item_up_arrow_button};
 	 	$flow_listbox_grey_w	= $hash_ref->{_flow_listbox_grey_w};
 	 	$flow_listbox_pink_w	= $hash_ref->{_flow_listbox_pink_w};
 	 	$flow_listbox_green_w	= $hash_ref->{_flow_listbox_green_w};
  	 	$flow_listbox_blue_w	= $hash_ref->{_flow_listbox_blue_w};
  	 	$flow_name_grey_w		= $hash_ref->{_flow_name_grey_w};
  	 	$flow_name_pink_w		= $hash_ref->{_flow_name_pink_w};
  	 	$flow_name_green_w		= $hash_ref->{_flow_name_green_w};
  	 	$flow_name_blue_w		= $hash_ref->{_flow_name_blue_w};
  	 	$flowNsuperflow_name_w  = $hash_ref->{_flowNsuperflow_name_w};
  	 	$is_pre_built_superflow = $hash_ref->{_is_pre_built_superflow};
  	 	$is_user_built_flow 	= $hash_ref->{_is_user_built_flow};
  		$message_w				= $hash_ref->{_message_w}; 
   		$mw						= $hash_ref->{_mw};
 	 	$parameter_names_frame  = $hash_ref->{_parameter_names_frame}; 	
 	 	$parameter_values_frame = $hash_ref->{_parameter_values_frame};
 		$parameter_values_button_frame	 = $hash_ref->{_parameter_values_button_frame};	
 		$run_button_w			= $hash_ref->{_run_button}; 	 	
 		$save_button_w			= $hash_ref->{_save_button}; 
 		$sunix_listbox			= $hash_ref->{_sunix_listbox};
 
     	$L_SU->{_Data_menubutton}				= $hash_ref->{_Data_menubutton};		
      	$L_SU->{_Flow_menubutton}				= $hash_ref->{_Flow_menubutton};
     	$L_SU->{_SaveAs_menubutton}				= $hash_ref->{_SaveAs_menubutton};	 	 		
 		$L_SU->{_add2flow_button_grey}			= $hash_ref->{_add2flow_button_grey};
 		$L_SU->{_add2flow_button_pink}			= $hash_ref->{_add2flow_button_pink};
 		$L_SU->{_add2flow_button_green}			= $hash_ref->{_add2flow_button_green};
 		$L_SU->{_add2flow_button_blue}			= $hash_ref->{_add2flow_button_blue};
 		$L_SU->{_check_code_button}				= $hash_ref->{_check_code_button}; 		 		
 		$L_SU->{_delete_from_flow_button}		= $hash_ref->{_delete_from_flow_button};
 		$L_SU->{_dnd_token_grey}				= $hash_ref->{_dnd_token_grey};
  		$L_SU->{_dnd_token_pink}				= $hash_ref->{_dnd_token_pink};
   		$L_SU->{_dnd_token_green}				= $hash_ref->{_dnd_token_green};
 		$L_SU->{_dnd_token_blue}				= $hash_ref->{_dnd_token_blue};
 		$L_SU->{_dropsite_token_grey}			= $hash_ref->{_dropsite_token_grey};
  		$L_SU->{_dropsite_token_pink}			= $hash_ref->{_dropsite_token_pink};
  		$L_SU->{_dropsite_token_green}			= $hash_ref->{_dropsite_token_green};
 		$L_SU->{_dropsite_token_blue}			= $hash_ref->{_dropsite_token_blue};
 	 	$L_SU->{_file_menubutton}				= $hash_ref->{_file_menubutton};
 	 	$L_SU->{_flow_item_down_arrow_button}	= $hash_ref->{_flow_item_down_arrow_button};
 		$L_SU->{_flow_item_up_arrow_button}		= $hash_ref->{_flow_item_up_arrow_button};
 	 	$L_SU->{_flow_listbox_grey_w}			= $hash_ref->{_flow_listbox_grey_w};
 	 	$L_SU->{_flow_listbox_pink_w}			= $hash_ref->{_flow_listbox_pink_w};
 	 	$L_SU->{_flow_listbox_green_w}			= $hash_ref->{_flow_listbox_green_w}; 	 	
  	 	$L_SU->{_flow_listbox_blue_w}			= $hash_ref->{_flow_listbox_blue_w};
  	 	$L_SU->{_flow_name_grey_w}				= $hash_ref->{_flow_name_grey_w};
 	 	$L_SU->{_flow_name_pink_w}				= $hash_ref->{_flow_name_pink_w};
 	 	$L_SU->{_flow_name_green_w}				= $hash_ref->{_flow_name_green_w};
  	 	$L_SU->{_flow_name_blue_w}				= $hash_ref->{_flow_name_blue_w};
  	   	$L_SU->{_flowNsuperflow_name_w}			= $hash_ref->{_flowNsuperflow_name_w};
  	    $L_SU->{_is_pre_built_superflow}		= $hash_ref->{_is_pre_built_superflow};
  	 	$L_SU->{_is_user_built_flow}		 	= $hash_ref->{_is_user_built_flow};
  		$L_SU->{_message_w}						= $hash_ref->{_message_w}; 
   		$L_SU->{_mw}							= $hash_ref->{_mw};
 	 	$L_SU->{_parameter_names_frame}  		= $hash_ref->{_parameter_names_frame}; 	
 	 	$L_SU->{_parameter_values_frame} 		= $hash_ref->{_parameter_values_frame};
 		$L_SU->{_parameter_values_button_frame}	= $hash_ref->{_parameter_values_button_frame};	
 		$L_SU->{_run_button}					= $hash_ref->{_run_button}; 	 	
 		$L_SU->{_save_button}					= $hash_ref->{_save_button}; 
 		$L_SU->{_sunix_listbox}					= $hash_ref->{_sunix_listbox};	
 		
 		 # print("L_SU,set_hash_ref,delete_from_flow_button: $delete_from_flow_button\n");
 		  # print("1 L_SU,set_hash_ref,parameter_values_frame: $L_SU->{_parameter_values_frame}\n");
 		 # print("1. L_SU,set_hash_ref,_message_w: $L_SU->{_message_w}\n");
 		  # print("2 L_SU,set_hash_ref,parameter_values_frame: $parameter_values_frame\n"); 	
 		 # print("L_SU,set_hash_ref,add2flow_button_grey,$add2flow_button_grey	\n"); 	
 		 #  print("L_SU,set_hash_ref,_flow_listbox_pink_w, $L_SU->{_flow_listbox_pink_w}\n");
 		 # print("L_SU,set_hash_ref,flowNsuperflow_name_w: $L_SU->{_flowNsuperflow_name_w}\n");
		 # print("L_SU,set_hash_ref,_flow_item_down_arrow_button: $L_SU->{_flow_item_down_arrow_button}\n");
		 # print("L_SU,set_hash_ref,_flow_item_up_arrow_button: $L_SU->{_flow_item_up_arrow_button}\n");
 		return();
 	}

=head2  set_param_widgets

  Initially, checkbutton widgets and values 
  are green ("on") or red ("off"), and
  Labels and Entry Widgets are made blank.

=cut

 sub set_param_widgets {
 	my $self 	= @_;
 	
	use param_widgets;
	my $param_widgets = param_widgets->new();
	
	$param_widgets	-> set_labels_frame(\$parameter_names_frame);
 	$param_widgets	-> set_values_frame(\$parameter_values_frame);
  	$param_widgets	-> set_check_buttons_frame(\$parameter_values_button_frame);
  	$param_widgets	-> initialize_labels();
  	$param_widgets	-> initialize_values();
  	$param_widgets	-> initialize_check_buttons();
  	$param_widgets	-> show_labels();
  	$param_widgets	-> show_values();
  	$param_widgets	-> show_check_buttons();
  	
  	$L_SU->{_check_buttons_w_aref}  = $param_widgets  -> get_check_buttons_w_aref();
  	# print("L_SU, set_param_widgets _check_buttons_w_aref: $L_SU->{_check_buttons_w_aref}\n");
  	$L_SU->{_labels_w_aref}  		= $param_widgets  -> get_labels_w_aref();
  	$L_SU->{_values_w_aref}  		= $param_widgets  -> get_values_w_aref();
  	
  	return();
}


=head2 sub set_flow_color


=cut 

 sub set_flow_color {
	my ($self,$color)   = @_;
	if ($color) {
		$L_SU->{_flow_color}  = $color;
		# print ("$L_SU, new color: $color\n");
	} else {		
		print ("$L_SU,missing color: $color\n");
	}
	return();
 }


=head2 sub user_built_flows 

 		# if neutral-colored stored parameters exist
 		# they have to be transferred from neutral_flow 
 		# to  grey pink green or blue _flow
 		
 		
 		
 		# displays superflow name at top of gui
 		$pre_built_superflow	->set_flowNsuperflow_name_w($flowNsuperflow_name_w);	

 		# needed for binding to file dialog options
 		$grey_flow	->set_sub_ref(\&_FileDialog_button);
 		
 		# Display of all the parameters and names occurs via select method
 		$pre_built_superflow	->select();  
 		
 		# return changes to $L_SU without altering other original values
 		$L_SU 					= $pre_built_superflow->get_hash_ref();		
 		
=cut

 sub user_built_flows  {
 	my ($self,$method) 	= @_;
 	
 	my $color =  _get_flow_color();    # can = 'neutral'
 									   # when flow listbox is not a color					   							   
 				print("1. L_SU,user_built_flows  color: $color\n");
 				# print("L_SU,user_built_flows,_is_flow_listbox_grey_w:	$L_SU->{_is_flow_listbox_grey_w} \n");

 	if ( $color eq 'grey' ) {					
 		 			# helps bind flow parameters to the opening files
 		 			 		 		 #	print("1. L_SU, grey_flow:_is_last_flow_index_touched: $L_SU->{_is_last_flow_index_touched}\n");
		$grey_flow -> set_hash_ref($L_SU);  # uses 24/ 68 in	
 		$grey_flow -> $method;
 		$L_SU		= $grey_flow->get_hash_ref();
 		 		 # print("L_SU, grey_flow:$grey_flow\n");
 		 		 # print("1. L_SU,user_built_flows, color: $L_SU->{_flow_color},method: $method\n");
 		 		 #	print("2. L_SU, grey_flow:_is_last_flow_index_touched: $L_SU->{_is_last_flow_index_touched}\n");
 		
 	} elsif ($color eq 'pink') {
 		$pink_flow -> set_hash_ref($L_SU);
		$pink_flow -> $method;
  		$L_SU		= $pink_flow->get_hash_ref();
  				
 	} elsif ($color eq 'green') {	# needed?	
 		$green_flow -> set_hash_ref($L_SU);
 		$green_flow -> $method;
 		$L_SU		= $green_flow->get_hash_ref();
   					# print("3. L_SU,user_built_flows  color: $L_SU->{_flow_color}, method: $method \n");
 		
 	} elsif ($color eq 'blue') { 	# needed?
 		$blue_flow -> set_hash_ref($L_SU); 
 		$blue_flow -> $method;
 		$L_SU		= $blue_flow->get_hash_ref();
   					# print("4. L_SU,user_built_flows  color: $L_SU->{_flow_color}, method: $method \n");
 		
 	} elsif ($color eq 'neutral') {	  # for sunix_select
 		$neutral_flow 	-> set_hash_ref($L_SU);
 		$neutral_flow 	-> $method;
 		$L_SU->{_prog_name_sref} 	= $neutral_flow->get_prog_name_sref(); # bring back selected sunix program name
 					# $L_SU->{_sunix_flow}  = $hash_ref->{_sunix_flow};
   					# print("5. L_SU,user_built_flows  color: $L_SU->{_flow_color}, method: $method \n");
   					# print("5. L_SU,user_built_flows  _prog_name_sref : ${$L_SU->{_prog_name_sref}}\n");

 				# nothing more can happen until add2flow is selected
 	} else {
 		 print("L_SU,user_built_flows, method is $method, unknown color\n");
 	}
 	
	_set_user_built_flow_type();
	
	return();
}





=head2 sub check_code_button 

TODO: foreseeable errors

TODO: If it is a superflow:
					Sudipfilter
							In sunix package: are filter values increasing monotonically

	  If it is a user-built flow:
	  
	  	If dealing with sunix/user-built_flow (ASSUME)
	  
	  	    1. Collect the names of sunix modules in the flow
	  						
	  		2. Check MODULES as a WHOLE
	  		Are the modules incompatible?
	  		Do we have a minimum number of modules?
	  		Are there too many modules?
	  		Are the modules in the correct order?
	  		Are there any missing modules?
	  		
	  		3. For each individual sunix module: 
	  			sufilter:  are filter values increasing monotonically
	  								
	  			sudipfilt: are filter values increasing monotonically
	  						
	  			data_in  : does the file exist?
	  								 : is the file of a non-zero finite size
	  								 
	  			sugain:  incompatibilities			
	  						
	  						
	  		4.Send to message box one at a time e.g. 1 of 3 , 2 of 3, 3 of 3
	  						
	  	
	  If it is a pre-existing superflow
	  	 		 
	  	 		 						
	  						# FUTURE CASES not implemented flows
	  	If dealing with gmt?							
	  		If in individual gmt module:
	  	
	  	If dealing with grass?		  
	  		If in individual grass module:
	  		
	  	If dealing with sqlite ?
	  		If in individual sqlite module:

=cut                           

#sub check_code_button {
# 	my ($self, $value) 				= @_;
# 	use messages::message_director;
# 	# use whereami;
# 	
#	my $L_SU_messages 	    = message_director->new();
#	# my $whereami			= new whereami;
#
#	my $message          	= $L_SU_messages->null_button(0);
# 	$message_w   			->delete("1.0",'end');
# 	$message_w   			->insert('end', $message); 	
# 	
# 	$conditions_gui				->set_hash_ref($L_SU);
#	$conditions_gui				->set_gui_widgets($L_SU);
#	$conditions_gui				->set4start_of_check_code_button();
#	$L_SU 						= $conditions_gui->get_hash_ref();
#	
#        	# location within GUI   
#	my $widget_type		= $whereami->widget_type($parameter_values_frame);
#			  # print("L_SU,check_code_button,widget_type = $widget_type\n");
#			 
#
#			# for superflows only
#			# print("L_SU,check_code_button,is_superflow_select_button:$L_SU->{_is_superflow_select_button}\n");
#    if($L_SU->{_is_superflow_select_button}) {
##		$config_superflows	->save($L_SU);
##		$conditions_gui	->set4_save_button();
## $L_SU 			= $conditions_gui->get_hash_ref();
##		
##		# for flow but only if activated
#	} elsif ( ($L_SU->{_is_flow_listbox_grey_w} || 
#	    $L_SU->{_is_flow_listbox_pink_w} 		||
#	    $L_SU->{_is_flow_listbox_green_w} 		||
#	    $L_SU->{_is_flow_listbox_blue_w}) 		&&
#	    $widget_type eq 'Entry' )  {		
#
#			# 
#			# consider empty case	
##		if( !($L_SU->{_flow_name_out}) ||
##			$L_SU->{_flow_name_out} eq '') {
##
##			$message          	= $L_SU_messages->save_button(1);
## 	  		$message->delete("1.0",'end');
## 	  		$message->insert('end', $message);
##
##		} else {  # good case
##			# print("1. save_button, saving flow: $L_SU->{_flow_name_out}\n");
##    	}
#    	
#		_check4changes(); 	
#		$param_flow->set_good_values;
#		$param_flow->set_good_labels;
#		$L_SU->{_good_labels_aref2}	= $param_flow->get_good_labels_aref2;
#		$L_SU->{_items_versions_aref}= $param_flow->get_flow_items_version_aref;
#		$L_SU->{_good_values_aref2} 	= $param_flow->get_good_values_aref2;
#		$L_SU->{_prog_names_aref} 	= $param_flow->get_flow_prog_names_aref;
#		
#				# print("L_SU,check_code_button, program names are: @{$L_SU->{_prog_names_aref}} \n");
#		my $length = scalar @{$L_SU->{_prog_names_aref}};
#				# print("L_SU,check_code_button,There is/are $length program(s) in flow\n");
#		
#		for (my $prog_num = 0; $prog_num < $length; $prog_num++ ) {
#				# print("L_SU,check_code_button, program # $prog_num in flow is
#			  	# @{$L_SU->{_prog_names_aref}}[$prog_num]\n");
#			# my $prog_name  = @{$L_SU->{_prog_names_aref}}[$prog_num];
#			# require ($prog_name);
#			# $prog_name->set_code_values($L_SU->{_good_values_aref2});
#			# $prog_name->get_code_suggestions();
#		}
#
## 		$files_LSU	->set_prog_param_labels_aref2($L_SU);
## 		$files_LSU	->set_prog_param_values_aref2($L_SU);
## 		$files_LSU	->set_prog_names_aref($L_SU);
## 		$files_LSU	->set_items_versions_aref($L_SU);
## 		$files_LSU	->set_data();
## 		$files_LSU	->set_message($L_SU);
##		$files_LSU	->set2pl($L_SU); # flows saved to PL_SEISMIC
##		$files_LSU	->save();
##		$conditions_gui	->set4_save_button();
## $L_SU 			= $conditions_gui->get_hash_ref();
##		
#	} else { # if flow first needs a change for activation
##
##		$message          	= $L_SU_messages->check_code_button(0);
## 	  	$message_w			->delete("1.0",'end');
## 	  	$message_w			->insert('end', $message);
#	}
#	
#	$conditions_gui	->set4end_of_check_code_button();
#	 $L_SU 			= $conditions_gui->get_hash_ref();
#   	return();
#}

# 12. see if CAGEo or SRL will accept code
 	
 1;
