package arith_by;

# perform math on arrays by  class
# Contains methods/subroutines/functions to operate on directories
# V 1. March  2008 
# Juan M. Lorenzo

sub nearest {

   my ($val,$ref_array,$num_elements)	=  @_;

   my($closest_value_is) = -999. ;
   my($ind) = -999. ;
   my($error) = .05; # in km or 50 m

   print("\ninitial value is: $val ");

   for ($i=1; $i<=$num_elements; $i++) {

      my($margin) = abs($$ref_array[$i] - $val);

	#print(" margin: $margin index:$i $$ref_array[$i]\n");
      if ($margin <= $error) {

	#print("\n diff: $margin index:$i $$ref_array[$i]\n");

	$closest_value_is = $$ref_array[$i];
        $ind              = $i;
      }
	

    }

return($closest_value_is,$ind);

}

sub round_off {  # round off decimal to nearest whole number

        my ($ref_array,$num_elements,$decimate)	=  @_;

#set the counter

  for($i=1,$j=1; $i <=$num_elements; $i=$i+$decimate,$j++) {

	$A_rounded[$j]	= sprintf("%.0f",$$ref_array[$i]);

   }
       $num_rows = $j-1;
       print("@A_rounded[$j-1]\n");
       print("$num_rows\n");

return (\@A_rounded,$num_rows);

}

sub adding {  # round off decimal to nearest whole number

        my ($ref_array,$num_elements,$add,$decimate)	=  @_;

#set the counter

  for($i=1,$j=1; $i <=$num_elements; $i=$i+$decimate,$j++) {

       #print("$$ref_array[$i]\n");
	$A[$j] = $$ref_array[$i] + $add;
       #print("@A[$j]\n");

   }
       $num_rows = $j-1;

return (\@A,$num_rows);

}
1;
