package grey_flow;

=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL PACKAGE NAME: grey_flow.pm
 AUTHOR: 	Juan Lorenzo
 DATE: 		June 8 2018 

 DESCRIPTION 
     

 BASED ON:
 previous versions of the main userBuiltFlow.pl
  

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
 	our $VERSION = '0.0.2';
 	extends 'color_flow';	 
	
1;