=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL PROGRAM NAME: L_SU.pl 
 AUTHOR: 	Juan Lorenzo
 DATE: 		June 22 2017 

 DESCRIPTION 
     

 BASED ON:
 Version 0.1 April 18 2017 SeismicUnixPlTk.pl  
     Added a simple configuration file readable 
flow
    and writable using Config::Simple (CPAN)

 Version 0.2 
    incorporate more object oriented classes
   
 Update: Simple (ASCII) local configuration 
      file is Project_Variables.config
      
 V 0.2.0 Jan 12 2018: removed all Config::Simple dependencies   
 V 0.3.0 May 14, 2018: refactored into L_SU.pm and L_SU.pl
 
 V 0.3.1 makes Run = Save and Run
 Moves SaveAs to Main Menu removes Save button
 
 V 0.3.2 has 4 flow panels
 
 V 0.3.3 has dragNdrop deactivated to stabilize version
 
 V 0.3.4 has classifies sunix programs using tabbed notebooks Sept. 12, 2018

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
 	our $VERSION = '0.3.4';
 
 	use Tk;
 	use Tk::Pane;
# 	use Tk::DragDrop;
# 	use Tk::DropSite;
	use Tk::NoteBook;
 	use L_SU 0.1.4;
	use SeismicUnixPlTk_global_constants;			
	
 	my $get					= new SeismicUnixPlTk_global_constants();
 	my $L_SU				= L_SU->new();

=head2

 share the following parameters in same name 
 space

 flow_listbox_grey_w  -left listbox, input by user selection
 flow_listbox_green_w  -right listbox,input by user selection
 sunix_listbox   -choice of listed sunix modules in a listbox
 
 29 off, 4 off, 1 off

=cut
 	my ($mw);
 	my ($top_menu_frame,$top_titles_frame,$work_frame);
 	my ($side_menu_frame);
 	my ($sunix_frame,$parameters_pane,$flow_control_frame);
 	my ($parameter_values_button_frame);
 	my ($parameter_names_frame,$parameter_values_frame);
 	my ($sunix_listbox,$flow_listbox_grey_w,$flow_listbox_green_w,$flow_listbox_pink_w,$flow_listbox_blue_w);
 	my ($dnd_token_grey,$dropsite_token_grey);
  	my ($dnd_token_pink,$dropsite_token_pink);
    my ($dnd_token_green,$dropsite_token_green);
    my ($dnd_token_blue,$dropsite_token_blue);
	my (@param,@values,@args);
	
 	my $var								= $get->var();
	my $alias_FileDialog_button_label	= $get->alias_FileDialog_button_label_aref; 
	my $superflow_names_gui_aref     	= $get->superflow_names_gui_aref();
	my $file_dialog_type				= $get->file_dialog_type_href();
	my $global_libs						= $get->global_libs();
	

 	@values								= qw//;
 	my @choices							= @{$var->{_sunix_choices}};
   	my @sunix_data_programs  			= @{$var->{_sunix_data_programs}};	
 	my @sunix_display_programs  		= @{$var->{_sunix_display_programs}};
 	my @sunix_filter_programs  			= @{$var->{_sunix_filter_programs}};
 	my @sunix_model_programs  			= @{$var->{_sunix_model_programs}}; 	
 	my @sunix_transform_programs  		= @{$var->{_sunix_transform_programs}};
  	my @sunix_velocity_programs  		= @{$var->{_sunix_velocity_programs}};	
   	my @sunix_statsMath_programs  		= @{$var->{_sunix_statsMath_programs}};	
   	my @sunix_metadata_programs  		= @{$var->{_sunix_metadata_programs}};
   	my @sunix_migration_programs  		= @{$var->{_sunix_migration_programs}};  
   		
=head2 Default Tk settings{

 Create scoped hash 
 43 off

=cut

 my $TkPl_SU   = {
 	
	_Data_menubutton				=> '',
	_Flow_menubutton				=> '',
	_SaveAs_menubutton				=> '',
	_add2flow_button_grey			=> '',
	_add2flow_button_pink			=> '',
	_add2flow_button_green			=> '',
	_add2flow_button_blue			=> '',
	_check_code_button				=> '',
	_delete_from_flow_button		=> '',
	_dnd_token_grey					=> '',
	_dnd_token_pink					=> '',
	_dnd_token_green				=> '',
	_dnd_token_blue					=> '',
	_dropsite_token_grey			=> '',
	_dropsite_token_pink			=> '',
	_dropsite_token_green			=> '',
	_dropsite_token_blue			=> '',
	_file_menubutton				=> '',
	_flow_item_down_arrow_button	=> '',
	_flow_item_up_arrow_button		=> '',	
	_flow_listbox_grey_w			=> '',
	_flow_listbox_pink_w			=> '',
	_flow_listbox_green_w			=> '',
	_flow_listbox_blue_w			=> '',
	_flow_name_grey_w				=> '',
	_flow_name_pink_w				=> '',
	_flow_name_green_w				=> '',
	_flow_name_blue_w				=> '',	
	_flowNsuperflow_name_w			=> '',
	_good_labels_aref2				=> '',		
	_prog_names_aref 				=> '', 
	_name_aref    					=> '',
	_names_aref    					=> '',
    _index2move	    				=> '',
    _destination_index	 			=> '',
 	_run_button						=> '',
	_mw								=> '',
	_parameter_values_frame			=> '',
	_parameter_names_frame			=> '',
	_parameter_values_button_frame	=> '',
	_prog_name     					=> '',
	_save_button					=> '',
	_sunix_listbox					=> '',
	
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
                  
 	my $arial_small  = $mw->fontCreate(
                  'arial_small', 
                  -family => 'arial',
                  -weight => 'normal',
                  -size   => -12);             
                    
 	my $arial_italic  = $mw->fontCreate(
                  'arial_italic', 
                  -family => 'arial',
                  -weight => 'normal',
                  -slant  => 'italic',
                  -size   => -16);
                  
   	my $arial_italic_small  = $mw->fontCreate(
                  'arial_italic_small', 
                  -family => 'arial',
                  -weight => 'normal',
                  -slant  => 'italic',
                  -size   => -12);
                  
   	my $arial_italic_very_small  = $mw->fontCreate(
                  'arial_italic_very_small', 
                  -family => 'arial',
                  -slant  => 'italic',                  
                  -weight => 'normal',
                  -size   => -9);
                                  
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
 
 help goes to superflow bindings 

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

 	$top_menu_bar		-> bind('<ButtonRelease-3>' 
				=> [\&_L_SU_superflow_bindings,'help'],
				);
			

=head2 Top title reminders for Selected flow and Superflow names


=cut 


	my $top_menu_frame_spacer	 = $top_menu_frame->Label(
					-text 	    		=> '',
		   			-font 	   			=> $arial,
  	           		-height     		=> $var->{_one_character},
		   			-border     		=> $var->{_no_pixel},
                   	-width      		=> 0,
                   	-padx       		=> 0,
	                -height     		=> 1,
	                -width      		=> 40,
	                -padx	    		=> $var->{_five_pixels},
                    -background 		=> $var->{_my_purple},
 					-foreground 		=> $var->{_my_black},
					-disabledforeground => $var->{_my_dark_grey},
					-activeforeground 	=> $var->{_my_white},
					-activebackground 	=> $var->{_my_dark_grey},                   
    		        -relief 			=> 'flat'
		          );

	my $flowNsuperflow_name_w	 = $top_menu_frame->Label(
					-text 	    		=> 'Flow Name',
					-anchor				=> 'center',
		   			-font 	   			=> $arial_italic,
  	           		-height     		=> $var->{_one_character},
		   			-border     		=> $var->{_no_pixel},
                   	-padx       		=> 0,
	                -height     		=> 1,
	                -width      		=> $var->{_thirty_characters},,
	                -padx	    		=> $var->{_five_pixels},
                    -background 		=> $var->{_my_yellow},
 					-foreground 		=> $var->{_my_black},
					-disabledforeground => $var->{_my_dark_grey},
					-activeforeground 	=> $var->{_my_white},
					-activebackground 	=> $var->{_my_dark_grey},                   
    		        -relief 			=> 'flat',
    		        -state 				=> 'disabled',
		          );
			   
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
                  -command      => [\&_L_SU_superflows,'pre_built_superflows',\$args[$sflows]],
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
 1. for files

=cut

	my $file_menubutton = $side_menu_frame->Menubutton(
    		           	-text   			=> 'File',
		           		-font 				=> $arial,
	                   	-height      		=> 1,
    		           	-relief 			=> 'flat',
    		           	-background			=> $var->{_my_yellow},
						-foreground 		=> $var->{_my_black},
						-disabledforeground => $var->{_my_dark_grey},
						-activeforeground 	=> $var->{_my_white},
						-activebackground 	=> $var->{_my_dark_grey},        
		          		);
#    		           	-state 				=> 'disabled',
	
	my $side_menu_bar	= $file_menubutton->Menu(
		           		-font 	=> $arial);

 	$file_menubutton	->configure(
			   				-menu 	=> $side_menu_bar
                           ); 
                        
 	$file_menubutton	->separator;
	my @File_option;
    $File_option[0] =  $file_dialog_type->{_Data}; 
    $File_option[1] =  $file_dialog_type->{_Flow};
    $File_option[2] =  $file_dialog_type->{_SaveAs};

 	my $Data_menubutton = $file_menubutton	->command(
    			  		-label       	=> @$alias_FileDialog_button_label[0],
    			  		-underline   	=> 0,
     			  		-state 			=> 'disabled',
			  			-command      	=>[\&_L_SU,'FileDialog_button',\$File_option[0]],
    			  		-font 			=>$arial
 						);
 						
# 						print("L_SU, main,Data_menubutton deref Array: @{$Data_menubutton}\n");
# 						print("L_SU, main,file_menubutton Hash: $file_menubutton\n");
# 						$Data_menubutton->configure(-state => 'normal');
# 	 					my $option_hash = $file_menubutton->{_names_};
# 						 print("L_SU, main,option_array, $file_menubutton->{_names_}\n");
# 	 
# 						print("L_SU, main,file_menubutton->{_names_}: $file_menubutton->{_names_}\n");
# 	 					foreach my $key (sort keys %$file_menubutton) {
#      					print (" L_SU, main, file_menubutton,key is $key, value is $file_menubutton->{$key}\n");
# 						}
# 					
# 					 						
# 	 					foreach my $key (sort keys %$option_hash) {
#      					print (" L_SU, main,option_hash, key is $key, value is $option_hash->{$key}\n");
# 						}
 						
	# Flow (in order to open a user-built perl flow) is the only button enabled button from the start					
	$file_menubutton	->separator;
 	my $Flow_menubutton = $file_menubutton	->command(
    			  		-label       	=> @$alias_FileDialog_button_label[1],
    			  		-underline   	=> 0,
			  			-command      	=>[\&_L_SU,'FileDialog_button',\$File_option[1]],
    			  		-font 			=>$arial,
 						);
						
	$file_menubutton	->separator;
 	my $SaveAs_menubutton = $file_menubutton	->command(
   			  			-label       	=> @$alias_FileDialog_button_label[2],
    			  		-underline   	=> 0,
    			  		-state 			=> 'disabled',
			  			-command      	=>[\&_L_SU,'FileDialog_button',\$File_option[2]],
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

	my $Run_option 	= 'Run';
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
			   				-command     		=> [\&_L_SU,'run_button',\$Run_option],
		          			);
	 	

	my $Save_option 	= 'Save';
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
			   				-command    		=> [\&_L_SU,'save_button',\$Save_option],
		          			);

  	my $Check_code_option 	= 'Check';
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
			   				-command    		=> [\&_L_SU,'check_code_button',\$Check_code_option],
		          			);

	      			
=head2 top_titles frame

 just above the work frame
 contains Titles only 

=cut
      
 	my $top_titles_label	= $top_titles_frame  ->Label(
						-text 	    	=> "\t".'Parameter Names'."\t\t\t".'Values',
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
						-activeforeground 	=> $var->{_my_black},
						-activebackground 	=> $var->{_my_dark_grey},           	
    		           	-relief 			=> 'flat',
    		           	-state 				=> 'disabled',
						-command			=> [\&_L_SU_flows,'add2flow_button','grey'],
		          );


	my $add2flow_button_pink = $top_titles_frame->Button(
    		           	-text  				=> '2. -+->',
						-font 				=> $arial,
	                   	-height   			=> 1,
	                   	-width  			=> 2,
						-background			=> $var->{_my_pink},
						-foreground 		=> $var->{_my_black},
						-disabledforeground => $var->{_my_dark_grey} ,
						-activeforeground 	=> $var->{_my_black},
						-activebackground 	=> $var->{_my_dark_grey},
    		           	-relief 			=> 'flat',
    		           	-state 				=> 'disabled',
						-command			=> [\&_L_SU_flows,'add2flow_button','pink'],
		          );
                           
	my $add2flow_button_green = $top_titles_frame->Button(
    		           	-text  				=> '3. -+->',
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
						-command			=> [\&_L_SU_flows,'add2flow_button','green'],
		          );
          
	my $add2flow_button_blue = $top_titles_frame->Button(
    		           	-text  				=> '4. -+->',
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
						-command			=> [\&_L_SU_flows,'add2flow_button','blue']
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
              		 

   # read bitmap from file
   my $flow_item_up_arrow 	= $mw->Bitmap(-file    => $global_libs->{_images}.'file_item_up_arrow.xbm',
                    );
   my $flow_item_down_arrow = $mw->Bitmap(-file    => $global_libs->{_images}.'file_item_down_arrow.xbm',
                    );                  

=pod

 button that moves items (program names) UP in a flow (color grey, pink, green or blue);
 up within a listbox

=cut

 	my $flow_item_up_arrow_button = $top_titles_frame->Button(
                   		-image				=> $flow_item_up_arrow,
						-height      		=> $var->{_24_pixels},
						-border      		=> 0,
                   		-padx        		=> 8,
                   		-width       		=> $var->{_12_pixels},
                   		-background			=> $var->{_my_light_grey},
						-foreground 		=> $var->{_my_black},
						-disabledforeground => $var->{_my_dark_grey},
						-activeforeground 	=> $var->{_my_white},
						-activebackground 	=> $var->{_my_dark_grey},
                   		-relief      		=> 'flat',
                   		-state       		=> 'disabled',
                 		 );

=pod

 button that moves items (program names) DOWN in a flow (color grey, pink, green or blue);
 down within a listbox

=cut

 	my $flow_item_down_arrow_button = $top_titles_frame->Button(
                   		-image				=> $flow_item_down_arrow,
						-height      		=> $var->{_24_pixels},
						-border      		=> 0,
                   		-padx        		=> 8,
                   		-width       		=> $var->{_12_pixels},
                   		-background			=> $var->{_my_light_grey},
						-foreground 		=> $var->{_my_black},
						-disabledforeground => $var->{_my_dark_grey},
						-activeforeground 	=> $var->{_my_white},
						-activebackground 	=> $var->{_my_dark_grey},
                   		-relief      		=> 'flat',
                   		-state       		=> 'disabled',
                 		 );

=head2 tied listbox widgets

 to a button action
 for easier management

=cut

 	$delete_from_flow_button	-> bind('<1>' 
   					=> [\&_L_SU_flow_bindings_any_color,'delete_from_flow_button'],
                       );
   
	$flow_item_up_arrow_button	-> bind('<1>' 
   					=> [\&_L_SU_flow_bindings_any_color,'flow_item_up_arrow_button'],
                       );
                       
	$flow_item_down_arrow_button	-> bind('<1>' 
   					=> [\&_L_SU_flow_bindings_any_color,'flow_item_down_arrow_button'],
                       );                     
	 
 	$work_frame	= $mw->Frame(
                   -borderwidth => $var->{_one_pixel_borderwidth}, 
                   -background  => 'yellow',
                   -relief 		=> 'groove'
                  );

=head2 work frame

 has menu items to its left
 contains a sunix_frame on its far left, 
 a parameters_pane (with names value buttons and values) in the center
 and four listboxes contained in a module-sequences frame on the far right
 


=cut


=head2 sunix_frame

  The sunix_frame itself contains upper and a lower
  sub-frames called sunix_frame_top and sunix_frame_bottom
 
=cut 

 	$sunix_frame  	= $work_frame->Frame(
                    	   	-borderwidth 	=> $var->{_no_borderwidth}, 
                    	   	-relief	 		=> 'flat',
                    	   	-width       	=> $var->{_eleven_characters},
							-background  	=> $var->{_my_purple},
                   	   	);

     my $sunix_frame_top  = $sunix_frame->Frame (
                          	-borderwidth 	=> $var->{_no_borderwidth}, 
                    	   	-relief	 		=> 'flat',
                    	   	-width       	=> $var->{_eleven_characters},
                    	     -height		=> '50',
							-background  	=> $var->{_my_purple},
      						) ;
     my $sunix_frame_middle  = $sunix_frame->Frame (
                          	-borderwidth 	=> $var->{_no_borderwidth}, 
                          	-pady			=> $var->{_one_pixel},
                    	   	-relief	 		=> 'flat',
                    	   	-width       	=> $var->{_eleven_characters},
                    	    -height			=> '50',
							-background  	=> $var->{_my_purple},
      						) ;
      						
    my $sunix_frame_bottom  = $sunix_frame->Frame (
                          	-borderwidth 	=> $var->{_no_borderwidth}, 
                    	   	-relief	 		=> 'flat',
                    	   	-width       	=> $var->{_eleven_characters},
                    	   	 -height		=> '50',
							-background  	=> $var->{_my_purple},
      						);     						
 

=head2 Notebooks within top sunix_frame

  an upper and lower notebook exists within
  the utop sunix sub-frame
 
=cut  
    												   	   	
    my $sunix_programs_top_book    = $sunix_frame_top->NoteBook(
     								-font 			=> $arial_small,
     								-borderwidth 	=> $var->{_no_borderwidth},
     								-backpagecolor => $var->{_my_purple},
     								);   								
  
  	 my $sunix_data_programs_tab 	= $sunix_programs_top_book->add(
									"data programs tab",
									-label=>"data"
									);
     								
	 my $sunix_display_programs_tab 	= $sunix_programs_top_book->add( 
	 								"display programs tab",
	 								-label=>"display");
	 								
	 my $sunix_filter_programs_tab 		= $sunix_programs_top_book->add(
									"filter programs tab",
									-label=>"filter",
									);
	 									 								                                        
 	my $sunix_filter_programs_listbox 	= $sunix_filter_programs_tab->Scrolled(
		       	   			"Listbox", 
                       	   -scrollbars 		=> "osoe", 
                       	   -height 			=> $var->{_3_lines}, 
                    	   -width       	=> $var->{_eleven_characters},
                       	   -selectmode  	=> "single",
                           -borderwidth   	=> $var->{_no_borderwidth}
                       );

 	my $sunix_display_programs_listbox 	= $sunix_display_programs_tab->Scrolled(
		       	   			"Listbox", 
                       	   -scrollbars 		=> "osoe", 
                       	   -height 			=> $var->{_3_lines}, 
                    	   -width       	=> $var->{_eleven_characters},
                       	   -selectmode  	=> "single",
                           -borderwidth   	=> $var->{_no_borderwidth}
                       );
                       
    my $sunix_data_programs_listbox 		= $sunix_data_programs_tab->Scrolled(
		       	   			"Listbox", 
                       	   -scrollbars 		=> "osoe", 
                       	   -height 			=> $var->{_3_lines}, 
                    	   -width       	=> $var->{_eleven_characters},
                       	   -selectmode  	=> "single",
                           -borderwidth   	=> $var->{_no_borderwidth}
                       );               
	
 	$sunix_filter_programs_listbox    ->insert(
                       "end", 
                        sort @sunix_filter_programs,
	             		);                       
	
 	$sunix_display_programs_listbox    ->insert(
                       "end", 
                        sort @sunix_display_programs,
	             		);

	$sunix_data_programs_listbox    ->insert(
                       "end", 
                        sort @sunix_data_programs,
	             		);
                 		 
=head2 Notebooks within middle sunix_frame

  an upper and lower notebook exists within
  the utop sunix sub-frame
 
=cut  
    												   	   	
    my $sunix_programs_middle_book    = $sunix_frame_middle->NoteBook(
     								-font 			=> $arial_small,
     								-borderwidth 	=> $var->{_no_borderwidth},
     								-backpagecolor => $var->{_my_purple},
     								);   								
  
  	 my $sunix_statsMath_programs_tab 	= $sunix_programs_middle_book->add(
									"statsMath programs tab",
									-label=>"statsMath"
									);
     								
	 my $sunix_metadata_programs_tab 	= $sunix_programs_middle_book->add( 
	 								"metadata programs tab",
	 								-label=>"metadata");
	 								
	 my $sunix_migration_programs_tab 		= $sunix_programs_middle_book->add(
									"migration programs tab",
									-label=>"migration",
									);
	 									 								                                        
 	my $sunix_statsMath_programs_listbox 	= $sunix_statsMath_programs_tab->Scrolled(
		       	   			"Listbox", 
                       	   -scrollbars 		=> "osoe", 
                       	   -height 			=> $var->{_3_lines}, 
                    	   -width       	=> $var->{_eleven_characters},
                       	   -selectmode  	=> "single",
                           -borderwidth   	=> $var->{_no_borderwidth}
                       );

 	my $sunix_metadata_programs_listbox 	= $sunix_metadata_programs_tab->Scrolled(
		       	   			"Listbox", 
                       	   -scrollbars 		=> "osoe", 
                       	   -height 			=> $var->{_3_lines}, 
                    	   -width       	=> $var->{_eleven_characters},
                       	   -selectmode  	=> "single",
                           -borderwidth   	=> $var->{_no_borderwidth}
                       );
                       
    my $sunix_migration_programs_listbox 		= $sunix_migration_programs_tab->Scrolled(
		       	   			"Listbox", 
                       	   -scrollbars 		=> "osoe", 
                       	   -height 			=> $var->{_3_lines}, 
                    	   -width       	=> $var->{_eleven_characters},
                       	   -selectmode  	=> "single",
                           -borderwidth   	=> $var->{_no_borderwidth}
                       );               
	
 	$sunix_statsMath_programs_listbox    ->insert(
                       "end", 
                        sort @sunix_statsMath_programs,
	             		);                       
	
 	$sunix_metadata_programs_listbox    ->insert(
                       "end", 
                        sort @sunix_metadata_programs,
	             		);

	$sunix_migration_programs_listbox    ->insert(
                       "end", 
                        sort @sunix_migration_programs,
	             		);
                 		 


=head2 Notebooks within bottom sunix_frame

  a lower notebook exists within
  the bottom sunix sub-frame
 
=cut 

   my $sunix_programs_bottom_book    = $sunix_frame_bottom->NoteBook(
      									-font 			=> $arial_small,
     									-borderwidth 	=> $var->{_no_borderwidth},
     									-backpagecolor 	=> $var->{_my_purple},);
 
	my $velocity_programs_tab 		= $sunix_programs_bottom_book->add(
										 "velocity programs tab",
	 									-label=>"velocity");
	 									
	my $transform_programs_tab 		= $sunix_programs_bottom_book->add(
										"transform programs tab", 	
	 									-label=>"transform"); 									
	 								
	my $model_programs_tab 			= $sunix_programs_bottom_book->add( 
										"model programs tab",
										-label=>"model",);
										
 	my $sunix_transform_programs_listbox 	= $transform_programs_tab->Scrolled(
		       	   			"Listbox", 
                       	   -scrollbars 		=> "osoe", 
                       	   -height 			=> $var->{_3_lines}, 
                    	   -width       	=> $var->{_eleven_characters},
                       	   -selectmode  	=> "single",
                           -borderwidth   	=> $var->{_no_borderwidth}
                       ); 										
	 									 								                                        
 	my $sunix_velocity_programs_listbox 	= $velocity_programs_tab->Scrolled(
		       	   			"Listbox", 
                       	   -scrollbars 		=> "osoe", 
                       	   -height 			=> $var->{_3_lines}, 
                    	   -width       	=> $var->{_eleven_characters},
                       	   -selectmode  	=> "single",
                           -borderwidth   	=> $var->{_no_borderwidth}
                       );

 	my $sunix_model_programs_listbox 	= $model_programs_tab->Scrolled(
		       	   			"Listbox", 
                       	   -scrollbars 		=> "osoe", 
                       	   -height 			=> $var->{_3_lines}, 
                    	   -width       	=> $var->{_eleven_characters},
                       	   -selectmode  	=> "single",
                           -borderwidth   	=> $var->{_no_borderwidth}
                       );                       
	
 	$sunix_model_programs_listbox    	->insert(
                       "end", 
                        sort @sunix_model_programs,
	             		);
   
    $sunix_transform_programs_listbox    ->insert(
                       "end", 
                        sort @sunix_transform_programs,
	             		);     
                       	
 	$sunix_velocity_programs_listbox    ->insert(
                       "end", 
                        sort @sunix_velocity_programs,
	             		);
	
=head2 tied listbox widgets

  to a tool_array
  for easier management
  
  This binding occurs inside L_SU.pm

=cut

 	$sunix_data_programs_listbox	-> bind(	
		'<1>'	=> [\&_L_SU_sunix_bindings,'sunix_select','neutral','data'] 
	);
 	$sunix_filter_programs_listbox	-> bind( 
		'<1>'	=> [\&_L_SU_sunix_bindings,'sunix_select','neutral','filter'] 
    );  
 	$sunix_model_programs_listbox	-> bind( 
		'<1>'	=> [\&_L_SU_sunix_bindings,'sunix_select','neutral','model'] 
    );       							    
 	$sunix_display_programs_listbox	-> bind( 
		'<1>'	=> [\&_L_SU_sunix_bindings,'sunix_select','neutral','display']     
    );         	        
 	$sunix_transform_programs_listbox	-> bind( 
		'<1>'	=> [\&_L_SU_sunix_bindings,'sunix_select','neutral','transform']     
	);
	$sunix_velocity_programs_listbox	-> bind( 
		'<1>'	=> [\&_L_SU_sunix_bindings,'sunix_select','neutral','velocity']
    );
	$sunix_statsMath_programs_listbox	-> bind( 
		'<1>'	=> [\&_L_SU_sunix_bindings,'sunix_select','neutral','statsMath']
    );
	$sunix_metadata_programs_listbox	-> bind( 
		'<1>'	=> [\&_L_SU_sunix_bindings,'sunix_select','neutral','metadata']
    );
 	$sunix_migration_programs_listbox	-> bind( 
		'<1>'	=> [\&_L_SU_sunix_bindings,'sunix_select','neutral','migration']
    );                     	                       	                    	                     	
 	$sunix_data_programs_listbox		-> bind(	
		'<3>'	=> [\&_L_SU_sunix_bindings,'help','neutral','data']      #TODo return to 'neutral' 
	);                  	                    	                     	
 	$sunix_filter_programs_listbox		-> bind( 
		'<3>'	=> [\&_L_SU_sunix_bindings,'help','neutral','filter']      #TODo return to 'neutral'
    );  
 	$sunix_model_programs_listbox		-> bind( 
		'<3>'	=> [\&_L_SU_sunix_bindings,'help','neutral','model']      #TODo return to 'neutral'
    );       	
 	$sunix_display_programs_listbox		-> bind( 
		'<3>'	=> [\&_L_SU_sunix_bindings,'help','neutral','plot']      #TODo return to 'neutral'
    );         	
  	$sunix_transform_programs_listbox	-> bind( 
		'<3>'	=> [\&_L_SU_sunix_bindings,'help','neutral','transform']      #TODo return to 'neutral'
	);
  	$sunix_velocity_programs_listbox	-> bind( 
		'<3>'	=> [\&_L_SU_sunix_bindings,'help','neutral','velocity']      #TODo return to 'neutral'
	);
	
  	$sunix_statsMath_programs_listbox	-> bind( 
		'<3>'	=> [\&_L_SU_sunix_bindings,'help','neutral','statsMath']      #TODo return to 'neutral'
	);	
  	$sunix_metadata_programs_listbox	-> bind( 
		'<3>'	=> [\&_L_SU_sunix_bindings,'help','neutral','metadata']      #TODo return to 'neutral'
	);
  	$sunix_migration_programs_listbox	-> bind( 
		'<3>'	=> [\&_L_SU_sunix_bindings,'help','neutral','migration']      #TODo return to 'neutral'
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
			-width			=> 380,
			 #-padx			=> 10,
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
		-relief      	=> 'flat',
		#-width          => '200',
	       );   
	       		#-width          => '1',

 	$parameter_values_button_frame    = $parameters_pane->Frame(
		-borderwidth 	=> $var->{_one_pixel_borderwidth}, 
		-background  	=> $var->{_my_purple},
		-relief      	=> 'flat',
		#-width          => '50',
	       );
		#-width          => '10',
 	$parameter_values_frame   	= $parameters_pane->Frame(
		-borderwidth 	=> $var->{_one_pixel_borderwidth}, 
		-background  	=> $var->{_my_purple},
		-relief      	=> 'flat',
		#-width          => '150',
	       );	       

	       		#-width          => '200',


=head2 message area 

      to notify user of important evets 

=cut

 	my $message	= $work_frame->Text(
                	-height 			=> $var->{_1_line},
		   			-font   			=> $arial,
		   			-foreground     	=> $var->{_my_white},
					-background     	=> $var->{_my_black},
                  );
                  


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

	my $flow_control_frame_names4top_row     = $flow_control_frame->Frame(
                    	   	-borderwidth 	=> $var->{_no_borderwidth}, 
                    	   	-relief 	 	=> 'groove',
                    	   	-width       	=> '400',
		    	   			-height			=> '1',
		    	   			-background  	=> 'purple',
		           			);
 
	my $flow_control_frame_top_row     = $flow_control_frame->Frame(
                    	   	-borderwidth 	=> $var->{_no_borderwidth}, 
                    	   	-relief 	 	=> 'groove',
                    	   	-width       	=> '400',
		    	   			-height			=> '150',
		    	   			-background  	=> 'purple',
		           			);
 
 	my $flow_control_frame_names4bottom_row  = $flow_control_frame->Frame(
                    	   	-borderwidth 	=> $var->{_no_borderwidth}, 
                    	   	-relief 	 	=> 'groove',
                    	   	-width       	=> '400',
		    	   			-height			=> '1',
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

 includes flow names

=cut

	my $flow_name_grey_w	 = $flow_control_frame_names4top_row->Label(
	
					-activeforeground 	=> $var->{_my_white},
					-activebackground 	=> $var->{_my_dark_grey},	
					-anchor				=> 'w',
                    -background 		=> $var->{_my_yellow},					
		   			-border     		=> $var->{_no_pixel},
					-disabledforeground => $var->{_my_dark_grey},										
		   			-font 	   			=> $arial_italic_small,
 					-foreground 		=> $var->{_my_black},		   			
  	           		-height     		=> $var->{_one_character},
  		            -padx	    		=> $var->{_five_pixels},				                 
    		        -relief 			=> 'flat',
    		        -state 				=> 'disabled',
  					-text 	    		=> 'grey name', 
                    -width      		=> $var->{_13_characters}, 	                    				 		        
		          );

	my $flow_name_pink_w	 = $flow_control_frame_names4top_row->Label(
	
					-activeforeground 	=> $var->{_my_white},
					-activebackground 	=> $var->{_my_dark_grey},
					-anchor				=> 'w',
					-background 		=> $var->{_my_yellow},	
		   			-border     		=> $var->{_no_pixel},
					-disabledforeground => $var->{_my_dark_grey},
		   			-font 	   			=> $arial_italic_small,
 					-foreground 		=> $var->{_my_black},
  	           		-height     		=> $var->{_one_character},			
	                -padx	    		=> $var->{_five_pixels},         
    		        -relief 			=> 'flat',
    		        -state 				=> 'disabled',
    		     	-text 	    		=> 'pink name',	
                   	-width      		=> $var->{_13_characters},
		          );

	my $flow_name_green_w = $flow_control_frame_names4bottom_row->Label(

					-activeforeground 	=> $var->{_my_white},
					-activebackground 	=> $var->{_my_dark_grey}, 	
					-anchor				=> 'w',
                    -background 		=> $var->{_my_yellow},
		   			-border     		=> $var->{_no_pixel},	
					-disabledforeground => $var->{_my_dark_grey},		   												
		   			-font 	   			=> $arial_italic_small,
					-foreground 		=> $var->{_my_black},		   			
  	           		-height     		=> $var->{_one_character},
	                -padx	    		=> $var->{_five_pixels},					                  
    		        -relief 			=> 'flat',
    		        -state 				=> 'disabled',
					-text 	    		=>  'green name',    		        
                   	-width      		=> $var->{_13_characters},    		        
		          );

	my $flow_name_blue_w = $flow_control_frame_names4bottom_row->Label(
					-activeforeground 	=> $var->{_my_white},
					-activebackground 	=> $var->{_my_dark_grey},
					-anchor				=> 'w',
                    -background 		=> $var->{_my_yellow},
		   			-border     		=> $var->{_no_pixel},
					-disabledforeground => $var->{_my_dark_grey},		 
		   			-font 	   			=> $arial_italic_small,
 					-foreground 		=> $var->{_my_black},		   			
  	           		-height     		=> $var->{_one_character},
	                -padx	    		=> $var->{_five_pixels},
     		        -relief 			=> 'flat',
     		        -state 				=> 'disabled',
					-text 	    		=> 'blue name',
                   	-width      		=> $var->{_13_characters},					
		          );

 	$flow_listbox_grey_w	= $flow_control_frame_top_row->Scrolled(
		       	   			"Listbox", 
						-scrollbars			=> "osoe", 
						-height 			=> 0, 
						-width       		=> $var->{_ten_characters},
						-selectmode  		=> "single",
						-borderwidth   		=> $var->{_one_pixel_borderwidth},
						-foreground     	=> $var->{_my_black},
						-background     	=> $var->{_my_light_grey},
     		        -relief 			=> 'flat',						
						-selectforeground 	=> $var->{_my_white},
						-selectbackground 	=> $var->{_my_dark_grey},						
						-state				=> 'disabled',
                      	   );
  
 	$flow_listbox_pink_w 	= $flow_control_frame_top_row->Scrolled(
		       	   			"Listbox", 
						-scrollbars 		=> "osoe", 
						-height				=> 0, 
						-width       		=> $var->{_ten_characters},
						-selectmode  		=> "single",
						-borderwidth   		=> $var->{_one_pixel_borderwidth},
						-foreground     	=> $var->{_my_black},
						-background     	=> $var->{_my_pink},
						
     		        -relief 			=> 'flat',					
						-selectforeground	=> $var->{_my_white},
						-selectbackground 	=> $var->{_my_dark_grey},
						-state				=> 'disabled',
                      	   );

 	$flow_listbox_green_w	= $flow_control_frame_bottom_row->Scrolled(
		       	   			"Listbox", 
						-scrollbars 		=> "osoe", 
						-height				=> 0, 
						-width       		=> $var->{_ten_characters},
						-selectmode  		=> "single",
						-borderwidth   		=> $var->{_one_pixel_borderwidth},
						-foreground     	=> $var->{_my_black},
						-background     	=> $var->{_my_light_green},
						
     		        -relief 			=> 'flat',					
						-selectforeground	=> $var->{_my_white},
						-selectbackground 	=> $var->{_my_dark_grey},
						-state				=> 'disabled',
                      	   );
  
 	$flow_listbox_blue_w 	= $flow_control_frame_bottom_row->Scrolled(
		       	   			"Listbox", 
						-scrollbars 		=> "osoe", 
						-height				=> 0,
						-width       		=> $var->{_ten_characters},
						-selectmode  		=> "single",
						-borderwidth   		=> $var->{_one_pixel_borderwidth},
						-foreground     	=> $var->{_my_black},
						-background     	=> $var->{_my_light_blue},
						
     		        -relief 			=> 'flat',					
						-selectforeground	=> $var->{_my_white},
						-selectbackground 	=> $var->{_my_dark_grey},
						-state				=> 'disabled',
                      	   );

=head2 tied flow listbox widgets

  to a tool_array
  for easier management
  
  # could also be done in L_SU.pm/param_widgets

=cut

 	$flow_listbox_grey_w	-> bind('<1>' 
				=> [\&_L_SU_flow_bindings,'flow_select','grey'],  
                       );
 	$flow_listbox_grey_w-> bind('<3>' 
				=> [\&_L_SU_flow_bindings,'help','grey']      
                       );

 	$flow_listbox_pink_w	-> bind('<1>' 
				=> [\&_L_SU_flow_bindings,'flow_select','pink'],  
                       );
 	$flow_listbox_pink_w-> bind('<3>' 
				=> [\&_L_SU_flow_bindings,'help','pink']     
                       );

 	$flow_listbox_green_w	-> bind('<1>' 
				=> [\&_L_SU_flow_bindings,'flow_select','green'],  
                       );
 	$flow_listbox_green_w-> bind('<3>' 
				=> [\&_L_SU_flow_bindings,'help','green']     
                       );
 
 	$flow_listbox_blue_w	-> bind('<1>' 
				=> [\&_L_SU_flow_bindings,'flow_select','blue'],  
                       );
 	$flow_listbox_blue_w-> bind('<3>' 
				=> [\&_L_SU_flow_bindings,'help','blue']     
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
    $top_menu_frame_spacer 	->pack(
                  			-side	=> "left",
			    			-fill   => 'y'
                            );
                            
    $flowNsuperflow_name_w	->pack(
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
   	#$check_code_button	    ->pack(
    #                        -side  	=> "top",
	#		    			-fill   => 'x',
    #                        );      
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
    $flow_item_up_arrow_button->pack(
                    		-side 	=> "right",
                   			);
    $flow_item_down_arrow_button->pack(
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
    						
    # pack contents of work frame						
 	$sunix_frame			->pack(
                           	-side 	=> "left",
                           	-fill 	=> "y",
		          			);
	    
    $parameters_pane		->pack(
                           	-side => "left",
                           	-fill => "y",
                           	                         	
                           	);		         

	$flow_control_frame		->pack(
                          		-side 	=> "top",
                          		-fill 	=> "both",
                           		-expand => 1,
    						);
    						
	# pack contents of parameters_pane		          			
    $sunix_frame_top 	 	->pack (
    						-side 	=> "top",
    						-fill	=> "both",
    						-expand => 1,
    						) ;
    						
    $sunix_frame_middle 	->pack (
    						-side 	=> "top",
    						-fill	=> "both",
    						-expand => 1,
    						) ;
      						
    $sunix_frame_bottom  	->pack(
    						-side 	=> "top",
    						-fill=> "both",
    						-expand => 1,
    						) ;
    						
    # pack Notebooks in 	$sunix_frame_top					 
    $sunix_programs_top_book   	->pack( 
        					-fill=> "x",
    					 	);
    					 	
    # pack Notebooks in 	$sunix_frame_middle   
    $sunix_programs_middle_book  ->pack(
							-fill=>'x',
							);
   					 	
    # pack Notebooks in 	$sunix_frame_bottom   
    $sunix_programs_bottom_book  ->pack(
							-fill=>'x',
							-expand=>1 
							);
							  						
    # pack tabs in upper Notebook						   	   	    		          				          				          										
 	$sunix_display_programs_listbox		->pack(
                           		-side 	=> "left",
                           		-fill 	=> "x",
 							); 
	$sunix_transform_programs_listbox	->pack(
                           		-side 	=> "left",
                           		-fill 	=> "x",
 							); 

  	$sunix_data_programs_listbox		->pack(
                           		-side 	=> "left",
                           		-fill 	=> "x",
 							);
 							
    # pack tabs in middle Notebook						   	   	    		          				          				          										
 	$sunix_statsMath_programs_listbox		->pack(
                           		-side 	=> "left",
                           		-fill 	=> "x",
 							); 
	$sunix_metadata_programs_listbox	->pack(
                           		-side 	=> "left",
                           		-fill 	=> "x",
 							); 

  	$sunix_migration_programs_listbox		->pack(
                           		-side 	=> "left",
                           		-fill 	=> "x",
 							); 
 														
    # pack tabs in lower Notebook	 							  							
 	$sunix_velocity_programs_listbox	->pack(
                           		-side 	=> "top",
                           		-fill 	=> "x", 
 							); 
 							 
	$sunix_filter_programs_listbox		->pack(
                           		-side 	=> "top",
                           		-fill 	=> "x",
							);
							 	 								
 	$sunix_model_programs_listbox->pack(
                           		-side 	=> "left",
                           		-fill 	=> "x",
 							);  													 																
                        	                 	
	# within parameters_pane from LtoR we have:
	# $parameter_names_frame
	# parameter_values_button_frame
	# have parameter_values_frame
	
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
								-fill => "y",
		          			);	          			

	# pack contents of control frame
    $flow_control_frame_names4top_row 		->pack(
                          		-side 	=> "top",
                          		-fill 	=> "x",
                           		-expand => 0,
    						);
	$flow_control_frame_top_row	->pack(
                         		-side 	=> "top",
     	                 		-fill 	=> "both", 
     	                 		-expand => 1,                   
		          			); 	   
    $flow_control_frame_names4bottom_row 		->pack(
                          		-side 	=> "top",
                          		-fill 	=> "x",
                           		-expand => 0,
    						);		          			       
	$flow_control_frame_bottom_row	->pack(
	                         	-side 	=> "top",
	                         	-fill 	=> "both",
	                         	-expand => 1,
							);
	$flow_name_grey_w		->pack(
                           -side 	=> "left",
                           -fill 	=> "x",
		          			);							
	$flow_name_pink_w		->pack(
                           -side 	=> "left",
                           -fill 	=> "x",
		          			);
	$flow_listbox_grey_w		->pack(
                           -side 	=> "left",
                           -fill 	=> "y",
		          			);
	$flow_listbox_pink_w	->pack(
                           -side => "left",
                           -fill => "y",
                         );
    $flow_name_green_w		->pack(
                           -side 	=> "left",
                           -fill 	=> "x",
		          			);							
	$flow_name_blue_w		->pack(
                           -side 	=> "left",
                           -fill 	=> "x",
		          			);                         
 	$flow_listbox_green_w		->pack(
                           -side => "left",
                           -fill 	=> "y",
                         );                          
	$flow_listbox_blue_w	->pack(
                            -fill => "y",
                            -side => "left",
                          );                                              
	
		# end of drag - keep this order
		# drop could go into L_SU
# 	$dropsite_token_grey= $flow_listbox_grey_w->DropSite(
#    				-droptypes   	=> [qw/Local/],
#					-dropcommand 	=> [\&_L_SU_flows,'drop','grey'], 
#				    -entercommand   => [\&_L_SU_flows,'increase_vigil_on_delete_counter','grey'],
# 					);
#                    #-postdropcommand => [\&decrease_vigil_on_delete_counter],
#
#		# start of drag - dropsite token must exist first
# 	$dnd_token_grey = $flow_listbox_grey_w->DragDrop(
#    				-event        => '<B1-Motion>',
#    				-sitetypes    => [qw/Local/],
#    				-startcommand => [\&_L_SU_flows,'drag','grey'],
#    				-cursor       => 'arrow',
#					);
#
#		# end of drag - keep this order
#		# drop could go into L_SU
# 	$dropsite_token_pink = $flow_listbox_pink_w->DropSite(
#    				-droptypes   	=> [qw/Local/],
#					-dropcommand 	=> [\&_L_SU_flows,'drop','pink'], 
#				    -entercommand   => [\&_L_SU_flows,'increase_vigil_on_delete_counter','pink'],
# 					);
#                    #-postdropcommand => [\&decrease_vigil_on_delete_counter],
#	
#		# start of drag - dropsite token must exist first
# 	$dnd_token_pink  = $flow_listbox_pink_w->DragDrop(
#    				-event        => '<B1-Motion>',
#    				-sitetypes    => [qw/Local/],
#    				-startcommand => [\&_L_SU_flows,'drag','pink'],
#    				-cursor       => 'arrow',
#					);
#	
#		# end of drag - keep this order
#		# drop could go into L_SU
# 	$dropsite_token_green = $flow_listbox_green_w->DropSite(
#    				-droptypes   	=> [qw/Local/],
#					-dropcommand 	=> [\&_L_SU_flows,'drop','green'], 
#				    -entercommand   => [\&_L_SU_flows,'increase_vigil_on_delete_counter','green'],
# 					);
#                    #-postdropcommand => [\&decrease_vigil_on_delete_counter],
#
#		# start of drag - dropsite token must exist first
# 	$dnd_token_green = $flow_listbox_green_w->DragDrop(
#    				-event        => '<B1-Motion>',
#    				-sitetypes    => [qw/Local/],
#    				-startcommand => [\&_L_SU_flows,'drag','green'],
#    				-cursor       => 'arrow',
#					);
#	
#		# end of drag - keep this order
#		# drop could go into L_SU
# 	$dropsite_token_blue = $flow_listbox_blue_w->DropSite(
#    				-droptypes   	=> [qw/Local/],
#					-dropcommand 	=> [\&_L_SU_flows,'drop','blue'], 
#				    -entercommand   => [\&_L_SU_flows,'increase_vigil_on_delete_counter','blue'],
# 					);
#                    #-postdropcommand => [\&decrease_vigil_on_delete_counter],
#	
#		# start of drag - dropsite token must exist first
# 	$dnd_token_blue = $flow_listbox_blue_w->DragDrop(
#    				-event        => '<B1-Motion>',
#    				-sitetypes    => [qw/Local/],
#    				-startcommand => [\&_L_SU_flows,'drag','blue'],
#    				-cursor       => 'arrow',
#					);


=head2 prepare

 34 to export hash ref

=cut
					
    $TkPl_SU->{_Data_menubutton}		= $Data_menubutton;
	$TkPl_SU->{_SaveAs_menubutton}		= $SaveAs_menubutton;
	$TkPl_SU->{_Flow_menubutton}		= $Flow_menubutton;
    $TkPl_SU->{_add2flow_button_grey}	= $add2flow_button_grey;
	$TkPl_SU->{_add2flow_button_pink}	= $add2flow_button_pink;
    $TkPl_SU->{_add2flow_button_green}	= $add2flow_button_green;
	$TkPl_SU->{_add2flow_button_blue}	= $add2flow_button_blue;
	$TkPl_SU->{_check_code_button}  	= $check_code_button;
	$TkPl_SU->{_delete_from_flow_button}= $delete_from_flow_button;	 
    $TkPl_SU->{_dnd_token_grey} 		= $dnd_token_grey;
    $TkPl_SU->{_dnd_token_pink} 		= $dnd_token_pink;
    $TkPl_SU->{_dnd_token_green} 		= $dnd_token_green;
    $TkPl_SU->{_dnd_token_blue} 		= $dnd_token_blue;
    $TkPl_SU->{_dropsite_token_grey} 	= $dropsite_token_grey;    
    $TkPl_SU->{_dropsite_token_pink} 	= $dropsite_token_pink;
    $TkPl_SU->{_dropsite_token_green} 	= $dropsite_token_green;
    $TkPl_SU->{_dropsite_token_blue} 	= $dropsite_token_blue;
 	$TkPl_SU->{_file_menubutton} 		= $file_menubutton;
 	$TkPl_SU->{_flow_item_down_arrow_button}= $flow_item_down_arrow_button;
 	$TkPl_SU->{_flow_item_up_arrow_button}= $flow_item_up_arrow_button;	
 	$TkPl_SU->{_flow_listbox_grey_w} 	= $flow_listbox_grey_w;
 	$TkPl_SU->{_flow_listbox_pink_w} 	= $flow_listbox_pink_w;
 	$TkPl_SU->{_flow_listbox_green_w} 	= $flow_listbox_green_w;
    $TkPl_SU->{_flow_listbox_blue_w} 	= $flow_listbox_blue_w;
    $TkPl_SU->{_flow_name_grey_w} 		= $flow_name_grey_w;			
	$TkPl_SU->{_flow_name_pink_w} 		= $flow_name_pink_w;			
	$TkPl_SU->{_flow_name_green_w} 		= $flow_name_green_w;
	$TkPl_SU->{_flow_name_blue_w} 		= $flow_name_blue_w;			
    $TkPl_SU->{_flowNsuperflow_name_w}  = $flowNsuperflow_name_w;
 	$TkPl_SU->{_message_w} 				= $message; 
  	$TkPl_SU->{_mw} 					= $mw;
  	$TkPl_SU->{_parameter_names_frame}	= $parameter_names_frame;
  	$TkPl_SU->{_parameter_values_frame}	= $parameter_values_frame; 
  	$TkPl_SU->{_parameter_values_button_frame} = $parameter_values_button_frame;
  	$TkPl_SU->{_run_button}				= $run_button;		          					 	
  	$TkPl_SU->{_save_button}			= $save_button;           		          		
	$TkPl_SU->{_sunix_listbox}			= $sunix_listbox;   # empty at first
	                 
    
    # send widgets to the main package from the current perl program 
    # one time BUT
    # transfer must also be repeated within each subroutine
    # outside MainLoop     	
	$L_SU				->set_hash_ref($TkPl_SU);
		# print("setting up first hash from TkPl_SU\n");
	$L_SU				->set_param_widgets();  # Initialize screen parameter names and values

 MainLoop;
 
  # used for help in pre-built superflows and help in user-built listbox flows
sub _L_SU_bindings {   # color not needed but $self is needed

	my ($self,$set_method) = @_;
					# print("1 main,_L_SU_bindings ,method:$set_method,\n");
	if ($set_method) {									
				
		$L_SU				->set_hash_ref($TkPl_SU);
					# print("2 main,_L_SU_bindings,method:$set_method\n");
		$L_SU->$set_method();
				
	} else {	
		print("main, _L_SU_bindings, no method name: $set_method error 1,\n");
	}
	
	return();
}
 

 	  # used for sunix_listbox help
sub _L_SU_sunix_bindings {
	my ($self,$method,$color,$prog_group) = @_;
					print("1 main,_L_SU_sunix_bindings, method:$method, color $color prog_group $prog_group \n");				
	if ($method && $color && $prog_group) {
		
		_set_prog_group($prog_group);
		$L_SU				->set_hash_ref($TkPl_SU);
					# print("main,_L_SU_sunix_bindings,method:$method\n");
					# print("main,_L_SU_sunix_bindings,color:$color\n");
					# sunix_select follows a 'neutral' color
		$L_SU				->set_flow_color($color);
		$L_SU				->user_built_flows($method);
		
				
	} else {	
		print("main, _L_SU_sunix_bindings, no method, color or group : $method error 1,\n");
	}
	
	return();
}
 
 	  # used for sunix_listbox help
sub _L_SU_flow_bindings {
	my ($self,$method,$color) = @_;
					#print("1 main,_L_SU_flow_bindings ,method:$method,\n");				
	if ($method && $color) {
		
		$L_SU				->set_hash_ref($TkPl_SU);
					# print("main,_L_SU_flow_bindings,method:$method\n");
					# print("main,_L_SU_flow_bindings,color:$color\n");
					# sunix_select follows a 'neutral' color
		$L_SU				->set_flow_color($color);
		$L_SU				->user_built_flows($method);
		
				
	} else {	
		print("main, _L_SU_flow_bindings, no method, color : $method error 1,\n");
	}
	
	return();
}

=head2 sub _L_SU_flow_bindings_any_color

 for any colored flow


=cut
 
 
sub _L_SU_flow_bindings_any_color {
	my ($self,$method) = @_;
					#print("1 main,_L_SU_flow_bindings ,method:$method,\n");				
	if ($method ) {
		$L_SU				->set_hash_ref($TkPl_SU);
					# print("main,_L_SU_flow_bindings,method:$method\n");
					# print("main,_L_SU_flow_bindings,value: any_color\n");
		$L_SU				->user_built_flows($method);
				
	} else {	
		print("main, _L_SU_flow_bindings, no method: $method error 1,\n");
	}
	
	return();
}


=head2 sub _L_SU_superflow_bindings

redirect user selections to L_SU.pm
for the case of: superflows and mouse-button bindings


=cut
 
 
sub _L_SU_superflow_bindings {
	my ($self,$set_method) = @_;
					# print("1 main,_L_SU,method:$set_method,\n");				
	if ($set_method ) {
			$L_SU				->set_hash_ref($TkPl_SU);
					# print("2 main,_L_SU, superflow_bindings,method:$set_method\n");
		$L_SU->$set_method();
				
	} else {	
		print("_L_SU,superflow_bindings, no method: $set_method error 1,\n");
	}
	
	return();
}

=head2 sub _L_SU

 invoke a method in L_SU from a button click

=cut

sub _L_SU {
	my ($set_method,$value) = @_;
					# print("1. main,_L_SU,method:$set_method, ref scalar value:$$value\n");
					# print("1 main,_L_SU,method:$set_method, scalar value:$value\n");				
	if ($set_method && $value) {
		$L_SU		->set_hash_ref($TkPl_SU);
					# print("2 main,_L_SU,method:$set_method, deref scalar value:$$value\n");
		$L_SU		->$set_method($value);
		
	} else {		
		print("main, _L_SU,no method: $set_method error 1,\n");
	}
	return();
}


=head2sub _L_SU_flows 

=cut 

sub _L_SU_flows {
	my ($method,$value) = @_;
					# print("1. main,_L_SU,method:$set_method, ref scalar value:$$value\n");
					# print("1 main,_L_SU,method:$method, scalar value:$value\n");				
	if ($method && $value) { # value is sref
			$L_SU				->set_hash_ref($TkPl_SU);
			$L_SU				->set_flow_color($value);
			$L_SU				->user_built_flows($method);
					 # print("2 main,_L_SU,method:$method, scalar value:$value, method: $method\n");
		
	} else {		
		print("main, _L_SU_flows, no method: method error 1,\n");
	}
	
	return();
}

=head2sub _L_SU_flows_any_color 

=cut 

sub _L_SU_flows_any_color {
	my ($method) = @_;
					# print("1. main,_L_SU,method:$set_method\n");				
	if ($method) { # value is sref
			$L_SU				->set_hash_ref($TkPl_SU);
			$L_SU				->user_built_flows($method);

					# print("2 main,_L_SU,method:$set_method, deref scalar value:$$value\n");
					# method = pre_built_sueprflow and value = Project or Sseg2su
		
	} else {		
		print("main, _L_SU_flows, no method: method error 1,\n");
	}
	
	return();
}

sub _L_SU_superflows {
	my ($set_method,$value) = @_;				
	if ($set_method && $value) { # value is sref
	
		$L_SU				->set_hash_ref($TkPl_SU);
		$L_SU				->$set_method($value);
		
	} else {		
		print("main,_L_SU_superflows,no method: $set_method error 1,\n");
	}
	
	return();
}

=head2 sub _set_prog_group

=cut

 sub _set_prog_group {
 	
	my ($prog_group) = @_;
		
	if 	($prog_group eq 'data') {
		$TkPl_SU->{_sunix_listbox}	= $sunix_data_programs_listbox;	
	} 
	elsif ($prog_group eq 'filter') {
		$TkPl_SU->{_sunix_listbox}	= $sunix_filter_programs_listbox;			
	}
	elsif ($prog_group eq 'model') {
		$TkPl_SU->{_sunix_listbox}	= $sunix_model_programs_listbox;			
	}
	elsif ($prog_group eq 'display') {
		$TkPl_SU->{_sunix_listbox}	= $sunix_display_programs_listbox;			
	}
	elsif ($prog_group eq 'metadata') {
		$TkPl_SU->{_sunix_listbox}	= $sunix_metadata_programs_listbox;			
	}
	elsif ($prog_group eq 'migration') {
		$TkPl_SU->{_sunix_listbox}	= $sunix_migration_programs_listbox;			
	}
	elsif ($prog_group eq 'statsMath') {
		$TkPl_SU->{_sunix_listbox}	= $sunix_statsMath_programs_listbox;			
	}
	elsif ($prog_group eq 'transform') {
		$TkPl_SU->{_sunix_listbox}	= $sunix_transform_programs_listbox;			
	}
	elsif ($prog_group eq 'velocity') {			
		$TkPl_SU->{_sunix_listbox}	= $sunix_velocity_programs_listbox;		
	} 
	else {		
		print("main,_set_prog_group, no prog_group\n");
	}
	
	return();
 }
