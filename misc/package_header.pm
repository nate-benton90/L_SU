package package_header;
use Moose;

=head2 Default perl lines for the headers of the file

 _first_entry_num is normally 1
 _max_entry_num is defaulted to 14

=cut

 my @head;

 $head[1] = ("use Moose;\n");

=head2 sub section

 a small section of the file
 print ("package_header,section:name $name\n");

=cut

sub section {
 my ($self,$name) = @_;
 $head[0] = ("package $name;\n");

 return (\@head);
}

1;
