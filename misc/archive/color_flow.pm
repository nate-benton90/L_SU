package color_flow;

=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL PACKAGE NAME: color_flow.pm
 AUTHOR: 	Juan Lorenzo
 DATE: 		June 8 2018 

 DESCRIPTION 
     

 BASED ON:
 previous versions of the main color_flow.pl
  

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
    
    flow_listbox_grey_w  	-top left listbox, input by user selection
    flow_listbox_green_w  	-bottom right listbox,input by user selection
    sunix_listbox   		-choice of listed sunix modules in a listbox
    
    

=head4 Examples

=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES
 refactoring of 2017 version of L_SU.pl

=cut 

=head2 Notes 

sub sunix_select (subroutine is only active in neutral_flow.pm)
 
=cut 

 	use Moose;
 	our $VERSION = '0.0.1';			 
	
	use param_widgets_grey;  
	use param_flow_grey 0.0.2 ; 
	use param_flow_pink 0.0.2 ; 
	use param_flow_green 0.0.2; 
	use param_flow_blue 0.0.2; 
	
	use whereami;  # used extensively for whole-gui awareness
	use flow_widgets;
	use conditions_gui;
	
 	my $conditions_gui		= conditions_gui 	->new();
 	my $flow_widgets		= flow_widgets		->new();
 	my $get					= SeismicUnixPlTk_global_constants->new();
 	my $param_flow_grey    	= param_flow_grey 	->new();
 	my $param_flow_pink    	= param_flow_pink 	->new();
  	my $param_flow_green    = param_flow_green 	->new();
   	my $param_flow_blue    	= param_flow_blue 	->new();
 		# print("color flow, make param_flow instance grey: $param_flow_grey \n pink: $param_flow_pink green:$param_flow_green blue: $param_flow_blue\n");
 	my $param_widgets		= param_widgets_grey ->new();
 	my $whereami           	= whereami			->new();
 	my $flow_type			= $get->flow_type_href();

 
=head2

 share the following parameters in same name 
 space

=cut

	my $Data_menubutton;
	my $Flow_menubutton;
	my $SaveAs_menubutton;
 	my $FileDialog_sub_ref;
 	my $FileDialog_option;
   	my $is_pre_built_superflow;
    my $is_user_built_flow;
 	my $mw;

 	my $flow_listbox_grey_w;
 	my $flow_listbox_pink_w;
 	my $flow_listbox_green_w;
 	my $flow_listbox_blue_w;
 	my $flow_listbox_color_w;
 	my $flow_color;
 	my ($flow_name_grey_w,$flow_name_pink_w,$flow_name_green_w,$flow_name_blue_w);
 	my $flow_name_color_w;
 	my ($flowNsuperflow_name_w);
 	my ($dnd_token_grey,$dnd_token_pink,$dnd_token_green,$dnd_token_blue);
 	my ($dropsite_token_grey, $dropsite_token_pink,$dropsite_token_green,$dropsite_token_blue);
 	my ($labels_w_aref, $values_w_aref, $check_buttons_w_aref);
 	my $message_w;
 	my $parameter_values_button_frame;
 	my $parameter_names_frame;
 	my $parameter_values_frame;
 	my $prog_name_sref;
 	my $run_button;
 	my $sunix_listbox;

	my ($add2flow_button_grey, $add2flow_button_pink, $add2flow_button_green, $add2flow_button_blue, $check_code_button);
	my $delete_from_flow_button;
	my $dialog_type;	
 	my $file_menubutton;
 	my ($flow_item_down_arrow_button, $flow_item_up_arrow_button);
 	my $save_button;
 	
 	# instance (i) of a hash reference
 	# value of the hash changes depending on the color-flow in use
 	# value is change in _set_param_flow_color_i 
 	# not for export
 	my $param_flow_color_i;  

	my $var								= $get->var();
#	my $on         						= $var->{_on};
	my $true       						= $var->{_true};
	my $false      						= $var->{_false};	
  	my @empty_array = (0); # length=1
 

=head2 private hash

	112 off 
	_is_flow_listbox_color_w is generic colored widget
	Warning: conditions_gui.pm does not contain all the hash keys and values
	that follow-- these variables will be reset by conditions_gui.p.

=cut

my $color_flow   = {

	_Data_menubutton				=> '',
	_Flow_menubutton				=> '',
	_FileDialog_sub_ref				=> '',
	_FileDialog_option				=> '',
	_SaveAs_menubutton				=> '',	
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
   	_flow_listbox_color_w			=> '', #
   	_flow_name_grey_w				=> '',
   	_flow_name_pink_w				=> '',
   	_flow_name_green_w				=> '',
   	_flow_name_blue_w				=> '',
   	_flow_name_color_w				=> '',   # TBAdded to all programs 	
   	_flow_name_out					=> '',#
   	_flow_name_in					=> '',
  	_flow_type						=> $flow_type->{_user_built},#
    _flow_widget_index				=> '',#
 	_flowNsuperflow_name_w			=> '',
	_good_labels_aref2				=> '',
	_good_values_aref2 				=> '',
	_has_used_open_perl_file_button => '',
    _has_used_Save_button			=> '',	#
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
	_is_last_flow_index_touched_grey 		=>  $false,
	_is_last_flow_index_touched_pink 		=>  $false,
	_is_last_flow_index_touched_green 		=>  $false,
	_is_last_flow_index_touched_blue 		=>  $false,
	_is_last_flow_index_touched 			=> $false,
	_is_last_parameter_index_touched_grey 	=> $false,
	_is_last_parameter_index_touched_pink 	=> $false,
	_is_last_parameter_index_touched_green	=> $false,
	_is_last_parameter_index_touched_blue 	=> $false,
	_is_last_parameter_index_touched_color => $false,	
    _is_moveNdrop_in_flow			=> '',
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
  	_last_flow_index_touched_grey   => -1,
   	_last_flow_index_touched_pink   => -1,
    _last_flow_index_touched_green   => -1,
    _last_flow_index_touched_blue   => -1,
 	_last_flow_listbox_touched 		=> '',
 	_last_flow_listbox_touched_w	=> -1,
 	_last_parameter_index_touched_color   => -1,#
 	_last_parameter_index_touched_grey		=> -1,
  	_last_parameter_index_touched_pink		=> -1,
   	_last_parameter_index_touched_green		=> -1,
    _last_parameter_index_touched_blue		=> -1,
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


=head2 sub _add2flow

	When reading a user-built perl flow
	Incorporate new prorgam parameter values and labels into the gui
	and save the values, labels and checkbuttons setting in the param_flow
	namespace

=cut

sub _add2flow {
	
	my ($self,$value)  = @_;

	$color_flow->{_flow_type} = $flow_type->{_user_built};
	 	# print("1. color_flow, add2flow_button, color: $flow_color \n");
	 	# print("2. color_flow, add2flow_button, _values_w_aref $values_w_aref}\n");
		# print("3. color_flowadd2flow_button: _last_parameter_index_touched $color_flow->{_last_parameter_index_touched_color}\n");
	       
 	use messages::message_director;
 	
	my $color_flow_messages 	= message_director->new();
  	my $message          		= $color_flow_messages->null_button(0);
  	
  	my $here;
 	 		# print("color_flow,_add2flow, labels: @{$color_flow->{_names_aref}}\n");  	
  	    	# print("4. color_flow, add2flow_button, _values_w_aref $color_flow->{_values_w_aref}\n");
 			# print("color_flow,_add2flow,check_buttons_settings : @{$color_flow->{_check_buttons_settings_aref}}\n");
  	$conditions_gui				-> set_gui_widgets($color_flow);  	# 26 used  / 112 in
 	$conditions_gui				-> set_hash_ref($color_flow);	 	# 62 used / 112 in
	$conditions_gui				-> set4start_of_add2flow($flow_color);  #  set and 10 widgets configured	
	$color_flow					= $conditions_gui-> get_hash_ref();  	# 88 returned	

	 			# print("5. color_flow, add2flow_button, color: $flow_color \n"); 	
 	$message_w   				->delete("1.0",'end');
 	$message_w   				->insert('end', $message);	
			 
    			# print("6. color_flow, add2flow_button, _prog_name_sref: ${$color_flow->{_prog_name_sref}}\n"); 
    			# print("7. color_flow, add2flow_button, _values_w_aref $color_flow->{_values_w_aref}\n");
    
			# add the most recently selected program
			# name (scalar reference) to the 
			# end of the list indside flow_listbox 
    _set_flow_listbox_color_w($flow_color); # in "color"_flow namespace
    
   				# print("8. color_flow, add2flow_button, _is_flow_listbox_grey_w $color_flow->{_is_flow_listbox_grey_w}\n");
   				# print("9. color_flow,add2flow_button,color_flow->listbox_widget: $color_flow->{_flow_listbox_color_w}\n");
   
   	# append new program names to the end of the list but this item is NOT selected
   	# selection occurs inside conditions_gui
   	$color_flow->{_flow_listbox_color_w} ->insert(
                       	"end", 
                       	${$color_flow->{_prog_name_sref}},
	               );

   			# display default paramters in the GUI
    		# same as for sunix_select
    		# can not get program name from the item selected in the sunix list box 
    		# because focus is transferred to a flow list box  (grey, pink,green or blue)
    				  
	$here 				= $whereami->set4add2flow();   # checking 		
   		 		# print("13. color_flow, add2flow_button, color: $flow_color \n");
   		 		# print (" color_flow, _add2flow, _is_add2flow: $color_flow->{_is_add2flow}\n");
   	$here                = $whereami->get4add2flow();
	$param_widgets       ->set_location_in_gui($here);
	
	# widgets are initialized in a super class
	# Assign program parameters in the GUI	
	# no. of parameters defaults to max=112
	
	$param_widgets		-> set_labels_w_aref($color_flow->{_labels_w_aref} );
	$param_widgets		-> set_values_w_aref($color_flow->{_values_w_aref} );
	$param_widgets		-> set_check_buttons_w_aref($color_flow->{_check_buttons_w_aref} );	 			
	 			
   	$param_widgets		->range($color_flow);
    $param_widgets		->set_labels($color_flow->{_names_aref});
   	$param_widgets		->set_values($color_flow->{_values_aref});
	$param_widgets		->set_check_buttons($color_flow->{_check_buttons_settings_aref});
	$param_widgets		->gui_full_clear();
   	$param_widgets		->redisplay_labels();
   	$param_widgets		->redisplay_values();
   				 # print("14. color_flow, add2flow, labels or names @{$color_flow->{_names_aref}}\n");   	  			
   	  		 	 # print("15. color_flow, add2flow, flow color $flow_color \n");

   	$param_widgets		->redisplay_check_buttons();
  		  		 # print("16. color_flow, add2flow_button, _labels_w_aref @{$color_flow->{_labels_w_aref}}\n");
	  			 # print("17.  color_flow, add2flow_button, _values_w_aref {$color_flow->{_values_w_aref}}\n");
   				 # Collect and store prog versions changed in list box
   _stack_versions();
   	
   		# Add a single_program to the growing stack
		# store one program name, its associated parameters and their values
		# as well as the checkbuttons settings (on or off) in another namespace

   	_stack_flow();
	 			# print("18. color_flow, add2flow_button, _values_w_aref @{$color_flow->{_values_w_aref}}}[0]\n");   	
   	$conditions_gui			-> set_gui_widgets($color_flow); 	# includes _values_w_aref; 29 used / 112 in
 	$conditions_gui			-> set_hash_ref($color_flow);		# 70 used / 112 in
	$conditions_gui    		-> set4end_of_add2flow($flow_color);
				 # print("19. color_flowadd2flow_button: _last_parameter_index_touched $color_flow->{_last_parameter_index_touched_color}\n");
	 			 # print("4 color_flow,add2flow_button,_flowNsuperflow_name_w : $color_flow->{_flowNsuperflow_name_w} \n"); 
	 			
	my $index 				= $flow_widgets->get_flow_selection($color_flow->{_flow_listbox_color_w});
							 # print("20.color_flow add2flow,last flow program touched had index: $index\n");
							 # print("21. color_flow, add2flow_button, color: $flow_color \n");
	$conditions_gui			-> set_flow_index_last_touched($index); # flow color is not reset
#	
	$color_flow 			=  $conditions_gui->get_hash_ref();
	
			
	# switch between the correct index of the last parameter that was touched
	# as a function of the flow's  color 
	# These data are encapsulated 
	# _set_last_parameter_index_touched_color($flow_color);
	# _set_is_last_parameter_index_touched_color($flow_color);
	
	 	 		# print("5 color_flow,add2flow_button,_flowNsuperflow_name_w : $color_flow->{_flowNsuperflow_name_w} \n");
	$color_flow			->{_last_parameter_index_touched_color} 		= 0; # initialize
	$color_flow			->{_is_last_parameter_index_touched_color} 	= $true;
   														
   	return(); 
}


=head2

	Only cases where there is a MB binding use this private ('_') subroutine
	sub binding is responsible
	Other cases that select the GUI file buttons directly use: FileDialog_button
	 	 foreach my $key (sort keys %$color_flow) {
   			print (" color_flowkey is $key, value is $color_flow->{$key}\n");
  		}
  	print ("color_flow,_FileDialog_button(binding), _is_flow_listbox_grey_w: $color_flow->{_is_flow_listbox_grey_w} \n");
  	
  	Once the file name is selected the paramter value is upadate in the GUI
  	
=cut 

 sub _FileDialog_button {   # N.B. change here mean FileDialog_button in L_SU needs to be updated too!!!!!!!
	
	my ($self,$option_sref) = @_;
	use file_dialog;
	
	my $file_dialog			    = file_dialog ->new();	
	
	if ($option_sref)  {  # e.g., can be 'Data'
	
		# print("color_flow FileDialog_button,option_sref $$option_sref\n");

		# provide values in the current widget
		$color_flow		->{_values_aref}  = $param_widgets	->get_values_aref();
			# print("color_flow FileDialog_button,changed values_aref: @{$color_flow->{_values_aref}}\n");
		  			
		$color_flow		->{_dialog_type}  = $$option_sref;  # dereference scalar
		
		$file_dialog		->set_flow_color($color_flow->{_flow_color}); 	# uses 1/ 31 in	 
		$file_dialog 		->set_hash_ref($color_flow);       # uses 7/ 31 in  ; uses values_aref
		$file_dialog		->set_gui_widgets($color_flow);    # uses 18/ 31 in
		$file_dialog 		->FileDialog_director();
		
		# assume that after selection to open of a data file in file-dialog the
		# GUI has been updated 
		# See if the last parameter index has been touched (>= 0)
		# Assume we are still dealing with the current flow item selected
		
		$color_flow->{_last_parameter_index_touched_color} 	    = $file_dialog->get_last_parameter_index_touched_color();
		$color_flow->{_is_last_parameter_index_touched_color} 	= $true;
			 # print ("color_flow,_FileDialog_button(binding), last_parameter_index_touched: $color_flow->{_last_parameter_index_touched_color} \n");
 			# in case _check4changes does not run make sure to use the following line
 			# update to parameter values occurs in file_dialog
 		$color_flow->{_values_aref} 					= $file_dialog->get_values_aref();
		
  		# set up this flow listbox item as the last item touched
  
  		my $_flow_listbox_color_w 						= _get_flow_listbox_color_w();  # user-built_flow in current use				
   		my $current_flow_listbox_index 					= $flow_widgets->get_flow_selection($_flow_listbox_color_w);
		$color_flow->{_last_flow_index_touched} 		= $current_flow_listbox_index;   # for next time
		$color_flow->{_is_last_flow_index_touched} 	= $true;
 			 # print("color_flow,_FileDialog_button(binding), last_flow_index_touched:$color_flow->{_last_flow_index_touched} \n"); 		 		  		
  		  		
  		# Changes made with another instance of param_widgets (in file_dialog) will require
  		# that we update the namespace of the current param_flow
  		# We make this change inside _check4parameter_changes	
		_check4parameter_changes();
				
	} else {		
		print("color_flow,_FileDialog_button (binding),option type missing ")
	}
	return();
 }

=head2  _check4flow_changes

	assume now that selection of a flow item will always change a previously existing
	assume that opening a file dialog will change a parameter (Entry widget) value
	set of flow parameters, That is, a prior program must have been touched
	if ($param_widgets->get_entry_change_status && $color_flow->{_last_flow_index_touched} >= 0) {		
    	  foreach my $key (sort keys %$color_flow) {
           print (" color_flowkey is $key, value is $color_flow->{$key}\n");
           used only by flow_select and sunix_select
          }
             
		 ( $color_flow->{_last_parameter_index_touched_color} ) >= 0)        
=cut 

sub _check4flow_changes {
	my $self = @_;	
	   
	if ( $color_flow->{_last_flow_index_touched} >= 0  ||
		 $color_flow->{_last_parameter_index_touched_color} >= 0) {  
			# <-1 does exist and means the flow/paramter was not touched
			
		# switch between instances of the correct param_flow_color 
		# param_flow_color stores Data 
		_set_param_flow_color_i($flow_color);
	
	     print("1  color_flow _check4flow_changes, param_flow: $param_flow_color_i , color: $flow_color\n");
		 print("11 color_flow _check4flow_changes: _last_flow_index_touched $color_flow->{_last_flow_index_touched}\n");
   		 print("12 color_flow _check4flow_changes: _last_parameter_index_touched $color_flow->{_last_parameter_index_touched_color}\n");


		my $last_idx_chng = $color_flow->{_last_flow_index_touched} ;

	 				# print("color_flow check4flow_changes,
	 				# last changed entry index was $last_idx_chng\n");
  					# print("color_flow check4flow_changes program name is 
  					# ${$color_flow->{_prog_name_sref}}\n");
  					
  		# the checkbuttons, values and names of ONLY the last program used 
  		# are stored in param_widgets at any ONE time			
		$color_flow->{_values_aref} 				= $param_widgets	->get_values_aref();
		$color_flow->{_names_aref} 					= $param_widgets	->get_labels_aref();
		$color_flow->{_check_buttons_settings_aref}	= $param_widgets	->get_check_buttons_aref();

  							print("31 color_flow check4flow_changes,changed values_aref: @{$color_flow->{_values_aref}}[0..1]\n");
  							# print("color_flow check4flow_changes,changed names_aref: @{$color_flow->{_names_aref}}\n");
  							# print("color_flow check4flow_changes,check_buttons_settings_aref: @{$color_flow->{_check_buttons_settings_aref}}\n");
  							
   		 $param_flow_color_i	-> set_flow_index($last_idx_chng);
  				# print("color_flow check4flow_changes,store changes in param_flow, last changed entry index $last_idx_chng\n");
  				# print("color_flow check4flow_changes, param_flow: $param_flow_color_i \n");
  				# 
  						 	    
		# save old changed values
		 $param_flow_color_i	->set_values_aref($color_flow->{_values_aref}); 	# but not the versions
	 	 $param_flow_color_i	->set_names_aref($color_flow->{_names_aref}); 		# but not the versions
		 $param_flow_color_i	->set_check_buttons_settings_aref($color_flow->{_check_buttons_settings_aref}); # BUT not the versions

		 $param_widgets	->set_entry_change_status($false);  # changes are now complete
	 	 						 # print("color_flowflow_select, set_entry_change_status: to 0\n");
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
	
	# switch between instances of the correct param_flow_color 
	# param_flow_color stores Data 
	_set_param_flow_color_i($flow_color);
	
	# switch between the correct index of the last parameter that was touched
	# as a function of the flow's  color 
	# These data are encapsulated 
	# _set_last_parameter_index_touched_color($flow_color);
	# _set_is_last_parameter_index_touched_color($flow_color);
		
   		# print("B4 color_flow _check4parameter_changes: _last_flow_index_touched $color_flow->{_last_flow_index_touched}\n");
   		# print("B4 color_flow _check4parameter_changes: _last_parameter_index_touched: $color_flow->{_last_parameter_index_touched_color}\n");
   
	if ( $color_flow->{_last_parameter_index_touched_color} >= 0 ){  # N.B., <-1 does exist and means the parameters are untouched

		my $last_parameter_idx_touched = $color_flow->{_last_parameter_index_touched_color} ;

	 		# print("color_flow _check4parameter_changes,last changed entry index was $last_parameter_idx_touched \n");
  			# print("color_flow _check4parameter_changes current program name in use: ${$color_flow->{_prog_name_sref}}\n"); 		

  		# very next line appears in _FileDialog_button
  		# because update of parameter widget values occurs via file_dialog
 		# $color_flow->{_values_aref} = $file_dialog->get_values_aref();
 								
  		# Update the names and check_buttons again, reading in from the gui (param_widgets), just in case 							  		
		$color_flow->{_names_aref} 					= $param_widgets	->get_labels_aref();
		$color_flow->{_check_buttons_settings_aref}	= $param_widgets	->get_check_buttons_aref();
			
  							# print(" color_flow _check4parameter_changes, check_buttons_settings_aref: @{$color_flow->{_check_buttons_settings_aref}}\n");			
	
  		# For flow item index of the program in the color-flow listbox that is currently being used, 
  		# i.e., not the index of the last-used program
  		# user-built_flow in current use
  		my $_flow_listbox_color_w 		= _get_flow_listbox_color_w();  
 				
 				# print("color_flow check4parameter_changes flow_listbox_color_w,: $_flow_listbox_color_w \n"); 		
  		
   		my $current_flow_listbox_index 	= $flow_widgets->get_flow_selection($_flow_listbox_color_w);
		$param_flow_color_i				-> set_flow_index($current_flow_listbox_index);
				
				# print("color_flowcheck4parameter_changes, current_flow_listbox_index: $current_flow_listbox_index \n");
  						 	    	
	  			# print("color_flow _changes4changes,changed names_aref: @{$color_flow->{_names_aref}}[0]\n");
		 		print("color_flow _check4parameter_changes,changed values_aref: @{$color_flow->{_values_aref}}[0]\n");
		 		print("color_flow _check4parameter_changes, param_flow: $param_flow_color_i , color: $flow_color\n");
		 		
		 # save current values
		 $param_flow_color_i	->set_values_aref($color_flow->{_values_aref}); 	# but not the versions
		 					# my $out 				= $param_flow_color_i	->get_values_aref();		
	 	 $param_flow_color_i	->set_names_aref($color_flow->{_names_aref}); 		# but not the versions
		 $param_flow_color_i	->set_check_buttons_settings_aref($color_flow->{_check_buttons_settings_aref}); # BUT not the versions

		 $param_widgets	->set_entry_change_status($false);  # changes are now complete
		 
	 	 		# print("color_flow,check4parameter_changes, set_entry_change_status: back to 0 (default)\n");
	 	 						
	 	 # if reinitialize last_parameter_index_touched goes back to -1 (default)
	 	 # then this subroutine may not be used
	 	 $color_flow->{_last_parameter_index_touched_color} 	= -1; 	 
	 	 $color_flow->{_last_flow_index_touched}      	= $current_flow_listbox_index; # for next time
	 	 $color_flow->{_is_last_flow_index_touched}		= $true;
	 	 
	 	# print("End of color_flowcheck4changes: _last_flow_index_touched $color_flow->{_last_flow_index_touched}\n");
   		# print("End of color_flowcheck4changes: _last_parameter_index_touched reset: $color_flow->{_last_parameter_index_touched_color}\n");
	}  						

	return();
 }


=head2 sub _get_flow_listbox_color_w


=cut 

 sub _get_flow_listbox_color_w {
	my ($self)   = @_;
	my $flow_color;
	my $correct_flow_listbox_color_w;
	
	$flow_color 		= $color_flow->{_flow_color};
	
	if ($flow_color eq 'grey') {
		$correct_flow_listbox_color_w =  $color_flow->{_flow_listbox_grey_w};
		
	} elsif ($flow_color eq 'pink')  {
		$correct_flow_listbox_color_w = $color_flow->{_flow_listbox_pink_w};
		
	} elsif ($flow_color eq 'green') {
		$correct_flow_listbox_color_w =  $color_flow->{_flow_listbox_green_w};
		
	} elsif ($flow_color eq 'blue')  {
		$correct_flow_listbox_color_w =  $color_flow->{_flow_listbox_blue_w};
		
	} elsif ($flow_color eq 'neutral'){
		print("color_flow, _get_flow_listbox_color_w, neutral color\n");
	} else {
		print("color_flow, _get_flow_listbox_color_w, missing color\n");
		
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
	
	# switch between instances of the correct param_flow_color 
	# param_flow_color stores Data 
	_set_param_flow_color_i($flow_color);
   
	$color_flow->{_index2move}        	= $flow_widgets->index2move();
   	$color_flow->{_destination_index} 	= $flow_widgets->destination_index();

   	my $start	= $color_flow->{_index2move};
  	my $end	    = $color_flow->{_destination_index};
   			 print("color_flow move_in_stored_flows,start index is the $start\n");
   			 print("color_flow move_in_stored_flows, insertion index is $end \n");

   	$param_flow_color_i	->set_insert_start($start);
   	$param_flow_color_i	->set_insert_end($end);
   	$param_flow_color_i	->insert_selection();
   	
  	return(); 
 }


=head2 sub _SaveAs_button

	topic: only for 'SaveAs'
  	for safety, place set_hash_ref first
  	
   	my	$m          	= "color_flow, _SaveAs_button, Test,set_specs,message,$message_w\n";
 	$message_w->delete("1.0",'end');
 	$message_w->insert('end', $m);

=cut

 sub _SaveAs_button {
 	my ($topic) = @_;
 	
	if ($topic eq 'SaveAs') {
		
		use files_LSU;

		my $files_LSU			= new files_LSU();
		
		# switch between instances of the correct param_flow_color 
		# param_flow_color stores Data 
		_set_param_flow_color_i($flow_color);
		
		$conditions_gui			->set_hash_ref($color_flow);       # 57 used of 112 in
		$conditions_gui			->set_gui_widgets($color_flow);	  # 26 used of 112 in
		$conditions_gui			->set4_start_of_SaveAs_button();

		my $num_items 			= $param_flow_color_i->get_num_items();
  			# print("1. color_flow, _SaveAs_button, B4 stored number of prgrams: $num_items\n");
  	 	$color_flow->{_names_aref} 	= $param_flow_color_i->get_names_aref();
  			# print("2. color_flow,_SaveAs_button parameter names: @{$color_flow->{_names_aref}}[0]\n");
	
		$param_flow_color_i				->set_good_values();
		$param_flow_color_i				->set_good_labels();
		
		# collect information to be saved in a perl flow
		$color_flow->{_good_labels_aref2}	= $param_flow_color_i->get_good_labels_aref2();
		$color_flow->{_items_versions_aref}	= $param_flow_color_i->get_flow_items_version_aref();
		$color_flow->{_good_values_aref2} 	= $param_flow_color_i->get_good_values_aref2();
		$color_flow->{_prog_names_aref} 	= $param_flow_color_i->get_flow_prog_names_aref();

		 		 # print("color_flow,_prog_names_aref,
		 		 # @{$color_flow->{_prog_names_aref}}\n");
		# my $num_items4flow = scalar @{$color_flow->{_good_labels_aref2}};

				 # for (my $i=0; $i < $num_items4flow; $i++ ) {
					# print("color_flow,_good_labels_aref2,
				# @{@{$color_flow->{_good_labels_aref2}}[$i]}\n");
				# }

				# for (my $i=0; $i < $num_items4flow; $i++ ) {
				#	print("color_flow,_good_values_aref2,
				#	@{@{$color_flow->{_good_values_aref2}}[$i]}\n");
				#}
				#   print("color_flow,_prog_versions_aref,
				#   @{$color_flow->{_items_versions_aref}}\n");
				
 		$files_LSU	->set_prog_param_labels_aref2($color_flow);	# uses x / 61 in
 		$files_LSU	->set_prog_param_values_aref2($color_flow);	# uses x / 61 in
 		$files_LSU	->set_prog_names_aref($color_flow);			# uses x / 61 in
 		$files_LSU	->set_items_versions_aref($color_flow);		# uses x / 61 in
 		$files_LSU	->set_data();
 		$files_LSU	->set_message($color_flow);  				# uses 1 / 61 in

 	  	
		$files_LSU	->set2pl($color_flow); 			# flows saved to PL_SEISMIC
		$files_LSU	->save();
		
		$conditions_gui			->set4_end_of_SaveAs_button(); # sets: _has_used_SaveAs=true
		$color_flow 			= $conditions_gui->get_hash_ref(); # 79 out
			# print("1. color_flow, _SaveAs_button, has_used_SaveAs_button: $color_flow->{_has_used_SaveAs_button}\n");
 	
 		return();
 		
	} else {		
		print("color_flow,_SaveAs_button, missing topic\n");
	}		
 } 	


=head2 sub _perl_flow

  Parse perl flows

  foreach my $key (sort keys %$color_flow) {
   print (" color_flowkey is $key, value is $color_flow->{$key}\n");
  }
  
  set
  	$param_sunix
  	$param_widgets
  	
  get
  	$color_flow messages
  	$whereami					->set4sunix_listbox()
  	$param_widgets
  	$param_sunix
  	
  call:
    $conditions_gui			->set4start_of_sunix_select;
    $conditions_gui	->set4end_of_sunix_select() ;
     $color_flow 			= $conditions_gui->get_hash_ref();
     
   		my $length = scalar @{$all_values_aref};
   		print("color_flow,perl_flow, length = $length\n");
   		
   		for (my $j=0; $j <$length; $j++) {
   			   	print("color_flow,perl_flow,name & value:@{$all_names_aref}[$j] = @{$all_values_aref}[$j]\n");

   		}     
 
=cut 

sub _perl_flow {	
   	my ($self) = @_;
   	
   	# import modules
   	use perl_flow;
   	use messages::message_director; 
   	use param_sunix;
   	
   	# instantiate modules
   	my $perl_flow 				= perl_flow -> new();
	my $param_sunix        		= param_sunix->new();
	my $color_flow_messages 	= message_director->new();
	  	
 	# messages
    my $message          	= $color_flow_messages->null_button(0);
 	$message_w   			->delete("1.0",'end');
 	$message_w   			->insert('end', $message);  	
   	
   	# switch between instances of the correct param_flow_color 
	# param_flow_color stores Data 
	_set_param_flow_color_i($flow_color);
	
	# should be at start of color_flow
   	$color_flow->{_flow_type} 	= $flow_type->{_user_built};
   	my $flow_name_in			= $color_flow->{_flow_name_in};
   	 		
   	  	 # print("color_flow, _perl_flow ,flow_name_in $flow_name_in\n");  	  	   	 		 	 	
		 # print("color_flow,1. _perl_flow,flow_color: $color_flow->{_flow_color}\n"); 	
   	  	     
#    $conditions_gui						    ->set_gui_widgets($color_flow);
#    $conditions_gui							->set4start_of_perl_select();

    my $flow_color		 = $color_flow->{_flow_color};
 				# print("color_flow,2. _perl_flow,flow_color: $flow_color\n"); 
 			
 	# read in variables from the perl flow file
 	$perl_flow->set_perl_file_in($flow_name_in);
    $perl_flow->parse();
    
    # clear any param_flow
   	$param_flow_color_i     ->clear();
   	# clear the parameter values and labels
   	$param_widgets	->gui_full_clear();
   	
    # clear the flow listbox too
    # _set_flow_listbox_color_w($flow_color); # in "color"_flow namespace
    my $_flow_listbox_color_w 	= _get_flow_listbox_color_w();
    	# $flow_widgets	->clear($flow_listbox_grey_w);
    $flow_widgets	->clear($_flow_listbox_color_w );
            # print("color_flow,flow_listbox_grey_w, $flow_listbox_grey_w, _perl_flow\n");
            # print("color_flow,flow_listbox_grey_w, $_flow_listbox_color_w , _perl_flow\n");
    
    my $num_prog_names = $perl_flow->get_num_prog_names();
    
    
    for (my $prog_idx=0; $prog_idx< $num_prog_names; $prog_idx++) {
    	
    	# collect info from perl file
    	$perl_flow										-> set_prog_index($prog_idx);
    	$color_flow->{_prog_name_sref} 				= $perl_flow->get_prog_name_sref();

    	$color_flow->{_names_aref}  					= $perl_flow	->get_all_names_aref();
   		$color_flow->{_values_aref} 					= $perl_flow	->get_all_values_aref();
   		$color_flow->{_check_buttons_settings_aref}  = $perl_flow	->get_check_buttons_settings_aref();
   		
   				# my $names = scalar @{$color_flow->{_names_aref}};
   				# print("color_flow,_perl_flow, #names = $names\n");
   		
   				# print("color_flow,_perl_flow,prog_name_sref: ${$color_flow->{_prog_name_sref}}\n");
	 			# print("color_flow,_perl_flow, values: @{$color_flow->{_values_aref}}\n");
	 			# print("color_flow,_perl_flow, labels: @{$color_flow->{_names_aref}}\n");	
				# print("color_flow,_perl_flow,_check_buttons_settings: @{$color_flow->{_check_buttons_settings_aref}}\n"); 		
	 		 			
   		# upload variables into the param_flow for each program
   		# Populate GUI with the parameter values and labels of the first item
   		_add2flow();
   		 		
    }
    	# # select the last flow item loaded
		# # _flow_select();	
   	return();
}
 

=head2 sub _set_flow_color


=cut 

 sub _set_flow_color {
	my ($flow_color)   = @_;
	
	if ($flow_color) {
		# print("color_flow set_flow_color , color:$flow_color\n");
		$color_flow->{_flow_color}  			 = $flow_color;
		
	} else  {
	 	print("color_flow, set_flow_color, missing color\n");
	}
	return();
 }



=head2 sub _set_flow_listbox_color_w


=cut 

 sub _set_flow_listbox_color_w {
	my ($flow_color)   = @_;
		
	if ($flow_color eq 'grey') {
		
		$color_flow->{_flow_listbox_color_w} =  $color_flow->{_flow_listbox_grey_w};
			#print("color_flow,_set_flow_listbox_color_w, _set_flow_listbox_color_w, color is $flow_color\n");
		
	} elsif ($flow_color eq 'pink')  {
		
		$color_flow->{_flow_listbox_color_w} = $color_flow->{_flow_listbox_pink_w};
			#print("color_flow,_set_flow_listbox_color_w, _set_flow_listbox_color_w, color is $flow_color\n");	
				
	} elsif ($flow_color eq 'green') {
		
		$color_flow->{_flow_listbox_color_w} =  $color_flow->{_flow_listbox_green_w};
			#print("color_flow,_set_flow_listbox_color_w, _set_flow_listbox_color_w, color is $flow_color\n");	
				
	} elsif ($flow_color eq 'blue')  {
		
		$color_flow->{_flow_listbox_color_w} =  $color_flow->{_flow_listbox_blue_w};
			#print("color_flow,set_flow_listbox_color_w, _set_flow_listbox_color_w, color is $flow_color\n");
					
	} else {
		print("color_flow,_set_flow_listbox_color_w, _set_flow_listbox_color_w, missing color\n");
	}
    
	return();
 }



=head2 sub _set_flow_name_color_w

=cut

sub _set_flow_name_color_w {	
	my ($flow_color) = @_;
		
	if ($flow_color eq 'grey') {
		
		$flow_name_color_w 	=  $color_flow->{_flow_name_grey_w};
		
		# do not export
		$flow_name_color_w 						=  $color_flow->{_flow_name_grey_w};
				
			#print("color_flow,_set_flow_name_color_w, _set_flow_name_color_w, color is $flow_color\n");
		
	} elsif ($flow_color eq 'pink')  {
		
		$flow_name_color_w	 = $color_flow->{_flow_name_pink_w};
		
		#do not export
		$flow_name_color_w 						=  $color_flow->{_flow_name_pink_w};
		
			#print("color_flow,_set_flow_name_color_w, _set_flow_name_color_w, color is $flow_color\n");		
	} elsif ($flow_color eq 'green') {
		
		$flow_name_color_w 	=  $color_flow->{_flow_name_green_w};
		
		# do not export
		$flow_name_color_w 						=  $color_flow->{_flow_name_green_w};
		
			#print("color_flow,_set_flow_name_color_w, _set_flow_name_color_w, color is $flow_color\n");		
	} elsif ($flow_color eq 'blue')  {
		
		$flow_name_color_w 	=  $color_flow->{_flow_name_blue_w};
		
		# do not export
		$flow_name_color_w 						=  $color_flow->{_flow_name_blue_w};
		
			#print("color_flow,set_flow_name_color_w, _set_flow_name_color_w, color is $flow_color\n");		
	} else {
		print("color_flow,_set_flow_name_color_w, _set_flow_name_color_w, missing color \n");
	}		

	return();
}


=head2 sub _set_flowNsuperflow_name_w

	displays superflow name at top of gui
	
=cut

sub _set_flowNsuperflow_name_w {	
	my ($flowNsuperflow_name) = @_;
		
	if ($flowNsuperflow_name && $flowNsuperflow_name_w) {
		
		$color_flow->{_flowNsuperflow_name_w} = $flowNsuperflow_name_w;
		
		$flowNsuperflow_name_w->configure(-text => $flowNsuperflow_name,);				
	} else {		
			print("color_flow, set_flowNsuperflow_name_w, missing widget or program name\n");
	}

	return();
}
 
#=head2 sub  _set_is_last_parameter_index_touched_color
#
#=cut 
#
#
#sub _set_is_last_parameter_index_touched_color {	
#	my ($flow_color) = @_;
#		
#	if ($flow_color eq 'grey') {
#		
#		# not for export
#		$color_flow->{_is_last_parameter_index_touched_color}	=  $color_flow->{_is_last_parameter_index_touched_grey};
#						
#			# print("color_flow,_set_is_last_parameter_index_touched_color, color is $flow_color\n");
#			# print("color_flow,_set_is_last_parameter_index_touched_color, last_parameter_index_touched_grey: $last_parameter_index_touched_grey\n");
#					
#	} elsif ($flow_color eq 'pink')  {
#		
#		# not for export
#		$color_flow->{_is_last_parameter_index_touched_color}	=  $color_flow->{_is_last_parameter_index_touched_pink};
#						
#			# print("color_flow,_set_is_last_parameter_index_touched_color, color is $flow_color\n");		
#			# print("color_flow,_set_is_last_parameter_index_touched_color, last_parameter_index_touched_pink: $last_parameter_index_touched_pink\n");
#		
#	} elsif ($flow_color eq 'green') {
#		
#		# not for export
#		$color_flow->{_is_last_parameter_index_touched_color}	=  $color_flow->{_is_last_parameter_index_touched__green};
#						
#			# print("color_flow,_set_is_last_parameter_index_touched_color, color is $flow_color\n");
#			# print("color_flow,_set_is_last_parameter_index_touched_color, last_parameter_index_touched_green: $last_parameter_index_touched_green\n");
#					
#	} elsif ($flow_color eq 'blue')  {
#		
#		# not for export
#		$color_flow->{_is_last_parameter_index_touched_color}	=  $color_flow->{_is_last_parameter_index_touched_blue};
#						
#			# print("color_flow,_set_is_last_parameter_index_touched_color, color is $flow_color\n");
#			# print("color_flow,_set_is_last_parameter_index_touched_color, last_parameter_index_touched_blue: $last_parameter_index_touched_blue\n");
#					
#	} else {
#		print("color_flow,_set_is_last_parameter_index_touched_color, missing color \n");
#	}		
#
#	return();
#}
 
# 
#=head2 sub  _set_last_parameter_index_touched_color
#
#=cut 
#
#
#sub _set_last_parameter_index_touched_color {	
#	my ($flow_color) = @_;
#		
#	if ($flow_color eq 'grey') {
#		
#		# not for export
#		$color_flow->{_last_parameter_index_touched_color}	=  $color_flow->{_last_parameter_index_touched_grey};
#						
#			# print("color_flow,_set_last_parameter_index_touched_color, color is $flow_color\n");
#			# print("color_flow,_set_last_parameter_index_touched_color, last_parameter_index_touched_grey: $last_parameter_index_touched_grey\n");
#					
#	} elsif ($flow_color eq 'pink')  {
#		
#		# not for export
#		$color_flow->{_last_parameter_index_touched_color}	=  $color_flow->{_last_parameter_index_touched_pink};
#						
#			# print("color_flow,_set_last_parameter_index_touched_color, color is $flow_color\n");		
#			# print("color_flow,_set_last_parameter_index_touched_color, last_parameter_index_touched_pink: $last_parameter_index_touched_pink\n");
#		
#	} elsif ($flow_color eq 'green') {
#		
#		# not for export
#		$color_flow->{_last_parameter_index_touched_color}	=  $color_flow->{_last_parameter_index_touched_green};
#						
#			# print("color_flow,_set_last_parameter_index_touched_color, color is $flow_color\n");
#			# print("color_flow,_set_last_parameter_index_touched_color, last_parameter_index_touched_green: $last_parameter_index_touched_green\n");
#					
#	} elsif ($flow_color eq 'blue')  {
#		
#		# not for export
#		$color_flow->{_last_parameter_index_touched_color}	=  $color_flow->{_last_parameter_index_touched_blue};
#						
#			# print("color_flow,_set_last_parameter_index_touched_color, color is $flow_color\n");
#			# print("color_flow,_set_last_parameter_index_touched_color, last_parameter_index_touched_blue: $last_parameter_index_touched_blue\n");
#					
#	} else {
#		print("color_flow,_set_last_parameter_index_touched_color, , missing color \n");
#	}		
#
#	return();
#}

 
=head2 sub _set_param_flow_color_i


=cut

sub _set_param_flow_color_i {	
	my ($flow_color) = @_;
		
	if ($flow_color eq 'grey') {
		
		# not for export
		$param_flow_color_i	=  $param_flow_grey;
						
			print("color_flow,_set_param_flow_color_i, $param_flow_color_i, color is $flow_color\n");
		
	} elsif ($flow_color eq 'pink')  {
		
		# not for export
		$param_flow_color_i	=  $param_flow_pink;
						
			print("color_flow,_set_param_flow_color_i, $param_flow_color_i, color is $flow_color\n");		
		
	} elsif ($flow_color eq 'green') {
		
		# not for export
		$param_flow_color_i	=  $param_flow_green;
						
			# print("color_flow,_set_param_flow_color_i, $param_flow_color_i, color is $flow_color\n");
					
	} elsif ($flow_color eq 'blue')  {
		
		# not for export
		$param_flow_color_i	=  $param_flow_blue;
						
			# print("color_flow,_set_param_flow_color_i, $param_flow_color_i, color is $flow_color\n");
					
	} else {
		print("color_flow,__set_param_flow_color_i, __set_param_flow_color_i, missing color \n");
	}		

	return();
}
 
 		
=head2 sub _set_user_built_flow_name_w

 place and show the user-built flow name

=cut

sub _set_user_built_flow_name_w {	
	my ($user_built_flow_name) = @_;
	
	if ($user_built_flow_name) {
			
	   if ($flow_name_color_w) {
	   			
		# do not export
		$flow_name_color_w = $flow_name_color_w;	
		
		# display name in widget
		$flow_name_color_w->configure(-text => $user_built_flow_name,);	
		
		} elsif  (not $flow_name_color_w) {
			
			_set_flow_name_color_w($flow_color);
			
			# do not export
			$flow_name_color_w = $flow_name_color_w;	
		
			# display name in widget
			$flow_name_color_w->configure(-text => $user_built_flow_name,);	
			
		} else {
			print("color_flow, set_user_built_flow_name_w, missing flow_name_color_w \n");
		}			
	} else {		
			print("color_flow, set_user_built_flow_name_w, missing program name\n");
	}

	return();
}



=head2 sub _stack_flow

  store an initial version of the parameters in a 
  namespace different to the one belonginf to param_widgets 
  
  The initial version comes from default parameter files
  i.e., sing the same code as for sunix_select
  
  print("color_flow stack_flow,last left listbox flow program touched had index = $color_flow->{_last_flow_index_touched}\n");
  print("color_flow stack_flow,values= @{$color_flow->{_values_aref}}\n");
  
=cut


sub _stack_flow {
  my( $self) = @_;
  
	# switch between instances of the correct param_flow_color 
	# param_flow_color stores Data 
	_set_param_flow_color_i($flow_color); 
    	
       		# my $num_items = $param_flow_color->get_num_items();
  			# print("1. color_flow, _stack_flow, B4 stored number of programs: $num_items\n");
  			# print("color_flow,_stack_flow,color_flow->listbox_widget: $color_flow->{_flow_listbox_color_w}\n");
  			print("color_flow, _stack_flow, color: $flow_color \n");
  			print("color_flow, _stack_flow, param_flow_color_i: $param_flow_color_i\n");
  			
	$param_flow_color_i		->stack_flow_item($color_flow->{_prog_name_sref});

	$param_flow_color_i		->stack_values_aref2($color_flow->{_values_aref});
	$param_flow_color_i		->stack_names_aref2($color_flow->{_names_aref});
	$param_flow_color_i		->stack_checkbuttons_aref2($color_flow->{_check_buttons_settings_aref});
  
  			$param_flow_color_i 		->view_data();  
   	    	# my $num_items = $param_flow_color_i->get_num_items;
  			# print("2. color_flow, _stack_flow, End- stored programs num_items: $num_items\n");	
  			
  			print("2. color_flow, _stack_flow, param_flow_grey,$param_flow_grey\n");
   			print("color_flow, _stack_flow, param_flow_color_i: $param_flow_color_i\n");
  			$param_flow_grey 		->view_data();  
   	    	# $num_items = $param_flow_color_i->get_num_items;
  			# print("2. color_flow, _stack_flow, End- stored programs num_items: $num_items\n");
  			# 
  			
  			#print("2. color_flow, _stack_flow, param_flow_pink,$param_flow_pink\n");
  			#$param_flow_pink 		->view_data();  
   	    	#$num_items = $param_flow_pink->get_num_items;
  			#print("2. color_flow, _stack_flow, End- stored programs num_items: $num_items\n");
  			
  					 
						
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
	
	# switch between instances of the correct param_flow_color 
	# param_flow_color stores Data 
	_set_param_flow_color_i($flow_color);
	
	my $_flow_listbox_color_w 			= _get_flow_listbox_color_w();
	
	   			# print("color_flow, _stack_versions ,color_flow->listbox_widget: $_flow_listbox_color_w \n");
	   			
    $flow_widgets						->set_flow_items($_flow_listbox_color_w);
    $color_flow->{_items_versions_aref} = $flow_widgets->items_versions_aref;
    $param_flow_color_i					->set_flow_items_version_aref($color_flow->{_items_versions_aref});
 			 # print("_stack_versions,items_versions_aref: @{$color_flow->{_items_versions_aref}}\n");
}



=head2

	FileDialog_button 	: handles Data, SaveAs and (perl) Flow (in) is 
  	
  	Once the file name is selected the parameter value is upadated in the GUI
  	
  			 	 foreach my $key (sort keys %$color_flow) {
   			print (" color_flowkey is $key, value is $color_flow->{$key}\n");
  		}
  		dialog type (option_sref)  can be:
  			Data, 
  			Flow (open an exisiting user-built flow, but not a pre-built
  				superflow), or
  			SaveAs
  				my $uBF      	= $file_dialog->get_hash_ref(); #TODO but some variables will not get Xferred
		foreach my $key (sort keys %$uBF) {
   			print (" color_flowkey is $key, value is $uBF->{$key}\n");
  		}
  		
  		foreach my $key (sort keys %$color_flow) {
   			print (" color_flowkey is $key, value is $color_flow->{$key}\n");
  		}
  	
=cut 

 sub FileDialog_button {   # N.B., Another _FileDialog_button in L_SU.pm needs to be updated too!!!!!!!
	
	my ($self,$dialog_type_sref) = @_;
	use file_dialog;
	use SeismicUnixPlTk_global_constants;
	use conditions_gui;
	
	my $file_dialog			= file_dialog 	->new();		
	my $get					= SeismicUnixPlTk_global_constants->new();
	my $conditions_gui		= conditions_gui ->new();
	my $file_dialog_type	= $get->file_dialog_type_href();

	# may provide values from the current widget if it is used
	# can also be (1) a previous pre-built superflow that is already in the GUI
	# (2) empty if program is just starting			             
	
	if ($dialog_type_sref)  {
		
		# switch between the correct index of the last parameter that was touched
		# as a function of the flow's  color 
		# These data are encapsulated 
		# _set_last_parameter_index_touched_color($flow_color);
		# _set_is_last_parameter_index_touched_color($flow_color);
		
				# print ("2. color_flow,FileDialog_button, is_last_flow_index_touched: $color_flow->{_is_last_flow_index_touched} \n");		
		
		$color_flow		->{_dialog_type}  = $$dialog_type_sref;  # dereference scalar
		my $topic 			= $color_flow ->{_dialog_type}; 
				# print ("2. color_flow,FileDialog_button,dialog_type: $color_flow->{_dialog_type}\n");
				# print ("2. color_flow,set_hash_ref,_flowNsuperflow_name_w:$color_flow->{_flowNsuperflow_name_w}\n");
		
		# ONLY for SaveAs
		# In this module, dialog_type can only be SaveAs
		# 
		# Save for 'user-built flows' is accessible via L_SU.pm	
		if ($topic eq $file_dialog_type->{_SaveAs} ) {

				# print ("0. color_flow,FileDialog_button, is_last_parameter_index_touched: $color_flow->{_is_last_parameter_index_touched_color} \n");
				# print ("0. color_flow,FileDialog_button, is_last_flow_index_touched: $color_flow->{_is_last_flow_index_touched} \n");
			$color_flow		->{_values_aref}  = $param_widgets->get_values_aref();
			$color_flow		->{_dialog_type}  = $$dialog_type_sref;  # dereference scalar
		
			$file_dialog		->set_flow_color($color_flow->{_flow_color}); 	# uses 1/ 112 in	 
			$file_dialog 		->set_hash_ref($color_flow);       # uses 86/ 112 in  ; uses values_aref
			$file_dialog		->set_gui_widgets($color_flow);    # uses 34/ 112 in
			# $file_dialog		->set_flow_type('user_built'); not needed beacuase file_dialog accounts forSaveAs
				# print ("1. color_flow,FileDialog_button, is_last_parameter_index_touched: $color_flow->{_is_last_parameter_index_touched_color} \n");
				# print ("1. color_flow,FileDialog_button, is_last_flow_index_touched: $color_flow->{_is_last_flow_index_touched} \n");
			$file_dialog 		->FileDialog_director();
		
					# print ("2. color_flow,FileDialog_button, is_last_parameter_index_touched: $color_flow->{_is_last_parameter_index_touched_color} \n");
	
			# assume that while selecting a data file to open in file-dialog that the
			# GUI has been updated (not very elegant... TODO
			# see if the last index has been touched
						
			$color_flow->{_has_used_SaveAs_button}   		= $true;
			
			# new file name will generate a case that an index has been touched
			$color_flow->{_last_parameter_index_touched_color} 	    = $file_dialog->get_last_parameter_index_touched_color();
			print ("1. color_flow,FileDialog_button,_last_parameter_index_touched_color:$color_flow->{_last_parameter_index_touched_color} \n"); 
			print ("1. color_flow,FileDialog_button, color: $flow_color \n");
			$color_flow->{_is_last_parameter_index_touched_color} 	= $true;
			
			_check4parameter_changes();
			
			use messages::message_director;
			my $color_flow_messages 				= message_director->new();
			
			$color_flow->{_flow_name_out} 		= file_dialog->get_perl_flow_name_out();
			$color_flow-> {_path}    			= file_dialog->get_file_path();
			
			# consider empty case, for which saving is not possible
			if( !($color_flow->{_flow_name_out}) 		||
				$color_flow	->{_flow_name_out} eq '' 	|| 
				!($color_flow-> {_path})	 				||
				$color_flow	-> {_path} 		    eq ''     ) {
				
				my $message          = $color_flow_messages->save_button(1);
 	  			$message_w			 ->delete("1.0",'end');
 	  			$message_w			 ->insert('end', $message);

			} else {  # Good,  NON-EMPTY case
			
			 	# displays user-built flow name at top of grey-flow gui
 				_set_flowNsuperflow_name_w( $color_flow->{_flow_name_out} );
 				_set_user_built_flow_name_w( $color_flow->{_flow_name_out} );
				# print("1. color_flow, FileDialog_button, saving flow: $color_flow->{_flow_name_out}\n");
				
				# go save perl flow file
				_SaveAs_button($topic);	
				
				# restore message at the bottom of the string to blank if not already so	  	
 				# messages
    			my $message          	= $color_flow_messages->null_button(0);
 				$message_w   			->delete("1.0",'end');
 				$message_w   			->insert('end', $message);

				# print("color_flow,FileDialog_button,_flow_name_out: $color_flow->{_flow_name_out}  \n");
				# print("color_flow,FileDialog_button,_path: $color_flow->{_path}  \n");
    		}  #Ends SaveAs option
    		
		} elsif ($topic eq $file_dialog_type->{_Flow} ) {		
		
			# Read perl flow file
			# Write name to the file name in the appropriate flow
			# populate GUI
			# populate hashes (color_flow)and memory spaces (param_flow)
					# print("3. color_flow,FileDialog_button,flow_color: $color_flow->{_flow_color} \n");
					# print("3  color_flow,FileDialog_button,_flowNsuperflow_name_w:$color_flow->{_flowNsuperflow_name_w} \n");		
			$file_dialog		->set_flow_color($color_flow->{_flow_color}); 	# uses 1/ 31 in	 
			$file_dialog 		->set_hash_ref($color_flow);       # uses 7/ 31 in  ; uses values_aref
			$file_dialog		->set_gui_widgets($color_flow);    # uses 18/ 31 in
					# print("3  color_flow,FileDialog_button,_flowNsuperflow_name_w:$color_flow->{_flowNsuperflow_name_w} \n");
			$file_dialog		->set_flow_type('user_built');
					# print("3  color_flow,FileDialog_button,_flowNsuperflow_name_w:$color_flow->{_flowNsuperflow_name_w} \n");
			$file_dialog		->FileDialog_director();
					# print("3  color_flow,FileDialog_button,_flowNsuperflow_name_w:$color_flow->{_flowNsuperflow_name_w} \n");
				
			$color_flow->{_flow_name_in} 		= $file_dialog->get_perl_flow_name_in();
					# print("4. color_flow, FileDialog_button,_flow_name_in, $color_flow->{_flow_name_in} \n");			
				# $conditions_gui				->set_hash_ref($file_dialog); # uses 74 / 123 given
				# $conditions_gui				->set_gui_widgets($conditions_gui); # uses 29  /123 given
   				# $conditions_gui   			->set4FileDialog_open_perl_file_end(); # sets 2
   			  			
			$color_flow->{_flow_name_out}					= $color_flow->{_flow_name_in};
			$color_flow->{_has_used_open_perl_file_button} 	= $true;
			
		
			# Place names of the programs at the head of the grey listbox 
			_set_flow_name_color_w ($flow_color);
  			$flow_name_color_w     -> configure(-text => $color_flow->{_flow_name_in});
    					# $color_flow->{_flow_name_grey_w}     -> configure(-text => $color_flow->{_flow_name_in});
   				
   			# Place names of the programs at the head of the GUI 
   			$color_flow->{_flowNsuperflow_name_w}-> configure(-text => $color_flow->{_flow_name_in});
				
			# populate gui, and bot param_flow and param_widgets namespaces
			_perl_flow();
			
		
		} elsif ($topic eq $file_dialog_type->{_Data} ) {
	
					print("color_flowFileDialog_button,option_sref $topic\n");
					
			# assume that after selection to open of a data file in file-dialog the
			# GUI has been updated 
			# See if the last parameter index has been touched (>= 0)
			# Assume we are still dealing with the current flow item selected	
			$color_flow->{_last_parameter_index_touched_color} 	  = $file_dialog->get_last_parameter_index_touched_color();
			$color_flow->{_is_last_parameter_index_touched_color} = $true;
			
			# set the current listbox as the last color listbox
			$color_flow->{_last_flow_listbox_color_w}             = $color_flow->{_flow_listbox_color_w}; 

			# provide values in the current widget
			$color_flow		->{_values_aref}  = $param_widgets	->get_values_aref();
				# print("color_flowFileDialog_button,changed values_aref: @{$color_flow->{_values_aref}}\n");		  
			print ("color_flow,_FileDialog_button(binding), flow_listbox_color_w: $color_flow->{_flow_listbox_color_w} \n");
			$file_dialog		->set_flow_color($color_flow->{_flow_color}); 	# uses 1/ 31 in	 
			$file_dialog 		->set_hash_ref($color_flow);       # uses 86/ 112 in  ; uses values_aref
			$file_dialog		->set_gui_widgets($color_flow);    # uses 34/ 112 in
			$file_dialog 		->FileDialog_director();
						
			print ("color_flow,_FileDialog_button(binding), last_parameter_index_touched_color: $color_flow->{_last_parameter_index_touched_color} \n");
 			
 			# in case _check4changes does not run make sure to use the following line
 			# update to parameter values occurs in file_dialog
 			$color_flow->{_values_aref} 					= $file_dialog->get_values_aref();
		
  			# set up this flow listbox item as the last item touched
  			my $_flow_listbox_color_w 						= _get_flow_listbox_color_w();  # user-built_flow in current use				
   			my $current_flow_listbox_index 					= $flow_widgets->get_flow_selection($_flow_listbox_color_w);
			$color_flow->{_last_flow_index_touched} 		= $current_flow_listbox_index;   # for next time
			$color_flow->{_is_last_flow_index_touched} 		= $true;
 			 		
 			 		print("color_flow,FileDialog_button(binding), last_flow_index_touched:$color_flow->{_last_flow_index_touched} \n"); 		 		  		
  		  		
  			# Changes made with another instance of param_widgets (in file_dialog) will require
	  		# that we also update the namespace of the current param_flow
	  		# We make this change inside _check4parameter_changes	
			_check4parameter_changes();

			} else {
			print("1. color_flow, FileDialog_button, missing topic \n");
		   		# Ends opt_ref
			}					
		} else {		
			print("color_flow,FileDialog_button ,option type missing\ n");
		}
		# print ("2. color_flow,FileDialog_button, is_last_parameter_index_touched_color: $color_flow->{_is_last_parameter_index_touched_color} \n");
		# print ("2. color_flow,FileDialog_button, is_last_flow_index_touched: $color_flow->{_is_last_flow_index_touched} \n");
		return();
 }


=head2 sub add2flow_button

	When build a first-time perl flow
	Incorporate new prorgam parameter values and labels into the gui
	and save the values, labels and checkbuttons setting in the param_flow
	namespace

  		foreach my $key (sort keys %$color_flow) {
   			print (" color_flow key is $key, value is $color_flow->{$key}\n");
  		}

=cut

sub add2flow_button {
	
	my ($self,$value)  = @_;

	$color_flow->{_flow_type} = $flow_type->{_user_built};
	 	print("1. color_flow, add2flow_button, color: $flow_color \n");
	 	# print("2. color_flow, add2flow_button, _values_w_aref $color_flow->{_values_w_aref}\n");
		# print("3. color_flow add2flow_button: _last_parameter_index_touched_color $color_flow->{_last_parameter_index_touched_color}\n");
	       
 	use messages::message_director;
 	use param_sunix;
 	
 	my $param_sunix        		= param_sunix->new();
	my $color_flow_messages 	= message_director->new();
  	my $message          		= $color_flow_messages->null_button(0);
  	
  	my $here;
  	
  	# switch between the correct index of the last parameter that was touched
	# as a function of the flow's  color 
	# These data are encapsulated 
	# _set_last_parameter_index_touched_color($flow_color);
	# _set_is_last_parameter_index_touched_color($flow_color);
		# print("31. color_flow add2flow_button: _last_parameter_index_touched $color_flow->{_last_parameter_index_touched_color}\n");	
  	 	
  	    #print("4. color_flow, add2flow_button, _values_w_aref $color_flow->{_values_w_aref}\n");
  	    
  	$conditions_gui				-> set_gui_widgets($color_flow);  # 26 used  / 112 in
 	$conditions_gui				-> set_hash_ref($color_flow);	  # 62 used / 112 in
	$conditions_gui				-> set4start_of_add2flow_button($flow_color);  # 5 set and 10 widgets configured	
	$color_flow					= $conditions_gui-> get_hash_ref();  # 88 returned	

	 			print("5. color_flow, add2flow_button, color: $flow_color \n"); 	
 	$message_w   				->delete("1.0",'end');
 	$message_w   				->insert('end', $message);	

   	# $whereami					->set4flow_listbox($flow_color);  	
			 
       		# clear all the indices of selected elements   
   	$sunix_listbox->selectionClear($sunix_listbox->curselection);
    		# print("6. color_flow, add2flow_button, _prog_name_sref: ${$color_flow->{_prog_name_sref}}\n"); 
    		# print("7. color_flow, add2flow_button, _values_w_aref $color_flow->{_values_w_aref}\n");
    
			# add the most recently selected program
			# name (scalar reference) to the 
			# end of the list indside flow_listbox 
    _set_flow_listbox_color_w($flow_color); # in "color"_flow namespace
    
   			# print("8. color_flow, add2flow_button, _is_flow_listbox_grey_w $color_flow->{_is_flow_listbox_grey_w}\n");
   			# print("81. color_flow, add2flow_button, _is_flow_listbox_pink_w $color_flow->{_is_flow_listbox_pink_w}\n");
   			# print("82. color_flow,add2flow_button,color_flow->listbox_widget: $color_flow->{_flow_listbox_color_w}\n");
   			
    # append new program names to the end of the list but this item is NOT selected
   	# selection occurs inside conditions_gui
   	$color_flow->{_flow_listbox_color_w} ->insert(
                       	"end", 
                       	${$color_flow->{_prog_name_sref}},
	               );
	  		# print("10. color_flow, add2flow_button, _values_w_aref[0] $color_flow->{_values_w_aref}[0]\n");
	  		# print("11. color_flow, add2flow_button, _labels_w_aref $color_flow->{_labels_w_aref}\n");
	  		
   	# display default paramters in the GUI
    # same as for sunix_select
    # can not get program name from the item selected in the sunix list box 
    # because focus is transferred to another list box   
   
   	$param_sunix   									->set_program_name($color_flow->{_prog_name_sref});
   	$color_flow->{_names_aref}  					= $param_sunix->get_names();
   	$color_flow->{_values_aref} 					= $param_sunix->get_values();
   	$color_flow->{_check_buttons_settings_aref}  	= $param_sunix->get_check_buttons_settings();
   	$color_flow->{_param_sunix_first_idx}  			= $param_sunix->first_idx(); # first index = 0
   	$param_sunix									-> set_half_length(); # values not #(values+labels) 
   	   	
	 		# print("12. color_flow, add2flow_button, color: $flow_color \n");
	 		# print("12. color_flow, add2flow_button, _names_aref[1] @{$color_flow->{_names_aref}}[1]\n");
			# my $length = $param_sunix-> get_length();
	 		# print("12. color_flow, add2flow_button,length_test:$length 	\n");
	 		
   	$whereami			->set4add2flow_button();
   		 	# print("13. color_flow, add2flow_button, color: $flow_color \n");
   	$here                = $whereami->get4add2flow_button();
   	$param_widgets       ->set_location_in_gui($here);
	    		# print("13. color_flow, add2flow_button, _values_aref @{$color_flow->{_values_aref}}[1]\n");
	    		
	# widgets are initialized in a super class
	# Assign program parameters in the GUI	
	# no. of parameters defaults to max=61
	$param_widgets		->set_labels_w_aref($color_flow->{_labels_w_aref} );
  	$param_widgets		->set_values_w_aref($color_flow->{_values_w_aref} );
  	$param_widgets		->set_check_buttons_w_aref($color_flow->{_check_buttons_w_aref} );
  	 			
   	$param_widgets		->range($color_flow);
   	$param_widgets		->set_labels($color_flow->{_names_aref});
   	$param_widgets		->set_values($color_flow->{_values_aref});
   	$param_widgets		->set_check_buttons($color_flow->{_check_buttons_settings_aref});
   	$param_widgets		->redisplay_labels();
   	$param_widgets		->redisplay_values();
   	
   				# print("14. color_flow, add2flow_button, _names_aref @{$color_flow->{_names_aref}}[0]\n");  			
   	  		 	# print("15. color_flow, add2flow_button, color: $flow_color \n");
   	  		 	
   	$param_widgets		->redisplay_check_buttons();
   	
   		  	# print("16. color_flow, add2flow_button, _labels_w_aref @{$color_flow->{_labels_w_aref}}[0]\n");
	  		# print("17.  color_flow, add2flow_button, _values_w_aref {$color_flow->{_values_w_aref}}\n");
			# print("17. color_flow, add2flow_button, _values_aref @{$color_flow->{_values_aref}}[1]\n");
			
   # Collect and store prog versions changed in list box
   _stack_versions();
   	
   	# Add a single_program to the growing stack
	# store one program name, its associated parameters and their values
	# as well as the checkbuttons settings (on or off) in another namespace
   	_stack_flow();
   	
	 		# print("18. color_flow, add2flow_button, _values_w_aref @{$color_flow->{_values_w_aref}}[0]\n");   	
   			# print("18. color_flow, add2flow_button, _values_aref[1] @{$color_flow->{_values_aref}}[1]\n");
	$conditions_gui			-> set_gui_widgets($color_flow); 		# includes _values_w_aref; 26 used / 61 in
 	$conditions_gui			-> set_hash_ref($color_flow);			# 61 used / 61 in
	$conditions_gui    		-> set4end_of_add2flow_button($flow_color);
	
			 # print("19. color_flow add2flow_button: _last_parameter_index_touched_color $color_flow->{_last_parameter_index_touched_color}\n");
	 		# print("4 color_flow,add2flow_button,_flowNsuperflow_name_w : $color_flow->{_flowNsuperflow_name_w} \n"); 
	    	# print("19. color_flow, add2flow_button, _values_aref @{$color_flow->{_values_aref}}[1]\n");
	    	
	my $flow_index 			= $flow_widgets->get_flow_selection($color_flow->{_flow_listbox_color_w});
	
							 # print("20.color_flow add2flow_button,last flow program touched had index: $flow_index\n");
							 # print("21. color_flow, add2flow_button, color: $flow_color \n");
							 
	$conditions_gui			-> set_flow_index_last_touched($flow_index); # flow color is not reset
	$color_flow 			=  $conditions_gui->get_hash_ref();
	
   			# print("27. color_flow, add2flow_button, _values_aref @{$color_flow->{_values_aref}}[1]\n");
	 	 	# print("5 color_flow,add2flow_button,_flowNsuperflow_name_w : $color_flow->{_flowNsuperflow_name_w} \n");
	$color_flow			->{_last_parameter_index_touched_color} 	= 0; # initialize
	$color_flow			->{_is_last_parameter_index_touched_color} 	= $true;
		
			# print("22. color_flow, add2flow_button, _is_flow_listbox_grey_w $color_flow->{_is_flow_listbox_grey_w}\n");

				# print("23. color_flow, add2flow_button, color: $flow_color \n");
	   			# print("24. color_flow,add2flow_button,color_flow->listbox_widget: $color_flow->{_flow_listbox_color_w}\n");
		  		# print("25. color_flow, add2flow_button, _values_w_aref $color_flow->{_values_w_aref}\n");
   				# print("26. color_flow,add2flow_button,color_flow->listbox_widget: $color_flow->{_flow_listbox_color_w}\n");
		    	# print("27. color_flow,add2flow_button,last grey-flow program touched had index: $color_flow->{_last_flow_index_touched}\n");
				# print("28. color_flow, add2flow_button, _values_w_aref @{$color_flow->{_values_w_aref}}[1]\n"); 
				# print("29. color_flow, add2flow_button, _values_aref @{$color_flow->{_values_aref}}[1]\n");
				# print("30. color_flow add2flow_button: _last_parameter_index_touched_color $color_flow->{_last_parameter_index_touched_color}\n");
				# print("31. color_flow add2flow_button: _is_last_parameter_index_touched_color $color_flow->{_is_last_parameter_index_touched_color}\n");
	flow_select();	
												
   	return(); 
}


=head2 sub delete_from_flow_button
   	 	
 set:
     $decisions
 
 get:
     $color_flow_messages
     $flow_widgets
     $param_flow_color_i	
 
 call:
    _stack_versions();	
	$conditions_gui->set4last_delete_from_flow_button();
    $conditions_gui->set4delete_from_flow_button();
    $color_flow 			= $conditions_gui->get_hash_ref();
  
  		
  		foreach my $key (sort keys %$color_flow) {
   			print (" color_flowkey is $key, value is $color_flow->{$key}\n");
  		}
    
=cut

sub delete_from_flow_button {

	my $self = @_;
	
	 	# if flow_select was last pushed then conditions_gui conserved the flow color chosen:	
 	my $flow_color			= $conditions_gui->get_flow_color();
 	
 				# print("1. color_flow,delete_from_flow_button, flow_color: $flow_color \n");
 	
 	if ($flow_color)  {
 		_set_flow_color($flow_color);
 		
		# switch between instances of the correct param_flow_color 
		# param_flow_color stores Data 
		_set_param_flow_color_i($flow_color);
		
 					# print("2. color_flow,delete_from_flow_button, flow_color: $color_flow->{_flow_color} \n");
 					
		use messages::message_director;
		use decisions 1.00;
	
		my $color_flow_messages 	    = message_director->new();
		my $decisions			= decisions->new();

		my $message          	= $color_flow_messages->null_button(0);
 		$message_w   			->delete("1.0",'end');
 		$message_w   			->insert('end', $message);
	
 		my $_flow_listbox_color_w 	= _get_flow_listbox_color_w();
					# print("1. color_flow,delete_from_flow_button, flow_listbox_color_w: $_flow_listbox_color_w \n");
		$conditions_gui			->set_hash_ref($color_flow);    # 57 used  /112 in
		$conditions_gui			->set_gui_widgets($color_flow); # 26 used  /112 in
		$conditions_gui			->set4start_of_delete_from_flow_button($flow_color);  # 3 set /  72 max
		$color_flow 			= $conditions_gui->get_hash_ref(); # find out if delete button is active    64 returned / 72 max
		
			# print("1. color_flow,delete_from_flow_button , is_flow_listbox_grey_w pink green or blue_w: $color_flow->{_is_flow_listbox_color_w} \n");
		$decisions				->set4delete_from_flow_button($color_flow);
		my $pre_req_ok 			= $decisions->get4delete_from_flow_button();
					# confirm listboxes are active
					# print("1. color_flow,delete_from_flow_button pre_req $pre_req_ok\n");
  		if ($pre_req_ok) {
					 # print("2. color_flowdelete_from_flow_button pre_req_ok\n");
   
  			$whereami			->set4delete_from_flow_button();
  			my $here 			= $whereami->get4delete_from_flow_button();

        			# location within GUI on first clicking delete button
        	$conditions_gui		->set_hash_ref($color_flow);
			$conditions_gui		->set_gui_widgets($color_flow);
        	$conditions_gui		->set4start_of_delete_from_flow_button($flow_color);
 			$color_flow 		= $conditions_gui->get_hash_ref();
 			
			# _set_flow_listbox_color_w($flow_color);
			my $index = $flow_widgets->get_flow_selection($_flow_listbox_color_w );
			
						# when LAST ITEM in listbox is deleted 
			if ($index == 0 && $param_flow_color_i->get_num_items == 1) {

      				 print("color_flow,delete_button, last item deleted Shut down delete button\n");
      				 #  Run and Save button
     			$flow_widgets->delete_selection($_flow_listbox_color_w );

							# the last program that was touched is cancelled out
   				$color_flow->{_last_flow_index_touched} 		= -1;
   				$color_flow->{_is_last_flow_index_touched} 	= $false;

							# print("color_flowdelete_from_flow_button,
							# last left flow program touched had index 
							# = $color_flow->{_last_flow_index_touched}\n");

							# delete stored programs and their parameters
   							# delete_from_stored_flows(); 
  				my $index2delete 	= $flow_widgets->get_index2delete();
  					 		# print("color_flowdelete_from_stored,index2delete:$index2delete\n");
  					 
  				$param_flow_color_i		->delete_selection($index2delete);

   							# collect and store latest program versions from changed list 
   				_stack_versions();
			    
			    $conditions_gui		->set_hash_ref($color_flow);
				$conditions_gui		->set_gui_widgets($color_flow);
				$conditions_gui		->set4last_delete_from_flow_button();
 				$color_flow 		= $conditions_gui->get_hash_ref();

        					# location within GUI after last item is deleted 
        		# $conditions_gui	->reset(); 						# needed?
  				# $color_flow 	= $conditions_gui->get_hash_ref();# needed?
  			
				# $decisions       ->reset();						# needed?

				# Blank out all the widget parameter names 
				# and their values
				$param_flow_color_i->clear();
							
				$whereami			->set4delete_from_flow_button();
        		$here				= $whereami->get4delete_from_flow_button();
   				$param_widgets      ->set_location_in_gui($here);
   				$param_widgets		->gui_full_clear();
   				
   				# Blank out the names of the programs in the GUI
   				_set_flow_name_color_w($flow_color);
   				# $color_flow->{_flow_name_grey_w}     -> configure(-text => $var->{_clear_text});
   				$flow_name_color_w    -> configure(-text => $var->{_clear_text});
   				$color_flow->{_flowNsuperflow_name_w}-> configure(-text => $var->{_clear_text});
        
   			} elsif ($index >= 0) { #  i.e., more than one item remains in a listbox	
			
							# note the last program that was touched
							 $color_flow->{_last_flow_index_touched} 	= $index;
							 $color_flow->{_is_last_flow_index_touched} 	= $true;

					   		# print("color_flow delete_from_flow_button, last index touched :$index..\n");
     			$flow_widgets->delete_selection($_flow_listbox_color_w );

					# delete stored programs and their parameters
   					# delete_from_stored_flows(); 
  				my $index2delete 	= $flow_widgets->get_index2delete();
  					 		#print("2. color_flowdelete_from_stored,index2delete:$index2delete\n");
  				$param_flow_color_i		->delete_selection($index2delete);

					# update the widget parameter names and values
					# to those of new selection after deletion
  					# the chkbuttons, values and names of only the last program used 
  					# are stored in param_widgets at any one time			
  					# get parameters from storage
  				my $next_idx_selected_after_deletion = $index2delete - 1;	
            	if($next_idx_selected_after_deletion == -1) { $next_idx_selected_after_deletion = 0} # NOT < 0
  					  		# print("2. color_flowdelete_from_flow_button,indexafter_deletion:
  					  		# $next_idx_selected_after_deletion\n");

   		 		$param_flow_color_i		-> set_flow_index($next_idx_selected_after_deletion);
 				$color_flow->{_names_aref} 	= $param_flow_color_i->get_names_aref();

  							 # print("2. color_flow delete_from_flow_button,parameter names 
  							 # is @{$color_flow->{_names_aref}}\n");
 				$color_flow->{_values_aref} 	=	$param_flow_color_i->get_values_aref();

  				 			 # print("3. color_flow delete_from_flow_button,parameter values 
  				 			 # is @{$color_flow->{_values_aref}}\n");
 				$color_flow->{_check_buttons_settings_aref} 
										=  $param_flow_color_i->get_check_buttons_settings();

  				 			 # print("4. color_flow delete_from_flow_button, 
  				 			 # check_buttons_settings no changes, 
  				 			 # @{$color_flow->{_check_buttons_settings_aref}}, index;$index\n#");
  				 			
 				 			# get stored first index and num of items 
 				$color_flow->{_param_flow_first_idx}	= $param_flow_color_i->first_idx();
 				$color_flow->{_param_flow_length}   	= $param_flow_color_i->length();
 				$color_flow->{_prog_name_sref}		= $param_widgets->get_current_program(\$_flow_listbox_color_w );
 				$param_widgets				 	->set_current_program($color_flow->{_prog_name_sref});
				$whereami						->set4flow_listbox($flow_color);
				$here 							= $whereami->get4flow_listbox();
				 			 # print("color_flow delete_from_flow_button, $here->{_is_flow_listbox_color_w}\n");
				 			 
	    		$param_widgets      		->set_location_in_gui($here);
   				$param_widgets				->gui_clean();
  				$param_widgets				->range($color_flow);
 				$param_widgets				->set_labels($color_flow->{_names_aref});
 				$param_widgets				->set_values($color_flow->{_values_aref});
 				$param_widgets				->set_check_buttons(
									$color_flow->{_check_buttons_settings_aref});

					  		 # print("color_flow, delete_from_flow_button, is listbox selected:$here->{_is_flow_listbox_color_w}\n");
 				$param_widgets				->redisplay_labels();
 				$param_widgets				->redisplay_values();
 					$param_widgets			->redisplay_check_buttons();
	#  			$param_widgets				->set_entry_change_status($false);	

							# note the last program that was touched
			 	$color_flow->{_last_flow_index_touched} 		= $next_idx_selected_after_deletion;
				$color_flow->{_is_last_flow_index_touched} 	= $true;
   					# collect and store latest program versions from changed list 
   				_stack_versions();
   			}
  		} # if pre_req_ok	
		
 	} else { # if flow_color
 		print("color_flow, delete_from_flow_button, flow color missing: \n");
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
  	$color_flow
  	$flow_widgets
  	
  sets to:
  	$param_flow_color_i
  	$flow_widgets
  	
  calls: _stack_versions
  o/p need
	
=cut

sub drag {
  	my ($self) = @_;   
					# print("1. color_flowdrag;just starting\n");
					# print("1. color_flowdrag;listbox can not be empty\n");
					# print("1. color_flowdrag;more than one item must exist\n");
  my $prog_name;
  if($color_flow->{_prog_name_sref}) {
	$prog_name					= ${$color_flow->{_prog_name_sref}};
	# print("1. color_flowdrag,prog=$prog_name\n");
   }
   
			# was a program deleted through a previous dragNdrop? 
			# Has a program name even been selected or is user just playing aimlessly? # K
 	if( $prog_name && $flow_widgets->is_drag_deleted($flow_listbox_grey_w) ) {
 		
 		# switch between instances of the correct param_flow_color 
		# param_flow_color stores Data 
		_set_param_flow_color_i($flow_color);

			print("2.color_flowdrag; prior index was deleted\n");
        my $this_index = $flow_widgets->get_drag_deleted_index($flow_listbox_grey_w);

			print("color_flowdrag,deleting flow_listbox,idx=$this_index\n");
    	print("index $this_index was just removed from widget\n");

						# delete stored values from param_flow
    	$param_flow_color_i->delete_selection($this_index); 

						# update program versions if listbox changes
						# store via param_flows
    	_stack_versions();
		$flow_widgets->set_vigil_on_delete();
  	}						  
						# in case a previous drag updated the 
						# vigil_on_delete counter
						# reset drag and drop vigil_on_delete counter 
	#$flow_widgets->set_vigil_on_delete();
	
	my $num_items = $flow_widgets->get_num_items($flow_listbox_grey_w);
  						# print("color_flowdrag,num items prior to deletion  = $num_items\n");

  	if ( $num_items > 1 ) {  # num_items PRIOR to deletion
   	   $flow_widgets->drag_start($dnd_token_grey);
	    				# print("color_flowdrag,start dnd_token_grey:$dnd_token_grey\n");
  	} else {
						# print("WARNING: color_flowdrag,not allowed\n");
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
   			$color_flow
   			$flow_widgets
   			$flow_listbox_color_w  	
   	
   	 	sets:
   	 		$color_flow
   			$flow_listbox_color_w
   			$flow_widgets

	calls external _stack_versions
	calls external _move_in_stored_flows
	
	happens inside a Listbox only
	
=cut

sub drop {
   my ($self) 						= @_;   
   my $done;
   my $chosen_index_to_drop 		= $flow_widgets->drag_end($dnd_token_grey);
   my $prog_name;
   
   # listbox must have at least one item
   if($color_flow->{_prog_name_sref}) {
	$prog_name					= ${$color_flow->{_prog_name_sref}};
	# print("1. color_flowdrop,prog=$prog_name\n");
   }

   if ($prog_name && $chosen_index_to_drop && $chosen_index_to_drop>=0  ) {   # same as destination_index
   
   	 # print("2. color_flowdrop,prog=$prog_name\n");
   
	        			# if insertion occurs within the listbox
	 $color_flow->{_index2move} 			= $flow_widgets->index2move();
     $color_flow->{_destination_index} 	= $flow_widgets->destination_index;

							# note the last program that was touched
    						 $color_flow->{_last_flow_index_touched} 	= $color_flow->{_destination_index} ;
    						 $color_flow->{_is_last_flow_index_touched} 	= $true;
							 	# print(" color_flow drop, destination index = $color_flow->{_last_flow_index_touched}\n");

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

	# highlight new index
	_set_flow_listbox_color_w($flow_color); # in "color"_flow namespace
	$flow_listbox_color_w    ->selectionSet( $color_flow->{_destination_index},);
    #$flow_listbox_grey_w    ->selectionSet( $color_flow->{_destination_index},);
    
   }
}


=head2 sub flow_item_down_arrow_button

 	move items down in a flow listbox
    
=cut

 sub flow_item_down_arrow_button{

	my $self = @_;
	my $prog_name;
	
	if ($flow_color)  {
		# print("1. color_flow,flow_item_down_arrow_button,color_flow->listbox_widget: $color_flow->{_flow_listbox_color_w}, color: $flow_color\n");
		_set_flow_color($flow_color);
		
		# switch between instances of the correct param_flow_color 
		# param_flow_color stores Data 
		_set_param_flow_color_i($flow_color);
		
 		# $conditions_gui->set4start_of_flow_item_down_arrow_button($color_flow);
 		
		use messages::message_director;
		use decisions 1.00;
	
		my $color_flow_messages 	    = message_director->new();
		my $decisions					= decisions->new();

		my $message          			= $color_flow_messages->null_button(0);
 		$message_w   					->delete("1.0",'end');
 		$message_w   					->insert('end', $message);

		$prog_name						= ${$color_flow->{_prog_name_sref}};
	
			# 		
  			# print("3. color_flow,flow_item_down_arrow_button, prog_name: $prog_name  \n");
	
		#  get number of items in the flow listbox
		# _set_flow_listbox_color_w($flow_color); # in "color"_flow namespace
 		my $_flow_listbox_color_w 			= _get_flow_listbox_color_w();  # user-built_flow in current use	
	  	my $num_items 						= $flow_widgets->get_num_items($_flow_listbox_color_w );

	  		 	# print("4. color_flow,flow_item_down_arrow_button, num_items: $num_items \n");
	
		# get the current index					
   		my $current_flow_listbox_index  	= $flow_widgets->get_flow_selection($_flow_listbox_color_w);
   	
   		# the destination index will be one more
 		my $destination_index				= 	$current_flow_listbox_index + 1;
 		
 		# limit max index
    	if ($destination_index >= $num_items) { 
    		$destination_index = $num_items -1;
    	} 
		
		# MEET THESE conditions, OR do NOTHING
		if ( $prog_name  && 
			($current_flow_listbox_index >= 0 ) &&
			$destination_index < $num_items   ) {
			
			$color_flow->{_index2move} 			= $current_flow_listbox_index;
     		$color_flow->{_destination_index} 	= $destination_index;
     	
     	 	# print("2. color_flow,flow_item_down_arrow_button, destination_index: $destination_index \n");
     	 	# print("2. color_flow,flow_item_down_arrow_button, current index: $current_flow_listbox_index\n");
     	 	
     	 	# modify flow listbox
     	 	# _set_flow_listbox_color_w($flow_color); # in "color"_flow namespace
   			 # print("3. color_flow,flow_item_down_arrow_button , _is_flow_listbox_grey_w $color_flow->{_is_flow_listbox_grey_w}\n");
   			# print("2. color_flow,flow_item_down_arrow_button,color_flow->listbox_widget: $color_flow->{_flow_listbox_color_w}, color: $flow_color\n");
   			
   			# get all the elements from inside the listbox 			
   			my @elements = $_flow_listbox_color_w->get(0, 'end');
     	 	
     	 	# rearrange elements  	 	
     	 	my $saved_item = $elements[$color_flow->{_index2move}];
     	 	
    		$color_flow->{_flow_listbox_color_w}->delete($color_flow->{_index2move});
    		$color_flow->{_flow_listbox_color_w}->insert($color_flow->{_destination_index}, $saved_item);
    		$color_flow->{_flow_listbox_color_w}->selectionSet($color_flow->{_destination_index});
     	 	     	 	
			# note the last program that was touched
    		$color_flow->{_last_flow_index_touched} 		= $color_flow->{_destination_index} ;
    		$color_flow->{_is_last_flow_index_touched} 	= $true;
       
    		# move stored data within arrays
			my $start	= $color_flow->{_index2move};
  			my $end	    = $color_flow->{_destination_index};
  			
  			$param_flow_color_i	->set_insert_start($start);
   			$param_flow_color_i	->set_insert_end($end);
   			$param_flow_color_i	->insert_selection();
   			
			# update program versions if listbox changes
			# stored in param_flows
     		_stack_versions();
  			
  			# update the parameter widget labels and their values

			# highlight new index
			_set_flow_listbox_color_w($flow_color); # in "color"_flow namespace
			$_flow_listbox_color_w    ->selectionSet( $color_flow->{_destination_index},);
    		#$flow_listbox_grey_w    ->selectionSet( $color_flow->{_destination_index},);
    		# print("2. color_flow,flow_item_down_arrow_button, flow_color: $color_flow->{_flow_color} \n"); 
    		
    		# carry out all gui updates needed
    		flow_select();
    
		}else {	
   	   		print("color_flow, flow_item_down_arrow_button missing program or bad index\n");
		}
		 		
  	 } else {
  	 	print("color_flow, flow_item_down_arrow_button missing color \n");
  	 }  		
 		
}

=head2 sub flow_item_up_arrow_button

		move items up in a flow listbox
    
=cut

sub flow_item_up_arrow_button {

	my $self = @_;
	my $prog_name;
	
	if ($flow_color)  {
		_set_flow_color($flow_color);
		
		# switch between instances of the correct param_flow_color 
		# param_flow_color stores Data 
		_set_param_flow_color_i($flow_color);
		
 		# $conditions_gui->set4start_of_flow_item_up_arrow_button($color_flow);
 		
		use messages::message_director;
		use decisions 1.00;
	
		my $color_flow_messages 	    = message_director->new();
		my $decisions					= decisions->new();

		my $message          			= $color_flow_messages->null_button(0);
 		$message_w   					->delete("1.0",'end');
 		$message_w   					->insert('end', $message);

		$prog_name						= ${$color_flow->{_prog_name_sref}};
	
			# print("2. color_flow,flow_item_up_arrow_button, flow_color: $color_flow->{_flow_color} \n"); 		
  			# print("3. color_flow,flow_item_up_arrow_button, prog_name: $prog_name  \n");
	
		#  get number of items in the flow listbox
 		my $_flow_listbox_color_w 			= _get_flow_listbox_color_w();  # user-built_flow in current use
	  	my $num_items 						= $flow_widgets->get_num_items($_flow_listbox_color_w);
				# my $num_items 						= $flow_widgets->get_num_items($flow_listbox_grey_w);	
	  		 		# print("4. color_flow,flow_item_up_arrow_button, num_items: $num_items \n");
	
		# get the current index	
				
   		my $current_flow_listbox_index  = $flow_widgets->get_flow_selection($_flow_listbox_color_w);
   	
   		# the destination index will be one less
 		my $destination_index			= 	$current_flow_listbox_index - 1;
    	if ($destination_index <= 0 ) { $destination_index = 0 } # limit min index
		
		# MEET THESE conditions, OR do NOTHING
		if ( $prog_name  && 
			($current_flow_listbox_index > 0 ) &&
			$destination_index >= 0   ) {
			
			$color_flow->{_index2move} 			= $current_flow_listbox_index;
     		$color_flow->{_destination_index} 	= $destination_index;
     	
     	 	# print("2. color_flow,flow_item_down_arrow_button, destination_index: $destination_index \n");
     	 	# print("2. color_flow,flow_item_down_arrow_button, current index: $current_flow_listbox_index\n");
     	 	
			# note the last program that was touched
    		$color_flow->{_last_flow_index_touched} 	= $color_flow->{_destination_index} ;
    		$color_flow->{_is_last_flow_index_touched} 	= $true;
         	
         	# modify flow listbox
     	 	# _set_flow_listbox_color_w($flow_color); # in "color"_flow namespace
   			# print("3. color_flow,flow_item_up_arrow_button , _is_flow_listbox_grey_w $color_flow->{_is_flow_listbox_grey_w}\n");
   			# print("3. color_flow,flow_item_up_arrow_button,color_flow->listbox_widget: $color_flow->{_flow_listbox_color_w}\n");
   			
   			# get all the elements from inside the listbox 			
   			my @elements = $_flow_listbox_color_w->get(0, 'end');
     	 	
     	 	# rearrange elements  	 	
     	 	my $saved_item = $elements[$color_flow->{_index2move}];
     	 	
    		$color_flow->{_flow_listbox_color_w}->delete($color_flow->{_index2move});
    		$color_flow->{_flow_listbox_color_w}->insert($color_flow->{_destination_index}, $saved_item);
    		$color_flow->{_flow_listbox_color_w}->selectionSet($color_flow->{_destination_index});
     	 	     	 	
			# note the last program that was touched
    		$color_flow->{_last_flow_index_touched} 		= $color_flow->{_destination_index} ;
    		$color_flow->{_is_last_flow_index_touched} 	= $true;
 
     		# move stored data within arrays
			my $start	= $color_flow->{_index2move};
  			my $end	    = $color_flow->{_destination_index};
  			
  			$param_flow_color_i	->set_insert_start($start);
   			$param_flow_color_i	->set_insert_end($end);
   			$param_flow_color_i	->insert_selection();
    
			# update program versions if listbox changes
			# stored in param_flows
     		_stack_versions();

			# highlight new index
			# _set_flow_listbox_color_w($flow_color); # in "color"_flow namespace
			$_flow_listbox_color_w    ->selectionSet( $color_flow->{_destination_index},);
    		#$flow_listbox_grey_w    ->selectionSet( $color_flow->{_destination_index},);
    		
    		# carry out all gui updates needed
    		flow_select();
  	   	
		}else {	
   	   		# print("color_flow, flow_item_up_arrow_button missing program or bad index\n");
		}
		 		
  	 } else {
  	 	print("color_flow, flow_item_up_arrow_button missing color \n");
  	 }  		
 		
}


=head2 sub flow_select

  Pick a Seismic Unix module
  from within a flow listbox
  This module was placed there previously by user
  When there is only one item left in the
  listbox drag and drop becomes blocked
  N.B. I assume that _check4flow_changes will prove false in this case
  check whether any programs were deleted by dragging previously
  If so, delete stored values from param_flow
  N.B. I assume that _check4flow_changes will prove false in this case
  
  if($color_flow->{_prog_name_sref}) {
 		print("\n1. color_flow flow_select, program name is $color_flow->{_prog_name_sref}\n");
 	}

  	gets from:
    	flow_widgets
    	param_widgets
  
  	sets 
   		param_flow
  		param_widgets
    color_flow

 	calls
 	  	_stack_versions
  		_check4flow_changes();
 		$conditions_gui->set4start_of_flow_select(); 
  		$conditions_gui->set4end_of_flow_select();
  	 $color_flow 			= $conditions_gui->get_hash_ref();
  	 
    	  foreach my $key (sort keys %$color_flow) {
           print (" color_flowkey is $key, value is $color_flow->{$key}\n");
          }
    	     	 
  	always takes focus on first entry ; index = 0
  	if focus is on first endtry then also make the last_paramter_index_touched = 0
  	TODO: via conditions package
    	  foreach my $key (sort keys %$color_flow) {
           print ("color_flow, key is $key, value is $color_flow->{$key}\n");
          }	  
          
    Important variables:
      $color_flow->{_prog_name_sref}  : selected program name as a scalar reference
      
    foreach my $key (sort keys %$color_flow) {
   			print (" color_flow key is $key, value is $color_flow->{$key}\n");
  	}
  	
=cut

sub flow_select {
	my ($self) = @_;
	
	use messages::message_director;
	use decisions;
	
	# reset residual flow_listbox_color_w of another color
	_set_flow_listbox_color_w($flow_color);

	# switch between instances of the correct param_flow_color 
	# param_flow_color stores Data 
	_set_param_flow_color_i($flow_color);
	
  	# switch between the correct index of the last parameter that was touched
	# as a function of the flow's  color 
	# These data are encapsulated 
	# _set_last_parameter_index_touched_color($flow_color);
	# _set_is_last_parameter_index_touched_color($flow_color);
	
				# print("1. color_flow, flow_select, _is_last_parameter_index_touched_color:$color_flow->{_is_last_parameter_index_touched_color}, color:$flow_color\n");	
				# print("1. color_flow, flow_select, _last_parameter_index_touched_color:$color_flow->{_last_parameter_index_touched_color}, color:$flow_color\n");	
	
					# print("1. color_flow, flow_select, _flow_listbox_color_w:$color_flow->{_flow_listbox_color_w}, color:$flow_color\n");					
					# print("1. color_flow, flow_select _values_aref[1] @{$color_flow->{_values_aref}}[1]\n"); 
				
	my $color_flow_messages 	= message_director->new();
	my $decisions				= decisions->new();
	
 			# print("2. color_flow,flow_select,_flowNsuperflow_name_w : $color_flow->{_flowNsuperflow_name_w} \n");
			# $color_flow->{_names_aref} 		= $param_flow_color_i->get_names_aref();
			# print("2. color_flow flow_select,parameter names: @{$color_flow->{_names_aref}}[0]\n");	
			# $color_flow->{_flow_type} = $flow_type->{_user_built}; 
			# print("4. color_flow, flow_select, array of widgets: _values_w_aref=  @{$color_flow->{_values_w_aref}}\n");
			# my $value = @{$color_flow->{_values_w_aref}}[3]->get;
			# print("5. color_flow, flow_select, first value of first widget: _values_w_aref= $value \n");			
			# my $size = scalar @{$color_flow->{_values_aref}};
			# print("5. color_flow, flow_select,no. values is $size\n");
			
	my $message          		= $color_flow_messages->null_button(0);
 	$message_w   				->delete("1.0",'end');
 	$message_w   				->insert('end', $message);
 	
			# print("6. color_flow, flow_select,flow color: $color_flow->{_flow_color} = flow_color $flow_color \n");
			
  	$conditions_gui				-> set_gui_widgets($color_flow);
 	$conditions_gui				-> set_hash_ref($color_flow);
	$conditions_gui				-> set4start_of_flow_select($flow_color);
	$color_flow					= $conditions_gui->get_hash_ref();

	
			# my $value = @{$color_flow->{_values_w_aref}}[1]->get;
			# print("7. color_flow, flow_select, first value of first widget: _values_w_aref= $value \n");
	
	# update the flow color as per add2flow_select	
	my $_flow_listbox_color_w 	= _get_flow_listbox_color_w();
	
				#  independently set conditions to make grey box available
				# print("8. color_flow, flow_select,_is_flow_listbox_grey_w $color_flow->{_is_flow_listbox_grey_w}\n");
				
	#TODO: careful, color is re-assigned from conditions_gui,few lines up ... necessary?
 	my $flow_color				= $color_flow ->{_flow_color}; 
 	
 				# print("9 color_flow, flow_select,_last_flow_listbox_touched_w: $color_flow->{_last_flow_listbox_touched_w} \n");
 	 			# print("10. color_flow,flow_select,_prog_name_sref: ${$color_flow->{_prog_name_sref}} \n");
 	 						
    $color_flow->{_prog_name_sref} 		= $flow_widgets->get_current_program(\$_flow_listbox_color_w);
    
    			# print("3 color_flow,flow_select,_prog_name_sref: ${$color_flow->{_prog_name_sref}} \n");
    				  
	$decisions		 		 				->set4flow_select($color_flow);
					# print("11. color_flow, flow_select, _values_w_aref $color_flow->{_values_w_aref}\n");
						
	my $pre_req_ok 	  						= $decisions->get4flow_select();
					
					# print ("color_flow, flow_select, pre_req_ok: $pre_req_ok\n");
				 	# print("12 color_flow,flow_select,_prog_name_sref: ${$color_flow->{_prog_name_sref}} \n");
	
	if ($pre_req_ok) {
		use binding;
 		my $binding 			 = binding -> new;;
		my $here;
    						
		$color_flow->{_prog_name_sref} 	= $flow_widgets->get_current_program(\$_flow_listbox_color_w);
		
 				 			# print ("8. color_flow, flow_select, flow_color: $flow_color\n");
 				 			# print("13 color_flow,flow_select,_prog_name_sref: ${$color_flow->{_prog_name_sref}} \n");
 				 					
			# Is a program deleted through a previous dragNdrop?
  			if( $flow_widgets->is_drag_deleted($_flow_listbox_color_w) ) {

			  				 # print("\n\ncolor_flowflow_select,something was deleted in previous dragNdrop\n");
			  				 
        		my $this_index 		= $flow_widgets->get_drag_deleted_index($_flow_listbox_color_w);
        		
							 # print("color_flowflow_select,deleting flow_listbox,idx=$thi# s_index\n");
     						 # print("index (old) $this_index was just removed from widget\n");

				# delete stored values from param_flow
     			$param_flow_color_i->delete_selection($this_index); 

				# update program versions if listbox changes
				# store via param_flows
     			_stack_versions(); 
     						# reset drag and drop vigil_on_delete counter
				$flow_widgets->set_vigil_on_delete();
			
			}	# end deletion	
						# print("3. color_flow, flow_select, _values_w_aref $color_flow->{_values_w_aref}\n");
						
		# Find out which program was previously touched
		# Assume all prior programs that were touched have
		# modified parameters 
		# and update the previously touched program's values in storage via param_flow	
		# Find out which index was touched in "color"-flow box
		_check4flow_changes();
		
			# my $value = @{$color_flow->{_values_w_aref}}[1]->get;
			# print("5. color_flow, flow_select: _values_aref[1]= $value \n");  
			                  
		# for just-selected program name
		# get its flow parameters from storage
		# and redisplay the widgets with parameters
							
		# Update the flow item index to the program that is currently being used, instead of last-used program 
   		my $index 							= $flow_widgets->get_flow_selection($_flow_listbox_color_w);
   		
						# print("color_flow, flow_select,_flow_listbox_color_w: $color_flow->{_flow_listbox_color_w} \n");
  						# print("color_flow, flow_select, current index is $index\n");
  						# print("color_flow, flow_select, last_flow_index_touched:$color_flow->{_last_flow_index_touched}\n");
						# print("color_flow flow_select: _last_parameter_index_touched $color_flow->{_last_parameter_index_touched_color}\n");
  								
  					# number of programs in flow
  					# my $num_items 						= $param_flow_color_i->get_num_items(); 
 		$param_flow_color_i					->set_flow_index($index);
 		$color_flow->{_names_aref} 			= $param_flow_color_i->get_names_aref();
  		$color_flow->{_values_aref} 		= $param_flow_color_i->get_values_aref();
 		
  							print("2. color_flow flow_select,parameter names[0]: @{$color_flow->{_names_aref}}[0], flow_color: $flow_color\n");
  							print("2. color_flow flow_select,parameter values[0]:@{$color_flow->{_values_aref}}[0], flow_color: $flow_color\n");
  							print("2. color_flow flow_select,param_flow_color_i: $param_flow_color_i\, flow_color: $flow_color\n");
  							print("2. color_flow flow_select,param_flow_grey: $param_flow_grey, flow_color: $flow_color\n");
  							print("2. color_flow flow_select,param_flow_pink: $param_flow_pink\, flow_color: $flow_color\n");
  							

 		
  				 			  # print("3. color_flowflow_select,parameter values:@{$color_flow->{_values_aref}}[1]\n");
  				 			 
 		$color_flow->{_check_buttons_settings_aref} 
									=  $param_flow_color_i->get_check_buttons_settings();

  				 			 # print("4. color_flowflow_select, check_buttons_settings no changes, @{$color_flow->{_check_buttons_settings_aref}}\n");
  				 			 # print("4. color_flowflow_select,index: $index \n");
  				 			
 		# get stored first index and num of items 
 		$color_flow->{_param_flow_first_idx}	= $param_flow_color_i->first_idx();
 		$color_flow->{_param_flow_length}   	= $param_flow_color_i->length();
 		
 		$param_widgets				 			->set_current_program($color_flow->{_prog_name_sref});

 				 				# print("5. color_flow, flow_select, _values_w_aref $color_flow->{_values_w_aref}\n");
				 			  	# print("color_flow, flow_select, $color_flow->{_is_flow_listbox_color_w}\n");
				 			  	# print("color_flow, flow_select, color:$flow_color\n");
				 			  	
		$whereami				->set4flow_listbox($flow_color);
		$here 					= $whereami->get4flow_listbox();
		
				 			  # print("5. color_flowflow_select,here->{_is_flow_listbox_color_w: $here->{_is_flow_listbox_color_w}\n");
				 			  # print("color_flow, flow_select, _is_flow_listbox_color_w, $here->{_is_flow_listbox_color_w}\n");
		 				 	  # print("6. color_flow, flow_select, _values_w_aref $color_flow->{_values_w_aref}\n");	
		 				 	  # print("7. color_flow, flow_select,_param_flow_first_idx, $color_flow->{_param_flow_first_idx}\n");	
		  				 	  # print("8. color_flow, flow_select,_param_flow_length, $color_flow->{_param_flow_length}\n");	

	    $param_widgets      		->set_location_in_gui($here);
	    	    	
		# widgets were initialized in super class	
		$param_widgets				->set_labels_w_aref($color_flow->{_labels_w_aref} );
  		$param_widgets				->set_values_w_aref($color_flow->{_values_w_aref} );
  		$param_widgets				->set_check_buttons_w_aref($color_flow->{_check_buttons_w_aref} );
	    	    
   		$param_widgets				->gui_full_clear();
  		$param_widgets				->range($color_flow);
 		$param_widgets				->set_labels($color_flow->{_names_aref});
 		$param_widgets				->set_values($color_flow->{_values_aref});
 		$param_widgets				->set_check_buttons($color_flow->{_check_buttons_settings_aref});
										
					  		 # print("6. color_flowflow_select, is listbox selected:$here->{_is_flow_listbox_color_w}\n");
					  		 
		$whereami					->set4flow_listbox($flow_color);
		$here 						= $whereami->get4flow_listbox();
		
							 # print("6. color_flow, flow_select, _values_w_aref $color_flow->{_values_w_aref}\n");
							 
    	$param_widgets      		->set_location_in_gui($here);
 		$param_widgets				->redisplay_labels();
 		$param_widgets				->redisplay_values();
 		$param_widgets				->redisplay_check_buttons();
  		$param_widgets				->set_entry_change_status($false);	

		my @Entry_widget			= @{$param_widgets->get_values_w_aref()};
		
							# print("color_flow, flow_select,Entry_widgets@Entry_widget\n");
							
		$Entry_widget[0]			->focus;  # always put focus on first entry widget
		
		# Force the parameter index = 0 (NOT the flow index that marks the index of the programs in the flow);
		# If parameter_index >= 0 stored values will also be updated via check4paramter_changes
		# TODO the parameter_index_touched may become  .n.e. 0 but >=0
		# $color_flow->{_last_parameter_index_touched_color} = 0;
		# the changed parameter value in the Entry widget should force an update of stored values
		# in the current flow item (not the last flow item touched)
		# _check4parameter_changes(); # is only active if $color_flow->{_last_parameter_index_touched_color} >= 0
			
		# Here is where you rebind the different buttons depending on the
 		# program name that is selected (i.e., through spec.pm) 
 		$binding					->set_prog_name_sref($color_flow->{_prog_name_sref});
 		$binding					->set_values_w_aref($param_widgets->get_values_w_aref);
 		
 		#reference to local subroutine that will be run when MB3 is pressed
 		$binding					->setFileDialog_button_sub_ref (\&_FileDialog_button);  
 		$binding					->set();
				# print("7. color_flow, flow_select, _values_w_aref $color_flow->{_values_w_aref}\n");

  		$conditions_gui				-> set_gui_widgets($color_flow);
 		$conditions_gui				-> set_hash_ref($color_flow);
    	$conditions_gui				-> set4end_of_flow_select($flow_color);
    	$conditions_gui				-> set_flow_index_last_touched($index);
   		  		 # print("14 color_flow,flow_select,_prog_name_sref: ${$color_flow->{_prog_name_sref}} \n");	
    	$color_flow 				= $conditions_gui->get_hash_ref(); # now color_flow= 0; flow_type=user_built
    			# print("15. color_flow,flow_select,_prog_name_sref: ${$color_flow->{_prog_name_sref}} \n");
    			# print("6. color_flow,flow_select,flow_color: $color_flow->{_flow_color} \n");
    		
    		# Here is where you update th entry button value that displays the currently active 
			# flow or superflow name, by using the currently selected program name from the flow list
			# e.g. data_in, suximage, suxgraph etc.

				# print("8. color_flow,flow_select,_flowNsuperflow_name_w : $color_flow->{_flowNsuperflow_name_w} \n");
				# print("16. color_flow,flow_select,_prog_name_sref: ${$color_flow->{_prog_name_sref}} \n");
    		
    	$color_flow->{_flowNsuperflow_name_w}-> configure(-text => ${$color_flow->{_prog_name_sref}} );
    	
   		return();
	} # end pre_ok
}



=head2 sub get_hash_ref 

	exports private hash
	
	47 
 
=cut

 	sub get_hash_ref {
 		my ($self) 	= @_;
 				# print("color_flow, get_hash_ref \n");
 				
 		$color_flow->{_Data_menubutton}				= $Data_menubutton;		
      	$color_flow->{_Flow_menubutton}				= $Flow_menubutton;
      	$color_flow->{_FileDialog_sub_ref}			= $FileDialog_sub_ref;
 		$color_flow->{_FileDialog_option}			= $FileDialog_option;
     	$color_flow->{_SaveAs_menubutton}			= $SaveAs_menubutton;      						 	 		
 		$color_flow->{_add2flow_button_grey}		= $add2flow_button_grey;
 		$color_flow->{_add2flow_button_pink}		= $add2flow_button_pink;
 		$color_flow->{_add2flow_button_green}		= $add2flow_button_green;
 		$color_flow->{_add2flow_button_blue}		= $add2flow_button_blue;
 		$color_flow->{_check_code_button}			= $check_code_button;
 		$color_flow->{_check_buttons_w_aref}	 	= $check_buttons_w_aref;
 		$color_flow->{_delete_from_flow_button}		= $delete_from_flow_button;
 		$color_flow->{_dnd_token_grey}				= $dnd_token_grey;
 		$color_flow->{_dnd_token_pink}				= $dnd_token_pink; 
 		$color_flow->{_dnd_token_green}				= $dnd_token_green; 
 		$color_flow->{_dnd_token_blue}				= $dnd_token_blue; 
 		$color_flow->{_dropsite_token_grey}			= $dropsite_token_grey;
  		$color_flow->{_dropsite_token_pink}			= $dropsite_token_pink; 
   		$color_flow->{_dropsite_token_green}		= $dropsite_token_green;
    	$color_flow->{_dropsite_token_blue}			= $dropsite_token_blue; 
 	 	$color_flow->{_file_menubutton}				= $file_menubutton;	 	
 		$color_flow->{_flow_color}					= $flow_color; 
 		$color_flow->{_flow_item_down_arrow_button}	= $flow_item_down_arrow_button;
 		$color_flow->{_flow_item_up_arrow_button}	= $flow_item_up_arrow_button;		
 	 	$color_flow->{_flow_listbox_grey_w}			= $flow_listbox_grey_w;
 	 	$color_flow->{_flow_listbox_pink_w}			= $flow_listbox_pink_w;
  	 	$color_flow->{_flow_listbox_green_w}		= $flow_listbox_green_w;
 	 	$color_flow->{_flow_listbox_blue_w}			= $flow_listbox_blue_w;
  	 	$color_flow->{_flowNsuperflow_name_w}		= $flowNsuperflow_name_w;
  	 	$color_flow->{_flow_name_grey_w}			= $flow_name_grey_w;
 	 	$color_flow->{_flow_name_pink_w}			= $flow_name_pink_w;
 	 	$color_flow->{_flow_name_green_w}			= $flow_name_green_w;
  	 	$color_flow->{_flow_name_blue_w}			= $flow_name_blue_w;
  	 	$color_flow->{_is_pre_built_superflow}		= $is_pre_built_superflow;				
  	 	$color_flow->{_is_user_built_flow}	 		= $is_user_built_flow;		
   		$color_flow->{_labels_w_aref}		 		= $labels_w_aref;
		$color_flow->{_message_w}					= $message_w; 
   		$color_flow->{_mw}							= $mw;
 	 	$color_flow->{_parameter_names_frame}  		= $parameter_names_frame; 	
 	 	$color_flow->{_parameter_values_frame} 		= $parameter_values_frame;
 		$color_flow->{_parameter_values_button_frame}=$parameter_values_button_frame;
 		$color_flow->{_prog_name_sref}		 		= $prog_name_sref;
 		$color_flow->{_run_button}					= $run_button; 	 	
 		$color_flow->{_save_button}					= $save_button; 
 		$color_flow->{_sunix_listbox}				= $sunix_listbox;
 		$color_flow->{_values_w_aref} 				= $values_w_aref;
 		
 		# $color_flow->{_flow_name_color_w}			= $flow_name_color_w; do not export
 					
 		return($color_flow);

 	}

=head2 sub get_flow_color

	exports private hash value
 
=cut

 	sub get_flow_color {
 		my ($self) 	= @_;
 		
 		if( $color_flow->{_flow_color}) {
 			my $color;
 			
 			$color = $color_flow->{_flow_color}; 
 			return($color);
 			
 		} else {
 			print("color_flow, missing flow color\n");
 		}

 	}
 	
 	
=head2 sub get_flow_type

	exports private hash value
 
=cut

 	sub get_flow_type {
 		my ($self) 	= @_;
 		
 		if( $color_flow->{_flow_type}) {
 			my $flow_type;
 			
 			$flow_type = $color_flow->{_flow_type}; 
 			return($flow_type);
 			
 		} else {
 			print("color_flow, missing flow type\n");
 		}

 	}





=head2 sub get_prog_name_sref 

	exports private hash value
 
=cut

 	sub get_prog_name_sref {
 		my ($self) 	= @_;
 		
 		if( $color_flow->{_prog_name_sref}) {
 			my $name;
 			
 			$name = $color_flow->{_prog_name_sref}; 
 			return($name);
 			
 		} else {
 			print("color_flow, missing \n");
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
	# print("color_flowincrease_vigil_on_delete_counter\n");
	return();
}




#
#=head2
# $color_flow>{_sub_ref} is collected 
# and is use to ryn a subroutine in main
#
#=cut
# 
# sub set_sub_ref {
# 	my ($self,$sub_ref) = @_;
# 	
# 	if ($sub_ref) {
#
# 		$color_flow->{_FileDialog_sub_ref} =  $sub_ref;
# 		
# 		my $option		= 'Data';
# 		my $option_sref	= \$option;
# 		&{$sub_ref}($option_sref);  # run a subroutine in the overlying namespace
# 		
# 		print("user_built_flow, set_sub_ref, sub_ref: $color_flow->{_FileDialog_sub_ref}\n");
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
   	use decisions;
   	
   	my $decisions	= decisions->new();
   	my $help 		= new help();
   	my $pre_req_ok;
   	
   	$decisions		->set4help($color_flow);
	$pre_req_ok 	= $decisions->get4help();
	
	if ($pre_req_ok) {
		
	    # print("color_flow, help\n");
		$help->set_name($color_flow->{_prog_name_sref});
		$help->tkpod();
		
	} else {
		
		# print("1. color_flow, can not provide help\n");
	}

   	return();
}


=head2 sub save_button

	topic: only 'Save'
  	for safety, place set_hash_ref first
  	run from L_SU.pm
  	
   	my	$m          	= "color_flow, _save_button, Test,set_specs,message,$message_w\n";
 	$message_w->delete("1.0",'end');
 	$message_w->insert('end', $m);

=cut

 sub save_button {
 	my ($self, $topic) = @_;
 		# print("color_flow,save_button, topic: $topic\n");
 		
 	if ($topic eq 'Save') {  # double-check
 		use files_LSU;

		my $files_LSU			= new files_LSU();
		
		# switch between instances of the correct param_flow_color 
		# param_flow_color stores Data 
		_set_param_flow_color_i($flow_color);
		
		
		
		# switch between the correct index of the last parameter that was touched
		# as a function of the flow's  color 
		# These data are encapsulated 
		# _set_last_parameter_index_touched_color($flow_color);
		# _set_is_last_parameter_index_touched_color($flow_color);
			
		# assume a parameter index has been changed
		# provide values in the current widget
		$color_flow->{_values_aref} 						= $param_widgets->get_values_aref();
		$color_flow->{_last_parameter_index_touched_color} 	= 0 ;
		$color_flow->{_is_last_parameter_index_touched_color} = $true; 
		
		_check4parameter_changes();  # update changes to parameter values between 'SaveAs' and 'Save'
		
		# $conditions_gui				-> set_gui_widgets($color_flow);  # uses 29/  112 in
 		# $conditions_gui				-> set_hash_ref($color_flow);     # uses 70/  112 in
		# $conditions_gui				-> set4start_of_SaveAs_button();	 # sets 2

  			# print("1. color_flow, _save_button, B4 stored number of prgrams: $num_items\n");
  	 	$color_flow->{_names_aref} 	= $param_flow_color_i->get_names_aref();
  	 	
			# print("2. color_flow,save_button flow_name_out $color_flow->{_flow_name_out}\n");
			# my $num_items 			= $param_flow_color_i->get_num_items();
			# print("1. color_flow, _save_button, B4 stored number of prgrams: $num_items\n");
			 
		$param_flow_color_i	->set_good_values();
		$param_flow_color_i	->set_good_labels();
		
		$color_flow->{_good_labels_aref2}	= $param_flow_color_i->get_good_labels_aref2();
		$color_flow->{_items_versions_aref}	= $param_flow_color_i->get_flow_items_version_aref();
		$color_flow->{_good_values_aref2} 	= $param_flow_color_i->get_good_values_aref2();
		$color_flow->{_prog_names_aref} 	= $param_flow_color_i->get_flow_prog_names_aref();
				
 		$files_LSU	->set_prog_param_labels_aref2($color_flow);	# uses 1 / 112 in
 		$files_LSU	->set_prog_param_values_aref2($color_flow);	# uses 1 / 112 in
 		$files_LSU	->set_prog_names_aref($color_flow);			# uses 1 / 112 in
 		$files_LSU	->set_items_versions_aref($color_flow);		# uses 1 / 112 in
 		$files_LSU	->set_data();
 		$files_LSU	->set_message($color_flow);  				# uses 1 / 112 in
	  	
		$files_LSU	->set2pl($color_flow); 						# flows saved to PL_SEISMIC
		$files_LSU	->save();
		
#		$conditions_gui	->set4end_of_SaveAs_button();   			# uses 2/
#		$color_flow 	= $conditions_gui->get_hash_ref();   		# returns 89
 			
 	} else {			
 			print("color_flow, missing topic Save\n");		
 	}
 	 return();	
 } 


=head2 sub set_hash_ref

	copies with simplified names are also kept (40) so later
	the hash can be returned to a calling module
	
	imports external hash into private settings 
 	47 and 47 
 	
 	local extra  
 	
=cut

 	sub set_hash_ref {
 		my ($self,$hash_ref) 	= @_;
 
 		$color_flow->{_Data_menubutton}					= $hash_ref->{_Data_menubutton};		
      	$color_flow->{_Flow_menubutton}					= $hash_ref->{_Flow_menubutton};
      	$color_flow->{_FileDialog_sub_ref}				= $hash_ref->{_FileDialog_sub_ref};
 		$color_flow->{_FileDialog_option}				= $hash_ref->{_FileDialog_option};
     	$color_flow->{_SaveAs_menubutton}				= $hash_ref->{_SaveAs_menubutton};      						 	 		
 		$color_flow->{_add2flow_button_grey}			= $hash_ref->{_add2flow_button_grey};
 		$color_flow->{_add2flow_button_pink}			= $hash_ref->{_add2flow_button_pink};
 		$color_flow->{_add2flow_button_green}			= $hash_ref->{_add2flow_button_green};
 		$color_flow->{_add2flow_button_blue}			= $hash_ref->{_add2flow_button_blue};
 		$color_flow->{_check_code_button}				= $hash_ref->{_check_code_button};
 		$color_flow->{_check_buttons_w_aref}	 		= $hash_ref->{_check_buttons_w_aref};
 		$color_flow->{_delete_from_flow_button}			= $hash_ref->{_delete_from_flow_button};
  		$color_flow->{_dialog_type}						= $hash_ref->{_dialog_type}; 
 		$color_flow->{_dnd_token_grey}					= $hash_ref->{_dnd_token_grey};
 		$color_flow->{_dnd_token_pink}					= $hash_ref->{_dnd_token_pink}; 
 		$color_flow->{_dnd_token_green}					= $hash_ref->{_dnd_token_green}; 
 		$color_flow->{_dnd_token_blue}					= $hash_ref->{_dnd_token_blue}; 
 		$color_flow->{_dropsite_token_grey}				= $hash_ref->{_dropsite_token_grey};
  		$color_flow->{_dropsite_token_pink}				= $hash_ref->{_dropsite_token_pink}; 
   		$color_flow->{_dropsite_token_green}			= $hash_ref->{_dropsite_token_green};
    	$color_flow->{_dropsite_token_blue}				= $hash_ref->{_dropsite_token_blue}; 
 	 	$color_flow->{_file_menubutton}					= $hash_ref->{_file_menubutton};	 	
 		$color_flow->{_flow_color}						= $hash_ref->{_flow_color}; 
 		$color_flow->{_flow_item_down_arrow_button}		= $hash_ref->{_flow_item_down_arrow_button};
 		$color_flow->{_flow_item_up_arrow_button}		= $hash_ref->{_flow_item_up_arrow_button};		
 	 	$color_flow->{_flow_listbox_grey_w}				= $hash_ref->{_flow_listbox_grey_w};
 	 	$color_flow->{_flow_listbox_pink_w}				= $hash_ref->{_flow_listbox_pink_w};
  	 	$color_flow->{_flow_listbox_green_w}			= $hash_ref->{_flow_listbox_green_w};
 	 	$color_flow->{_flow_listbox_blue_w}				= $hash_ref->{_flow_listbox_blue_w};
  	 	$color_flow->{_flowNsuperflow_name_w}			= $hash_ref->{_flowNsuperflow_name_w};
  	 	$color_flow->{_flow_name_grey_w}				= $hash_ref->{_flow_name_grey_w};
 	 	$color_flow->{_flow_name_pink_w}				= $hash_ref->{_flow_name_pink_w};
 	 	$color_flow->{_flow_name_green_w}				= $hash_ref->{_flow_name_green_w};
  	 	$color_flow->{_flow_name_blue_w}				= $hash_ref->{_flow_name_blue_w};
  	 	$color_flow->{_flowNsuperflow_name_w}			= $hash_ref->{_flowNsuperflow_name_w};
  	 	$color_flow->{_is_pre_built_superflow}			= $hash_ref->{_is_pre_built_superflow};				
  	 	$color_flow->{_is_user_built_flow}	 			= $hash_ref->{_is_user_built_flow};	
   		$color_flow->{_labels_w_aref}		 			= $hash_ref->{_labels_w_aref};
		$color_flow->{_message_w}						= $hash_ref->{_message_w}; 
   		$color_flow->{_mw}								= $hash_ref->{_mw};
 	 	$color_flow->{_parameter_names_frame}  			= $hash_ref->{_parameter_names_frame}; 	
 	 	$color_flow->{_parameter_values_frame} 			= $hash_ref->{_parameter_values_frame};
 		$color_flow->{_parameter_values_button_frame}	= $hash_ref->{_parameter_values_button_frame};
 		$color_flow->{_prog_name_sref}		 			= $hash_ref->{_prog_name_sref};
 		$color_flow->{_run_button}						= $hash_ref->{_run_button};
 		$color_flow->{_save_button}						= $hash_ref->{_save_button};
 		$color_flow->{_sunix_listbox}					= $hash_ref->{_sunix_listbox};
 		$color_flow->{_values_w_aref} 					= $hash_ref->{_values_w_aref};
 		
 		# $color_flow->{_flow_name_color_w				= $hash_ref->{_flow_name_color_w}; do not import
 		
 		#private and for potential export
 		$Data_menubutton						= $hash_ref->{_Data_menubutton};		
      	$Flow_menubutton						= $hash_ref->{_Flow_menubutton};
      	$FileDialog_sub_ref						= $hash_ref->{_FileDialog_sub_ref};
 		$FileDialog_option						= $hash_ref->{_FileDialog_option};
     	$SaveAs_menubutton						= $hash_ref->{_SaveAs_menubutton};      						 	 		
 		$add2flow_button_grey					= $hash_ref->{_add2flow_button_grey};
 		$add2flow_button_pink					= $hash_ref->{_add2flow_button_pink};
 		$add2flow_button_green					= $hash_ref->{_add2flow_button_green};
 		$add2flow_button_blue					= $hash_ref->{_add2flow_button_blue};
 		$check_code_button						= $hash_ref->{_check_code_button};
 		$check_buttons_w_aref	 				= $hash_ref->{_check_buttons_w_aref};
 		$delete_from_flow_button				= $hash_ref->{_delete_from_flow_button};
  		$dialog_type							= $hash_ref->{_dialog_type}; 
 		$dnd_token_grey							= $hash_ref->{_dnd_token_grey};
 		$dnd_token_pink							= $hash_ref->{_dnd_token_pink}; 
 		$dnd_token_green						= $hash_ref->{_dnd_token_green}; 
 		$dnd_token_blue							= $hash_ref->{_dnd_token_blue}; 
 		$dropsite_token_grey					= $hash_ref->{_dropsite_token_grey};
  		$dropsite_token_pink					= $hash_ref->{_dropsite_token_pink}; 
   		$dropsite_token_green					= $hash_ref->{_dropsite_token_green};
    	$dropsite_token_blue					= $hash_ref->{_dropsite_token_blue}; 
 	 	$file_menubutton						= $hash_ref->{_file_menubutton};	 	
 		$flow_color								= $hash_ref->{_flow_color}; 
 		$flow_item_down_arrow_button			= $hash_ref->{_flow_item_down_arrow_button};
 		$flow_item_up_arrow_button				= $hash_ref->{_flow_item_up_arrow_button};		
 	 	$flow_listbox_grey_w					= $hash_ref->{_flow_listbox_grey_w};
 	 	$flow_listbox_pink_w					= $hash_ref->{_flow_listbox_pink_w};
  	 	$flow_listbox_green_w					= $hash_ref->{_flow_listbox_green_w};
 	 	$flow_listbox_blue_w					= $hash_ref->{_flow_listbox_blue_w};
  	 	$flowNsuperflow_name_w					= $hash_ref->{_flowNsuperflow_name_w};
  	 	$flow_name_grey_w						= $hash_ref->{_flow_name_grey_w};
 	 	$flow_name_pink_w						= $hash_ref->{_flow_name_pink_w};
 	 	$flow_name_green_w						= $hash_ref->{_flow_name_green_w};
  	 	$flow_name_blue_w						= $hash_ref->{_flow_name_blue_w};
  	 	$flowNsuperflow_name_w					= $hash_ref->{_flowNsuperflow_name_w};
  	 	$is_pre_built_superflow					= $hash_ref->{_is_pre_built_superflow};				
  	 	$is_user_built_flow	 					= $hash_ref->{_is_user_built_flow};		
   		$labels_w_aref		 					= $hash_ref->{_labels_w_aref};
		$message_w								= $hash_ref->{_message_w}; 
   		$mw										= $hash_ref->{_mw};
 	 	$parameter_names_frame  				= $hash_ref->{_parameter_names_frame}; 	
 	 	$parameter_values_frame 				= $hash_ref->{_parameter_values_frame};
 		$parameter_values_button_frame			= $hash_ref->{_parameter_values_button_frame};
 		$prog_name_sref		 					= $hash_ref->{_prog_name_sref};
 		$save_button							= $hash_ref->{_save_button};
 		$sunix_listbox							= $hash_ref->{_sunix_listbox};
 		$values_w_aref 							= $hash_ref->{_values_w_aref};
 		
 	   	# $flow_name_color_w					= $hash_ref->{_flow_name_color_w}; do not import
 		
 		 # print("color_flowset_hash_ref,delete_from_flow_button: $color_flow->{_delete_from_flow_button\n");
 		 # print("color_flowset_hash_ref,parameter_values_frame: $color_flow->{_parameter_values_frame}\n");
 		 # print("1. color_flowset_hash_ref,_message_w: $color_flow->{_message_w}\n");
 		 # print("color_flowset_hash_ref,parameter_values_frame: $parameter_values_frame\n"); 	
 		 # print("color_flowset_hash_ref,add2flow_button_grey,$add2flow_button_grey	\n");
 		 # print("color_flow,set_hash_ref,color_flow->{_flow_color}: $color_flow->{_flow_color}	\n");
 		 # print("color_flowset_hash_ref,delete_from_flow_button: $delete_from_flow_button\n");
 		 # print("color_flow,set_hash_ref,flow_color: $flow_color\n");
 		 # print("color_flow,set_hash_ref,_flowNsuperflow_name_w:$$flowNsuperflow_name_w}\n");

 		return();
 	}
 	
1;