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
 refactoring of 2017 version of L_SU.pl

=cut 

=head2 Notes from bash
 
=cut 

	# for all
 	use Moose;
 	our $VERSION = '0.1.0';
 	
 	# potentially in all packages
	use SeismicUnixPlTk_global_constants;			

	# for 3. BOTH
	# 1.user_built_flow.pm 2.built_in__flow.pm
		# drop add2flow delete_from_flow
		# sunix_select _check4change flow_select superflow_select
		# FileDialog_button FileDialog_close 
	
	use param_widgets;
	
	# 1.user_built_flow.pm AND 2.built_in_flow.pm  i.e., BOTH
		# used in drag _stack_flow _stack_superflow move in stored flow stack_version
		# _change4check, check_code_button save_button
	use param_flow;
	
	
	# for 2.built_in_flow.pm ONLY save_button superflow_select check_code_button
	use config_superflows;
		
	# used extensively for whole-gui awareness
	use whereami;
	
	# for 1.user_built_flow.pm ONLY
 		# for drag drop increase_vigil_on_delete_counter delete_from_flow_select
		# move_in_stored_flows stack_versions flow_select set_flow_index_touched
	use flow_widgets;
	use conditions_gui;
	# use file_dialog;

	# my $grey = 0;
	
 	my $conditions_gui		= conditions_gui 	->new();
 	my $config_superflows   = config_superflows	->new();
 	# my $file_dialog 		= file_dialog 		-> new();
 	my $flow_widgets		= flow_widgets		->new();
 	my $get					= SeismicUnixPlTk_global_constants->new();
 	my $param_flow         	= param_flow 		->new();
 	my $param_widgets		= param_widgets		->new();
 	my $whereami           	= whereami			->new();

 
=head2

 share the following parameters in same name 
 space

 flow_listbox_grey_w  -left listbox, input by user selection
 flow_listbox_green_w  -right listbox,input by user selection
 sunix_listbox   -choice of listed sunix modules in a listbox

=cut
 	my ($mw);
 	my ($parameter_values_button_frame );
 	my ($parameter_names_frame,$parameter_values_frame);
 	my ($flow_listbox_grey_w,$flow_listbox_green_w,$flow_listbox_sw,$flow_listbox_se);
 	my ($dnd_token,$dropsite_token);
 	my ($run_button,$save_button,$message_w);
 	my ($sunix_listbox); 
	my ($add2flow_button_grey, $check_code_button);
	my ($delete_from_flow_button);		
 	my ($file_menubutton);

	my $var								= $get->var();
	my $on         						= $var->{_on};
	my $true       						= $var->{_true};
	my $false      						= $var->{_false};
    my $global_libs						= $get->global_libs();
    my $superflow_names     			= $get->superflow_names_h();	
 
 
=head2 Default L_SU settings{

 Create scoped hash 

=cut

 my $L_SU   = { 		 		
 	_add2flow_button_grey			=> '',
 	_check_code_button				=> '', 		 		
 	_delete_from_flow_button		=> '', 
 	_dnd_token						=> '', 
 	_dropsite_token					=> '', 
 	_file_menubutton				=> '', 
 	_flow_listbox_grey_w			=> '', 
  	_flow_listbox_green_w			=> '', 
  	_message_w						=> '',  
   	_mw								=> '', 
 	_parameter_names_frame  		=> '', 
 	_parameter_values_frame 		=> '', 
 	_parameter_values_button_frame	=> '', 	
 	_run_button						=> '',  	 	
 	_save_button					=> '', 
 	_sunix_listbox					=> '', 
	_FileDialog_option				=> '',
	_check_buttons_settings_aref    => '',
    _current_widget					=> '', 
	_current_index  				=> '',
	_current_sunix_selection_index 	=> '',
	_entry_button_label	  			=> '',	
	_error 							=> '',
	_flow_name_out					=> '',
	_flow_type						=> 'user_built', # default
	_good_labels_aref2				=> '',
	_good_values_aref2 				=> '',		
	_prog_names_aref 				=> '', 
	_name_aref    					=> '',
	_names_aref    					=> '',
	_first_index    				=> '',
    _index2move	    				=> '',
    _destination_index	 			=> '',
    _has_used_check_code_button		=> '',   # TODO check if needed?
    _has_used_Save_button			=> '',
    _has_used_saveas_flow_button	=> '',
  	_items_versions_aref 			=> '',
  	_items_values_aref2  			=> '',
  	_items_names_aref2  			=> '',
  	_items_checkbuttons_aref2 		=> '',
	_is_add2flow_button	   			=> '',
	_is_check_code_button          	=> '',
	_is_delete_from_flow_button	   	=> '',
	_is_flow_listbox_grey_w				=> '',
	_is_flow_listbox_green_w				=> '',
     is_flow_listbox_sw				=> '',
	_is_flow_listbox_se				=> '',
    _is_moveNdrop_in_flow			=> '',
    _is_run_button          		=> '',
    _is_save_button          		=> '',
    _is_saveas_file_button			=> '',
	_is_sunix_listbox				=> '',
	_is_superflow 					=> '',
	_is_sunix_listbox				=> '',
	_first    						=> '',
	_last    						=> '',
	_last_flow_index_touched	 	=> -1,
	_last_flow_listbox_touched 		=> '',
	_last_flow_listbox_touched_w 	=> '',
	_last_path_touched				=> './',
	_run_button						=> '',
	_superflows_first_idx   		=> '',
	_superflows_length    			=> '',
    _last_param    					=> '',
    _first_param    				=> '',
	_length    						=> '',
	_listbox_size 					=> '',
	_mw								=> '',   #$
	_module_name   					=> '',
	_name     						=> '',
	_num_good_checkbuttons_aref		=> '',
	_num_good_labels_aref			=> '',
	_num_good_values_aref			=> '',
	_path     						=> '',
	_param_flow_first       		=> 0,
	_param_flow_length        		=> '',
	_param_sunix_first_idx      	=> 0,
	_param_sunix_length       		=> '',
	_parameter_value_index  		=> -1,
	_prev_index  					=> '',
	_prev_prog_name   				=> '',
	_prev_ref_values_w  			=> '',
	_ref_labels  					=> '',
	_ref_labels_w  					=> '',
	_prog_name     					=> '',
	_prev_ref_labels_w  			=> '',
	_ref_param_value_button_w          	=> '',
	_ref_param_value_button_w_variable 	=> '',
	_ref_values_w  					=> '',
	_ref_values  					=> '',
	_selected_file_name 			=> '',
	_values_aref  					=> '',
    };

 
=head2 sub set_hash_ref 

	imports external hash into private settings 
 
=cut 
 	sub set_hash_ref {
 		my ($self,$hash_ref) = @_;
 		
 		$add2flow_button_grey	= $hash_ref->{_add2flow_button_grey};
 		$check_code_button		= $hash_ref->{_check_code_button}; 		 		
 		$delete_from_flow_button= $hash_ref->{_delete_from_flow_button};
 			# print("L_SU,set_hash_ref,delete_from_flow_button: $delete_from_flow_button\n");
 		$dnd_token				= $hash_ref->{_dnd_token};
 		$dropsite_token			= $hash_ref->{_dropsite_token};
 	 	$file_menubutton		= $hash_ref->{_file_menubutton};
 	 	$flow_listbox_grey_w	= $hash_ref->{_flow_listbox_grey_w};
  	 	$flow_listbox_green_w	= $hash_ref->{_flow_listbox_green_w};
  		$message_w				= $hash_ref->{_message_box_w}; 
   		$mw						= $hash_ref->{_mw};
 	 	$parameter_names_frame  = $hash_ref->{_parameter_names_frame}; 	
 	 	$parameter_values_frame = $hash_ref->{_parameter_values_frame};
 		$parameter_values_button_frame	 = $hash_ref->{_parameter_values_button_frame};	
 		$run_button				= $hash_ref->{_run_button}; 	 	
 		$save_button			= $hash_ref->{_save_button}; 
 		$sunix_listbox			= $hash_ref->{_sunix_listbox};
 	
 	 		
 		$L_SU->{_add2flow_button_grey}			= $hash_ref->{_add2flow_button_grey};
 		$L_SU->{_check_code_button}				= $hash_ref->{_check_code_button}; 		 		
 		$L_SU->{_delete_from_flow_button}		= $hash_ref->{_delete_from_flow_button};
 				# print("L_SU,set_hash_ref,delete_from_flow_button: $delete_from_flow_button\n");
 		$L_SU->{_dnd_token}						= $hash_ref->{_dnd_token};
 		$L_SU->{_dropsite_token}				= $hash_ref->{_dropsite_token};
 	 	$L_SU->{_file_menubutton}				= $hash_ref->{_file_menubutton};
 	 	$L_SU->{_flow_listbox_grey_w}			= $hash_ref->{_flow_listbox_grey_w};
  	 	$L_SU->{_flow_listbox_green_w}			= $hash_ref->{_flow_listbox_green_w};
  		$L_SU->{_message_w}						= $hash_ref->{_message_box_w}; 
   		$L_SU->{_mw}							= $hash_ref->{_mw};
 	 	$L_SU->{_parameter_names_frame}  		= $hash_ref->{_parameter_names_frame}; 	
 	 	$L_SU->{_parameter_values_frame} 		= $hash_ref->{_parameter_values_frame};
 		$L_SU->{_parameter_values_button_frame}	= $hash_ref->{_parameter_values_button_frame};	
 		$L_SU->{_run_button}					= $hash_ref->{_run_button}; 	 	
 		$L_SU->{_save_button}					= $hash_ref->{_save_button}; 
 		$L_SU->{_sunix_listbox}					= $hash_ref->{_sunix_listbox};	
 		
 		return();
 	}
 	
 sub _pre_built_superflow {
 	my $self = @_;
 	
 	$L_SU->{_flow_type}   = 'pre_built_superflow';
 	
 	# pre_built_superflows->save
 	
 	return();
 	# use pre_built_suprflows;	
 	# my $pre_built_superflows = pre_built_superflow -> new();
 	# pre_built_superflow	->flow_select;	
 }
 
  	
 sub pre_built_superflow {
 	my $self = @_;
 	
 	$L_SU->{_flow_type}   = 'pre_built_superflow';
 	
 	# pre_built_superflows->save
 	
 	return();
 	# use pre_built_suprflows;	
 	# my $pre_built_superflows = pre_built_superflow -> new();
 	# pre_built_superflow	->flow_select; 	
 }
 
 
  	
 sub user_built_flow {
 	my $self = @_;
 	
 	$L_SU->{_flow_type}   = 'user_built'; #also package default
 	
 	return();	
 }	
 	
 sub _user_built_flow {
 	my $self = @_;
 	
 	$L_SU->{_flow_type}   = 'user_built'; #also package default
 	
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
  	
  	return();
}

 	
=head2 sub FileDialog_button

	Interactively choose a file name
    that will then be entered into the
    values of the parameter frame and 
	stored away via param_flow

	independently set conditions for the use of a FileDialog_button
    find out which prior widget invoked the FileDialog_button
    For example, was it an entry button?

	#				# confirm listboxes are active
#  	if ($pre_req_ok) {

    #my $entry_changed = $param_widgets->get_entry_change_status();
     					 	# print(" L_SU, FileDialog_button, entry_change_status= $entry_changed\n"); 
    # if($entry_changed) {  
							# get program index most recently selected from left flow
     $index = $L_SU->{_last_flow_index_touched};
     print("L_SU,FileDialog_button,in left flow, program index= $index\n");

    						# get entry values of selected program from storage
# 	$param_flow			->set_flow_index($index);
# 	$L_SU->{_values_aref} 	=	$param_flow->get_values_aref();
  						 # print("2. L_SU, FileDialog_button,parameter values is @{$L_SU->{_values_aref}}\n");
							 $whereami->in_gui();
 my $index = $L_SU->{_last_flow_index_touched};
     print("L_SU,FileDialog_button,in left flow, program index= $index\n");

							 
TODO: Better encapsulation
	sets
		$messages in gui
		param_widgets
		iFile
	
	gets from
		whereami ( which sees all gui)
		parameter_values_frame
		param_widgets
		iFile
	
	calls
		_conditions   		-> set4FileDialog_select_start()
		$conditions_gui   	-> set4FileDialog_select_end();
	sees:
		messages box
		



		$file_dialog 		->set_FileDialog_director(); parameter_values_frame

=cut



sub FileDialog_button {

	my ($self,$option_sref) = @_;
	my $widget_type;
	use messages::message_director;
	use iFile;
	use whereami;
		
	# $file_dialog			->set_flow_type ($L_SU->{_flow_type});
	# $file_dialog 			->set_dialog_type ($$option_sref);
	# $file_dialog 			->set_hash_ref($L_SU);
	
	my $L_SU_messages 	    = message_director->new();
	my $whereami			= whereami->new();
	my $iFile				= new iFile;
	
	my $message          	= $L_SU_messages->null_button(0);
 	$message_w   			->delete("1.0",'end');
 	$message_w   			->insert('end', $message);
 	
 	$conditions_gui			-> set_gui_widgets($L_SU);
 	
	$L_SU->{_FileDialog_option} = $$option_sref;
				 # print("1. L_SU,FileDialog_button, option=$$option_sref \n");
				 # Select is for pre-existing Data Sets, 
				 # seen in the GUI as "File/Data"
				     #
	if ($$option_sref eq 'Select') {
			# print("4,L_SU, FileDialog,_last_flow_listbox_touched_w: $L_SU->{_last_flow_listbox_touched_w} \n");
   		$conditions_gui   	-> set4FileDialog_select_start();
   		$L_SU 				= $conditions_gui->get_hash_ref();
   			# print("3. L_SU, FileDialog,_last_flow_listbox_touched_w: $L_SU->{_last_flow_listbox_touched_w} \n");
   				# if an appropriate entry widget is first selected, ie. Entry
    			# get index of entry button pressed 
				# find out which entry button has been chosen
				# confirm that it IS the file button
				# TODO determine the required file type and file path
				# TODO from the *_spec.pm file for the particular program in the flow.
				# print("L_SU,FileDialog_button pressed\n");
						    				    
		$widget_type		= $whereami->widget_type($parameter_values_frame);
	 				   # print("L_SU  FileDialog_button selected widget type is = $widget_type	\n");

		if ($widget_type eq 'Entry' ) {
				     
				    # print("1. L_SU,FileDialog_button, selected widget_type=$widget_type \n");

   			my $selected_Entry_widget 	= $parameter_values_frame->focusCurrent;
			$param_widgets				->set_entry_button_chosen_widget($selected_Entry_widget);
					  # print("2. L_SU  FileDialog_button, selected_Entry_widget: $selected_Entry_widget\n");
			$L_SU->{_parameter_value_index} 	= $param_widgets->get_entry_button_chosen_index();
							     # print("L_SU,FileDialog_button,selection_Entry_widget HASH = $selected_Entry_widget\n");
							     # print("L_SU,FileDialog_button, parameter_value_index= $L_SU->{_parameter_value_index}\n");

			if ($L_SU->{_parameter_value_index} >= 0) { # for additional certainty; but is it needed?
							     # print("L_SU,FileDialog_button, parameter_value_index= $L_SU->{_parameter_value_index}\n");
				$L_SU->{_entry_button_label} 	= $param_widgets->get_label4entry_button_chosen();
							     # print("L_SU,FileDialog_button,entry_button_label = $L_SU->{_entry_button_label}\n");
				$iFile 				-> set_entry($L_SU);
				$iFile 				-> set_prog_name($L_SU);
				$L_SU->{_path} 		= $iFile->get_Select_path();
				
				$conditions_gui   	-> set4FileDialog_select_end();
   				$L_SU 				= $conditions_gui->get_hash_ref();
   					 # print("2. L_SU, FileDialog,_last_flow_listbox_touched_w: $L_SU->{_last_flow_listbox_touched_w} \n");
  				FileDialog();
  				FileDialog_close();
			} 
		} elsif  ($widget_type eq 'MainWindow'){  # opening random file
			$message          	= $L_SU_messages->FileDialog_button(0);
	
 	  		$message_w			->delete("1.0",'end');
 	  		$message_w			->insert('end', $message);
 	  		
		}

		$conditions_gui   	-> set4FileDialog_select_end();
   		$L_SU 				= $conditions_gui->get_hash_ref();
	}

			# Open is for perl files
	if ($$option_sref eq 'Open') {
   		$conditions_gui  -> set4FileDialog_open_start();
   		$L_SU 			= $conditions_gui->get_hash_ref();
   		
		$widget_type		= $whereami->widget_type($parameter_values_frame);
				 		# print("2. L_SU,FileDialog_button, option=$$option_sref \n");
	 				   	# print("2.L_SU  FileDialog_button selected widget type is = $widget_type	\n");
							    # print("L_SU,FileDialog_button,entry_button_label = $L_SU->{_entry_button_label}\n");
			if  ($widget_type eq 'MainWindow'){  # opening a random file

				$L_SU->{_path} 	= $iFile->get_Open_path();
  				FileDialog();
  				FileDialog_close();

			} else {

				$message          		= $L_SU_messages->FileDialog_button(0);
 	  			$message_w   			->delete("1.0",'end');
 	    		$message_w	    		->insert('end', $message);

			}

   		$conditions_gui   -> set4FileDialog_open_end();
   		$L_SU 			= $conditions_gui->get_hash_ref();
	}
							# Only user-created/regular flows can be saved
							# using SaveAs
							# superflows are not save with a new name
							# A simple save suffices for superflows.
							
	if ($$option_sref eq 'SaveAs') {
   		$conditions_gui   -> set4FileDialog_saveas_start();
   		$L_SU 			  = $conditions_gui->get_hash_ref();

    	if($L_SU->{_is_flow_listbox_grey_w} 		|| 
			$L_SU->{_is_flow_listbox_green_w} 		|| 
			$widget_type eq 'Text' 					|| 
			$widget_type eq 'DragDrop' 				|| 
			$widget_type eq 'MainWindow' ) {

			$widget_type			= $whereami->widget_type($parameter_values_frame);

			if ($widget_type eq 'Entry') {
							# always save to ~/pl
				$L_SU->{_path} 	= $iFile->get_SaveAs_path(); 
					# print("L_SU,SaveAs option for PL,FileDialog,_path: $L_SU->{_path}\n");
				$conditions_gui   -> set4FileDialog_saveas_start();
    			$L_SU 			  = $conditions_gui->get_hash_ref();
				FileDialog();
  				FileDialog_close();

			} else  {  # inactive flow
				$message          	= $L_SU_messages->FileDialog_button(0);
 	  			$message_w			->delete("1.0",'end');
 	  			$message_w			->insert('end', $message);
			}

		} else {

			$message          		= $L_SU_messages->FileDialog_button(1);
 	  		$message_w   			->delete("1.0",'end');
 	    	$message_w    			->insert('end', $message);

		}

   		$conditions_gui   -> set4FileDialog_saveas_end();
    	$L_SU 			  = $conditions_gui->get_hash_ref();
	}

   	return();
}


=head2 sub FileDialog

     print ("my file is $L_SU->{_selected_file_name}\n");
     will NOT:
        print ("1. label is @{$L_SU->{_ref_labels_w}}[$first]->cget('-text') \n");

    WILL print:
     print ("2. label is  $out\n");

     $who[$first] = $parameter_values_frame->focusCurrent;
     print("who is $who[$first]\n");
     if ($who[$first] eq @{$L_SU->{_ref_values_w}}[$first]) { 
       print("who is also @{$L_SU->{_ref_values_w}}[$first]\n");
       print ("2. label is  $out\n");
     }

   Assume that file name in labels is always first
   print ("1. Full path is  $L_SU->{_selected_file_name}\n");

	Cancel returns undefined file name

=cut

sub FileDialog {

	my $self = @_;

   	use Tk::JFileDialog;
    
   	my $mytitle 		= $L_SU->{_FileDialog_option};
   	my ($create) 		= 0;
   	my $fileDialog;
   	
   	# can be for a data or pl directory
   		# print("L_SU,FileDialog,_path:$L_SU->{_path}\n");

	$fileDialog = $mw->JFileDialog(
		-Title			=> $mytitle,
		-Path 			=> $L_SU->{_path},
		-History		=> 12,
		-HistDeleteOk 	=> 1,
		-HistUsePath	=> 1,
		-HistFile 		=> "./.FileHistory.txt",
		-PathFile 		=> "./.Bookmarks.txt",
		-Create 		=> 1
               );
				# results from interactive file selection
				 
  	$L_SU->{_selected_file_name} 	= $fileDialog->Show();
	$L_SU->{_last_path_touched} 	= $fileDialog->cget('-Path');
					   # print("L_SU,FileDialog,last path is 
					   # L_SU->{_last_path_touched} \n");
					   # print("L_SU,FileDialog,selected_file_name 
					   # is $L_SU->{_selected_file_name} \n");
   	return();
}


=head2 sub FileDialog_close

  reorganizing the display after a file is selected

  print("1. OK index:$L_SU->{_parameter_value_index}\n");
  print("2. value:@$ref_values[$L_SU->{_parameter_value_index}]\n");
  print("2. chek value:@{$L_SU->{_ref_param_value_button_w_variable}}[$current_index]\n");

  'menubutton' is for our macro sunix tools
  'frame' is for the regular sunix programs

  TODO: CASE of opening a pre-existing superflow configuration file
        or previously scripted flow  by this GUI
        BEFORE or While the menubutton OR Frame are selected

    # if(entry_button_chosen('file_name') != $failure) {
    # if($L_SU->{_current_widget} eq 'menubutton' ||  $L_SU->{_current_widget} eq 'frame' ) { 
		print("L_SU,FileDialog_close, is superflow? $L_SU->{_is_superflow_select_button}\n");
		print("L_SU,FileDialog_close, is flow? left lstbox:$L_SU->{_is_flow_listbox_grey_w},right:$L_SU->{_is_flow_listbox_green_w} \n");
  
=cut



sub FileDialog_close {
	my $self 			= @_;
	
	use messages::message_director;
	use iFile;
	use decisions 1.00;
	use control;
	
	my $L_SU_messages 	    = message_director	->new();
	my $decisions			= decisions			->new();
	my $iFile 				= iFile				->new();
	my $control				= control			->new();
	
	my @fields;
	my $full_path_name;
	
	my $option 			= $L_SU->{_FileDialog_option};
	$full_path_name 	= $L_SU->{_selected_file_name};

	if ($full_path_name ) {
  		@fields 						= split (/\//,$full_path_name);
		$L_SU->{_is_selected_file_name}	= $true;
		
	} else {
		print("FileDialog_close,Cancelled. No output flow name selected\n");
		
	}			
	
			# print("L_SU,FileDialog_close, option: $option\n");
						# Select is used to open a data file
						# Opening flows and superflow selections is also allowed
	if ($option eq  'Select') {   # Seen as DATA
		$decisions			->set4FileDialog_select($L_SU);
		my $pre_req_ok 		= $decisions->get4FileDialog_select();
			 		   	  # print("1. L_SU,FileDialog_close,pre_req_ok= $pre_req_ok \n");
			 		   
   		if ( $pre_req_ok ) { 	

						# both flows and superflows require the following    
  			my $current_index             		= $L_SU->{_parameter_value_index};
			   		  	# print("L_SU,FileDialog_close,Select,current parameter index $current_index\n");
      		@{$L_SU->{_check_buttons_settings_aref}}[$current_index] 
											= $on; 

			if( $L_SU->{_selected_file_name}) {
  							 # print("L_SU,FileDialog_close, fields= $fields[-1]\n");
  							# remove *.su suffix
  				$L_SU->{_selected_file_name} 	= $control->su_data_name(\$fields[-1]);
			} else {
  			 			# print("L_SU,FileDialog_close No file was selected\n");
			 			# print("L_SU,FileDialog_close ,last path touched was 
			 			# $L_SU->{_last_path_touched}\n") ;
			}
			 		   	# print("2. L_SU,FileDialog_close,pre_req_ok= $pre_req_ok \n");
						#  superflows require the following   
			if ( $L_SU->{_is_superflow_select_button} ) {
			 		   	 # print(" L_SU,FileDialog_close,is_superflow_select_button=
			 		   	 # $L_SU->{_is_superflow_select_button}  \n");

			   		     # print("L_SU,FileDialog_close,prog_name=
			   		     # ${$L_SU->{_prog_name}}\n");
			   		     	
						# only ProjectVariables (a superflow) which does 
						# not have files/only directories requires the following
    			if( ${$L_SU->{_prog_name}} eq $superflow_names->{_ProjectVariables} ) {

	    		@{$L_SU->{_values_aref}}[$current_index] = 	$L_SU->{_last_path_touched}; 
					 	 # print("L_SU,FileDialog_close,last path is $L_SU->{_last_path_touched} \n");
				}
			   		   # print("L_SU,FileDialog_close,superflow, selected_file_name=$L_SU->{_selected_file_name}\n");
			   		   
      		#if(@{$L_SU->{_values_aref}}[$current_index]) { # overkill? 
					@{$L_SU->{_values_aref}}[$current_index]
							= $L_SU->{_selected_file_name};  
			#}

						# only superflows require the following entry updates  
				$param_widgets->set_values($L_SU->{_values_aref});
		 		$param_widgets->redisplay_values();
			}
						# only flows require the following    
			if ( $L_SU->{_is_flow_listbox_grey_w} || $L_SU->{_is_flow_listbox_green_w}) {

      		#if(@{$L_SU->{_values_aref}}[$current_index]) { # overkill? 
					@{$L_SU->{_values_aref}}[$current_index]
							= $L_SU->{_selected_file_name};  
			 		# print("L_SU,FileDialog_close,selected_file_name  $L_SU->{_selected_file_name} \n");
			#}
					# flows will be updated via flow_select, which is activated 
					# in iFile->close()
					#  TODO iFile->close needs 		$L_SU->{_last_flow_listbox_touched_w}
					#  TODo iFile->close also needs $L_SU->{_last_flow_index_touched
					# reset focus on item last touched in flow 
					# find which listbox and which listbox_item 
					# change the Entry Value in param widgets
					# update Entry Value
   		 			# update entry in superflow OR
   		 			# go on to flow_select and update those parameters
				print("FileDialog_close\n");
				$iFile->close($L_SU);
			}
   		#$conditions_gui->set4FileDialog_select_start(); #needed?
   		#$L_SU 			= $conditions_gui->get_hash_ref();
		} # if prereq_OK
	}

				# Open means that a previous perl file is being opened
				# superflows and flows currently are not allowed to open perl files
	if ( $option eq  'Open' ) { 
		$decisions			->set4FileDialog_open($L_SU);
		my $pre_req_ok 		= $decisions->get4FileDialog_open();
		if ( $pre_req_ok ) {
				my @first_name;
			 		   	 	  # print("2. L_SU,FileDialog_close,Open,pre_req_ok= $pre_req_ok \n");
				# $L_SU->{_path} 				= $iFile->get_path();
  							  # print("L_SU,fields= $fields[-1]\n");
  							  # 	remove suffix from selected file name
  				$control							->set_file_name(\$fields[-1]);
  				$control							->set_suffix();
  				$control							->set_first_name();
  				my $suffix 							= $control->get_suffix();
  				my $first_name						= $control->get_first_name();
  							   	# print("L_SU,FileDialog_close, open,suffix: $suffix\n");

							#is this a superflow configuration file?
				if($suffix ne '') {
					if( $suffix eq 'config') {
						$L_SU->{_prog_name}  	= $iFile->get_prog_name_s($first_name);
						$first_name[0] 				= $L_SU->{_prog_name}; # historical

							# run, if superflow
						if($L_SU->{_prog_name}) {
  							  # print("L_SU,FileDialog_close, open,prog_name: $first_name[0]\n");
 								superflow_select(\$first_name[0]) ; 
						} else {
							my $message          	= $L_SU_messages->FileDialog_close(0);
 	  						$message_w				->delete("1.0",'end');
 	    					$message_w    			->insert('end', $message);
						}
							#$L_SU->{_last_path_touched} 	= $fileDialog->cget('-Path');
							
						} elsif( $suffix eq 'pl')  {
							my $message 	= $L_SU_messages->FileDialog_close(1);
 	  						$message_w   	->delete("1.0",'end');
 	    					$message_w    	->insert('end', $message);

						} else {
							my $message 	= $L_SU_messages->FileDialog_close(0);
 	  						$message_w   	->delete("1.0",'end');
 	    					$message_w    	->insert('end', $message);

						}	# if config
				} else {
					my $message 	= $L_SU_messages->FileDialog_close(0);
 	  				$message_w   	->delete("1.0",'end');
 	    			$message_w    	->insert('end', $message);

				}	# if suffix is initialized

		} else { 
					my $message 	= $L_SU_messages->FileDialog_close(2);
 	  				$message_w   	->delete("1.0",'end');
 	    			$message_w    	->insert('end', $message);

		}			#if pre_req_ok 

   					$conditions_gui->set4FileDialog_open_start(); #needed?
   					$L_SU 			= $conditions_gui->get_hash_ref();
	} 				# if open
					# superflows and flows are not allowed to open perl files 
					# TODO flows will be allowed once a parser is built



					# SaveAs is used to save a PERL file
					# regular user-created flows are allowed but
					# output superflows as PERL files do not exist and are NOT ALLOWABLE
					# the outputs from sueprflows consist of only a configuration file
					# int he ~/pl directory for most superflows
					# and in the .L_SU/configuration/active/Project.config when Project is save as a 
					# superflow
											
	if ( $option eq  'SaveAs' ) {	
				# print("2. L_SU,FileDialog_close, option: $option\n");
				# print("2. L_SU,FileDialog_close,L_SU->{_is_flow_listbox_grey_w}:$L_SU->{_is_flow_listbox_grey_w}\n");
		$conditions_gui	->set4FileDialog_saveas_start();
 		$L_SU 			= $conditions_gui->get_hash_ref();
					
		$decisions			->set4FileDialog_saveas($L_SU);
		my $pre_req_ok 		= $decisions->get4FileDialog_saveas();
		
		if ( $pre_req_ok ) {
													# print("3. L_SU,FileDialog_close, option: $option\n");

			 		   	 		# print("3. L_SU FileDialog_close,SaveAs,
			 		   	 		# pre_req_ok= $pre_req_ok \n");
  							 	# remove suffix (pl?) from selected file name
  			$control							->set_file_name(\$fields[-1]);
  			$control							->set_suffix();
  			$control							->set_first_name();
  			my $suffix 							= $control->get_suffix();
  			my $first_name						= $control->get_first_name();
			$L_SU->{_flow_name_out}          = $fields[-1];
  							   	 # print("L_SU,FileDialog_close, SaveAs,
  							   	 # suffix: $suffix\n");
  							   	 # print("L_SU,FileDialog_close, SaveAs,
  							   	 # first_name: $first_name\n");
  							   	 # print("1. L_SU,FileDialog_close, flow_name_out: $L_SU->{_flow_name_out}\n");
								# go save the file

			$conditions_gui->set4FileDialog_saveas_end();
 			$L_SU 			= $conditions_gui->get_hash_ref();
 			_save_button();
		} else{
			
			print("L_SU, FileDialog_close, option SaveAs has problems\n");
		}
		
		$conditions_gui	->set4FileDialog_saveas_end();
 		$L_SU 			= $conditions_gui->get_hash_ref();

	}
}
	


  # print(" dnd_token is $dnd_token\n");

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
  	$L_SU
  	$flow_widgets
  	
  sets to:
  	$param_flow
  	$flow_widgets
  	
  calls: stack_versions
  o/p need
	
=cut

sub drag {
  	my ($self) = @_;   
					#print("1. L_SU,drag;just starting\n");
					#print("1. L_SU,drag;listbox can not be empty\n");
					#print("1. L_SU,drag;more than one item must exist\n");
  my $prog_name;
  if($L_SU->{_prog_name}) {
	$prog_name					= ${$L_SU->{_prog_name}};
	#print("1. L_SU,drag,prog=$prog_name\n");
   }
   
			# was a program deleted through a previous dragNdrop? 
			# Has a program name even been selected or is user just playing aimlessly?
 	if( $prog_name && $flow_widgets->is_drag_deleted($flow_listbox_grey_w) ) {

		print("2.L_SU,drag; prior index was deleted\n");
        my $this_index = $flow_widgets->get_drag_deleted_index($flow_listbox_grey_w);

							 print("L_SU,drag,deleting flow_listbox,idx=$this_index\n");
    	print("index $this_index was just removed from widget\n");

						# delete stored values from param_flow
    	$param_flow->delete_selection($this_index); 

						# update program versions if listbox changes
						# store via param_flows
    	stack_versions();
		$flow_widgets->set_vigil_on_delete();
  	}						 
  
						# in case a previous drag updated the 
						# vigil_on_delete counter
						# reset drag and drop vigil_on_delete counter 
	#$flow_widgets->set_vigil_on_delete();
	
	my $num_items = $flow_widgets->get_num_items($flow_listbox_grey_w);
  						# print("L_SU,drag,num items prior to deletion  = $num_items\n");

  	if ( $num_items > 1 ) {  # num_items PRIOR to deletion
   	   $flow_widgets->drag_start($dnd_token);
	    				# print("L_SU,drag,start dnd_token:$dnd_token\n");
  	} else {
						# print("WARNING: L_SU,drag,not allowed\n");
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
   			$L_SU
   			$flow_widgets
   			$flow_listbox_grey_w  	
   	
   	 	sets:
   	 		$L_SU
   			$flow_listbox_grey_w
   			$flow_widgets

	calls external stack_versions
	calls external move_in_stored_flows
	
	happens inside a Listbox only
	
=cut

sub drop {
   my ($self) 						= @_;   
   my $done;
   my $chosen_index_to_drop 		= $flow_widgets->drag_end($dnd_token);
   my $prog_name;
   
   # listbox must have at least one item
   if($L_SU->{_prog_name}) {
	$prog_name					= ${$L_SU->{_prog_name}};
	#print("1. L_SU,drop,prog=$prog_name\n");
   }

   if ($prog_name && $chosen_index_to_drop && $chosen_index_to_drop>=0  ) {   # same as destination_index
   
   	 # print("2. L_SU,drop,prog=$prog_name\n");
   
	        			# if insertion occurs within the listbox
	 $L_SU->{_index2move} 			= $flow_widgets->index2move();
     $L_SU->{_destination_index} 	= $flow_widgets->destination_index;

							# note the last program that was touched
    						 $L_SU->{_last_flow_index_touched} 	= $L_SU->{_destination_index} ;
							 	# print(" L_SU,drop, destination index = $L_SU->{_last_flow_index_touched}\n");

			    # move stored data in agreement with this drop 
	 move_in_stored_flows(); 
				# update program versions if listbox changes
				# stored in param_flows
     stack_versions();
							 # If there is no delete while dragging
							 # the counter is also increased, so 
							 # reset drag and drop vigil_on_delete counter 
							 # this is a bug in the DragandDrop package
  							 
	$flow_widgets->set_vigil_on_delete();
	 		 				# print(" drop, done is $done\n");
	$flow_widgets->dec_vigil_on_delete_counter(2);
							# highlight new index
    $flow_listbox_grey_w    			->selectionSet(
                       			  $L_SU->{_destination_index}, 
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
	# print("L_SU,increase_vigil_on_delete_counter\n");
	return();
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

	

=cut


=head2 sub add2flow_button 


=cut

sub add2flow_button {
	
	my ($self,$value)  =@_;

 	use messages::message_director;
 	use param_sunix;
 	
 	my $param_sunix        		= param_sunix->new();
	my $L_SU_messages 	    	= message_director->new();
  	my $message          		= $L_SU_messages->null_button(0);
  	
  	my $last_item;
  	my $here;
 	$message_w   				->delete("1.0",'end');
 	$message_w   				->insert('end', $message);

			# print("L_SU,add2flow_button,L_SU->listbox_widget: $L_SU->{_flow_listbox_grey_w}\n");
 	$conditions_gui			-> set_gui_widgets($L_SU);
	$conditions_gui			-> set4start_of_add2flow_button();
 	$L_SU 					= $conditions_gui->get_hash_ref();

   	$whereami				->set4flow_listbox();

       		# clear all the indices of selected elements   
   	$sunix_listbox->selectionClear($sunix_listbox->curselection);

			# add the most recently selected program
			# name (scalar reference) to the 
			# end of the list indside flow_listbox 
    
   	$flow_listbox_grey_w    ->insert(
                       	"end", 
                       	${$L_SU->{_prog_name}},
	               );

   				# display default paramters in the GUI
    			# same as for sunix_select
    			# can not get program name from the item selected in the sunix list box 
    			# because focus is transferred to another list box
      
   	$param_sunix   							->set_program_name($L_SU->{_prog_name});
   	$L_SU->{_names_aref}  					= $param_sunix->get_names();
   	$L_SU->{_values_aref} 					= $param_sunix->get_values();
   	$L_SU->{_check_buttons_settings_aref}  	= $param_sunix->get_check_buttons_settings();
   	$L_SU->{_param_sunix_first_idx}  		= $param_sunix->first_idx(); # first index = 0
   	$L_SU->{_param_sunix_length}  			= $param_sunix->length(); # # values not index 

   	$whereami			->set4add2flow_button();
   	$here                = $whereami->get4add2flow_button();
   	$param_widgets       ->set_location_in_gui($here);

   	$param_widgets		->range($L_SU);
   	$param_widgets		->set_labels($L_SU->{_names_aref});
   	$param_widgets		->set_values($L_SU->{_values_aref});
   	$param_widgets		->set_check_buttons(
					$L_SU->{_check_buttons_settings_aref});
   	$param_widgets		->redisplay_labels();
   	$param_widgets		->redisplay_values();
   	$param_widgets		->redisplay_check_buttons();

   				# collect,store prog versions changed in list box
   	stack_versions();
   	
   				# add a single_program to the growing stack
				# store one program name, its associated parameters and their values
				# as well as the ckecbuttons in another namespace

   	_stack_flow();
				# set location to be in a flow listbox--left or right
   	$whereami			->set4flow_listbox();

	$conditions_gui    	->set4end_of_add2flow_button();
	my $index 			= $flow_widgets->get_flow_selection($flow_listbox_grey_w);
					# print("L_SU,add2flow_button,last left flow program touched had index: $index\n");
	$conditions_gui		->set_flow_index_last_touched($index);
	$L_SU 				= $conditions_gui->get_hash_ref();
					# print("L_SU,add2flow_button,last left flow program touched had index: $L_SU->{_last_flow_index_touched}\n");
						
   	return(); 
}


=head2 sub _stack_flow

  store an initial version of the parameters in another namespace for
  manipulation by the user
  the initial version comes from default parameter files
  Using the same code as for sunix_select
  print("L_SU,_stack_flow,last left listbox flow program touched had index = $L_SU->{_last_flow_index_touched}\n");
  print("L_SU,_stack_flow,values= @{$L_SU->{_values_aref}}\n");
  
=cut


sub _stack_flow {
		# store flow parameters in another namespace
  $param_flow		->stack_flow_item($L_SU->{_prog_name});
  $param_flow		->stack_values_aref2($L_SU->{_values_aref});
  $param_flow		->stack_names_aref2($L_SU->{_names_aref});
  $param_flow		->stack_checkbuttons_aref2($L_SU->{_check_buttons_settings_aref});						 
						

  return();
}

=head2 sub _stack_superflow

  store an initial version of the parameters in another namespace for
  manipulation by the user
  the initial version comes from default parameter files
  Using the same code as for sunix_select
						 print("L_SU,_stack_superflow,last left listbox flow program touched had index = $L_SU->{_last_flow_index_touched}\n");

=cut


sub _stack_superflow {
		# store flow parameters in another namespace
  $param_flow		->stack_superflow_item($L_SU->{_prog_name});
  $param_flow		->stack_values_aref2($L_SU->{_values_aref});
  $param_flow		->stack_names_aref2($L_SU->{_names_aref});
  $param_flow		->stack_checkbuttons_aref2($L_SU->{_check_buttons_settings_aref});

  return();
}


=head2 sub delete_from_flow_button

		print("L_SU, delete_from_flow_button, $here\n");
  		foreach my $key (sort keys %$here) {
   	 	print (" L_SU,delete_from_flow_button, key is $key, value is $here->{$key}\n");
   	 	
   	 	TODO: Encapsulate better
 set:
     $decisions
 
 
 get:
     $L_SU_messages
     $flow_widgets
     $param_flow	
 
 call:
    stack_versions();	
	$conditions_gui->set4last_delete_from_flow_button();
    $conditions_gui->set4delete_from_flow_button();
  $L_SU 			= $conditions_gui->get_hash_ref();
    
=cut

sub delete_from_flow_button {

	my $self = @_;
	
	use messages::message_director;
	use decisions 1.00;
	
	my $L_SU_messages 	    = message_director->new();
	my $decisions			= decisions->new();

	my $message          	= $L_SU_messages->null_button(0);
 	$message_w   			->delete("1.0",'end');
 	$message_w   			->insert('end', $message);

	$decisions				->set4delete_from_flow_button($L_SU);
	my $pre_req_ok 			= $decisions->get4delete_from_flow_button();

					# confirm listboxes are active
					# print("1. L_SU,delete_from_flow_button pre_req $pre_req_ok\n");
  	if ($pre_req_ok) {
					 # print("2. L_SU,delete_from_flow_button pre_req_ok\n");
   
  		$whereami			->set4delete_from_flow_button();
  		my $here 			= $whereami->get4delete_from_flow_button();

        			# location within GUI on first clicking delete button  
        $conditions_gui->set4delete_from_flow_button();
 		$L_SU 			= $conditions_gui->get_hash_ref();

		my $index = $flow_widgets->get_flow_selection($flow_listbox_grey_w);

					# when last item in listbox is deleted 
		if ($index == 0 && $param_flow->get_num_items == 1) {

      				 #  print("last item deleted Shut down delete button\n");
      				 #  Run and Save button
     		$flow_widgets->delete_selection($flow_listbox_grey_w);

							# the last program that was touched is cancelled out
   			$L_SU->{_last_flow_index_touched} 	= -1;

							#  print("L_SU,delete_from_flow_button,
							#  last left flow program touched had index 
							#  = $L_SU->{_last_flow_index_touched}\n");

							# delete stored programs and their parameters
   							# delete_from_stored_flows(); 
  			my $index2delete 	= $flow_widgets->get_index2delete();
  					 		# print("L_SU,delete_from_stored,index2delete:$index2delete\n");
  					 
  			$param_flow		->delete_selection($index2delete);

   							# collect and store latest program versions from changed list 
   			stack_versions();
			
			$conditions_gui->set4last_delete_from_flow_button();
 			$L_SU 			= $conditions_gui->get_hash_ref();

        					# location within GUI after last item is deleted 
        	$conditions_gui	->reset();
  			$L_SU 			= $conditions_gui->get_hash_ref();
  			
			$decisions        ->reset();

							# Blank out all the widget parameter names 
							# and their values
							
			$whereami			->set4delete_from_flow_button();
        	$here				= $whereami->get4delete_from_flow_button();
   			$param_widgets      ->set_location_in_gui($here);
   			$param_widgets		->gui_clean();
        
   		} elsif ($index >= 0) { #  i.e., more than one item remains			
			
							# note the last program that was touched
							# note the last program that was touched
							 $L_SU->{_last_flow_index_touched} = $index;

					   		# print("delete_from_flow_button, index:$index..\n");
     		$flow_widgets->delete_selection($flow_listbox_grey_w);

					# delete stored programs and their parameters
   					# delete_from_stored_flows(); 
  			my $index2delete 	= $flow_widgets->get_index2delete();
  					 		# print("2. L_SU,delete_from_stored,index2delete:$index2delete\n");
  			$param_flow		->delete_selection($index2delete);

					# update the widget parameter names and values
					# to those of new selection after deletion
  					# the chkbuttons, values and names of only the last program used 
  					# are stored in param_widgets at any one time			
  					# get parameters from storage
  			my $next_idx_selected_after_deletion = $index2delete - 1;	
            if($next_idx_selected_after_deletion == -1) { $next_idx_selected_after_deletion = 0} # NOT < 0
  					  		# print("2. L_SU,delete_from_flow_button,indexafter_deletion:
  					  		# $next_idx_selected_after_deletion\n");

   		 	$param_flow		-> set_flow_index($next_idx_selected_after_deletion);
 			$L_SU->{_names_aref} 	= $param_flow->get_names_aref();

  							 # print("2. L_SU, delete_from_flow_button,parameter names 
  							 # is @{$L_SU->{_names_aref}}\n");
 			$L_SU->{_values_aref} 	=	$param_flow->get_values_aref();

  				 			 # print("3. L_SU, delete_from_flow_button,parameter values 
  				 			 # is @{$L_SU->{_values_aref}}\n");
 			$L_SU->{_check_buttons_settings_aref} 
										=  $param_flow->get_check_buttons_settings();

  				 			 # print("4. L_SU, delete_from_flow_button, 
  				 			 # check_buttons_settings no changes, 
  				 			 # @{$L_SU->{_check_buttons_settings_aref}}, index;$index\n#");
  				 			
 				 			# get stored first index and num of items 
 			$L_SU->{_param_flow_first_idx}	= $param_flow->first_idx();
 			$L_SU->{_param_flow_length}   	= $param_flow->length();
 			$L_SU->{_prog_name}				= $param_widgets->get_current_program(\$flow_listbox_grey_w);
 			$param_widgets				 	->set_current_program($L_SU->{_prog_name});

			$whereami						->set4flow_listbox();
			$here 							= $whereami->get4flow_listbox();
				 			 # print("L_SU, delete_from_flow_button, $here->{_is_flow_listbox_grey_w}\n");
				 			 # print("L_SU, delete_from_flow_button, $here->{_is_flow_listbox_green_w}\n");
				 			 
	    	$param_widgets      		->set_location_in_gui($here);
   			$param_widgets				->gui_clean();
  			$param_widgets				->range($L_SU);
 			$param_widgets				->set_labels($L_SU->{_names_aref});
 			$param_widgets				->set_values($L_SU->{_values_aref});
 			$param_widgets				->set_check_buttons(
									$L_SU->{_check_buttons_settings_aref});

					  		 # print("L_SU, delete_from_flow_button, is listbox selected:$here->{_is_flow_listbox_grey_w}\n");
 			$param_widgets				->redisplay_labels();
 			$param_widgets				->redisplay_values();
 			$param_widgets				->redisplay_check_buttons();
#  			$param_widgets				->set_entry_change_status($false);	

							# note the last program that was touched
			 $L_SU->{_last_flow_index_touched} = $next_idx_selected_after_deletion;

   					# collect and store latest program versions from changed list 
   			stack_versions();
   		}

  	}
	
}

=head2 sub move_in_stored_flows

  move program names,
  parameter names, values and checkbutton setttings
  --- these are stored separately (via param_flows.pm)
  from GUI widgets (via flow_widgets.pm)
  The flow-widgets is a single copy of names and values
  that constantly changes as the uses interacts with the GUI
  The param-flows stores several program (items) and their
  names and values

=cut 

 sub move_in_stored_flows {
	my $self 		= @_;
   
	$L_SU->{_index2move}        	= $flow_widgets->index2move();
   	$L_SU->{_destination_index} 	= $flow_widgets->destination_index();

   	my $start						= $L_SU->{_index2move};
  	my $end	    					= $L_SU->{_destination_index};
   			 # print("L_SU,move_in_stored_flows,start index is the $start\n");
   			 # print("L_SU,move_in_stored_flows, insertion index is $end \n");

   	$param_flow->set_insert_start($start);
   	$param_flow->set_insert_end($end);
   	$param_flow->insert_selection(); 
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
   	my $help = new help();  	
   	$help->set_name($L_SU->{_prog_name});
   	$help->tkpod();
   	return();
}


=head2 sub stack_versions 

   Collect and store latest program versions from changed list 
   
   Will update listbox variables inside flow_widgets package
   Therefore pop is not needed on the array
   Use after data have been stored, deleted, or 
   suffered an insertion event

=cut

sub stack_versions {
    $flow_widgets						->set_flow_items($flow_listbox_grey_w );
    $L_SU->{_items_versions_aref} 	= $flow_widgets->items_versions_aref;
    $param_flow						->set_flow_items_version_aref($L_SU->{_items_versions_aref});
 	 # print("stack_versions,items_versions_aref: @{$L_SU->{_items_versions_aref}}\n");
}


=head2 sub sunix_select

  Pick Seismic Unix modules

  foreach my $key (sort keys %$L_SU) {
   print (" L_SU,key is $key, value is $L_SU->{$key}\n");
  }
  TODO: encapsulate better
  
  set
  	$param_sunix
  	$param_widgets
  	
  get
  	$L_SU_messages
  	$whereami					->set4sunix_listbox()
  	$param_widgets
  	$param_sunix
  	
  call:
    $conditions_gui			->set4start_of_sunix_select;
    $conditions_gui	->set4end_of_sunix_select() ;
     $L_SU 			= $conditions_gui->get_hash_ref();
 
=cut 

sub sunix_select {
   	my ($self) = @_;
   	  	
   	use messages::message_director; 
   	use param_sunix;
   	  	
	my $L_SU_messages 	    = message_director->new();
	my $param_sunix        	= param_sunix->new();
   	
   	my $message          	= $L_SU_messages->null_button(0);
 	$message_w   			->delete("1.0",'end');
 	$message_w   			->insert('end', $message);

        # location within GUI
    $conditions_gui			->set_gui_widgets($L_SU);
    $conditions_gui			->set4start_of_sunix_select();
    $L_SU 					= $conditions_gui->get_hash_ref();
    
   	$whereami				->set4sunix_listbox();
   	my $here 				= $whereami->get4sunix_listbox();

        # get program name
   	$L_SU->{_prog_name} 					= $param_widgets->get_current_program(\$sunix_listbox);
				# print("L_SU, sunix_select, program name is ${$L_SU->{_prog_name}}\n");
   	$param_sunix   							->set_program_name($L_SU->{_prog_name});
   	$L_SU->{_names_aref}  					= $param_sunix->get_names();
   	$L_SU->{_values_aref} 					= $param_sunix->get_values();
   	$L_SU->{_check_buttons_settings_aref}  	= $param_sunix->get_check_buttons_settings();
   	$L_SU->{_param_sunix_first_idx}  		= $param_sunix->first_idx();
   	$L_SU->{_param_sunix_length}  			= $param_sunix->length();

   	$param_widgets      ->set_location_in_gui($here);
   	$param_widgets		->gui_clean();
   	$param_widgets		->range($L_SU);
   	$param_widgets		->set_labels($L_SU->{_names_aref});
   	$param_widgets		->set_values($L_SU->{_values_aref});
   	$param_widgets		->set_check_buttons(
						$L_SU->{_check_buttons_settings_aref});
   	$param_widgets		->set_current_program($L_SU->{_prog_name});

						 # print("L_SU, sunix_select, $L_SU->{_is_sunix_listbox}\n");
   	$param_widgets       ->set_location_in_gui($here);
   	$param_widgets		->redisplay_labels();
   	$param_widgets		->redisplay_values();
   	$param_widgets		->redisplay_check_buttons();

    $conditions_gui	->set4end_of_sunix_select() ;
    $L_SU 			= $conditions_gui->get_hash_ref();

   	return();
}

=head2  _check4changes

	assume now that selection of a flow item will always change a previously existing
	set of flow parameters, That is, a prior program must have been touched
	if ($param_widgets->get_entry_change_status && $L_SU->{_last_flow_index_touched} >= 0) {

=cut 

sub _check4changes {
	my $self = @_;

	if ($L_SU->{_last_flow_index_touched} >= 0) {  # <-1 does exist

		my $last_idx_chng =$L_SU->{_last_flow_index_touched} ;

	 					      #  print("L_SU,_check4changes,
	 					      # last changed entry index was $last_idx_chng\n");
  							  # print("L_SU, _check4changes program name is 
  							  # ${$L_SU->{_prog_name}}\n");
  							  # the chekbuttons, values and names of only the last program used 
  							  # is stored in param_widgets at any one time			
		$L_SU->{_values_aref} 					= $param_widgets	->get_values_aref();
		$L_SU->{_names_aref} 					= $param_widgets	->get_labels_aref();
		$L_SU->{_check_buttons_settings_aref}	= $param_widgets	->get_check_buttons_aref();

  							# print("L_SU,flow_select,changed values_aref: @{$L_SU->{_values_aref}}\n");
  							# print("L_SU,_changes4changes,changed names_aref: @{$L_SU->{_names_aref}}\n");
  							# print(" L_SU,flow_select,changes, check_buttons_settings_aref: @{$L_SU->{_check_buttons_settings_aref}}\n");
  							#
   		 $param_flow	-> set_flow_index($last_idx_chng);
  						 	     # print("L_SU,flow_select,store changes in param_flow, last changed entry index $last_idx_chng\n");
  						 	    
								# save old changed values
		 $param_flow	->set_values_aref($L_SU->{_values_aref}); 		# but not the versions
	 	 $param_flow	->set_names_aref($L_SU->{_names_aref}); 		# but not the versions
		 $param_flow	->set_check_buttons_settings_aref($L_SU->{_check_buttons_settings_aref}); # BUT not the versions

		 $param_widgets	->set_entry_change_status($false);  # changes are now complete
	 	 						 # print("L_SU, flow_select, set_entry_change_status: to 0\n");
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
  
  if($L_SU->{_prog_name}) {
 		print("\n1. L_SU, flow_select, program name is $L_SU->{_prog_name}\n");
 	}

  TODO: Encapsulation is poor:
  	gets from:
    	flow_widgets
    	param_widgets
  
  	sets 
   		param_flow
  		param_widgets
    L_SU

 	calls
 	  	stack_versions
  		_check4changes();
 		$conditions_gui->set4start_of_flow_select(); 
  		$conditions_gui->set4end_of_flow_select();
  	 $L_SU 			= $conditions_gui->get_hash_ref(); 
  
=cut

sub flow_select {
	my ($self) = @_;
	
	use messages::message_director;
	use decisions;
	# use whereami;
	
	my $L_SU_messages 	        = message_director->new();
	my $decisions				= decisions->new();
	# my $whereami				= wehreami->new();
	
	my $message          		= $L_SU_messages->null_button(0);
 	$message_w   				->delete("1.0",'end');
 	$message_w   				->insert('end', $message);

				#  independently set conditions to make both flow boxes available
				#  TODO place which listbox (left or right) was chosen in $conditions_gui
    
    $conditions_gui				->set4start_of_flow_select();
 	$L_SU 						= $conditions_gui->get_hash_ref();
 		# print("TODO 1 L_SU, flow_select,_last_flow_listbox_touched_w: $L_SU->{_last_flow_listbox_touched_w} \n");
 		
    $L_SU->{_prog_name} 		= $flow_widgets->get_current_program(\$flow_listbox_grey_w);
 	  
	$decisions		 		 	->set4flow_select($L_SU);
		
	my $pre_req_ok 	  		= $decisions->get4flow_select();
	
	if ($pre_req_ok) { 
		my $here;
      						# selected program name
 		$L_SU->{_prog_name} 	= $flow_widgets->get_current_program(\$flow_listbox_grey_w);
 		
							# Is a program deleted through a previous dragNdrop?
  		if( $flow_widgets->is_drag_deleted($flow_listbox_grey_w) ) {

			  				 # print("\n\nL_SU,flow_select,something was deleted in previous dragNdrop\n");
        	my $this_index = $flow_widgets->get_drag_deleted_index($flow_listbox_grey_w);
							 # print("L_SU,flow_select,deleting flow_listbox,idx=$thi# s_index\n");
							 # 
     						 # print("index (old) $this_index was just removed from widget\n");

							# delete stored values from param_flow
     		$param_flow->delete_selection($this_index); 

							# update program versions if listbox changes
							# store via param_flows
     		stack_versions(); 

     						# reset drag and drop vigil_on_delete counter
			$flow_widgets->set_vigil_on_delete();   
		}
		                     # find out which program was previously touched
		                     # assume all prior programs touched have
		                     # modified parameters 
		                     # and update that program's stored values	
		_check4changes();
		                     
		                    # for just-selected program name
							# get its flow parameters from storage
							# and redisplay the widgets with parameters 
   		my $index 			= $flow_widgets->get_flow_selection($flow_listbox_grey_w);

  							# print("2. L_SU, flow_select,index is $index\n");
 		$param_flow					->set_flow_index($index);
 		$L_SU->{_names_aref} 	= $param_flow->get_names_aref();

  							# print("2. L_SU, flow_select,parameter names: @{$L_SU->{_names_aref}}\n");
 		$L_SU->{_values_aref} 	=	$param_flow->get_values_aref();

  				 			# print("3. L_SU, flow_select,parameter values:@{$L_SU->{_values_aref}}\n");
 		$L_SU->{_check_buttons_settings_aref} 
									=  $param_flow->get_check_buttons_settings();

  				 			# print("4. L_SU, flow_select, check_buttons_settings no changes, @{$L_SU->{_check_buttons_settings_aref}}\n");
  				 			# print("4. L_SU, flow_select,index;$index\n#");
  				 			
 				 			# get stored first index and num of items 
 		$L_SU->{_param_flow_first_idx}	= $param_flow->first_idx();
 		$L_SU->{_param_flow_length}   	= $param_flow->length();
 		$param_widgets				 		->set_current_program($L_SU->{_prog_name});

				 			  #print("L_SU, flow_select, $L_SU->{_is_flow_listbox_grey_w}\n");
				 			  # TODO!!! is the next line a problem?
		$whereami					->set4flow_listbox();
		$here 						= $whereami->get4flow_listbox();
				 			  #print("L_SU, flow_select, $here->{_is_flow_listbox_grey_w}\n");
				 			  #print("L_SU, flow_select, $here->{_is_flow_listbox_green_w}\n");
				 			 
	    $param_widgets      		->set_location_in_gui($here);
   		$param_widgets				->gui_clean();
  		$param_widgets				->range($L_SU);
 		$param_widgets				->set_labels($L_SU->{_names_aref});
 		$param_widgets				->set_values($L_SU->{_values_aref});
 		$param_widgets				->set_check_buttons(
									$L_SU->{_check_buttons_settings_aref});

					  		# print("L_SU, flow_select, is listbox selected:$here->{_is_flow_listbox_grey_w}\n");
		$whereami					->set4flow_listbox();
		$here 						= $whereami->get4flow_listbox();
		
    	$param_widgets      		->set_location_in_gui($here);
 		$param_widgets				->redisplay_labels();
 		$param_widgets				->redisplay_values();
 		
 		# Here is where you would rebind the different buttons depending on the
 		# program name that is selected (i.e. through spec.pm... do it in param widgets)
 		# $param_widgets			->set_slow_bindings();  or set_superflow_bindings();
 		$param_widgets				->redisplay_check_buttons();
  		$param_widgets				->set_entry_change_status($false);	


    	$conditions_gui->set4end_of_flow_select();
    	$conditions_gui->set_flow_index_last_touched($index);
    	$L_SU 			= $conditions_gui->get_hash_ref();      

   		return();
	}
}

=head2 sub run_button

 TODO: Encapsulate better
 
  gets from
  	$decisions
  	$L_SU
  	$name->get_alias_superflow_names
  sets
  	$pre_req_ok
  	
  calls 
	$conditions_gui		->set4run_button_start();
	$conditions_gui		->set4run_button();     
	$decisions		      	->set4run_select($L_SU);
	$conditions_gui		->set4run_button_end();
	$whereami				->in_gui();
	message box: 			$message
	 $L_SU 			= $conditions_gui->get_hash_ref();
	
	
=cut

sub run_button {
	my ($self) = @_;
	
	# print("L_SU,run_button,flow_name_out: $L_SU->{_flow_name_out}\n");
			
	use name;
	use decisions 1.00;
	use messages::message_director;
	use control;
	# use whereami;
	
	my $name 		= name->new();
	# my $whereami	= whreami->new();
	my $L_SU_messages 	    = message_director->new();
	my $decisions			= decisions->new();
	my $control				= control->new();
	
	my $message          	= $L_SU_messages->null_button(0);
 	$message_w   			->delete("1.0",'end');
 	$message_w   			->insert('end', $message);
 	
	$conditions_gui				->set4run_button_start();
	 $L_SU 			= $conditions_gui->get_hash_ref();      
	$decisions		      	->set4run_select($L_SU);
	my $pre_req_ok 	  	  	= $decisions->get4run_select();
	$whereami				->in_gui();
	
	# must have saved files already
	if ($pre_req_ok) {
				# for saved superflow configuration files
		if( $L_SU->{_is_superflow_select_button} ) {
    	 		 # print("L_SU,run_button,program name is ${$L_SU->{_prog_name}}\n"); 
    		my $run_name 			= $name->get_alias_superflow_names($L_SU->{_prog_name});
  			system ("perl $global_libs->{_superflows}$run_name"); 	
  				 # print("L_SU,run_button, running: $global_libs->{_superflows}$run_name\n");
		}
				# for saved regular flows 
    	if( $L_SU->{_is_flow_listbox_grey_w} || 
	    	$L_SU->{_is_flow_listbox_green_w} ) {
	    	save_button;
    		# print("L_SU,run_button,program name is ${$L_SU->{_prog_name}}\n"); 
    		# print("L_SU, 1. run button, checking accuracy of inserted values\n");
    		
			# TODO: pre-run check
    		# $control	->set_prog_param_labels_aref2($L_SU);
 			# $control	->set_prog_param_values_aref2($L_SU);
 			# $control	->set_prog_names_aref($L_SU);
 			# $control	->set_items_versions_aref($L_SU);
 			# my $ok2run	= $control->get_conditions();
 			
 			my $ok2run = $true;
 			
 			if ($ok2run) {
 				my $run_name 		= $L_SU->{_flow_name_out};
 				use Project;
 				my $Project 		= Project->new();
 				my $PL_SEISMIC 	 	= $Project->PL_SEISMIC();
 				 
				# print("L_SU,run_button, running: $run_name\n");
  				system ("perl $PL_SEISMIC/$run_name");
 			}

		}
			
		$conditions_gui->set4run_button();
		 $L_SU 			= $conditions_gui->get_hash_ref(); 
	} else {
			my $message          	= $L_SU_messages->run_button(0);
 	  		$message_w   			->delete("1.0",'end');
 	  		$message_w   			->insert('end', $message);
	}
	
 	$conditions_gui->set4run_button_end();
 	 $L_SU 			= $conditions_gui->get_hash_ref();
	return();
}

 
=head2 sub superflow_select

   Provides in-house macros/superflows
   1. Find widget you have selected

  if widget_name= frame then we have flow
              $var->{_flow}
  if widget_name= menubutton we have superflow 
              $var->{_tool}

   2. Set the new program name 

     4. Make widget states active for:
       run_button
       save_button

     5. Disable the following widgets:
       delete_from_flow_button
      (sunix) flow_listbox

    print("L_SU,superflow_select,program name is $L_SU->{_prog_name}\n"); 
    print(" L_SU,superflow_select, is tool: is $L_SU->{_is_superflow_select_button}\n"); 
    print(" L_SU,superflow_select,is sunix_module $L_SU->{_is_sunix_module}\n"); 
    print(" L_SU,superflow_select,widget: $L_SU->{_current_widget}\n"); 
    print(" L_SU,superflow_select,widget: $var->{_superflow}\n"); 
 
    scalar reference:
      print("LSU_Tk,superflow_select,prog_name: ${$L_SU->{_prog_name}}\n");
    array reference:
      print("LSU_Tk,superflow_select: _names_aref @{$L_SU->{_names_aref}}\n");

=cut

=pod sketch


sub pre_built_superflow {
	
	my ($self,$value)  = @_;
	use superflow_select;
	my $superflow_select = superrflow_select->new();
	
	if ($value  eq 'select' ) {
		$conditions_gui			->set4superflow_select();
		 $L_SU 			= $conditions_gui->get_hash_ref();
		
		$superflow_select   ->set_whereami($parameter_frame)
		$superflow_select	->set_prog_name($L_SU->{_prog_name});
		$superflow_select	->get_prog_name();
		$superflow_select	->gui(); 	# do $param_widgets stuff
		
	} elsif
				
	} else {
		print("L_SU,pre_built_superflow, error in selection\n");	
	}
	
	
	return();
}

sub _pre_built_superflow {
	
	my ($value)  = @_;
	use superflow_select;
	my $superflow_select = superrflow_select->new();
	
	if ($value  eq 'save' ) {
		$conditions_gui			->set4superflow_select();
		 $L_SU 			= $conditions_gui->get_hash_ref();
		
		$superflow_select   ->set_whereami($parameter_frame)
		$superflow_select	->set_prog_name($L_SU->{_prog_name});
		$superflow_select	->get_prog_name();
		$superflow_select	->gui(); 	# do $param_widgets stuff
		
				
	} else {
		print("L_SU,pre_built_superflow, error in selection\n");	
	}
	
	
	return();
}

=cut

sub superflow_select {
 	my ($self,$superflow_name_sref) = @_; 
 	
 	use messages::message_director;
 	# use whereami;
   	
   	# my $whereami				= whereami->new();
	my $L_SU_messages 	    	= message_director->new();
 	
 	my $message          		= $L_SU_messages->null_button(0);
 	$message_w   				->delete("1.0",'end');
 	$message_w   				->insert('end', $message);

        		       	# local location within GUI
    $conditions_gui				->set_gui_widgets($L_SU);
	$conditions_gui				->set4superflow_select();
	$L_SU 						= $conditions_gui->get_hash_ref();

						# set location in gui
	$whereami					->set4superflow_select_button();

   	     				# get and set program name (scalar ref), including alias
  	$L_SU->{_prog_name} 		= $superflow_name_sref;
						# print("L_SU,superflow_select,prog=${$L_SU->{_prog_name}}\n");
   	
   	$config_superflows   		->set_program_name($L_SU->{_prog_name});
        
   	     				# parameter names from superflow configuration file
   	$L_SU->{_names_aref}  	= $config_superflows->get_names();
						#  print("L_SU,superflow_select,prog=@{$L_SU->{_names_aref}}\n");

     					# parameter values from superflow configuration file
   	$L_SU->{_values_aref} 	= $config_superflows->get_values();
						 #  print("L_SU,superflow_select,valu=@{$L_SU->{_values_aref}}\n");
   	
   	$L_SU->{_check_buttons_settings_aref}  	= $config_superflows->get_check_buttons_settings();
						 # print("L_SU,superflow_select,chkb=@{$L_SU->{_check_buttons_settings_aref}}\n");

   	$L_SU->{_superflows_first_idx}  	= $config_superflows->first_idx();
   	$L_SU->{_superflows_length}  	= $config_superflows->length();

					# Blank out all the widget parameter names and their values
   	my $here			= $whereami->get4superflow_select_button();
   	$param_widgets      ->set_location_in_gui($here);
   	$param_widgets		->gui_clean();

   	$param_widgets		->range($L_SU);
   	$param_widgets		->set_labels($L_SU->{_names_aref});
   	$param_widgets		->set_values($L_SU->{_values_aref});
   	$param_widgets		->set_check_buttons(
						$L_SU->{_check_buttons_settings_aref});
						
 	$param_widgets		->set_current_program($L_SU->{_prog_name});
						 		
 		# Here is where you would rebind the different buttons depending on the
 		# program name that is selected (i.e. through spec.pm... do it in param widgets)
 		# $param_widgets			->set_superflow_bindings();
	$param_widgets		->redisplay_labels();
   	$param_widgets		->redisplay_values();
   	$param_widgets		->redisplay_check_buttons();

}


=head2 sub check_code_button 

TODO: foreseeable errors

TODO: If it is a superflow:
					Sudipfilter
							In sunix package: are filter values increasing monotonically

	  If it is a user flow: 
	  	If dealing with sunix? (ASSUMED)
	  		Are the modules incompatible?
	  		Do we have a minimum number of modules?
	  		Are there too many modules?
	  		Are the modules in the correct order?
	  		Are there any missing modules?
	  	
	  			Collect the names of sunix moduels in the flow
	  	      	For each individual sunix module: 
	  						sufilter:  are filter values increasing monotonically
	  								
	  						sudipfilt: are filter values increasing monotonically
	  						
	  						data_in  : does the file exist?
	  								 : is the file of a non-zero finite size
	  								 
	  						sugain:  incompatibilities
	  						
	  						# FUTURE CASES not implemented flows
	  	If dealing with gmt?							
	  		If in individual gmt module:
	  	
	  	If dealing with grass?		  
	  		If in individual grass module:
	  		
	  	If dealing with sqlite ?
	  		If in individual sqlite module:

=cut                           

sub check_code_button {
 	my ($self, $value) 				= @_;
 	use messages::message_director;
 	# use whereami;
 	
	my $L_SU_messages 	    = message_director->new();
	# my $whereami			= new whereami;

	my $message          	= $L_SU_messages->null_button(0);
 	$message_w   			->delete("1.0",'end');
 	$message_w   			->insert('end', $message); 	
 	
	$conditions_gui	->set4start_of_check_code_button();
	 $L_SU 			= $conditions_gui->get_hash_ref();
	
        	# location within GUI   
	my $widget_type		= $whereami->widget_type($parameter_values_frame);
			  # print("L_SU,check_code_button,widget_type = $widget_type\n");
			 

			# for superflows only
			# print("L_SU,check_code_button,is_superflow_select_button:$L_SU->{_is_superflow_select_button}\n");
    if($L_SU->{_is_superflow_select_button}) {
#		$config_superflows	->save($L_SU);
#		$conditions_gui	->set4_save_button();
# $L_SU 			= $conditions_gui->get_hash_ref();
#		
#		# for flow but only if activated
	} elsif ( ($L_SU->{_is_flow_listbox_grey_w} || 
	    $L_SU->{_is_flow_listbox_green_w}) &&
	    $widget_type eq 'Entry' )  {		

			# 
			# consider empty case	
#		if( !($L_SU->{_flow_name_out}) ||
#			$L_SU->{_flow_name_out} eq '') {
#
#			$message          	= $L_SU_messages->save_button(1);
# 	  		$message->delete("1.0",'end');
# 	  		$message->insert('end', $message);
#
#		} else {  # good case
#			# print("1. save_button, saving flow: $L_SU->{_flow_name_out}\n");
#    	}
    	
		_check4changes(); 	
		$param_flow->set_good_values;
		$param_flow->set_good_labels;
		$L_SU->{_good_labels_aref2}	= $param_flow->get_good_labels_aref2;
		$L_SU->{_items_versions_aref}= $param_flow->get_flow_items_version_aref;
		$L_SU->{_good_values_aref2} 	= $param_flow->get_good_values_aref2;
		$L_SU->{_prog_names_aref} 	= $param_flow->get_flow_prog_names_aref;
		
				# print("L_SU,check_code_button, program names are: @{$L_SU->{_prog_names_aref}} \n");
		my $length = scalar @{$L_SU->{_prog_names_aref}};
				# print("L_SU,check_code_button,There is/are $length program(s) in flow\n");
		
		for (my $prog_num = 0; $prog_num < $length; $prog_num++ ) {
				# print("L_SU,check_code_button, program # $prog_num in flow is
			  	# @{$L_SU->{_prog_names_aref}}[$prog_num]\n");
			# my $prog_name  = @{$L_SU->{_prog_names_aref}}[$prog_num];
			# require ($prog_name);
			# $prog_name->set_code_values($L_SU->{_good_values_aref2});
			# $prog_name->get_code_suggestions();
		}

# 		$files_LSU	->set_prog_param_labels_aref2($L_SU);
# 		$files_LSU	->set_prog_param_values_aref2($L_SU);
# 		$files_LSU	->set_prog_names_aref($L_SU);
# 		$files_LSU	->set_items_versions_aref($L_SU);
# 		$files_LSU	->set_data();
# 		$files_LSU	->set_message($L_SU);
#		$files_LSU	->set2pl($L_SU); # flows saved to PL_SEISMIC
#		$files_LSU	->save();
#		$conditions_gui	->set4_save_button();
# $L_SU 			= $conditions_gui->get_hash_ref();
#		
	} else { # if flow first needs a change for activation
#
#		$message          	= $L_SU_messages->check_code_button(0);
# 	  	$message_w			->delete("1.0",'end');
# 	  	$message_w			->insert('end', $message);
	}
	
	$conditions_gui	->set4end_of_check_code_button();
	 $L_SU 			= $conditions_gui->get_hash_ref();
   	return();
}



=head2 sub save_button_director



 prior to saving
 determine if we are dealing with superflow 
 (" menubutton" widget)   
 - collect and/or access flow parameters
 - default path is the current path

 TODO:
 or with GUI-made flows ("frame widget")
 - collect and/or access flow parameters
 - default path is the current path

DB:
 print("current widget is $LSU->{_current_widget}\n"); 
 
 TODO: improve ENCAPSULATION:
 
 Analysis:
 
 i/p: $parameter_values_frame
 i/p: $L_SU_messages
 i/p: $message
 i/p: $param_flow
 i/p: $L_SU
 i/p: $config_superflows
 
 o/p: $conditions_gui	->set4start_of_save_button();
 o/p: $conditions_gui	->set4_save_button
 o/p: $conditions_gui	->set4end_of_save_button();
  $L_SU 			= $conditions_gui->get_hash_ref();
 o/p: _check4changes();
 
 o/p: $L_SU
 o/p: $files_LSU
		


=cut

sub save_button_director {
	
	if ($L_SU->{_flow_type} eq 'user_built ') {
		# save_user_built_flow(); 
	
	
	} elsif ($L_SU->{_flow_type} eq 'pre_built_superflow ') {
		# save_pre_built_superflow(); 
	
	} else {
	print("L_SU,save_button, flow type unrecognized\n");
	
}
	
	
}

sub _save_button_director {
	
	if ($L_SU->{_flow_type} eq 'user_built ') {
		# save_user_built_flow(); 
	
	
	} elsif ($L_SU->{_flow_type} eq 'pre_built_superflow ') {
		# save_pre_built_superflow(); 
	
	} else {
	print("L_SU,save_button, flow type unrecognized\n");
	
	}
		
}
=head2 sub save_button

	Only for Perl files or superflow files
	Not for DATA

=cut

sub save_button {
 	my ($self,$value) 				= @_;
 	use save;
	use files_LSU;
	use messages::message_director;
	# use whereami;
	
	my $L_SU_messages 	    = message_director->new();
	# my $whereami			= whereami->new();
	
 	my $save 				= new save();
 	my $files_LSU			= new files_LSU();
 	
	my $message          	= $L_SU_messages->null_button(0);
 	$message_w   			->delete("1.0",'end');
 	$message_w   			->insert('end', $message); 	
 	
	$conditions_gui			->set4start_of_save_button();
	$L_SU 					= $conditions_gui->get_hash_ref();
	
        	# location within GUI   
	my $widget_type		= $whereami->widget_type($parameter_values_frame);
			# print("L_SU,save_button,widget_type = $widget_type\n");

			# FOR SUPERFLOWS only
			# print("L_SU,save_button,is_superflow_select_button:$L_SU->{_is_superflow_select_button}\n");
    if($L_SU->{_is_superflow_select_button}) {
		$config_superflows	->save($L_SU);
		$conditions_gui		->set4_save_button();
		$L_SU 				= $conditions_gui->get_hash_ref();
		
		# for REGULAR FLOWS but only if activated
	} elsif ( ($L_SU->{_is_flow_listbox_grey_w} || 
	    $L_SU->{_is_flow_listbox_green_w}) &&
	    $widget_type eq 'Entry' )  {		

			# consider empty case	
		if( !($L_SU->{_flow_name_out}) ||
			$L_SU->{_flow_name_out} eq '') {

			$message          	= $L_SU_messages->save_button(1);
 	  		$message_w			->delete("1.0",'end');
 	  		$message_w			->insert('end', $message);

		} else {  # good case
			# print("1. save_button, saving flow: $L_SU->{_flow_name_out}\n");
    	}
    	
		_check4changes(); 	
		$param_flow->set_good_values;
		$param_flow->set_good_labels;
		$L_SU->{_good_labels_aref2}		= $param_flow->get_good_labels_aref2;
		$L_SU->{_items_versions_aref}	= $param_flow->get_flow_items_version_aref;
		$L_SU->{_good_values_aref2} 	= $param_flow->get_good_values_aref2;
		$L_SU->{_prog_names_aref} 		= $param_flow->get_flow_prog_names_aref;

		 		# print("save_button,_prog_names_aref,
		 		# @{$L_SU->{_prog_names_aref}}\n");
		# my $num_items4flow = scalar @{$L_SU->{_good_labels_aref2}};

				 # for (my $i=0; $i < $num_items4flow; $i++ ) {
					# print("save_button,_good_labels_aref2,
				# @{@{$L_SU->{_good_labels_aref2}}[$i]}\n");
				# }

				# for (my $i=0; $i < $num_items4flow; $i++ ) {
				#	print("save_button,_good_values_aref2,
				#	@{@{$L_SU->{_good_values_aref2}}[$i]}\n");
				#}
				#   print("save_button,_prog_versions_aref,
				#   @{$L_SU->{_items_versions_aref}}\n");

 		$files_LSU	->set_prog_param_labels_aref2($L_SU);
 		$files_LSU	->set_prog_param_values_aref2($L_SU);
 		$files_LSU	->set_prog_names_aref($L_SU);
 		$files_LSU	->set_items_versions_aref($L_SU);
 		$files_LSU	->set_data();
 		$files_LSU	->set_message($L_SU);
		$files_LSU	->set2pl($L_SU); # flows saved to PL_SEISMIC
		$files_LSU	->save();
		
		$conditions_gui	->set4_save_button();
		 $L_SU 			= $conditions_gui->get_hash_ref();
		
	} else { # if flow first needs a change for activation

		$message          	= $L_SU_messages->save_button(0);
 	  	$message_w			->delete("1.0",'end');
 	  	$message_w			->insert('end', $message);
	}
	
	$conditions_gui	->set4end_of_save_button();
	 $L_SU 			= $conditions_gui->get_hash_ref();
   	return();
}


=head2 sub _save_button 


=cut

sub _save_button {
 	my ($self) 				= @_;
 	
 	use save;
	use files_LSU;
	use messages::message_director;
	# use whereami;
	
	my $L_SU_messages 	    = message_director->new();
	# my $whereami			= whereami->new();
	
 	my $save 				= new save();
 	my $files_LSU			= new files_LSU();
 	
	my $message          	= $L_SU_messages->null_button(0);
 	$message_w   			->delete("1.0",'end');
 	$message_w   			->insert('end', $message); 	
 	
	$conditions_gui	->set4start_of_save_button();
	$L_SU 			= $conditions_gui->get_hash_ref();
	
        	# location within GUI   
	my $widget_type		= $whereami->widget_type($parameter_values_frame);
			# print("L_SU,save_button,widget_type = $widget_type\n");

			# FOR SUPERFLOWS only
			# print("L_SU,save_button,is_superflow_select_button:$L_SU->{_is_superflow_select_button}\n");
    if($L_SU->{_is_superflow_select_button}) {
		$config_superflows	->save($L_SU);
		$conditions_gui		->set4_save_button();
		 $L_SU 			= $conditions_gui->get_hash_ref();
		
		# for REGULAR FLOWS but only if activated
	} elsif ( ($L_SU->{_is_flow_listbox_grey_w} || 
	    $L_SU->{_is_flow_listbox_green_w}) &&
	    $widget_type eq 'Entry' )  {		

			# consider empty case	
		if( !($L_SU->{_flow_name_out}) ||
			$L_SU->{_flow_name_out} eq '') {

			$message          = $L_SU_messages->save_button(1);
 	  		$message_w		->delete("1.0",'end');
 	  		$message_w		->insert('end', $message);

		} else {  # good case
			# print("1. save_button, saving flow: $L_SU->{_flow_name_out}\n");
    	}
    	
		_check4changes(); 	
		$param_flow						->set_good_values;
		$param_flow						->set_good_labels;
		$L_SU->{_good_labels_aref2}		= $param_flow->get_good_labels_aref2;
		$L_SU->{_items_versions_aref}	= $param_flow->get_flow_items_version_aref;
		$L_SU->{_good_values_aref2} 	= $param_flow->get_good_values_aref2;
		$L_SU->{_prog_names_aref} 		= $param_flow->get_flow_prog_names_aref;

		 		# print("save_button,_prog_names_aref,
		 		# @{$L_SU->{_prog_names_aref}}\n");
		# my $num_items4flow = scalar @{$L_SU->{_good_labels_aref2}};

				 # for (my $i=0; $i < $num_items4flow; $i++ ) {
					# print("save_button,_good_labels_aref2,
				# @{@{$L_SU->{_good_labels_aref2}}[$i]}\n");
				# }

				# for (my $i=0; $i < $num_items4flow; $i++ ) {
				#	print("save_button,_good_values_aref2,
				#	@{@{$L_SU->{_good_values_aref2}}[$i]}\n");
				#}
				#   print("save_button,_prog_versions_aref,
				#   @{$L_SU->{_items_versions_aref}}\n");

 		$files_LSU	->set_prog_param_labels_aref2($L_SU);
 		$files_LSU	->set_prog_param_values_aref2($L_SU);
 		$files_LSU	->set_prog_names_aref($L_SU);
 		$files_LSU	->set_items_versions_aref($L_SU);
 		$files_LSU	->set_data();
 		$files_LSU	->set_message($L_SU);
		$files_LSU	->set2pl($L_SU); # flows saved to PL_SEISMIC
		$files_LSU	->save();
		$conditions_gui	->set4_save_button();
		$L_SU 			= $conditions_gui->get_hash_ref();
		
	} else { # if flow first needs a change for activation

		$message          	= $L_SU_messages->save_button(0);
 	  	$message_w			->delete("1.0",'end');
 	  	$message_w			->insert('end', $message);
	}
	
	$conditions_gui	->set4end_of_save_button();
	$L_SU 			= $conditions_gui->get_hash_ref();
   	return();
}

# 12. see if CAGEo or SRL will accept code
 	
 1;
