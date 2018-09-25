package read;

use Moose;

=pod
 
=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PACKAGE NAME: read 
 AUTHOR: Juan Lorenzo
 DATE: Oct 29 2012
 DESCRIPTION read file operations
 Version 1
         2 May 31 2016, Mom's 83 birthday
         2.1 June 29, 2016 
 Add reading configuration file hashes

 Notes: 
 Package name is the same as the file name
 Moose is a package that allows an object-oriented
 syntax to organizing your programs

 STEPS ARE:

=head2 USAGE 1 

 Read a file with one colume of text 
 Read each line

 Example
        $read->ref_file($list);
        $read-Step();
=cut

my $read = {
    _note 	=> '',
    _ref_file  	=> '',
    _Step 	=> ''
   };

=head2 sub clear:

 clean hash of its values

=cut

sub clear {
    $read->{_note} 	= '';
    $read->{_ref_file}  = '';
    $read->{_Step} 	= '';
}

=head2 sub cols_1 

 reads cols 1 in a text file
 open the file of interest

=cut

sub cols_1 { 

 my ($variable, $ref_origin) =	 @_;

=pod 

 declare local variables  

=cut

 my $line;

=pod 

 counter, a number, row number  

=cut

 my $i = 1;
 my ($x,$num_rows);
 my (@OFFSET);

 if($ref_origin) {
      $read->{_ref_file} 	= $ref_origin;
   #print ("\nThe input file is called $ref_origin\n");	
  open(FILE,$read->{_ref_file}) || print("Can't open file_name, $!\n");

=pod 

 read contents of shotpoint geometry file

=cut

   while ($line = <FILE>) {
	#print("\n$line");
	chomp($line);
        my($x)    		= $line;
        $OFFSET[$i]           	= $x;
        #print("\n Reading 1 col file:@OFFSET[$i]\n");
        $i 		 = $i +1;
    }

   close(FILE);

   $num_rows = $i-1;
   
  #print out the number of lines of data for the user
  # print ("This file contains $num_rows rows of data\n\n\n");	

  }
return (\@OFFSET,$num_rows);

}


=head2 sub cols_2 

 reads cols 1 and 2 in a text file

=cut

sub cols_2 {

    my ($files, $ref_file ) = @_;
    $read->{_ref_file}         = $$ref_file if defined($ref_file);
    print '$$ref_file= '.$$ref_file."\n\n";    

# open the file of interest
    open(FILE,$$ref_file) || print("Can't open file_name, $!\n");

#set the counter
    my $i = 1;
    my (@TIME,@OFFSET);

# read contents of shotpoint geometry file
     while (my $line = <FILE>) {
      	#print("\n$line");
	chomp($line);
        my ($t, $x)    	      = split (" +",$line);
	 $TIME[$i] 	      = $t;
         $OFFSET[$i]          = $x;
        $i 		      = $i +1;
     }
     close(FILE);

     my $num_rows = $i-1;
     my $rows  =$num_rows;

     #print ("\nThis file contains $num_rows row(s) of data\n");	

#   to prevent contaminating outside variables
      my  @TIME_OUT            = @TIME;
      my  @OFFSET_OUT          =  @OFFSET;
      return (\@TIME_OUT,\@OFFSET_OUT,$rows);


}

=head2 sub cfg

 Read a configuration file
 Reading and Writing Perl Config Files
 by jdhedden 	
 on Jun 07, 2005 at 15:55 UTC ( #464358=snippet)
 The arg can be a relative or full path, or
 it can be a file located somewhere in @INC.

=cut

 sub cfg  {
     my ($file_char) = @_; # file is a character array scalar 
	print("read,cfg,file_char: $file_char\n");
     if ($file_char) {
         my $file = $file_char; 
      print ("Doing $file \n\n");
      our $err;
             {   # Put config data into a separate namespace
                 package CFG;
                 # Process the contents of the config file
     		 our $CFG;
                 our $rc = do($file);
                               
                 #print ("log is $CFG->{log}{level} \n\n");
                 ## Check for errors
                                  if ($@) {
                                      $::err = "ERROR: Failure compiling '$file' - $@";
                                   } elsif (! defined($rc)) {
                                                                                     $::err = "ERROR: Failure reading '$file' - $!";
                                                                                             } elsif (! $rc) {
              $::err = "ERROR: Failure processing '$file'";
                           
      }
                           return ($err,$CFG);
      }
    }

}
1;
