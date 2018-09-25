package sudoc;
use Moose;

=head2 sunix_pl

 shares many similar attributes to current 
 class in that files are examined for patterns
 However, the current class uses sudoc files
 rather than sunix perl scripts

=cut

extends 'sunix_pl';


=head2 hash of encapsuated variables


=cut

my $sudoc   = { 
				_names    => '',
				_values   => '',
              };

=head2 sub parse variable names

    from among selected lines

=cut

sub parameters{
	my ($self,$hash_ref) = @_;
	my $line_text;
    my (@default_names,@default_values,@extraction);
    my $parse_names;
    my $line_num=0;
	my $op_line_num=0;
    my $parse_names_ref = $hash_ref; 

    foreach my $content (@{$parse_names_ref->{_line_contents}}) {
    	
#    	print ("sudoc, parameters,line:$line_num comprises: $content \n");
    	
     	$line_text   		=  @{$parse_names_ref->{_line_contents}}[$line_num];

					#  match regex (m//) to string ($line_text) 
					#  and assign (=~) to array @fields 
					#  look for any number of whitespaces (\s*)
					#  followed by one or more word characters (\w+)							 
					#  followed by '='
					#  followed by any or no whitespaces (\s*)
					#  followed by one or more (+) non-whitespaces [^\s]+ 
     	my @fields = $line_text =~ m/\s*(\w+)\s*=\s*([^\s]+)/;
		my $length = scalar @fields;
			
		# filtered results
#		 for (my $i=0; $i<$length; $i++) {
#     		print ("line:$line_num, field $i:----$fields[$i]----\n");
#		 }

     	if( $fields[0] ) {

       		$default_names[$op_line_num]           = $fields[0]; 
       		$default_values[$op_line_num]   	   = $fields[1]; 

#       		 print("sudoc, $line_num param_name: $default_names[$op_line_num]\n");
#       		 print("sudoc, $line_num default param_value: $default_values[$op_line_num]\n");
			$op_line_num++;           
     	}

    $line_num++;
   }
   $sudoc->{_names}  = \@default_names;
   $sudoc->{_values} = \@default_values;
   return ($sudoc);
} 
1;
