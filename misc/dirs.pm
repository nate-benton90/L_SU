package dirs;

=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL PACKAGE NAME: dirs
 AUTHOR: 	Juan Lorenzo
 DATE: 		May 5 2018

 DESCRIPTION 
     
	directory service
 BASED ON:
 Version 0.1 

=cut

=head2 USE

=head3 NOTES

=head4 Examples


=head2 CHANGES and their DATES

=cut 



use Moose;


=head2 private hash

=cut


my $dirs = {
	_DIR   		=>'',
	_ref_ls 	=>'',
};


sub set_dir {
	my ($self, $DIR) = @_;
	
	if ($DIR) {
		$dirs->{_DIR} 	= $DIR;	
		# print("dirs,set_dir, DIR: $dirs->{_DIR}\n");
	}
	return();
}


=head2 sub get_ls 

i/p directgry
o/p array ref of list of file names

=cut

 sub get_ls 		{
	my @self = @_;
	my $directory = $dirs->{_DIR};
	my @list;
	if ($directory) {
		opendir (DIR, $directory) or die $!;
		my $i=0;
   		while (my $file = readdir(DIR)) {
			#chomp $file;
    		# Use a regular expression to ignore files beginning with a period
    		next if ($file =~ m/^\./);
    		# print "$file\n";
			$list[$i] = $file;
			$i++;
   		}
   		# print @list;
   		closedir(DIR);
   		return(\@list);	
   	} else {
		print ("dirs,get_ls,no directory available\n");
		return();
	}


 }

    
#my @dir= `ls`;
#print "\n @dir";

1;
