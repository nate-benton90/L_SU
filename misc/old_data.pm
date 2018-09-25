package old_data;

use Moose;

=pod

=head1 DOCUMENTATION

=head2 SYNOPSIS 


 PACKAGE NAME: old_data 
 AUTHOR: Juan Lorenzo
 DATE:  Sept. 18 2015 

 DESCRIPTION: 
 Version: 1.1
 Package used to locate pre-exisitng data sets

=head2 USE

=head3 NOTES 

=head4 
Examples

=head3 SEISMIC UNIX NOTES  

=head4 CHANGES and their DATES


=cut

=pod

=head3 STEPS

 1. define the types of variables you are using
    these would be the values you enter into 
    each of the Seismic Unix programs  each of the 
    Seismic Unix programs

 2. build a list or hash with all the possible variable
    names you may use and you can even change them

=cut

my $old_data = {
          _TX_inbound 	       =>'',
          _TX_outbound 	       =>'',
          _Tvel_inbound        =>'',
          _Tvel_outbound       =>'',
          _cdp_num 	       =>'',
          _gather_num 	       =>'',
	  _exists              =>'',
	  _textfile_in         =>'',
	  _textfile_out        =>'',
          _type                =>''
        };

=head3

 Import file-name  and directory definitions

=cut 

  use SeismicUnix qw ($on $off $in $to $go $itemp_top_mute_picks_ $itemp_top_mute_picks_ $itop_mute_par_ $itemp_top_mute_picks_sorted_par_ $itop_mute_check_pickfile_  $false $true $suffix_su $suffix_su);

=head2 

 other needed packages

=cut

   use Project;
  my $Project = new Project();
  use manage_files_by2;

  my ($PL_SEISMIC) 	= $Project->PL_SEISMIC();

=pod

 instantiate packages 

=cut

  my $test                              = new manage_files_by2();

=head2 subroutine clear

  sets all variable strings to '' 

=cut

sub clear {
    $old_data->{_TX_inbound} 			= '';
    $old_data->{_TX_outbound} 			= '';
    $old_data->{_Tvel_inbound} 			= '';
    $old_data->{_Tvel_outbound} 		= '';
    $old_data->{_cdp_num} 			= '';
    $old_data->{_gather_num} 			= '';
    $old_data->{_exists} 			= '';
    $old_data->{_textfile_in} 			= '';
    $old_data->{_textfile_out} 			= '';
    $old_data->{_type} 				= '';
};

 my ($file_existence1,$file_existence2);
 my ($ans,$itop_mute_picks,$itop_mute_par);
 my @answers;

=head2 subroutine cdp

  sets cdp number to consider  

=cut

sub cdp_num {
   my($variable,$cdp_num)  	= @_;
   $old_data->{_cdp_num} 	= $cdp_num if defined ($cdp_num);
   $old_data->{_cdp_num_suffix} = '_cdp'.$old_data->{_cdp_num}
}

=head2 subroutine gather

  sets gather number to consider  

=cut

sub gather_num {
   my($variable,$gather_num)  	= @_;
   $old_data->{_gather_num} 	= $gather_num if defined ($gather_num);
   $old_data->{_gather_num_suffix} = '_gather'.$old_data->{_gather_num}
}



=head3 subroutine file_in

 Required file name
 on which to pick top mute values

=cut

sub file_in {
    my ($variable,$file_in) 	= @_;
    $old_data->{_file_in} 	= $file_in if defined($file_in); 
    #print("file name is $old_data->{_file_in} \n\n");
}


=head3 sub type

  switches for old data of two different types

   for type: velan
      test whether previous velan pick files exist
   textfile_in: ivpicks_old

   for type: Top_mute
      test whether previous mute pick files exist

   for type: iSpectralAnalysis 
      test whether previous spectral analyses picks files exist


=cut

sub type {
   my($variable,$type)  = @_;
   $old_data->{_type}   = $old_data if defined($old_data);


  if($old_data->{_type} eq 'iSpectralAnalysis') { 
      $old_data->{_textfile_in}	   = 'waveform'.'_'.$old_data->{_file_in}.$old_data->{_cdp_num_suffix} if defined($old_data);
     $old_data->{_Tvel_inbound}      = $PL_SEISMIC.'/'.$old_data->{_textfile_in} if defined(($old_data && $PL_SEISMIC )); 
      $ans                         = $test->does_file_exist(\$old_data->{_Tvel_inbound} );

     $old_data->{_textfile_out}    = 'ivpicks_'.$old_data->{_file_in}.$old_data->{_cdp_num_suffix} if defined(($old_data && ($old_data->{_file_in} && $old_data->{_cdp_num_suffix}))); 
     $old_data->{_Tvel_outbound}     = $PL_SEISMIC.'/'.$old_data->{_textfile_out} if defined(($old_data && $PL_SEISMIC )); 
     #print("Tvel out is $old_data->{_Tvel_outbound}\n\n");
     #print("Tvel in is $old_data->{_Tvel_inbound}\n\n");
     return ($ans);
    } 

  if($old_data->{_type} eq 'velan') { 
      $old_data->{_textfile_in}	   = 'ivpicks_old'.'_'.$old_data->{_file_in}.$old_data->{_cdp_num_suffix} if defined($old_data);
     $old_data->{_Tvel_inbound}      = $PL_SEISMIC.'/'.$old_data->{_textfile_in} if defined(($old_data && $PL_SEISMIC )); 
      $ans                         = $test->does_file_exist(\$old_data->{_Tvel_inbound} );

     $old_data->{_textfile_out}    = 'ivpicks_'.$old_data->{_file_in}.$old_data->{_cdp_num_suffix} if defined(($old_data && ($old_data->{_file_in} && $old_data->{_cdp_num_suffix}))); 
     $old_data->{_Tvel_outbound}     = $PL_SEISMIC.'/'.$old_data->{_textfile_out} if defined(($old_data && $PL_SEISMIC )); 
     #print("Tvel out is $old_data->{_Tvel_outbound}\n\n");
     #print("Tvel in is $old_data->{_Tvel_inbound}\n\n");
     return ($ans);
    } 

=pod
  
 test whether previous mute pick files exist

=cut 

 if($old_data->{_type} eq 'TopMute') {
     $old_data->{_textfile_in}	   = $itemp_top_mute_picks_sorted_par_.$old_data->{_file_in}.$old_data->{_gather_num_suffix} ;
     $old_data->{_TX_inbound}      = $PL_SEISMIC.'/'.$old_data->{_textfile_in} if defined(($old_data && $PL_SEISMIC )); 
      $ans                         = $test->does_file_exist(\$old_data->{_TX_inbound} );

     $old_data->{_textfile_out}    = 'ivpicks_'.$old_data->{_file_in}.$old_data->{_gather_num_suffix} if defined(($old_data && ($old_data->{_file_in} && $old_data->{_gather_num_suffix}))); 
     $old_data->{_TX_outbound}     = $PL_SEISMIC.'/'.$old_data->{_textfile_out} if defined(($old_data && $PL_SEISMIC )); 
     #print("TX out is $old_data->{_TX_outbound}\n\n");
     #print("TX in is $old_data->{_TX_inbound}\n\n");
     return ($ans);
   }

=pod

  file name definitions


  $itop_mute_picks 	= $PL_SEISMIC.'/'.$itop_mute_check_pickfile_.$old_data->{_file_in};

  $itop_mute_par         = $PL_SEISMIC.'/'.$itop_mute_par_.$old_data->{_file_in};

#	 set defaults
#         Do old mute files exist 
#         that can be  applied? 
	$file_existence1 = $false;
	$file_existence2 = $false;

        ($file_existence1) = $test->does_file_exist(\$itop_mute_picks);
	
        ($file_existence2) = $test->does_file_exist(\$itop_mute_par);
$answers[1]                          = $file_existence1;
$answers[2]                          = $file_existence2;

return $old_data->{_find};

=cut

} #end subroutine type

1;
