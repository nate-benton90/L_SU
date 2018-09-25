#!/usr/bin/perl

=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL PROGRAM NAME: SeismicUnixPlTk.pl 
 AUTHOR: 	Juan Lorenzo
 DATE: 		June 22 2017 

 DESCRIPTION 
     

 BASED ON:
 Version 0.1 April 18 2017  
     Added a simple configuration file readable 
flow
    and writable using Config::Simple (CPAN)

 Version 0.2 
    incorporate more object oriented classes
   
 Update: Simple (ASCII) local configuration 
      file is Project_Variables.config
      
 V 1.0.2 Jan 12 2018: removed all Config::Simple dependencies   

=cut

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES

=cut 

=head2 Notes from bash
 
=cut 

 	use Moose;
 	our $VERSION = '1.0.2';
	use L_SU::messages::message_director;
 	use Tk;
 	use Tk::DragDrop;
 	use Tk::DropSite;
 	use Tk::Pane;
	use SeismicUnixPlTk_global_constants;
	use control;
	use config_superflows;
	use decisions 1.00;
	use iFile;
	use flow_widgets;
	use	name;
	use param_widgets;
	use param_flow;
	use param_sunix;
	use whereami;

	my $L_SU_messages 	    = message_director->new();
 	my $config_superflows   = config_superflows->new();
 	my $control  			= control->new();
 	my $decisions			= decisions->new();
 	my $flow_widgets		= new flow_widgets;
 	my $iFile				= new iFile;
    my $name				= new name;
 	my $get					= new SeismicUnixPlTk_global_constants();
 	my $param_flow         	= new param_flow;
 	my $param_widgets		= param_widgets->new();
 	my $param_sunix        	= param_sunix->new();
 	my $whereami           	= whereami->new();


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
 	my ($top_menu_label);
 	my ($side_menu_frame);
 	my ($sunix_frame,$parameters_pane,$flow_control_frame);
 	my ($parameter_values_button_frame );
 	my ($parameter_names_frame,$parameter_values_frame);
 	my ($sunix_listbox,$flow_listbox_l,$flow_listbox_r,$flow_listbox_sw,$flow_listbox_se);
 	my ($ref_chk_button_variable);
 	my (@labels_w, @entries_w);
 	my ($sunix); 
	my (@param,@values,@args);
	my (@on_off_param);
	
 	my $var								= $get->var();
	my $on         						= $var->{_on};
	my $off        						= $var->{_off};
	my $true       						= $var->{_true};
	my $false      						= $var->{_false};
	my $default_path  					= $var->{_default_path};
	my $failure     					= $var->{_failure};
	my $tool_widget_ident 				= $var->{_superflow};
	my $sunix_widget_ident 				= $var->{_flow};
	my $alias_FileDialog_button_label	= $get->alias_FileDialog_button_label_aref; 
    my $alias_superflow_names			= $get->alias_superflow_names_h ;
    my $global_libs						= $get->global_libs();
    my $superflow_names     			= $get->superflow_names_h();
    my $superflow_names_gui_aref     	= $get->superflow_names_gui_aref(); 

 	@values  							= qw//;
 	my @choices 						= @{$var->{_sunix_choices}};


=head2 Default Tk settings{

 Create scoped hash 

=cut

 my $TkPl_SU   = {
	_FileDialog_option				=> '',
	_check_buttons_settings_aref    => '',
    _current_widget					=> '', 
	_current_index  				=> '',
	_current_sunix_selection_index 	=> '',
	_entry_button_label	  			=> '',	
	_error 							=> '',
	_flow_name_out					=> '',
	_good_labels_aref2				=> '',
	_good_values_aref2 				=> '',		
	_prog_names_aref 				=> '', 
	_name_aref    					=> '',
	_names_aref    					=> '',
	_first_index    				=> '',
    _index2move	    				=> '',
    _destination_index	 			=> '',
    _has_used_check_code_button		=> '',   # TODO check if needed?
    _has_used_save_button			=> '',
    _has_used_saveas_flow_button	=> '',
  	_items_versions_aref 			=> '',
  	_items_values_aref2  			=> '',
  	_items_names_aref2  			=> '',
  	_items_checkbuttons_aref2 		=> '',
	_is_add2flow_button	   			=> '',
	_is_check_code_button          	=> '',
	_is_delete_from_flow_button	   	=> '',
	_is_flow_listbox_l				=> '',
	_is_flow_listbox_r				=> '',
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
	_superflows_first_idx   		=> '',
	_superflows_length    			=> '',
    _last_param    					=> '',
    _first_param    				=> '',
	_length    						=> '',
	_listbox_size 					=> '',
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


=head2 Main Window contains

 a top menu frame 
 a middle menu titles frame
 and a
 bottom  work_frame
 font is made to be arial normal 14
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
                  
 	my $arial  = $mw->fontCreate(
                  'arial', 
                  -family => 'arial',
                  -weight => 'normal',
                  -size   => -14);
                  
 	my $small_garamond  = $mw->fontCreate(
                  'small_garamond', 
                  -family => 'garamond',
                  -weight => 'normal',
                  -size   => -9);
                  
 	my $small_arial  = $mw->fontCreate(
                  'small_arial', 
                  -family => 'arial',
                  -weight => 'normal',
                  -size   => -9);
                  
 	$top_menu_frame = $mw->Frame(
                   -borderwidth => $var->{_no_borderwidth}, 
                   -background  => $var->{_my_purple},
                   -relief      => 'groove'
                   );

 	$top_menu_frame  ->Label(
					-text 	=> '',
					-font 	=> $arial,
					-width	=> $var->{_no_pixel},
					-background  => $var->{_my_purple},
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
    		        -text   			=> 'Tools',
		           	-font 				=> $arial,
	                -height     		=> 1,
	                -width      		=> 6,
	                -padx	    		=> $var->{_five_pixels},
                    -background 		=> $var->{_my_yellow},
 					-foreground 		=> $var->{_my_black},
					-disabledforeground => $var->{_my_dark_grey},
					-activeforeground 	=> $var->{_my_white},
					-activebackground 	=> $var->{_my_dark_grey},                   
    		        -relief 			=> 'flat'
		          );
	my $top_menu_bar	= $superflow_select->Menu(
		           -font 	=> $arial);

 	$top_menu_bar	-> bind('<ButtonRelease-3>' 
			=> [\&help], );    
=pod
    $args[0] = $superflow_names->{_ProjectVariables}; (OLD)
	print("main, _Project: $args[0]\n");
	print("main,sflows:$sflows\n");
	print("main,$length_sflows\n");
	
=cut

=head2 give user superflow names

=cut

	@args    		  = @$superflow_names_gui_aref;
	my $length_sflows = (scalar @args) -1 ;  # last member is "temp"
	
	$superflow_select	 ->configure(
			   -menu 	 => $top_menu_bar
               ); 		
           
 	for (my $sflows=0; $sflows < $length_sflows; $sflows++) {	              
 		$superflow_select		->command(
    			  -label       	=> $args[$sflows],
    			  -underline   	=> 0,
    			  -font 		=> $arial,
                  -command      => [\&superflow_select, \$args[$sflows] ],
 			);   	
 	}
 
 			  
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
    		           	-text   			=> 'File',
		           		-font 				=> $arial,
	                   	-height      		=> 1,
    		           	-relief 			=> 'flat',
    		           	-state 				=> 'disabled',
    		           	-background			=> $var->{_my_yellow},
						-foreground 		=> $var->{_my_black},
						-disabledforeground => $var->{_my_dark_grey},
						-activeforeground 	=> $var->{_my_white},
						-activebackground 	=> $var->{_my_dark_grey},
    		           
		          		);
	
	my $side_menu_bar	= $file_menubutton->Menu(
		           		-font 	=> $arial);

 	$file_menubutton	->configure(
			   				-menu 	=> $side_menu_bar
                           );
 	$file_menubutton	->separator;
	my @File_option;
    $File_option[0] =  'Open';
    $File_option[1] =  'Select';
    $File_option[2] =  'SaveAs';


 	$file_menubutton	->command(
    			  		-label       	=> @$alias_FileDialog_button_label[0],
    			  		-underline   	=> 0,
			  			-command      	=>[\&FileDialog_button,\$File_option[0]],
    			  		-font 			=>$arial
 						);
	$file_menubutton	->separator;
 	$file_menubutton	->command(
    			  		-label       	=> @$alias_FileDialog_button_label[1],
    			  		-underline   	=> 0,
			  			-command      	=>[\&FileDialog_button,\$File_option[1]],
    			  		-font 			=>$arial
 						);
	$file_menubutton	->separator;
 	$file_menubutton	->command(
   			  			-label       	=> @$alias_FileDialog_button_label[2],
    			  		-underline   	=> 0,
			  			-command      	=>[\&FileDialog_button,\$File_option[2]],
    			  		-font 			=>$arial
 						);

 	$top_titles_frame 	= $mw->Frame(
                   	   -borderwidth => $var->{_one_pixel_borderwidth}, 
                   	   -background  => $var->{_light_gray},
                   	   -relief      => 'groove'
                   	);

=head2  side menu frame

 contains side menus
 2. for action 

=cut


 	my $run_button 	= $side_menu_frame->Button(
    		           		-text   			=> 'Run',
		           			-font 				=> $arial,
	                   		-height      		=> 1,
                           	-background  		=> $var->{_my_yellow},
                        	-foreground 		=> $var->{_my_black},
							-disabledforeground => $var->{_my_dark_grey},
							-activeforeground 	=> $var->{_my_white},
							-activebackground 	=> $var->{_my_dark_grey},
    		           		-relief 			=> 'flat',
    		           		-state 				=> 'disabled',
			   				-command     		=> [\&run_button],
		          			);
	 	
 
 	my $save_button 	= $side_menu_frame->Button(
    		           		-text   			=> 'Save',
		           			-font 				=> $arial,
	                   		-height      		=> 1,
                           	-background  		=> $var->{_my_yellow},
                        	-foreground 		=> $var->{_my_black},
							-disabledforeground => $var->{_my_dark_grey},
							-activeforeground 	=> $var->{_my_white},
							-activebackground 	=> $var->{_my_dark_grey},
    		           		-relief 			=> 'flat',
    		           		-state 				=> 'disabled',
			   				-command    		=> [\&save_button]
		          			);
		 	
 
 	my $check_code_button 	= $side_menu_frame->Button(
    		           		-text   			=> 'Check',
		           			-font 				=> $arial,
	                   		-height      		=> 1,
                           	-background  		=> $var->{_my_yellow},
                        	-foreground 		=> $var->{_my_black},
							-disabledforeground => $var->{_my_dark_grey},
							-activeforeground 	=> $var->{_my_white},
							-activebackground 	=> $var->{_my_dark_grey},
    		           		-relief 			=> 'flat',
    		           		-state 				=> 'disabled',
			   				-command    		=> [\&check_code_button]
		          			); 
=head2 top_titles frame

 just above the work frame
 contains Titles only 

=cut
      
 	my $top_titles_label	= $top_titles_frame  ->Label(
						-text 	    	=> '       Parameter Names                            Values',
		   				-font 	   		=> $arial,
  	           			-height     	=> $var->{_one_character},
		   				-border     	=> $var->{_no_pixel},
                   		-width      	=> 0,
                   		-padx       	=> 0,
                   		-background 	=> $var->{_light_gray},
                   		-relief     	=> 'groove'
                  	 );

	my $add2flow_button_grey = $top_titles_frame->Button(
    		           	-text  				=> '   Flow -+->',
						-font 				=> $arial,
	                   	-height   			=> 1,
	          			-width 				=> 4,
	                   	-padx				=> 18,
						-background			=> $var->{_my_light_grey},
						-foreground 		=> $var->{_my_black},
						-disabledforeground => $var->{_my_dark_grey},
						-activeforeground 	=> $var->{_my_white},
						-activebackground 	=> $var->{_my_dark_grey},           	
    		           	-relief 			=> 'flat',
    		           	-state 				=> 'disabled',
						-command			=> [\&add2flow_button]
		          );
   
	my $add2flow_button_pink = $top_titles_frame->Button(
    		           	-text  				=> '-+->',
						-font 				=> $arial,
	                   	-height   			=> 1,
	                   	-width  			=> 2,
						-background			=> $var->{_my_pink},
						-foreground 		=> $var->{_my_black},
						-disabledforeground => $var->{_my_dark_grey} ,
						-activeforeground 	=> $var->{_my_white},
						-activebackground 	=> $var->{_my_dark_grey},
    		           	-relief 			=> 'flat',
    		           	-state 				=> 'disabled',
						-command			=> [\&add2flow_button]
		          );
                            
	my $add2flow_button_green = $top_titles_frame->Button(
    		           	-text  				=> '-+->',
						-font 				=> $arial,
	                   	-height   			=> 1,
	                   	-width  			=> 2,
						-background			=> $var->{_my_light_green},
						-foreground 		=> $var->{_my_black},
						-disabledforeground => $var->{_my_dark_grey} ,
						-activeforeground 	=> $var->{_my_white},
						-activebackground 	=> $var->{_my_dark_grey},
    		           	-relief 			=> 'flat',
    		           	-state 				=> 'disabled',
						-command			=> [\&add2flow_button]
		          );
	my $add2flow_button_blue = $top_titles_frame->Button(
    		           	-text  				=> '-+->',
						-font 				=> $arial,
	                   	-height   			=> 1,
	                   	-width  			=> 2,  
						-background			=> $var->{_my_light_blue},
						-foreground 		=> $var->{_my_black},
						-disabledforeground => $var->{_my_dark_grey} ,
						-activeforeground 	=> $var->{_my_white},
						-activebackground 	=> $var->{_my_dark_grey},
    		           	-relief 			=> 'flat',
    		           	-state 				=> 'disabled',
						-command			=> [\&add2flow_button]
		          );

=pod

 button that removes a seismic unix program from the flow

=cut

 	my $delete_from_flow_button = $top_titles_frame->Button(
                   		-text				=> 'Delete',
						-font 				=> $arial,
						-height      		=> $var->{_one_character},
						-border      		=> 0,
                   		-padx        		=> 8,
                   		-width       		=> 7,
                   		-background			=> $var->{_my_light_grey},
						-foreground 		=> $var->{_my_black},
						-disabledforeground => $var->{_my_dark_grey},
						-activeforeground 	=> $var->{_my_white},
						-activebackground 	=> $var->{_my_dark_grey},
                   		-relief      		=> 'flat',
                   		-state       		=> 'disabled',
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
                   -background  => 'yellow',
                   -relief 		=> 'groove'
                  );


=head2 work frame

 has with menu items to its left
 contains a sunix_frame on its far left, 
 a parameters_pane (names and values)in the center
 and four listboxes contained in a module-sequences frame on the far right

=cut

 	$sunix_frame  		= $work_frame->Frame(
                    	   	-borderwidth 	=> $var->{_five_pixel_borderwidth}, 
                    	   	-relief	 		=> 'groove',
                    	   	-width       	=> $var->{_small_width},
							-background  	=> 'orange'
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
		       	   	"Pane", 
			-background  	=> $var->{_my_purple},
			-relief      	=> 'groove',
			-scrollbars 	=> "e", 
			-sticky         => 'ns',
			-width			=> 400,
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
		-background  	=> $var->{_my_black},
		-relief      	=> 'groove',

	       );
	       		#-width          => '1',

 	$parameter_values_button_frame    = $parameters_pane->Frame(
		-borderwidth 	=> $var->{_one_pixel_borderwidth}, 
		-background  	=> $var->{_my_purple},

		-relief      	=> 'groove',
	       );
		#-width          => '10',
 	$parameter_values_frame   	= $parameters_pane->Frame(
		-borderwidth 	=> $var->{_one_pixel_borderwidth}, 
		-background  	=> $var->{_my_purple},

		-relief      	=> 'groove',
	       );
	       		#-width          => '200',

=head2 Initialize 

  Initially, checkbutton widgets and values 
  are green ("on") or red ("off"), and
  Labels and Entry Widgets are made blank.

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
                	-height 			=> 3,
		   			-font   			=> $arial,
		   			-foreground     	=> $var->{_my_white},
					-background     	=> $var->{_my_black},
                  );
 	$TkPl_SU->{_message} 	= $message;
 	 # test $TkPl_SU->{_message}    ->insert('end', "This is some normal text\n");


=head2 workflow_control_frame

 on far right of work frame
 contains scrolled flow listboxes

=cut
 
	$flow_control_frame     = $work_frame->Frame(
                    	   	-borderwidth 	=> $var->{_no_borderwidth}, 
                    	   	-relief 	 	=> 'groove',
                    	   	-width       	=> '250',
		    	   			-background  	=> 'pink',
		           			);

 
=head2 workflow_control_frame

 two vertically stacked frames 
 each holding two 'Fs

=cut

	my $flow_control_frame_top_row     = $flow_control_frame->Frame(
                    	   	-borderwidth 	=> $var->{_no_borderwidth}, 
                    	   	-relief 	 	=> 'groove',
                    	   	-width       	=> '400',
		    	   			-height			=> '150',
		    	   			-background  	=> 'purple',
		           			);
 
	my $flow_control_frame_bottom_row     = $flow_control_frame->Frame(
                    	   	-borderwidth 	=> $var->{_no_borderwidth}, 
                    	   	-relief 	 	=> 'groove',
                    	   	-width       	=> '400',
                    	   	-height  		=> '150',
		    	   			-background  	=> 'purple',
		           			);

=head2 workflow_control_frame

 on far right of work frame

=cut

 	$flow_listbox_l	= $flow_control_frame_top_row->Scrolled(
		       	   			"Listbox", 
						-scrollbars			=> "osoe", 
						-height 			=> 0, 
						-width       		=> $var->{_ten_characters},
						-selectmode  		=> "single",
						-borderwidth   		=> $var->{_one_pixel_borderwidth},
						-foreground     	=> $var->{_my_black},
						-background     	=> $var->{_my_light_grey},
						-selectforeground 	=> $var->{_my_white},
						-selectbackground 	=> $var->{_my_dark_grey},						
						-state				=> 'disabled',
                      	   );

 	$flow_listbox_r 	= $flow_control_frame_top_row->Scrolled(
		       	   			"Listbox", 
						-scrollbars 		=> "osoe", 
						-height				=> 0, 
						-width       		=> $var->{_ten_characters},
						-selectmode  		=> "single",
						-borderwidth   		=> $var->{_one_pixel_borderwidth},
						-foreground     	=> $var->{_my_black},
						-background     	=> $var->{_my_pink},
						-selectforeground	=> $var->{_my_white},
						-selectbackground 	=> $var->{_my_light_green},
						-state				=> 'disabled',
                      	   );

 	$flow_listbox_sw 	= $flow_control_frame_bottom_row->Scrolled(
		       	   			"Listbox", 
						-scrollbars 		=> "osoe", 
						-height				=> 0, 
						-width       		=> $var->{_ten_characters},
						-selectmode  		=> "single",
						-borderwidth   		=> $var->{_one_pixel_borderwidth},
						-foreground     	=> $var->{_my_black},
						-background     	=> $var->{_my_light_green},
						-selectforeground	=> $var->{_my_white},
						-selectbackground 	=> $var->{_my_pink},
						-state				=> 'disabled',
                      	   );

 	$flow_listbox_se 	= $flow_control_frame_bottom_row->Scrolled(
		       	   			"Listbox", 
						-scrollbars 		=> "osoe", 
						-height				=> 0,
						-width       		=> $var->{_ten_characters},
						-selectmode  		=> "single",
						-borderwidth   		=> $var->{_one_pixel_borderwidth},
						-foreground     	=> $var->{_my_black},
						-background     	=> $var->{_my_light_blue},
						-selectforeground	=> $var->{_my_white},
						-selectbackground 	=> $var->{_my_pink},
						-state				=> 'disabled',
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
 	$top_titles_frame    ->pack(
	                   		-side 	=> "top",
                           	-fill 	=> 'x'
                          	);
                          	                          	 
 	$side_menu_frame    ->pack(
	                 		-side 	=> "left",
                           	-fill 	=> "both"
                          	);                         	

	$superflow_select	->pack(
                  			-side	=> "left",
			    			-fill   => 'y'
                            );
                            
   	$file_menubutton	->pack(
                            -side  	=> "top",
			    			-fill   => 'x'
                         	);
   	$run_button 	      ->pack(
                            -side  	=> "top",
			    			-fill   => 'x',
                            );                              
   	$save_button	      ->pack(
                            -side  	=> "top",
			    			-fill   => 'x',
                            );                                             
   	$check_code_button	    ->pack(
                            -side  	=> "top",
			    			-fill   => 'x',
                            );      
    # within top_titles_frame                    	
	$add2flow_button_grey->pack(
							-side  	=> "left",
                            );
  	$add2flow_button_pink->pack(
							-side  	=> "left",
                            );            
	$add2flow_button_green->pack(
							-side  	=> "left",
                            );
    $add2flow_button_blue	->pack(
							-side  	=> "left",
                            );                  
 	$delete_from_flow_button->pack(
                    		-side 	=> "right",
                   			);                        
    $top_titles_label  	->pack(	
							-side  	=> "left",
                            );    

=pod
	work frame contains, left-to-right
  	a sunix_frame , (orange)
	a parameters_pane,
	a flow frame (yellow)
	and four listboxes contained in a module-sequences frame on the far right
	The side menu frame is to its far left.
	
=cut	          

   $message              	->pack(
                           	-side    => "bottom",
                           	-fill    => 'x',
   							);
  
    $work_frame				->pack(
                           	-side 	=> "left",
                           	-fill 	=> "y",
    						);
 	$sunix_frame			->pack(
                           	-side 	=> "left",
                           	-fill 	=> "y",
		          			);
	$sunix_listbox			->pack(
                           		-side 	=> "left",
                           		-fill 	=> "y",
 							);   						

      
    $parameters_pane		->pack(
                           	-side => "left",
                           	-fill => "y",
                           	);                 	
	$parameter_names_frame	->pack(
                           		-side => "left",
    							-fill => "y",                         
		          			);
	$parameter_values_button_frame	->pack(
                           		-side => "left",
  								-fill => "y",                         
   		          			);
	$parameter_values_frame ->pack(
								-side  => "left",
								-fill => "x",
		          			);

	$flow_control_frame		->pack(
                          		-side 	=> "top",
                          		-fill 	=> "both",
                           		-expand => 1,
    						);
	$flow_control_frame_top_row	->pack(
                         		-side 	=> "top",
     	                 		-fill 	=> "both", 
     	                 		-expand => 1,                   
		          			); 	          
	$flow_control_frame_bottom_row	->pack(
	                         	-side 	=> "top",
	                         	-fill 	=> "both",
	                         	-expand => 1,
								);

	$flow_listbox_l		->pack(
                           -side 	=> "left",
                           -fill 	=> "y",
		          );

 	$flow_listbox_r		->pack(
                           -side => "left",
                           -fill 	=> "y",
                         );
                          
	$flow_listbox_sw	->pack(
                           -side => "left",
                           -fill => "y",
                         );
                            
	$flow_listbox_se	->pack(
                            -fill => "y",
                            -side => "left",
                          );
                                               
	
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
    find out which prior widget invoked the FileDialog_button
    For example, was it an entry button?

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
							 $whereami->in_gui();

=cut

sub FileDialog_button {

	my ($option_sref) = @_;
	my $widget_type;
	
	my $message          	= $L_SU_messages->null_button(0);
 	$TkPl_SU->{_message}	->delete("1.0",'end');
 	$TkPl_SU->{_message}	->insert('end', $message);

	$TkPl_SU->{_FileDialog_option} = $$option_sref;

				 
				 # print("1. main,FileDialog_button, option=$$option_sref \n");
				 # Select is for pre-exisiting data sets, 
				 # seen in the GUI as "File/Data"
	if ($$option_sref eq 'Select') {
   		private_conditions   -> set4FileDialog_select_start();
   				# if an appropriate entry widget is first selected, ie. Entry
    			# get index of entry button pressed 
				# find out which entry button has been chosen
				# confirm that it IS the file button
				# TODO determine the required file type and file path
				# TODO from the *_spec.pm file for the particular program in the flow.
				# print("main,FileDialog_button pressed\n");
						    
						    
		$widget_type		= $whereami->widget_type($parameter_values_frame);
	 				   # print("main  FileDialog_button selected widget type is = $widget_type	\n");

		if ($widget_type eq 'Entry' ) {
				     
				    # print("1. main,FileDialog_button, selected widget_type=$widget_type \n");

   			my $selected_Entry_widget 	= $parameter_values_frame->focusCurrent;
			$param_widgets				->set_entry_button_chosen_widget($selected_Entry_widget);
					  # print("2. main  FileDialog_button, selected_Entry_widget: $selected_Entry_widget\n");
			$TkPl_SU->{_parameter_value_index} 	= $param_widgets->get_entry_button_chosen_index();
							     # print("main,FileDialog_button,selection_Entry_widget HASH = $selected_Entry_widget\n");
							     # print("main,FileDialog_button, parameter_value_index= $TkPl_SU->{_parameter_value_index}\n");

				if ($TkPl_SU->{_parameter_value_index} >= 0) { # for additional certainty; but is it needed?
							     # print("main,FileDialog_button, parameter_value_index= $TkPl_SU->{_parameter_value_index}\n");
					$TkPl_SU->{_entry_button_label} 	= $param_widgets->get_label4entry_button_chosen();
							     # print("main,FileDialog_button,entry_button_label = $TkPl_SU->{_entry_button_label}\n");
					$iFile 				-> set_entry($TkPl_SU);
					$iFile 				-> set_prog_name($TkPl_SU);
					$TkPl_SU->{_path} 	= $iFile->get_Select_path();
  					FileDialog();
  					FileDialog_close();
				} 
		} elsif  ($widget_type eq 'MainWindow'){  # opening random file
			$message          	= $L_SU_messages->FileDialog_button(0);
	
 	  		$TkPl_SU->{_message}->delete("1.0",'end');
 	  		$TkPl_SU->{_message}->insert('end', $message);
		}

   		private_conditions   -> set4FileDialog_select_end();
	}

			# Open is for perl files
	if ($$option_sref eq 'Open') {
   		private_conditions  -> set4FileDialog_open_start();
		$widget_type		= $whereami->widget_type($parameter_values_frame);
				 		# print("2. main,FileDialog_button, option=$$option_sref \n");
	 				   	# print("2.main  FileDialog_button selected widget type is = $widget_type	\n");
							    print("main,FileDialog_button,entry_button_label = $TkPl_SU->{_entry_button_label}\n");
			if  ($widget_type eq 'MainWindow'){  # opening a random file

				$TkPl_SU->{_path} 	= $iFile->get_Open_path();
  				FileDialog();
  				FileDialog_close();

			} else {

				$message          		= $L_SU_messages->FileDialog_button(0);
 	  			$TkPl_SU->{_message}	->delete("1.0",'end');
 	    		$TkPl_SU->{_message}    ->insert('end', $message);

			}

   		private_conditions   -> set4FileDialog_open_end();
	}
							# Only flows can be saved
	if ($$option_sref eq 'SaveAs') {
   		private_conditions   -> set4FileDialog_saveas_start();

    	if($TkPl_SU->{_is_flow_listbox_l} 	|| 
			$TkPl_SU->{_is_flow_listbox_r} 	|| 
			$widget_type eq 'Text' 			|| 
			$widget_type eq 'DragDrop' 		|| 
			$widget_type eq 'MainWindow' ) {

			$widget_type			= $whereami->widget_type($parameter_values_frame);

			if ($widget_type eq 'Entry') {
							# always ~/pl
				$TkPl_SU->{_path} 	= $iFile->get_SaveAs_path(); 
				FileDialog();
  				FileDialog_close();

			} else  {  # inactive flow
				$message          	= $L_SU_messages->FileDialog_button(0);
 	  			$TkPl_SU->{_message}->delete("1.0",'end');
 	  			$TkPl_SU->{_message}->insert('end', $message);
			}

		} else {

			$message          		= $L_SU_messages->FileDialog_button(1);
 	  		$TkPl_SU->{_message}	->delete("1.0",'end');
 	    	$TkPl_SU->{_message}    ->insert('end', $message);

		}

   		private_conditions   -> set4FileDialog_saveas_end();
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

	Cancel returns undefined file name

=cut

sub FileDialog {

	my $self = @_;

   	use Tk::JFileDialog;
    
   	my $mytitle 		= $TkPl_SU->{_FileDialog_option};
   	my ($create) 		= 0;
   	my $fileDialog;

	$fileDialog = $mw->JFileDialog(
		-Title			=> $mytitle,
		-Path 			=> $TkPl_SU->{_path},
		-History		=> 12,
		-HistDeleteOk 	=> 1,
		-HistUsePath	=> 1,
		-HistFile 		=> "./.FileHistory.txt",
		-PathFile 		=> "./.Bookmarks.txt",
		-Create 		=> 1
               );
				# results from interactive file selection
				 
  	$TkPl_SU->{_selected_file_name} = $fileDialog->Show();
	$TkPl_SU->{_last_path_touched} 	= $fileDialog->cget('-Path');
					   # print("main,FileDialog,last path is 
					   # $TkPl_SU->{_last_path_touched} \n");
					   # print("main,FileDialog,selected_file_name 
					   # is $TkPl_SU->{_selected_file_name} \n");
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
	my $self 			= @_;
	my @fields;
	my $full_path_name;
	my $option 			= $TkPl_SU->{_FileDialog_option};
	$full_path_name 	= $TkPl_SU->{_selected_file_name};

	if ($full_path_name ) {
  		@fields 							= split (/\//,$full_path_name);
		$TkPl_SU->{_is_selected_file_name}	= $true;
	} else {
		print("FileDialog_close,Cancelled. No output flow name selected\n");
	}	
		
						# Select is used to open a data file
						# flows and superflow selections are allowed
	if ($option eq  'Select') {
		$decisions			->set4FileDialog_select($TkPl_SU);
		my $pre_req_ok 		= $decisions->get4FileDialog_select();
			 		   	  # print("1. main,FileDialog_close,pre_req_ok= $pre_req_ok \n");
			 		   
   		if ( $pre_req_ok ) { 	

						# both flows and superflows require the following    
  			my $current_index             		= $TkPl_SU->{_parameter_value_index};
			   		  	print("main,FileDialog_close,Select,current parameter index $current_index\n");
      		@{$TkPl_SU->{_check_buttons_settings_aref}}[$current_index] 
											= $on; 

			if( $TkPl_SU->{_selected_file_name}) {
  							 # print("main,FileDialog_close, fields= $fields[-1]\n");
  							# remove *.su suffix
  				$TkPl_SU->{_selected_file_name} 	= $control->su_data_name(\$fields[-1]);
			} else {
  			 			# print("main,FileDialog_close No file was selected\n");
			 			# print("main,FileDialog_close ,last path touched was 
			 			# $TkPl_SU->{_last_path_touched}\n") ;
			}
			 		   	# print("2. main,FileDialog_close,pre_req_ok= $pre_req_ok \n");
						#  superflows require the following   
			if ( $TkPl_SU->{_is_superflow_select_button} ) {
			 		   	 # print(" main,FileDialog_close,is_superflow_select_button=
			 		   	 # $TkPl_SU->{_is_superflow_select_button}  \n");

			   		     # print("main,FileDialog_close,prog_name=
			   		     # ${$TkPl_SU->{_prog_name}}\n");
			   		     	
						# only ProjectVariables (a superflow) which does 
						# not have files/only directories requires the following
    			if( ${$TkPl_SU->{_prog_name}} eq $superflow_names->{_ProjectVariables} ) {

	    		@{$TkPl_SU->{_values_aref}}[$current_index] = 	$TkPl_SU->{_last_path_touched}; 
					 	 # print("main,FileDialog_close,last path is $TkPl_SU->{_last_path_touched} \n");
				}
			   		   # print("main,FileDialog_close,superflow, selected_file_name=$TkPl_SU->{_selected_file_name}\n");
			   		   
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

      		#if(@{$TkPl_SU->{_values_aref}}[$current_index]) { # overkill? 
					@{$TkPl_SU->{_values_aref}}[$current_index]
							= $TkPl_SU->{_selected_file_name};  
			 		# print("main,FileDialog_close,selected_file_name  $TkPl_SU->{_selected_file_name} \n");
			#}
					# flows will be updated via flow_select, which is activated 
					# in iFile->close()
					# reset focus on item last touched in flow 
					# find which listbox and which listbox_item 
					# change the Entry Value in param widgets
					# update Entry Value
   		 			# update entry in superflow OR
   		 			# go on to flow_select and update those parameters
				$iFile->close($TkPl_SU);
			}
   		#private_conditions->set4FileDialog_select_start(); #needed?
		} # if prereq_OK
	}

				# Open means that a previous perl file is being opened
				# superflows and flows are not allowed to open perl files
	if ( $option eq  'Open' ) { 
		$decisions			->set4FileDialog_open($TkPl_SU);
		my $pre_req_ok 		= $decisions->get4FileDialog_open();
		if ( $pre_req_ok ) {
				my @first_name;
			 		   	 	  # print("2. main,FileDialog_close,Open,pre_req_ok= $pre_req_ok \n");
				# $TkPl_SU->{_path} 				= $iFile->get_path();
  							  # print("main,fields= $fields[-1]\n");
  							  # 	remove suffix from selected file name
  				$control							->set_file_name(\$fields[-1]);
  				$control							->set_suffix();
  				$control							->set_first_name();
  				my $suffix 							= $control->get_suffix();
  				my $first_name						= $control->get_first_name();
  							   	# print("main,FileDialog_close, open,suffix: $suffix\n");

							#is this a superflow configuration file?
				if($suffix ne '') {
					if( $suffix eq 'config') {
						$TkPl_SU->{_prog_name}  	= $iFile->get_prog_name_s($first_name);
						$first_name[0] 				= $TkPl_SU->{_prog_name}; # historical

							# run, if superflow
						if($TkPl_SU->{_prog_name}) {
  							  # print("main,FileDialog_close, open,prog_name: $first_name[0]\n");
 								superflow_select(\$first_name[0]) ; 
						} else {
							my $message          	= $L_SU_messages->FileDialog_close(0);
 	  						$TkPl_SU->{_message}->delete("1.0",'end');
 	    					$TkPl_SU->{_message}    ->insert('end', $message);
						}
							#$TkPl_SU->{_last_path_touched} 	= $fileDialog->cget('-Path');
							
						} elsif( $suffix eq 'pl')  {
							my $message = $L_SU_messages->FileDialog_close(1);
 	  						$TkPl_SU->{_message}	->delete("1.0",'end');
 	    					$TkPl_SU->{_message}    ->insert('end', $message);

						} else {
							my $message = $L_SU_messages->FileDialog_close(0);
 	  						$TkPl_SU->{_message}	->delete("1.0",'end');
 	    					$TkPl_SU->{_message}    ->insert('end', $message);

						}	# if config
				} else {
					my $message = $L_SU_messages->FileDialog_close(0);
 	  				$TkPl_SU->{_message}	->delete("1.0",'end');
 	    			$TkPl_SU->{_message}    ->insert('end', $message);

				}	# if suffix is initialized

		} else { 
					my $message = $L_SU_messages->FileDialog_close(2);
 	  				$TkPl_SU->{_message}	->delete("1.0",'end');
 	    			$TkPl_SU->{_message}    ->insert('end', $message);

		}			#if pre_req_ok 

   					#private_conditions->set4FileDialog_open_start(); #needed?
	} 				# if open
					# superflows and flows are not allowed to open perl files 
					# TODO flows will be allowed once a parser is built



					# SaveAs is used to save a perl file
					# flows are allowed but
					# superflows are not allowed
	if ( $option eq  'SaveAs' ) {	
		$decisions			->set4FileDialog_saveas($TkPl_SU);
		my $pre_req_ok 		= $decisions->get4FileDialog_saveas();
		
		if ( $pre_req_ok ) {
			private_conditions->set4FileDialog_saveas_start();
			 		   	 		# print("3. main FileDialog_close,SaveAs,
			 		   	 		# pre_req_ok= $pre_req_ok \n");
  							 	# remove suffix from selected file name
  			$control							->set_file_name(\$fields[-1]);
  			$control							->set_suffix();
  			$control							->set_first_name();
  			my $suffix 							= $control->get_suffix();
  			my $first_name						= $control->get_first_name();
			$TkPl_SU->{_flow_name_out}          = $fields[-1];
  							   	 # print("main,FileDialog_close, SaveAs,
  							   	 # suffix: $suffix\n");
  							   	 # print("main,FileDialog_close, SaveAs,
  							   	 # first_name: $first_name\n");
  							   	 # print("main,FileDialog_close, flow name out: 
  							   	 #  $TkPl_SU->{_flow_name_out}\n");
								# go save the file
			save_button();
			private_conditions->set4FileDialog_saveas_end();
		}


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

		# print("2.main,drag\n");
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
							 # print(" main,drop, destination index = $TkPl_SU->{_last_flow_index_touched}\n");

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


# 
# 


=head2 sub set_new_flow

  after reading a flow file
  there are progam names, values, param names, checkbuttons on and off
  Store this new flow in another namespace

  input is hash from main: $TkPl_SU
  do not change has reference contents at all

=cut
=pod

# in param_flow->set_box_number(1);
# in param_flow->set_box_number(2);
# in param_flow->set_box_number(3);
# in param_flow->set_box_number(4);

 sub set_new_flow {	
 	my (@self,$hash_ref) = @_;	
 	my $TkPl_SU = $hash_ref;
 	private_set_prog_versions($TkPl_SU);
	privat_set_prog_names;
	private_set_param_values_aref2($TkPl_SU->{_values_aref});
    private_set_param_names_aref2($TkPl_SU->{_names_aref});
	private_set_param_checkbuttons_aref2($TkPl_SU->{_check_buttons_settings_aref});
	return();
 }

	

=cut




=head2 sub add2flow_button 


=cut

sub add2flow_button {
	my $last_item;
  	my $here; 
  	
  	my $message          	= $L_SU_messages->null_button(0);
 	$TkPl_SU->{_message}	->delete("1.0",'end');
 	$TkPl_SU->{_message}	->insert('end', $message);

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
   	$TkPl_SU->{_param_sunix_first_idx}  		= $param_sunix->first_idx(); # first index = 0
   	$TkPl_SU->{_param_sunix_length}  			= $param_sunix->length(); # # values not index 

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
   	
   				# add a single_program to the growing stack
				# store one program name, its associated parameters and their values
				# as well as the ckecbuttons in another namespace

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
						 print("main,stack_flow,values= @{$TkPl_SU->{_values_aref}}\n");

=cut


sub stack_flow {
		# store flow parameters in another namespace
  $param_flow		->stack_flow_item($TkPl_SU->{_prog_name});
  $param_flow		->stack_values_aref2($TkPl_SU->{_values_aref});
  $param_flow		->stack_names_aref2($TkPl_SU->{_names_aref});
  $param_flow		->stack_checkbuttons_aref2($TkPl_SU->{_check_buttons_settings_aref});
  						 print("main,stack_flow,last left listbox flow program touched had index = $TkPl_SU->{_last_flow_index_touched}\n");
						 print("main,stack_flow,values= @{$TkPl_SU->{_values_aref}}\n");

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

=cut

sub delete_from_flow_button {

	my $self = @_;

	my $message          	= $L_SU_messages->null_button(0);
 	$TkPl_SU->{_message}	->delete("1.0",'end');
 	$TkPl_SU->{_message}	->insert('end', $message);

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
      				 #  Run and Save button
     		$flow_widgets->delete_selection($flow_listbox_l);

							# the last program that was touched is cancelled out
   			$TkPl_SU->{_last_flow_index_touched} 	= -1;

							#  print("main,delete_from_flow_button,
							#  last left flow program touched had index 
							#  = $TkPl_SU->{_last_flow_index_touched}\n");

							# delete stored programs and their parameters
   							# delete_from_stored_flows(); 
  			my $index2delete 	= $flow_widgets->get_index2delete();
  					 		# print("main,delete_from_stored,index2delete:$index2delete\n");
  					 
  			$param_flow		->delete_selection($index2delete);

   							# collect and store latest program versions from changed list 
   			stack_versions();
			
			private_conditions->set4last_delete_from_flow_button();

        					# location within GUI after last item is deleted 
        	private_conditions->reset();
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
  					# are stored in param_widgets at any one time			
  					# get parameters from storage
  			my $next_idx_selected_after_deletion = $index2delete - 1;	
            if($next_idx_selected_after_deletion == -1) { $next_idx_selected_after_deletion = 0} # NOT < 0
  					  		# print("2. main,delete_from_flow_button,indexafter_deletion:
  					  		# $next_idx_selected_after_deletion\n");

   		 	$param_flow		-> set_flow_index($next_idx_selected_after_deletion);
 			$TkPl_SU->{_names_aref} 	= $param_flow->get_names_aref();

  							 # print("2. main, delete_from_flow_button,parameter names 
  							 # is @{$TkPl_SU->{_names_aref}}\n");
 			$TkPl_SU->{_values_aref} 	=	$param_flow->get_values_aref();

  				 			 # print("3. main, delete_from_flow_button,parameter values 
  				 			 # is @{$TkPl_SU->{_values_aref}}\n");
 			$TkPl_SU->{_check_buttons_settings_aref} 
										=  $param_flow->get_check_buttons_settings();

  				 			 # print("4. main, delete_from_flow_button, 
  				 			 # check_buttons_settings no changes, 
  				 			 # @{$TkPl_SU->{_check_buttons_settings_aref}}, index;$index\n#");
  				 			
 				 			# get stored first index and num of items 
 			$TkPl_SU->{_param_flow_first_idx}	= $param_flow->first_idx();
 			$TkPl_SU->{_param_flow_length}   	= $param_flow->length();
 			$TkPl_SU->{_prog_name}				= $param_widgets->get_current_program(\$flow_listbox_l);
 			$param_widgets				 		->set_current_program($TkPl_SU->{_prog_name});

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
 
 Let help decide whether it is a superflow
 or a user-created flow
 
 Show a window with the perldoc to the user
 

=cut 

sub help {
	my $self = @_;
   	use help;
   	my $help = new help();  	
   	$help->set_name($TkPl_SU->{_prog_name});
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

=cut 

sub sunix_select {

   	my $self = @_;
   	
   	my $message          	= $L_SU_messages->null_button(0);
 	$TkPl_SU->{_message}	->delete("1.0",'end');
 	$TkPl_SU->{_message}	->insert('end', $message);

        # location within GUI
    private_conditions			->set4start_of_sunix_select;
   	$whereami					->set4sunix_listbox();
   	my $here 					= $whereami->get4sunix_listbox();

        # get program name
   	$TkPl_SU->{_prog_name} 				= $param_widgets->get_current_program(\$sunix_listbox);
				# print("main, sunix_select, program name is ${$TkPl_SU->{_prog_name}}\n");
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
   	$param_widgets		->set_current_program($TkPl_SU->{_prog_name});

						 # print("main, sunix_select, $TkPl_SU->{_is_sunix_listbox}\n");
   	$param_widgets       ->set_location_in_gui($here);
   	$param_widgets		->redisplay_labels();
   	$param_widgets		->redisplay_values();
   	$param_widgets		->redisplay_check_buttons();

    private_conditions	->set4end_of_sunix_select() ;

   	return();
}

=head2  local_check4changes

	assume now that selection of a flow item will always change a previously existing
	set of flow parameters, That is that a prior program must have been touched
	if ($param_widgets->get_entry_change_status && $TkPl_SU->{_last_flow_index_touched} >= 0) {

=cut 

sub local_check4changes {
	my $self = @_;

	if ($TkPl_SU->{_last_flow_index_touched} >= 0) {  # <-1 does exist

		my $last_idx_chng =$TkPl_SU->{_last_flow_index_touched} ;

	 					      #  print("main,local_check4changes,
	 					      # last changed entry index was $last_idx_chng\n");
  							  # print("main, local_check4changes program name is 
  							  # ${$TkPl_SU->{_prog_name}}\n");
  							  # the chekbuttons, values and names of only the last program used 
  							  # is stored in param_widgets at any one time			
		$TkPl_SU->{_values_aref} 				= $param_widgets	->get_values_aref();
		$TkPl_SU->{_names_aref} 				= $param_widgets	->get_labels_aref();
		$TkPl_SU->{_check_buttons_settings_aref}= $param_widgets	->get_check_buttons_aref();

  							# print("main,flow_select,changed values_aref: @{$TkPl_SU->{_values_aref}}\n");
  							# print("main,local_changes4changes,changed names_aref: @{$TkPl_SU->{_names_aref}}\n");
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
	
	my $message          	= $L_SU_messages->null_button(0);
 	$TkPl_SU->{_message}	->delete("1.0",'end');
 	$TkPl_SU->{_message}	->insert('end', $message);

				#  independently set conditions to make both flow boxes available
				#  TODO place which listbox (left or right) was chosen in private_conditions

    private_conditions->set4start_of_flow_select();       
	$decisions		  ->set4flow_select($TkPl_SU);
	my $pre_req_ok 	  = $decisions->get4flow_select();
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
		                     # find out which program was previously touched
		                     # assume all prior programs touched have
		                     # modified parameters 
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
 		$param_widgets				 		->set_current_program($TkPl_SU->{_prog_name});

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
	
	my $message          	= $L_SU_messages->null_button(0);
 	$TkPl_SU->{_message}	->delete("1.0",'end');
 	$TkPl_SU->{_message}	->insert('end', $message);
 	
	private_conditions		->set4run_button_start();      
	$decisions		      	->set4run_select($TkPl_SU);
	my $pre_req_ok 	  	  	= $decisions->get4run_select();
	$whereami				->in_gui();
	
	# must have saved files already
	if ($pre_req_ok) {
				# for saved superflow configuration files
		if( $TkPl_SU->{_is_superflow_select_button} ) {
    	 		 # print("main,run_button,program name is ${$TkPl_SU->{_prog_name}}\n"); 
    		my $run_name 			= $name->get_alias_superflow_names($TkPl_SU->{_prog_name});
  			system $global_libs->{_superflows}.$run_name; 	
  				 # print("main,run_button, running: $global_libs->{_superflows}$run_name\n");
		}
				# for saved regular flows 
    	if( $TkPl_SU->{_is_flow_listbox_l} || 
	    	$TkPl_SU->{_is_flow_listbox_r} ) {
    		# print("main,run_button,program name is ${$TkPl_SU->{_prog_name}}\n"); 
    		# print("main, 1. run button, checking accuracy of inserted values\n");
    		
			# TODO: pre-run check
    		# $control	->set_prog_param_labels_aref2($TkPl_SU);
 			# $control	->set_prog_param_values_aref2($TkPl_SU);
 			# $control	->set_prog_names_aref($TkPl_SU);
 			# $control	->set_items_versions_aref($TkPl_SU);
 			# my $ok2run	= $control->get_conditions();
 			
 			my $ok2run = $true;
 			
 			if ($ok2run) {
 				my $run_name = $TkPl_SU->{_flow_name_out};
				# print("main,run_button, running: $run_name\n");
  				system ("perl $run_name");
 			}

		}
			
		private_conditions->set4run_button(); 
	} else {
			my $message          	= $L_SU_messages->run_button(0);
 	  		$TkPl_SU->{_message}	->delete("1.0",'end');
 	  		$TkPl_SU->{_message}	->insert('end', $message);
	}
	
 	private_conditions->set4run_button_end();
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
 	
 	my $message          	= $L_SU_messages->null_button(0);
 	$TkPl_SU->{_message}	->delete("1.0",'end');
 	$TkPl_SU->{_message}	->insert('end', $message);

        		       	# local location within GUI   
	private_conditions			->set4superflow_select();

						# set location in gui
	$whereami					->set4superflow_select_button();

   	     				# get and set program name (scalar ref), including alias
  	$TkPl_SU->{_prog_name} 		= $superflow_name_sref;
						# print("main,superflow_select,prog=${$TkPl_SU->{_prog_name}}\n");
   	
   	$config_superflows   		->set_program_name($TkPl_SU->{_prog_name});
        
   	     				# parameter names from superflow configuration file
   	$TkPl_SU->{_names_aref}  	= $config_superflows->get_names();
						#  print("main,superflow_select,prog=@{$TkPl_SU->{_names_aref}}\n");

     					# parameter values from superflow configuration file
   	$TkPl_SU->{_values_aref} 	= $config_superflows->get_values();
						 #  print("main,superflow_select,valu=@{$TkPl_SU->{_values_aref}}\n");
   	
   	$TkPl_SU->{_check_buttons_settings_aref}  	= $config_superflows->get_check_buttons_settings();
						 # print("main,superflow_select,chkb=@{$TkPl_SU->{_check_buttons_settings_aref}}\n");

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
						
 	$param_widgets		->set_current_program($TkPl_SU->{_prog_name});
						
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
 	my ($self) 				= @_;

	my $message          	= $L_SU_messages->null_button(0);
 	$TkPl_SU->{_message}	->delete("1.0",'end');
 	$TkPl_SU->{_message}	->insert('end', $message); 	
 	
	private_conditions	->set4start_of_check_code_button();
	
        	# location within GUI   
	my $widget_type		= $whereami->widget_type($parameter_values_frame);
			  # print("main,check_code_button,widget_type = $widget_type\n");
			 

			# for superflows only
			# print("main,check_code_button,is_superflow_select_button:$TkPl_SU->{_is_superflow_select_button}\n");
    if($TkPl_SU->{_is_superflow_select_button}) {
#		$config_superflows	->save($TkPl_SU);
#		private_conditions	->set4_save_button();
#		
#		# for flow but only if activated
	} elsif ( ($TkPl_SU->{_is_flow_listbox_l} || 
	    $TkPl_SU->{_is_flow_listbox_r}) &&
	    $widget_type eq 'Entry' )  {		

			# consider empty case	
#		if( !($TkPl_SU->{_flow_name_out}) ||
#			$TkPl_SU->{_flow_name_out} eq '') {
#
#			$message          	= $L_SU_messages->save_button(1);
# 	  		$TkPl_SU->{_message}->delete("1.0",'end');
# 	  		$TkPl_SU->{_message}->insert('end', $message);
#
#		} else {  # good case
#			# print("1. save_button, saving flow: $TkPl_SU->{_flow_name_out}\n");
#    	}
    	
		local_check4changes(); 	
		$param_flow->set_good_values;
		$param_flow->set_good_labels;
		$TkPl_SU->{_good_labels_aref2}	= $param_flow->get_good_labels_aref2;
		$TkPl_SU->{_items_versions_aref}= $param_flow->get_flow_items_version_aref;
		$TkPl_SU->{_good_values_aref2} 	= $param_flow->get_good_values_aref2;
		$TkPl_SU->{_prog_names_aref} 	= $param_flow->get_flow_prog_names_aref;
		
				# print("main,check_code_button, program names are: @{$TkPl_SU->{_prog_names_aref}} \n");
		my $length = scalar @{$TkPl_SU->{_prog_names_aref}};
				# print("main,check_code_button,There is/are $length program(s) in flow\n");
		
		for (my $prog_num = 0; $prog_num < $length; $prog_num++ ) {
				# print("main,check_code_button, program # $prog_num in flow is
			  	# @{$TkPl_SU->{_prog_names_aref}}[$prog_num]\n");
			# my $prog_name  = @{$TkPl_SU->{_prog_names_aref}}[$prog_num];
			# require ($prog_name);
			# $prog_name->set_code_values($TkPl_SU->{_good_values_aref2});
			# $prog_name->get_code_suggestions();
		}

# 		$files_LSU	->set_prog_param_labels_aref2($TkPl_SU);
# 		$files_LSU	->set_prog_param_values_aref2($TkPl_SU);
# 		$files_LSU	->set_prog_names_aref($TkPl_SU);
# 		$files_LSU	->set_items_versions_aref($TkPl_SU);
# 		$files_LSU	->set_data();
# 		$files_LSU	->set_message($TkPl_SU);
#		$files_LSU	->set2pl($TkPl_SU); # flows saved to PL_SEISMIC
#		$files_LSU	->save();
#		private_conditions	->set4_save_button();
#		
	} else { # if flow first needs a change for activation
#
#		$message          	= $L_SU_messages->check_code_button(0);
# 	  	$TkPl_SU->{_message}->delete("1.0",'end');
# 	  	$TkPl_SU->{_message}->insert('end', $message);
	}
	
	private_conditions	->set4end_of_check_code_button();
   	return();
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

=cut

sub save_button {
 	my ($self) 				= @_;
 	use save;
	use files_LSU;
 	my $save 				= new save();
 	my $files_LSU			= new files_LSU();
 	
	my $message          	= $L_SU_messages->null_button(0);
 	$TkPl_SU->{_message}	->delete("1.0",'end');
 	$TkPl_SU->{_message}	->insert('end', $message); 	
 	
	private_conditions	->set4start_of_save_button();
	
        	# location within GUI   
	my $widget_type		= $whereami->widget_type($parameter_values_frame);
			# print("main,save_button,widget_type = $widget_type\n");

			# for superflows only
			# print("main,save_button,is_superflow_select_button:$TkPl_SU->{_is_superflow_select_button}\n");
    if($TkPl_SU->{_is_superflow_select_button}) {
		$config_superflows	->save($TkPl_SU);
		private_conditions	->set4_save_button();
		
		# for flow but only if activated
	} elsif ( ($TkPl_SU->{_is_flow_listbox_l} || 
	    $TkPl_SU->{_is_flow_listbox_r}) &&
	    $widget_type eq 'Entry' )  {		

			# consider empty case	
		if( !($TkPl_SU->{_flow_name_out}) ||
			$TkPl_SU->{_flow_name_out} eq '') {

			$message          	= $L_SU_messages->save_button(1);
 	  		$TkPl_SU->{_message}->delete("1.0",'end');
 	  		$TkPl_SU->{_message}->insert('end', $message);

		} else {  # good case
			# print("1. save_button, saving flow: $TkPl_SU->{_flow_name_out}\n");
    	}
    	
		local_check4changes(); 	
		$param_flow->set_good_values;
		$param_flow->set_good_labels;
		$TkPl_SU->{_good_labels_aref2}	= $param_flow->get_good_labels_aref2;
		$TkPl_SU->{_items_versions_aref}= $param_flow->get_flow_items_version_aref;
		$TkPl_SU->{_good_values_aref2} 	= $param_flow->get_good_values_aref2;
		$TkPl_SU->{_prog_names_aref} 	= $param_flow->get_flow_prog_names_aref;

		 		# print("save_button,_prog_names_aref,
		 		# @{$TkPl_SU->{_prog_names_aref}}\n");
		# my $num_items4flow = scalar @{$TkPl_SU->{_good_labels_aref2}};

				 # for (my $i=0; $i < $num_items4flow; $i++ ) {
					# print("save_button,_good_labels_aref2,
				# @{@{$TkPl_SU->{_good_labels_aref2}}[$i]}\n");
				# }

				# for (my $i=0; $i < $num_items4flow; $i++ ) {
				#	print("save_button,_good_values_aref2,
				#	@{@{$TkPl_SU->{_good_values_aref2}}[$i]}\n");
				#}
				#   print("save_button,_prog_versions_aref,
				#   @{$TkPl_SU->{_items_versions_aref}}\n");

 		$files_LSU	->set_prog_param_labels_aref2($TkPl_SU);
 		$files_LSU	->set_prog_param_values_aref2($TkPl_SU);
 		$files_LSU	->set_prog_names_aref($TkPl_SU);
 		$files_LSU	->set_items_versions_aref($TkPl_SU);
 		$files_LSU	->set_data();
 		$files_LSU	->set_message($TkPl_SU);
		$files_LSU	->set2pl($TkPl_SU); # flows saved to PL_SEISMIC
		$files_LSU	->save();
		private_conditions	->set4_save_button();
		
	} else { # if flow first needs a change for activation

		$message          	= $L_SU_messages->save_button(0);
 	  	$TkPl_SU->{_message}->delete("1.0",'end');
 	  	$TkPl_SU->{_message}->insert('end', $message);
	}
	
	private_conditions	->set4end_of_save_button();
   	return();
}


=head2 package local_last

=cut

package local_last;  


=head2 sub set_flow_listbox_touched

=cut

sub set_flow_listbox_touched {
	my $self = @_;
	# TODO in future the program must keep track of which listbox was just chosen
   	$TkPl_SU->{_last_flow_listbox_touched} 		= 'flow_listbox_l';
    		  # print("main,local_last set_flow_listbox_touched left listbox = $TkPl_SU->{_last_flow_listbox_touched}\n");

	return();
}

=head2 sub set_flow_listbox_touched_w


=cut


sub set_flow_listbox_touched_w {
	my $self = @_;
	# TODO in future the program must keep track of which listbox was just chosen
   	$TkPl_SU->{_last_flow_listbox_touched_w} 	= $flow_listbox_l;	
    		  # print("main,local_last, set_flow_listbox_touched_w= $TkPl_SU->{_last_flow_listbox_touched_w}\n");

	return();
}

=head2


=cut


sub set_flow_index_touched {
	my ($self) = @_;

   		$TkPl_SU->{_last_flow_index_touched} 	= $flow_widgets->get_flow_selection($flow_listbox_l);
							  # print("1. main,local_last,last left listbox flow program touched had index = $TkPl_SU->{_last_flow_index_touched}\n");

	return();
}


package private_conditions;

=head2


=cut


sub reset {

	my $self = @_;

        		# location within GUI   
   	$TkPl_SU->{_is_add2flow_flow_button}	= $false;
   	$TkPl_SU->{_is_check_code_button}		= $false;
   	$TkPl_SU->{_is_delete_from_flow_button}	= $false;
   	$TkPl_SU->{_is_dragNdrop}				= $false;
   	$TkPl_SU->{_is_flow_listbox_l}			= $false;
   	$TkPl_SU->{_is_flow_listbox_r}			= $false;
    $TkPl_SU->{_is_open_file_button}		= $false;
    $TkPl_SU->{_is_select_file_button}		= $false;
    $TkPl_SU->{_is_saveas_file_button}		= $false;
   	$TkPl_SU->{_is_sunix_listbox}   		= $false;
	$TkPl_SU->{_is_new_listbox_selection} 	= $false;
# 	$TkPl_SU->{_is_sunix_module}   			= $false;
   	$TkPl_SU->{_is_superflow_select_button}	= $false;
   	$TkPl_SU->{_is_run_button}				= $false;
   	$TkPl_SU->{_is_save_button}				= $false;
    $TkPl_SU->{_is_moveNdrop_in_flow}       = $false;

}

=head2


=cut


sub  set4FileDialog_select_start {
	my $self = @_;
	#private_conditions->reset();
	 #  ERROR if private_conditions->reset() the param_widgets table is reset;
	 #  ERROR if private_conditions->reset() the 	 #  f 
    $TkPl_SU->{_is_select_file_button}		= $true;
    # print("main,private_conditions,set4FileDialog_select_start  $TkPl_SU->{_is_select_file_button} 	\n");
    #print("main,private_conditions,set4FileDialog_open_start,listbox_l listbox_r  $TkPl_SU->{_is_flow_listbox_l} 	$TkPl_SU->{_is_flow_listbox_r}\n");
 
	return();
}

=head2


=cut


sub  set4FileDialog_select_end {
	my $self = @_;
    $TkPl_SU->{_is_select_file_button}		= $false;
    # print("main,private_conditions,set4FileDialog_select_end  $TkPl_SU->{_is_select_file_button}\n");
    #print("main,private_conditions,set4FileDialog_open_start,listbox_l listbox_r  $TkPl_SU->{_is_flow_listbox_l} 	$TkPl_SU->{_is_flow_listbox_r}\n");
	
	return();
}

=head2


=cut

sub  set4FileDialog_open_start {
	my $self = @_;
	#private_conditions->reset();
	 #  ERROR if private_conditions->reset() the param_widgets table is reset;
    $TkPl_SU->{_is_open_file_button}		= $true;
    # print("main,private_conditions,set4FileDialog_open_start  $TkPl_SU->{_is_open_file_button}\n");
 
	return();
}

=head2


=cut


sub  set4FileDialog_open_end {
	my $self = @_;
    $TkPl_SU->{_is_open_file_button}		= $false;
    # print("main,private_conditions,set4FileDialog_open_end  $TkPl_SU->{_is_open_file_button}\n");
	
	return();
}


=head2


=cut


sub  set4FileDialog_saveas_start {
	my $self = @_;
	#private_conditions->reset();
	 					#  ERROR if private_conditions->reset() 
	 					#  the param_widgets table is reset; 	 
	 					
    $TkPl_SU->{_is_saveas_file_button}		= $true;
    					# print("main,private_conditions,set4FileDialog_saveas_start  
    					# $TkPl_SU->{_is_saveas_file_button}\n");
 
	return();
}

=head2


=cut


sub  set4FileDialog_saveas_end {
	my $self = @_;
    $TkPl_SU->{_is_saveas_file_button}					= $false;
    $TkPl_SU->{_has_used_saveas_file_button}			= $true;

						# clean path
    # $TkPl_SU->{_path}						= '';

    					# print("main,private_conditions,set4FileDialog_saveas_end  
    					# $TkPl_SU->{_is_saveas_file_button}\n");
	return();
}


=head2


=cut


sub set4start_of_check_code_button {
	my $self = @_;
	# private_conditions	->reset();
				  # print("1. main,local_configure,set4start_of_button,last left listbox flow program touched had index = $TkPl_SU->{_last_flow_index_touched}\n");
        		# location within GUI   
   	$TkPl_SU->{_is_check_code_button}			= $true;
   	$TkPl_SU->{_has_used_check_code_button}	= $false;

	return();

}

=head2


=cut


sub set4_check_code_button {
	my $self = @_;
	# private_conditions	->reset();
				  # print("1. main,local_configure,set4end_of_check_code_button,last left listbox flow program touched had index = $TkPl_SU->{_last_flow_index_touched}\n");
        		# location within GUI   
   	$TkPl_SU->{_has_used_check_code_button}			= $true;

	return();

}

=head2


=cut



sub set4end_of_check_code_button {
	my $self = @_;
	# private_conditions	->reset();
				  # print("1. main,local_configure,set4end_of_check_code_button,last left listbox flow program touched had index = $TkPl_SU->{_last_flow_index_touched}\n");
        		# location within GUI   
   	$TkPl_SU->{_is_check_code_button}			    	= $false;
	return();

}


=head2


=cut


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


=head2


=cut


sub set4start_of_save_button {
	my $self = @_;
	# private_conditions	->reset();
				  # print("1. main,local_configure,set4start_of_button,last left listbox flow program touched had index = $TkPl_SU->{_last_flow_index_touched}\n");
        		# location within GUI   
   	$TkPl_SU->{_is_save_button}			= $true;
   	$TkPl_SU->{_has_used_save_button}	= $false;

	return();

}

=head2


=cut


sub set4_save_button {
	my $self = @_;
	# private_conditions	->reset();
				  # print("1. main,local_configure,set4end_of_save_button,last left listbox flow program touched had index = $TkPl_SU->{_last_flow_index_touched}\n");
        		# location within GUI   
   	$TkPl_SU->{_has_used_save_button}			= $true;

	return();

}

=head2


=cut



sub set4end_of_save_button {
	my $self = @_;
	# private_conditions	->reset();
				  # print("1. main,local_configure,set4end_of_save_button,last left listbox flow program touched had index = $TkPl_SU->{_last_flow_index_touched}\n");
        		# location within GUI   
   	$TkPl_SU->{_is_save_button}			    	= $false;
	return();

}

=head2


=cut


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
  	$check_code_button						->configure(-state => 'normal',);

	return();

}

=head2


=cut


sub set4delete_from_flow_button {
	my $self = @_;
	# print("succeeded\n");
	private_conditions->reset();
        		# location within GUI on first clicking delete button
   	$TkPl_SU->{_is_delete_from_flow_button}	= $true;
   	$TkPl_SU->{_is_flow_listbox_l}			= $true;
   	$TkPl_SU->{_is_flow_listbox_r}			= $true;

	return();

}

=head2


=cut


sub set4last_delete_from_flow_button {
	my $self = @_;
       				# turn off delete button
	$delete_from_flow_button	->configure(
					-state => 'disabled',);   

    				# turn off ListBox
	$flow_listbox_l    			->configure(
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
	return();

}


=head2


=cut


sub set4run_button_start {
	my $self = @_;
        		# location within GUI   
   	$TkPl_SU->{_is_run_button}				= $true;
	return();

}

=head2


=cut


sub set4run_button {
	my $self = @_;
	# private_conditions->reset();
        		# location within GUI   
   	$TkPl_SU->{_is_run_button}					= $true;
   	$TkPl_SU->{_has_used_run_button}			= $true;
   	
   	# reset save and saveas options because
   	# file must be saved before running, always
    $TkPl_SU->{_has_used_saveas_file_button}	= $false;
    $TkPl_SU->{_has_used_save_button}			= $false;	
	return();

}

=head2


=cut


sub set4run_button_end {
	my $self = @_;
	# private_conditions->reset();
        		# location within GUI   
   	$TkPl_SU->{_is_run_button}				= $false;
   	$TkPl_SU->{_has_used_run_button}		= $false;
	return();

}

=head2


=cut

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
   		$add2flow_button_grey	->configure(
							-state=>'disabled');

	return();
}


=head2


=cut

sub set4start_of_add2flow_button{
	my $self = @_;
    private_conditions->reset();

   	local_last->set_flow_listbox_touched_w();	

   	$TkPl_SU->{_is_add2flow_flow_button}	= $true;
   	$TkPl_SU->{_is_sunix_listbox}   		= $true;
	$TkPl_SU->{_is_new_listbox_selection} 	= $true;
	
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

       		# turn on ListBox(es) later use
   $flow_listbox_l    ->configure(
		        		-state => 'normal',
                      ); 
   # $flow_listbox_r    ->configure(
   #	        		-state => 'normal',
   #                   ); 
	return();
}


=head2


=cut

sub set4superflow_select {
	my $self = @_;
	private_conditions->reset();
        		# location within GUI   
	$TkPl_SU->{_is_new_listbox_selection} 	= $true;
 	$TkPl_SU->{_is_superflow_select_button}	= $true;

    $delete_from_flow_button	->configure(-state => 'disabled',); 	

					# turn off Flow label
    $flow_listbox_l		->configure(-state => 'disabled'); 	# turn off left flow listbox
    $flow_listbox_r		->configure(-state => 'disabled'); 	# turn off right flow listbox
    $add2flow_button_grey	->configure(-state => 'disable',); 	# turn off Flow label
    $run_button			->configure(-state => 'normal'); 
    $save_button		->configure(-state => 'normal');    
    $file_menubutton	->configure(-state => 'normal'); 
    $check_code_button	->configure(-state => 'normal');  
}


=head2


=cut


sub set4start_of_sunix_select {
	my $self = @_;
    private_conditions->reset();
    $TkPl_SU->{_is_sunix_listbox} = $true;
    
    	# print("main, set4start_of_sunix_select, $TkPl_SU->{_is_sunix_listbox}\n");
   	$delete_from_flow_button	->configure(-state => 'disabled',);
	return();
}

sub set4end_of_sunix_select {
   	$flow_listbox_l		->configure(-state => 'normal',);
   	$add2flow_button_grey	->configure(-state => 'normal',);

							# future location in GUI TODO?
   	$TkPl_SU->{_is_flow_listbox_l}			= $true;
   	$TkPl_SU->{_is_flow_listbox_r}			= $false;
   	$TkPl_SU->{_is_add2flow_button}			= $true;
   	# $TkPl_SU->{_is_sunix_listbox} = $false;
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

# 7. Read in old flows
# 8. create param files for more sunix modules
# 9. create spec files for more sunix modules
# 10. creat make.PL file
# 12. see if CAGEo or SRL will accept code

