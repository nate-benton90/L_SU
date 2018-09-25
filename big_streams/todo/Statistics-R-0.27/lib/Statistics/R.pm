package Statistics::R;


use 5.006;
use strict;
use warnings;
use Regexp::Common;
use File::Spec::Functions;
use Statistics::R::Legacy;
use IPC::Run qw( harness start pump finish );
use Text::Balanced qw ( extract_delimited extract_multiple );

if ( $^O =~ m/^(?:.*?win32|dos)$/i ) {
    require Statistics::R::Win32;
}

our $VERSION = '0.27';

our ($SHARED_BRIDGE, $SHARED_STDIN, $SHARED_STDOUT, $SHARED_STDERR);


use constant PROG       => 'R';                           # executable name... R

use constant EOS        => '\\1';                         # indicate the end of R output with \1
use constant EOS_RE     => qr/[${\(EOS)}]\n$/;            # regexp to match end of R stream

#use constant EOS        => 'Statistics::R::EOS';          # indicate the end of R output
#use constant EOS_RE     => qr/${\(EOS)}\n$/;              # regexp to match end of R stream

use constant NUMBER_RE  => qr/^$RE{num}{real}$/;          # regexp matching numbers
use constant BLANK_RE   => qr/^\s*$/;                     # regexp matching whitespaces
use constant ILINE_RE   => qr/^\s*\[\d+\] /;              # regexp matching indexed line
use constant USR_ERR_RE => qr/<simpleError.*?:\s*(.*)>/s; # regexp for user error
use constant INT_ERR_RE => qr/^Error:\s*(.*)/s;           # regexp for internal error


=head1 NAME

Statistics::R - Perl interface with the R statistical program

=head1 DESCRIPTION

I<Statistics::R> is a module to controls the R interpreter (R project for statistical
computing: L<http://www.r-project.org/>). It lets you start R, pass commands to
it and retrieve the output. A shared mode allow to have several instances of
I<Statistics::R> talk to the same R process.

The current I<Statistics::R> implementation uses pipes (for stdin, stdout and
and stderr) to communicate with R. This implementation should be more efficient
and reliable than that in previous version, which relied on reading and writing
files. As before, this module works on GNU/Linux, MS Windows and probably many
more systems.

=head1 SYNOPSIS

  use Statistics::R;
  
  # Create a communication bridge with R and start R
  my $R = Statistics::R->new();
  
  # Run simple R commands
  my $output_file = "file.ps";
  $R->run(qq`postscript("$output_file" , horizontal=FALSE , width=500 , height=500 , pointsize=1)`);
  $R->run(q`plot(c(1, 5, 10), type = "l")`);
  $R->run(q`dev.off()`);

  # Pass and retrieve data (scalars or arrays)
  my $input_value = 1;
  $R->set('x', $input_value);
  $R->run(q`y <- x^2`);
  my $output_value = $R->get('y');
  print "y = $output_value\n";

  $R->stop();

=head1 METHODS

=over 4

=item new()

Build a I<Statistics::R> bridge object between Perl and R. Available options are:


=over 4

=item r_bin

Specify the full path to R if it is not automatically found. See L<INSTALLATION>.

=item shared

Start a shared bridge. When using a shared bridge, several instances of 
Statistics::R can communicate with the same unique R instance. Example:

   use Statistics::R;

   my $R1 = Statistics::R->new( shared => 1);
   my $R2 = Statistics::R->new( shared => 1);

   $R1->set( 'x', 'pear' );
   my $x = $R2->get( 'x' );
   print "x = $x\n";

Do not call the I<stop()> method is you still have processes that need to interact
with R.

=back


=item run()

First, start() R if it is not yet running. Then, execute R commands passed as a
string and return the output as a string. If your command fails to run in R, an
error message will be displayed.

Example:

   my $out = $R->run( q`print( 1 + 2 )` );

If you intend on runnning many R commands, it may be convenient to pass an array
of commands or put multiple commands in an here-doc:

   # Array of R commands:
   my $out1 = $R->run(
      q`a <- 2`,
      q`b <- 5`,
      q`c <- a * b`,
      q`print("ok")`
   );

   # Here-doc with multiple R commands:
   my $cmds = <<EOF;
   a <- 2
   b <- 5
   c <- a * b
   print('ok')
   EOF
   my $out2 = $R->run($cmds);

To run commands from a file, see the run_from_file() method.

The output you get from run() is the combination of what R would display on the
standard output and the standard error, but the order may differ. When loading
modules, some may write numerous messages on standard error. You can disable
this behavior using the following R command:

   suppressPackageStartupMessages(library(library_to_load))

Note that R imposes an upper limit on how many characters can be contained on a
line: about 4076 bytes maximum. You will be warned if this occurs. Commands
containing lines exceeding the limit may fail with an error message stating:

  '\�' is an unrecognized escape in character string starting "...

If possible, break down your R code into several smaller, more manageable
statements. Alternatively, adding newline characters "\n" at strategic places in
the R statements will work around the issue.

=item run_from_file()

Similar to run() but reads the R commands from the specified file. Internally,
this method uses the R source() command to read the file.

=item set()

Set the value of an R variable (scalar or arrayref). Example:

  $R->set( 'x', 'pear' );

or

  $R->set( 'y', [1, 2, 3] );

=item get()
 
Get the value of an R variable (scalar or arrayref). Example:

  my $x = $R->get( 'x' );  # $y is a scalar

or

  my $y = $R->get( 'y' );  # $x is an arrayref

=item start()

Explicitly start R. Most times, you do not need to do that because the first
execution of run() or set() will automatically call start().

=item stop()

Stop a running instance of R.

=item restart()

stop() and start() R.

=item bin()

Get or set the path to the R executable.

=item is_shared()

Was R started in shared mode?

=item is_started()

Is R running?

=item pid()

Return the pid of the running R process

=back

=head1 INSTALLATION

Since I<Statistics::R> relies on R to work, you need to install R first. See this
page for downloads, L<http://www.r-project.org/>. If R is in your PATH environment
variable, then it should be available from a terminal and be detected
automatically by I<Statistics::R>. This means that you don't have to do anything
on Linux systems to get I<Statistics::R> working. On Windows systems, in addition
to the folders described in PATH, the usual suspects will be checked for the
presence of the R binary, e.g. C:\Program Files\R. If I<Statistics::R> does not
find R installation, your last recourse is to specify its full path when calling
new():

    my $R = Statistics::R->new( r_bin => $fullpath );

You also need to have the following CPAN Perl modules installed:

=over 4

=item IPC::Run

=item Regexp::Common

=item Text::Balanced (>= 1.97)

=back

=head1 SEE ALSO

=over 4

=item * L<Statistics::R::Win32>

=item * L<Statistics::R::Legacy>

=item * The R-project web site: L<http://www.r-project.org/>

=item * Statistics:: modules for Perl: L<http://search.cpan.org/search?query=Statistics&mode=module>

=back

=head1 AUTHORS

Florent Angly E<lt>florent.angly@gmail.comE<gt> (2011 rewrite)

Graciliano M. P. E<lt>gm@virtuasites.com.brE<gt> (original code)

=head1 MAINTAINER

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT & LICENSE

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 BUGS

All complex software has bugs lurking in it, and this program is no exception.
If you find a bug, please report it on the CPAN Tracker of Statistics::R:
L<http://rt.cpan.org/Dist/Display.html?Name=Statistics-R>

Bug reports, suggestions and patches are welcome. The Statistics::R code is
developed on Github (L<http://github.com/bricas/statistics-r>) and is under Git
revision control. To get the latest revision, run:

   git clone git://github.com/bricas/statistics-r.git

=cut


sub new {
   # Create a new R communication object
   my ($class, %args) = @_;
   my $self = {};
   bless $self, ref($class) || $class;
   $self->initialize( %args );
   return $self;
}


sub is_shared {
   # Get (/ set) the whether or not Statistics::R is setup to run in shared mode
   my ($self, $val) = @_;
   if (defined $val) {
      $self->{is_shared} = $val;
   }
   return $self->{is_shared};
}


{
no warnings 'redefine';
sub start {
   my ($self, %args) = @_;
   my $status = 1;
   if (not $self->is_started) {

      # If shared mode option of start() requested, rebuild the bridge in shared
      # mode. Don't use this option though. It is only here to cater for the legacy
      # method start_shared()
      if ( exists($args{shared}) && ($args{shared} == 1) ) {
         $self->is_shared( 1 );
         $self->bridge( 1 );
      }

      # Now, start R
      my $bridge = $self->bridge;
      $status = $bridge->start or die "Error starting ".PROG.": $?\n";
      $self->bin( $bridge->{KIDS}->[0]->{PATH} );
   }

   return $status;
}
}


sub stop {
   my ($self) = @_;
   my $status = 1;
   if ($self->is_started) {
      $status = $self->bridge->finish or die "Error stopping ".PROG.": $?\n";
   }
   return $status;
}


sub restart {
   my ($self) = @_;
   return $self->stop && $self->start;
}


sub is_started {
   # Query whether or not R is currently running
   return shift->bridge->{STATE} eq IPC::Run::_started ? 1 : 0;
}


sub pid {
   # Get (/ set) the PID of the running R process. It is accessible only after
   # the bridge has start()ed
   return shift->bridge->{KIDS}->[0]->{PID};
}


sub bin {
   # Get / set the full path to the R binary program to use. Unless you have set
   # the path yourself, it is accessible only after the bridge has start()ed
   my ($self, $val) = @_;
   if (defined $val) {
      $self->{bin} = $val;
   }
   return $self->{bin};
}


sub run {
   # Pass the input and get the output
   my ($self, @cmds) = @_;

   # Need to start R now if it is not already running
   $self->start if not $self->is_started;


   # Process each command
   my $results = '';
   for my $cmd (@cmds) {

      # Wrap command for execution in R
      $self->stdin( $self->wrap_cmd($cmd) );

      # Pass input to R and get its output
      my $bridge = $self->bridge;
      while (  $self->stdout !~ EOS_RE  &&  $bridge->pumpable  ) {
         $bridge->pump;
      }

      # Parse outputs, detect errors
      my $out = $self->stdout;
      $out =~ s/${\(EOS_RE)}//;
      chomp $out;
      my $err = $self->stderr;
      chomp $err;
      if ( $out =~ USR_ERR_RE ) {
         # User-space (multi-line) error message
         die "Problem running this R command:\n$cmd\n\nGot the error:\n$1\n$err\n";
      } elsif ($err =~ INT_ERR_RE) {
         # Internal error
         my $err_msg = $1;
         if ( $err_msg =~ /unrecognized escape in character string/ ) {
            $err_msg .= "\nMost likely, your R command contained lines exceeding ".
               " 4076 bytes...";
         }
         die "Internal problem while running this R command:\n$cmd\n\nGot the error:\n$err_msg\n";

      }
   
      # Save results and reinitialize
      $results .= "\n" if $results;
      $results .= $err.$out;
      $self->stdout('');
      $self->stderr('');
   }

   $self->result($results);

   return $results;
}


sub run_from_file {
   my ($self, $file) = @_;
   my $results = $self->run( qq`source('$file')` );
   return $results;
}


sub set {
   # Assign a variable or array of variables in R. Use undef if you want to
   # assign NULL to an R variable
   my ($self, $varname, $arr) = @_;
    
   # Check variable type, convert everything into an arrayref
   my $ref = ref $arr;
   if ($ref eq '') {
      # This is a scalar
      $arr = [ $arr ];
   } elsif ($ref eq 'ARRAY') {
      # This is an array reference, nothing to do
   } else {
      die "Error: Import variable of type $ref is not supported\n";
   }

   # Quote strings and nullify undef variables
   for my $i (0 .. scalar @$arr - 1) {
      if (defined $$arr[$i]) {
         if ( $$arr[$i] !~ NUMBER_RE ) {
            $$arr[$i] = _quote( $$arr[$i] );
         }
      } else {
         $$arr[$i] = 'NULL';
      }
   }

   # Build a variable assignment string command. Sprinkle it with "\n" to avoid
   # running into R max line limits. Then run it!
   $self->run( $varname.'<-c('.join(",\n",@$arr).')' );

   return 1;
}


sub get {
   # Get the value of an R variable
   my ($self, $varname) = @_;
   my $string = $self->run(qq`print($varname)`);

   # Parse R output
   my $value;
   if ($string eq 'NULL') {
      $value = undef;
   } elsif ($string =~ ILINE_RE) {
      # Vector: its string look like:
      # ' [1]  6.4 13.3  4.1  1.3 14.1 10.6  9.9  9.6 15.3
      #  [16]  5.2 10.9 14.4'
      my @lines = split /\n/, $string;
      for my $i (0 .. scalar @lines - 1) {
         $lines[$i] =~ s/${\(ILINE_RE)}//;
      }
      $value = join ' ', @lines;
   } else {
      my @lines = split /\n/, $string;
      if (scalar @lines == 2) {
         # String looks like: '    mean 
         # 10.41111 '
         # Extract value from second line
         $value = _trim( $lines[1] );
      } else {
         $value = $string;
      }
   }

   # Clean
   my @arr;
   if (not defined $value) {
      @arr = ( undef );
   } else {
      # Split string into an array, paying attention to strings containing spaces:
      # extract_delim should be enough but we use extract_delim + split because
      # of Text::Balanced bug #73416
      if ($value =~ m{['"]}) {
         @arr = extract_multiple( $value, [sub { extract_delimited($_[0],q{'"}) },] );
         my $nof_empty = 0;
         for my $i (0 .. scalar @arr - 1) {
            my $elem = $arr[$i];
            if ($arr[$i] =~ BLANK_RE) {
               # Remove elements that are simply whitespaces later, in a single operation
               $nof_empty++;
            } else {
               # Trim and unquote
               $arr[$i-$nof_empty] = _unquote( _trim($elem) );
            }
         }
         if ($nof_empty > 0) {
            splice @arr, -$nof_empty, $nof_empty;
         }
      } else {
         @arr = split( /\s+/, _trim($value) );
      }
   }

   # Return either a scalar of an arrayref
   my $ret_val;
   if (scalar @arr == 1) {
       $ret_val = $arr[0];
   } else {
       $ret_val = \@arr;
   }

   return $ret_val;
}


#---------- INTERNAL METHODS --------------------------------------------------#


sub initialize {
   my ($self, %args) = @_;

   # Path of R binary
   my $bin;
   if ( $args{ r_bin } || $args{ R_bin } ) {
      $bin = $args{ r_bin } || $args{ R_bin };
   } else {
      $bin = PROG; # IPC::Run will find the full path for the program later
   }
   $self->bin( $bin );

   # Using shared mode?
   if ( exists($args{shared}) && ($args{shared} == 1) ) {
      $self->is_shared( 1 );
   } else {
      $self->is_shared( 0 );
   }

   # Build the bridge
   $self->bridge( 1 );

   return 1;
}


sub bridge {
   # Get or build the communication bridge and IOs with R
   my ($self, $build) = @_;
   my %params = ( debug => 0 );
   if ($build) {
      my $cmd = [ $self->bin, '--vanilla', '--slave' ];
      if (not $self->is_shared) {
         my ($stdin, $stdout, $stderr);
         $self->{stdin}  = \$stdin;
         $self->{stdout} = \$stdout;
         $self->{stderr} = \$stderr;
         $self->{bridge} = harness $cmd, $self->{stdin}, $self->{stdout}, $self->{stderr}, %params;
      } else {
         $self->{stdin}  = \$SHARED_STDIN ;
         $self->{stdout} = \$SHARED_STDOUT;
         $self->{stderr} = \$SHARED_STDERR;
         if (not defined $SHARED_BRIDGE) {
            # The first Statics::R instance builds the bridge
            $SHARED_BRIDGE = harness $cmd, $self->{stdin}, $self->{stdout}, $self->{stderr}, %params;
         }
         $self->{bridge} = $SHARED_BRIDGE;
      }
   }
   return $self->{bridge};
}


sub stdin {
   # Get / set standard input string for R
   my ($self, $val) = @_;
   if (defined $val) {
      ${$self->{stdin}} = $val;
   }
   return ${$self->{stdin}};
}


sub stdout {
   # Get / set standard output string for R
   my ($self, $val) = @_;
   if (defined $val) {
      ${$self->{stdout}} = $val;
   }
   return ${$self->{stdout}};
}


sub stderr {
   # Get / set standard error string for R
   my ($self, $val) = @_;
   if (defined $val) {
      ${$self->{stderr}} = $val;
   }
   return ${$self->{stderr}};
}


sub result {
   # Get / set result of last R command
   my ($self, $val) = @_;
   if (defined $val) {
      $self->{result} = $val;
   }
   return $self->{result};
}


sub wrap_cmd {
   # Wrap a command to pass to R. Whether the command is successful or not, the
   # end of stream string will appear on stdout and indicate that R has finished
   # processing the data. Note that $cmd can be multiple R commands.
   my ($self, $cmd) = @_;

   # Evaluate command (and catch syntax and runtime errors)
   $cmd = _quote($cmd);
   $cmd = qq`tryCatch( eval(parse(text=$cmd)), error = function(e){print(e)} ); `.
          qq`write("`.EOS.qq`",stdout())\n`;

   return $cmd;
}


#---------- HELPER SUBS -------------------------------------------------------#


sub _trim {
   # Remove flanking whitespaces
   my ($str) = @_;
   $str =~ s{^\s+}{};
   $str =~ s{\s+$}{};
   return $str;
}


sub _quote {
   # Quote a string for use in R. We use double-quotes because the documentation
   # Quotes {base} R documentation states that this is preferred over single-
   # quotes. Double-quotes inside the string are escaped.
   my ($str) = @_;

   # Escape " by \" , \" by \\\" , ...
   $str =~ s/ (\\*) " / '\\' x (2*length($1)+1) . '"' /egx;

   # Surround by "
   $str = qq("$str");

   return $str;
}


sub _unquote {
   # Opposite of _quote
   my ($str) = @_;

   # Remove surrounding "
   $str =~ s{^"}{};
   $str =~ s{"$}{};

   # Interpolate (de-escape) \\\" to \" , \" to " , ...
   $str =~ s/ ((?:\\\\)*) \\ " / '\\' x (length($1)*0.5) . '"' /egx;

   return $str;
}

1;
