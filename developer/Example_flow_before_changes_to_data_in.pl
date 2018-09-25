=head2 SYNOPSIS

 PACKAGE NAME: 

 AUTHOR:  

 DATE:

 DESCRIPTION:

 Version:

=head2 USE

=head3 NOTES

=head4 Examples

=head2 SYNOPSIS

=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES

=cut
	use Moose;

	use SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su);
	 use Project;
  my $Project = new Project();

	use misc::message;
	use misc::flow;
	use sunix::sugain;
	use sunix::suximage;
	my $log			= new message();
	my $run			= new flow();
	my $sugain		= new sugain() ;
	my $suximage		= new suximage() ;


=head2 Declare

local variables

=cut
	my (@flow);
	my (@items);
	my (@sugain);
	my (@suximage);

	my ($DATA_SEISMIC_SU) = $Project->DATA_SEISMIC_SU();
	my (@file_in);
	my (@sudata_in,@inbound);
	$file_in[1]	= '1000_42_clean';
	$sudata_in[1]	= $file_in[1].$suffix_su;
	$inbound[1]	= $DATA_SEISMIC_SU.'/'.$sudata_in[1];

=head2 Set up

sugain parameter values

=cut


	$sugain		->clear();
	$sugain		->pbal(1);
	$sugain[1] 		= $sugain->Step();


=head2 Set up

suximage parameter values

=cut


	$suximage		->clear();
	$suximage		->absclip(1);
	$suximage		->title('suximage');
	$suximage		->percent4clip(100);
	$suximage		->box_width(200);
	$suximage		->box_X0(800);
	$suximage		->clip(1);
	$suximage		->box_Y0(300);
	$suximage		->cmap('rgb0');
	$suximage		->orientation('seismic');
	$suximage[1] 		= $suximage->Step();



=head2 DEFINE FLOW(s) 


=cut


	 @items	= (
		  $sugain[1], $in,
		  $inbound[1],$to,
		  $suximage[1],
		  $go
		  );
	$flow[1] = $run->modules(\@items);




=head2 RUN FLOW(s) 


=cut


	$run->flow(\$flow[1]);




=head2 LOG FLOW(s)

to screen and FILE

=cut


	print $flow[1];

	$log->file($flow[1]);


