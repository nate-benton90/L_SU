package data_out;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PERL PROGRAM NAME: data_out.pm 
 AUTHOR: 	Juan Lorenzo
 DATE: 		June 22 2017
  

 DESCRIPTION 
     

 BASED ON:
 Version 0.0.1 June 22 2017

 Version 0.0.2 July 26 2018


=cut

=head2 USE

=head3 NOTES

=head4 Examples


=head2 CHANGES and their DATES

  Version 0.02 July 22 2018 added subs: 
  	type, inbound  _get_inbound
  	_get_suffix, _get_DIR

=cut 

=head2 Notes from bash
 
=cut 

 use Moose;
 our $VERSION = '0.0.2';

 my $data_out = {
 		_Step    				=>'',
        _base_file_name     	=>'',
        _note    				=>'',
        _notes_aref           	=>'',
        _type   				=>'',
       };

=head2 subroutine _get_DIR
	
  send PATH for type
  type can be su txt sgy or su
  

=cut

sub _get_DIR {
	my ($self) = @_;
	
	if ( $data_out->{_type} ) {
		
		use Project;
 		my $Project = new Project();
 		use SeismicUnix qw ($segy $su $txt $bin);
		
		my $DIR;
		my $type = $data_out->{_type};
		
		if ($type eq $su) {
			
		    my ($DATA_SEISMIC_SU) 	= $Project->DATA_SEISMIC_SU();
		    $DIR 			  		= $DATA_SEISMIC_SU; 
			
		} 
		elsif ($type eq $bin) {
			
		    my ($DATA_SEISMIC_BIN) 	= $Project->DATA_SEISMIC_BIN();
		    $DIR 			  		= $DATA_SEISMIC_BIN; 
			
		} 
		
		elsif ($type eq $txt) {
			
		    my ($DATA_SEISMIC_TXT) 	= $Project->DATA_SEISMIC_TXT();
		    $DIR 			  		= $DATA_SEISMIC_TXT; 
			
		} 
		elsif ($type eq $segy) {
			
		    my ($DATA_SEISMIC_SEGY) = $Project->DATA_SEISMIC_SEGY();
		    $DIR 			  		= $DATA_SEISMIC_SEGY; 
			
		}
		
		else {
			print("data_out, type is not su\n"); 
		}
		
		return($DIR);
		
	} else {
		
		print ("data_out, _get_DIR, type missing \n");
	}
  }



=head2 subroutine _get_suffix
	
  send PATH for type
  type can be su txt sgy or su
  

=cut

sub _get_suffix {
	my ($self) = @_;
	
	if ( $data_out->{_type}) {
		
		my $suffix;
		my $type = $data_out->{_type};
		
		use SeismicUnix qw ($suffix_segy $suffix_su $suffix_bin $suffix_txt $segy $su $txt $bin);
		
		if ($type eq $su) {

		    $suffix = $suffix_su;
		    		    
		} elsif ($type eq $segy) {
			
			$suffix = $suffix_segy;
		}
		elsif ($type eq $bin) {
			
			$suffix = $suffix_bin;
			
		}elsif ($type eq $txt) {
			
			$suffix = $suffix_txt;
		}
			
		else {
			
			print("data_out, type is not su, bin, segy or txt\n"); 
		}
		
		return($suffix);
		
	} else {
		
		print ("data_out, _get_sufix, type missing \n");
	}
  }


=head2 subroutine Step
 
 adds the program name

=cut


sub Step {
	my $self = @_;
	my $note;

    $data_out->{_note}      = _get_outbound();
	$note					= $data_out->{_note};

    return $note;
    
}
 

=head2 subroutine _get_outbound

  type can be su txt sgy or su

=cut

sub _get_outbound {
	my ($self) = @_;
	
	if ( $data_out->{_type} && $data_out->{_base_file_name}) {


		my $outbound;
		my $type;
		my $DIR;
		my $file;
		my $suffix;
		
		$file  = $data_out->{_base_file_name};
		
		$DIR 			= _get_DIR();
		$suffix			= _get_suffix();
		$outbound	 	=  $DIR.'/'.$file.$suffix;
			# print ("data_out,_get_outbound outbound: $outbound\n");
		return($outbound);
	} else {
		
		print ("data_out, missing: type, base file name  \n");
	}
  }


=head2 sub  base_file_name 

	has no suffix
  
=cut

sub base_file_name{
    my ($variable,$base_file_name)   = @_;
    
	if ($base_file_name) {
		
		$data_out->{_base_file_name}   = $base_file_name;
	  	# print ("daout, base_file_name $data_out->{_base_file_name}\n");
		
	} else {
		print ("data_out, base_file_name, name missing \n");
		
	}
}
=head2 sub  base_file_name_sref  

	has no suffix
  
=cut

sub base_file_name_sref{
    my ($variable,$base_file_name_sref)   = @_;
    
	if ($base_file_name_sref) {
		
		$data_out->{_base_file_name}   = $$base_file_name_sref;
	  	# print ("data_out, base_file_name $data_out->{_base_file_name}\n");
		
	} else {
		print ("data_out, base_file_name_sref, name missing \n");
		
	}
}


=head2 subroutine clear

  sets all variable strings to '' 

=cut

sub clear {
    $data_out->{_Step} 				= '';
    $data_out->{_base_file_name} 	= '';
    $data_out->{_note} 				= '';
    $data_out->{_notes_aref} 		= '';
    $data_out->{_type} 				= '';
  };

	my @notes;
# define a value
my $newline  = '
';


=head2 sub  full_file_name  

	hase plus suffix
  
=cut

sub full_file_name {
    my ($self,$full_file_name)   = @_;
    
	if ($full_file_name) {
		
		$data_out->{_full_file_name}   = $full_file_name;
		
	} else {
		print ("data_out, full_file_name, name missing \n");
	}
}

=head2 subroutine get_inbound

  type can be su txt sgy or su

=cut

sub get_inbound {
	my ($self) = @_;
	
	if ( $data_out->{_type} && $data_out->{_base_file_name}) {


		my $inbound;
		my $type;
		my $DIR;
		my $file;
		my $suffix;
		
		$file  = $data_out->{_base_file_name};
		
		$DIR 			= _get_DIR();
		$suffix			= _get_suffix();
		$inbound	 	=  $DIR.'/'.$file.$suffix_su;
			# print ("data_out,get_inbound inbound: $inbound\n");
		return($inbound);
	} else {
		
		print ("data_out, missing: type, base file name  \n");
	}
  }



=head2 sub  file_name  you need to know how many numbers per line
  will be in the output file 

=cut

sub file_name {
    my ($variable,$file_name)   = @_;
	if ($file_name) {
		$data_out->{_file_name}  = $file_name;
    	$data_out->{_note}       = $data_out->{_note}.' data_out='.$data_out->{_file_name};
    	$data_out->{_Step}       = $data_out->{_Step}.' data_out='.$data_out->{_file_name};
	}
}


=head2 sub get_max_index
  max index = number of input variables -1

=cut

 sub get_max_index {
 	my ($self) = @_;
 	# base_file_name : index=0
 	# type      : index=1
 	my $max_index = 1;
 	
 	return($max_index);
 }


=pod

=head2 subroutine note 
 adds the program name

=cut


sub notes_aref{
	my $self = @_;

	$notes[1]	=	"\t".'$data_out[1] 	= '.$data_out->{_note};

    $data_out->{_notes_aref}       = \@notes;

    return $data_out->{_notes_aref};
}



=head2 subroutine type

  type can be su txt sgy or su

=cut

sub type {
	my ($self,$type) = @_;
	
	if ($type ) {
		
		$data_out->{_type} = $type;
		
	} else {
		
		print ("data_out, type missing \n");
	}
  }

1;
