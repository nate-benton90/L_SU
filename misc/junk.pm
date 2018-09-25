package conditions_gui;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PERL PACKAGE NAME: conditions_gui.pm
 AUTHOR: 	Juan Lorenzo
 DATE: 		May 16 2018 

 DESCRIPTION 
 		makes gui aware 
 		of what method is active
 		
 		makes gui disable and reenable certain widgets depending on which
 		method is called
 		
 		based on method, hash values are reset internally
 		one of few packages that changes state of variables outside main
 		
 		only conditions are reset. All other parameters travel through safely
 		
 		Be careful to blank as many imported values as possible and only allow
 		the essential to be  used (_reset and reset methods are available)
 		
 		I generally try to reset all values and only allow 
 		one or a few to survive for manipulation internally
 		
 		TODO: remove get methods so that conditions has no chance of altering variable 
 		values inother namespaces.
 		
 		get_flow_index_last_touched needs to be exported so do not reset it
 		
 		
     
 BASED ON:
 
 previous version the main L_SU.pl (V 0.3)
  
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

	use Moose;
 	our $VERSION = '0.0.1';
	use SeismicUnixPlTk_global_constants;

 	my $get								= new SeismicUnixPlTk_global_constants();

	my $var								= $get->var(); 	
 	my $false      						= $var->{_false};
 	my $true      						= $var->{_true}; 	
 
=head2 
 
  58 off convenient private abbreviated-variable names
  
=cut

 	my $add2flow_button_grey;
 	my $add2flow_button_pink;
 	my $add2flow_button_green;
 	my $add2flow_button_blue; 
 	my $check_buttons_w_aref;
  	my $check_code_button;
  	my $delete_from_flow_button;
	my $dialog_type;
 	my $file_menubutton;
 	my $flow_color	;
 	my $flow_listbox_grey_w;
  	my $flow_listbox_pink_w;
   	my $flow_listbox_green_w;	
 	my $flow_listbox_blue_w;
 	my $flow_listbox_color_w;
   	my $flow_name_out;
   	my $flow_type;
	my $flow_widget_index;	
	my $has_used_run_button;
	my $has_used_SaveAs_button;
	my $has_used_Save_button;	
 	my $is_add2flow_button;
 	my $is_check_code_button;
 	my $is_delete_from_flow_button;
 	my $is_dragNdrop;
 	my $is_flow_listbox_grey_w;
 	my $is_flow_listbox_pink_w;
 	my $is_flow_listbox_green_w	;
 	my $is_flow_listbox_blue_w;
 	my $is_flow_listbox_color_w; 
	my $is_moveNdrop_in_flow;
  	my $is_new_listbox_selection;		
  	my $is_open_file_button;
  	my $is_pre_built_superflow;
  	my $is_run_button;
 	my $is_select_file_button;
   	my $is_Save_button;	
   	my $is_SaveAs_button;
  	my $is_SaveAs_file_button;
 	my $is_sunix_listbox;
   	my $is_superflow_select_button;		
   	my $is_superflow;
  	my $is_user_built_flow;
  	my $labels_w_aref;
  	my $last_flow_listbox_touched;
   	my $last_flow_listbox_touched_w;
   	my $last_flow_index_touched	;
   	my $last_parameter_index_touched;
  	my $message_w;
 	my $mw;	
   	my $parameter_value_idx;
 	my $parameter_values_frame;
   	my $prog_name_sref;
    my $run_button;
 	my $save_button;
   	my $sub_ref; 
   	my $values_aref; 	
 	my $values_w_aref; 	
 	
=head2 private hash

60 off

=cut

	my $conditions_gui = {	
		
		_add2flow_button_grey					=>'',
		_add2flow_button_pink					=>'',
		_add2flow_button_green					=>'',
		_add2flow_button_blue					=>'',
 		_check_code_button 						=> '',	
 		_check_buttons_w_aref 					=> '',	
		_delete_from_flow_button				=> '',
		_dialog_type							=> '', 	
		_file_menubutton 						=> '',
		_flow_color								=> '',
 		_flow_listbox_grey_w 					=> '',
 		_flow_listbox_pink_w 					=> '',
  		_flow_listbox_green_w 					=> '',
   		_flow_listbox_blue_w 					=> '',
		_flow_listbox_color_w					=> '',
		_flow_name_out							=> '',
		_flow_type								=> '', 			
 		_flow_widget_index						=> '',
 		_has_used_run_button					=> '',
		_has_used_Save_button					=> '',
		_has_used_SaveAs_button					=> '',		
		_is_add2flow_button						=> '',
		_is_check_code_button					=> '',
		_is_delete_from_flow_button				=> '',
		_is_dragNdrop							=> '',
		_is_flow_listbox_grey_w					=> '',
		_is_flow_listbox_pink_w					=> '',		
		_is_flow_listbox_green_w				=> '',
		_is_flow_listbox_blue_w					=> '',
		_is_flow_listbox_color_w				=> '',
		_is_moveNdrop_in_flow					=> '',
		_is_new_listbox_selection				=> '',		
		_is_open_file_button					=> '',
		_is_pre_built_superflow					=> '',
		_is_run_button							=> '',
		_is_select_file_button					=> '',
   		_is_superflow 							=> '',
		_is_SaveAs_file_button					=> '',
		_is_SaveAs_button						=> '',
		_is_Save_button							=> '',			
		_is_sunix_listbox						=> '',
		_is_superflow_select_button				=> '',
		_is_run_button							=> '',
		_is_user_built_flow						=> '',
		_labels_w_aref							=> '',
  	 	_last_flow_listbox_touched   			=> '',
 		_last_flow_listbox_touched_w 			=> '',
 		_last_flow_index_touched     	 		=> -1,
 		_last_parameter_index_touched			=> -1,
 		_message_w								=> '',
 		_mw										=> '',
 		_prog_name_sref							=> '',
   		_parameter_values_frame 				=> '',
   		_parameter_value_idx 					=> '',
		_prog_name_sref    						=> '',
 		_run_button								=> '',
  	 	_save_button 							=> '',
  	 	_sub_ref								=> '',
   		_values_aref							=> '',
  	 	_values_w_ref							=> '', 
  	 	 		
 	};



=head2 sub _get_flow_color


=cut 

 sub _get_add2flow_button {
	my ($self)   = @_;
	my $color;
	my $correct_add2flow_button;
	
	$color 		= $conditions_gui->{_flow_color};
	
	if ($color eq 'grey') 		{
		$correct_add2flow_button =  $conditions_gui->{_add2flow_button_grey};
		
	} elsif ($color eq 'pink')  {
		$correct_add2flow_button 	= $conditions_gui->{_add2flow_button_pink};
		
	} elsif ($color eq 'green') {
		$correct_add2flow_button 	=  $conditions_gui->{_add2flow_button_green};
		
	} elsif ($color eq 'blue')  {
		$correct_add2flow_button 	=  $conditions_gui->{_add2flow_button_blue};
		
	} else {
		print("conditions_gui,  _get_add2flow_button, missing color,missing color, color:$color\n");
	}
    
	return($correct_add2flow_button);
 }



=head2 sub _get_flow_color


=cut 

 sub _get_flow_color {
	my ($self)   = @_;
	my $color;
	
	$color 		= $conditions_gui->{_flow_color};
		
	return($color);
 }

=head2 sub _get_flow_listbox_color_w


=cut 

 sub _get_flow_listbox_color_w {
	my ($self)   = @_;
	my $correct_flow_listbox_color_w;
	
	if ($conditions_gui->{_flow_listbox_color_w}) {
		
		my $correct_flow_listbox_color_w = $conditions_gui->{_flow_listbox_color_w};
		return($correct_flow_listbox_color_w);
		
	} else {
		print("conditions_gui, _get_flow_listbox_color_w, munasigned flow listbox w for current color\n");		
		return();	
	}

 }


=head2  sub _reset

	23 off
	do not reset important values:
	location within GUI

=cut

 sub _reset {
	my $self = @_;

        $conditions_gui->{_is_Save_button}					= $false;
   		$conditions_gui->{_is_SaveAs_file_button}			= $false;
   		$conditions_gui->{_is_SaveAs_button}				= $false; 
   		$conditions_gui->{_has_used_run_button} 			= $false;;
   		$conditions_gui->{_is_add2flow_button}				= $false;
   		$conditions_gui->{_is_check_code_button}			= $false;
   		$conditions_gui->{_is_delete_from_flow_button}		= $false;
   		$conditions_gui->{_is_dragNdrop}					= $false;
   		$conditions_gui->{_is_flow_listbox_grey_w}			= $false;
   		$conditions_gui->{_is_flow_listbox_pink_w}			= $false;
   		$conditions_gui->{_is_flow_listbox_green_w}			= $false;
   		$conditions_gui->{_is_flow_listbox_blue_w}			= $false;
   		$conditions_gui->{_is_flow_listbox_color_w}			= $false; 
   		$conditions_gui->{_is_moveNdrop_in_flow}       		= $false;  	
   		$conditions_gui->{_is_open_file_button}				= $false;
   		$conditions_gui->{_is_select_file_button}			= $false; 		
   		$conditions_gui->{_is_sunix_listbox}   				= $false;
		$conditions_gui->{_is_new_listbox_selection} 		= $false;
   		$conditions_gui->{_is_superflow_select_button}		= $false;
  	 	$conditions_gui->{_is_run_button}					= $false;
  	 	$conditions_gui->{_is_pre_built_superflow}  		= $false;
   	 	$conditions_gui->{_is_superflow}  					= $false; 	 	
  	 	$conditions_gui->{_is_user_built_flow}   			= $false;
   		
 }




=head2 sub _set_flow_color


=cut 

 sub _set_flow_color {
	my ($color)   = @_;
	
	if ($color) {
		# print("conditions_gui, _set_flow_color , color:$color\n");
		$conditions_gui->{_flow_color}  			 = $color;	
	} else  {

	 print("conditions_gui, set_flow_color, missing color\n");
	 }
	return();
 }

=head2 sub _set_flow_listbox_color_w


=cut 

 sub _set_flow_listbox_color_w {
	my ($color)   = @_;
		
	if ($color eq 'grey') {
		$conditions_gui->{_flow_listbox_color_w} =  $conditions_gui->{_flow_listbox_grey_w};
		
	} elsif ($color eq 'pink')  {
		$conditions_gui->{_flow_listbox_color_w} = $conditions_gui->{_flow_listbox_pink_w};
		
	} elsif ($color eq 'green') {
		$conditions_gui->{_flow_listbox_color_w} =  $conditions_gui->{_flow_listbox_green_w};
		
	} elsif ($color eq 'blue')  {
		$conditions_gui->{_flow_listbox_color_w} =  $conditions_gui->{_flow_listbox_blue_w};
		
	} else {
		print("conditions_gui, _set_flow_listbox_color_w, missing color, color:$color\n");
	}
    
	return();
 }


=head2 sub _set_flow_listbox_last_touched

	keep track of whcih listbox was last chosen

=cut

 sub _set_flow_listbox_last_touched {
	my ($listbox_name) = @_;
	
	if ($listbox_name) {
		$conditions_gui->{_last_flow_listbox_touched} = $listbox_name;
		# print("conditions_gui,_set_flow_listbox_touched left listbox = $conditions_gui->{_last_flow_listbox_touched}\n");
		
	}else {
		print("conditions_gui,set_flow_listbox_touched, missing listbox name\n");
	}

	return();
 }

=head2 sub _set_flow_listbox_last_touched_w


=cut

sub _set_flow_listbox_last_touched_w {
	my ($flow_listbox_color_w) = @_;
	
	_set_gui_widgets();
	
	if ($flow_listbox_color_w) {
   		$conditions_gui->{_last_flow_listbox_touched_w} 	= $flow_listbox_color_w;	
    		  # print("conditions_gui,_set_flow_listbox_touched_w= $conditions_gui->{_last_flow_listbox_touched_w}\n");
		
	} else {
			  print("conditions_gui,_set_flow_listbox_touched_w, missing listbox widget\n");
	}
	return();
}


=head2 sub _set_gui_widgets

	 spread important widget addresses
	 privately for convenience using abbreviated names,
	 i.e. in scalar instead of hash notaion
	 print("1 conditions_gui,_set_gui_widgets, delete_from_flow_button: $delete_from_flow_button\n");
	 print("conditions_gui,_set_gui_widgets,flow_listbox_grey_w : $flow_listbox_grey_w \n");
	
	23 off
	
=cut

 		
 sub _set_gui_widgets {
 	my ($self) = @_;
 	
 	  	$add2flow_button_grey		= $conditions_gui->{_add2flow_button_grey};
   		$add2flow_button_pink		= $conditions_gui->{_add2flow_button_pink};
    	$add2flow_button_green		= $conditions_gui->{_add2flow_button_green};
    	$add2flow_button_blue		= $conditions_gui->{_add2flow_button_blue};	
 	 	$check_buttons_w_aref		= $conditions_gui->{_check_buttons_w_aref};
 		$check_code_button 			= $conditions_gui->{_check_code_button};
 		$delete_from_flow_button 	= $conditions_gui->{_delete_from_flow_button};
 		$file_menubutton			= $conditions_gui->{_file_menubutton};
		$flow_color 				= $conditions_gui->{_flow_color};
 		$flow_listbox_grey_w 		= $conditions_gui->{_flow_listbox_grey_w};
  		$flow_listbox_pink_w 		= $conditions_gui->{_flow_listbox_pink_w};
 		$flow_listbox_green_w 		= $conditions_gui->{_flow_listbox_green_w};
  		$flow_listbox_blue_w 		= $conditions_gui->{_flow_listbox_blue_w};
  		$flow_listbox_color_w		= $conditions_gui->{_flow_listbox_color_w};
 		$flow_widget_index			= $conditions_gui->{_flow_widget_index};
  		$labels_w_aref				= $conditions_gui->{_labels_w_aref};
 		$message_w					= $conditions_gui->{_message_w};
  		$mw 						= $conditions_gui->{_mw};
  		$parameter_values_frame 	= $conditions_gui->{_parameter_values_frame};
		$parameter_value_idx		= $conditions_gui->{_parameter_value_idx};
 		$run_button 				= $conditions_gui->{_run_button};
  		$save_button 				= $conditions_gui->{_save_button};
  		$values_w_aref				= $conditions_gui->{_values_w_aref};
  		
 	return();
 }


	

=head2 sub get_flow_color

	return flow color if it exists
	
=cut

 sub get_flow_color {
 	my ($self) = @_;
 	my $flow_color;
    
    if ( $conditions_gui->{_flow_color} ) {
    	
    	$flow_color	= $conditions_gui->{_flow_color};
    	 		# print("conditions_gui, conditions_gui->{_flow_color}: $conditions_gui->{_flow_color}\n");  	
   		 	return($flow_color);
   		
 	} else {		
 		print("conditions_gui, get_flow_color , missing flow color value \n");
 		return();
 	}
 }



=head2 sub get_hash_ref

	return ALL values of the private hash, supposedly
	improtant external widgets have not been reset.. only conditions
	are reset
	TODO: perhaps it is better to have a specific method
		to return one specific widget address at a time?
	}
	
=cut

 sub get_hash_ref {
 	my ($self) = @_;
    
    if($conditions_gui) {
    	 		# print("conditions_gui, get_hash_ref , conditions_gui->{_flow_color}: $conditions_gui->{_flow_color}\n");  	
   		 	return($conditions_gui);
   		
 	} else {		
 		print("conditions_gui, get_hash_ref , missing hconditions_gui hash_ref\n");
 	}
 }

=head2

 22 off  only reset the conditional parameters, not the widgets and other information

=cut

 sub reset {
	my $self = @_;
        		# location within GUI  
        $conditions_gui->{_has_used_run_button} 			= $false;	
        $conditions_gui->{_is_add2flow_button}				= $false;
   		$conditions_gui->{_is_check_code_button}			= $false;
   		$conditions_gui->{_is_delete_from_flow_button}		= $false;
   		$conditions_gui->{_is_dragNdrop}					= $false;
   		$conditions_gui->{_is_flow_listbox_grey_w}			= $false;
   		$conditions_gui->{_is_flow_listbox_pink_w}			= $false;
    	$conditions_gui->{_is_flow_listbox_green_w}			= $false;
   		$conditions_gui->{_is_flow_listbox_blue_w}			= $false;
   		$conditions_gui->{_is_flow_listbox_color_w}			= $false;   		
   		$conditions_gui->{_is_open_file_button}				= $false;
   		$conditions_gui->{_is_select_file_button}			= $false;
   		$conditions_gui->{_is_SaveAs_file_button}			= $false;
   		$conditions_gui->{_is_sunix_listbox}   				= $false;
		$conditions_gui->{_is_new_listbox_selection} 		= $false;
   		$conditions_gui->{_is_superflow_select_button}		= $false;
  	 	$conditions_gui->{_is_run_button}					= $false;
  	 	$conditions_gui->{_is_pre_built_superflow}   		= $false;
  	 	$conditions_gui->{_is_superflow}					= $false;
  	 	$conditions_gui->{_is_user_built_flow}   			= $false;
   		$conditions_gui->{_is_Save_button}					= $false;
   		$conditions_gui->{_is_moveNdrop_in_flow}       		= $false;
   		
 }


=head2 sub set_flow_color


=cut 

 sub set_flow_color {
	my ($self,$color)   = @_;
	
	if ($color) {
		
		$conditions_gui->{_flow_color}  			 = $color;
		
	} else  {
			# my $parameter					 			= '_is_flow_listbox_'.$color.'_w';
			# $conditions_gui->{$parameter} 				 = $true;
	 print("conditions_gui, set_flow_color, missing color\n");
	 }
	return();
 }


=head2 sub set_gui_widgets

	bring it important widget addresses
	
	22 off
	
=cut

 sub set_gui_widgets {
 	my ($self,$widget_hash_ref) = @_;
 	
 	if ( $widget_hash_ref) {
 		
     	$conditions_gui->{_add2flow_button_grey}	= $widget_hash_ref->{_add2flow_button_grey};
      	$conditions_gui->{_add2flow_button_pink}	= $widget_hash_ref->{_add2flow_button_pink}; 
      	$conditions_gui->{_add2flow_button_green}	= $widget_hash_ref->{_add2flow_button_green}; 
     	$conditions_gui->{_add2flow_button_blue}	= $widget_hash_ref->{_add2flow_button_blue};
  		$conditions_gui->{_check_code_button} 		= $widget_hash_ref->{_check_code_button};
 		$conditions_gui->{_check_buttons_w_aref}	= $widget_hash_ref->{_check_buttons_w_aref};
 		$conditions_gui->{_delete_from_flow_button} = $widget_hash_ref->{_delete_from_flow_button};
   		$conditions_gui->{_file_menubutton} 		= $widget_hash_ref->{_file_menubutton};			
 		$conditions_gui->{_flow_listbox_grey_w} 	= $widget_hash_ref->{_flow_listbox_grey_w};
 		$conditions_gui->{_flow_listbox_pink_w} 	= $widget_hash_ref->{_flow_listbox_pink_w}; 		
 		$conditions_gui->{_flow_listbox_green_w} 	= $widget_hash_ref->{_flow_listbox_green_w};
  		$conditions_gui->{_flow_listbox_blue_w} 	= $widget_hash_ref->{_flow_listbox_blue_w};
  		$conditions_gui->{_flow_listbox_color_w} 	= $widget_hash_ref->{_flow_listbox_color_w};  		
  		$conditions_gui->{_flow_widget_index}		= $widget_hash_ref->{_flow_widget_index};
    	$conditions_gui->{_labels_w_aref}			= $widget_hash_ref->{_labels_w_aref};
   		$conditions_gui->{_message_w}				= $widget_hash_ref->{_message_w};
   		$conditions_gui->{_mw}						= $widget_hash_ref->{_mw};
    	$conditions_gui->{_parameter_values_frame} 	= $widget_hash_ref->{_parameter_values_frame};
		$conditions_gui->{_parameter_value_idx}		= $widget_hash_ref->{_parameter_value_idx};
    	$conditions_gui->{_run_button} 				= $widget_hash_ref->{_run_button};
    	$conditions_gui->{_save_button} 			= $widget_hash_ref->{_save_button}; 
    	$conditions_gui->{_values_w_aref}			= $widget_hash_ref->{_values_w_aref};	
    	
    	# print("conditions_gui, set_gui_widgets , conditions_gui->{_delete_from_flow_button: $conditions_gui->{_delete_from_flow_button}\n");
    			  		
 	} else {
		
 		print("conditions_gui, set_gui_widgets , missing hash_ref\n");
 	}
 	return();
 }


=head2 sub set_hash_ref

	bring in important (1) last flow index, (1) prog name and (22) conditions
	does not include widgets
	widgets are boruught in with set_gui_widgets
	
	36 and 36
	
=cut

 sub set_hash_ref {
 	my ($self,$hash_ref) = @_;
 	
 	if ( $hash_ref) {
 		
 		$conditions_gui->{_dialog_type} 						= $hash_ref->{_dialog_type} ;
 		$conditions_gui->{_flow_color} 							= $hash_ref->{_flow_color} ;
   		$conditions_gui->{_flow_name_out} 						= $hash_ref->{_flow_name_out};
   		$conditions_gui->{_flow_type} 							= $hash_ref->{_flow_type};
		$conditions_gui->{_flow_widget_index} 					= $hash_ref->{_flow_widget_index};	
		$conditions_gui->{_has_used_run_button} 				= $hash_ref->{_has_used_run_button};
		$conditions_gui->{_has_used_SaveAs_button} 				= $hash_ref->{_has_used_SaveAs_button};
		$conditions_gui->{_has_used_Save_button} 				= $hash_ref->{_has_used_Save_button}; 	
 		$conditions_gui->{_is_add2flow_button} 					= $hash_ref->{_is_add2flow_button};
 		$conditions_gui->{_is_check_code_button} 				= $hash_ref->{_is_check_code_button};
 		$conditions_gui->{_is_delete_from_flow_button} 			= $hash_ref->{_is_delete_from_flow_button};
 		$conditions_gui->{_is_dragNdrop} 						= $hash_ref->{_is_dragNdrop};
 		$conditions_gui->{_is_flow_listbox_grey_w} 				= $hash_ref->{_is_flow_listbox_grey_w};
 		$conditions_gui->{_is_flow_listbox_pink_w} 				= $hash_ref->{_is_flow_listbox_pink_w};
 		$conditions_gui->{_is_flow_listbox_green_w} 			= $hash_ref->{_is_flow_listbox_green_w};
 		$conditions_gui->{_is_flow_listbox_blue_w} 				= $hash_ref->{_is_flow_listbox_blue_w};
 		$conditions_gui->{_is_flow_listbox_color_w} 			= $hash_ref->{_is_flow_listbox_color_w}; 		
  		$conditions_gui->{_is_open_file_button} 				= $hash_ref->{_is_open_file_button};
  		$conditions_gui->{_is_run_button} 						= $hash_ref->{_is_run_button};
		$conditions_gui->{_is_moveNdrop_in_flow} 				= $hash_ref->{_is_moveNdrop_in_flow};
		$conditions_gui->{_is_user_built_flow} 					= $hash_ref->{_is_user_built_flow};
 		$conditions_gui->{_is_select_file_button} 				= $hash_ref->{_is_select_file_button};
   		$conditions_gui->{_is_Save_button} 						= $hash_ref->{_is_Save_button};	
   		$conditions_gui->{_is_SaveAs_button} 					= $hash_ref->{_is_SaveAs_button};
  		$conditions_gui->{_is_SaveAs_file_button} 				= $hash_ref->{_is_SaveAs_file_button};
 		$conditions_gui->{_is_sunix_listbox} 					= $hash_ref->{_is_sunix_listbox};
  		$conditions_gui->{_is_new_listbox_selection} 			= $hash_ref->{_is_new_listbox_selection};
  		$conditions_gui->{_is_pre_built_superflow}				= $hash_ref->{_is_pre_built_superflow};
   		$conditions_gui->{_is_superflow_select_button} 			= $hash_ref->{_is_superflow_select_button};		
   		$conditions_gui->{_is_superflow}						= $hash_ref->{_is_superflow} ;
   		$conditions_gui->{_is_moveNdrop_in_flow} 				= $hash_ref->{_is_moveNdrop_in_flow};			
   		$conditions_gui->{_last_flow_index_touched}				= $hash_ref->{_last_flow_index_touched};
   		$conditions_gui->{_last_parameter_index_touched}		= $hash_ref->{_last_parameter_index_touched};
   		$conditions_gui->{_prog_name_sref}						= $hash_ref->{_prog_name_sref};	
   		$conditions_gui->{_sub_ref}								= $hash_ref->{_sub_ref};  		 
   		$conditions_gui->{_values_aref}							= $hash_ref->{_values_aref};
   		
   		
   		$dialog_type 							= $hash_ref->{_dialog_type} ;
 		$flow_color								= $hash_ref->{_flow_color} ;
   		$flow_name_out							= $hash_ref->{_flow_name_out};
   		$flow_type								= $hash_ref->{_flow_type};
		$flow_widget_index						= $hash_ref->{_flow_widget_index};	
		$has_used_run_button					= $hash_ref->{_has_used_run_button};
		$has_used_SaveAs_button					= $hash_ref->{_has_used_SaveAs_button};
		$has_used_Save_button					= $hash_ref->{_has_used_Save_button}; 	
 		$is_add2flow_button						= $hash_ref->{_is_add2flow_button};
 		$is_check_code_button					= $hash_ref->{_is_check_code_button};
 		$is_delete_from_flow_button				= $hash_ref->{_is_delete_from_flow_button};
 		$is_dragNdrop							= $hash_ref->{_is_dragNdrop};
 		$is_flow_listbox_grey_w					= $hash_ref->{_is_flow_listbox_grey_w};
 		$is_flow_listbox_pink_w					= $hash_ref->{_is_flow_listbox_pink_w};
 		$is_flow_listbox_green_w				= $hash_ref->{_is_flow_listbox_green_w};
 		$is_flow_listbox_blue_w					= $hash_ref->{_is_flow_listbox_blue_w};
 		$is_flow_listbox_color_w				= $hash_ref->{_is_flow_listbox_color_w}; 		
  		$is_open_file_button					= $hash_ref->{_is_open_file_button};
  		$is_run_button							= $hash_ref->{_is_run_button};
		$is_moveNdrop_in_flow					= $hash_ref->{_is_moveNdrop_in_flow};
		$is_user_built_flow						= $hash_ref->{_is_user_built_flow};
 		$is_select_file_button					= $hash_ref->{_is_select_file_button};
   		$is_Save_button							= $hash_ref->{_is_Save_button};	
   		$is_SaveAs_button						= $hash_ref->{_is_SaveAs_button};
  		$is_SaveAs_file_button					= $hash_ref->{_is_SaveAs_file_button};
 		$is_sunix_listbox						= $hash_ref->{_is_sunix_listbox};
  		$is_new_listbox_selection				= $hash_ref->{_is_new_listbox_selection};
  		$is_pre_built_superflow					= $hash_ref->{_is_pre_built_superflow};
   		$is_superflow_select_button				= $hash_ref->{_is_superflow_select_button};		
   		$is_superflow							= $hash_ref->{_is_superflow} ;
   		$is_moveNdrop_in_flow					= $hash_ref->{_is_moveNdrop_in_flow};			
   		$last_flow_index_touched				= $hash_ref->{_last_flow_index_touched};
   		$last_parameter_index_touched			= $hash_ref->{_last_parameter_index_touched};
   		$prog_name_sref							= $hash_ref->{_prog_name_sref};	
   		$sub_ref								= $hash_ref->{_sub_ref};  		 
   		$values_aref							= $hash_ref->{_values_aref};
   		
 	} else {
		
 		print("conditions_gui, set_hash_ref , missing hash_ref\n");
 	}
 	return();
 }



=head2


=cut

sub set4_check_code_button {
	my $self = @_;
	
	# _conditions	->reset();
				  # print("1. conditions_gui, set4end_of_check_code_button,last left listbox flow program touched had index = $conditions_gui->{_last_flow_index_touched}\n");
        		# location within GUI   
   	$conditions_gui->{_has_used_check_code_button}			= $true;

	return();
}


#=head2
#
#
#=cut
#
#
# sub  set4FileDialog_select_start {
#	my $self = @_;
#	#_reset();
#	 #  ERROR if _reset() the param_widgets table is reset;
#	 #  ERROR if _reset() the 	 #  f 
#    $conditions_gui->{_is_select_file_button}					= $true;
#    # print("conditions_gui,set4FileDialog_select_start  $conditions_gui->{_is_select_file_button} 	\n");
#    #print("conditions_gui,set4FileDialog_open_start,listbox_l listbox_r  $conditions_gui->{_is_flow_listbox_grey_w} 	$conditions_gui->{_is_flow_listbox_green_w}\n");
# 
#	return();
# }
#
#=head2
#
#
#=cut
#
#
#sub  set4FileDialog_select_end {
#	my $self = @_;
#    $conditions_gui->{_is_select_file_button}		= $false;
#    # print("conditions_gui,set4FileDialog_select_end  $conditions_gui->{_is_select_file_button}\n");
#    #print("conditions_gui,set4FileDialog_open_start,listbox_l listbox_r  $conditions_gui->{_is_flow_listbox_grey_w} 	$conditions_gui->{_is_flow_listbox_green_w}\n");
#	
#	return();
#}

=head2 sub  set4FileDialog_SaveAs_end 


=cut

sub  set4FileDialog_SaveAs_end {
	my $self = @_;
	
    $conditions_gui->{_is_SaveAs_file_button}				= $false;
    $conditions_gui->{_has_used_SaveAs_button}				= $true;

						# clean path
    # $conditions_gui->{_path}						= '';
    					 # print("conditions_gui,set4FileDialog_SaveAs_end  
    					 # $conditions_gui->{_is_SaveAs_file_button}\n");
	return();
}



=head2 sub  set4FileDialog_open_start


=cut

sub  set4FileDialog_open_start {
	my $self = @_;

    $conditions_gui->{_is_open_file_button}		= $true;
    # print("conditions_gui,set4FileDialog_open_start  $conditions_gui->{_is_open_file_button}\n");
 
	return();
}

=head2 sub  set4FileDialog_open_end


=cut

sub  set4FileDialog_open_end {
	my $self = @_;
	
    $conditions_gui->{_is_open_file_button}		= $false;
    # print("conditions_gui,set4FileDialog_open_end  $conditions_gui->{_is_open_file_button}\n");
	
	return();
}


=head2


=cut

sub  set4FileDialog_SaveAs_start {
	my $self = @_; 	
	
	use SeismicUnixPlTk_global_constants;
	my $get											= SeismicUnixPlTk_global_constants->new();
	my $flow_type_h									= $get->flow_type_href();
	 					
    $conditions_gui->{_is_SaveAs_file_button}		= $true;
    $conditions_gui->{_is_SaveAs_button}			= $true;
    
    if ($conditions_gui->{_flow_type} eq $flow_type_h->{_user_built} ) {
    	$conditions_gui->{_is_user_built_flow}  	= $true;
    	$conditions_gui->{_pre_built_superflow }  	= $false;
    	
    } elsif ($conditions_gui->{_flow_type} eq $flow_type_h->{_pre_built_superflow} ){
    	
    	$conditions_gui->{_user_built_flow}  		= $false;
  		$conditions_gui->{_pre_built_superflow }  	= $true;  	
    }
    					 # print("conditions_gui,set4FileDialog_SaveAs_start  
   						 # $conditions_gui->{_is_SaveAs_file_button}\n");
	return();
}




=head2


=cut

sub set4_Save_button {
	my $self = @_;
	
	# _conditions	->reset();
				  # print("1. conditions_gui, set4end_of_save_button,last left listbox flow program touched had index = $conditions_gui->{_last_flow_index_touched}\n");
        		# location within GUI   
   	$conditions_gui->{_has_used_Save_button}			= $true;

	return();
}


=head2 sub set4_end_of_SaveAs_button


=cut

sub set4_end_of_SaveAs_button {
	my $self = @_;
	  
   	$conditions_gui->{_has_used_SaveAs_button}			= $true;

	return();
}


=head2 sub set4_start_of_SaveAs_button


=cut

sub set4_start_of_SaveAs_button {
	my $self = @_;
	  
   	$conditions_gui->{_is_SaveAs_button}			= $true;

	return();
}


=head2


=cut


sub set4end_of_check_code_button {
	my $self = @_;
	
	# _conditions	->reset();
				  # print("1. conditions_gui, set4end_of_check_code_button,last left listbox flow program touched had index = $conditions_gui->{_last_flow_index_touched}\n");
        		# location within GUI   
   	$conditions_gui->{_is_check_code_button}			    	= $false;
   	
	return();
}


=head2


=cut

sub set4start_of_check_code_button {
	my $self = @_;
	
	# _conditions	->reset();
				  # print("1. conditions_gui, set4start_of_button,last left listbox flow program touched had index = $conditions_gui->{_last_flow_index_touched}\n");
        		# location within GUI   
   	$conditions_gui->{_is_check_code_button}			= $true;
   	$conditions_gui->{_has_used_check_code_button}	= $false;

	return();
}

=head2


=cut

sub set4end_of_SaveAs_button {
	my $self = @_;
	  
   	$conditions_gui->{_is_SaveAs_button}			    	    = $false;
   	$conditions_gui->{_has_used_SaveAs_button}			    	= $true;
	return();
}

=head2

   location within GUI
   
   foreach my $key (sort keys %$conditions_gui) {
     print ("conditions_gui user,set4end_of_flow_select,key is $key, value is $conditions_gui->{$key}\n");
   }

=cut

sub set4end_of_flow_select {
	my ($self,$color) = @_;
	
	if ($color) {
		_reset();
		_set_flow_color($color);
		my $is_flow_listbox_color_w      	= '_is_flow_listbox_'.$color.'_w';
   	    		# print("conditions_gui, set4end_of_flow_select, color:$color\n");
				# print("1. conditions_gui, set4end_of_flow_select,last left listbox flow program touched had index = $conditions_gui->{_last_flow_index_touched}\n");
   		$conditions_gui->{$is_flow_listbox_color_w}			= $true;
   		$conditions_gui->{_flow_color}						= $color;
   		$conditions_gui->{_is_delete_from_flow_button}		= $true;
   		$conditions_gui->{_is_flow_listbox_color_w}			= $true;
   		
   			# print("conditions_gui, set4end_of_flow_select, color:$color\n");
   			# print("conditions_gui, set4end_of_flow_select, is_flow_listbox_'grey pink gren or blue'_w:  $conditions_gui->{$is_flow_listbox_color_w}\n");
	}else {
		print("conditions_gui, set4end_of_flow_select , color missing: $color\n");
	}
	return();
}



=head2 sub set4end_of_run_button

location within GUI 

	sets 
	$conditions_gui

=cut

sub set4end_of_run_button {
	my $self = @_;
        		# location within GUI   
   	$conditions_gui->{_is_run_button}				= $false;
   	$conditions_gui->{_has_used_run_button}			= $false;
	return();
}


=head2


=cut


sub set4start_of_Save_button {
	my $self = @_;
				  # print("1. conditions_gui, set4start_of_Save_button,last left listbox flow program touched had index = $conditions_gui->{_last_flow_index_touched}\n");
        		# location within GUI   
   	$conditions_gui->{_is_Save_button}			= $true;
   	$conditions_gui->{_has_used_Save_button}	= $false;

	return();
}


sub set4end_of_sunix_select {
	my $self = @_;
	
	_set_gui_widgets();
   	
   	$add2flow_button_grey	->configure(-state => 'normal',);
   	$add2flow_button_pink	->configure(-state => 'normal',);
   	$add2flow_button_green	->configure(-state => 'normal',);
   	$add2flow_button_blue	->configure(-state => 'normal',);

   	$conditions_gui->{_is_flow_listbox_grey_w}			= $false;
   	$conditions_gui->{_is_flow_listbox_pink_w}			= $false;
   	$conditions_gui->{_is_flow_listbox_green_w}			= $false;
   	$conditions_gui->{_is_flow_listbox_blue_w}			= $false;
   	$conditions_gui->{_is_flow_listbox_color_w}			= $false;
   	$conditions_gui->{_is_add2flow_button}				= $true;
   	# $conditions_gui->{_is_sunix_listbox} = $false;
}



=head2


=cut

sub set4end_of_Save_button {
	my $self = @_;
	
	# _conditions	->reset();
				  # print("1. conditions_gui, set4end_of_save_button,last left listbox flow program touched had index = $conditions_gui->{_last_flow_index_touched}\n");
        		# location within GUI   
   	$conditions_gui->{_is_Save_button}			    	= $false;
   	$conditions_gui->{_has_used_Save_button}			= $true;
	return();
}




=head2

	when all items are removed from a flow lsitbox


=cut

sub set4last_delete_from_flow_button {
	my $self = @_;
	
	_set_gui_widgets();
	
       				# turn off delete button
	$delete_from_flow_button	->configure(
					-state => 'disabled',
					);   
    				# turn off all flow -listboxes
	$flow_listbox_grey_w    			->configure(
	        		-state => 'disabled',
                   );
	$flow_listbox_pink_w    			->configure(
	        		-state => 'disabled',
                   ); 
	$flow_listbox_green_w    			->configure(
	        		-state => 'disabled',
                   ); 
 	$flow_listbox_blue_w    			->configure(
	        		-state => 'disabled',
                   );                   			
       				# turn off run button
   	$run_button					->configure(
					-state => 'disabled'
					); 
					
       				# turn off file menu button
  	$file_menubutton			->configure(
					-state => 'disabled'
					); 

       				# turn off save button
  	$save_button				->configure(
	 				-state => 'disabled'
	 				); 
	
       				# turn off  check_code_button
  	$check_code_button			->configure(
					-state => 'disabled'
					);
					  
	$conditions_gui->{_is_delete_from_flow_button}	    = $false;
   	$conditions_gui->{_is_flow_listbox_grey_w}			= $false;
   	$conditions_gui->{_is_flow_listbox_pink_w}			= $false;
    $conditions_gui->{_is_flow_listbox_green_w}			= $false;
   	$conditions_gui->{_is_flow_listbox_blue_w}			= $false;
   	$conditions_gui->{_is_flow_listbox_color_w}			= $false;   	    	  	
   	$conditions_gui->{_is_user_built_flow}			    = $false; 
	return();
}


=head2

	location within GUI on first clicking delete button

=cut

sub set4start_of_delete_from_flow_button {
	my ($self,$color) = @_;
	
	if ($color) {
		_reset();

   		$conditions_gui->{_is_delete_from_flow_button}	    = $true;
		_set_flow_color($color);
		my $is_flow_listbox_color_w      					= '_is_flow_listbox_'.$color.'_w';
		$conditions_gui->{$is_flow_listbox_color_w}			= $true;
   		$conditions_gui->{_is_user_built_flow}			    = $true;
   	
	} else {		
		print("conditions_gui, set4start_of_delete_from_flow_button, no color: $color\n");
	}

	return();
}

=head2

take focus of the first Entry button/Value
for all listboxes
returns only a few parameters
All others have been reset to false

WARNING, _reset will make color disappear

=cut

sub set4start_of_flow_select {
	my ($self,$color) = @_;
	
	_reset();
	
	if ($color) {
		_set_flow_color($color);
		my $listbox_color_text      	= 'flow_listbox_'.$color.'_w';
   		my $flow_listbox_color_w 		= _get_flow_listbox_color_w($color);
   	    		# print("conditions_gui, set4start_of_flow_select, color:$color\n");
  
		_set_flow_listbox_last_touched($listbox_color_text);
		_set_gui_widgets();
    	_set_flow_listbox_last_touched_w($flow_listbox_color_w);
    			# print("conditions_gui, set4start_of_flow_select, _set_flow_listbox_last_touched_w\n");
        		# location within GUI   
   		$conditions_gui->{_is_flow_listbox_grey_w}			= $true;
   		$conditions_gui->{_is_flow_listbox_pink_w}			= $true;
   		$conditions_gui->{_is_flow_listbox_green_w}			= $true;
   		$conditions_gui->{_is_flow_listbox_blue_w}			= $true;
   		$conditions_gui->{_is_flow_listbox_color_w}			= $true;   		
   		$conditions_gui->{_is_user_built_flow}				= $true;

   		$delete_from_flow_button				->configure(-state => 'active',);
  		$flow_listbox_grey_w					->configure(-state => 'normal',);
  		$flow_listbox_pink_w					->configure(-state => 'normal',);  	
  		$flow_listbox_green_w					->configure(-state => 'normal',);
   		$flow_listbox_blue_w					->configure(-state => 'normal',);
  		$check_code_button						->configure(-state => 'normal',);
  	
  	#	$entry_button->focus
	} else {
		print("conditions_gui, set4start_of_flow_select, no color:$color\n");
		
	}  
	return();
	
}


=head2

legacy

=cut


sub set4run_button_start {
	my $self = @_;
        		# location within GUI   
   	$conditions_gui->{_is_run_button}				= $true;
	return();

}



=head2

legacy?

=cut

sub set4run_button {
	my $self = @_;
	# _reset();
        		# location within GUI   
   	$conditions_gui->{_is_run_button}					= $true;
   	$conditions_gui->{_has_used_run_button}				= $true;
   	
   	# reset save and SaveAs options because
   	# file must be saved before running, always
    $conditions_gui->{_has_used_SaveAs_button}			= $false;
    $conditions_gui->{_has_used_Save_button}			= $false;	
	return();

}



=head2 sub set4run_button_end

location within GUI 

	sets 
		$conditions_gui
		
		legacy?

=cut

sub set4run_button_end {
	my $self = @_;
        		# location within GUI   
   	$conditions_gui->{_is_run_button}				= $false;
   	$conditions_gui->{_has_used_run_button}			= $false;
	return();
}

=head2 sub set4end_of_add2flow_button

		sets 
			$conditions_gui
			$add2flow_button_grey
			$flow_listbox_grey_w
			
		calls
			_reset();
		
		sees a
			listbox
			my $color 						= _get_flow_color();
=cut

sub set4end_of_add2flow_button{
	my ($self,$color) = @_;
	
	if ($color) {
		_set_gui_widgets();
		_set_flow_color($color);

   		my $flow_listbox_color_w 		= _get_flow_listbox_color_w();
   		my $add2flow_button_color		= _get_add2flow_button();
   		my $flow_listbox_color_w_text 	= 'flow_listbox_'.$color.'_w';
   		my $is_flow_listbox_color_w_text = '_is_flow_listbox_'.$color.'_w';

   	
		_set_flow_listbox_last_touched_w($flow_listbox_color_w);
		_set_flow_listbox_last_touched($flow_listbox_color_w_text);
	
							# highlight new index
   		$flow_listbox_color_w    ->selectionSet("end");
   	
							# note the last program that was touched
   		$conditions_gui->{_is_add2flow_button}				= $false;
   		$conditions_gui->{$is_flow_listbox_color_w_text}	= $true;
   	

	# keep track of which listbox was just chosen

       # disable All Add-to-flow buttons 
       # regardless of only one button having been clicked
       # For all listboxes
   		$add2flow_button_grey	->configure(
							-state=>'disabled');
	    $add2flow_button_pink	->configure(
							-state=>'disabled');
   		$add2flow_button_green	->configure(
							-state=>'disabled');
   		$add2flow_button_blue	->configure(
							-state=>'disabled');
							   	# print("1 conditions_gui,set4end_of_add2flow_button color: $color\n");
							   	
	# set flow color back to neutral after add2flow_button is clicked
	_set_flow_color('neutral');	
	   						# print("2 conditions_gui,set4end_of_add2flow_button color: $color\n");
	return();
		
	} else {
		   	print("2 conditions_gui,set4end_of_add2flow_button resetcolor: $color\n");		
	}
   
}

=head2


=cut


sub set4start_of_run_button {
	my $self = @_;
        		# location within GUI   
   	$conditions_gui->{_is_run_button}				= $true;
   	
   	if( $conditions_gui->{_flow_color}  eq 'grey') 	{  		
   		$conditions_gui->{_is_flow_listbox_grey_w}  = $true;
  		
   	} elsif ($conditions_gui->{_flow_color}  eq 'pink') {
  		$conditions_gui->{_is_flow_listbox_pink_w}   = $true;
   		
   	} elsif ($conditions_gui->{_flow_color} eq 'green') {   		
		 $conditions_gui->{_is_flow_listbox_green_w} = $true;
		    
	} elsif  ($conditions_gui->{_flow_color} eq 'blue') {
		$conditions_gui->{_is_flow_listbox_blue_w}   = $true;
		
	} else {
		print("2 conditions_gui,set4start_of_run_button missing color \n");	
	}    	
	return();
}




=head2 sub set_flow_index_last_touched


=cut

 sub set_flow_index_last_touched {
	my ($self, $index) = @_;
			# print("1. conditions_gui,last left listbox flow program touched had index = $index\n");
	if ($index >= 0) {  # -1 does exist in conditions_gui thru default definition
		$conditions_gui->{_last_flow_index_touched} 	= $index;

				# print("1. conditions_gui,last left listbox flow program touched had index = $conditions_gui->{_last_flow_index_touched}\n");	
	}else {
		print("conditions_gui,set_flow_index_touched, missing index\n");
	}
	return();
 }

=head2

 find out correct color

=cut

sub set4start_of_add2flow_button{
	my ($self,$color) = @_;
    _reset();  	
   	_set_gui_widgets();
   	_set_flow_listbox_color_w($color);
   	
   	my $flow_listbox_color_w 	    = _get_flow_listbox_color_w();
   	
	_set_flow_listbox_last_touched_w($flow_listbox_color_w);

   	$conditions_gui->{_is_add2flow_button}		= $true;
   	$conditions_gui->{_is_sunix_listbox}   			= $true;
	$conditions_gui->{_is_new_listbox_selection} 	= $true;
	
		#turn on the following buttons
    $file_menubutton	->configure(-state => 'normal');
    $run_button			->configure(-state => 'normal'); 
    $save_button		->configure(-state => 'normal');    
    $check_code_button	->configure(-state => 'normal'); 

 	#$parameter_names_frame ->configure(
#							-state=>'disabled');
# 	$parameter_values_button_frame ->configure(
#							-state=>'disabled');

       		# turn on delete button
   	$delete_from_flow_button	->configure(
						-state => 'active',);   

       		# turn on All ListBox(es) for possible later use
   $flow_listbox_grey_w    ->configure(
		        		-state => 'normal',
                      ); 
   $flow_listbox_pink_w    ->configure(
		        		-state => 'normal',
                      ); 
   $flow_listbox_green_w    ->configure(
		        		-state => 'normal',
                      ); 
   $flow_listbox_blue_w    ->configure(
		        		-state => 'normal',
                      );
   	# print("conditions_gui, set4start_of_add2flow_button, color is: $color \n");
	return();
}




=head2


=cut

sub set4start_of_sunix_select {
	my $self = @_;
	
    _reset();
    $conditions_gui->{_is_sunix_listbox} = $true;
    _set_gui_widgets();
    
    	# print("conditions_gui, set4start_of_sunix_select, $conditions_gui->{_is_sunix_listbox}\n"); 
   	$delete_from_flow_button	->configure(-state => 'disabled',);
	return();
}


=head2 sub set4superflow_select 

	print("22 conditions_gui, set4superflow_select delete_from_flow_button: $delete_from_flow_button\n");

=cut

sub set4superflow_select {
	my $self = @_;
        		# location within GUI   
	$conditions_gui->{_is_new_listbox_selection} 	= $true;
 	$conditions_gui->{_is_superflow_select_button}	= $true;
 	$conditions_gui->{_is_pre_built_superflow}		= $true;
 	
	_set_gui_widgets();
    $delete_from_flow_button	->configure(-state => 'disabled',); 	

					# turn off Flow label
    $flow_listbox_grey_w			->configure(-state => 'disabled'); 	# turn off top left flow listbox
    $flow_listbox_pink_w			->configure(-state => 'disabled'); 	# turn off top-right flow listbox  
    $flow_listbox_green_w			->configure(-state => 'disabled'); 	# turn off bottom-left flow listbox
    $flow_listbox_blue_w			->configure(-state => 'disabled'); 	# turn off bottom-right flow listbox
    $add2flow_button_grey			->configure(-state => 'disable',); 	# turn off Flow label
    $add2flow_button_pink			->configure(-state => 'disable',); 	# turn off Flow label
    $add2flow_button_green			->configure(-state => 'disable',); 	# turn off Flow label
    $add2flow_button_blue			->configure(-state => 'disable',); 	# turn off Flow label    
    $run_button						->configure(-state => 'normal'); 
    $save_button					->configure(-state => 'normal');    
    $file_menubutton				->configure(-state => 'normal'); 
    $check_code_button				->configure(-state => 'normal');  
}


1;