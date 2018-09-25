#!/usr/local/bin/perl

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
    _has_used_save_button			=> '',
    _has_used_saveas_flow_button	=> '',
  	_items_versions_aref 			=> '',
  	_items_values_aref2  			=> '',
  	_items_names_aref2  			=> '',
  	_items_checkbuttons_aref2 		=> '',
	_is_add2flow_button	   			=> '',
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
 font is made to be garamond normal 14
 border width is defaulted too

=cut

 	$mw = MainWindow->new;
 	$mw	->title($var->{_program_title});
 	$mw	->geometry($var->{_box_position});
 	#$mw	->resizable( 0, 0 ); #not resizable in either width or height 

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

 	#$top_menu_frame  ->Label(
	#				-text 	=> '',
	#				-font 	=> $garamond,
	#				-width	=> $var->{_one_pixel},
	#				-background  => $var->{_my_purple},
     #           )
	#	  		->pack(
     #               -side => "left"
     #              );

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
    		        -text   	=> 'Seismic Tools',
    		        -padx	   => 5,
    		        -anchor     => 'w',
		           	-font 		=> $garamond,
	                -height     => 1,
	                -width      => 11,
                        -background			=> $var->{_my_yellow},
						-foreground 		=> $var->{_my_black},
						-disabledforeground => $var->{_my_dark_grey},
						-activeforeground 	=> $var->{_my_white},
						-activebackground 	=> $var->{_my_dark_grey},
    		        -relief 	=> 'flat'
		          )
		          ->pack(
                  	-side	  	=> "left",
			    	-fill       => 'y'
                            );
my $top_menu_bar	= $superflow_select->Menu(
		           -font 	=> $garamond);

 $top_menu_bar	-> bind('<ButtonRelease-3>' 
			=> [\&help], );    


 $superflow_select	 ->configure(
			   -menu 	=> $top_menu_bar
                           );
 		# $args[0] = $superflow_names->{_ProjectVariables};
 		$args[0] = $superflow_names->{_Project};
 		# print("main, _Project: $args[0]\n");
 $superflow_select	->command(
    			  -label       	=> $args[0],
    			  -underline   	=> 0,
    			  -font 		=> $garamond,
 			);   
  
 		$args[1] = $superflow_names->{_iVelAnalysis};
 $superflow_select	->command(
    			  -label       	=> $args[1],
    			  -underline   	=> 0,
    			  -font 		=>$garamond
                         );

 		$args[2] = $superflow_names->{_fk};
 $superflow_select	->command(
    			  -label       	=> $args[2],
    			  -underline   	=> 0,
    			  -font 		=>$garamond,
 			 );

 		$args[3] = $superflow_names->{_iSpectralAnalysis};
 $superflow_select	->command(
    			  -label       	=> $args[3],
    			  -underline   	=> 0,
    			  -font 		=>$garamond,
 			 );

 		$args[4] = $superflow_names->{_iTopMute};
 $superflow_select	->command(
    			  -label       	=> $args[4],
    			  -underline   	=> 0,
    			  -font 	=>$garamond,
 			 );

 		$args[5] = $superflow_names->{_iBottomMute};
 $superflow_select	->command(
    			  -label       	=> $args[5],
    			  -underline   	=> 0,
    			  -font 		=>$garamond,
 			 );

 		$args[6] = $superflow_names->{_synseis};
 $superflow_select	->command(
    			  -label       	=> $args[6],
    			  -underline   	=> 0,
    			  -font 		=>$garamond,
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
    		           -relief 		=> 'flat',
    		           -state 		=> 'normal',
    		           	-background			=> $var->{_my_yellow},
						-foreground 		=> $var->{_my_black},
						-disabledforeground => $var->{_my_dark_grey},
						-activeforeground 	=> $var->{_my_white},
						-activebackground 	=> $var->{_my_dark_grey},
    		           
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
	my @File_option;
    $File_option[0] =  'Open';
    $File_option[1] =  'Select';
    $File_option[2] =  'SaveAs';


 	$file_menubutton	->command(
    			  		-label       	=> @$alias_FileDialog_button_label[0],
    			  		-underline   	=> 0,
			  			-command      	=>[\&FileDialog_button,\$File_option[0]],
    			  		-font 			=>$garamond
 						);
	$file_menubutton	->separator;
 	$file_menubutton	->command(
    			  		-label       	=> @$alias_FileDialog_button_label[1],
    			  		-underline   	=> 0,
			  			-command      	=>[\&FileDialog_button,\$File_option[1]],
    			  		-font 			=>$garamond
 						);
	$file_menubutton	->separator;
 	$file_menubutton	->command(
   			  			-label       	=> @$alias_FileDialog_button_label[2],
    			  		-underline   	=> 0,
			  			-command      	=>[\&FileDialog_button,\$File_option[2]],
    			  		-font 			=>$garamond
 						);

 	$top_titles_frame 	= $mw->Frame(
                   	   -borderwidth => $var->{_one_pixel_borderwidth}, 
                   	   -background  => $var->{_light_gray},
                   	   -relief      => 'groove'
                   	);
 	# $file_menubutton	->configure(
	#			   			-state 	=> 'disabled', 
	#                        );


=head2  side menu frame

 contains side menus
 2. for action 

=cut


 	my $run_button 	= $side_menu_frame->Button(
    		           		-text   	=> 'Run',
		           			-font 		=> $garamond,
	                   		-height      => 1,
                         -background			=> $var->{_my_yellow},
						-foreground 		=> $var->{_my_black},
						-disabledforeground => $var->{_my_dark_grey},
						-activeforeground 	=> $var->{_my_white},
						-activebackground 	=> $var->{_my_dark_grey},
 
    		           		-relief 	=> 'flat',
    		           		-state 		=> 'normal',
		          			)
		          		->pack(
                            -side  	=> "top",
			    			-fill       => 'x'
                            );
 
 my $save_button 	= $side_menu_frame->Button(
    		           		-text   		=> 'Save',
		           			-font 			=> $garamond,
	                   		-height      	=> 1,
	                   	-background			=> $var->{_my_yellow},
						-foreground 		=> $var->{_my_black},
						-disabledforeground => $var->{_my_dark_grey},
						-activeforeground 	=> $var->{_my_white},
						-activebackground 	=> $var->{_my_dark_grey},
 

    		           		-relief 		=> 'flat',
    		           		-state 			=> 'normal',
		          			)
		          			->pack(
                            -side  	=> "top",
			    			-fill       => 'x'
                            );

=head2 top_titles frame

 just above the work frame
 contains Titles only 

=cut

	      
 	$top_titles_frame  ->Label(
						-text 	    	=> 'Parameter Names',
		   				-font 	   		=> $garamond,
  	           			-height     	=> $var->{_one_character},
		   				-border     	=> $var->{_no_pixel},
                   		-width      	=> 33,
                   		-padx       	=> 0,
                   		-background 	=> $var->{_light_gray},
                   		-relief     	=> 'groove'
                  	 )
		  			->pack(
						-side 			=> "left",
	            		-fill    		=> 'x'
                   	);

 	$top_titles_frame  ->Label(
                   		-text 			=> 'Values  ',
						-font 			=> $garamond,
						-height      	=> $var->{_one_character},
						-border      	=> $var->{_no_pixel},
                   		-padx        	=> 0,
                   		-width       	=> 6,
                   		-padx			=> 33,
                   		-background  	=> $var->{_light_gray},
                   		-relief      	=> 'groove'
                 	 )
		  	  		->pack(
						-side 			=> "left",
	            		-fill        	=> 'x'
                   	);
                   	
                   	my $add2flow_button_grey = $top_titles_frame->Button(
    		           	-text  				=> 'Flow -+->',
						-font 				=> $garamond,
	                   	-height   			=> 1,
	                   	-width 				=> 4,
	                   	-padx				=> 18,
						-background			=> $var->{_my_light_grey},
						-foreground 		=> $var->{_my_black},
						-disabledforeground => $var->{_my_dark_grey},
						-activeforeground 	=> $var->{_my_white},
						-activebackground 	=> $var->{_my_dark_grey},
    		           	-relief 			=> 'flat',
    		           	-state 				=> 'normal',
		          )
		          ->pack(
						-side  		=> "left",
                            );
                                  
	my $add2flow_button_pink = $top_titles_frame->Button(
    		           	-text  				=> '-+->',
						-font 				=> $garamond,
	                   	-height   			=> 1,
	                   	-width  => 2,
						-background			=> $var->{_my_pink},
						-foreground 		=> $var->{_my_black},
						-disabledforeground => $var->{_my_dark_grey} ,
						-activeforeground 	=> $var->{_my_white},
						-activebackground 	=> $var->{_my_dark_grey},
    		           	-relief 			=> 'flat',
    		           	-state 				=> 'normal',
		          )
		          ->pack(
						-side  		=> "left",
                            );                            
	my $add2flow_button_green = $top_titles_frame->Button(
    		           	-text  				=> '-+->',
						-font 				=> $garamond,
	                   	-height   			=> 1,
	                   	-width  => 2,
						-background			=> $var->{_my_light_green},
						-foreground 		=> $var->{_my_black},
						-disabledforeground => $var->{_my_dark_grey} ,
						-activeforeground 	=> $var->{_my_white},
						-activebackground 	=> $var->{_my_dark_grey},
    		           	-relief 			=> 'flat',
    		           	-state 				=> 'normal',
		          )
		          ->pack(
						-side  		=> "left",
                            );
                                      
	my $add2flow_button_blue = $top_titles_frame->Button(
    		           	-text  				=> '-+->',
						-font 				=> $garamond,
	                   	-height   			=> 1,
	                   	-width  			=> 2,                   	
						-background			=> $var->{_my_light_blue},
						-foreground 		=> $var->{_my_black},
						-disabledforeground => $var->{_my_dark_grey} ,
						-activeforeground 	=> $var->{_my_white},
						-activebackground 	=> $var->{_my_dark_grey},
    		           	-relief 			=> 'flat',
    		           	-state 				=> 'normal',

		          )
		          ->pack(
						-side  		=> "left",
                            );            
                   	
                   	

=pod

 button that removes a seismic unix program from the flow

=cut

 	my $delete_from_flow_button = $top_titles_frame->Button(
                   		-text			=> 'Delete',
						-font 			=> $garamond,
						-height      	=> $var->{_one_character},
						-border      	=> 0,
                   		-padx        	=> 8,
                   		-width       	=> 7,
                   		-background  	=> $var->{_white},
                   		-relief      	=> 'flat',
                   		-state       	=> 'active',
                   		-background			=> $var->{_my_light_grey},
						-foreground 		=> $var->{_my_black},
						-disabledforeground => $var->{_my_dark_grey},
						-activeforeground 	=> $var->{_my_white},
						-activebackground 	=> $var->{_my_dark_grey},
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

 	$parameter_values_button_frame    = $parameters_pane->Frame(
		-borderwidth 	=> $var->{_five_pixel_borderwidth}, 
		-background  	=> $var->{_my_purple},
		-width          => '10',
		-relief      	=> 'groove',
	       );
	
 	$parameter_values_frame   	= $parameters_pane->Frame(
		-borderwidth 	=> $var->{_five_pixel_borderwidth}, 
		-background  	=> $var->{_my_purple},
		-width          => '200',
		-relief      	=> 'groove',
	       );
	       
	       
 	$parameter_names_frame = $parameters_pane->Frame(
		-borderwidth 	=> $var->{_five_pixel_borderwidth}, 
		-background  	=> $var->{_my_black},
		-relief      	=> 'groove',
		-width          => '5',
	       );

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
                   -height 	=> 3,
		   			-font   => $garamond
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
                    	   	-width       	=> '150',
		    	   			-background  	=> 'pink',
		           			);

 
=head2 workflow_control_frame

 two vertically stacked frames 
 each holding two flows

=cut

	my $flow_control_frame_top_row     = $flow_control_frame->Frame(
                    	   	-borderwidth 	=> $var->{_five_pixel_borderwidth}, 
                    	   	-relief 	 	=> 'groove',
                    	   	-width       	=> '250',
		    	   			-background  	=> 'purple',
		    	   			-height			=> '150',
		           			);
 
	my $flow_control_frame_bottom_row     = $flow_control_frame->Frame(
                    	   	-borderwidth 	=> $var->{_five_pixel_borderwidth}, 
                    	   	-relief 	 	=> 'groove',
                    	   	-width       	=> '250',
                    	   	-height  		=> '150',
		    	   			-background  	=> 'white',
		           			);

=head2 workflow_control_frame

 on far right of work frame

=cut

 	$flow_listbox_l	= $flow_control_frame_top_row->Scrolled(
		       	   			"Listbox", 
						-scrollbars		=> "osoe", 
						-height 		=> 0, 
						-width       	=> $var->{_ten_characters},
						-selectmode  	=> "single",
						-borderwidth   	=> $var->{_one_pixel_borderwidth},
						-foreground     => $var->{_my_black},
						-background     => $var->{_my_light_grey},
						-selectforeground => $var->{_my_white},
						-selectbackground => $var->{_my_dark_grey},						
						-state			=> 'normal',
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
						-state				=> 'normal',
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
						-state				=> 'normal',
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
						-state				=> 'normal',
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
=pod
	work frame contains, left-to-right
  	a sunix_frame , (orange)
	a parameters_pane,
	a flo fraome (yellow)
	and four listboxes contained in a module-sequences frame on the far right
	The side menu frame is to its far left.
	
=cut

		          

   $message               ->pack(
                           -side    => "bottom",
                           -fill    => 'x',
   );
  
  
    $work_frame		->pack(
                           -side 	=> "left",
                           -fill 	=> "y",
    );
   
	$parameters_pane	->pack(
                           -side    => "left",
                           -fill    => "y",
                           	);   
                           	
     
	$parameter_names_frame	->pack(
                           -side    => "left",
    							-fill => "y",                         
		          );	  
   $parameter_values_button_frame	->pack(
                           -side    	=> "left",
  							-fill => "y",                         
   	); 	 
   	$parameter_values_frame ->pack(
							-side    	=> "left",
							-fill => "x",

		          );  
		          
		  $sunix_frame		->pack(
                           -side 	=> "left",
                           -fill 	=> "y",
		          );
	$sunix_listbox		->pack(
                           -side 	=> "left",
                           -fill 	=> "y",
                          );                   	
	$flow_control_frame		->pack(
                          -side 	=> "left",
                          -fill => "both",
                          -expand => 1, 
		          );
		$flow_control_frame_top_row		->pack(
                         -side 	=> "top",
     	                 -fill => "both", 
     	                 -expand => 1,                   
		          ); 
		          
		$flow_control_frame_bottom_row		->pack(
	                         -side 	=> "bottom",
	                         -fill => "both",
	                         -expand => 1,
		);


	$flow_listbox_l	->pack(
                           -side 	=> "left",
	                         -fill => "y",
		          );
 	                        
    $flow_listbox_r	->pack(
                           -side => "left",
	                         -fill => "y",
                         );
 	$flow_listbox_sw	->pack(
                           -side => "left",
                           -fill => "y",

                         );      
                                             
	$flow_listbox_se	->pack(
                                        -fill => "y",
                                         -side => "left",
                           
                          );                                                
=pod
	
                          
	$flow_listbox_sw	->pack(
                           -side => "bottom",
                           -fill => "x",

                         );

                                                  
=cut

	

 MainLoop;
