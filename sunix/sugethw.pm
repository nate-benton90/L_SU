package sugethw;
use Moose;

=pod

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: sugethw 
 AUTHOR: Juan Lorenzo
 DATE: Oct 23 2012
 DESCRIPTION sugethw 
 Version 1

 STEPS ARE:
=cut

my $newline    = '
';

my $sugethw = {
   _headerword	=> '',
   _verbose	=> '',
   _output	=> '',
   _file	=> '',
   _legend	=> '',
   _Step 	=> '',
   _Steps	=> '',
   _note 	=> ''
};

=head2 sub clear

 erase current hash variables from memory

=cut

sub clear {

 $sugethw->{_headerword} 	= '';
 $sugethw->{_verbose}		='';
 $sugethw->{_output}		='';
 $sugethw->{_file}		='';
 $sugethw->{_legend}		='';
 $sugethw->{_Step}		='';
 $sugethw->{_Steps}		='';
 $sugethw->{_note}		='';

}

my @headerword_list;
my ($i,$len);

sub setheaderword {
    my ($variable,$headerword ) = @_;
    $sugethw->{_headerword} = $headerword if defined($headerword);    
    $sugethw->{_Step}       = $sugethw->{_Step}.' key='.$sugethw->{_legend};    
    $sugethw->{_note}       = $sugethw->{_note}.' key='.$sugethw->{_legend};
    return $sugethw->{_headerword};
}

=head2 sub headerword

 select with which header word to work

=cut

sub headerword {
    my ($variable,$headerword ) = @_;
     #print("variable is $variable, and headerword is $headerword \n\n");
    if($headerword) {
      $sugethw->{_headerword} = $headerword ;    
      $sugethw->{_Step}       = $sugethw->{_Step}.' key='.$sugethw->{_headerword};
      #print("Step is is $sugethw->{_Step}\n\n");
      $sugethw->{_note}       = $sugethw->{_note}.' key='.$sugethw->{_legend};
    }
}

sub file {
    my ($variable, $ref_file ) = @_;
    $sugethw->{_file} 	      = $$ref_file[0] if defined($ref_file);
    print '$$ref_file= '.$$ref_file[0]."\n\n";    
    $sugethw->{_Step}         = $sugethw->{_Step}.$sugethw->{_file};    
    $sugethw->{_note}         = $sugethw->{_note}.' file='.$sugethw->{_file};
    return $sugethw->{_file};
}


sub files {
    my ($variable, $ref_file ) = @_;
# To DO for many files
    $sugethw->{_file} 	      = $$ref_file if defined($ref_file);
    $sugethw->{_Step}         = $sugethw->{_Step}.' key='.$sugethw->{_file};    
    $sugethw->{_note}         = $sugethw->{_note}.' key='.$sugethw->{_file};
    return $sugethw->{_file};
}

sub output {
    my ($variable, $output ) = @_;
    $sugethw->{_output}     = $output if defined($output);
    $sugethw->{_Step}       = $sugethw->{_Step}.' output='.$sugethw->{_output};    
    $sugethw->{_note}       = $sugethw->{_note}.' output='.$sugethw->{_output};
    return $sugethw->{_output};
}


sub verbose {
    my ($variable, $verbose ) = @_;
    $sugethw->{_verbose}      = $verbose if defined($verbose);
    $sugethw->{_Step}         = $sugethw->{_Step}.' verbose='.$sugethw->{_verbose};    
    $sugethw->{_note}        = $sugethw->{_note}.' verbose='.$sugethw->{_verbose};
    return $sugethw->{_verbose};
}


sub SetHeaderWords {   # array of header words
    my ($variable, $ref_array) = @_;
    my @list 			= @$ref_array if defined($ref_array);
    my $len 			= scalar (@list);

    # for first key entry
    $sugethw->{_Step}        = $sugethw->{_Step}.' key='.$list[0];    

    for ($i=1; $i< $len; $i++) {
       $headerword_list[$i] 	= $list[$i];
       $sugethw->{_Step}        = $sugethw->{_Step}.','.$list[$i];    
    }    
    $sugethw->{_note}        = $sugethw->{_note}.' key='.@headerword_list;
}


sub Step{
    my ($variable) = @_;
    $sugethw->{_Step} = ' sugethw'.$sugethw->{_Step};
    return $sugethw->{_Step};
}

sub Steps{
    my ($variable)  = @_;

# for the first time
    $sugethw->{_Steps} = ' sugethw'.
			 ' key='.$headerword_list[0];
			 ' verbose='.$sugethw->{_verbose}.
			 ' output='.$sugethw->{_output};
                         ' < '.
                         $sugethw->{_file}.
                         ' \\'.$newline;

# for successive times
    for ($i=1; $i < $len; $i++) {
       $sugethw->{_Steps} = $sugethw->{_Steps}.
			   ' | '.
                           ' sugethw'.
			   ' key='.@headerword_list.
			   ' verbose='.$sugethw->{_verbose}.
			   ' output='.$sugethw->{_output}.
			   ' \\'.$newline;
    }
    $sugethw->{_Steps} = $sugethw->{_Steps};
    return $sugethw->{_Steps};
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
