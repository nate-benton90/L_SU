package run_button_messages;

	use Moose;

	sub get {
		my ($self,$number) = @_;
		my @message;

		$message[0] = ("Warning: File not saved. First Save superflow, then, e.g., Run   (run_message=0)\n");
		$message[1] = ("Warning: File not saved. First save flow. Use File/SaveAs then, e.g., Run   (run_message=1)\n");
		return(\@message);
	}

1;

