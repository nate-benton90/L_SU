package sumute;

use Moose;
use SeismicUnix qw($itop_mute_par_ $ibot_mute_par_);

=pod

=head1 DOCUMENTATION

=head2 SYNOPSIS

  PROGRAM NAME: sumute
  AUTHOR:  Derek Goff
  DATE:  OCT 20 2013
  DESCRIPTION:  A package that makes using and understanding sumute easier
  VERSION: 1.1

=head2 Use

	sumute->clear();
	#which paramater subroutines go between
	#the clearing of the scalars and the step to the next ones
	$sumute[1] = sumute->Step();

=head2	NOTES

	This Program derives from sumute in Seismic Unix
	'_note' keeps track of actions for possible use in graphics
	'_Step' keeps track of actions for execution in the system

=head2 Example
	
 This is an example of how to use sumute in the command line

 suplane | sumute key=tracl xmute=15,17,25 tmute=.01,.14,.25 mode=1 | suxwigb &


=head2 Seismic Unix Notes

 SUMUTE - MUTE above (or below) a user-defined polygonal curve with
           the distance along the curve specified by key header word 
           
 sumute <stdin >stdout xmute= tmute= [optional parameters]
 
 REQUIRED PARAMETERS

 xmute=         array of position values as specified by
                        the `key' parameter
 tmute=         array of corresponding time values (sec)
                        in case of air wave muting, correspond to 
                        air blast duration
  ... or input via files:
 nmute=         number of x,t values defining mute
 xfile=         file containing position values as specified by
                        the `key' parameter
 tfile=         file containing corresponding time values (sec)
  ... or via header:
 hmute=         key header word specifying mute time
 
 OPTIONAL PARAMETERS: 
 
 key=offset      Key header word specifying trace offset 
                 =tracl  use trace number instead
 
 ntaper=0        number of points to taper before hard
                   mute (sine squared taper)
 
 mode		=0 to zero ABOVE the polygonal curve

		=1 to zero BELOW the polygonal curve

                =2 to mute below AND above a straight line. In this case
                     xmute,tmute describe the total time length of   
                     the muted zone as a function of xmute the slope 
                     of the line is given by the velocity linvel=

                =3 to mute below AND above a constant velocity hyperbola
                        as in mode=2 xmute,tmute describe the total time
                        length of the mute zone as a function of xmute,  
                        the velocity is given by the value of linvel=

                =4 to mute below AND above a user defined polygonal line
                        given by xmute, tmute pairs. The widths in time 
                        of the muted zone are given by the twindow vector

 linvel=330             constant velocity for linear or hyperbolic mute

 tm0=0                  time shift of linear or hyperbolic mute at
                         'key'=0
 
twindow=       vector of mute zone widths in time, operative only in mode=4
  
... or input via file:

	twfile= 

 Notes: 
 The tmute interpolant is extrapolated to the left by the smallest time
 sample on the trace and to the right by the last value given in the
 tmute array.

 The files tfile and xfile are files of binary (C-style) floats.

 In the context of this program "above" means earlier time and
 "below" means later time (above and below as seen on a seismic section.

 The mode=2 option is intended for removing air waves. The mute is
 is over a narrow window above and below the line specified by the
 the line specified by the velocity "linvel". Here the values of     
 tmute, xmute or tfile and xfile define the total time width of the mute.

 If data are spatial, such as the (z-x) output of a migration, then    
 depth values are used in place of times in tmute and tfile. The value 
 of the depth sampling interval is given by the d1 header field

 Caveat: if data are seismic time sections, then tr.dt must be set. If 
 data are seismic depth sections, then tr.trid must be set to the value
 of TRID_DEPTH and the tr.d1 header field must be set.
 To find the value of TRID_DEPTH:  
 type: 
     sukeyword trid
        and look for the entry for "Depth-Range (z-x) traces"

=cut

=pod

=head1 How To Define Parameters

=head2 _key
	
	Inspect the SEGY header (input "suxedit 'filename'" in command line)
	Determine how individual traces are identified, e.g. tracl, tracr etc.
	Use this to define the key parameter in "my $sumute = { ..."
	Example: " _key => 'tracr',

=head2 _xmute & _tmute

	Determine the (_xmute1,_tmute1) coordinate pairs that define boundary
	of the window you wish to mute.
	Input the xmute and tmute coords into their respective parameters
	Use the format: _xmute=> 'xmute1,xmute2,xmute3,...'
	There is no limit to the number of coord pairs to use 

=head2 _mode

	Set whether you want to mute above or below coord pairs determined
	from the (_xmute,_tmute) picks
	_mode => '0' mutes above the picks, '1' mutes below

=cut

#Define parameters below following 'How To Define Parameters'


=head2

 Declare shared hash contents among all subroutines herein
 (i.e. share the namespace)

=cut

my (@tmute,@xmute,@output,@Steps,@gather_number,@par_file);
my ($imute_par_);
   $output[0]='test';
   $tmute[0]='test';
   $xmute[0]='test';
   $gather_number[0]='test';
   $par_file[0]='test';

my $sumute = {
	_Step			=> '',
	_Steps			=> '',
	_Steps_array		=> \@Steps,
        _number_of_par_files 	=> '',
	_headerword		=> '',
	_gather_type		=> '',
	_gather_number_array	=> \@gather_number,
        _par_file_array       	=> \@par_file, 
	_list			=> '',
	_note			=> '',
	_row			=> '',
	_xmute			=> '',
	_tmute			=> '',
	_xmute_array		=> \@xmute, 
	_tmute_array		=> \@tmute, 
	_type			=> '',
	_mode			=> '',
	_key			=> '',
	_linvel			=> '', #Might be applied to Future Development (FD)
	_twin			=> '', #FD short for twindow, only use if mode=4
	_nmute			=> '', #FD
	_file_in		=> '', 
	_xfile			=> '', #FD
	_tfile			=> '', #FD
	_hmute			=> '', #FD
	_output			=> \@output, 
	_ntaper			=> '' 	
};



=head2 Subroutine clear
	
	Sets all variable strings to '' (nothing) 

=cut

sub clear {
	$sumute->{_Step}		= '';
	$sumute->{_Steps}		= '';
	$sumute->{_gather_type}		= '';
	$sumute->{_number_of_par_files}	= '';
	$sumute->{_list}		= '';
	$sumute->{_note}		= '';
	$sumute->{_row}			= '';
	$sumute->{_xmute}		= '';
	$sumute->{_tmute}		= '';
	$sumute->{_type}		= '';
	$sumute->{_mode}		= '';
	$sumute->{_key}			= '';
	$sumute->{_twin}		= ''; #FD
	$sumute->{_linvel}		= ''; #FD
	$sumute->{_nmute}		= ''; #FD
	$sumute->{_xfile}		= ''; #FD
	$sumute->{_parfile}		= ''; 
	$sumute->{_file_in}		= ''; 
	$sumute->{_tfile}		= ''; #FD
	$sumute->{_hmute}		= ''; #FD
	$sumute->{_ntaper}		= ''; #FD
}


=head2 Subroutine list

 list of gather numbers to mute
 There must be accompanying mute parameters in 
 additional files that correspond to each of the
 shotgather (ep), cdp gather etc. numbers inside the list	
 for example, 
   "1" should correspond to something like:
   "11" should correspond to something like:

 itop_mute_par_suFileName_binheaderType1
 itop_mute_par_suFileName_binheaderType11

 e.g., itop_mute_par_All_cmp_ep11

 Usage 1:
To mute an array of shotpoint gathers (numbers in list)
  and su file name to which mute is applied 
  sufile does NOT have a ".su" extension.

Example:
       $sumute->list('top_mute_list',\$file_in[1],\$binheader[1]);
        file_in is the sunix file
        binheader is either offset,tracl  etc.
        whereas the gather type is either cdp, ep etc.
        
=cut

sub list {
	my ($sub,$list,$ref_file_in,$ref_gather_type)= @_;

=head2 Error

     Messages

=cut


  if(defined($list)) {

    $sumute->{_list}    =   $list;
    $sumute->{_note}	= $sumute->{_note}.' list='.$sumute->{_list};

  }

  else {
  print(" Error: list name is missing in subroutine list");

  }

  if($ref_file_in) {
     $sumute->{_file_in}	= $$ref_file_in;
     #print("file is $sumute->{_file_in}\n\n");
  }
  else {
  print(" Error: su file is missing in subroutine list");

  }
  if($ref_gather_type) {
     $sumute->{_gather_type}	= $$ref_gather_type;
     #print("gather_type is $sumute->{_gather_type}\n\n");
  }
  else {
  print(" Error: gather type is missing in subroutine list");

  }


=head2 Insert package

 into namespace

=cut

  use manage_files_by;
   use Project;
  my $Project = new Project();

=head2 Load 

 variables into local namespace

=cut

  my ($numberOfFiles);
  my ($ref_file_names,$i);
  my ($file_number,$ref_values,$ref_numberOfValues);
  my (@sufile_in);
  my ($PL_SEISMIC) = $Project->PL_SEISMIC();

=head2 read a list 

 of file names

 testing

  print(" number of files is $numberOfFiles\n");
  for (my $i=1; $i<=$numberOfFiles;$i++) {
       print("\n file $i is $$ref_file_names[$i]");
   }

=cut 

    ($ref_file_names,$numberOfFiles) = manage_files_by::read_1col(\$sumute->{_list});

    if($numberOfFiles) {
      $sumute->{_number_of_par_files}  = $numberOfFiles;
    }

=head2
 
 read contents of each file in the list
 into arrays
 each line of the list is a gather number and
 indicates in which file the mute picks are found

 testing

      $row = scalar @$ref_numberOfValues;
      print(" \nfor file #$file_number, number of rows is $row\n");
          print("par file is $par_file\n\n");
      for (my $i=0; $i<$row;$i++) {
          print("\n row $i contains $$ref_values[$i]");
          print(" i.e., $$ref_numberOfValues[$i] values\n");
          }

 line=2 is needed to skip the  first two lines
 i.e. tnmo= vnmo=
 first initializaed as 1 and then incremented

=cut

 for ($file_number=1; $file_number <=$sumute->{_number_of_par_files};$file_number++) {

      $sumute->{_gather_number_array}[$file_number] = $$ref_file_names[$file_number];
      $sumute->{_par_file_array}[$file_number]		= $PL_SEISMIC.'/'.$imute_par_.$sumute->{_file_in}.'_'.$sumute->{_gather_type}.$sumute->{_gather_number_array}[$file_number];
      ($ref_values,$ref_numberOfValues) = manage_files_by::read_par(\$sumute->{_par_file_array}[$file_number]);

     my $row = scalar @$ref_numberOfValues;
      print(" \nfor file #$file_number, number of rows is $row\n");
          print("par file is $sumute->{_par_file_array}[$file_number]\n\n");
      for (my $i=0; $i<$row;$i++) {
          print("\n row $i contains $$ref_values[$i]");
          print(" i.e., $$ref_numberOfValues[$i] values\n");
          }


=head2
 
 place contents of each file in the list
 into an array
 @output is an array referenced within the hash of this namespace

 testing

 print("for i=0 output is $sumute->{_output}[0]\n\n");
 print("for i=$i tmute is $sumute->{_output}[$i]\n\n");
 print("for i=0 output is $$ref_values[0]\n\n");
 print("for i=1 output is $$ref_values[(0+1)]\n\n");

          $sumute->{_output}[$i] =  $$ref_values[$i];
          print("for file=$file_number tmute is $sumute->{_tmute_array}[$file_number]\n\n");
          print("for file=$file_number xmute is $sumute->{_xmute_array}[$file_number]\n\n");
=cut

      $sumute->{_row} = scalar @$ref_numberOfValues;     
      for ($i=0; $i<$sumute->{_row};$i=$i+2) {
          $sumute->{_tmute_array}[$file_number] =  $$ref_values[$i];
          $sumute->{_xmute_array}[$file_number] =  $$ref_values[($i+1)];
      }
   } # end of reading par files


=head2

   Create sets a  mute flow for each T-X pick file ("par" file)
          print("for i=$i,and line=$line tmute is $sumute->{_tmute_array}[$line]\n\n");
          print("for i=$i,and line=$line xmute is $sumute->{_xmute_array}[$line]\n\n");
  

=cut


} # end of sub list

sub parfile {
	my ($sub,$parfile)	= @_;
	$sumute->{_parfile}	= $parfile if defined($parfile);
	$sumute->{_note}	= $sumute->{_note}.' parfile='.$sumute->{_parfile};
	$sumute->{_Step}	= $sumute->{_Step}.' par='.$sumute->{_parfile};
	$sumute->{_Steps}	= $sumute->{_Steps}.' par='.$sumute->{_parfile};
}

=head2 Subroutine ntaper

	Defines the position (horizontal-axis) portion of the window to mute

=cut

sub ntaper {
	my ($sub,$ntaper)	= @_;
	$sumute->{_ntaper}	= $ntaper if defined($ntaper);
	$sumute->{_note}	= $sumute->{_note}.' ntaper='.$sumute->{_ntaper};
	$sumute->{_Step}	= $sumute->{_Step}.' ntaper='.$sumute->{_ntaper};
	$sumute->{_Steps}	= $sumute->{_Steps}.' ntaper='.$sumute->{_ntaper};
}



=head2 Subroutine xmute

	Defines the position (horizontal-axis) portion of the window to mute

=cut

sub xmute {
	my ($sub,$xmute)	= @_;

        if ($xmute) {
	   $sumute->{_xmute}	= $xmute;
	   $sumute->{_note}	= $sumute->{_note}.' xmute='.$sumute->{_xmute};
	   $sumute->{_Step}	= $sumute->{_Step}.' xmute='.$sumute->{_xmute};
        }
        elsif ($sub) {  # only for internal use of this sub
           #print("sub is $sub \n");
	   $sumute->{_xmute}	= $sub;
	   $sumute->{_Steps}	= $sumute->{_Steps}.' xmute='.$sumute->{_xmute};
          }

}

=pod

=head2 Subroutine tmute

	Defines the time (vertical-axis) portion of the window to mute
=cut

sub tmute {
	my ($sub,$tmute)	= @_;
        if ($tmute) {
	   $sumute->{_tmute}	= $tmute;
	   $sumute->{_note}	= $sumute->{_note}.' tmute='.$sumute->{_tmute};
	   $sumute->{_Step}	= $sumute->{_Step}.' tmute='.$sumute->{_tmute};
           #print("Step is $sumute->{_Step}\n\n");
        }
        elsif ($sub) {  # only for internal use of this sub
           #print("sub is $sub \n");
	   $sumute->{_tmute}	= $sub;
	   $sumute->{_Steps}	= $sumute->{_Step}.' tmute='.$sumute->{_tmute};
           #print("Steps are $sumute->{_Steps}\n\n");
          }
}


=head2 Subroutine mode

	Defines how the mute window is picked

=cut

sub mode {
	my ($sub,$mode)		= @_;
	$sumute->{_mode}	= $mode if defined($mode);
	$sumute->{_note}	= $sumute->{_note}.' mode='.$sumute->{_mode};
	$sumute->{_Step}	= $sumute->{_Step}.' mode='.$sumute->{_mode};
	$sumute->{_Steps}	= $sumute->{_Steps}.' mode='.$sumute->{_mode};
}



=head2 Subroutine headerword

	Defines which trace identifier to use from the SEGY header 
	
=cut

sub headerword {
	my ($sub,$headerword)			= @_;
	$sumute->{_headerword}		= $headerword if defined($headerword);
	$sumute->{_note}	= $sumute->{_note}.' headerword or key='.$sumute->{_headerword};
	$sumute->{_Step}	= $sumute->{_Step}.' key='.$sumute->{_headerword};
	$sumute->{_Steps}	= $sumute->{_Steps}.' key='.$sumute->{_headerword};
        #print("headerword is $sumute->{_headerword}\n\n");
}


=head2 Subroutine key

	Defines which trace identifier to use from the SEGY header 
	
=cut

sub key {
	my ($sub,$key)			= @_;
	$sumute->{_key}		= $key if defined($key);
	$sumute->{_note}	= $sumute->{_note}.' key='.$sumute->{_key};
	$sumute->{_Steps}	= $sumute->{_Steps}.' key='.$sumute->{_key};
}


=pod

=head2 Subroutine linvel
	
	The constant velocity used for linear or hyperbolic mutes

=cut

sub linvel {
	my ($sub,$linvel)		= @_;
	$sumute->{_linvel}	= $linvel if defined($linvel);
	$sumute->{_note}	= $sumute->{_note}.' linvel='.$sumute->{_linvel};
	$sumute->{_Step}	= $sumute->{_Step}.' linvel='.$sumute->{_linvel};
	$sumute->{_Steps}	= $sumute->{_Steps}.' linvel='.$sumute->{_linvel};
}


=pod

=head2 Subroutine Step

	Keeps track of actions for execution in the system

=cut

sub Step {
	$sumute->{_Step}	= 'sumute'.$sumute->{_Step};
	return $sumute->{_Step};
}


=head2 Subroutine Steps

       Keeps track of actions for execution in the system
       when more that one gather is being processed in the flow
       at a time
       Place contents of each line of the mute tables (t and index) 
       array into either a tmute or an xmute array for each file

 print("$output[$line]\n\n");
 print ("tmute is $sumute->{_tmute}\n\n");
 print ("$sumute->{_Steps}\n\n");
            #print (" sub Steps shows: $sumute->{_Steps_array}[$i]\n\n");

=cut

sub Steps {

  use Project;
  my $Project = new Project();
 use SeismicUnix qw ($in $out $to $suffix_su);
 use flow;

 my ($DATA_SEISMIC_SU) = $Project->DATA_SEISMIC_SU();
 my $run = new flow();
 my (@items,@outbound);

        for (my $i=1; $i<=$sumute->{_number_of_par_files};$i++) {
           tmute($sumute->{_tmute_array}[$i]);
           xmute($sumute->{_xmute_array}[$i]);

           $outbound[$i]             = $DATA_SEISMIC_SU.'/'.$sumute->{_file_in}.'_'.
                            $sumute->{_gather_type}.
                            $sumute->{_gather_number_array}[$i].$suffix_su;

           @items                    = ('suwind key='.$sumute->{_gather_type}.
                             ' min='.$sumute->{_gather_number_array}[$i].
                             ' max='.$sumute->{_gather_number_array}[$i],
                              $in,$DATA_SEISMIC_SU.'/'.$sumute->{_file_in}.$suffix_su,
                              $to,' sumute '.$sumute->{_Steps},$out,$outbound[$i]);

          $sumute->{_Steps_array}[$i] = $run->modules(\@items); 
          #print (" sub Steps shows: $sumute->{_Steps_array}[$i]\n\n");
	 }
	return ($sumute->{_Steps_array},$sumute->{_number_of_par_files},
                $sumute->{_gather_number_array},\@outbound);
}


=pod

=head2 Subroutine note

	Keeps track of actions for possible use in graphics

=cut

sub note {
	$sumute->{_note}	= $sumute->{_note};
	return $sumute->{_note};
}


=head2 Subroutine type

	Defines how the mute window is iapplied
        muting above or below a line
        print("Mute type is $sumute->{_type}\n\n");

=cut

sub type {
	my ($sub,$type)		= @_;
	$sumute->{_type}	= $type if defined($type);
        if ($sumute->{_type} eq 'top') {
            $sumute->{_type} 	= 0;
            $imute_par_        	= $itop_mute_par_;

       }

       if ($sumute->{_type} eq 'bottom') {
            $sumute->{_type} 	= 1;
            $imute_par_        	= $ibot_mute_par_;
       }

	$sumute->{_note}	= $sumute->{_note}.' type or mode ='.$sumute->{_type};
	$sumute->{_Step}	= $sumute->{_Step}.' mode='.$sumute->{_type};
}

   
=head2 sub get_max_index
  max index = number of input variables -1

=cut

 sub get_max_index {
 	my ($self) = @_;
 	# only file_name : index=6
 	my $max_index = 6;
 	
 	return($max_index);
 }



1;
