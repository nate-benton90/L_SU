package LSU_Tk_global_constants;

use Moose;
my @names;

=head2 Default Tk settings 

 _first_entry_num is normally 1
 _max_entry_num is defaulted to 14

=cut
  my    $var = {
         _no_borderwidth    	=> '0',
	 _my_purple	    	=> 'MediumPurple1',
	_no_borderwidth    	=>  '0',
	_one_pixel_borderwidth  =>  1,
	_half_tiny_width       	=> '6',
	_tiny_width       	=> '12',
	_very_small_width 	=> '25',
	_small_width      	=> '50',
	_medium_width     	=> '100',
	_large_width      	=> '200',
	_very_large_width 	=> '500',
	_standard_width   	=> '20', 
	_one_character   	=> '1',
	_five_characters   	=> '5',
	_ten_characters   	=> '10',
	_hundred_characters   	=> '100',
	_eight_characters   	=> '8',
    _file_name              => 'file_name',
	_five_pixels       	=> '5',
	_one_pixel       	=> '1',
	_no_pixel       	=> '0',
	_light_gray       	=> 'gray90',
	_my_purple        	=> 'MediumPurple1',
	_my_white        	=> 'white',
	_my_yellow        	=> 'LightGoldenrod1',
	_white        		=> 'white',
	_box_position     	=> '800x400+12+12',
	_program_title    	=> 'SeismicUnixPlTk',
        _sunix_choices          => '',
	_flow                   => 'frame',
        _superflow              => 'menubutton',
        
      };

  @names = (
            "file_in", 
            "file_out", 
            "suximage", 
            "suxgraph", 
            "suxwigb",
            "sugain",
            "suwind",
            );
  $var->{_sunix_choices}     = \@names;

 sub var {
   return ($var);
 }

1;
