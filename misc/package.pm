 package package;
 use Moose;

=head2 initialize shared anonymous hash 

  key/value pairs

=cut

 my $package = {
  	  _file_in			=> '',
  	  _file_out			=> '',
  	  _length			=> '',
  	  _name				=> '',
  	  _num_lines		=> '',
  	  _path_out			=> '',
  	  _sudoc			=> '',
  	  _outbound			=> '',
    };

=head2 sub file_in
file_out
  print("file_in is $package->{_file_in}\n");
path_out
=cut

sub file_in {
  my($self,$file_aref) = @_;
  $package->{_file_in} =  @$file_aref[0];
}

=head2 sub file_out

  print("file_out is $package->{_file_out}\n");

=cut

sub file_out {
  my($self,$file_aref) = @_;
  $package->{_file_out} =  @$file_aref[0];
}

=head2 sub name

  print("name is $package->{_name}\n");

=cut

sub name {
  my($self,$file_aref) = @_;
  $package->{_name} =  @$file_aref[0];
}


=head2 sub path_out

  print("path_out is $package->{_path_out}\n");

=cut

sub path_out {
  my($self,$file_aref) = @_;
  $package->{_path_out} =  @$file_aref[0];
}


=head2 sub param_names

  print("param_names is $package->{_param_names}\n");

=cut

sub param_names {
  my($self,$names_aref) = @_;
  $package->{_param_names} = $names_aref ;
  print("package,param_names  @{$package->{_param_names}}\n");
  $package->{_length} =  scalar @$names_aref;
}


=head2 sub param_values

  print("param_values is $package->{_param_values}\n");

=cut

sub param_values {
  my($self,$values_aref) = @_;
  $package->{_param_values} =  $values_aref;
  $package->{_length} =  scalar @$values_aref;
  print("package,param_values @{$package->{_param_values}}\n");
}

=head2 sub sudoc

  print("sudoc is $package->{_sudoc}\n");

=cut

sub sudoc {
  my($self,$sudoc_aref) = @_;
  $package->{_sudoc} =  $sudoc_aref;
  $package->{_num_lines} =  scalar @$sudoc_aref;
  #print("package,sudoc @{$package->{_sudoc}}\n");
}


=pod sub write 

 open  and write 
 to the file

=cut

 sub write {
   my($self) = shift;

   if ($package->{_file_out} && $package->{_length} ) { # avoids errors

     my $OUT;
     use package_encapsulated;
     use package_header;
     use package_pod;
     use package_subroutine;
     use package_tail;
     		#my $encapsulated 	       	= package_encapsulated->new();
     my $header 	       	= package_header->new();
     my $pod 	       		= package_pod->new();
     my $subroutine			= package_subroutine->new();
     my $tail				= package_tail->new();
     		#$encapsulated			->package_name($package->{_name});
     		#$encapsulated	        ->local_variables($package->{_param_names});
     $pod					->package_name($package->{_name});
     $pod					->sudoc($package->{_sudoc});
     $subroutine			->name($package->{_name});

     $package->{_outbound}	= $package->{_path_out}.$package->{_file_out};
      		print ("package outbound $package->{_outbound}\n");;

      open  $OUT, '>', $package->{_outbound} or die;
      print $OUT @{$header->section($package->{_name})};
      $pod->header($package->{_sudoc});
      #print $OUT @{$pod->header($package->{_sudoc})};

      		#print $OUT @{$encapsulated->section};

      for (my $i=0; $i < $package->{_length}; $i++) {

        $subroutine->param_name(\@{$package->{_param_names}}[$i]);
        $pod	   ->subroutine_name(\@{$package->{_param_names}}[$i]);

        print $OUT @{$pod->section};
        print $OUT @{$subroutine->section};

      }     
#    
#      pod_declare();
#      declare();
#      declare_external();
#
      print $OUT @{$tail->section};
      close($OUT);
   }

 }

1;
