package GMT_global_constants;

use Moose;
my @names;


  my    $var = {
		_no_head 	=> ' -O',
		_no_tail 	=> ' -K',
		_landscape  => ' -L',
		_portrait 	=> ' -P',
		_verbose    => ' -V',
      };


 sub var {
   return ($var);
 }


1;
