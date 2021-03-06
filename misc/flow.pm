package flow;
#use PID;
use Moose;
#my $PID = new PID;

 my $flow = {
      _inbound		=> '',
      _outbound		=> '',
      _ref_list		=> '',
      _instructions	=> '',
      _ref_PID		=> '',
    };


sub inbound {
    my ($flow, $inbound ) = @_;
    $flow->{_inbound} = $inbound if defined($inbound);
}

sub outbound {
    my ($flow, $outbound ) = @_;
    $flow->{_outbound} = $outbound if defined($outbound);
}


=head2 sub modules

   rearrange list of items
   before sending to the
   operating system to run

   Debug using:
    print "list length is $list_length\n\n";
    print("flow so far is $flow->{_ref_list}\n\n");

=cut

sub modules {
    my ($flow, $ref_list ) = @_;
    my $i;
    	# print("flow so far is @$ref_list\n\n");
    my $list_length 	= $#$ref_list;
    my $word 			= $$ref_list[0];

    for ($i=1;$i<=$list_length; $i++) {
     	$word = $word.$$ref_list[$i];
    }

    $flow->{_ref_list} 	= $word;
    return $flow->{_ref_list};
}


=head2 sub flow 

   sending a list of instructions to 
   operating system to run

   Debug using:
    print("ref_instr is $$ref_instructions\n\n");
    print "it's an array reference!";
    print("flows=$flow->{_instructions}\n\n");
			print("flow,flow,$$ref_instructions\n");

			 print("flow,flow,/usr/local/bin/pl $$ref_instructions\n");

=cut


sub flow{
    my ($flow,$ref_instructions) = @_;
    if ($ref_instructions) {
    	$flow->{_instructions} = $$ref_instructions;
      	system("$flow->{_instructions}");
      	return();
    }
  }



=head2 sub PID 

  get PID 

  Debug with:

=cut

 #sub PID {
 # my ($var,$program) =  @_;
 # if (defined $program) {
 #  my $this = $program;
 #  my $ref_pid;
#
#    if ($this eq 'ximage') {
#       $ref_pid = $PID->xgraph(); 
#    print("1. this is $this \n\n");
#       return ($ref_pid);
#    }
#    if ($this eq 'suximage') {
#       $ref_pid = $PID->suximage();
#       return ($ref_pid);
#    }
#    if ($this eq 'xgraph')   {
#	$ref_pid = $PID->xgraph();
#       return ($ref_pid);
#    }
#    if ($this eq 'suxgraph') {
#	$ref_pid = $PID->suxgraph();
#       return ($ref_pid);
#    } 
#
#    $ref_pid = $PID->any($this);
#    return ($ref_pid);
#
#  }
# }


1;
