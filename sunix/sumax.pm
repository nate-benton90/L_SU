#!/usr/bin/perl

package sumax;

sub new
{
    my $class = shift;
    my $sumax = {
        _mode,     => shift,
        _key,     => shift,
        _output,  => shift,
        _verbose,   => shift,
        _outpar,   => shift,
        _note,     => shift,
    };
         bless $sumax, $class;
         return $sumax;
 }

sub mode {
    my ($sumax, $mode ) = @_;
    $sumax->{_mode}     = $mode if defined($mode);
    $sumax->{_note}       = ' mode='.$sumax->{_mode};
}

sub key {
    my ($sumax, $key ) = @_;
    $sumax->{_key}     = $key if defined($key);
    $sumax->{_note}       = $sumax->{_note}.' mode='.$sumax->{_key};
}

sub output {
    my ($sumax, $output )   = @_;
    $sumax->{_output}       = $output if defined($output);
    $sumax->{_note}       = $sumax->{_note}.' output='.$sumax->{_output};
}

sub verbose{
    my ($sumax, $verbose )  = @_;
    $sumax->{_verbose} 	   = $verbose if defined($verbose);		
    $sumax->{_note}  	   = $sumax->{_note}.' verbose= '.$sumax->{_verbose}; 
}

sub outpar {
    my ($sumax, $outpar )    = @_;
    $sumax->{_outpar}        = $outpar if defined($outpar);
    $sumax->{_note}       = $sumax->{_note}.' outpar='.$sumax->{_outpar};
}

sub Step{
    my ($sumax) 	   = @_;
    $sumax->{_Step}       = 'sumax'.$sumax->{_note};
    return $sumax->{_Step};
}


sub note {
    my ($sumax) 	   = @_;
    $sumax->{_note}       =  $sumax->{_note};
    return $sumax->{_note};

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
