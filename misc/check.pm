package check;


=pod

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: check
 AUTHOR: Juan Lorenzo
 DATE:   April 19, 2018
 DESCRIPTION: 
 Version: 0.1

=head2 USE


=head3 NOTES 
 The following may need key values to increase monotonically:
 suop2 op=diff 
 suwind


=head4 

 Examples

=head3


=head4 CHANGES and their DATES

=cut

=pod

=head3 STEPS

=cut

use Moose;

 my $check = {
          _AminusB    => '',
          _AplusB     => '',
          _diffOrSum  => '',
          _fileA      => '',
          _fileB      => '',
          _note	      => '',
          _Step       => ''
        };


# define a value
my $newline  = '
';


=pod

=head2 subroutine clear

  sets all variable strings to '' 

=cut

sub clear {
    my ($check)               = @_;
    $check->{_AminusB}        = '';
    $check->{_AplusB}         = '';
    $check->{_diffOrSum}      = '';
    $check->{_fileA}          = '';
    $check->{_fileB}          = '';
    $check->{_note}           = '';
    $check->{_Step}           = '';
}


=pod

=head2 sub is_flow

=cut

=head2 sub is_superflow

=cut


=head2 sub is_sunix_program

=cut
check->{_number_of_flows}
check->{_number_of_programs_per_flow}
check->{_programs_in_flow}
check->{_number_of_superflows} = 1;
sub check_program

sub check_flow

sub check superflow


=head3 Warnings for programmers

 packages must end with
 ;1

=cut

1;
