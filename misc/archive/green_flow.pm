package green_flow;

=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL PACKAGE NAME: green_flow.pm
 AUTHOR: 	Juan Lorenzo
 DATE: 		June 8 2018 

 DESCRIPTION 
     

 BASED ON:
 previous versions of the main userBuiltFlow.pl
  

=cut

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES
 refactoring of 2017 version of L_SU.pl

=cut 

=head2 Notes from bash
 
=cut 


	# for all
 	use Moose;
 	our $VERSION = '0.0.1';
 	
 	# potentially in all packages
#	use SeismicUnixPlTk_global_constants;			
	# for 3. BOTH
	# 1.green_flow.pm 2.built_in__flow.pm
		# drop add2flow delete_from_flow
		# sunix_select _check4change flow_select superflow_select
		# FileDialog_button FileDialog_close 
	
	use param_widgets_green;  # K
	
	# 1.green_flow.pm AND 2.built_in_flow.pm  i.e., BOTH
		# used in drag _stack_flow _stack_superflow move in stored flow stack_version
		# _change4check, check_code_button save_button
	use param_flow_green;# K
		
	# used extensively for whole-gui awareness
	use whereami;
#	
 		# for drag drop increase_vigil_on_delete_counter delete_from_flow_select
		# _move_in_stored_flows _stack_versions flow_select set_flow_index_touched
	use flow_widgets;
	use conditions_gui;
 	my $conditions_gui		= conditions_gui 	->new();
 	my $flow_widgets		= flow_widgets		->new();
 	my $get					= SeismicUnixPlTk_global_constants->new();
 	my $param_flow     		= param_flow_pink 	->new();
 			# print("grey flow, make param_flow instance in grey flow\n");
 	my $param_widgets		= param_widgets ->new();
 	my $whereami           	= whereami			->new();

 	my $flow_type			= $get->flow_type_href();

# 
#=head2
#
# share the following parameters in same name 
# space
#
# flow_listbox_grey_w  -left listbox, input by user selection
# flow_listbox_green_w  -right listbox,input by user selection
# sunix_listbox   -choice of listed sunix modules in a listbox
#
#=cut
 	my ($mw);
 	my ($parameter_values_button_frame );
 	my ($parameter_names_frame,$parameter_values_frame);
 	my ($flow_listbox_grey_w,$flow_listbox_pink_w,$flow_listbox_green_w,$flow_listbox_blue_w,$flow_listbox_color_w);
 	my ($flow_color);
 	my ($flowNsuperflow_name_w);
 	my ($dnd_token,$dropsite_token);
 	my ($labels_w_aref, $values_w_aref, $check_buttons_w_aref);
 	my ($message_w);
 	my ($sunix_listbox); 
	my ($add2flow_button_grey, $add2flow_button_pink, $add2flow_button_green, $add2flow_button_blue, $check_code_button);
	my ($delete_from_flow_button);		
 	my ($file_menubutton);
#
	my $var								= $get->var();
#	my $on         						= $var->{_on};
	my $true       						= $var->{_true};
	my $false      						= $var->{_false};
#   my $superflow_names     			= $get->superflow_names_h();	
# 
# 
#=head2 Default userBuiltFlow settings{
#
# Create scoped hash 
#     # _has_used_Save_button			=> '',
#     	# _FileDialog_option			=> '',
#	# _error 						=> '',
#	# _superflows_first_idx   		=> '',
#	# _superflows_length    			=> '',
#	#_num_good_checkbuttons_aref		=> '',
#	#_num_good_labels_aref			=> '',
#	# _num_good_values_aref			=> '',
#	# _listbox_size 					=> '',
#	# _module_name   					=> '',
#    _has_used_check_code_button		=> '',   # TODO check if needed?
#	
#	_check_buttons_settings_aref    => '',
#    _current_widget					=> '', 
#	_current_index  				=> '',
#	_current_sunix_selection_index 	=> '',
#	_entry_button_label	  			=> '',	
#	_flow_name_out					=> '',

#	_flow_widget_index				=> '',
#	_good_labels_aref2				=> '',
#	_good_values_aref2 				=> '',		
#	_prog_names_aref 				=> '', 
#	_name_aref    					=> '',
#	_names_aref    					=> '',
#	_first_index    				=> '',
#=cut
#
#	_last_flow_listbox_touched 		=> '',
#	_last_flow_listbox_touched_w 	=> '',
#	_last_path_touched				=> './',
#	_run_button						=> '',
#    _last_param    					=> '',
#    _first_param    				=> '',
#	_length    						=> '',
#	_name     						=> '',
#   _mw								=> '',
#	_open							=> '',
#	_path     						=> '',
#	_param_flow_first       		=> 0,
#	_param_flow_length        		=> '',
#	_param_sunix_first_idx      	=> 0,
#	_param_sunix_length       		=> '',
#	_parameter_value_index  		=> -1,
#	_prev_index  					=> '',
#	_prev_prog_name   				=> '',
#	_prev_ref_values_w  			=> '',
#	_ref_labels  					=> '',
#	_ref_labels_w  					=> '',
#	_prog_name     					=> '',
#	_prev_ref_labels_w  			=> '',
#	_ref_param_value_button_w          	=> '',
#	_ref_param_value_button_w_variable 	=> '',
#	_ref_values_w  					=> '',
#	_ref_values  					=> '',
#	_selected_file_name 			=> '',
#	_values_aref  					=> '',
#  	_items_values_aref2  			=> '',
#  	_items_names_aref2  			=> '',
#  	_items_checkbuttons_aref2 		=> '',
#	_is_add2flow_button	   			=> '',
#	_is_check_code_button          	=> '',
#	_is_delete_from_flow_button	   	=> '',
#    _has_used_check_code_button		=> '',
#    _has_used_SaveAs_flow_button	=> '',
#    _is_moveNdrop_in_flow			=> '',
#    _is_run_button          		=> '',
#    _is_pre_built_superflow			=> '',
#    _is_Save_button          		=> '',
#    _is_SaveAs_file_button			=> '',
#	_is_superflow_select_button		=> '',
#	_is_superflow 					=> '',
#	_is_sunix_listbox				=> '',
#	_is_pre_built_superflow			=> '', 
#	_is_green_flow				=> '',
#	_first    						=> '',
#	_last    						=> '',

=head2 private hash

	37 off 
	_is_flow_listbox_color_w is generic colored widget

=cut

my $userBuiltFlow   = { 		 		
 	_add2flow_button_grey			=> '',
 	_add2flow_button_pink			=> '',
 	_add2flow_button_green			=> '',
 	_add2flow_button_blue			=> '',
 	_check_code_button				=> '', 
 	_check_buttons_w_aref			=> '',		 		
 	_delete_from_flow_button		=> '', 
 	_destination_index	 			=> '',
 	_dnd_token						=> '', 
 	_dropsite_token					=> '', 
 	_file_menubutton				=> '',
   	_flowNsuperflow_name_w			=> '', 
 	_flow_color						=> '',
 	_flow_listbox_grey_w			=> '',
 	_flow_listbox_pink_w			=> '',  
  	_flow_listbox_green_w			=> '',
   	_flow_listbox_blue_w			=> '',
   	_flow_listbox_color_w			=> '', 
  	_flow_type						=> $flow_type->{_user_built},
  	_labels_w_aref					=> '',
  	_message_w						=> '',  
   	_mw								=> '', 
 	_parameter_names_frame  		=> '', 
 	_parameter_values_frame 		=> '', 
 	_parameter_values_button_frame	=> '', 	 
 	_sunix_listbox					=> '', 
    _index2move	    				=> '',
  	_items_versions_aref 			=> '',
	_is_flow_listbox_grey_w			=> '',
	_is_flow_listbox_pink_w			=> '',	
	_is_flow_listbox_green_w		=> '',
	_is_flow_listbox_blue_w			=> '',
	_is_flow_listbox_color_w		=> '',		
	_is_sunix_listbox				=> '',
	_last_flow_index_touched	 	=> -1,
	_prog_name_sref					=> '',
	_values_w_aref					=> '',
    };

=head2 sub set_hash_ref 

	imports external hash into private settings 
 	24 and 27 off
 	
=cut

 	sub set_hash_ref {
 		my ($self,$hash_ref) 	= @_;
 		
 		$add2flow_button_grey	= $hash_ref->{_add2flow_button_grey};
 		$add2flow_button_pink	= $hash_ref->{_add2flow_button_pink};
 		$add2flow_button_green	= $hash_ref->{_add2flow_button_green};
 		$add2flow_button_blue	= $hash_ref->{_add2flow_button_blue};
 		$check_buttons_w_aref 	= $hash_ref->{_check_buttons_w_aref};
 		$check_code_button		= $hash_ref->{_check_code_button};
 		$delete_from_flow_button= $hash_ref->{_delete_from_flow_button};
 		$dnd_token				= $hash_ref->{_dnd_token_green};# K
 		$dropsite_token			= $hash_ref->{_dropsite_token_green};# K
 	 	$file_menubutton		= $hash_ref->{_file_menubutton};
 	 	$flow_color				= $hash_ref->{_flow_color};
 	 	$flow_listbox_grey_w	= $hash_ref->{_flow_listbox_grey_w};
 	 	$flow_listbox_pink_w	= $hash_ref->{_flow_listbox_pink_w};
 	 	$flow_listbox_green_w	= $hash_ref->{_flow_listbox_green_w};
  	 	$flow_listbox_blue_w	= $hash_ref->{_flow_listbox_blue_w};
  	 	$flowNsuperflow_name_w	= $hash_ref->{_flowNsuperflow_name_w};
  		$labels_w_aref 			= $hash_ref->{_labels_w_aref};
  		$message_w				= $hash_ref->{_message_w}; 
   		$mw						= $hash_ref->{_mw};
 	 	$parameter_names_frame  = $hash_ref->{_parameter_names_frame}; 	
 	 	$parameter_values_frame = $hash_ref->{_parameter_values_frame};
 		$parameter_values_button_frame	 = $hash_ref->{_parameter_values_button_frame};
 		$sunix_listbox			= $hash_ref->{_sunix_listbox};
  		$values_w_aref 			= $hash_ref->{_values_w_aref};
 		 	 		
 		$userBuiltFlow->{_add2flow_button_grey}			= $hash_ref->{_add2flow_button_grey};
 		$userBuiltFlow->{_add2flow_button_pink}			= $hash_ref->{_add2flow_button_pink};
 		$userBuiltFlow->{_add2flow_button_green}		= $hash_ref->{_add2flow_button_green};
 		$userBuiltFlow->{_add2flow_button_blue}			= $hash_ref->{_add2flow_button_blue};
 		$userBuiltFlow->{_check_code_button}			= $hash_ref->{_check_code_button};
 		$userBuiltFlow->{_check_buttons_w_aref}	 		= $hash_ref->{_check_buttons_w_aref};
 		$userBuiltFlow->{_delete_from_flow_button}		= $hash_ref->{_delete_from_flow_button};
 		$userBuiltFlow->{_dnd_token}					= $hash_ref->{_dnd_token};
 		$userBuiltFlow->{_dropsite_token}				= $hash_ref->{_dropsite_token};
 		$userBuiltFlow->{_flow_color}					= $hash_ref->{_flow_color}; 		
 	 	$userBuiltFlow->{_file_menubutton}				= $hash_ref->{_file_menubutton};
 	 	$userBuiltFlow->{_flow_listbox_grey_w}			= $hash_ref->{_flow_listbox_grey_w};
 	 	$userBuiltFlow->{_flow_listbox_pink_w}			= $hash_ref->{_flow_listbox_pink_w};
  	 	$userBuiltFlow->{_flow_listbox_green_w}			= $hash_ref->{_flow_listbox_green_w};
 	 	$userBuiltFlow->{_flow_listbox_blue_w}			= $hash_ref->{_flow_listbox_blue_w};
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
 		
 		 # print("green_flowset_hash_ref,delete_from_flow_button: $delete_from_flow_button\n");
 		 # print("green_flowset_hash_ref,parameter_values_frame: $userBuiltFlow->{_parameter_values_frame}\n");
 		 # print("1. green_flowset_hash_ref,_message_w: $userBuiltFlow->{_message_w}\n");
 		 # print("green_flowset_hash_ref,parameter_values_frame: $parameter_values_frame\n"); 	
 		 # print("green_flowset_hash_ref,add2flow_button_grey,$add2flow_button_grey	\n");
 		 # print("green_flow,set_hash_ref,userBuiltFlow->{_flow_color}: $userBuiltFlow->{_flow_color}	\n");
 		 # print("green_flowset_hash_ref,delete_from_flow_button: $delete_from_flow_button\n");
 		 # print("green_flow,set_hash_ref,flow_color: $flow_color\n");
 		return();
 	}

=head2 sub get_hash_ref 

	exports private hash 
 
=cut

 	sub get_hash_ref {
 		my ($self) 	= @_;
 				# print("green_flow, get_hash_ref \n");		
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
 			print("green_flow, missing flow color\n");
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
 			print("green_flow, missing \n");
 		}

 	}


=head2 sub drag

  Drag and Drop do not delete 
  the program name from param_flow stored data
  when the program name disappears from the GUI

  User must delete the item and its parameters
  from stored memory after the Drop, i.e.
  When  
  (1) Drag is selected a second time or
  (2) when any other button in the GUI is selected
 
  print("drag,check $check\n");

  check if previous index was deleted by DnD 
  if so they delete that program 
  delete the stored parameter entries via param_flow.pm
  delete stored parameter values, names and checkbuttons
  also make sure that you can not drag if there is only one item left
  
  TODO: encapsulate and refactor
  gets from :
  	$userBuiltFlow
  	$flow_widgets
  	
  sets to:
  	$param_flow
  	$flow_widgets
  	
  calls: _stack_versions
  o/p need
	
=cut

sub drag {
  	my ($self) = @_;   
					# print("1. green_flowdrag;just starting\n");
					# print("1. green_flowdrag;listbox can not be empty\n");
					# print("1. green_flowdrag;more than one item must exist\n");
  my $prog_name;
  if($userBuiltFlow->{_prog_name_sref}) {
	$prog_name					= ${$userBuiltFlow->{_prog_name_sref}};
	# print("1. green_flowdrag,prog=$prog_name\n");
   }
   
			# was a program deleted through a previous dragNdrop? 
			# Has a program name even been selected or is user just playing aimlessly? # K
 	if( $prog_name && $flow_widgets->is_drag_deleted($flow_listbox_green_w) ) {

			print("2.green_flowdrag; prior index was deleted\n"); # K 
        my $this_index = $flow_widgets->get_drag_deleted_index($flow_listbox_green_w);

			print("green_flowdrag,deleting flow_listbox,idx=$this_index\n");
    	print("index $this_index was just removed from widget\n");

						# delete stored values from param_flow
    	$param_flow->delete_selection($this_index); 

						# update program versions if listbox changes
						# store via param_flows
    	_stack_versions();
		$flow_widgets->set_vigil_on_delete();
  	}						  
						# in case a previous drag updated the 
						# vigil_on_delete counter
						# reset drag and drop vigil_on_delete counter 
	#$flow_widgets->set_vigil_on_delete();
	
	my $num_items = $flow_widgets->get_num_items($flow_listbox_green_w);  # K
  						# print("green_flowdrag,num items prior to deletion  = $num_items\n");

  	if ( $num_items > 1 ) {  # num_items PRIOR to deletion
   	   $flow_widgets->drag_start($dnd_token);
	    				# print("green_flowdrag,start dnd_token:$dnd_token\n");
  	} else {
						# print("WARNING: green_flowdrag,not allowed\n");
  	}						 
}


=head2 sub drop

   Item is successfully moved from one part of the flow
   listbox to another part of the same listbox
   
   drop does not occur if the user drags the item out of
   the listbox area
   
	
	$whereami					->set4moveNdrop_in_flow();
	my $here 					= $whereami->get4moveNdrop_in_flow();
	$param_widgets				->set_location_in_gui($here);

    print("drop,confirm done\n");
    
	make param_widgets not detect any entry changes
	This IS needed for sub flow_select also not to sense previous changes
	or else the stored parameters in the flow will not be correct
   	$param_widgets->set_entry_change_status($false);
   	
   	TODO: Refactoring
   	Encapsulation is poor:
   		gets from:
   			$userBuiltFlow
   			$flow_widgets
   			$flow_listbox_color_w  	
   	
   	 	sets:
   	 		$userBuiltFlow
   			$flow_listbox_color_w
   			$flow_widgets

	calls external _stack_versions
	calls external _move_in_stored_flows
	
	happens inside a Listbox only
	
=cut

sub drop {
   my ($self) 						= @_;   
   my $done;
   my $chosen_index_to_drop 		= $flow_widgets->drag_end($dnd_token);
   my $prog_name;
   
   # listbox must have at least one item
   if($userBuiltFlow->{_prog_name_sref}) {
	$prog_name					= ${$userBuiltFlow->{_prog_name_sref}};
	# print("1. green_flowdrop,prog=$prog_name\n");
   }

   if ($prog_name && $chosen_index_to_drop && $chosen_index_to_drop>=0  ) {   # same as destination_index
   
   	 # print("2. green_flowdrop,prog=$prog_name\n");
   
	        			# if insertion occurs within the listbox
	 $userBuiltFlow->{_index2move} 			= $flow_widgets->index2move();
     $userBuiltFlow->{_destination_index} 	= $flow_widgets->destination_index;

							# note the last program that was touched
    						 $userBuiltFlow->{_last_flow_index_touched} 	= $userBuiltFlow->{_destination_index} ;
							 	# print(" green_flowdrop, destination index = $userBuiltFlow->{_last_flow_index_touched}\n");

			    # move stored data in agreement with this drop 
	 _move_in_stored_flows(); 
				# update program versions if listbox changes
				# stored in param_flows
     _stack_versions();
							 # If there is no delete while dragging
							 # the counter is also increased, so 
							 # reset drag and drop vigil_on_delete counter 
							 # this is a bug in the DragandDrop package
  							 
	$flow_widgets->set_vigil_on_delete();
	 		 				# print(" drop, done is $done\n");
	$flow_widgets->dec_vigil_on_delete_counter(2);
							# highlight new index  # K
    $flow_listbox_green_w    			->selectionSet(
                       			  $userBuiltFlow->{_destination_index}, 
	               			  );
   }
}

=head2 sub increase_vigil_on_delete_counter

	Helps keep check of whether an item
    is deleted from the listbox
    during dragging and dropping    

=cut

sub increase_vigil_on_delete_counter {
	my $self = @_;
  	$flow_widgets->inc_vigil_on_delete_counter;
	# print("green_flowincrease_vigil_on_delete_counter\n");
	return();
}


=head2 sub _set_flow_listbox_color_w


=cut 

 sub _set_flow_listbox_color_w {
	my ($flow_color)   = @_;
		
	if ($flow_color eq 'grey') {
		$userBuiltFlow->{_flow_listbox_color_w} =  $userBuiltFlow->{_flow_listbox_grey_w};
			#print("green_flow,_set_flow_listbox_color_w, _set_flow_listbox_color_w, color is $flow_color\n");
		
	} elsif ($flow_color eq 'pink')  {
		$userBuiltFlow->{_flow_listbox_color_w} = $userBuiltFlow->{_flow_listbox_pink_w};
			#print("green_flow,_set_flow_listbox_color_w, _set_flow_listbox_color_w, color is $flow_color\n");		
	} elsif ($flow_color eq 'green') {
		$userBuiltFlow->{_flow_listbox_color_w} =  $userBuiltFlow->{_flow_listbox_green_w};
			#print("green_flow,_set_flow_listbox_color_w, _set_flow_listbox_color_w, color is $flow_color\n");		
	} elsif ($flow_color eq 'blue')  {
		$userBuiltFlow->{_flow_listbox_color_w} =  $userBuiltFlow->{_flow_listbox_blue_w};
			#print("green_flow,set_flow_listbox_color_w, _set_flow_listbox_color_w, color is $flow_color\n");		
	} else {
		print("green_flow,_set_flow_listbox_color_w, _set_flow_listbox_color_w, missing color\n");
	}
    
	return();
 }


=head2 sub add2flow_button


  		foreach my $key (sort keys %$userBuiltFlow) {
   			print (" green_flow key is $key, value is $userBuiltFlow->{$key}\n");
  		}

=cut

sub add2flow_button {
	
	my ($self,$value)  = @_;

	$userBuiltFlow->{_flow_type} = $flow_type->{_user_built};
	 	# print("1. green_flow, add2flow_button, color: $flow_color \n");
	 	# print("1. green_flow, add2flow_button, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
	
 	use messages::message_director;
 	use param_sunix;
 	
 	my $param_sunix        		= param_sunix->new();
	my $userBuiltFlow_messages 	= message_director->new();
  	my $message          		= $userBuiltFlow_messages->null_button(0);
  	
  	my $last_item;
  	my $here;
  	    #print("1. green_flow, add2flow_button, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
  	$conditions_gui				-> set_gui_widgets($userBuiltFlow);
 	$conditions_gui				-> set_hash_ref($userBuiltFlow);
	$conditions_gui				-> set4start_of_add2flow_button($flow_color);
	 	# print("2. green_flow, add2flow_button, color: $flow_color \n"); 	
 	$message_w   				->delete("1.0",'end');
 	$message_w   				->insert('end', $message);	

   	$whereami					->set4flow_listbox($flow_color);
   	
			# 
       		# clear all the indices of selected elements   
   	$sunix_listbox->selectionClear($sunix_listbox->curselection);
    # print("3. green_flow, add2flow_button, _prog_name_sref: ${$userBuiltFlow->{_prog_name_sref}}\n"); 
    # print("2. green_flow, add2flow_button, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
			# add the most recently selected program
			# name (scalar reference) to the 
			# end of the list indside flow_listbox 
    _set_flow_listbox_color_w($flow_color);
   			# print("green_flow,add2flow_button,userBuiltFlow->listbox_widget: $userBuiltFlow->{_flow_listbox_color_w}\n");
   	$userBuiltFlow->{_flow_listbox_color_w} ->insert(
                       	"end", 
                       	${$userBuiltFlow->{_prog_name_sref}},
	               );
	  		#print("3. green_flow, add2flow_button, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
	  		#print("3. green_flow, add2flow_button, _labels_w_aref $userBuiltFlow->{_labels_w_aref}\n");
   				# display default paramters in the GUI
    			# same as for sunix_select
    			# can not get program name from the item selected in the sunix list box 
    			# because focus is transferred to another list box   
   
   	$param_sunix   									->set_program_name($userBuiltFlow->{_prog_name_sref});
   	$userBuiltFlow->{_names_aref}  					= $param_sunix->get_names();
   	$userBuiltFlow->{_values_aref} 					= $param_sunix->get_values();
   	$userBuiltFlow->{_check_buttons_settings_aref}  = $param_sunix->get_check_buttons_settings();
   	$userBuiltFlow->{_param_sunix_first_idx}  		= $param_sunix->first_idx(); # first index = 0
   	$userBuiltFlow->{_param_sunix_length}  			= $param_sunix->length(); # # values not index 
	 	# print("4. green_flow, add2flow_button, color: $flow_color \n"); 
   	$whereami			->set4add2flow_button();
   		 	# print("5. green_flow, add2flow_button, color: $flow_color \n");
   	$here                = $whereami->get4add2flow_button();
   	$param_widgets       ->set_location_in_gui($here);
	
		# widgets initialized in super class	
	$param_widgets		->set_labels_w_aref($userBuiltFlow->{_labels_w_aref} );
  	$param_widgets		->set_values_w_aref($userBuiltFlow->{_values_w_aref} );
  	$param_widgets		->set_check_buttons_w_aref($userBuiltFlow->{_check_buttons_w_aref} );
  	
  	print("2. green_flow, add2flow_button, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
   	$param_widgets		->range($userBuiltFlow);
   	$param_widgets		->set_labels($userBuiltFlow->{_names_aref});
   	$param_widgets		->set_values($userBuiltFlow->{_values_aref});
   	$param_widgets		->set_check_buttons(
					$userBuiltFlow->{_check_buttons_settings_aref});
   	$param_widgets		->redisplay_labels();
   	$param_widgets		->redisplay_values();
   	  		 	# print("5. green_flow, add2flow_button, color: $flow_color \n");
   	$param_widgets		->redisplay_check_buttons();
   		  	# print("3. green_flow, add2flow_button, _labels_w_aref $userBuiltFlow->{_labels_w_aref}\n");
	  		# print("4.  green_flow, add2flow_button, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
   				# collect,store prog versions changed in list box
   _stack_versions();
   	
   				# add a single_program to the growing stack
				# store one program name, its associated parameters and their values
				# as well as the ckecbuttons in another namespace

   	_stack_flow();
	  		# print("5. green_flow, add2flow_button, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");   	
   	
   	$conditions_gui			-> set_gui_widgets($userBuiltFlow); # includes _values_w_aref
 	$conditions_gui			-> set_hash_ref($userBuiltFlow);
	$conditions_gui    		-> set4end_of_add2flow_button($flow_color);
	my $index 				= $flow_widgets->get_flow_selection($userBuiltFlow->{_flow_listbox_color_w});
							# print("green_flowadd2flow_button,last left flow program touched had index: $index\n");
											# print("66. green_flow, add2flow_button, color: $flow_color \n");
	$conditions_gui			-> set_flow_index_last_touched($index); # flow color is not reset
	$userBuiltFlow 			=  $conditions_gui->get_hash_ref();
				# print("66. green_flow, add2flow_button, color: $flow_color \n");
	   			# print("2. green_flow,add2flow_button,userBuiltFlow->listbox_widget: $userBuiltFlow->{_flow_listbox_color_w}\n");
		  		print("6. green_flow, add2flow_button, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
	flow_select();
	
   			# print("3. green_flow,add2flow_button,userBuiltFlow->listbox_widget: $userBuiltFlow->{_flow_listbox_color_w}\n");
					 # print("user_builtFlow,add2flow_button,last left flow program touched had index: $userBuiltFlow->{_last_flow_index_touched}\n");
													
   	return(); 
}


=head2 sub _stack_flow

  store an initial version of the parameters in another namespace for
  manipulation by the user
  the initial version comes from default parameter files
  Using the same code as for sunix_select
  print("green_flow_stack_flow,last left listbox flow program touched had index = $userBuiltFlow->{_last_flow_index_touched}\n");
  print("green_flow_stack_flow,values= @{$userBuiltFlow->{_values_aref}}\n");
  
=cut


sub _stack_flow {
  my( $self) = @_;
    	print("1. green_flow, _stack_flow, B4 num_items\n");
  		my $num_items = $param_flow->get_num_items();
  		# print("green_flow,_stack_flow,userBuiltFlow->listbox_widget: $userBuiltFlow->{_flow_listbox_color_w}\n");

  		# print("green_flow, _stack_flow, color: $flow_color \n");
  $param_flow		->stack_flow_item($userBuiltFlow->{_prog_name_sref});
  $param_flow		->stack_values_aref2($userBuiltFlow->{_values_aref});
  $param_flow		->stack_names_aref2($userBuiltFlow->{_names_aref});
  $param_flow		->stack_checkbuttons_aref2($userBuiltFlow->{_check_buttons_settings_aref});	
  

  		$num_items = $param_flow->get_num_items;
	    print("2. green_flow, _stack_flow, After num_items: $num_items\n");			 
						
  return();
}


=head2 sub delete_from_flow_button
   	 	
   	 	TODO: Encapsulate better
 set:
     $decisions
 
 
 get:
     $userBuiltFlow_messages
     $flow_widgets
     $param_flow	
 
 call:
    _stack_versions();	
	$conditions_gui->set4last_delete_from_flow_button();
    $conditions_gui->set4delete_from_flow_button();
  $userBuiltFlow 			= $conditions_gui->get_hash_ref();
  
  		
  		foreach my $key (sort keys %$userBuiltFlow) {
   			print (" green_flowkey is $key, value is $userBuiltFlow->{$key}\n");
  		}
    
=cut

sub delete_from_flow_button {

	my $self = @_;
	
	 	# if flow_select was last pushed then conditions_gui conserved the flow color chosen:	
 	my $flow_color			= $conditions_gui->get_flow_color();
 		# print("1. green_flow,delete_from_flow_button, flow_color: $flow_color \n");
 	
 	if ($flow_color)  {
 		_set_flow_color($flow_color);
 					# print("2. green_flow,delete_from_flow_button, flow_color: $userBuiltFlow->{_flow_color} \n");
		use messages::message_director;
		use decisions 1.00;
	
		my $userBuiltFlow_messages 	    = message_director->new();
		my $decisions			= decisions->new();

		my $message          	= $userBuiltFlow_messages->null_button(0);
 		$message_w   			->delete("1.0",'end');
 		$message_w   			->insert('end', $message);
	
 		my $flow_listbox_color_w = _get_flow_listbox_color_w();
					# print("1. green_flow,delete_from_flow_button, flow_listbox_color_w: $flow_listbox_color_w \n");
		$userBuiltFlow 			= $conditions_gui->get_hash_ref(); # find out if delete button is active
					# print("1. green_flow,delete_from_flow_button , is_flow_listbox_grey pink green or blue_w: $userBuiltFlow->{_is_flow_listbox_color_w} \n");
		$decisions				->set4delete_from_flow_button($userBuiltFlow);
		my $pre_req_ok 			= $decisions->get4delete_from_flow_button();
					# confirm listboxes are active
					# print("1. green_flow,delete_from_flow_button pre_req $pre_req_ok\n");
  		if ($pre_req_ok) {
					 # print("2. green_flowdelete_from_flow_button pre_req_ok\n");
   
  			$whereami			->set4delete_from_flow_button();
  			my $here 			= $whereami->get4delete_from_flow_button();

        			# location within GUI on first clicking delete button
        	$conditions_gui		->set_hash_ref($userBuiltFlow);
			$conditions_gui		->set_gui_widgets($userBuiltFlow);
        	$conditions_gui		->set4start_of_delete_from_flow_button($flow_color);
 			$userBuiltFlow 		= $conditions_gui->get_hash_ref();

			my $index = $flow_widgets->get_flow_selection($flow_listbox_color_w);
						# when LAST ITEM in listbox is deleted 
			if ($index == 0 && $param_flow->get_num_items == 1) {

      				 # print("last item deleted Shut down delete button\n");
      				 #  Run and Save button
     			$flow_widgets->delete_selection($flow_listbox_color_w);

							# the last program that was touched is cancelled out
   				$userBuiltFlow->{_last_flow_index_touched} 	= -1;

							#  print("green_flowdelete_from_flow_button,
							#  last left flow program touched had index 
							#  = $userBuiltFlow->{_last_flow_index_touched}\n");

							# delete stored programs and their parameters
   							# delete_from_stored_flows(); 
  				my $index2delete 	= $flow_widgets->get_index2delete();
  					 		# print("green_flowdelete_from_stored,index2delete:$index2delete\n");
  					 
  				$param_flow		->delete_selection($index2delete);

   							# collect and store latest program versions from changed list 
   				_stack_versions();
			
				$conditions_gui	->set4last_delete_from_flow_button();
 				$userBuiltFlow 	= $conditions_gui->get_hash_ref();

        					# location within GUI after last item is deleted 
        		$conditions_gui	->reset();
  				$userBuiltFlow 	= $conditions_gui->get_hash_ref();
  			
				$decisions       ->reset();

							# Blank out all the widget parameter names 
							# and their values
							
				$whereami			->set4delete_from_flow_button();
        		$here				= $whereami->get4delete_from_flow_button();
   				$param_widgets      ->set_location_in_gui($here);
   				$param_widgets		->gui_clean();
        
   			} elsif ($index >= 0) { #  i.e., more than one item remains in a listbox	
			
							# note the last program that was touched
							 $userBuiltFlow->{_last_flow_index_touched} = $index;

					   		# print("green_flow_delete_from_flow_button, last index touched :$index..\n");
     			$flow_widgets->delete_selection($flow_listbox_color_w);

					# delete stored programs and their parameters
   					# delete_from_stored_flows(); 
  				my $index2delete 	= $flow_widgets->get_index2delete();
  					 		#print("2. green_flowdelete_from_stored,index2delete:$index2delete\n");
  				$param_flow		->delete_selection($index2delete);

					# update the widget parameter names and values
					# to those of new selection after deletion
  					# the chkbuttons, values and names of only the last program used 
  					# are stored in param_widgets at any one time			
  					# get parameters from storage
  				my $next_idx_selected_after_deletion = $index2delete - 1;	
            	if($next_idx_selected_after_deletion == -1) { $next_idx_selected_after_deletion = 0} # NOT < 0
  					  		# print("2. green_flowdelete_from_flow_button,indexafter_deletion:
  					  		# $next_idx_selected_after_deletion\n");

   		 		$param_flow		-> set_flow_index($next_idx_selected_after_deletion);
 				$userBuiltFlow->{_names_aref} 	= $param_flow->get_names_aref();

  							 # print("2. green_flow delete_from_flow_button,parameter names 
  							 # is @{$userBuiltFlow->{_names_aref}}\n");
 				$userBuiltFlow->{_values_aref} 	=	$param_flow->get_values_aref();

  				 			 # print("3. green_flow delete_from_flow_button,parameter values 
  				 			 # is @{$userBuiltFlow->{_values_aref}}\n");
 				$userBuiltFlow->{_check_buttons_settings_aref} 
										=  $param_flow->get_check_buttons_settings();

  				 			 # print("4. green_flow delete_from_flow_button, 
  				 			 # check_buttons_settings no changes, 
  				 			 # @{$userBuiltFlow->{_check_buttons_settings_aref}}, index;$index\n#");
  				 			
 				 			# get stored first index and num of items 
 				$userBuiltFlow->{_param_flow_first_idx}	= $param_flow->first_idx();
 				$userBuiltFlow->{_param_flow_length}   	= $param_flow->length();
 				$userBuiltFlow->{_prog_name_sref}		= $param_widgets->get_current_program(\$flow_listbox_color_w);
 				$param_widgets				 	->set_current_program($userBuiltFlow->{_prog_name_sref});
				$whereami						->set4flow_listbox($flow_color);
				$here 							= $whereami->get4flow_listbox();
				 			 # print("green_flow delete_from_flow_button, $here->{_is_flow_listbox_color_w}\n");
				 			 
	    		$param_widgets      		->set_location_in_gui($here);
   				$param_widgets				->gui_clean();
  				$param_widgets				->range($userBuiltFlow);
 				$param_widgets				->set_labels($userBuiltFlow->{_names_aref});
 				$param_widgets				->set_values($userBuiltFlow->{_values_aref});
 				$param_widgets				->set_check_buttons(
									$userBuiltFlow->{_check_buttons_settings_aref});

					  		 # print("green_flow, delete_from_flow_button, is listbox selected:$here->{_is_flow_listbox_color_w}\n");
 				$param_widgets				->redisplay_labels();
 				$param_widgets				->redisplay_values();
 					$param_widgets			->redisplay_check_buttons();
	#  			$param_widgets				->set_entry_change_status($false);	

							# note the last program that was touched
			 	$userBuiltFlow->{_last_flow_index_touched} = $next_idx_selected_after_deletion;

   					# collect and store latest program versions from changed list 
   				_stack_versions();
   			}
  		} # if pre_req_ok	
		
 	} else { # if flow_color
 		print("green_flow, delete_from_flow_button, flow color missing: \n");
 	}
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
   	my $help = new help();  	
   	$help->set_name($userBuiltFlow->{_prog_name_sref});
   	$help->tkpod();
   	return();
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
   			 # print("green_flow_move_in_stored_flows,start index is the $start\n");
   			 # print("green_flow_move_in_stored_flows, insertion index is $end \n");

   	$param_flow	->set_insert_start($start);
   	$param_flow	->set_insert_end($end);
   	$param_flow	->insert_selection(); 
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
		print("green_flow, _get_flow_listbox_color_w, neutral color\n");
	} else {
		print("green_flow, _get_flow_listbox_color_w, missing color\n");
		
	}
    
	return($correct_flow_listbox_color_w);
 }



=head2 sub _set_flow_color


=cut 

 sub _set_flow_color {
	my ($flow_color)   = @_;
	
	if ($flow_color) {
		# print("green_flow _set_flow_color , color:$flow_color\n");
		$userBuiltFlow->{_flow_color}  			 = $flow_color;
		
	} else  {
	 	print("green_flow, set_flow_color, missing color\n");
	}
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
	   			print("green_flow, _stack_versions ,userBuiltFlow->listbox_widget: $flow_listbox_color_w\n");
    $flow_widgets						->set_flow_items($flow_listbox_color_w );
    $userBuiltFlow->{_items_versions_aref} 	= $flow_widgets->items_versions_aref;
    $param_flow						->set_flow_items_version_aref($userBuiltFlow->{_items_versions_aref});
 			 # print("_stack_versions,items_versions_aref: @{$userBuiltFlow->{_items_versions_aref}}\n");
}



=head2 sub sunix_select

  Pick Seismic Unix modules

  foreach my $key (sort keys %$userBuiltFlow) {
   print (" green_flowkey is $key, value is $userBuiltFlow->{$key}\n");
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

#sub sunix_select {
#   	my ($self) = @_;
#   	
#   	$userBuiltFlow->{_flow_type} = $flow_type->{_user_built}; # should be at start of green_flow
#   	 		 print("green_flow, sunix_select,parameter_values_frame: $parameter_values_frame\n"); 	
#   	  	
#   	use messages::message_director; 
#   	use param_sunix;
#   	  	
#	my $userBuiltFlow_messages 	    = message_director->new();
#	my $param_sunix        			= param_sunix->new();
#   	
#   	my $message          	= $userBuiltFlow_messages->null_button(0);
# 	$message_w   			->delete("1.0",'end');
# 	$message_w   			->insert('end', $message);
#
#		                     # find out which program was previously touched
#		                     # assume all prior programs touched have
#		                     # modified parameters 
#		                     # and update that program's stored values
#	_check4changes();
#	
#     # print("green_flow,1. sunix_select,flow_color: $userBuiltFlow->{_flow_color}\n"); 	
#   	  	     
#    $conditions_gui						    ->set_gui_widgets($userBuiltFlow);
#    $conditions_gui							->set4start_of_sunix_select();
#    #$userBuiltFlow->{_flow_color} 			= $conditions_gui->get_flow_color();
#    my $flow_color							= $userBuiltFlow->{_flow_color};
#    	print("green_flow,2. sunix_select,flow_color: $flow_color\n"); 
#    	# print("1. green_flow, sunix_select, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
#   	$whereami								->set4sunix_listbox($flow_color);
#   	my $here 								= $whereami->get4sunix_listbox();
#
#        # get program name
#   	$userBuiltFlow->{_prog_name_sref} 					= $param_widgets->get_current_program(\$sunix_listbox);
#				print("green_flow sunix_select, program name is ${$userBuiltFlow->{_prog_name_sref}}\n");
#   	$param_sunix   							->set_program_name($userBuiltFlow->{_prog_name_sref});
#   	$userBuiltFlow->{_names_aref}  					= $param_sunix->get_names();
#   	$userBuiltFlow->{_values_aref} 					= $param_sunix->get_values();
#   	$userBuiltFlow->{_check_buttons_settings_aref}  = $param_sunix->get_check_buttons_settings();
#   	$userBuiltFlow->{_param_sunix_first_idx}  		= $param_sunix->first_idx();
#   	$userBuiltFlow->{_param_sunix_length}  			= $param_sunix->length();
#
#   	$param_widgets      ->set_location_in_gui($here);
#   				# print("2. green_flow, sunix_select, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
#   	   			# widgets initialized in super class	
#	#$param_widgets		->set_labels_w_aref($userBuiltFlow->{_labels_w_aref} );
#  	#$param_widgets		->set_values_w_aref($userBuiltFlow->{_values_w_aref} );
#  	#$param_widgets		->set_check_buttons_w_aref($userBuiltFlow->{_check_buttons_w_aref});
#  	
#  	$param_widgets		->gui_clean();
#  	
#  	$param_widgets		->range($userBuiltFlow);
#
#   	$param_widgets		->set_labels($userBuiltFlow->{_names_aref});
#   	$param_widgets		->set_values($userBuiltFlow->{_values_aref});
#   	$param_widgets		->set_check_buttons(
#						$userBuiltFlow->{_check_buttons_settings_aref});
#   	$param_widgets		->set_current_program($userBuiltFlow->{_prog_name_sref});
#		# print("3. green_flow, sunix_select, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
#						 # print("green_flow sunix_select, $userBuiltFlow->{_is_sunix_listbox}\n");
#   	$param_widgets       ->set_location_in_gui($here);
#   	$param_widgets		->redisplay_labels();
#   	$param_widgets		->redisplay_values();
#   	$param_widgets		->redisplay_check_buttons();
#
#    $conditions_gui		->set4end_of_sunix_select() ;
#     # print("green_flow,2. sunix_select,1 line after set4end_of_sunix_select\n");
#    # $flow_color				= $userBuiltFlow->{_flow_color};
#    # TODo are  following 1 line and past 1 line needed?
#    # $userBuiltFlow 		= $conditions_gui->get_hash_ref();
#    	# print("4. green_flow, sunix_select, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
#	 # print("green_flow,3. sunix_select,flow_color: $flow_color\n");
#   	return();
#}

=head2  _check4changes

	assume now that selection of a flow item will always change a previously existing
	set of flow parameters, That is, a prior program must have been touched
	if ($param_widgets->get_entry_change_status && $userBuiltFlow->{_last_flow_index_touched} >= 0) {		
    	  foreach my $key (sort keys %$userBuiltFlow) {
           print (" green_flowkey is $key, value is $userBuiltFlow->{$key}\n");
           used only by flow_select and sunix_select
          }
=cut 

sub _check4changes {
	my $self = @_;	
	
		# print("green_flow check4changes: _last_flow_index_touched $userBuiltFlow->{_last_flow_index_touched}\n");

	if ($userBuiltFlow->{_last_flow_index_touched} >= 0) {  # <-1 does exist and means the flow was not touched

		my $last_idx_chng =$userBuiltFlow->{_last_flow_index_touched} ;

	 					      #  print("green_flow_check4changes,
	 					      # last changed entry index was $last_idx_chng\n");
  							  # print("green_flow _check4changes program name is 
  							  # ${$userBuiltFlow->{_prog_name_sref}}\n");
  							  # the chekbuttons, values and names of only the last program used 
  							  # is stored in param_widgets at any one time			
		$userBuiltFlow->{_values_aref} 					= $param_widgets	->get_values_aref();
		$userBuiltFlow->{_names_aref} 					= $param_widgets	->get_labels_aref();
		$userBuiltFlow->{_check_buttons_settings_aref}	= $param_widgets	->get_check_buttons_aref();

  							#print("green_flowflow_select,changed values_aref: @{$userBuiltFlow->{_values_aref}}\n");
  							#print("green_flow_changes4changes,changed names_aref: @{$userBuiltFlow->{_names_aref}}\n");
  							#print(" green_flowflow_select,changes, check_buttons_settings_aref: @{$userBuiltFlow->{_check_buttons_settings_aref}}\n");
  							#
   		 $param_flow	-> set_flow_index($last_idx_chng);
  						 	     print("green_flow check4change ,store changes in param_flow, last changed entry index $last_idx_chng\n");
  						 	    
								# save old changed values
		 $param_flow	->set_values_aref($userBuiltFlow->{_values_aref}); 		# but not the versions
	 	 $param_flow	->set_names_aref($userBuiltFlow->{_names_aref}); 		# but not the versions
		 $param_flow	->set_check_buttons_settings_aref($userBuiltFlow->{_check_buttons_settings_aref}); # BUT not the versions

		 $param_widgets	->set_entry_change_status($false);  # changes are now complete
	 	 						 # print("green_flow flow_select, set_entry_change_status: to 0\n");
	}  						

	return();
 }


=head2 sub flow_select

  Pick a Seismic Unix module
  from within a flow listbox
  This module was placed there previously by user
  When there is only one item left in the
  listbox drag and drop becomes blocked
  N.B. I assume that _check4changes will prove false in this case
  check whether any programs were deleted by dragging previously
  If so, delete stored values from param_flow
  N.B. I assume that _check4changes will prove false in this case
  
  if($userBuiltFlow->{_prog_name_sref}) {
 		print("\n1. green_flow flow_select, program name is $userBuiltFlow->{_prog_name_sref}\n");
 	}

  TODO: Encapsulation is poor:
  	gets from:
    	flow_widgets
    	param_widgets
  
  	sets 
   		param_flow
  		param_widgets
    userBuiltFlow

 	calls
 	  	_stack_versions
  		_check4changes();
 		$conditions_gui->set4start_of_flow_select(); 
  		$conditions_gui->set4end_of_flow_select();
  	 $userBuiltFlow 			= $conditions_gui->get_hash_ref();
  	 
    	  foreach my $key (sort keys %$userBuiltFlow) {
           print (" green_flowkey is $key, value is $userBuiltFlow->{$key}\n");
          }
    	     	 
  	always takes focus on first entry 
  	TODO: via conditions package
    	  foreach my $key (sort keys %$userBuiltFlow) {
           print ("green_flow, key is $key, value is $userBuiltFlow->{$key}\n");
          }	  
  	
=cut

sub flow_select {
	my ($self) = @_;
	
	use messages::message_director;
	use decisions;  
	
	my $userBuiltFlow_messages 	= message_director->new();
	my $decisions				= decisions->new();
	
    $userBuiltFlow->{_flow_type} = $flow_type->{_user_built}; 
			print("1. green_flow, flow_select, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
	my $message          		= $userBuiltFlow_messages->null_button(0);
 	$message_w   				->delete("1.0",'end');
 	$message_w   				->insert('end', $message);
 				print("green_flow, flow_select,flow color: $flow_color \n");
  	$conditions_gui				-> set_gui_widgets($userBuiltFlow);
 	$conditions_gui				-> set_hash_ref($userBuiltFlow);
	$conditions_gui				-> set4start_of_flow_select($flow_color);
	
	_set_flow_listbox_color_w($flow_color); # update the flow color as per add2flow_select
	
	my $flow_listbox_color_w 	= _get_flow_listbox_color_w();
				#  independently set conditions to make both flow boxes available

 	$userBuiltFlow 				= $conditions_gui->get_hash_ref();
 	my $flow_color				= $userBuiltFlow ->{_flow_color};  # TODO: careful, color is re-assigned from conditions_gui,few lines up
 				# print("green_flow, flow_select,_last_flow_listbox_touched_w: $userBuiltFlow->{_last_flow_listbox_touched_w} \n");
 		
    $userBuiltFlow->{_prog_name_sref} 		= $flow_widgets->get_current_program(\$flow_listbox_color_w);	  
	$decisions		 		 				->set4flow_select($userBuiltFlow);
			# print("2. green_flow, flow_select, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");	
	my $pre_req_ok 	  						= $decisions->get4flow_select();
				# print ("green_flow, flow_select, pre_req_ok: $pre_req_ok\n");
	
	if ($pre_req_ok) {
		use binding;
 		my $binding 			 = binding -> new;  # or set_superflow_bindings();
		my $here;

      						# selected program name
 		$userBuiltFlow->{_prog_name_sref} 	= $flow_widgets->get_current_program(\$flow_listbox_color_w);
 				 # print ("green_flow, flow_color: $flow_color\n");		
							# Is a program deleted through a previous dragNdrop?
  		if( $flow_widgets->is_drag_deleted($flow_listbox_color_w) ) {

			  				 # print("\n\ngreen_flowflow_select,something was deleted in previous dragNdrop\n");
        	my $this_index 		= $flow_widgets->get_drag_deleted_index($flow_listbox_color_w);
							 # print("green_flowflow_select,deleting flow_listbox,idx=$thi# s_index\n");
							 # 
     						 # print("index (old) $this_index was just removed from widget\n");

							# delete stored values from param_flow
     		$param_flow->delete_selection($this_index); 

							# update program versions if listbox changes
							# store via param_flows
     		_stack_versions(); 
     						# reset drag and drop vigil_on_delete counter
			$flow_widgets->set_vigil_on_delete();
			
		}
				# print("3. green_flow, flow_select, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
		                     # find out which program was previously touched
		                     # assume all prior programs touched have
		                     # modified parameters 
		                     # and update that program's stored values	
		_check4changes();
				# print("4 green_flow, flow_select, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");                     
		                    # for just-selected program name
							# get its flow parameters from storage
							# and redisplay the widgets with parameters 
   		my $index 							= $flow_widgets->get_flow_selection($flow_listbox_color_w);
 				# print("green_flow, flow_select,_flow_listbox_color_w: $userBuiltFlow->{_flow_listbox_color_w} \n");
  							# print("2. green_flow, flow_select,index is $index\n");
  							my $num_items = $param_flow->get_num_items();
 		$param_flow							->set_flow_index($index);
 		$userBuiltFlow->{_names_aref} 		= $param_flow->get_names_aref();

  							# print("2. green_flow flow_select,parameter names: @{$userBuiltFlow->{_names_aref}}\n");
 		$userBuiltFlow->{_values_aref} 		=	$param_flow->get_values_aref();

  				 			 print("3. green_flow flow_select,parameter values:@{$userBuiltFlow->{_values_aref}}\n");
 		$userBuiltFlow->{_check_buttons_settings_aref} 
									=  $param_flow->get_check_buttons_settings();

  				 			 # print("4. green_flow flow_select, check_buttons_settings no changes, @{$userBuiltFlow->{_check_buttons_settings_aref}}\n");
  				 			# print("4. green_flow flow_select,index;$index\n#");
  				 			
 				 			# get stored first index and num of items 
 		$userBuiltFlow->{_param_flow_first_idx}	= $param_flow->first_idx();
 		$userBuiltFlow->{_param_flow_length}   	= $param_flow->length();
 		$param_widgets				 			->set_current_program($userBuiltFlow->{_prog_name_sref});
 				 print("5. green_flow, flow_select, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");

				 			  #print("green_flow, flow_select, $userBuiltFlow->{_is_flow_listbox_color_w}\n");
				 			  # print("green_flow, flow_select, color:$flow_color\n");
		$whereami				->set4flow_listbox($flow_color);
		$here 					= $whereami->get4flow_listbox();
				 			  # print("5. green_flow flow_select, $here->{_is_flow_listbox_color_w}\n");
				 			  # print("green_flow, flow_select, _is_flow_listbox_color_w, $here->{_is_flow_listbox_color_w}\n");

		# $param_widgets		->range($userBuiltFlow); # to set widgets, must be before gui_clean
		 				 print("6. green_flow, flow_select, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");	
		 				 	 			 
	    $param_widgets      		->set_location_in_gui($here);
	    
	    	
		# widgets initialized in super class	
		$param_widgets		->set_labels_w_aref($userBuiltFlow->{_labels_w_aref} );
  		$param_widgets		->set_values_w_aref($userBuiltFlow->{_values_w_aref} );
  		$param_widgets		->set_check_buttons_w_aref($userBuiltFlow->{_check_buttons_w_aref} );
	    
	    
   		$param_widgets				->gui_clean();
  		$param_widgets				->range($userBuiltFlow);
 		$param_widgets				->set_labels($userBuiltFlow->{_names_aref});
 		$param_widgets				->set_values($userBuiltFlow->{_values_aref});
 		$param_widgets				->set_check_buttons(
										$userBuiltFlow->{_check_buttons_settings_aref});
								# TODO
					  		 # print("6. green_flow flow_select, is listbox selected:$here->{_is_flow_listbox_color_w}\n");
		$whereami					->set4flow_listbox($flow_color);
		$here 						= $whereami->get4flow_listbox();
				# print("6. green_flow, flow_select, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
    	$param_widgets      		->set_location_in_gui($here);
 		$param_widgets				->redisplay_labels();
 		$param_widgets				->redisplay_values();
 		$param_widgets				->redisplay_check_buttons();
  		$param_widgets				->set_entry_change_status($false);	

		my @Entry_widget			= @{$param_widgets->get_values_w_aref()};
					# print("green_flowflow_select,Entry_widgets@Entry_widget\n");
		$Entry_widget[0]->focus;  # always put focus on first entry widget
			
		 			# Here is where you rebind the different buttons depending on the
 					# program name that is selected (i.e. through spec.pm) 
 		$binding					->set_prog_name_sref($userBuiltFlow->{_prog_name_sref});
 		$binding					->set_values_w_aref($param_widgets->get_values_w_aref);
 		$binding					->setFileDialog_button_sub_ref (\&_FileDialog_button);
 		$binding					->set();
				# print("7. green_flow, flow_select, _values_w_aref $userBuiltFlow->{_values_w_aref}\n");
		
    	$conditions_gui				->set4end_of_flow_select($flow_color);
    	$conditions_gui				->set_flow_index_last_touched($index);
    	
    	$userBuiltFlow 				= $conditions_gui->get_hash_ref(); # now green_flow = 0; flow_type=user_built
    		# print("6. green_flow,flow_select,flow_color: $userBuiltFlow->{_flow_color} \n");
   		return();
	}
}



=head2 sub set_new_flow

  after reading a flow file
  there are progam names, values, param names, checkbuttons on and off
  Store this new flow in another namespace

  input is hash from L_SU: $L_SU
  do not change has reference contents at all

=cut
=pod

# in param_flow->set_box_number(1);
# in param_flow->set_box_number(2);
# in param_flow->set_box_number(3);
# in param_flow->set_box_number(4);

 sub set_new_flow {	
 	my (@self,$hash_ref) = @_;	
 	my $L_SU = $hash_ref;
 	_set_prog_versions($L_SU);
	privat_set_prog_names;
	_set_param_values_aref2($L_SU->{_values_aref});
    _set_param_names_aref2($L_SU->{_names_aref});
	_set_param_checkbuttons_aref2($L_SU->{_check_buttons_settings_aref});
	return();
 }	
 	
1;