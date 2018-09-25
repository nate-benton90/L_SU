package neutral_flow;

=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL PACKAGE NAME: neutral_flow.pm
 AUTHOR: 	Juan Lorenzo
 DATE: 		June 8 2018 

 DESCRIPTION 
     

 BASED ON:
 previous versions of the main userBuiltFlow.pl
  

=cut

=head2 USE

=head3 NOTES

   Provides in-house macros/superflows
   1. Find widget you have selected

  if widget_name= frame then we have flow
              $var->{_flow}
              
  if widget_name= menubutton we have superflow 
              $var->{_tool}

   2. Set the new program name 

     3. Make widget states active for:
       run_button
       save_button

     4. Disable the following widgets:
       delete_from_flow_button
      (sunix) flow_listbox
    
    flow_listbox_neutral_w  	-top left listbox, input by user selection
    flow_listbox_green_w  	-bottom right listbox,input by user selection
    sunix_listbox   		-choice of listed sunix modules in a listbox
    

=head4 Examples

=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES
 refactoring of 2017 version of L_SU.pl

=cut 

=head2 Notes from bash
 
=cut 

 	use Moose;
 	our $VERSION = '0.0.1';			 
	
	use param_widgets_grey;  # K
	use param_flow; # K		
	use whereami;  # used extensively for whole-gui awareness
	use flow_widgets;
	use conditions_gui;
	
 	my $conditions_gui		= conditions_gui 	->new();
 	my $flow_widgets		= flow_widgets		->new();
 	my $get					= SeismicUnixPlTk_global_constants->new();
 	my $param_flow     		= param_flow 	->new();
 			# print("user_built flow, make param_flow instance in user_built flow\n");
 	my $param_widgets		= param_widgets_grey ->new();
 	my $whereami           	= whereami			->new();
 	my $flow_type			= $get->flow_type_href();

 
=head2

 share the following parameters in same name 
 space

=cut
 	my $FileDialog_sub_ref;
 	my $FileDialog_option;
 	my ($mw);
 	my ($parameter_values_button_frame );
 	my ($parameter_names_frame,$parameter_values_frame);
 	my ($flow_listbox_grey_w,$flow_listbox_pink_w,$flow_listbox_green_w,$flow_listbox_blue_w,$flow_listbox_color_w,$flow_listbox_neutral_w);
 	my ($flow_color);
 	my ($flow_name_grey_w,$flow_name_pink_w,$flow_name_green_w,$flow_name_blue_w,$flow_name_neutral_w);
 	my ($flowNsuperflow_name_w);
 	my ($dnd_token_grey,$dnd_token_pink,$dnd_token_green,$dnd_token_blue,$dnd_token_neutral);
 	my ($dropsite_token_grey, $dropsite_token_pink,$dropsite_token_green,$dropsite_token_blue,$dropsite_token_neutral);
 	my ($labels_w_aref, $values_w_aref, $check_buttons_w_aref);
 	my ($message_w);
 	my ($sunix_listbox);
 	my  $save_button;
	my ($add2flow_button_grey, $add2flow_button_pink, $add2flow_button_green, $add2flow_button_blue, $add2flow_button_neutral, $check_code_button);
	my ($delete_from_flow_button);
	my $dialog_type;	
 	my ($file_menubutton);
 	my ($flow_item_down_arrow_button, $flow_item_up_arrow_button);

	my $var								= $get->var();
#	my $on         						= $var->{_on};
	my $true       						= $var->{_true};
	my $false      						= $var->{_false};
#   my $superflow_names     			= $get->superflow_names_h();	
  	my @empty_array = (0); # length=1
 

=head2 private hash

	92 off 
	_is_flow_listbox_color_w is generic colored widget
	Warning: conditions_gui.pm does not contain all the hash keys and values
	that follow-- these variables will be reset by conditions_gui.p.

=cut

my $userBuiltFlow   = {
	
	_FileDialog_sub_ref				=> '',
	_FileDialog_option				=> '',
 	_add2flow_button_grey			=> '',#
 	_add2flow_button_pink			=> '',#
 	_add2flow_button_green			=> '',#
 	_add2flow_button_blue			=> '',#
 	_check_code_button				=> '', #
 	_check_buttons_settings_aref    => '',
 	_check_buttons_w_aref			=> '',#		 		
 	_delete_from_flow_button		=> '', #
 	_destination_index	 			=> '',
 	_dialog_type					=> '',#
 	_dnd_token_grey					=> '',
  	_dnd_token_pink					=> '', 
   	_dnd_token_green				=> '', 
    _dnd_token_blue					=> '',  
 	_dropsite_token_grey			=> '',
  	_dropsite_token_pink			=> '',
   	_dropsite_token_green			=> '',
    _dropsite_token_blue			=> '', 
 	_file_menubutton				=> '',#
 	_flow_color						=> '',#
 	_flow_item_down_arrow_button	=> '',
 	_flow_item_up_arrow_button		=> '', 	
 	_flow_listbox_grey_w			=> '',#
 	_flow_listbox_pink_w			=> '', # 
  	_flow_listbox_green_w			=> '',#
   	_flow_listbox_blue_w			=> '',#
    _flow_listbox_neutral_w			=> '',
   	_flow_listbox_color_w			=> '', #
   	_flow_name_grey_w				=> '',
   	_flow_name_pink_w				=> '',
   	_flow_name_green_w				=> '',
   	_flow_name_blue_w				=> '',  	
   	_flow_name_out					=> '',#
  	_flow_type						=> $flow_type->{_user_built},#
    _flow_widget_index				=> '',#
 	_flowNsuperflow_name_w			=> '',
	_good_labels_aref2				=> '',
	_good_values_aref2 				=> '',
	_has_used_open_perl_file_butt	 => '',
    _has_used_Save_button			=> '',	#
    _has_used_Save_superflow		=> '',	#
    _has_used_SaveAs_button			=> '',#
    _has_used_run_button			=> '',#
    _index2move	    				=> '',
	_is_check_code_button          	=> '',#
    _is_SaveAs_file_button			=> '',#	
	_is_add2flow_button	   			=> '',#
	_is_check_code_button          	=> '',#
	_is_delete_from_flow_button	   	=> '',#
 	_is_flow_item_down_arrow_button	=> '',
 	_is_flow_item_up_arrow_button	=> '', 	
	_is_flow_listbox_grey_w			=> '',#
	_is_flow_listbox_pink_w			=> '',#	
	_is_flow_listbox_green_w		=> '',#
	_is_flow_listbox_blue_w			=> '',#
	_is_flow_listbox_color_w		=> '',#
    _is_pre_built_superflow			=> '',
	_is_run_button          		=> '',#
	_is_sunix_listbox				=> '',#
	_is_superflow_select_button		=> 0,#
	_is_superflow 					=> '',  # should it be _pre_built_superflow?#
	_is_user_built_flow				=> '',
  	_items_checkbuttons_aref2 		=> '',
  	_items_names_aref2  			=> '',
  	_items_values_aref2  			=> '',
  	_items_versions_aref 			=> '',	
  	_labels_w_aref					=> '',#
 	_last_flow_index_touched	 	=> -1,#
 	_last_flow_listbox_touched 		=> '',
 	_last_flow_listbox_touched_w	=> -1,
 	_last_parameter_index_touched   => -1,#
  	_last_parameter_index_touched   => -1,
 	_last_path_touched				=> './',
  	_message_w						=> '', # 
   	_mw								=> '',#
  	_names_aref    					=> '',
 	_param_flow_length        		=> '', 	
   	_parameter_names_frame  		=> '',
	_param_sunix_first_idx      	=> 0,
	_param_sunix_length  			=> '', 
 	_parameter_values_frame 		=> '', #
 	_parameter_values_button_frame	=> '', 
	_parameter_value_index  		=> -1,#
	_prog_name_sref					=> '',#
	_prog_names_aref 				=> '',
	_run_button						=> '',#
	_save_button					=> '', #
 	_sunix_listbox					=> '', 
	_values_aref  					=> \@empty_array,  # initialise empty array
	_values_w_aref					=> '',#
	
    };



=head2 sub set_hash_ref

	copies with simplified names are also kept (40) so later
	the hash can be returned to a calling module
	
	imports external hash into private settings 
 	40 and 33 
 	
 	local extra  
 	
=cut

 	sub set_hash_ref {
 		my ($self,$hash_ref) 	= @_;
 		
 		$FileDialog_sub_ref		= $hash_ref->{_FileDialog_sub_ref};
 		$FileDialog_option		= $hash_ref->{_FileDialog_option};
 		$add2flow_button_grey	= $hash_ref->{_add2flow_button_grey};
 		$add2flow_button_pink	= $hash_ref->{_add2flow_button_pink};
 		$add2flow_button_green	= $hash_ref->{_add2flow_button_green};
 		$add2flow_button_blue	= $hash_ref->{_add2flow_button_blue};
 		$check_buttons_w_aref 	= $hash_ref->{_check_buttons_w_aref};
 		$check_code_button		= $hash_ref->{_check_code_button};
 		$delete_from_flow_button= $hash_ref->{_delete_from_flow_button};
  		$dialog_type			= $hash_ref->{_dialog_type};
 		$dnd_token_grey			= $hash_ref->{_dnd_token_grey}; # K
 		$dnd_token_pink			= $hash_ref->{_dnd_token_pink}; 
 		$dnd_token_green		= $hash_ref->{_dnd_token_green}; 
 		$dnd_token_blue			= $hash_ref->{_dnd_token_blue}; 
 		$dropsite_token_grey	= $hash_ref->{_dropsite_token_grey};# K
  		$dropsite_token_pink	= $hash_ref->{_dropsite_token_pink}; 
   		$dropsite_token_green	= $hash_ref->{_dropsite_token_green};
    	$dropsite_token_blue	= $hash_ref->{_dropsite_token_blue}; 
 	 	$file_menubutton		= $hash_ref->{_file_menubutton};	 	
 	 	$flow_color				= $hash_ref->{_flow_color};
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
  	 	$flowNsuperflow_name_w	= $hash_ref->{_flowNsuperflow_name_w};
  		$labels_w_aref 			= $hash_ref->{_labels_w_aref};
  		$message_w				= $hash_ref->{_message_w}; 
   		$mw						= $hash_ref->{_mw};
 	 	$parameter_names_frame  = $hash_ref->{_parameter_names_frame}; 	
 	 	$parameter_values_frame = $hash_ref->{_parameter_values_frame};
 		$parameter_values_button_frame	 = $hash_ref->{_parameter_values_button_frame};
 		$save_button			= $hash_ref->{_save_button};
 		$sunix_listbox			= $hash_ref->{_sunix_listbox};
  		$values_w_aref 			= $hash_ref->{_values_w_aref};
 		 	 		
 		$userBuiltFlow->{_add2flow_button_grey}			= $hash_ref->{_add2flow_button_grey};
 		$userBuiltFlow->{_add2flow_button_pink}			= $hash_ref->{_add2flow_button_pink};
 		$userBuiltFlow->{_add2flow_button_green}		= $hash_ref->{_add2flow_button_green};
 		$userBuiltFlow->{_add2flow_button_blue}			= $hash_ref->{_add2flow_button_blue};
 		$userBuiltFlow->{_check_code_button}			= $hash_ref->{_check_code_button};
 		$userBuiltFlow->{_check_buttons_w_aref}	 		= $hash_ref->{_check_buttons_w_aref};
 		$userBuiltFlow->{_delete_from_flow_button}		= $hash_ref->{_delete_from_flow_button};
 		$userBuiltFlow->{_dnd_token_grey}				= $hash_ref->{_dnd_token_grey};
 		$userBuiltFlow->{_dropsite_token_grey}			= $hash_ref->{_dropsite_token_grey};
 		$userBuiltFlow->{_flow_color}					= $hash_ref->{_flow_color}; 
 		$userBuiltFlow->{_flow_item_down_arrow_button}	= $hash_ref->{_flow_item_down_arrow_button};
 		$userBuiltFlow->{_flow_item_up_arrow_button}	= $hash_ref->{_flow_item_up_arrow_button};		
 	 	$userBuiltFlow->{_file_menubutton}				= $hash_ref->{_file_menubutton};
 	 	$userBuiltFlow->{_flow_listbox_grey_w}			= $hash_ref->{_flow_listbox_grey_w};
 	 	$userBuiltFlow->{_flow_listbox_pink_w}			= $hash_ref->{_flow_listbox_pink_w};
  	 	$userBuiltFlow->{_flow_listbox_green_w}			= $hash_ref->{_flow_listbox_green_w};
 	 	$userBuiltFlow->{_flow_listbox_blue_w}			= $hash_ref->{_flow_listbox_blue_w};
  	 	$userBuiltFlow->{_flow_name_grey_w}				= $hash_ref->{_flow_name_grey_w};
 	 	$userBuiltFlow->{_flow_name_pink_w}				= $hash_ref->{_flow_name_pink_w};
 	 	$userBuiltFlow->{_flow_name_green_w}			= $hash_ref->{_flow_name_green_w};
  	 	$userBuiltFlow->{_flow_name_blue_w}				= $hash_ref->{_flow_name_blue_w};
  	 	$userBuiltFlow->{_flowNsuperflow_name_w}		= $hash_ref->{_flowNsuperflow_name_w};
   		$userBuiltFlow->{_labels_w_aref}		 		= $hash_ref->{_labels_w_aref};
		$userBuiltFlow->{_message_w}					= $hash_ref->{_message_w}; 
   		$userBuiltFlow->{_mw}							= $hash_ref->{_mw};
 	 	$userBuiltFlow->{_parameter_names_frame}  		= $hash_ref->{_parameter_names_frame}; 	
 	 	$userBuiltFlow->{_parameter_values_frame} 		= $hash_ref->{_parameter_values_frame};
 		$userBuiltFlow->{_parameter_values_button_frame}= $hash_ref->{_parameter_values_button_frame};
 		$userBuiltFlow->{_prog_name_sref}		 		= $hash_ref->{_prog_name_sref};
 		$userBuiltFlow->{_run_button}					= $hash_ref->{_run_button}; 	 	
 		$userBuiltFlow->{_save_button}					= $hash_ref->{_save_button}; 
 		$userBuiltFlow->{_sunix_listbox}				= $hash_ref->{_sunix_listbox};
 		$userBuiltFlow->{_values_w_aref} 				= $hash_ref->{_values_w_aref};
 		
 		 # print("neutral_flowset_hash_ref,delete_from_flow_button: $delete_from_flow_button\n");
 		 # print("neutral_flowset_hash_ref,parameter_values_frame: $userBuiltFlow->{_parameter_values_frame}\n");
 		 # print("1. neutral_flowset_hash_ref,_message_w: $userBuiltFlow->{_message_w}\n");
 		 # print("neutral_flowset_hash_ref,parameter_values_frame: $parameter_values_frame\n"); 	
 		 # print("neutral_flowset_hash_ref,add2flow_button_neutral,$add2flow_button_neutral	\n");
 		 # print("neutral_flow,set_hash_ref,userBuiltFlow->{_flow_color}: $userBuiltFlow->{_flow_color}	\n");
 		 # print("neutral_flowset_hash_ref,delete_from_flow_button: $delete_from_flow_button\n");
 		 # print("neutral_flow,set_hash_ref,flow_color: $flow_color\n");
 		return();
 	}

=head2

	Only cases where there is a MB binding use this private ('_') subroutine 
	Other cases that select the GUI file buttons directly use: FileDialog_button
	 	 foreach my $key (sort keys %$userBuiltFlow) {
   			print (" neutral_flow key is $key, value is $userBuiltFlow->{$key}\n");
  		}
  	print ("neutral_flow,_FileDialog_button(binding), _is_flow_listbox_neutral_w: $userBuiltFlow->{_is_flow_listbox_neutral_w} \n");
  	
  	Once the file name is selected the paramter value is upadate in the GUI
  	
=cut 

 sub _FileDialog_button {   # N.B. Another FileDialog_button in L_SU needs to be updated too!!!!!!!
	
	my ($self,$option_sref) = @_;
	use file_dialog;
	my $file_dialog			= file_dialog ->new();
	
	if ($option_sref)  {
		
		$userBuiltFlow		->{_dialog_type}  = $$option_sref;  # dereference scalar
		
		$file_dialog		->set_flow_color($userBuiltFlow->{_flow_color}); 	# uses 1/ 31 in	 
		$file_dialog 		->set_hash_ref($userBuiltFlow);       # uses 7/ 31 in  ; uses values_aref
		$file_dialog		->set_gui_widgets($userBuiltFlow);    # uses 18/ 31 in
		$file_dialog 		->FileDialog_director();
		
		# assume that while selecting a data file to open in file-dialog that the
		# GUI has been updated (not very elegant... TODO
		# See if the last parameter index has been touched (>= 0)
		# assume we are still dealing with the current flow item selected
		$userBuiltFlow->{_last_parameter_index_touched} = $file_dialog->get_last_parameter_index_touched();
		_check4parameter_changes();
				
	} else {		
		print("neutral_flow,_FileDialog_button (binding),option type missing ")
	}
	return();
 }

=head2  _check4flow_changes

	assume now that selection of a flow item will always change a previously existing
	assume that opening a file dialog will change a parameter (Entry widget) value
	set of flow parameters, That is, a prior program must have been touched
	if ($param_widgets->get_entry_change_status && $userBuiltFlow->{_last_flow_index_touched} >= 0) {		
    	  foreach my $key (sort keys %$userBuiltFlow) {
           print (" neutral_flowkey is $key, value is $userBuiltFlow->{$key}\n");
           used only by flow_select and sunix_select
          }
             
		 ( $userBuiltFlow->{_last_parameter_index_touched} ) >= 0)        
=cut 

sub _check4flow_changes {
	my $self = @_;	
	
   # print("neutral_flow check4flow_changes: _last_flow_index_touched $userBuiltFlow->{_last_flow_index_touched}\n");
   # print("neutral_flow check4flow_changes: _last_parameter_index_touched $userBuiltFlow->{_last_parameter_index_touched}\n");
   
	if ( $userBuiltFlow->{_last_flow_index_touched} >= 0 ){  # <-1 does exist and means the flow was not touched

		my $last_idx_chng = $userBuiltFlow->{_last_flow_index_touched} ;

	 					      #  print("neutral_flow_check4flow_changes,
	 					      # last changed entry index was $last_idx_chng\n");
  							  # print("neutral_flow _check4flow_changes program name is 
  							  # ${$userBuiltFlow->{_prog_name_sref}}\n");
  							  # the chekbuttons, values and names of only the last program used 
  							  # is stored in param_widgets at any one time			
		$userBuiltFlow->{_values_aref} 					= $param_widgets	->get_values_aref();
		$userBuiltFlow->{_names_aref} 					= $param_widgets	->get_labels_aref();
		$userBuiltFlow->{_check_buttons_settings_aref}	= $param_widgets	->get_check_buttons_aref();

  							#print("neutral_flowflow_select,changed values_aref: @{$userBuiltFlow->{_values_aref}}\n");
  							#print("neutral_flow_changes4changes,changed names_aref: @{$userBuiltFlow->{_names_aref}}\n");
  							#print(" neutral_flowflow_select,changes, check_buttons_settings_aref: @{$userBuiltFlow->{_check_buttons_settings_aref}}\n");
  							#
   		 $param_flow	-> set_flow_index($last_idx_chng);
  						 	     # print("neutral_flow check4flow_changes ,store changes in param_flow, last changed entry index $last_idx_chng\n");
  						 	    
								# save old changed values
		 $param_flow	->set_values_aref($userBuiltFlow->{_values_aref}); 		# but not the versions
	 	 $param_flow	->set_names_aref($userBuiltFlow->{_names_aref}); 		# but not the versions
		 $param_flow	->set_check_buttons_settings_aref($userBuiltFlow->{_check_buttons_settings_aref}); # BUT not the versions

		 $param_widgets	->set_entry_change_status($false);  # changes are now complete
	 	 						 # print("neutral_flow flow_select, set_entry_change_status: to 0\n");
	}  						

	return();
 }


=head2  _check4parameter_changes

	Assume that the program of interest within an activate flow does not change
	Assume that a parameter within a fixed program has changed so that
	the stored paramters for that program need to be updated.
	That is param_flow will update the stored parameters for a member of the flow
	without having to change with which flow item/program we interact.
	
	N.B. The checkbuttons, values and names of only the present program in use 
  	are stored in param_widgets at any one time
  	
  	For example, after selecting  a data file name, the file name is automatically inserted
  	into the GUI. Following we update the data file name into the stored parameters via param_flow
  	
  	Required: current flow item number, current parameter index in use
	   
=cut 

sub _check4parameter_changes {
	my $self = @_;	
	
   		# print("B4 neutral_flow check4changes: _last_flow_index_touched $userBuiltFlow->{_last_flow_index_touched}\n");
   		# print("B4 neutral_flow check4changes: _last_parameter_index_touched: $userBuiltFlow->{_last_parameter_index_touched}\n");
   
	if ( $userBuiltFlow->{_last_parameter_index_touched} >= 0 ){  # <-1 does exist and means the parameters are untouched

		my $last_parameter_idx_touched = $userBuiltFlow->{_last_parameter_index_touched} ;

	 		# print("neutral_flow_check4parameter_changes,last changed entry index was $last_parameter_idx_touched \n");
  		# print("neutral_flow _check4parameter_changes current program name in use: ${$userBuiltFlow->{_prog_name_sref}}\n");
  							 							  		
		$userBuiltFlow->{_values_aref} 					= $param_widgets	->get_values_aref();
		$userBuiltFlow->{_names_aref} 					= $param_widgets	->get_labels_aref();
		$userBuiltFlow->{_check_buttons_settings_aref}	= $param_widgets	->get_check_buttons_aref();

  							# print("neutral_flow flow_select,changed values_aref: @{$userBuiltFlow->{_values_aref}}[0]\n");
  							#print("neutral_flow_changes4changes,changed names_aref: @{$userBuiltFlow->{_names_aref}}\n");
  							#print(" neutral_flowflow_select,changes, check_buttons_settings_aref: @{$userBuiltFlow->{_check_buttons_settings_aref}}\n");
  							
	
  		# flow item index of the program in the grey-flow listbox that is currently being used, i.e., not the index of the last-used program
  		my $flow_listbox_color_w 		= _get_flow_listbox_color_w();  # user-built_flow in current use 
   		my $current_flow_listbox_index 	= $flow_widgets->get_flow_selection($flow_listbox_color_w);
		$param_flow						-> set_flow_index($current_flow_listbox_index);
							# print("neutral_flow check4parameter_changes ,current_flow_listbox_index: $current_flow_listbox_index \n");
  						 	    
								# save current values
		 $param_flow	->set_values_aref($userBuiltFlow->{_values_aref}); 		# but not the versions
	 	 $param_flow	->set_names_aref($userBuiltFlow->{_names_aref}); 		# but not the versions
		 $param_flow	->set_check_buttons_settings_aref($userBuiltFlow->{_check_buttons_settings_aref}); # BUT not the versions

		 $param_widgets	->set_entry_change_status($false);  # changes are now complete
	 	 		# print("neutral_flow ,check4paramter_changes, set_entry_change_status: to 0\n");
	 	 						 # if er reinitialize last_paramter_index_touched to -1
	 	 						 # then this subroutine may not be used
	 	 $userBuiltFlow->{_last_parameter_index_touched} = -1;
	 	 $userBuiltFlow->{_last_flow_index_touched}      = $current_flow_listbox_index; # for next time
	 	 
	 	# print("End neutral_flow check4changes: _last_flow_index_touched $userBuiltFlow->{_last_flow_index_touched}\n");
   		# print("BEndneutral_flow check4changes: _last_parameter_index_touched reset: $userBuiltFlow->{_last_parameter_index_touched}\n");
	}  						

	return();
 }



=head2 sub _get_flow_listbox_color_w


=cut 

 sub _get_flow_listbox_color_w {
	my ($self)   = @_;
	my $flow_color;
	my $correct_flow_listbox_color_w;
	
	$flow_color 		= $userBuiltFlow->{_flow_color};
	
	if ($flow_color eq 'grey') {
		$correct_flow_listbox_color_w =  $userBuiltFlow->{_flow_listbox_grey_w};
		
	} elsif ($flow_color eq 'pink')  {
		$correct_flow_listbox_color_w = $userBuiltFlow->{_flow_listbox_pink_w};
		
	} elsif ($flow_color eq 'green') {
		$correct_flow_listbox_color_w =  $userBuiltFlow->{_flow_listbox_green_w};
		
	} elsif ($flow_color eq 'blue')  {
		$correct_flow_listbox_color_w =  $userBuiltFlow->{_flow_listbox_blue_w};
		
	} elsif ($flow_color eq 'neutral'){
		print("neutral_flow, _get_flow_listbox_color_w, neutral color\n");
	} else {
		print("neutral_flow, _get_flow_listbox_color_w, missing color\n");
		
	}
    
	return($correct_flow_listbox_color_w);
 }



=head2 sub _move_in_stored_flows

  move program names,
  parameter names, values and checkbutton setttings
  --- these are stored separately (via param_flows.pm)
  from GUI widgets (via flow_widgets.pm)
  The flow-widgets is a single copy of names and values
  that constantly changes as the uses interacts with the GUI
  The param-flows stores several program (items) and their
  names and values

=cut 

 sub _move_in_stored_flows {
	my $self 		= @_;
   
	$userBuiltFlow->{_index2move}        	= $flow_widgets->index2move();
   	$userBuiltFlow->{_destination_index} 	= $flow_widgets->destination_index();

   	my $start	= $userBuiltFlow->{_index2move};
  	my $end	    = $userBuiltFlow->{_destination_index};
   			 # print("neutral_flow_move_in_stored_flows,start index is the $start\n");
   			 # print("neutral_flow_move_in_stored_flows, insertion index is $end \n");

   	$param_flow	->set_insert_start($start);
   	$param_flow	->set_insert_end($end);
   	$param_flow	->insert_selection(); 
  	return(); 
 }




=head2 sub _SaveAs_button

	topic: only for 'SaveAs'
  	for safety, place set_hash_ref first
  	
   	my	$m          	= "neutral_flow, _SaveAs_button, Test,set_specs,message,$message_w\n";
 	$message_w->delete("1.0",'end');
 	$message_w->insert('end', $m);

=cut

 sub _SaveAs_button {
 	my ($topic) = @_;
 	
	if ($topic eq 'SaveAs') {
		
		use files_LSU;

		my $files_LSU			= new files_LSU();
		
		#$conditions_gui			->set_hash_ref();       # 36 used of 85 in
		#$conditions_gui			->set_gui_widgets();	# 23 used of 85 in
		#$conditions_gui			->set4_start_of_SaveAs_button();

		my $num_items 			= $param_flow->get_num_items();
  			# print("1. neutral_flow, _SaveAs_button, B4 stored number of prgrams: $num_items\n");
  	 	$userBuiltFlow->{_names_aref} 	= $param_flow->get_names_aref();
  			# print("2. neutral_flow ,_SaveAs_button parameter names: @{$userBuiltFlow->{_names_aref}}[0]\n");
	
		$param_flow				->set_good_values();
		$param_flow				->set_good_labels();
		
		$userBuiltFlow->{_good_labels_aref2}	= $param_flow->get_good_labels_aref2();
		$userBuiltFlow->{_items_versions_aref}	= $param_flow->get_flow_items_version_aref();
		$userBuiltFlow->{_good_values_aref2} 	= $param_flow->get_good_values_aref2();
		$userBuiltFlow->{_prog_names_aref} 		= $param_flow->get_flow_prog_names_aref();

		 		 # print("neutral_flow,_prog_names_aref,
		 		 # @{$userBuiltFlow->{_prog_names_aref}}\n");
		# my $num_items4flow = scalar @{$userBuiltFlow->{_good_labels_aref2}};

				 # for (my $i=0; $i < $num_items4flow; $i++ ) {
					# print("userBuiltFlow,_good_labels_aref2,
				# @{@{$userBuiltFlow->{_good_labels_aref2}}[$i]}\n");
				# }

				# for (my $i=0; $i < $num_items4flow; $i++ ) {
				#	print("userBuiltFlow,_good_values_aref2,
				#	@{@{$userBuiltFlow->{_good_values_aref2}}[$i]}\n");
				#}
				#   print("userBuiltFlow,_prog_versions_aref,
				#   @{$userBuiltFlow->{_items_versions_aref}}\n");
				
 		$files_LSU	->set_prog_param_labels_aref2($userBuiltFlow);	# uses x / 61 in
 		$files_LSU	->set_prog_param_values_aref2($userBuiltFlow);	# uses x / 61 in
 		$files_LSU	->set_prog_names_aref($userBuiltFlow);			# uses x / 61 in
 		$files_LSU	->set_items_versions_aref($userBuiltFlow);		# uses x / 61 in
 		$files_LSU	->set_data();
 		$files_LSU	->set_message($userBuiltFlow);  				# uses 1 / 61 in

 	  	
		$files_LSU	->set2pl($userBuiltFlow); 			# flows saved to PL_SEISMIC
		$files_LSU	->save();
		
		print("1. neutral_flow, _SaveAs_button, has_used_SaveAs: $userBuiltFlow->{_has_used_SaveAs}\n");
		$conditions_gui			    ->set4_end_of_SaveAs_button();
		#$userBuiltFlow 			= $conditions_gui->get_hash_ref(); # 78 out
 	
 		return();
 		
	} else {
		
		print("neutral_flow,_SaveAs_button, missing topic\n");
	}
	
 	
 } 	


=head2 sub _set_flow_color


=cut 

 sub _set_flow_color {
	my ($flow_color)   = @_;
	
	if ($flow_color) {
		# print("neutral_flow _set_flow_color , color:$flow_color\n");
		$userBuiltFlow->{_flow_color}  			 = $flow_color;
		
	} else  {
	 	print("neutral_flow, set_flow_color, missing color\n");
	}
	return();
 }



=head2 sub _set_flow_listbox_color_w


=cut 

 sub _set_flow_listbox_color_w {
	my ($flow_color)   = @_;
		
	if ($flow_color eq 'grey') {
		$userBuiltFlow->{_flow_listbox_color_w} =  $userBuiltFlow->{_flow_listbox_grey_w};
			#print("neutral_flow,_set_flow_listbox_color_w, _set_flow_listbox_color_w, color is $flow_color\n");
		
	} elsif ($flow_color eq 'pink')  {
		$userBuiltFlow->{_flow_listbox_color_w} = $userBuiltFlow->{_flow_listbox_pink_w};
			#print("neutral_flow,_set_flow_listbox_color_w, _set_flow_listbox_color_w, color is $flow_color\n");		
	} elsif ($flow_color eq 'green') {
		$userBuiltFlow->{_flow_listbox_color_w} =  $userBuiltFlow->{_flow_listbox_green_w};
			#print("neutral_flow,_set_flow_listbox_color_w, _set_flow_listbox_color_w, color is $flow_color\n");		
	} elsif ($flow_color eq 'blue')  {
		$userBuiltFlow->{_flow_listbox_color_w} =  $userBuiltFlow->{_flow_listbox_blue_w};
			#print("neutral_flow,set_flow_listbox_color_w, _set_flow_listbox_color_w, color is $flow_color\n");		
	} else {
		print("neutral_flow,_set_flow_listbox_color_w, _set_flow_listbox_color_w, missing color\n");
	}
    
	return();
 }



=head2 sub _set_flowNsuperflow_name_w

	displays superflow name at top of gui
	
=cut

sub _set_flowNsuperflow_name_w {	
	my ($flowNsuperflow_name) = @_;
		
	if ($flowNsuperflow_name && $flowNsuperflow_name_w) {
		
		$userBuiltFlow->{_flowNsuperflow_name_w} = $flowNsuperflow_name_w;
		
		$flowNsuperflow_name_w->configure(-text => $flowNsuperflow_name,);				
	} else {		
			print("userBuiltFlow, set_flowNsuperflow_name_w, missing widget or program name\n");
	}

	return();
}
 		
=head2 sub _set_user_built_flow_name_w

=cut

sub _set_user_built_flow_name_w {	
	my ($user_built_flow_name) = @_;
		
	if ($user_built_flow_name && $flow_name_neutral_w) {
		
		$userBuiltFlow->{_flow_name_neutral_w} = $flow_name_neutral_w;	

		$flow_name_neutral_w->configure(-text => $user_built_flow_name);				
	} else {		
			print("userBuiltFlow, set_user_built_flow_name_w, missing widget or program name\n");
	}

	return();
}



=head2 sub _stack_flow

  store an initial version of the parameters in a 
  namespace different to the one belonginf to param_widgets 
  
  The initial version comes from default parameter files
  i.e., sing the same code as for sunix_select
  
  print("neutral_flow_stack_flow,last left listbox flow program touched had index = $userBuiltFlow->{_last_flow_index_touched}\n");
  print("neutral_flow_stack_flow,values= @{$userBuiltFlow->{_values_aref}}\n");
  
=cut


sub _stack_flow {
  my( $self) = @_;
    	
       # my $num_items = $param_flow->get_num_items();
  		# print("1. neutral_flow, _stack_flow, B4 stored number of prgroams: $num_items\n");
  		# print("neutral_flow,_stack_flow,userBuiltFlow->listbox_widget: $userBuiltFlow->{_flow_listbox_color_w}\n");

  		# print("neutral_flow, _stack_flow, color: $flow_color \n");
  $param_flow		->stack_flow_item($userBuiltFlow->{_prog_name_sref});
  $param_flow		->stack_values_aref2($userBuiltFlow->{_values_aref});
  $param_flow		->stack_names_aref2($userBuiltFlow->{_names_aref});
  $param_flow		->stack_checkbuttons_aref2($userBuiltFlow->{_check_buttons_settings_aref});	
  
   	    # my $num_items = $param_flow->get_num_items;
  		# print("2. neutral_flow, _stack_flow, End- stored programs num_items: $num_items\n");			 
						
  return();
}


=head2 sub _stack_versions 

   Collect and store latest program versions from changed list 
   
   Will update listbox variables inside flow_widgets package
   Therefore pop is not needed on the array
   Use after data have been stored, deleted, or 
   suffered an insertion event

=cut

sub _stack_versions {
	my $flow_listbox_color_w 			= _get_flow_listbox_color_w();
	   			# print("neutral_flow, _stack_versions ,userBuiltFlow->listbox_widget: $flow_listbox_color_w\n");
    $flow_widgets						->set_flow_items($flow_listbox_color_w );
    $userBuiltFlow->{_items_versions_aref} 	= $flow_widgets->items_versions_aref;
    $param_flow						->set_flow_items_version_aref($userBuiltFlow->{_items_versions_aref});
 			 # print("_stack_versions,items_versions_aref: @{$userBuiltFlow->{_items_versions_aref}}\n");
}



=head2

	FileDialog_button
	 	 foreach my $key (sort keys %$userBuiltFlow) {
   			print (" neutral_flow key is $key, value is $userBuiltFlow->{$key}\n");
  		} 	
  	
  	Once the file name is selected the paramter value is upadate in the GUI
  	
=cut 

 sub FileDialog_button {   # N.B. Another _FileDialog_button in L_SU needs to be updated too!!!!!!!
	
	my ($self,$option_sref) = @_;
	use file_dialog;
	use SeismicUnixPlTk_global_constants;
	
	my $file_dialog			= file_dialog ->new();
		
	my $get					= SeismicUnixPlTk_global_constants->new();
	my $conditions_gui		= conditions_gui ->new();
	my $file_dialog_type	= $get->file_dialog_type_href();
	
	if ($option_sref)  {
		
		$userBuiltFlow		->{_dialog_type}  = $$option_sref;  # dereference scalar
		
		$file_dialog		->set_flow_color($userBuiltFlow->{_flow_color}); 	# uses 1/ 31 in	 
		$file_dialog 		->set_hash_ref($userBuiltFlow);       # uses 7/ 31 in  ; uses values_aref
		$file_dialog		->set_gui_widgets($userBuiltFlow);    # uses 18/ 31 in
		$file_dialog 		->FileDialog_director();
		
			# save flows if possible
		my $topic = $userBuiltFlow ->{_dialog_type}; # in this module can only be SaveAs
													 # Save for user-built flows is accessible via L_SU.pm
		
		if ($topic eq $file_dialog_type->{_SaveAs} ) {
	
					# assume that while selecting a data file to open in file-dialog that the
					# GUI has been updated (not very elegant... TODO
					# see if the last index has been touched
					# print ("neutral_flow,FileDialog_button, last_parameter_index_touched: $userBuiltFlow->{_last_parameter_index_touched} \n");
						
			$userBuiltFlow->{_has_used_SaveAs_button}   	= $true;
			$userBuiltFlow->{_last_parameter_index_touched} = $file_dialog->get_last_parameter_index_touched();
			_check4parameter_changes();
			
			use messages::message_director;
			my $userBuiltFlow_messages 				= message_director->new();
			
			$userBuiltFlow->{_flow_name_out} 		= file_dialog->get_perl_flow_name_out();
			$userBuiltFlow-> {_path}    			= file_dialog->get_file_path();
			
				# consider empty case	for which saving is not possible
			if( !($userBuiltFlow->{_flow_name_out}) 		||
				$userBuiltFlow	->{_flow_name_out} eq '' 	|| 
				!($userBuiltFlow-> {_path})	 				||
				$userBuiltFlow	-> {_path} 		    eq ''     ) {
				
				my $message          = $userBuiltFlow_messages->save_button(1);
 	  			$message_w			 ->delete("1.0",'end');
 	  			$message_w			 ->insert('end', $message);

			} else {  # Good,  NON-EMPTY case
			
			 	# displays user-built flow name at top of grey-flow gui
 				_set_flowNsuperflow_name_w( $userBuiltFlow->{_flow_name_out} );
 				_set_user_built_flow_name_w( $userBuiltFlow->{_flow_name_out} );
				print("1. neutral_flow, FileDialog_button, saving flow: $userBuiltFlow->{_flow_name_out}\n");
				
				# go save perl flow file
				_SaveAs_button($topic);	

				# print("neutral_flow,FileDialog_button,_flow_name_out: $userBuiltFlow->{_flow_name_out}  \n");
				# print("neutral_flow,FileDialog_button,_path: $userBuiltFlow->{_path}  \n");
    		}
						
		} else {
		   # do nothing	
		}				
	} else {		
		print("neutral_flow,FileDialog_button ,option type missing\ n");
	}
	return();
 }


#=head2 sub add2flow_button
#
#
#  		foreach my $key (sort keys %$userBuiltFlow) {
#   			print (" neutral_flow key is $key, value is $userBuiltFlow->{$key}\n");
#  		}
#
#=cut
#
#sub add2flow_button {
#	
#	my ($self,$value)  = @_;
#
#	$userBuiltFlow->{_flow_type} = $flow_type->{_user_built};
#	 	# print("1. neutral_flow, add2flow_button, color: $flow_color \n");
#	 	# print("1. neutral_flow, add2flow_button, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
#		# print("1. neutral_flow add2flow_button: _last_parameter_index_touched $userBuiltFlow->{_last_parameter_index_touched}\n");
#		       
# 	use messages::message_director;
# 	use param_sunix;
# 	
# 	my $param_sunix        		= param_sunix->new();
#	my $userBuiltFlow_messages 	= message_director->new();
#  	my $message          		= $userBuiltFlow_messages->null_button(0);
#  	
#  	my $last_item;
#  	my $here;
#  	    #print("1. neutral_flow, add2flow_button, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
#  	$conditions_gui				-> set_gui_widgets($userBuiltFlow);
# 	$conditions_gui				-> set_hash_ref($userBuiltFlow);
#	$conditions_gui				-> set4start_of_add2flow_button($flow_color);
#	 	# print("2. neutral_flow, add2flow_button, color: $flow_color \n"); 	
# 	$message_w   				->delete("1.0",'end');
# 	$message_w   				->insert('end', $message);	
#
#   	$whereami					->set4flow_listbox($flow_color);  	
#			# 
#       		# clear all the indices of selected elements   
#   	$sunix_listbox->selectionClear($sunix_listbox->curselection);
#    # print("3. neutral_flow, add2flow_button, _prog_name_sref: ${$userBuiltFlow->{_prog_name_sref}}\n"); 
#    # print("2. neutral_flow, add2flow_button, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
#			# add the most recently selected program
#			# name (scalar reference) to the 
#			# end of the list indside flow_listbox 
#    _set_flow_listbox_color_w($flow_color);
#   			# print("8. neutral_flow, add2flow_button, _is_flow_listbox_neutral_w $userBuiltFlow->{_is_flow_listbox_neutral_w}\n");
#   			# print("neutral_flow,add2flow_button,userBuiltFlow->listbox_widget: $userBuiltFlow->{_flow_listbox_color_w}\n");
#   	$userBuiltFlow->{_flow_listbox_color_w} ->insert(
#                       	"end", 
#                       	${$userBuiltFlow->{_prog_name_sref}},
#	               );
#	  		#print("3. neutral_flow, add2flow_button, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
#	  		#print("3. neutral_flow, add2flow_button, _labels_w_aref $userBuiltFlow->{_labels_w_aref}\n");
#   				# display default paramters in the GUI
#    			# same as for sunix_select
#    			# can not get program name from the item selected in the sunix list box 
#    			# because focus is transferred to another list box   
#   
#   	$param_sunix   									->set_program_name($userBuiltFlow->{_prog_name_sref});
#   	$userBuiltFlow->{_names_aref}  					= $param_sunix->get_names();
#   	$userBuiltFlow->{_values_aref} 					= $param_sunix->get_values();
#   	$userBuiltFlow->{_check_buttons_settings_aref}  = $param_sunix->get_check_buttons_settings();
#   	$userBuiltFlow->{_param_sunix_first_idx}  		= $param_sunix->first_idx(); # first index = 0
#   	$param_sunix									->set_length(); # = (values+labels)  
#   			# $userBuiltFlow->{_param_sunix_length}  			= $param_sunix->get_length(); # # values not index 
#	 	# print("4. neutral_flow, add2flow_button, color: $flow_color \n"); 
#   	$whereami			->set4add2flow_button();
#   		 	# print("5. neutral_flow, add2flow_button, color: $flow_color \n");
#   	$here                = $whereami->get4add2flow_button();
#   	$param_widgets       ->set_location_in_gui($here);
#	
#		# widgets are initialized in a super class
#		# Assign program parameters in the GUI	
#	$param_widgets		->set_labels_w_aref($userBuiltFlow->{_labels_w_aref} );
#  	$param_widgets		->set_values_w_aref($userBuiltFlow->{_values_w_aref} );
#  	$param_widgets		->set_check_buttons_w_aref($userBuiltFlow->{_check_buttons_w_aref} );
#  	
#
#  			
#   	$param_widgets		->range($userBuiltFlow);
#   	$param_widgets		->set_labels($userBuiltFlow->{_names_aref});
#   	$param_widgets		->set_values($userBuiltFlow->{_values_aref});
#   	$param_widgets		->set_check_buttons(
#					$userBuiltFlow->{_check_buttons_settings_aref});
#   	$param_widgets		->redisplay_labels();
#   	$param_widgets		->redisplay_values();
#   	# print("2. neutral_flow, add2flow_button, _names_aref @{$userBuiltFlow->{_names_aref}}\n");
#   	  			
#   	  		 	# print("5. neutral_flow, add2flow_button, color: $flow_color \n");
#   	$param_widgets		->redisplay_check_buttons();
#   		  	# print("3. neutral_flow, add2flow_button, _labels_w_aref $userBuiltFlow->{_labels_w_aref}\n");
#	  		# print("4.  neutral_flow, add2flow_button, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
#   				# Collect and store prog versions changed in list box
#   _stack_versions();
#   	
#   				# Add a single_program to the growing stack
#				# store one program name, its associated parameters and their values
#				# as well as the ckecbuttons in another namespace
#
#   	_stack_flow();
#	  		# print("5. neutral_flow, add2flow_button, _values_w_aref @{$userBuiltFlow->{_values_w_aref}}\n");   	
#   	
#   	$conditions_gui			-> set_gui_widgets($userBuiltFlow); # includes _values_w_aref; 23 used / 61 in
# 	$conditions_gui			-> set_hash_ref($userBuiltFlow);			# 35 used / 61 in
#	$conditions_gui    		-> set4end_of_add2flow_button($flow_color);
#			# print("2. neutral_flow add2flow_button: _last_parameter_index_touched $userBuiltFlow->{_last_parameter_index_touched}\n");
#
#	my $index 				= $flow_widgets->get_flow_selection($userBuiltFlow->{_flow_listbox_color_w});
#							# print("neutral_flowadd2flow_button,last left flow program touched had index: $index\n");
#											# print("66. neutral_flow, add2flow_button, color: $flow_color \n");
#	$conditions_gui			-> set_flow_index_last_touched($index); # flow color is not reset
#	$userBuiltFlow 			=  $conditions_gui->get_hash_ref();
#			#print("9. neutral_flow, add2flow_button, _is_flow_listbox_neutral_w $userBuiltFlow->{_is_flow_listbox_neutral_w}\n");
#
#				# print("66. neutral_flow, add2flow_button, color: $flow_color \n");
#	   			# print("2. neutral_flow,add2flow_button,userBuiltFlow->listbox_widget: $userBuiltFlow->{_flow_listbox_color_w}\n");
#		  		# print("6. neutral_flow, add2flow_button, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
#	flow_select();
#	
#   			# print("3. neutral_flow,add2flow_button,userBuiltFlow->listbox_widget: $userBuiltFlow->{_flow_listbox_color_w}\n");
#			# print("user_builtFlow,add2flow_button,last grey-flow program touched had index: $userBuiltFlow->{_last_flow_index_touched}\n");
#													
#   	return(); 
#}


#
#
#=head2 sub delete_from_flow_button
#   	 	
# set:
#     $decisions
# 
# get:
#     $userBuiltFlow_messages
#     $flow_widgets
#     $param_flow	
# 
# call:
#    _stack_versions();	
#	$conditions_gui->set4last_delete_from_flow_button();
#    $conditions_gui->set4delete_from_flow_button();
#    $userBuiltFlow 			= $conditions_gui->get_hash_ref();
#  
#  		
#  		foreach my $key (sort keys %$userBuiltFlow) {
#   			print (" neutral_flowkey is $key, value is $userBuiltFlow->{$key}\n");
#  		}
#    
#=cut
#
#sub delete_from_flow_button {
#
#	my $self = @_;
#	
#	 	# if flow_select was last pushed then conditions_gui conserved the flow color chosen:	
# 	my $flow_color			= $conditions_gui->get_flow_color();
# 		# print("1. neutral_flow,delete_from_flow_button, flow_color: $flow_color \n");
# 	
# 	if ($flow_color)  {
# 		_set_flow_color($flow_color);
# 					# print("2. neutral_flow,delete_from_flow_button, flow_color: $userBuiltFlow->{_flow_color} \n");
#		use messages::message_director;
#		use decisions 1.00;
#	
#		my $userBuiltFlow_messages 	    = message_director->new();
#		my $decisions			= decisions->new();
#
#		my $message          	= $userBuiltFlow_messages->null_button(0);
# 		$message_w   			->delete("1.0",'end');
# 		$message_w   			->insert('end', $message);
#	
# 		my $flow_listbox_color_w = _get_flow_listbox_color_w();
#					# print("1. neutral_flow,delete_from_flow_button, flow_listbox_color_w: $flow_listbox_color_w \n");
#		$userBuiltFlow 			= $conditions_gui->get_hash_ref(); # find out if delete button is active
#					# print("1. neutral_flow,delete_from_flow_button , is_flow_listbox_neutral pink green or blue_w: $userBuiltFlow->{_is_flow_listbox_color_w} \n");
#		$decisions				->set4delete_from_flow_button($userBuiltFlow);
#		my $pre_req_ok 			= $decisions->get4delete_from_flow_button();
#					# confirm listboxes are active
#					# print("1. neutral_flow,delete_from_flow_button pre_req $pre_req_ok\n");
#  		if ($pre_req_ok) {
#					 # print("2. neutral_flowdelete_from_flow_button pre_req_ok\n");
#   
#  			$whereami			->set4delete_from_flow_button();
#  			my $here 			= $whereami->get4delete_from_flow_button();
#
#        			# location within GUI on first clicking delete button
#        	$conditions_gui		->set_hash_ref($userBuiltFlow);
#			$conditions_gui		->set_gui_widgets($userBuiltFlow);
#        	$conditions_gui		->set4start_of_delete_from_flow_button($flow_color);
# 			$userBuiltFlow 		= $conditions_gui->get_hash_ref();
#
#			my $index = $flow_widgets->get_flow_selection($flow_listbox_color_w);
#			
#						# when LAST ITEM in listbox is deleted 
#			if ($index == 0 && $param_flow->get_num_items == 1) {
#
#      				 # print("last item deleted Shut down delete button\n");
#      				 #  Run and Save button
#     			$flow_widgets->delete_selection($flow_listbox_color_w);
#
#							# the last program that was touched is cancelled out
#   				$userBuiltFlow->{_last_flow_index_touched} 	= -1;
#
#							#  print("neutral_flowdelete_from_flow_button,
#							#  last left flow program touched had index 
#							#  = $userBuiltFlow->{_last_flow_index_touched}\n");
#
#							# delete stored programs and their parameters
#   							# delete_from_stored_flows(); 
#  				my $index2delete 	= $flow_widgets->get_index2delete();
#  					 		# print("neutral_flowdelete_from_stored,index2delete:$index2delete\n");
#  					 
#  				$param_flow		->delete_selection($index2delete);
#
#   							# collect and store latest program versions from changed list 
#   				_stack_versions();
#			
#				$conditions_gui	->set4last_delete_from_flow_button();
# 				$userBuiltFlow 	= $conditions_gui->get_hash_ref();
#
#        					# location within GUI after last item is deleted 
#        		$conditions_gui	->reset(); 						# needed?
#  				$userBuiltFlow 	= $conditions_gui->get_hash_ref();# needed?
#  			
#				$decisions       ->reset();						# needed?
#
#							# Blank out all the widget parameter names 
#							# and their values
#							
#				$whereami			->set4delete_from_flow_button();
#        		$here				= $whereami->get4delete_from_flow_button();
#   				$param_widgets      ->set_location_in_gui($here);
#   				$param_widgets		->gui_clean();
#   				
#   							# Blank out the names of the programs in the GUI
#   				$userBuiltFlow->{_flow_name_neutral_w}     -> configure(-text => $var->{_clear_text});
#   				$userBuiltFlow->{_flowNsuperflow_name_w}-> configure(-text => $var->{_clear_text});
#        
#   			} elsif ($index >= 0) { #  i.e., more than one item remains in a listbox	
#			
#							# note the last program that was touched
#							 $userBuiltFlow->{_last_flow_index_touched} = $index;
#
#					   		# print("neutral_flow_delete_from_flow_button, last index touched :$index..\n");
#     			$flow_widgets->delete_selection($flow_listbox_color_w);
#
#					# delete stored programs and their parameters
#   					# delete_from_stored_flows(); 
#  				my $index2delete 	= $flow_widgets->get_index2delete();
#  					 		#print("2. neutral_flowdelete_from_stored,index2delete:$index2delete\n");
#  				$param_flow		->delete_selection($index2delete);
#
#					# update the widget parameter names and values
#					# to those of new selection after deletion
#  					# the chkbuttons, values and names of only the last program used 
#  					# are stored in param_widgets at any one time			
#  					# get parameters from storage
#  				my $next_idx_selected_after_deletion = $index2delete - 1;	
#            	if($next_idx_selected_after_deletion == -1) { $next_idx_selected_after_deletion = 0} # NOT < 0
#  					  		# print("2. neutral_flowdelete_from_flow_button,indexafter_deletion:
#  					  		# $next_idx_selected_after_deletion\n");
#
#   		 		$param_flow		-> set_flow_index($next_idx_selected_after_deletion);
# 				$userBuiltFlow->{_names_aref} 	= $param_flow->get_names_aref();
#
#  							 # print("2. neutral_flow delete_from_flow_button,parameter names 
#  							 # is @{$userBuiltFlow->{_names_aref}}\n");
# 				$userBuiltFlow->{_values_aref} 	=	$param_flow->get_values_aref();
#
#  				 			 # print("3. neutral_flow delete_from_flow_button,parameter values 
#  				 			 # is @{$userBuiltFlow->{_values_aref}}\n");
# 				$userBuiltFlow->{_check_buttons_settings_aref} 
#										=  $param_flow->get_check_buttons_settings();
#
#  				 			 # print("4. neutral_flow delete_from_flow_button, 
#  				 			 # check_buttons_settings no changes, 
#  				 			 # @{$userBuiltFlow->{_check_buttons_settings_aref}}, index;$index\n#");
#  				 			
# 				 			# get stored first index and num of items 
# 				$userBuiltFlow->{_param_flow_first_idx}	= $param_flow->first_idx();
# 				$userBuiltFlow->{_param_flow_length}   	= $param_flow->length();
# 				$userBuiltFlow->{_prog_name_sref}		= $param_widgets->get_current_program(\$flow_listbox_color_w);
# 				$param_widgets				 	->set_current_program($userBuiltFlow->{_prog_name_sref});
#				$whereami						->set4flow_listbox($flow_color);
#				$here 							= $whereami->get4flow_listbox();
#				 			 # print("neutral_flow delete_from_flow_button, $here->{_is_flow_listbox_color_w}\n");
#				 			 
#	    		$param_widgets      		->set_location_in_gui($here);
#   				$param_widgets				->gui_clean();
#  				$param_widgets				->range($userBuiltFlow);
# 				$param_widgets				->set_labels($userBuiltFlow->{_names_aref});
# 				$param_widgets				->set_values($userBuiltFlow->{_values_aref});
# 				$param_widgets				->set_check_buttons(
#									$userBuiltFlow->{_check_buttons_settings_aref});
#
#					  		 # print("neutral_flow, delete_from_flow_button, is listbox selected:$here->{_is_flow_listbox_color_w}\n");
# 				$param_widgets				->redisplay_labels();
# 				$param_widgets				->redisplay_values();
# 					$param_widgets			->redisplay_check_buttons();
#	#  			$param_widgets				->set_entry_change_status($false);	
#
#							# note the last program that was touched
#			 	$userBuiltFlow->{_last_flow_index_touched} = $next_idx_selected_after_deletion;
#
#   					# collect and store latest program versions from changed list 
#   				_stack_versions();
#   			}
#  		} # if pre_req_ok	
#		
# 	} else { # if flow_color
# 		print("neutral_flow, delete_from_flow_button, flow color missing: \n");
# 	}
#}
#
#
#=head2 sub drag
#
#  Drag and Drop do not delete 
#  the program name from param_flow stored data
#  when the program name disappears from the GUI
#
#  User must delete the item and its parameters
#  from stored memory after the Drop, i.e.
#  When  
#  (1) Drag is selected a second time or
#  (2) when any other button in the GUI is selected
# 
#  print("drag,check $check\n");
#
#  check if previous index was deleted by DnD 
#  if so they delete that program 
#  delete the stored parameter entries via param_flow.pm
#  delete stored parameter values, names and checkbuttons
#  also make sure that you can not drag if there is only one item left
#  
#  TODO: encapsulate and refactor
#  gets from :
#  	$userBuiltFlow
#  	$flow_widgets
#  	
#  sets to:
#  	$param_flow
#  	$flow_widgets
#  	
#  calls: _stack_versions
#  o/p need
#	
#=cut
#
#sub drag {
#  	my ($self) = @_;   
#					# print("1. neutral_flowdrag;just starting\n");
#					# print("1. neutral_flowdrag;listbox can not be empty\n");
#					# print("1. neutral_flowdrag;more than one item must exist\n");
#  my $prog_name;
#  if($userBuiltFlow->{_prog_name_sref}) {
#	$prog_name					= ${$userBuiltFlow->{_prog_name_sref}};
#	# print("1. neutral_flowdrag,prog=$prog_name\n");
#   }
#   
#			# was a program deleted through a previous dragNdrop? 
#			# Has a program name even been selected or is user just playing aimlessly? # K
# 	if( $prog_name && $flow_widgets->is_drag_deleted($flow_listbox_neutral_w) ) {
#
#			print("2.neutral_flowdrag; prior index was deleted\n");
#        my $this_index = $flow_widgets->get_drag_deleted_index($flow_listbox_neutral_w);
#
#			print("neutral_flowdrag,deleting flow_listbox,idx=$this_index\n");
#    	print("index $this_index was just removed from widget\n");
#
#						# delete stored values from param_flow
#    	$param_flow->delete_selection($this_index); 
#
#						# update program versions if listbox changes
#						# store via param_flows
#    	_stack_versions();
#		$flow_widgets->set_vigil_on_delete();
#  	}						  
#						# in case a previous drag updated the 
#						# vigil_on_delete counter
#						# reset drag and drop vigil_on_delete counter 
#	#$flow_widgets->set_vigil_on_delete();
#	
#	my $num_items = $flow_widgets->get_num_items($flow_listbox_neutral_w);
#  						# print("neutral_flowdrag,num items prior to deletion  = $num_items\n");
#
#  	if ( $num_items > 1 ) {  # num_items PRIOR to deletion
#   	   $flow_widgets->drag_start($dnd_token_neutral);
#	    				# print("neutral_flowdrag,start dnd_token_neutral:$dnd_token_neutral\n");
#  	} else {
#						# print("WARNING: neutral_flowdrag,not allowed\n");
#  	}						 
#}
#
#
#=head2 sub drop
#
#   Item is successfully moved from one part of the flow
#   listbox to another part of the same listbox
#   
#   drop does not occur if the user drags the item out of
#   the listbox area
#   
#	
#	$whereami					->set4moveNdrop_in_flow();
#	my $here 					= $whereami->get4moveNdrop_in_flow();
#	$param_widgets				->set_location_in_gui($here);
#
#    print("drop,confirm done\n");
#    
#	make param_widgets not detect any entry changes
#	This IS needed for sub flow_select also not to sense previous changes
#	or else the stored parameters in the flow will not be correct
#   	$param_widgets->set_entry_change_status($false);
#   	
#   	TODO: Refactoring
#   	Encapsulation is poor:
#   		gets from:
#   			$userBuiltFlow
#   			$flow_widgets
#   			$flow_listbox_color_w  	
#   	
#   	 	sets:
#   	 		$userBuiltFlow
#   			$flow_listbox_color_w
#   			$flow_widgets
#
#	calls external _stack_versions
#	calls external _move_in_stored_flows
#	
#	happens inside a Listbox only
#	
#=cut
#
#sub drop {
#   my ($self) 						= @_;   
#   my $done;
#   my $chosen_index_to_drop 		= $flow_widgets->drag_end($dnd_token_neutral);
#   my $prog_name;
#   
#   # listbox must have at least one item
#   if($userBuiltFlow->{_prog_name_sref}) {
#	$prog_name					= ${$userBuiltFlow->{_prog_name_sref}};
#	# print("1. neutral_flowdrop,prog=$prog_name\n");
#   }
#
#   if ($prog_name && $chosen_index_to_drop && $chosen_index_to_drop>=0  ) {   # same as destination_index
#   
#   	 # print("2. neutral_flowdrop,prog=$prog_name\n");
#   
#	        			# if insertion occurs within the listbox
#	 $userBuiltFlow->{_index2move} 			= $flow_widgets->index2move();
#     $userBuiltFlow->{_destination_index} 	= $flow_widgets->destination_index;
#
#							# note the last program that was touched
#    						 $userBuiltFlow->{_last_flow_index_touched} 	= $userBuiltFlow->{_destination_index} ;
#							 	# print(" neutral_flow drop, destination index = $userBuiltFlow->{_last_flow_index_touched}\n");
#
#			    # move stored data in agreement with this drop 
#	 _move_in_stored_flows(); 
#				# update program versions if listbox changes
#				# stored in param_flows
#     _stack_versions();
#							 # If there is no delete while dragging
#							 # the counter is also increased, so 
#							 # reset drag and drop vigil_on_delete counter 
#							 # this is a bug in the DragandDrop package
#  							 
#	$flow_widgets->set_vigil_on_delete();
#	 		 				# print(" drop, done is $done\n");
#	$flow_widgets->dec_vigil_on_delete_counter(2);
#							# highlight new index
#    $flow_listbox_neutral_w    			->selectionSet(
#                       			  $userBuiltFlow->{_destination_index}, 
#	               			  );
#   }
#}


#=head2 sub flow_select
#
#  Pick a Seismic Unix module
#  from within a flow listbox
#  This module was placed there previously by user
#  When there is only one item left in the
#  listbox drag and drop becomes blocked
#  N.B. I assume that _check4flow_changes will prove false in this case
#  check whether any programs were deleted by dragging previously
#  If so, delete stored values from param_flow
#  N.B. I assume that _check4flow_changes will prove false in this case
#  
#  if($userBuiltFlow->{_prog_name_sref}) {
# 		print("\n1. neutral_flow flow_select, program name is $userBuiltFlow->{_prog_name_sref}\n");
# 	}
#
#  TODO: Encapsulation is poor:
#  	gets from:
#    	flow_widgets
#    	param_widgets
#  
#  	sets 
#   		param_flow
#  		param_widgets
#    userBuiltFlow
#
# 	calls
# 	  	_stack_versions
#  		_check4flow_changes();
# 		$conditions_gui->set4start_of_flow_select(); 
#  		$conditions_gui->set4end_of_flow_select();
#  	 $userBuiltFlow 			= $conditions_gui->get_hash_ref();
#  	 
#    	  foreach my $key (sort keys %$userBuiltFlow) {
#           print (" neutral_flowkey is $key, value is $userBuiltFlow->{$key}\n");
#          }
#    	     	 
#  	always takes focus on first entry ; index = 0
#  	if focus is on first endtry then also make the last_paramter_index_touched = 0
#  	TODO: via conditions package
#    	  foreach my $key (sort keys %$userBuiltFlow) {
#           print ("neutral_flow, key is $key, value is $userBuiltFlow->{$key}\n");
#          }	  
#          
#    Important variables:
#      $userBuiltFlow->{_prog_name_sref}  : selected program name as a scalar reference
#  	
#=cut
#
#sub flow_select {
#	my ($self) = @_;
#	
#	use messages::message_director;
#	use decisions;  
#					# print("1. neutral_flow, flow_select, _is_flow_listbox_neutral_w:$userBuiltFlow->{_is_flow_listbox_neutral_w}\n");
#					# print("neutral_flow flow_select: _last_parameter_index_touched $userBuiltFlow->{_last_parameter_index_touched}\n");
#	my $userBuiltFlow_messages 	= message_director->new();
#	my $decisions				= decisions->new();
#	
#    $userBuiltFlow->{_flow_type} = $flow_type->{_user_built}; 
#			# print("1. neutral_flow, flow_select, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
#	my $message          		= $userBuiltFlow_messages->null_button(0);
# 	$message_w   				->delete("1.0",'end');
# 	$message_w   				->insert('end', $message);
# 				# print("neutral_flow, flow_select,flow color: $flow_color \n");
#  	$conditions_gui				-> set_gui_widgets($userBuiltFlow);
# 	$conditions_gui				-> set_hash_ref($userBuiltFlow);
#	$conditions_gui				-> set4start_of_flow_select($flow_color);
#	
#	_set_flow_listbox_color_w($flow_color); # update the flow color as per add2flow_select
#	
#	my $flow_listbox_color_w 	= _get_flow_listbox_color_w();
#	
#				#  independently set conditions to make grey box available
#				# print("2. neutral_flow, flow_select,_is_flow_listbox_neutral $userBuiltFlow->{_is_flow_listbox_neutral_w}\n");
# 	$userBuiltFlow 				= $conditions_gui->get_hash_ref();
# 	my $flow_color				= $userBuiltFlow ->{_flow_color};  # TODO: careful, color is re-assigned from conditions_gui,few lines up
# 				# print("neutral_flow, flow_select,_last_flow_listbox_touched_w: $userBuiltFlow->{_last_flow_listbox_touched_w} \n");
# 				
#    $userBuiltFlow->{_prog_name_sref} 		= $flow_widgets->get_current_program(\$flow_listbox_color_w);	  
#	$decisions		 		 				->set4flow_select($userBuiltFlow);
#			# print("2. neutral_flow, flow_select, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");	
#	my $pre_req_ok 	  						= $decisions->get4flow_select();
#				# print ("neutral_flow, flow_select, pre_req_ok: $pre_req_ok\n");
#	
#	if ($pre_req_ok) {
#		use binding;
# 		my $binding 			 = binding -> new;;
#		my $here;
#    						
# 		$userBuiltFlow->{_prog_name_sref} 	= $flow_widgets->get_current_program(\$flow_listbox_color_w);
# 				 			# print ("neutral_flow, flow_color: $flow_color\n");		
#							# Is a program deleted through a previous dragNdrop?
#  			if( $flow_widgets->is_drag_deleted($flow_listbox_color_w) ) {
#
#			  				 # print("\n\nneutral_flowflow_select,something was deleted in previous dragNdrop\n");
#        		my $this_index 		= $flow_widgets->get_drag_deleted_index($flow_listbox_color_w);
#							 # print("neutral_flowflow_select,deleting flow_listbox,idx=$thi# s_index\n");
#							 # 
#     						 # print("index (old) $this_index was just removed from widget\n");
#
#							# delete stored values from param_flow
#     			$param_flow->delete_selection($this_index); 
#
#							# update program versions if listbox changes
#							# store via param_flows
#     			_stack_versions(); 
#     						# reset drag and drop vigil_on_delete counter
#				$flow_widgets->set_vigil_on_delete();
#			
#			}
#				# print("3. neutral_flow, flow_select, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
#		                     # find out which program was previously touched
#		                     # assume all prior programs touched have
#		                     # modified parameters 
#		                     # and update the previously touched program's values ins torage via param_flow	
#		                     # find out what index was touched in grey-flow box
#		_check4flow_changes();
#				# print("4 neutral_flow, flow_select, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");                     
#		                    # for just-selected program name
#							# get its flow parameters from storage
#							# and redisplay the widgets with parameters
#							
#		# Update the flow item index to the program that is currently being used, instead of last-used program 
#   		my $index 							= $flow_widgets->get_flow_selection($flow_listbox_color_w);
# 				# print("neutral_flow, flow_select,_flow_listbox_color_w: $userBuiltFlow->{_flow_listbox_color_w} \n");
#  							# print("2. neutral_flow, current flow_select,index is $index\n");
#  							
#  		my $num_items 						= $param_flow->get_num_items();
# 		$param_flow							->set_flow_index($index);
# 		$userBuiltFlow->{_names_aref} 		= $param_flow->get_names_aref();
#  							# print("2. neutral_flow flow_select,parameter names: @{$userBuiltFlow->{_names_aref}}[0]\n");
#  							
# 		$userBuiltFlow->{_values_aref} 		=	$param_flow->get_values_aref();
#  				 			 # print("3. neutral_flow flow_select,parameter values:@{$userBuiltFlow->{_values_aref}}\n");
#  				 			 
# 		$userBuiltFlow->{_check_buttons_settings_aref} 
#									=  $param_flow->get_check_buttons_settings();
#
#  				 			 # print("4. neutral_flow flow_select, check_buttons_settings no changes, @{$userBuiltFlow->{_check_buttons_settings_aref}}\n");
#  				 			# print("4. neutral_flow flow_select,index: $index \n");
#  				 			
# 				 			# get stored first index and num of items 
# 		$userBuiltFlow->{_param_flow_first_idx}	= $param_flow->first_idx();
# 		$userBuiltFlow->{_param_flow_length}   	= $param_flow->length();
# 		$param_widgets				 			->set_current_program($userBuiltFlow->{_prog_name_sref});
# 				 				# print("5. neutral_flow, flow_select, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
#				 			  	# print("neutral_flow, flow_select, $userBuiltFlow->{_is_flow_listbox_color_w}\n");
#				 			  	# print("neutral_flow, flow_select, color:$flow_color\n");
#		$whereami				->set4flow_listbox($flow_color);
#		$here 					= $whereami->get4flow_listbox();
#				 			  # print("5. neutral_flow flow_select,here->{_is_flow_listbox_color_w: $here->{_is_flow_listbox_color_w}\n");
#				 			  # print("neutral_flow, flow_select, _is_flow_listbox_color_w, $here->{_is_flow_listbox_color_w}\n");
#
#		# $param_widgets		->range($userBuiltFlow); # to set widgets, must be before gui_clean
#		 				 	# print("6. neutral_flow, flow_select, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");	
#		 				 	 			 
#	    $param_widgets      		->set_location_in_gui($here);
#	    	    	
#		# widgets initialized in super class	
#		$param_widgets				->set_labels_w_aref($userBuiltFlow->{_labels_w_aref} );
#  		$param_widgets				->set_values_w_aref($userBuiltFlow->{_values_w_aref} );
#  		$param_widgets				->set_check_buttons_w_aref($userBuiltFlow->{_check_buttons_w_aref} );
#	    	    
#   		$param_widgets				->gui_clean();
#  		$param_widgets				->range($userBuiltFlow);
# 		$param_widgets				->set_labels($userBuiltFlow->{_names_aref});
# 		$param_widgets				->set_values($userBuiltFlow->{_values_aref});
# 		$param_widgets				->set_check_buttons($userBuiltFlow->{_check_buttons_settings_aref});
#										
#					  		 # print("6. neutral_flow flow_select, is listbox selected:$here->{_is_flow_listbox_color_w}\n");
#		$whereami					->set4flow_listbox($flow_color);
#		$here 						= $whereami->get4flow_listbox();
#							# print("6. neutral_flow, flow_select, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
#    	$param_widgets      		->set_location_in_gui($here);
# 		$param_widgets				->redisplay_labels();
# 		$param_widgets				->redisplay_values();
# 		$param_widgets				->redisplay_check_buttons();
#  		$param_widgets				->set_entry_change_status($false);	
#
#		my @Entry_widget			= @{$param_widgets->get_values_w_aref()};
#							# print("neutral_flowflow_select,Entry_widgets@Entry_widget\n");
#		$Entry_widget[0]			->focus;  # always put focus on first entry widget
#		
#		# Force the parameter index = 0 (NOT the flow index that marks the index of the programs in the flow);
#		# If parameter_index >= 0 stored values will also be updated via check4paramter_changes
#		# TODO the parameter_index_touched may become  .n.e. 0 but >=0
#		# $userBuiltFlow->{_last_parameter_index_touched} = 0;
#		# the changed parameter value in the Entry widget should force an update of stored values
#		# in the current flow item (not the last flow item touched)
#		# _check4parameter_changes(); # is only active if $userBuiltFlow->{_last_parameter_index_touched} >= 0
#			
#		 			# Here is where you rebind the different buttons depending on the
# 					# program name that is selected (i.e., through spec.pm) 
# 		$binding					->set_prog_name_sref($userBuiltFlow->{_prog_name_sref});
# 		$binding					->set_values_w_aref($param_widgets->get_values_w_aref);
# 		$binding					->setFileDialog_button_sub_ref (\&_FileDialog_button);  #reference to local subroutine
# 		$binding					->set();
#				# print("7. neutral_flow, flow_select, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
#
#    	$conditions_gui				->set4end_of_flow_select($flow_color);
#    	$conditions_gui				->set_flow_index_last_touched($index);
#    	
#    	$userBuiltFlow 				= $conditions_gui->get_hash_ref(); # now neutral_flow = 0; flow_type=user_built
#    		# print("6. neutral_flow,flow_select,flow_color: $userBuiltFlow->{_flow_color} \n");
#   		return();
#	}
#}



=head2 sub get_hash_ref 

	exports private hash 
 
=cut

 	sub get_hash_ref {
 		my ($self) 	= @_;
 				# print("neutral_flow, get_hash_ref \n");		
 		return($userBuiltFlow);

 	}

=head2 sub get_flow_color 

	exports private hash value
 
=cut

 	sub get_flow_color {
 		my ($self) 	= @_;
 		
 		if( $userBuiltFlow->{_flow_color}) {
 			my $color;
 			
 			$color = $userBuiltFlow->{_flow_color}; 
 			return($color);
 			
 		} else {
 			print("neutral_flow, missing flow color\n");
 		}

 	}


=head2 sub get_prog_name_sref 

	exports private hash value
 
=cut

 	sub get_prog_name_sref {
 		my ($self) 	= @_;
 		
 		if( $userBuiltFlow->{_prog_name_sref}) {
 			my $name;
 			
 			$name = $userBuiltFlow->{_prog_name_sref}; 
 			return($name);
 			
 		} else {
 			print("neutral_flow, missing \n");
 		}

 	}

#
#=head2 sub increase_vigil_on_delete_counter
#
#	Helps keep check of whether an item
#    is deleted from the listbox
#    during dragging and dropping    
#
#=cut
#
#sub increase_vigil_on_delete_counter {
#	my $self = @_;
#  	$flow_widgets->inc_vigil_on_delete_counter;
#	# print("neutral_flowincrease_vigil_on_delete_counter\n");
#	return();
#}
#
#
#

#
#=head2
# $userBuiltFlow>{_sub_ref} is collected 
# and is use to ryn a subroutine in main
#
#=cut
# 
# sub set_sub_ref {
# 	my ($self,$sub_ref) = @_;
# 	
# 	if ($sub_ref) {
#
# 		$userBuiltFlow->{_FileDialog_sub_ref} =  $sub_ref;
# 		
# 		my $option		= 'Data';
# 		my $option_sref	= \$option;
# 		&{$sub_ref}($option_sref);  # run a subroutine in the overlying namespace
# 		
# 		print("user_built_flow, set_sub_ref, sub_ref: $userBuiltFlow->{_FileDialog_sub_ref}\n");
# 		#print("user_built_flow, set_sub_ref, sub_ref: $user_flow_sub_ref\n");
# 		#print("pre_built_superflow, set_sub_ref, sub_ref: $superflow_sub_ref \n"); 		
# 	} else{
#		print("user_built_flow, set_sub_ref, missing sub ref\n");
# 	}
# 	
# 	return();
# }
# 


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
   	my $help = new help();  	
   	$help->set_name($userBuiltFlow->{_prog_name_sref});
   	$help->tkpod();
   	return();
}


#
#=head2 sub save_button
#
#	topic: only 'Save'
#  	for safety, place set_hash_ref first
#  	run from L_SU.pm
#  	
#   	my	$m          	= "neutral_flow, _save_button, Test,set_specs,message,$message_w\n";
# 	$message_w->delete("1.0",'end');
# 	$message_w->insert('end', $m);
#
#=cut
#
# sub save_button {
# 	my ($self, $topic) = @_;
# 		print("neutral_flow,save_button, topic: $topic\n");
# 	if ($topic eq 'Save') {  # double-check
# 		use files_LSU;
#
#		my $files_LSU			= new files_LSU();
#		
#		_check4parameter_changes();  # update changes to parameter values between 'SaveAs' and 'Save'
#		
#		# $conditions_gui				-> set_gui_widgets($userBuiltFlow);  # uses 23/  61 in
# 		# $conditions_gui				-> set_hash_ref($userBuiltFlow);     # uses 36/  61 in
#		# $conditions_gui				-> set4start_of_Save_button();		 # sets 2
#
#
#  			# print("1. neutral_flow, _save_button, B4 stored number of prgrams: $num_items\n");
#  	 	$userBuiltFlow->{_names_aref} 	= $param_flow->get_names_aref();
#  			# print("2. neutral_flow ,save_button flow_name_out $userBuiltFlow->{_flow_name_out}n");
#  			 # my $num_items 			= $param_flow->get_num_items();
#			 # print("1. neutral_flow, _save_button, B4 stored number of prgrams: $num_items\n");
#		$param_flow	->set_good_values();
#		$param_flow	->set_good_labels();
#		
#		$userBuiltFlow->{_good_labels_aref2}	= $param_flow->get_good_labels_aref2();
#		$userBuiltFlow->{_items_versions_aref}	= $param_flow->get_flow_items_version_aref();
#		$userBuiltFlow->{_good_values_aref2} 	= $param_flow->get_good_values_aref2();
#		$userBuiltFlow->{_prog_names_aref} 		= $param_flow->get_flow_prog_names_aref();
#				
# 		$files_LSU	->set_prog_param_labels_aref2($userBuiltFlow);	# uses x / 61 in
# 		$files_LSU	->set_prog_param_values_aref2($userBuiltFlow);	# uses x / 61 in
# 		$files_LSU	->set_prog_names_aref($userBuiltFlow);			# uses x / 61 in
# 		$files_LSU	->set_items_versions_aref($userBuiltFlow);		# uses x / 61 in
# 		$files_LSU	->set_data();
# 		$files_LSU	->set_message($userBuiltFlow);  				# uses 1 / 61 in
#	  	
#		$files_LSU	->set2pl($userBuiltFlow); 			# flows saved to PL_SEISMIC
#		$files_LSU	->save();
#		
##		$conditions_gui	->set4end_of_Save_button();   # use 1/
##		$userBuiltFlow 	= $conditions_gui->get_hash_ref();   # returns 78
# 			
# 	} else {			
# 			print("userBuiltFlow, missing topic Save\n");		
# 	}
# 	 return();	
# } 
#

=head2 sub sunix_select (subroutine is only active in neutral_flow)

  Pick Seismic Unix modules

  foreach my $key (sort keys %$userBuiltFlow) {
   print (" neutral_flowkey is $key, value is $userBuiltFlow->{$key}\n");
  }
  TODO: encapsulate better
  
  set
  	$param_sunix
  	$param_widgets
  	
  get
  	$userBuiltFlow_messages
  	$whereami					->set4sunix_listbox()
  	$param_widgets
  	$param_sunix
  	
  call:
    $conditions_gui			->set4start_of_sunix_select;
    $conditions_gui	->set4end_of_sunix_select() ;
     $userBuiltFlow 			= $conditions_gui->get_hash_ref();
 
=cut 

sub sunix_select {
   	my ($self) = @_;
   	
   	$userBuiltFlow->{_flow_type} = $flow_type->{_user_built}; # should be at start of neutral_flow
   	 		 # print("neutral_flow, sunix_select,parameter_values_frame: $parameter_values_frame\n"); 	
   	  	
   	use messages::message_director; 
   	use param_sunix;
   	  	
	my $userBuiltFlow_messages 	    = message_director->new();
	my $param_sunix        			= param_sunix->new();
   	
   	my $message          	= $userBuiltFlow_messages->null_button(0);
 	$message_w   			->delete("1.0",'end');
 	$message_w   			->insert('end', $message);

		                     # find out which program was previously touched
		                     # assume all prior programs touched have
		                     # modified parameters 
		                     # and update that program's stored values
	_check4flow_changes();
	
     # print("neutral_flow,1. sunix_select,flow_color: $userBuiltFlow->{_flow_color}\n"); 	
   	  	     
    $conditions_gui						    ->set_gui_widgets($userBuiltFlow);
    $conditions_gui							->set4start_of_sunix_select();
    #$userBuiltFlow->{_flow_color} 			= $conditions_gui->get_flow_color();
    my $flow_color							= $userBuiltFlow->{_flow_color};
    	# print("neutral_flow,2. sunix_select,flow_color: $flow_color\n"); 
    	# print("1. neutral_flow, sunix_select, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
   	$whereami								->set4sunix_listbox($flow_color); # purpose? needed? TODO
   	my $here 								= $whereami->get4sunix_listbox();

        # get program name
   	$userBuiltFlow->{_prog_name_sref} 				= $param_widgets->get_current_program(\$sunix_listbox);
				# print("neutral_flow sunix_select, program name is ${$userBuiltFlow->{_prog_name_sref}}\n");
   	$param_sunix   							->set_program_name($userBuiltFlow->{_prog_name_sref});
   	$userBuiltFlow->{_names_aref}  					= $param_sunix->get_names();
   	$userBuiltFlow->{_values_aref} 					= $param_sunix->get_values();
   	$userBuiltFlow->{_check_buttons_settings_aref}  = $param_sunix->get_check_buttons_settings();
   	$userBuiltFlow->{_param_sunix_first_idx}  		= $param_sunix->first_idx();
   	$param_sunix									->set_half_length(); # # values not index 
   	$userBuiltFlow->{_param_sunix_length}  			= $param_sunix->get_length(); # 
   			# print("2. neutral_flow, sunix_select, length $userBuiltFlow->{_param_sunix_length}\n");
			# $userBuiltFlow->{_param_sunix_length}  			= $param_sunix->length();

   	$param_widgets      ->set_location_in_gui($here);
   				# print("2. neutral_flow, sunix_select, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
   	   			# widgets initialized in super class	
	$param_widgets		->set_labels_w_aref($userBuiltFlow->{_labels_w_aref} );
  	$param_widgets		->set_values_w_aref($userBuiltFlow->{_values_w_aref} );
  	$param_widgets		->set_check_buttons_w_aref($userBuiltFlow->{_check_buttons_w_aref});
  	
  	$param_widgets		->gui_full_clear();
  	
  	$param_widgets		->range($userBuiltFlow);
   	$param_widgets		->set_labels($userBuiltFlow->{_names_aref}); # equiv to "labels_aref"
   	$param_widgets		->set_values($userBuiltFlow->{_values_aref});
   	$param_widgets		->set_check_buttons(
						$userBuiltFlow->{_check_buttons_settings_aref});
   	$param_widgets		->set_current_program($userBuiltFlow->{_prog_name_sref});
		# print("3. neutral_flow, sunix_select, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
						 # print("neutral_flow sunix_select, $userBuiltFlow->{_is_sunix_listbox}\n");
   	$param_widgets       ->set_location_in_gui($here);
   	$param_widgets		->redisplay_labels();
   	$param_widgets		->redisplay_values();
   	$param_widgets		->redisplay_check_buttons();

    $conditions_gui		->set4end_of_sunix_select() ;
     # print("neutral_flow,2. sunix_select,1 line after set4end_of_sunix_select\n");
    # $flow_color				= $userBuiltFlow->{_flow_color};
    # TODo are  following 1 line and past 1 line needed?
    # $userBuiltFlow 		= $conditions_gui->get_hash_ref();
    	# print("4. neutral_flow, sunix_select, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
	 # print("neutral_flow,3. sunix_select,flow_color: $flow_color\n");
   	return();
}
 
 	
1;