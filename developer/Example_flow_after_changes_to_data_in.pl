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
	use misc::data_in;
	use sunix::sugain;
	use sunix::suximage;

	my $data_in		= new data_in();	
	my $log			= new message();
	my $run			= new flow();
	my $sugain		= new sugain() ;
	my $suximage	= new suximage() ;


=head2 Declare

local variables

=cut
	my (@flow);
	my (@items);
	my (@sugain);
	my (@suximage);
	my @data_in;

	my (@file_in);
	my (@inbound);
	
	$file_in[1]	= '1001_43_clean_sort';

=head2 Set up

 data_in parameter values

=cut

	$data_in		->clear();
	$data_in		->base_file_name_sref(\$file_in[1]);
	$data_in		->type('su');
	$inbound[1]	 	= $data_in->get_inbound();


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


