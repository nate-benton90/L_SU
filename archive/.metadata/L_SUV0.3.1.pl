=head1 DOCUMENTATION

$# delete thes lines int he final version

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
 	our $VERSION = '0.3.1';
 
 	use Tk;
 	use Tk::Pane;
 	use Tk::DragDrop;
 	use Tk::DropSite;
 	use L_SU 0.1.2;
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
	

 	@values					= qw//;
 	my @choices				= @{$var->{_sunix_choices}};

=head2 Default Tk settings{

 Create scoped hash 
 34 off

=cut

 my $TkPl_SU   = {
	_add2flow_button_grey			=> '',
	_add2flow_button_pink			=> '',
	_add2flow_button_green			=> '',
	_add2flow_button_blue			=> '',
	_check_code_button				=> '',
	_delete_from_flow_button		=> '',
	_dnd_token_grey					=> '',
	_dnd_tokenn_pink				=> '',
	_dnd_token_green				=> '',
	_dnd_token_blue					=> '',
	_dropsite_token_grey			=> '',
	_dropsite_token_pink			=> '',
	_dropsite_token_green			=> '',
	_dropsite_token_blue			=> '',
	_file_menubutton				=> '',
	_flow_listbox_grey_w			=> '',
	_flow_listbox_pink_w			=> '',
	_flow_listbox_green_w			=> '',
	_flow_listbox_blue_w			=> '',
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
                    
 	my $arial_italic  = $mw->fontCreate(
                  'arial_italic', 
                  -family => 'arial',
                  -weight => 'normal',
                  -slant  => 'italic',
                  -size   => -16);
  
                  
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

 	$top_menu_bar		-> bind('<ButtonRelease-3>' 
				=> [\&_L_SU_bindings,'help'],
				);
			

=head2 Top title reminders for Selected flow and Superflow names


=cut 


	my $top_menu_frame_spacer	 = $top_menu_frame->Label(
					-text 	    	=> '',
		   			-font 	   		=> $arial,
  	           		-height     	=> $var->{_one_character},
		   			-border     	=> $var->{_no_pixel},
                   	-width      	=> 0,
                   	-padx       	=> 0,
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
					-text 	    	=> ' Flow Name ',
		   			-font 	   		=> $arial_italic,
  	           		-height     	=> $var->{_one_character},
		   			-border     	=> $var->{_no_pixel},
                   	-width      	=> 0,
                   	-padx       	=> 0,
	                -height     		=> 1,
	                -width      		=> 11,
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
    $File_option[0] =  $file_dialog_type->{_Data}; 
    $File_option[1] =  $file_dialog_type->{_Flow};
    $File_option[2] =  $file_dialog_type->{_SaveAs};


 	$file_menubutton	->command(
    			  		-label       	=> @$alias_FileDialog_button_label[0],
    			  		-underline   	=> 0,
			  			-command      	=>[\&_L_SU,'FileDialog_button',\$File_option[0]],
    			  		-font 			=>$arial
 						);
					
	$file_menubutton	->separator;
 	$file_menubutton	->command(
    			  		-label       	=> @$alias_FileDialog_button_label[1],
    			  		-underline   	=> 0,
			  			-command      	=>[\&_L_SU,'FileDialog_button',\$File_option[1]],
    			  		-font 			=>$arial
 						);
						
	$file_menubutton	->separator;
 	$file_menubutton	->command(
   			  			-label       	=> @$alias_FileDialog_button_label[2],
    			  		-underline   	=> 0,
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
			   				-command     		=> [\&_L_SU,'run_button',1],
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
			   				-command    		=> [\&_L_SU,'save_button','Save'],
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
			   				-command    		=> [\&_L_SU,'check_code_button',1],
		          			);

	      			
=head2 top_titles frame

 just above the work frame
 contains Titles only 

=cut
      
 	my $top_titles_label	= $top_titles_frame  ->Label(
						-text 	    	=> '         Parameter Names                                     Values',
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

=head2 tied listbox widgets

 to a tool_array
 for easier management

=cut

 	$delete_from_flow_button	-> bind('<1>' 
   					=> [\&_L_SU_flow_bindings_any_color,'delete_from_flow_button'],
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
  
  This binding occurs inside L_SU.pm

=cut

 	$sunix_listbox	-> bind('<1>' 
			=> [\&_L_SU_flow_bindings,'sunix_select','neutral']     
                       	);
 	$sunix_listbox	-> bind('<3>' 
			=> [\&_L_SU_flow_bindings,'help','neutral']     
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
			-width			=> 450,
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


=head2 message area 

      to notify user of important evets 

=cut

 	my $message	= $work_frame->Text(
                	-height 			=> 3,
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

 on far right of work frame

=cut


	my $flow_name_grey_w	 = $flow_control_frame_names4top_row->Label(
					-text 	    	=> ' grey name ',
		   			-font 	   		=> $arial_italic,
  	           		-height     	=> $var->{_one_character},
		   			-border     	=> $var->{_no_pixel},
                   	-width      	=> 0,
                   	-padx       	=> 0,
	                -padx	    		=> $var->{_five_pixels},
                    -background 		=> $var->{_my_yellow},
 					-foreground 		=> $var->{_my_black},
					-disabledforeground => $var->{_my_dark_grey},
					-activeforeground 	=> $var->{_my_white},
					-activebackground 	=> $var->{_my_dark_grey},                   
    		        -relief 			=> 'flat',
    		        -state 				=> 'disabled',
		          );


	my $flow_name_pink_w	 = $flow_control_frame_names4top_row->Label(
					-text 	    	=> 'pink name ',
		   			-font 	   		=> $arial_italic,
  	           		-height     	=> $var->{_one_character},
		   			-border     	=> $var->{_no_pixel},
                   	-width      	=> 0,
                   	-padx       	=> 0,
	                -padx	    		=> $var->{_five_pixels},
                    -background 		=> $var->{_my_yellow},
 					-foreground 		=> $var->{_my_black},
					-disabledforeground => $var->{_my_dark_grey},
					-activeforeground 	=> $var->{_my_white},
					-activebackground 	=> $var->{_my_dark_grey},                   
    		        -relief 			=> 'flat',
    		        -state 				=> 'disabled',
		          );


	my $flow_name_green_w = $flow_control_frame_names4bottom_row->Label(
					-text 	    	=> ' green name ',
		   			-font 	   		=> $arial_italic,
  	           		-height     	=> $var->{_one_character},
		   			-border     	=> $var->{_no_pixel},
                   	-width      	=> 0,
                   	-padx       	=> 0,
	                -padx	    		=> $var->{_five_pixels},
                    -background 		=> $var->{_my_yellow},
 					-foreground 		=> $var->{_my_black},
					-disabledforeground => $var->{_my_dark_grey},
					-activeforeground 	=> $var->{_my_white},
					-activebackground 	=> $var->{_my_dark_grey},                   
    		        -relief 			=> 'flat',
    		        -state 				=> 'disabled',
		          );


	my $flow_name_blue_w = $flow_control_frame_names4bottom_row->Label(
					-text 	    	=> 'blue name ',
		   			-font 	   		=> $arial_italic,
  	           		-height     	=> $var->{_one_character},
		   			-border     	=> $var->{_no_pixel},
                   	-width      	=> 0,
                   	-padx       	=> 0,
	                -padx	    		=> $var->{_five_pixels},
                    -background 		=> $var->{_my_yellow},
 					-foreground 		=> $var->{_my_black},
					-disabledforeground => $var->{_my_dark_grey},
					-activeforeground 	=> $var->{_my_white},
					-activebackground 	=> $var->{_my_dark_grey},                   
    		        -relief 			=> 'flat',
    		        -state 				=> 'disabled',
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
						-selectforeground	=> $var->{_my_white},
						-selectbackground 	=> $var->{_my_dark_grey},
						-state				=> 'disabled',
                      	   );

=head2 tied listbox widgets

  to a tool_array
  for easier management
  
  # could also be done in L_SU.pm/param_widgets

=cut

 	$flow_listbox_grey_w	-> bind('<1>' 
				=> [\&_L_SU_flow_bindings,'flow_select','grey'],  
                       );
 	$flow_listbox_grey_w-> bind('<3>' 
				=> [\&_L_SU_bindings,'help']      
                       );

 	$flow_listbox_pink_w	-> bind('<1>' 
				=> [\&_L_SU_flow_bindings,'flow_select','pink'],  
                       );
 	$flow_listbox_pink_w-> bind('<3>' 
				=> [\&_L_SU_bindings,'help']     
                       );

 	$flow_listbox_green_w	-> bind('<1>' 
				=> [\&_L_SU_flow_bindings,'flow_select','green'],  
                       );
 	$flow_listbox_green_w-> bind('<3>' 
				=> [\&_L_SU_bindings,'help']     
                       );
 
 	$flow_listbox_blue_w	-> bind('<1>' 
				=> [\&_L_SU_flow_bindings,'flow_select','blue'],  
                       );
 	$flow_listbox_blue_w-> bind('<3>' 
				=> [\&_L_SU_bindings,'help']     
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
	$sunix_listbox		->pack(
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
 	$dropsite_token_grey= $flow_listbox_grey_w->DropSite(
    				-droptypes   	=> [qw/Local/],
					-dropcommand 	=> [\&_L_SU_flows,'drop','grey'], 
				    -entercommand   => [\&_L_SU_flows,'increase_vigil_on_delete_counter','grey'],
 					);
                    #-postdropcommand => [\&decrease_vigil_on_delete_counter],

		# start of drag - dropsite token must exist first
 	$dnd_token_grey = $flow_listbox_grey_w->DragDrop(
    				-event        => '<B1-Motion>',
    				-sitetypes    => [qw/Local/],
    				-startcommand => [\&_L_SU_flows,'drag','grey'],
    				-cursor       => 'arrow',
					);

		# end of drag - keep this order
		# drop could go into L_SU
 	$dropsite_token_pink = $flow_listbox_pink_w->DropSite(
    				-droptypes   	=> [qw/Local/],
					-dropcommand 	=> [\&_L_SU_flows,'drop','pink'], 
				    -entercommand   => [\&_L_SU_flows,'increase_vigil_on_delete_counter','pink'],
 					);
                    #-postdropcommand => [\&decrease_vigil_on_delete_counter],
	
		# start of drag - dropsite token must exist first
 	$dnd_token_pink  = $flow_listbox_pink_w->DragDrop(
    				-event        => '<B1-Motion>',
    				-sitetypes    => [qw/Local/],
    				-startcommand => [\&_L_SU_flows,'drag','pink'],
    				-cursor       => 'arrow',
					);
	
		# end of drag - keep this order
		# drop could go into L_SU
 	$dropsite_token_green = $flow_listbox_green_w->DropSite(
    				-droptypes   	=> [qw/Local/],
					-dropcommand 	=> [\&_L_SU_flows,'drop','green'], 
				    -entercommand   => [\&_L_SU_flows,'increase_vigil_on_delete_counter','green'],
 					);
                    #-postdropcommand => [\&decrease_vigil_on_delete_counter],

		# start of drag - dropsite token must exist first
 	$dnd_token_green = $flow_listbox_green_w->DragDrop(
    				-event        => '<B1-Motion>',
    				-sitetypes    => [qw/Local/],
    				-startcommand => [\&_L_SU_flows,'drag','green'],
    				-cursor       => 'arrow',
					);
	
		# end of drag - keep this order
		# drop could go into L_SU
 	$dropsite_token_blue = $flow_listbox_blue_w->DropSite(
    				-droptypes   	=> [qw/Local/],
					-dropcommand 	=> [\&_L_SU_flows,'drop','blue'], 
				    -entercommand   => [\&_L_SU_flows,'increase_vigil_on_delete_counter','blue'],
 					);
                    #-postdropcommand => [\&decrease_vigil_on_delete_counter],
	
		# start of drag - dropsite token must exist first
 	$dnd_token_blue = $flow_listbox_blue_w->DragDrop(
    				-event        => '<B1-Motion>',
    				-sitetypes    => [qw/Local/],
    				-startcommand => [\&_L_SU_flows,'drag','blue'],
    				-cursor       => 'arrow',
					);


=head2 prepare

to export hash ref

=cut
					
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
 	$TkPl_SU->{_flow_listbox_grey_w} 	= $flow_listbox_grey_w;
 	$TkPl_SU->{_flow_listbox_pink_w} 	= $flow_listbox_pink_w;
 	$TkPl_SU->{_flow_listbox_green_w} 	= $flow_listbox_green_w;
    $TkPl_SU->{_flow_listbox_blue_w} 	= $flow_listbox_blue_w;
    $TkPl_SU->{_flowNsuperflow_name_w}  = $flowNsuperflow_name_w;
 	$TkPl_SU->{_message_w} 				= $message; 
  	$TkPl_SU->{_mw} 					= $mw;
  	$TkPl_SU->{_parameter_names_frame}	= $parameter_names_frame;
  	$TkPl_SU->{_parameter_values_frame}	= $parameter_values_frame; 
  	$TkPl_SU->{_parameter_values_button_frame} = $parameter_values_button_frame;
  	$TkPl_SU->{_run_button}				= $run_button;		          					 	
  	$TkPl_SU->{_save_button}			= $save_button;           		          		
	$TkPl_SU->{_sunix_listbox}			= $sunix_listbox;                  
    
    # send widgets to the main package from the current perl program 
    # once but then is lost and must be repeated within each subroutine
    # outside MainLoop     	
	$L_SU				->set_hash_ref($TkPl_SU);
		# print("setting up first hash from TkPl_SU\n");
	$L_SU				->set_param_widgets();  # Initialize screen parameter names and values

 MainLoop;
 
  
sub _L_SU_bindings {   # color not needed but $self is needed
	my ($self,$set_method) = @_;
					# print("1 main,_L_SU_bindings ,method:$set_method,\n");				
	if ($set_method ) {
			$L_SU				->set_hash_ref($TkPl_SU);
					# print("2 main,_L_SU_bindings,method:$set_method\n");
		$L_SU->$set_method();
				
	} else {	
		print("main, _L_SU_bindings, no method: $set_method error 1,\n");
	}
	
	return();
}
 
 
 
sub _L_SU_flow_bindings {
	my ($self,$method,$color) = @_;
					#print("1 main,_L_SU_flow_bindings ,method:$method,\n");				
	if ($method ) {
		$L_SU				->set_hash_ref($TkPl_SU);
					# print("main,_L_SU_flow_bindings,method:$method\n");
					# print("main,_L_SU_flow_bindings,color:$color\n");
		$L_SU				->set_flow_color($color);
		$L_SU				->user_built_flows($method);
				
	} else {	
		print("main, _L_SU_flow_bindings, no method: $method error 1,\n");
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

sub _L_SU {
	my ($set_method,$value) = @_;
					# print("1. main,_L_SU,method:$set_method, ref scalar value:$$value\n");
					# print("1 main,_L_SU,method:$set_method, scalar value:$value\n");				
	if ($set_method && $value) {
		$L_SU				->set_hash_ref($TkPl_SU);
					#print("2 main,_L_SU,method:$set_method, ref scalar value:$$value\n");
					# print("2 main,_L_SU,method:$set_method, scalar value:$value\n");
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
					# print("1 main,_L_SU,method:$set_method, scalar value:$value\n");				
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
