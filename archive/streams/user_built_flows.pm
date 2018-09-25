package user_built_flows;

=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL PACKAGENAME: user_built_in_flows 
 AUTHOR: 	Juan Lorenzo
 DATE: 		2018 
 VERSION:   1.01
 
 DESCRIPTION Package containing methods
 and objects for dealing with user-built
 flows
     

 BASED ON:
 LSU.pl version 1.02 
     
     refactored LSU.pl
     
=cut

=head2 USE

=head3 NOTES

=head4 Examples

=head3 

=head2 CHANGES and their DATES

=cut 

=head2 Notes from bash
 
=cut

 use Moose;
 our $VERSION = '1.0.1';
 
 
=head2 declare needed classes

=cut

	use param_sunix;
	use param_widgets;
	use whereami;
 
 
=head2 instantiate declared classes

=cut 

	my $param_sunix        	= param_sunix->new();
 	my $param_widgets		= param_widgets->new();
	my $whereami           	= whereami->new();


=head private hash

=cut

 	my $user_built_flows =	{
 		_prog_name				=> '', 		
 		_message_box_w			=> '',
 		_sunix_listbox_w 		=> '',
 	};
 

=head2 sub add2flow_button 


=cut

sub add2flow_button {
	my $last_item;
  	my $here;
 
 	use L_SU::messages::message_director;
	my $user_built_flows_messages 	    = message_director->new();
  	
  	my $message          				= $user_built_flows_messages->null_button(0);
 	$user_built_flows->{_message_box_w}	->delete("1.0",'end');
 	$user_built_flows->{_message_box_w}	->insert('end', $message);
 	
	my $flow_listbox					= $user_built_flows->{_flow_listbox_w};
	my $prog_name						= $user_built_flows->{_prog_name};
	my $sunix_listbox					= $user_built_flows->{_sunix_listbox_w};
	
    $whereami		->set4add2flow_button();

	_conditions		->set4start_of_add2flow_button();

   	$whereami		->set4flow_listbox();

       		# clear all the indices of selected elements   
   	$flow_listbox	->selectionClear($sunix_listbox->curselection);

			# add the most recently selected program
			# name (scalar reference) to the 
			# end of the list 
    
   	$flow_listbox    ->insert(
                       	"end", 
                       	${$prog_name},
	               );

   				# display default paramters in the GUI
    			# same as for sunix_select
    			# can not get program name from the item selected in the sunix list box 
    			# because focus is transferred to another list box
      
   	$param_sunix   					->set_program_name($user_built_flows->{_prog_name});
   	$user_built_flows->{_names_aref}  		= $param_sunix->get_names();
   	$user_built_flows->{_values_aref} 		= $param_sunix->get_values();
   	$user_built_flows->{_check_buttons_settings_aref}  	= $param_sunix->get_check_buttons_settings();
   	$user_built_flows->{_param_sunix_first_idx}  		= $param_sunix->first_idx(); # first index = 0
   	$user_built_flows->{_param_sunix_length}  			= $param_sunix->length(); # # values not index 

   	$whereami			->set4add2flow_button();
   	$here                = $whereami->get4add2flow_button();
   	$param_widgets       ->set_location_in_gui($here);

   	$param_widgets		->range($user_built_flows);
   	$param_widgets		->set_labels($user_built_flows->{_names_aref});
   	$param_widgets		->set_values($user_built_flows->{_values_aref});
   	$param_widgets		->set_check_buttons(
					$user_built_flows->{_check_buttons_settings_aref});
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

	_conditions->set4end_of_add2flow_button();
						 # print("main,add2flow_button,last left flow program touched had index = $user_built_flows->{_last_flow_index_touched}\n");
						
   	return(); 
}





=head2 sub set_flow_listbox
 
=cut
 
 sub set_flow_listbox_w {
 	my (@self,$flow_listbox_href) 		= @_; 	
 	$user_built_flows->{_flow_listbox_w} = $flow_listbox_href->{_flow_listbox_w};
 	 			print("user_built_flows,set_sunix_listbox: $user_built_flows->{_flow_listbox_w}\n");
 	return();	
 }

 
=head2 sub set_message_box_w 
 
=cut
 
 sub set_message_box_w {
 	my (@self,$message_box_href) 		= @_;	
 	$user_built_flows->{_message_box_w} = $message_box_href->{_message_box_w};
 				print("user_built_flows,set_message_box_w: $user_built_flows->{_message_box_w}\n");
 	return();
 }
 
 
=head2 sub set_prog_name
 
=cut 
 
 sub set_prog_name {
 	my (@self,$prog_name_href) 		= @_; 	
 	$user_built_flows->{_prog_name} = $prog_name_href->{_prog_name};
 	 			print("user_built_flows,set_prog_name: $user_built_flows->{_prog_name}\n");
 	return();	
 }
 
 
=head2 sub set_sunix_listbox
 
=cut
 
 sub set_sunix_listbox {
 	my (@self,$sunix_listbox_href) 		= @_; 	
 	$user_built_flows->{_sunix_listbox_w} = $sunix_listbox_href->{_sunix_listbox_w};
 	 			print("user_built_flows,set_sunix_listbox: $user_built_flows->{_sunix_listbox_w}\n");
 	return();	
 }
 1;