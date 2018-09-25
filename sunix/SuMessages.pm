package SuMessages;

use Moose;

=head1 DOCUMENTATION

=head2 SYNOPSIS 
PACKAGE NAME: SuMessages 
 AUTHOR: Juan Lorenzo
         July 29 2015

 DESCRIPTION: 
 Version: 1.1
 Version: 1.11 : June 12 2007 
   Include messages for interactive bottom mute
 Messages to users in Seismic unix programs

=head2 USE

=head3 NOTES 

=head4 
 Examples

=head3 SEISMIC UNIX NOTES  

=head4 CHANGES and their DATES

=cut

=head2

=head3 STEPS

 1. define the types of variables you are using
    these would be the values you enter into 
    each of the Seismic Unix programs  each of the 
    Seismic Unix programs

 2. build a list or hash with all the possible variable
    names you may use and you can even change them

=cut

=head2

set defaults

VELAN DATA 
 m/s

 
=cut

 my $SuMessages = {
          _cdp_num     			=>'',
          _gather_num     		=>'',
          _gather_type     		=>'',
          _binheader_type     		=>'',
          _type     			=>'',
          _instructions     		=>''
        };

=head2 subroutine clear

  sets all variable strings to '' 

=cut

sub clear {

    $SuMessages->{_cdp_num} 			= '';
    $SuMessages->{_gather_num} 			= '';
    $SuMessages->{_gather_type} 		= '';
    $SuMessages->{_binheader_type} 		= '';
    $SuMessages->{_type} 			= '';
    $SuMessages->{_instructions} 		= '';
};



=head2 subroutine cdp_num

  sets cdp number to consider  

=cut

sub cdp_num {
   my($variable,$cdp_num)  	= @_;
   $SuMessages->{_cdp_num} 	= $cdp_num if defined ($cdp_num);
   #print("\ncdp num is $SuMessages->{_cdp_num}\n");
}

=head2 subroutine binheader_type

  sets binheader type to consider  

=cut

sub binheader_type {
   my($variable,$binheader_type)  	= @_;
   $SuMessages->{_binheader_type} 	= $binheader_type if defined ($binheader_type);
   #print("\nbinheader_type is $SuMessages->{_binheader_type}\n");
}


=head2 subroutine gather_type

  sets gather type to consider  

=cut

sub gather_type {
   my($variable,$gather_type)  	= @_;
   $SuMessages->{_gather_type} 	= $gather_type if defined ($gather_type);
   #print("\n_gather_type is $SuMessages->{_gather_type}\n");
}


=head2 subroutine gather_num

  sets gather number to consider  

=cut

sub gather_num {
   my($variable,$gather_num)  	= @_;
   $SuMessages->{_gather_num} 	= $gather_num if defined ($gather_num);
   #print("\ngather num is $SuMessages->{_gather_num}\n");
}


=head2

 sub set
   establishes the family type of messages

   e.g., velocity analysis
         sutaup  etc.

=cut

sub set {
    my ($variable,$message_type) = @_;
    $SuMessages->{_type}         = $message_type if defined($message_type);
    #print("Message type is $SuMessages->{_type}\n\n");
}


=head2

 sub type 
   redirection for a given family type of message 
   e.g., velocity analysis
         sutaup  etc.

=cut

sub instructions {
    my ($variable,$instructions) = @_;
    $SuMessages->{_instructions} = $instructions if defined($instructions);
    #print("instructions are $SuMessages->{_instructions}\n\n");
   
=head2 CASE:

  empty types

=cut 
    if ($SuMessages->{_type} eq '') {
    print("Warning: message type not set in SuMessages->instructions\n\n");
      }

=head2 CASE:

  interactive spectral analysis 

=cut 

    if ($SuMessages->{_type} eq 'iSpectralAnalysis') { 

       if($SuMessages->{_instructions} eq 'firstSpectralAnalysis') {

       	      print("\n   GATHER = $SuMessages->{_gather_num}\n\n");
		print("  1. PICK two(2) X-T pairs\n"); 
                print("  2. Quit window*\n"); 
		print("  3. Click CALC \n\n\n"); 
	        print("  (*To FINISH picking in window, enter: q \n");
                print("    while mouse lies over image)\n");
                print("LSULSULSULSULSULSULSULSULSULSULSULSULSULSU\n");

         } # end first spectral analysis instructions
     }

=head2 CASE:

  interactive velocity analysis 

=cut 

    if ($SuMessages->{_type} eq 'iva') { 

       if($SuMessages->{_instructions} eq 'first_velan') {

       	      print("\n   CDP = $SuMessages->{_cdp_num}\n\n");
		print("   Click PICK  (if you want to pick V-T pairs) \n"); 
		print("   or Click NEXT  (next CDP)\n\n");
                print("LSULSULSULSULSULSULSULSULSULSULSULSULSULSU\n");

         } # end first-velan instructions

       if($SuMessages->{_instructions} eq 'pre_pick_velan') {
		print("  1. PICK V-T pairs\n"); 
                print("  2. Quit window*\n"); 
		print("  3. Click CALC \n\n\n"); 
	        print("  (*To FINISH picking in window, enter: q \n");
                print("    while mouse lies over image)\n");
                print("LSULSULSULSULSULSULSULSULSULSULSULSULSULSU\n");

          }  # end 'pre_pick_velan' instructions

     if($SuMessages->{_instructions} eq 'post_pick_velan') {

       	print("\tCDP = $SuMessages->{_cdp_num}\n\n");
                print(" Are you HAPPY with these picks? \n");
 		print("\n");
		print(" If NOT:  \n");
                print("  1. RE-PICK the V-T pairs  \n"); 
		print("  2. Quit window*, and \n"); 
                print("  3. Click CALC\n\n"); 
		print(" If SATISFIED:\n"); 
                print("  1. Quit window*,\n");
                print("  2. Click NEXT to go to next CDP  \n");
		print("  or Click EXIT    \n\n\n");
	        print("  (*To FINISH picking in window, enter: q \n");
                print("    while mouse lies over image)\n");
                print("LSULSULSULSULSULSULSULSULSULSULSULSULSULSU\n");

        return();

        }   # end post-pick velan 
  }   # end iva-type instructions 

=head2 CASE:

  Interactive  top mute picking 

=cut 

    if($SuMessages->{_type} eq 'iTopMute') { 

       if($SuMessages->{_instructions} eq 'first_top_mute') {

       	      print("\n  $SuMessages->{_gather_type}  GATHER  = $SuMessages->{_gather_num}\n\n");
	      print("   Click PICK  (if you want to pick X-T pairs) \n"); 
	      print("   or Click NEXT  (next GATHER)\n\n");
              print("LSULSULSULSULSULSULSULSULSULSULSULSULSULSU\n");

         }

       if($SuMessages->{_instructions} eq 'pre_pick_mute') {
		print("  1. PICK X-T pairs\n"); 
                print("  2. Quit window*\n"); 
		print("  3. Click CALC \n\n\n"); 
	        print("  (*To FINISH picking in window, enter: q \n");
                print("    while mouse lies over image)\n");
                print("LSULSULSULSULSULSULSULSULSULSULSULSULSULSU\n");
         }

       if($SuMessages->{_instructions} eq 'post_pick_mute') {

       	print("\t $SuMessages->{_gather_type} GATHER = $SuMessages->{_gather_num}\n\n");
                print(" Are you HAPPY with these picks? \n");
 		print("\n");
		print(" If NOT:  \n");
                print("  1. PICK the X-T pairs  \n"); 
		print("  2. Quit window*, and \n"); 
                print("  3. Click CALC\n\n"); 
		print(" If SATISFIED:\n"); 
                print("  1. Quit window*,\n");
                print("  2. Click NEXT to go to next CDP  \n");
		print("  or Click EXIT    \n\n");
                print("LSULSULSULSULSULSULSULSULSULSULSULSULSULSU\n");

       return();

       }   # end post-pick mute 
        #return();
    } # end top mute instructions


=head2 CASE:

  Interactive  bottom mute picking 

=cut 

   if($SuMessages->{_type} eq 'iBottomMute') { 

       if($SuMessages->{_instructions} eq 'first_bottom_mute') {

       	      print("\n  $SuMessages->{_gather_type}  GATHER  = $SuMessages->{_gather_num}\n\n");
	      print("   Click PICK  (if you want to pick X-T pairs) \n"); 
	      print("   or Click NEXT  (next GATHER)\n\n");
              print("LSULSULSULSULSULSULSULSULSULSULSULSULSULSU\n");

         }

       if($SuMessages->{_instructions} eq 'pre_pick_mute') {
		print("  1. PICK X-T pairs\n"); 
                print("  2. Quit window*\n"); 
		print("  3. Click CALC \n\n\n"); 
	        print("  (*To FINISH picking in window, enter: q \n");
                print("    while mouse lies over image)\n");
                print("LSULSULSULSULSULSULSULSULSULSULSULSULSULSU\n");
         }

       if($SuMessages->{_instructions} eq 'post_pick_mute') {

       	print("\t $SuMessages->{_gather_type} GATHER = $SuMessages->{_gather_num}\n\n");
                print(" Are you HAPPY with these picks? \n");
 		print("\n");
		print(" If NOT:  \n");
                print("  1. PICK the X-T pairs  \n"); 
		print("  2. Quit window*, and \n"); 
                print("  3. Click CALC\n\n"); 
		print(" If SATISFIED:\n"); 
                print("  1. Quit window*,\n");
                print("  2. Click NEXT to go to next CDP  \n");
		print("  or Click EXIT    \n\n");
                print("LSULSULSULSULSULSULSULSULSULSULSULSULSULSU\n");

       return();

       }   # end post-pick mute 
        #return();
    } # end bottom mute instructions




} # end sub instructions

1;
