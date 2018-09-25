=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PERL PROGRAM NAME: SeismicUnixPlTk.pl 
 AUTHOR: Juan Lorenzo
 DATE: June 22 2017 

 DESCRIPTION 
     

 BASED ON:
 Version 0.1 April 18 2017  
     Added a simple configuration file readable 
flow
    and writable using Config::Simple (CPAN)

 Version 0.2 
    incorporate more object oriented classes
   
 TODO: Simple (ASCII) local configuration 
      file is Project_Variables.config

=cut
=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES

=cut 

=head2 Notes from bash
 
=cut 

 	our $VERSION = '1.20';
 	use Moose;
 	use Tk;
 	use Tk::DragDrop;
 	use Tk::DropSite;
 	use Tk::Pane;
	use SeismicUnixPlTk_global_constants;
	use config_superflows;
	use decisions 1.00;
	use iFile;
	use flow_widgets;
	use param_widgets;
	use param_flow;
	use param_sunix;
	use whereami;

 	my $config_superflows   = config_superflows->new();
 	my $decisions			= decisions->new();
 	my $flow_widgets		= new flow_widgets;
 	my $iFile				= new iFile;
 	my $get					= new SeismicUnixPlTk_global_constants();
 	my $param_flow         	= new param_flow;
 	my $param_widgets		= param_widgets->new();
 	my $param_sunix        	= param_sunix->new();
 	my $whereami           	= whereami->new();
 	my $var					= $get->var();
 	my $global_libs			= $get->global_libs();

=head2

 share the following parameters in same name 
 space

 flow_listbox_l  -left listbox, input by user selection
 flow_listbox_r  -right listbox,input by user selection
 sunix_listbox   -choice of listed sunix modules in a listbox

=cut
 	my ($mw);
 	my ($i,$j,$k);
 	my ($top_menu_frame,$top_titles_frame,$work_frame);
 	my ($side_menu_frame);
 	my ($sunix_frame,$parameters_pane,$flow_control_frame);
 	my ($parameter_values_button_frame );
 	my ($parameter_names_frame,$parameter_values_frame);
 	my ($sunix_listbox,$flow_listbox_l,$flow_listbox_r);
 	my ($ref_chk_button_variable);
 	my (@labels_w, @entries_w);
 	my ($sunix); 
	my (@param,@values,@args);
	my (@on_off_param);

	my $on         		= $var->{_on};
	my $off        		= $var->{_off};
	my $true       		= $var->{_true};
	my $false      		= $var->{_false};
	my $default_path  	= $var->{_default_path};
	my $failure     	= $var->{_failure};
	my $tool_widget_ident 	= $var->{_superflow};
	my $sunix_widget_ident = $var->{_flow};

 	@values  			= qw//;
 	my @choices 		= @{$var->{_sunix_choices}};


=head2 Default Tk settings{

 Create scoped hash 

=cut

 my $TkPl_SU   = {
	_check_buttons_settings_aref    => '',
    _current_widget					=> '', 
	_current_index  				=> '',
	_current_sunix_selection_index 	=> '',
	_entry_button_label	  			=> '',	
	_error 							=> '',
	_flow_name 						=> '',
	_name_aref    					=> '',
	_names_aref    					=> '',
	_first_index    				=> '',
    _index2move	    				=> '',
    _destination_index	 			=> '',
  	_items_versions_aref 			=> '',
  	_items_values_aref2  			=> '',
  	_items_names_aref2  			=> '',
  	_items_checkbuttons_aref2 		=> '',
	_is_add2flow_button	   			=> '',
	_is_delete_from_flow_button	   	=> '',
	_is_flow_listbox_l				=> '',
	_is_flow_listbox_r				=> '',
    _is_moveNdrop_in_flow			=> '',
    _is_run_button          		=> '',
    _is_save_button          		=> '',
	_is_sunix_listbox				=> '',
	_is_superflow 					=> '',
# 	_is_sunix_module   				=> '',
	_is_sunix_listbox				=> '',
	_first    						=> '',
	_last    						=> '',
	_last_flow_index_touched	 	=> '',
	_last_flow_listbox_touched 		=> '',
	_last_flow_listbox_touched_w 	=> '',
	_last_path_touched				=> './',
	_superflows_first_idx   		=> '',
	_superflows_length    			=> '',
    _last_param    					=> '',
    _first_param    				=> '',
	_length    						=> '',
	_listbox_size 					=> '',
	_module_name   					=> '',
	_name     						=> '',
	_path     						=> '',
	_param_flow_first       		=> 0,
	_param_flow_length        		=> '',
	_param_sunix_first_idx      	=> 0,
	_param_sunix_length       		=> '',
	_parameter_value_index  		=> -1,
	_prev_flow_name 				=> '',
	_prev_index  					=> '',
	_prev_prog_name   				=> '',
	_prev_ref_values_w  			=> '',
	_prev_flow_name 				=> '',
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


=head2 Main Window contains

 a top menu frame 
 a middle menu titles frame
 and a
 bottom  work_frame
 font is made to be garamond normal 14
 border width is defaulted too

=cut

 	$mw = MainWindow->new;
 	$mw	->title($var->{_program_title});
 	$mw	->geometry($var->{_box_position});
 	$mw	->resizable( 0, 0 ); #not resizable in either width or height 

=head2 Define 
  
  fonts to use in the menu

=cut

 	my $garamond  = $mw->fontCreate(
                  'garamond', 
                  -family => 'garamond',
                  -weight => 'normal',
                  -size   => -14);

 	my $small_garamond  = $mw->fontCreate(
                  'small_garamond', 
                  -family => 'garamond',
                  -weight => 'normal',
                  -size   => -9);

 	$top_menu_frame = $mw->Frame(
                   -borderwidth => $var->{_no_borderwidth}, 
                   -background  => $var->{_my_purple},
                   -relief      => 'groove'
                   );

 	$top_menu_frame  ->Label(
					-text 	=> '',
					-font 	=> $garamond,
					-width	=> $var->{_one_pixel},
					-background  => $var->{_my_purple},
                )
		  		->pack(
                    -side => "left"
                   );

 	$side_menu_frame = $mw->Frame(
                   -borderwidth => $var->{_no_borderwidth}, 
                   -background  => $var->{_my_purple},
                   -relief      => 'groove'
                   );

=head2  top menu frame

 contains top menus
 1te. for superflows 

=cut



my $superflow_select 	= $top_menu_frame->Menubutton(
    		        -text   	=> 'Tools',
		           	-font 		=> $garamond,
	                -height     => 1,
                    -background => $var->{_my_yellow},
    		        -relief 	=> 'flat'
		          )
		          ->pack(
                  	-side	  	=> "left",
			    	-fill       => 'x'
                            );
my $top_menu_bar	= $superflow_select->Menu(
		           -font 	=> $garamond);

 $top_menu_bar	-> bind('<ButtonRelease-3>' 
			=> [\&help], );    


 $superflow_select	 ->configure(
			   -menu 	=> $top_menu_bar
                           );
 		$args[0] = 'ProjectVariables';
 $superflow_select	->command(
    			  -label       	=> $args[0],
    			  -underline   	=> 0,
    			  -font 		=> $garamond,
                  -command      => [\&superflow_select, \$args[0]],
 			);   
                       
 		$args[1] = 'iVelAnalysis';
 $superflow_select	->command(
    			  -label       	=> $args[1],
    			  -underline   	=> 0,
                  -command      => [\&superflow_select,\$args[1] ],
    			  -font 		=>$garamond
                         );

 		$args[2] = 'fk';
 $superflow_select	->command(
    			  -label       	=> $args[2],
    			  -underline   	=> 0,
    			  -font 		=>$garamond,
		          -command      =>[\&superflow_select,\$args[2] ],
 			 );

 		$args[3] = 'iSpectralAnalysis';
 $superflow_select	->command(
    			  -label       	=> $args[3],
    			  -underline   	=> 0,
    			  -font 		=>$garamond,
		          -command      =>[\&superflow_select,\$args[3] ],
 			 );

 		$args[4] = 'iTopMute';
 $superflow_select	->command(
    			  -label       	=> $args[4],
    			  -underline   	=> 0,
    			  -font 	=>$garamond,
		          -command      =>[\&superflow_select,\$args[4] ],
 			 );

 		$args[5] = 'iBottomMute';
 $superflow_select	->command(
    			  -label       	=> $args[5],
    			  -underline   	=> 0,
    			  -font 		=>$garamond,
		          -command      =>[\&superflow_select,\$args[5] ],
 			 );


=pod tied button widgets

  to a tool_array
  for easier management
  bind MB3 to help
my @who;
my $this=0;

    $who[$this] = $top_menu_bar->focusCurrent;
 print(" who is @who\n");
 my $a =$top_menu_bar->bind();
 print(" bind is @$a\n");
 my $class = ref $top_menu_bar;
 print "Button \\$top_menu_bar is an instance of class '$class'.\n" .
      "This class has bindings for these events:\n\n";
 print join("\n", $top_menu_bar->bind($class) ), "\n";


=cut

=head2  side menu frame

 contains side menus
 1. for files$

=cut

	my $file_menubutton = $side_menu_frame->Menubutton(
    		           -text   		=> 'File',
		           		-font 		=> $garamond,
	                   -height      => 1,
    		           -relief 		=> 'flat'
		          		)
		          		->pack(
                            -side  		=> "top",
			    			-fill       => 'x'
                         );

	my $side_menu_bar	= $file_menubutton->Menu(
		           		-font 	=> $garamond);

 	$file_menubutton	->configure(
			   				-menu 	=> $side_menu_bar
                           );
 	$file_menubutton	->separator;
 	$file_menubutton	->command(
    			  		-label       	=> 'Open',
    			  		-underline   	=> 0,
			  			-command      	=>\&FileDialog_button,
    			  		-font 			=>$garamond
 						);

 	$top_titles_frame 	= $mw->Frame(
                   	   -borderwidth => $var->{_one_pixel_borderwidth}, 
                   	   -background  => $var->{_light_gray},
                   	   -relief      => 'groove'
                   	);
 	#$file_menubutton	->configure(
	#		   			-state 	=> 'disabled', 
     #                   );


=head2  side menu frame

 contains side menus
 2. for action 

=cut


 	my $run_button 	= $side_menu_frame->Button(
    		           		-text   	=> 'Run',
		           			-font 		=> $garamond,
	                   		-height      => 1,
                           	-background  => $var->{_my_yellow},
    		           		-relief 	=> 'flat',
    		           		-state 		=> 'disabled',
			   				-command     => [\&run_button]
		          			)
		          		->pack(
                            -side  	=> "top",
			    			-fill       => 'x'
                            );
 
 my $save_button 	= $side_menu_frame->Button(
    		           		-text   	=> 'Save',
		           			-font 	=> $garamond,
	                   		-height      => 1,
                           	-background  => $var->{_my_yellow},
    		           		-relief 	=> 'flat',
    		           		-state 	=> 'disabled',
			   				-command     => [\&save_button]
		          			)
		          			->pack(
                            -side  	=> "top",
			    			-fill       => 'x'
                            );

=head2 top_titles frame

 just above the work frame
 contains Titles only 

=cut

	my $add2flow_button = $top_titles_frame->Button(
    		           	-text  		=> 'Flow -+->',
						-font 		=> $garamond,
	                   	-height   	=> 1,
						-background	=> $var->{_white},
    		           	-relief 	=> 'flat',
    		           	-state 		=> 'disabled',
						-command	=> [\&add2flow_button]
		          )
		          ->pack(
						-side  		=> "left",
                            );

 	$top_titles_frame  ->Label(
						-text 	    	=> 'Parameter Names',
		   				-font 	   		=> $garamond,
  	           			-height     	=> $var->{_one_character},
		   				-border     	=> $var->{_no_pixel},
                   		-width      	=> 30,
                   		-padx       	=> 0,
                   		-background 	=> $var->{_light_gray},
                   		-relief     	=> 'groove'
                  	 )
		  			->pack(
						-side 		=> "left",
	            		-fill    	=> 'x'
                   	);

 	$top_titles_frame  ->Label(
                   		-text 		=> 'Values  ',
						-font 		=> $garamond,
						-height      	=> $var->{_one_character},
						-border      	=> $var->{_no_pixel},
                   		-padx        	=> 0,
                   		-width       	=> 27,
                   		-background  	=> $var->{_light_gray},
                   		-relief      	=> 'groove'
                 	 )
		  	  		->pack(
						-side 		=> "left",
	            		-fill        	=> 'x'
                   	);

=pod

 button that removes a seismic unix program from the flow

=cut

 	my $delete_from_flow_button = $top_titles_frame->Button(
                   		-text			=> 'Delete',
						-font 			=> $garamond,
						-height      	=> $var->{_one_character},
						-border      	=> 0,
                   		-padx        	=> 0,
                   		-width       	=> 6,
                   		-background  	=> $var->{_white},
                   		-relief      	=> 'flat',
                   		-state       	=> 'disabled',
                 		 )
		  				->pack(
                    		-side 		=> "left",
                   		);

=head2 tied listbox widgets

 to a tool_array
 for easier management

=cut

 	$delete_from_flow_button	-> bind('<1>' 
			=> [\&delete_from_flow_button]     
                       );

 	$work_frame	= $mw->Frame(
                   -borderwidth => $var->{_one_pixel_borderwidth}, 
                   -background  => 'blue',
                   -relief 	=> 'groove'
                  );


=head2 work frame

 contains frame with menu items on the far left
 a sunix_frame second from the left, 
 a parameters_pane to its right
 and two listboxes contained in a module-sequences frame on the far right

=cut

 	$sunix_frame  		= $work_frame->Frame(
                    	   	-borderwidth 	=> $var->{_one_pixel_borderwidth}, 
                    	   	-relief	 		=> 'groove',
                    	   	-width       	=> $var->{_small_width},
							-background  	=> 'green'
                   	   	);

 	$sunix_listbox 	= $sunix_frame->Scrolled(
		       	   "Listbox", 
                       	   -scrollbars 		=> "osoe", 
                       	   -height 			=> 20, 
                    	   -width       	=> $var->{_ten_characters},
                       	   -selectmode  	=> "single",
                           -borderwidth   	=> $var->{_one_pixel_borderwidth}
                       );

 	$sunix_listbox    ->insert(
                       "end", 
                        sort @choices
	             		);

=head2 tied listbox widgets

  to a tool_array
  for easier management

=cut

 	$sunix_listbox	-> bind('<1>' 
			=> [\&sunix_select]     
                       	);
 	$sunix_listbox	-> bind('<3>' 
			=> [\&help]     
                       	);

=head2 parameters frame

 Parameters from
 Tools and Su Modules

 Contains name_values_frame at the top, 
 and a message_frame at the bottom 

=cut

	$parameters_pane    = $work_frame->Scrolled(
		       	   "Frame", 
			-background  	=> $var->{_my_purple},
			-relief      	=> 'groove',
			-scrollbars 	=> "e", 
                       );

=head2  input frame

 Contains, left-to-right:

 a parameter_names_frame 
 a stack of radio buttons 
 and a values_frame  

 Choose whether to ignore/deactivate or apply
 the parameter-value pairs later on

 To solicit and modify
 possibly existing
 parameter value input

=cut

 	$parameter_names_frame = $parameters_pane->Frame(
		-borderwidth 	=> $var->{_one_pixel_borderwidth}, 
		-background  	=> $var->{_my_purple},
		-width          => $var->{_standard_width},
		-relief      	=> 'groove',
	       );

 	$parameter_values_button_frame    = $parameters_pane->Frame(
		-borderwidth 	=> $var->{_one_pixel_borderwidth}, 
		-background  	=> $var->{_my_purple},
		-width          => 20,
		-relief      	=> 'groove',
	       );

 	$parameter_values_frame   	= $parameters_pane->Frame(
		-borderwidth 	=> $var->{_one_pixel_borderwidth}, 
		-background  	=> $var->{_my_purple},
		-width          => $var->{_standard_width},
		-relief      	=> 'groove',
	       );

=head2 Initialize 

  Initially, checkbutton widgets and values 
  are green ("on") or red ("off"), and
  Labels and Entry Widgets are blank.

=cut

	$param_widgets	-> set_labels_frame(\$parameter_names_frame);
 	$param_widgets	-> set_values_frame(\$parameter_values_frame);
  	$param_widgets	-> set_check_buttons_frame(\$parameter_values_button_frame);
  	$param_widgets	-> initialize_labels();
  	$param_widgets	-> initialize_values();
  	$param_widgets	-> initialize_check_buttons();
  	$param_widgets	-> show_labels();
  	$param_widgets	-> show_values();
  	$param_widgets	-> show_check_buttons();

=head2 message area 

      to notify user of important evets 

=cut


 	my $message	= $work_frame->Text(
                   -height 	=> 3,
		   			-font   => $garamond
                    );
 	$TkPl_SU->{_message} 	= $message;
 	$TkPl_SU->{_message}    ->insert('end', "This is some normal text\n");


=head2 workflow_control_frame

 on far right of work frame
 contains scrolled flow listbox

=cut
 
	$flow_control_frame     = $work_frame->Frame(
                    	   	-borderwidth 	=> $var->{_no_borderwidth}, 
                    	   	-relief 	 	=> 'groove',
                    	   	-width       	=> $var->{_medium_width},
		    	   			-background  	=> 'pink',
		           			);

=head2 workflow_control_frame

 on far right of work frame

=cut

 	$flow_listbox_l	= $flow_control_frame->Scrolled(
		       	   			"Listbox", 
						-scrollbars		=> "osoe", 
						-height 		=> 20, 
						-width       	=> $var->{_ten_characters},
						-selectmode  	=> "single",
						-borderwidth   	=> $var->{_one_pixel_borderwidth},
						-state			=> 'disabled',
                      	   );

 	$flow_listbox_r 	= $flow_control_frame->Scrolled(
		       	   			"Listbox", 
						-scrollbars 	=> "osoe", 
						-height			=> 20, 
						-width       	=> $var->{_ten_characters},
						-selectmode  	=> "single",
						-borderwidth   	=> $var->{_one_pixel_borderwidth},
						-state			=> 'disabled',
                      	   );

=head2 tied listbox widgets

  to a tool_array
  for easier management

=cut

 	$flow_listbox_l	-> bind('<1>' 
				=> [\&flow_select]     
                       );
 	$flow_listbox_l	-> bind('<3>' 
				=> [\&flow_help]     
                       );

=head2 Packing Frame widgets


=cut     

 	$top_menu_frame    	->pack(
	                  	-side 	=> "top",
                        -fill 	=> 'x',
                          ); 


 	$side_menu_frame    	->pack(
	                  -side 	=> "left",
                           -fill 	=> "both"
                          ); 

 	$top_titles_frame    	->pack(
	                   -side 	=> "top",
                           -fill 	=> 'x'
                          ); 

 	$work_frame		->pack(
                           -side 	=> "left",
                           -expand  	=> 1,
                           -fill 	=> "both",
		          );
 $message               ->pack(
                           -side    => "bottom",
                           -fill    => 'both',
                           );


 	$sunix_frame		->pack(
                           -side 	=> "left",
                           -fill 	=> "both",
		          );
 	$sunix_listbox		->pack(
                           -side 	=> "left",
                           -fill 	=> "both",
                          );

 	$flow_control_frame	->pack(
                           -side 	=> "right",
                           -fill 	=> "both",
		          );
 	$flow_listbox_l	->pack(
                           -side 	=> "left",
                           -fill 	=> "both",
		          );

 	$flow_listbox_r	->pack(
                           -side => "left",
                           -fill => "both",
                          );

 	$parameters_pane	->pack(
                           -side    	=> "right",
                           -fill 	=> "both",
		          );
                           #-expand  => 1,
 	$parameter_names_frame	->pack(
                           -side    	=> "left",
                           -fill 	=> "x",
		          );
                           #-expand  => 1,
 	$parameter_values_button_frame	->pack(
                           -side    	=> "left",
                           -fill    	=> "x",
   		          );
                           #-expand  => 1,
 	$parameter_values_frame ->pack(
							-side    	=> "left",
							-fill    	=> "both",
		          );
                           #-expand  => 1,

	
		#end of drag - in this order
 	my $dropsite_token = $flow_listbox_l->DropSite(
    				-droptypes   	=> [qw/Local/],
					-dropcommand 	=> \&drop, 
				    -entercommand   => \&increase_vigil_on_delete_counter,
 					);
                    #-postdropcommand => [\&decrease_vigil_on_delete_counter],

	
		#start of drag - dropsite token must exist first
 	my $dnd_token = $flow_listbox_l->DragDrop(
    				-event        => '<B1-Motion>',
    				-sitetypes    => [qw/Local/],
    				-startcommand => \&drag,
    				-cursor       => 'arrow',
					);

 MainLoop;

=head2 sub FileDialog_button

	Interactively choose a file name
    that will then be entered into the
    values of the parameter frame and 
	stored away via param_flow

	independently set conditions for the use of a FileDialog_button
    find out which prior widget invoked the FileDialog_button ?
    was it an entry button?

	#				# confirm listboxes are active
#  	if ($pre_req_ok) {

    #my $entry_changed = $param_widgets->get_entry_change_status();
     					 	# print(" main, FileDialog_button, entry_change_status= $entry_changed\n"); 
    # if($entry_changed) {  
							# get program index most recently selected from left flow
#	$index = $TkPl_SU->{_last_flow_index_touched};
    					 	# print("main,FileDialog_button,in left flow, program index= $index\n");

    						# get entry values of selected program from storage
# 	$param_flow			->set_flow_index($index);
# 	$TkPl_SU->{_values_aref} 	=	$param_flow->get_values_aref();
  						 # print("2. main, FileDialog_button,parameter values is @{$TkPl_SU->{_values_aref}}\n");

=cut

sub FileDialog_button {

	my($self) 				= @_;
	my @selection;
	my $index;

   	private_conditions    	-> set4FileDialog_button();

    						# get index of entry button pressed 
							# find out which entry button has been chosen
							# while confirming that it IS the file button
							# print("main,FileDialog_button pressed\n");
						    # only if an appropriate entry widget is first selected	
   	my $selected_Entry_widget 	= $parameter_values_frame->focusCurrent;

	if ($selected_Entry_widget) {
		$param_widgets			->set_entry_button_chosen_widget($selected_Entry_widget);
		$TkPl_SU->{_parameter_value_index} 	= $param_widgets->get_entry_button_chosen_index();
							   # print("main,FileDialog_button,selection_Entry_widget HASH = $selected_Entry_widget\n");
							   # print("main,FileDialog_button, parameter_value_index= $TkPl_SU->{_parameter_value_index}\n");

		if ($TkPl_SU->{_parameter_value_index} >= 0) {

			$TkPl_SU->{_entry_button_label} 	= $param_widgets->get_label4entry_button_chosen();
							   # print("main,FileDialog_button,entry_button_label = $TkPl_SU->{_entry_button_label}\n");

			$iFile 				-> set_entry($TkPl_SU);
			$iFile 				-> set_prog_name($TkPl_SU);
			$TkPl_SU->{_path} 	= $iFile->get_path();

  			FileDialog();
  			FileDialog_close();
		} 

	} else {
		print("Warning: Must select a parameter value first\n");
	}
    return();
}


=head2 sub FileDialog

     print ("my file is $TkPl_SU->{_selected_file_name}\n");
     will NOT:
        print ("1. label is @{$TkPl_SU->{_ref_labels_w}}[$first]->cget('-text') \n");

    WILL print:
     print ("2. label is  $out\n");

     $who[$first] = $parameter_values_frame->focusCurrent;
     print("who is $who[$first]\n");
     if ($who[$first] eq @{$TkPl_SU->{_ref_values_w}}[$first]) { 
       print("who is also @{$TkPl_SU->{_ref_values_w}}[$first]\n");
       print ("2. label is  $out\n");
     }

   Assume that file name in labels is always first
   print ("1. Full path is  $TkPl_SU->{_selected_file_name}\n");

=cut

sub FileDialog {

	my $self = @_;

   	use Tk::JFileDialog;

   	my $mytitle 		= "Select";
   	my ($create) 		= 0;
   	my $fileDialog;

	$fileDialog = $mw->JFileDialog(
		-Title			=> $var->{_mytitle},
		-Path 			=> $TkPl_SU->{_path},
		-History		=> 12,
		-HistDeleteOk 	=> 1,
		-HistUsePath	=> 1,
		-HistFile 		=> "./.FileHistory.txt",
		-PathFile 		=> "./.Bookmarks.txt",
		-Create 		=> 1
               );
				# results from interactive file selection
				# 
  	$TkPl_SU->{_selected_file_name} = $fileDialog->Show();
	$TkPl_SU->{_last_path_touched} 	= $fileDialog->cget('-Path');
					 #print("main,FileDialog,last path is $TkPl_SU->{_last_path_touched} \n");
					 #print("main,FileDialog,selected_file_name is $TkPl_SU->{_selected_file_name} \n");
   	return();
}


=head2 sub FileDialog_close

  reorganizing the display after a file is selected

  print("1. OK index:$TkPl_SU->{_parameter_value_index}\n");
  print("2. value:@$ref_values[$TkPl_SU->{_parameter_value_index}]\n");
  print("2. chek value:@{$TkPl_SU->{_ref_param_value_button_w_variable}}[$current_index]\n");

  'menubutton' is for our macro sunix tools
  'frame' is for the regular sunix programs

  TODO: CASE of opening a pre-existing superflow configuration file
        or previously scripted flow  by this GUI
        BEFORE or While the menubutton OR Frame are selected

    # if(entry_button_chosen('file_name') != $failure) {
    # if($TkPl_SU->{_current_widget} eq 'menubutton' ||  $TkPl_SU->{_current_widget} eq 'frame' ) { 
		print("main,FileDialog_close, is superflow? $TkPl_SU->{_is_superflow_select_button}\n");
		print("main,FileDialog_close, is flow? left lstbox:$TkPl_SU->{_is_flow_listbox_l},right:$TkPl_SU->{_is_flow_listbox_r} \n");
  
=cut


sub FileDialog_close {
	my $self = @_;

						# only flows and superflow selections are currently allowed
	$decisions			->set4FileDialog_close($TkPl_SU);
	my $pre_req_ok 		= $decisions->get4FileDialog_close();
			 		   	# print("1. main,FileDialog_close,pre_req_ok= $pre_req_ok \n");
			 		   
  	my $full_path_name 	= $TkPl_SU->{_selected_file_name};
				 			 # print("main, delete_from_flow_button, $here->{_is_flow_listbox_l}\n");
   	if ( $pre_req_ok ) { 	
			 		   	# print("2. main,FileDialog_close,pre_req_ok= $pre_req_ok \n");

						# both flows and superflows require the following    
  		my $current_index             		= $TkPl_SU->{_parameter_value_index};
			   		  	# print("main,FileDialog_close, current parameter index $current_index\n");
      	@{$TkPl_SU->{_check_buttons_settings_aref}}[$current_index] 
											= $on; 

						#  superflows require the following   
		if ( $TkPl_SU->{_is_superflow_select_button} ) {

						# only ProjectVariables (a superflow) require the following
    		if( $TkPl_SU->{_prog_name} eq 'ProjectVariables' ) {
	    		$TkPl_SU->{_selected_file_name} = 	$TkPl_SU->{_last_path_touched}; 
			}
			   		   # print("main,FileDialog_close,fields=@fields, selected_file_name=$TkPl_SU->{_selected_file_name}\n");
			   		   #
      		#if(@{$TkPl_SU->{_values_aref}}[$current_index]) { # overkill? 
				@{$TkPl_SU->{_values_aref}}[$current_index]
						= $TkPl_SU->{_selected_file_name};  
			#}

						# only superflows require the following entry updates  
			$param_widgets->set_values($TkPl_SU->{_values_aref});
		 	$param_widgets->redisplay_values();
		}

						# only flows require the following    
		if ( $TkPl_SU->{_is_flow_listbox_l} || $TkPl_SU->{_is_flow_listbox_r}) {

			if( $full_path_name) {
  				my @fields 							= split (/\//,$full_path_name);
  				$TkPl_SU->{_selected_file_name} 	= $fields[-1];
			}

      		#if(@{$TkPl_SU->{_values_aref}}[$current_index]) { # overkill? 
				@{$TkPl_SU->{_values_aref}}[$current_index]
						= $TkPl_SU->{_selected_file_name};  
			 		print("main,FileDialog_close,selected_file_name  $TkPl_SU->{_selected_file_name} \n");
			#}
					# flows will be updated via flow_select, which is activated 
					# in iFile->close()
					# reset focus on item last touched in flow 
					# find which listbox and which listbox_item 
					# change the Entry Value in param widgets
					# update Entry Value
   		 			# update entry in superflow OR
   		 			# go on to flow_select and update those parameters
			iFile->close($TkPl_SU);
		}
   	private_conditions->set4FileDialog_close();
	}
}



  # print(" dnd_token is $dnd_token\n");

=head2 sub drag

  rag and Drop does not delete 
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
	
=cut

sub drag {
  	my ($self) = @_;   
					# print("1. main,drag\n");

			# was a program deleted through a previous dragNdrop?
 	if( $flow_widgets->is_drag_deleted($flow_listbox_l) ) {

		print("2.main,drag\n");
        my $this_index = $flow_widgets->get_drag_deleted_index($flow_listbox_l);

							 print("main,drag,deleting flow_listbox,idx=$this_index\n");
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
	
	my $num_items = $flow_widgets->get_num_items($flow_listbox_l);
  						# print("main,drag,num items prior to deletion  = $num_items\n");

  	if ( $num_items > 1 ) {  # num_items PRIOR to deletion
   	   $flow_widgets->drag_start($dnd_token);
	    				# print("main,drag,start dnd_token:$dnd_token\n");
  	} else {
						# print("WARNING: main,drag,not allowed\n");
  	}						 
}


=head2 sub drop

   drop does not occur if the user drags the item out of
   the listbox area
   item is successfully moved from one part of the flow
   listbox to another
	
	$whereami					->set4moveNdrop_in_flow();
	my $here 					= $whereami->get4moveNdrop_in_flow();
	$param_widgets				->set_location_in_gui($here);

    print("drop,confirm done\n");
							# make param_widgets not detect any entry changes
							# This IS needed for sub flow_select not to sense previous changes
							# or else the stored parameters in the flow will not be correct
   							# $param_widgets->set_entry_change_status($false);

=cut

sub drop {
   my $self 		= @_;   
   my $done;
   my $chosen_index_to_drop 		= $flow_widgets->drag_end($dnd_token); 
   if ($chosen_index_to_drop >=0) {   # same as destination_index
	        			# if insertion occurs within the listbox widget
	 $TkPl_SU->{_index2move} 			= $flow_widgets->index2move();
     $TkPl_SU->{_destination_index} 	= $flow_widgets->destination_index;

							# note the last program that was touched
    						 $TkPl_SU->{_last_flow_index_touched} 	= $TkPl_SU->{_destination_index} ;
							 print(" main,drop, destination index = $TkPl_SU->{_last_flow_index_touched}\n");

			    # move stored data agreement with this drop 
	 move_in_stored_flows(); 
				# update program versions if listbox changes
				# stored in param_flows
     stack_versions();
							 # if there is no delete while dragging
							 # the counter is also increased, so reset
							 # this is a bug in the DragandDrop package
  							 # reset drag and drop vigil_on_delete counter 
	$flow_widgets->set_vigil_on_delete();
	 		 				# print(" drop, done is $done\n");
	$flow_widgets->dec_vigil_on_delete_counter(2);
							# highlight new index
    $flow_listbox_l    			->selectionSet(
                       			  $TkPl_SU->{_destination_index}, 
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
	# print("main,increase_vigil_on_delete_counter\n");
	return();
}

#=head2 sub decrease_vigil_on_delete_counter
#
#	Keeps check of whether an item
#    is deleted from the listbox
#    during dragging and dropping    
#
#=cut
#
# sub decrease_vigil_on_delete_counter {
#	my $self = @_;
#
#
#	print("main,decrease_vigil_on_delete_counter; count =");
#  	$flow_widgets->dec_vigil_on_delete_counter(2);
#   print("$flow_widgets->get_vigil_on_delete\n");

#	return();
#}


=head2 sub add2flow_button 


=cut

sub add2flow_button {
	my $last_item;
  	my $here; 

    $whereami->set4add2flow_button();

	private_conditions->set4start_of_add2flow_button();

   	$whereami		->set4flow_listbox();

       		# clear all the indices of selected elements   
   	$sunix_listbox->selectionClear($sunix_listbox->curselection);

			# add the most recently selected program
			# name (scalar reference) to the 
			# end of the list 
    
   	$flow_listbox_l    ->insert(
                       	"end", 
                       	${$TkPl_SU->{_prog_name}},
	               );

   				# display default paramters in the GUI
    			# same as for sunix_select
    			# can not get program name from the item selected in the sunix list box 
    			# because focus is transferred to another list box
      
   	$param_sunix   					->set_program_name($TkPl_SU->{_prog_name});
   	$TkPl_SU->{_names_aref}  		= $param_sunix->get_names();
   	$TkPl_SU->{_values_aref} 		= $param_sunix->get_values();
   	$TkPl_SU->{_check_buttons_settings_aref}  	= $param_sunix->get_check_buttons_settings();
   	$TkPl_SU->{_param_sunix_first_idx}  	= $param_sunix->first_idx(); # first index = 0
   	$TkPl_SU->{_param_sunix_length}  	= $param_sunix->length(); # # values not index 

   	$whereami			->set4add2flow_button();
   	$here                = $whereami->get4add2flow_button();
   	$param_widgets       ->set_location_in_gui($here);

   	$param_widgets		->range($TkPl_SU);
   	$param_widgets		->set_labels($TkPl_SU->{_names_aref});
   	$param_widgets		->set_values($TkPl_SU->{_values_aref});
   	$param_widgets		->set_check_buttons(
					$TkPl_SU->{_check_buttons_settings_aref});
   	$param_widgets		->redisplay_labels();
   	$param_widgets		->redisplay_values();
   	$param_widgets		->redisplay_check_buttons();

   				# collect,store prog versions changed in list box
   	stack_versions();

				# store flow parameters in another namespace
   	stack_flow();
				# set location to be in a flow listbox--left or right
   	$whereami			->set4flow_listbox();

	private_conditions->set4end_of_add2flow_button();
						 # print("main,add2flow_button,last left flow program touched had index = $TkPl_SU->{_last_flow_index_touched}\n");
						
   	return(); 
}


=head2 sub stack_flow

  store an initial version of the parameters in another namespace for
  manipulation by the user
 the initial version comes from default parameter files
  Using the same code as for sunix_select
						 print("main,stack_flow,last left listbox flow program touched had index = $TkPl_SU->{_last_flow_index_touched}\n");


=cut


sub stack_flow {
		# store flow parameters in another namespace
  $param_flow		->stack_flow_item($TkPl_SU->{_prog_name});
  $param_flow		->stack_values_aref2($TkPl_SU->{_values_aref});
  $param_flow		->stack_names_aref2($TkPl_SU->{_names_aref});
  $param_flow		->stack_checkbuttons_aref2($TkPl_SU->{_check_buttons_settings_aref});

  return();
}

=head2 sub stack_superflow

  store an initial version of the parameters in another namespace for
  manipulation by the user
 the initial version comes from default parameter files
  Using the same code as for sunix_select
						 print("main,stack_superflow,last left listbox flow program touched had index = $TkPl_SU->{_last_flow_index_touched}\n");


=cut


sub stack_superflow {
		# store flow parameters in another namespace
  $param_flow		->stack_superflow_item($TkPl_SU->{_prog_name});
  $param_flow		->stack_values_aref2($TkPl_SU->{_values_aref});
  $param_flow		->stack_names_aref2($TkPl_SU->{_names_aref});
  $param_flow		->stack_checkbuttons_aref2($TkPl_SU->{_check_buttons_settings_aref});

  return();
}


=head2 sub delete_from_flow_button

		print("main, delete_from_flow_button, $here\n");
  		foreach my $key (sort keys %$here) {
   	 	print (" main,delete_from_flow_button, key is $key, value is $here->{$key}\n");
}

=cut

sub delete_from_flow_button {

	my $self = @_;

	$decisions		->set4delete_from_flow_button($TkPl_SU);
	my $pre_req_ok 	= $decisions->get4delete_from_flow_button();

					# confirm listboxes are active
					# print("1. main,delete_from_flow_button pre_req $pre_req_ok\n");
  	if ($pre_req_ok) {
					 # print("2. main,delete_from_flow_button pre_req_ok\n");
   
  		$whereami			->set4delete_from_flow_button();
  		my $here 			= $whereami->get4delete_from_flow_button();

        			# location within GUI on first clicking delete button  
        private_conditions->set4delete_from_flow_button();

		my $index = $flow_widgets->get_flow_selection($flow_listbox_l);

					# when last item in listbox is deleted 
		if ($index == 0 && $param_flow->get_num_items == 1) {

      				 #  print("last item deleted Shut down delete button\n");
     		$flow_widgets->delete_selection($flow_listbox_l);

					# the last program that was touched is cancelled out
   							 $TkPl_SU->{_last_flow_index_touched} 	= -1;
							#  print("main,delete_from_flow_button,last left flow program touched had index = $TkPl_SU->{_last_flow_index_touched}\n");

			# delete stored programs and their parameters
   			# delete_from_stored_flows(); 
  			my $index2delete 	= $flow_widgets->get_index2delete();
  					 # print("main,delete_from_stored,index2delete:$index2delete\n");
  			$param_flow		->delete_selection($index2delete);

   					# collect and store latest program versions from changed list 
   			stack_versions();

       				# turn off delete button
			$delete_from_flow_button	->configure(
						-state => 'disabled',);   

       				# turn off ListBox
			$flow_listbox_l    ->configure(
		        		-state => 'disabled',
                      ); 

        			# location within GUI after last item is deleted 
        	private_conditions->reset();

					# Blank out all the widget parameter names and their values
			$whereami			->set4delete_from_flow_button();
        	$here				= $whereami->get4delete_from_flow_button();
   			$param_widgets      ->set_location_in_gui($here);
   			$param_widgets		->gui_clean();
        
   		} elsif ($index >= 0) { #  i.e., more than one item remains			
			
							# note the last program that was touched
							# note the last program that was touched
							 $TkPl_SU->{_last_flow_index_touched} = $index;

					   		# print("delete_from_flow_button, index:$index..\n");
     		$flow_widgets->delete_selection($flow_listbox_l);

					# delete stored programs and their parameters
   					# delete_from_stored_flows(); 
  			my $index2delete 	= $flow_widgets->get_index2delete();
  					 		# print("2. main,delete_from_stored,index2delete:$index2delete\n");
  			$param_flow		->delete_selection($index2delete);

					# update the widget parameter names and values
					# to those of new selection after deletion
  					# the chkbuttons, values and names of only the last program used 
  					# is stored in param_widgets at any one time			
  					# get parameters from storage
  			my $next_idx_selected_after_deletion = $index2delete - 1;	
            if($next_idx_selected_after_deletion == -1) { $next_idx_selected_after_deletion = 0} # NOT < 0
  					  		# print("2. main,delete_from_flow_button,indexafter_deletion:$next_idx_selected_after_deletion\n");

   		 	$param_flow		-> set_flow_index($next_idx_selected_after_deletion);
 			$TkPl_SU->{_names_aref} 	= $param_flow->get_names_aref();

  							 # print("2. main, delete_from_flow_button,parameter names is @{$TkPl_SU->{_names_aref}}\n");
 			$TkPl_SU->{_values_aref} 	=	$param_flow->get_values_aref();

  				 			 # print("3. main, delete_from_flow_button,parameter values is @{$TkPl_SU->{_values_aref}}\n");
 			$TkPl_SU->{_check_buttons_settings_aref} 
										=  $param_flow->get_check_buttons_settings();

  				 			 # print("4. main, delete_from_flow_button, check_buttons_settings no changes, @{$TkPl_SU->{_check_buttons_settings_aref}}, index;$index\n#");
  				 			
 				 			# get stored first index and num of items 
 			$TkPl_SU->{_param_flow_first_idx}	= $param_flow->first_idx();
 			$TkPl_SU->{_param_flow_length}   	= $param_flow->length();
 			$param_widgets				 		->set_current_program(\$flow_listbox_l);

			$whereami					->set4flow_listbox();
			$here 						= $whereami->get4flow_listbox();
				 			 # print("main, delete_from_flow_button, $here->{_is_flow_listbox_l}\n");
				 			 # print("main, delete_from_flow_button, $here->{_is_flow_listbox_r}\n");
				 			 
	    	$param_widgets      		->set_location_in_gui($here);
   			$param_widgets				->gui_clean();
  			$param_widgets				->range($TkPl_SU);
 			$param_widgets				->set_labels($TkPl_SU->{_names_aref});
 			$param_widgets				->set_values($TkPl_SU->{_values_aref});
 			$param_widgets				->set_check_buttons(
									$TkPl_SU->{_check_buttons_settings_aref});

					  		 # print("main, delete_from_flow_button, is listbox selected:$here->{_is_flow_listbox_l}\n");
 			$param_widgets				->redisplay_labels();
 			$param_widgets				->redisplay_values();
 			$param_widgets				->redisplay_check_buttons();
#  			$param_widgets				->set_entry_change_status($false);	

							# note the last program that was touched
			 $TkPl_SU->{_last_flow_index_touched} = $next_idx_selected_after_deletion;

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

=cut 

sub move_in_stored_flows {
   my $self 		= @_;
   $TkPl_SU->{_index2move}        	= $flow_widgets->index2move();
   $TkPl_SU->{_destination_index} 	= $flow_widgets->destination_index();

   my $start						= $TkPl_SU->{_index2move};
   my $end	    					= $TkPl_SU->{_destination_index};
   			 # print("main,move_in_stored_flows,start index is the $start\n");
   			 # print("main,move_in_stored_flows, insertion index is $end \n");

   $param_flow->set_insert_start($start);
   $param_flow->set_insert_end($end);
   $param_flow->insert_selection(); 
   

 }

=head2 sub help

 Callback sequence following MB3 click 
 activation of a sunix (Listbox) item
 program name is a scalar reference

=cut 

sub help {
	my $self = @_;
   	use help;
   	my $help = new help();
   	$help->name($TkPl_SU->{_prog_name});
#   	$help->sunix($TkPl_SU->{_is_sunix_module});
   	$help->superflows($TkPl_SU->{_is_superflow_select_button});
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
    $flow_widgets						->set_flow_items($flow_listbox_l );
    $TkPl_SU->{_items_versions_aref} 	= $flow_widgets->items_versions_aref;
    $param_flow						->set_flow_items_version_aref($TkPl_SU->{_items_versions_aref});
 	 # print("stack_versions,items_versions_aref: @{$TkPl_SU->{_items_versions_aref}}\n");
}


=head2 sub sunix_select

  Pick Seismic Unix modules

  foreach my $key (sort keys %$TkPl_SU) {
   print (" main,key is $key, value is $TkPl_SU->{$key}\n");
  }

     print("main, program name is ${$TkPl_SU->{_prog_name}}\n");

=cut 

sub sunix_select {

   	my $self = @_;

        # location within GUI
    private_conditions			->set4sunix_select;
   	$whereami					->set4sunix_listbox();
   	my $here 					= $whereami->get4sunix_listbox();

        # get program name
   	$TkPl_SU->{_prog_name} 				= $param_widgets->get_current_program(\$sunix_listbox);

   	$param_sunix   						->set_program_name($TkPl_SU->{_prog_name});
   	$TkPl_SU->{_names_aref}  			= $param_sunix->get_names();
   	$TkPl_SU->{_values_aref} 			= $param_sunix->get_values();
   	$TkPl_SU->{_check_buttons_settings_aref}  	= $param_sunix->get_check_buttons_settings();
   	$TkPl_SU->{_param_sunix_first_idx}  = $param_sunix->first_idx();
   	$TkPl_SU->{_param_sunix_length}  	= $param_sunix->length();

   	$param_widgets      ->set_location_in_gui($here);
   	$param_widgets		->gui_clean();
   	$param_widgets		->range($TkPl_SU);
   	$param_widgets		->set_labels($TkPl_SU->{_names_aref});
   	$param_widgets		->set_values($TkPl_SU->{_values_aref});
   	$param_widgets		->set_check_buttons(
						$TkPl_SU->{_check_buttons_settings_aref});
   	$param_widgets		->set_current_program(\$sunix_listbox);

						 # print("main, sunix_select, $TkPl_SU->{_is_sunix_listbox}\n");
   	$param_widgets       ->set_location_in_gui($here);
   	$param_widgets		->redisplay_labels();
   	$param_widgets		->redisplay_values();
   	$param_widgets		->redisplay_check_buttons();

   	$flow_listbox_l		->configure(-state => 'normal',);
   	$add2flow_button	->configure(-state => 'normal',);

							# future location in GUI TODO?
   	$TkPl_SU->{_is_flow_listbox_l}	= $true;
   	$TkPl_SU->{_is_flow_listbox_r}	= $false;
   	$TkPl_SU->{_is_add2flow_button}	= $true;


   	return();
}

=head2  local_check4changes

	assume now that a flow select will always change a previously existing
	set of flow parameters, That is, a prior program must have been touched if
	the following conditions are met:
	($param_widgets->get_entry_change_status && $TkPl_SU->{_last_flow_index_touched} >= 0) {

=cut 

sub local_check4changes {
	my $self = @_;

	if ($TkPl_SU->{_last_flow_index_touched} >= 0) {  # <-1 does exist

		my $last_idx_chng =$TkPl_SU->{_last_flow_index_touched} ;

	 					      # print("main,local_check4changes,last changed entry index was $last_idx_chng\n");
  							  # print("main, local_check4changes program name is ${$TkPl_SU->{_prog_name}}\n");
  							 #  	local_check4changes();
  							# the chkbuttons, values and names of only the last program used 
  							# is stored in param_widgets at any one time			
		$TkPl_SU->{_values_aref} 				= $param_widgets	->get_values_aref();
		$TkPl_SU->{_names_aref} 				= $param_widgets	->get_labels_aref();
		$TkPl_SU->{_check_buttons_settings_aref}= $param_widgets	->get_check_buttons_aref();

  							# print("main,flow_select,changed values_aref: @{$TkPl_SU->{_values_aref}}\n");
  							 # print("main,local_check4changes,changed names_aref: @{$TkPl_SU->{_names_aref}}\n");
  							# print(" main,flow_select,changes, check_buttons_settings_aref: @{$TkPl_SU->{_check_buttons_settings_aref}}\n");
  							#
   		 $param_flow				-> set_flow_index($last_idx_chng);
  						 	     # print("main,flow_select,store changes in param_flow, last changed entry index $last_idx_chng\n");
  						 	    
								# save old changed values
		 $param_flow->set_values_aref($TkPl_SU->{_values_aref}); 	# but not the versions
	 	 $param_flow->set_names_aref($TkPl_SU->{_names_aref}); 		# but not the versions
		 $param_flow->set_check_buttons_settings_aref($TkPl_SU->{_check_buttons_settings_aref}); # BUT not the versions

		 $param_widgets->set_entry_change_status($false);  # changes are now complete
	 	 						 # print("main, flow_select, set_entry_change_status: to 0\n");
	}  						

	return();
 }


=head2 sub flow_select

  Pick a Seismic Unix module
  from within a flow listbox
  This module is selected previously by user
  When there is only one item left in the
  listbox drag and drop becomes blocked
  N.B. I assume that local_check4changes will prove false in this case
  check whether any programs were deleted by dragging previously
  If so, delete stored values from param_flow
  N.B. I assume that local_check4changes will prove false in this case

=cut

sub flow_select {

	my $self = @_;

				# independently set conditions to make both flow boxes available
				#  TODO place which listbox (left or right) was chosen in private_conditions

    private_conditions->set4start_of_flow_select();       
	$decisions		->set4flow_select($TkPl_SU);
	my $pre_req_ok 	= $decisions->get4flow_select();
	if ($pre_req_ok) { 
		my $here;
      						# selected program name
 		$TkPl_SU->{_prog_name} 	= $flow_widgets->get_current_program(\$flow_listbox_l);
 							    # print("\n1. main, flow_select, program name is ${$TkPl_SU->{_prog_name}}\n");
 		
							# Is a program deleted through a previous dragNdrop?
  		if( $flow_widgets->is_drag_deleted($flow_listbox_l) ) {

			  				 #   print("\n\nmain,flow_select,something was deleted in previous dragNdrop\n");
        	my $this_index = $flow_widgets->get_drag_deleted_index($flow_listbox_l);
							 # print("main,flow_select,deleting flow_listbox,idx=$thi# s_index\n");
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
							 # make sure you know which program was touched previously
		                     # assume all prior programs touched have
		                     # modified parameters 
		                     # find out which program was previously touched
		                     # and update that program's stored values	
		local_check4changes();
		                     
		                    # for just-selected program name
							# get its flow parameters from storage
							# and redisplay the widgets with parameters 
   		my $index 					= $flow_widgets->get_flow_selection($flow_listbox_l);

  							  #   print("2. main, flow_select,index is $index\n");
 		$param_flow					->set_flow_index($index);
 		$TkPl_SU->{_names_aref} 	= $param_flow->get_names_aref();

  							  #  print("2. main, flow_select,parameter names is @{$TkPl_SU->{_names_aref}}\n");
 		$TkPl_SU->{_values_aref} 	=	$param_flow->get_values_aref();

  				 			 # print("3. main, flow_select,parameter values is @{$TkPl_SU->{_values_aref}}\n");
 		$TkPl_SU->{_check_buttons_settings_aref} 
									=  $param_flow->get_check_buttons_settings();

  				 			# print("4. main, flow_select, check_buttons_settings no changes, @{$TkPl_SU->{_check_buttons_settings_aref}}, index;$index\n#");
  				 			
 				 			# get stored first index and num of items 
 		$TkPl_SU->{_param_flow_first_idx}	= $param_flow->first_idx();
 		$TkPl_SU->{_param_flow_length}   	= $param_flow->length();
 		$param_widgets				 		->set_current_program(\$flow_listbox_l);

				 			 # print("main, flow_select, $TkPl_SU->{_is_flow_listbox_l}\n");
		$whereami					->set4flow_listbox();
		$here 						= $whereami->get4flow_listbox();
				 			 # print("main, flow_select, $here->{_is_flow_listbox_l}\n");
				 			 # print("main, flow_select, $here->{_is_flow_listbox_r}\n");
				 			 
	    $param_widgets      		->set_location_in_gui($here);
   		$param_widgets				->gui_clean();
  		$param_widgets				->range($TkPl_SU);
 		$param_widgets				->set_labels($TkPl_SU->{_names_aref});
 		$param_widgets				->set_values($TkPl_SU->{_values_aref});
 		$param_widgets				->set_check_buttons(
									$TkPl_SU->{_check_buttons_settings_aref});

					  		# print("main, flow_select, is listbox selected:$here->{_is_flow_listbox_l}\n");
		#$whereami					->set4flow_listbox();
		#$here 						= $whereami->get4flow_listbox();
    	$param_widgets      		->set_location_in_gui($here);
 		$param_widgets				->redisplay_labels();
 		$param_widgets				->redisplay_values();
 		$param_widgets				->redisplay_check_buttons();
  		$param_widgets				->set_entry_change_status($false);	


    private_conditions->set4end_of_flow_select();       

   		return();
	}
}

=head2 sub run_button


=cut

sub run_button {
	my $self = @_;
	private_conditions->set4run_button();

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

    print("main,superflow_select,program name is $TkPl_SU->{_prog_name}\n"); 
    print(" main,superflow_select, is tool: is $TkPl_SU->{_is_superflow_select_button}\n"); 
    print(" main,superflow_select,is sunix_module $TkPl_SU->{_is_sunix_module}\n"); 
    print(" main,superflow_select,widget: $TkPl_SU->{_current_widget}\n"); 
    print(" main,superflow_select,widget: $var->{_superflow}\n"); 
 
    scalar reference:
      print("LSU_Tk,superflow_select,prog_name: ${$TkPl_SU->{_prog_name}}\n");
    array reference:
      print("LSU_Tk,superflow_select: _names_aref @{$TkPl_SU->{_names_aref}}\n");

=cut

sub superflow_select {

 	my ($superflow_name_sref) = @_; 

        		       	# local location within GUI   
	private_conditions->set4superflow_select();

						# set location in gui
	$whereami			->set4superflow_select_button();

   	     				# get and set program name (scalar ref) 
  	$TkPl_SU->{_prog_name} 		= $superflow_name_sref;
						#  print("main,superflow_select,prog=${$TkPl_SU->{_prog_name}}\n");
   	$config_superflows   		->set_program_name($TkPl_SU->{_prog_name});
        
   	     				# parameter names from superflow configuration file
   	$TkPl_SU->{_names_aref}  	= $config_superflows->get_names();
						#  print("main,superflow_select,prog=@{$TkPl_SU->{_names_aref}}\n");

     					# parameter values from superflow configuration file
   	$TkPl_SU->{_values_aref} 	= $config_superflows->get_values();
						 #  print("main,superflow_select,valu=@{$TkPl_SU->{_values_aref}}\n");

   	$TkPl_SU->{_check_buttons_settings_aref}  	= $config_superflows->get_check_buttons_settings();
						 print("main,superflow_select,chkb=@{$TkPl_SU->{_check_buttons_settings_aref}}\n");

   	$TkPl_SU->{_superflows_first_idx}  	= $config_superflows->first_idx();
   	$TkPl_SU->{_superflows_length}  	= $config_superflows->length();

					# Blank out all the widget parameter names and their values
   	my $here			= $whereami->get4superflow_select_button();
   	$param_widgets      ->set_location_in_gui($here);
   	$param_widgets		->gui_clean();

   	$param_widgets		->range($TkPl_SU);
   	$param_widgets		->set_labels($TkPl_SU->{_names_aref});
   	$param_widgets		->set_values($TkPl_SU->{_values_aref});
   	$param_widgets		->set_check_buttons(
						$TkPl_SU->{_check_buttons_settings_aref});
   	$param_widgets		->redisplay_labels();
   	$param_widgets		->redisplay_values();
   	$param_widgets		->redisplay_check_buttons();

				# store superflow parameters in another namespace
   # stack_superflow();
}



=head2 sub save_button 

 prior to saving
 determine if we are dealing with superlow 
 (" menubutton" widget)   
 - collect and/or access flow parameters
 - default path is the current path

 TODO:
 or with GUI-made flows ("frame widget")
 - collect and/or access flow parameters
 - default path is the current path



DB:
 print("current widget is $LSU->{_current_widget}\n"); 

#			$whereami->set4save_button();
#    	$TkPl_SU->{_is_add2flow_flow_button}	= $false;
#    	$TkPl_SU->{_is_delete_from_flow_button}	= $false;
#    	$TkPl_SU->{_is_dragNdrop}				= $false;
#    	$TkPl_SU->{_is_flow_listbox_l}			= $false;
#    	$TkPl_SU->{_is_flow_listbox_r}			= $false;
#    	$TkPl_SU->{_is_sunix_listbox}   		= $false;
# 		$TkPl_SU->{_is_sunix_module}   			= $false;
#    	$TkPl_SU->{_is_superflow_select_button}	= $false;
#    	$TkPl_SU->{_is_run_button}				= $false;

=cut

sub save_button {
 	my ($self) 			= @_;
 	use save;
 	my $save 			= new save();
	private_conditions	->set4save_button();

        		# location within GUI   
	my $here = $whereami->in_gui();

    if($TkPl_SU->{_is_superflow_select_button}) {
		$config_superflows->save($TkPl_SU);
	}
   # $save->configure($TkPl_SU);
   #error->save
   	return();
}


=head2 package local_last

=cut

package local_last;


=head2 package private_conditions

=cut

sub set_flow_listbox_touched {
	my $self = @_;
	# TODO in future the program must keep track of which listbox was just chosen
   	$TkPl_SU->{_last_flow_listbox_touched} 		= 'flow_listbox_l';
    		  # print("main,local_last set_flow_listbox_touched left listbox = $TkPl_SU->{_last_flow_listbox_touched}\n");

	return();
}

sub set_flow_listbox_touched_w {
	my $self = @_;
	# TODO in future the program must keep track of which listbox was just chosen
   	$TkPl_SU->{_last_flow_listbox_touched_w} 	= $flow_listbox_l;	
    		  # print("main,local_last, set_flow_listbox_touched_w= $TkPl_SU->{_last_flow_listbox_touched_w}\n");

	return();
}

sub set_flow_index_touched {
	my ($self) = @_;

   		$TkPl_SU->{_last_flow_index_touched} 	= $flow_widgets->get_flow_selection($flow_listbox_l);
							  # print("1. main,local_last,last left listbox flow program touched had index = $TkPl_SU->{_last_flow_index_touched}\n");

	return();
}



package private_conditions;

sub reset {

	my $self = @_;

        		# location within GUI   
   	$TkPl_SU->{_is_add2flow_flow_button}	= $false;
   	$TkPl_SU->{_is_delete_from_flow_button}	= $false;
   	$TkPl_SU->{_is_dragNdrop}				= $false;
   	$TkPl_SU->{_is_flow_listbox_l}			= $false;
   	$TkPl_SU->{_is_flow_listbox_r}			= $false;
    $TkPl_SU->{_is_open_file_button}		= $false;
   	$TkPl_SU->{_is_sunix_listbox}   		= $false;
	$TkPl_SU->{_is_new_listbox_selection} 	= $false;
# 	$TkPl_SU->{_is_sunix_module}   			= $false;
   	$TkPl_SU->{_is_superflow_select_button}	= $false;
   	$TkPl_SU->{_is_run_button}				= $false;
   	$TkPl_SU->{_is_save_button}				= $false;
    $TkPl_SU->{_is_moveNdrop_in_flow}       = $false;

}

sub  set4FileDialog_button {
	my $self = @_;
	#private_conditions->reset();
	 #  ERROR if private_conditions->reset() the param_widgets table is reset;
	 #  ERROR if private_conditions->reset() the 	 #  f 
    $TkPl_SU->{_is_open_file_button}		= $true;
	
    #print("main,private_conditions,set4FileDialog_button,listbox_l listbox_r  $TkPl_SU->{_is_flow_listbox_l} 	$TkPl_SU->{_is_flow_listbox_r}\n");
 
	return();
}

sub  set4FileDialog_close {
	my $self = @_;
    $TkPl_SU->{_is_open_file_button}		= $false;
	
	return();
}


sub set4end_of_flow_select {
	my $self = @_;
	private_conditions	->reset();
	local_last			->set_flow_index_touched();
				  # print("1. main,local_configure,set4end_of_flow_select,last left listbox flow program touched had index = $TkPl_SU->{_last_flow_index_touched}\n");
        		# location within GUI   
   	$TkPl_SU->{_is_flow_listbox_l}			= $true;
   	$TkPl_SU->{_is_flow_listbox_r}			= $true;

	return();

}



sub set4save_button {
	my $self = @_;
	# private_conditions	->reset();
				  # print("1. main,local_configure,set4save_button,last left listbox flow program touched had index = $TkPl_SU->{_last_flow_index_touched}\n");
        		# location within GUI   
   	$TkPl_SU->{_is_save_button}			= $true;

	return();

}

sub set4start_of_flow_select {
	my $self = @_;
	private_conditions	->reset();
	local_last			->set_flow_listbox_touched();
    local_last			->set_flow_listbox_touched_w();
        		# location within GUI   
   	$TkPl_SU->{_is_flow_listbox_l}			= $true;
   	$TkPl_SU->{_is_flow_listbox_r}			= $true;
   	$delete_from_flow_button				->configure(-state => 'active',);
  	$flow_listbox_l							->configure(-state => 'normal',);
  	$flow_listbox_r							->configure(-state => 'normal',);

	return();

}

sub set4delete_from_flow_button {
	my $self = @_;
	# print("succeeded\n");
	private_conditions->reset();
        		# location within GUI on first clicking delete button
   	$TkPl_SU->{_is_delete_from_flow_button}	= $true;
	return();

}


sub set4run_button {
	my $self = @_;
	private_conditions->reset();
        		# location within GUI   
   	$TkPl_SU->{_is_run_button}				= $true;
	return();

}


sub set4end_of_add2flow_button{
	my $self = @_;
	private_conditions->reset();
							# highlight new index
   	$flow_listbox_l    ->selectionSet("end");
							# note the last program that was touched
   	$TkPl_SU->{_is_add2flow_flow_button}	= $false;
   	$TkPl_SU->{_is_flow_listbox_l}			= $true;
   	$TkPl_SU->{_is_flow_listbox_r}			= $true;

   	local_last->set_flow_index_touched();
	# TODO in future the program must keep track of which listbox was just chosen
   	local_last->set_flow_listbox_touched();
       # disable Add-to-flow button that was 
       # just clicked
   		$add2flow_button	->configure(
							-state=>'disabled');

	return();
}


sub set4start_of_add2flow_button{
	my $self = @_;
    private_conditions->reset();

   	local_last->set_flow_listbox_touched_w();	

   	$TkPl_SU->{_is_add2flow_flow_button}	= $true;
   	$TkPl_SU->{_is_sunix_listbox}   		= $true;
	$TkPl_SU->{_is_new_listbox_selection} 	= $true;

    $run_button			->configure(-state => 'normal'); 
    $save_button		->configure(-state => 'normal');    


 	#$parameter_names_frame ->configure(
#							-state=>'disabled');
# 	$parameter_values_button_frame ->configure(
#							-state=>'disabled');

       		# turn on delete button
   	$delete_from_flow_button	->configure(
						-state => 'active',);   

       		# turn on ListBox(es) later use
   $flow_listbox_l    ->configure(
		        		-state => 'normal',
                      ); 
   # $flow_listbox_r    ->configure(
   #	        		-state => 'normal',
   #                   ); 
	return();
}


sub set4superflow_select {
	my $self = @_;
	private_conditions->reset();
        		# location within GUI   
	$TkPl_SU->{_is_new_listbox_selection} 	= $true;
# 	$TkPl_SU->{_is_sunix_module}   			= $false;
 	$TkPl_SU->{_is_superflow_select_button}	= $true;

    $delete_from_flow_button	->configure(-state => 'disabled',); 	

					# turn off Flow label
    $flow_listbox_l		->configure(-state => 'disabled'); 	# turn off Flow label
    $flow_listbox_r		->configure(-state => 'disabled'); 	# turn off Flow label
    $run_button			->configure(-state => 'normal'); 
    $save_button		->configure(-state => 'normal');    

}


sub set4sunix_select {
	my $self = @_;
    private_conditions->reset();
   	$delete_from_flow_button	->configure(-state => 'disabled',);
	return();
}

#sub superflows_commands {
 	#use toolspecs;
    # my $size;
   # my $tool_specs 			= new tool_specs(); 
# 	 my ($selected_button) 		= @_;
  #if (defined $selected_button ) {
#    
#    refresh_gui();
#    } 
# }
					# import parameters for selected superflow	
    #( $TkPl_SU->{_ref_labels},
    #  $TkPl_SU->{_ref_values},
    #  $ref_chk_button_variable ) = $tool_specs->get($TkPl_SU->{_prog_name});
    #$size  			 			 = $tool_specs->sizes();
    #$TkPl_SU->{_ref_param_value_button_w_variable}           = $ref_chk_button_variable; 
#
#    $TkPl_SU	->{_final_entry_num}   =  $size;
#    $entries	->{_final_entry_num}   =  $TkPl_SU->{_final_entry_num};
     # superflows_commands();
# 4. merge with LSU_Tk
# 5. Save new flows and superflows
# 6. Run new flows and superflows
# 7. Read in old flows
# 8. create param files for more sunix modules
# 9. create spec files for more sunix modules
# 10. creat make.PL file
# 11. upload code
# 12. see if CAGEo or SRL will accept code

