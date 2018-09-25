package param_widgets;
 use Moose; 

 extends  'populated', 'unpopulated'

 has 'check_buttons' => ( 
      is        => 'rw',
      isa       => 'HashRef',
      trigger   => \&set_check_buttons,
  );
 
 has 'entry_boxes' => ( 
      is        => 'rw',
      isa       => 'HashRef',
      trigger   => \&set_entry_boxes,
  );
  );
 
 has 'label_boxes' => ( 
      is        => 'rw',
      isa       => 'HashRef',
      trigger   => \&set_label_boxes,
  );

use label_boxes;

my $label_boxes->new($number);
   $label_boxes->initialize($number);
   $label_boxes->populate();
   $label_boxes->store();

=head2 sub set_check_buttons

=cut

 sub set_check_buttons {
   my $self = shift;
   $sunix->{_check_buttons} = $self->check_buttons ;
 }

=head2 sub set_entry_boxes

=cut

 sub set_entry_boxes {
   my $self = shift;
   $sunix->{_entry_boxes} = $self->entry_boxes;

 }


=head2 sub set_label_boxes

=cut

 sub set_label_boxes {
   my $self = shift;
   $sunix->{_label_boxes} = $self->label_boxes;

 }

 package label_boxes;

 sub initialize{};

 sub populate{};


