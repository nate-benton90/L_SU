package manage_files_by;

# manage_files_by  class
# Contains methods/subroutines/functions to operate on directories
# V 1. March 3 2008 
# Juan M. Lorenzo

sub copy_file {

# this function/method  makes a  directory
# if it does not exist already

#get directory names
        my ($origin) 		= shift @_;
        my ($destination) 	= shift @_;
		
	 print ("\nCopying $origin to $destination \n");

	system ("                       	\\
                cp $origin $destination       	\\
        ");

}

sub mult_col2 { 

# this function multiplies column  2 by a user given value

        my ($origin) 		= shift @_;
        my ($scale) 		= shift @_;

   print ("\nThe input file is called $origin\n");	

# open the file of interest
  open(FILE,$origin || print("Can't open file_name, $!\n") );

#set the counter
  $i = 1;

# read contents of file
   while ($line = <FILE>) {
	#print("\n$line");
	chomp($line);
        ($t, $x)    = split ("  ",$line);
	$TIME[$i] 	      = $t;
        $OFFSET[$i]           = $x * $scale;
#        print("\n @TIME[$i] @OFFSET[$i]\n");
        $i 		 = $i +1;

    }

   close(FILE);

   $num_rows = $i-1;

# print out the number of lines of data for the user
#   print ("This file contains $num_rows[1] rows of data\n\n\n");	

return (\@TIME,\@OFFSET,$num_rows);

}

sub read_2cols { 

# this function reads cols 1 and 2 in a text file

        my ($origin) 		= shift @_;

   print ("\nThe input file is called $origin\n");	

# open the file of interest
  open(FILE,$origin || print("Can't open file_name, $!\n") );

#set the counter
  $i = 1;

# read contents of shotpoint geometry file
   while ($line = <FILE>) {
	#print("\n$line");
	chomp($line);
        ($t, $x)    = split ("  ",$line);
	$TIME[$i] 	      = $t;
        $OFFSET[$i]           = $x;
#        print("\n @TIME[$i] @OFFSET[$i]\n");
        $i 		 = $i +1;

    }

   close(FILE);

   $num_rows = $i-1;

# print out the number of lines of data for the user
#   print ("This file contains $num_rows[1] rows of data\n\n\n");	

return (\@TIME,\@OFFSET,$num_rows);

}


sub read_4cols { 

# this function reads 4 cols in a text file 

   my ($ref_file_name) 		= shift @_;

   print ("\nThe input file is called $$ref_file_name\n");	

# open the file of interest
  open(FILE,$$ref_file_name || print("Can't open file_name, $!\n") );

#set the counter
  $i = 1;

# read contents of file
   while ($lines = <FILE>) {
        #print("$lines");
        chomp($lines);
        ($ident, $x, $y, $z)    = split (" ",$lines);
        #print("\n $num \n");
        $ID[$i]	     = $ident;
        $X[$i]           = $x;
        $Y[$i]           = $y;
        $Z[$i]           = $z;
       #print("\n @ID[$i] @X[$i] @Y[$i] @Z[$i] \n");
        $i               = $i +1;

    }
	# number of geophones stations in file
	$num_rows = $i -1;

# close the file of interest
   close(FILE);


  return (\@X,\@Y,\@Z,$num_rows);

}

sub write_2cols{ 

# WRITE OUT FILE

# open and write to output file
   my($ref_X,$ref_Y,$num_rows,$ref_file_name) = @_;

   print("\nThe output file is called $$ref_file_name\n");

   open(OUT,">$$ref_file_name");

   for($j=1; $j<=$num_rows; $j++) {

  	print OUT  ("$$ref_X[$j] $$ref_Y[$j]\n");
	}

   close(OUT);
}

sub write_3cols{ 

# WRITE OUT FILE

# open and write to output file
   my($ref_X,$ref_Y,$ref_Z,$num_rows,$ref_file_name) = @_;

   print("\nThe output file is called $$ref_file_name\n");

   open(OUT,">$$ref_file_name");

   for($j=1; $j<=$num_rows; $j++) {

  	print OUT  ("$$ref_X[$j] $$ref_Y[$j] $$ref_Z[$j]\n");
	}

   close(OUT);
}
1;
