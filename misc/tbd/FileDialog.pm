##################################################
##################################################
##
##	FileDialog - a reusable Tk-widget file and
##               directory requester
##
##	Version 2.0
##
##	Brent B. Powers
##	Merrill Lynch
##	powers@swaps-comm.ml.com
##  Martin Herrmann (Martin-Herrmann@gmx.de)
##
##################################################
##################################################

# Change History:
#   Version 1.0 - Initial implementation
#   96 Jan 15	ringger@cs.rochester.edu - Fixed dialogue box creation.
#   96 Jan 15	ringger - Added option for selecting directories.
#   96 Feb 29	powers - Rewrote and componentized, and added a bunch of
#		options.  Now requires perl 5.002gamma
#   96 May 30	mkr- add support for single character navigation within
#		lists, e.g. typing G in list will navigate to first entry
#		starting with G
#   96 May 30	mkr- fixed problem with click in empty file list
#   96 May 31	powers - refixed problem with click in empty list (couldn't
#			 click the first entry in list box)
#		       - altered single character navigation to prevent
#			 nudging the mouse while in an entry from grabbing
#			 focus.
#		       - altered single character navigation to go from
#			 first to next to next to first (et al)
#		       - Finished keyboard navigation with tabs
#   Version 1.2:
#   96 Jun  3	powers - Added Version, ship
#   Version 1.3
#   96 Jun  9	powers - Added Version, and then fixed the Makefile.PM
#
#   Version 2.0
#   2003 Nov 06 Herrmann
#               - fixed problem with spaces in file and dir names
#                 (removed globbing)
#               - made the surface and layout a bit more "modern"
#               - the default size of the dialog is much bigger now
#               - added an adjuster between file and dir frame
#               - added a "create dir", "clear filter" and a ".." button
#               - added a optional "hot directories" and "last used"  button
#               - added display of file size and date
#               - the ESC button closes the dialog

# ToDo, Ideas
# - fix tab order (add new buttons)
# - multiple selections
# - validate command
# - rename file, dir
# - delete file, dir
# - icons for the buttons (optional, configurable)

=head1 NAME

Tk::FileDialog - A highly configurable File Dialog widget for Perl/Tk.

=head1 DESCRIPTION

The widget is composed of a number
of sub-widgets, namely, a listbox for files and (optionally) directories, an entry
for filename, an (optional) entry for pathname, an entry for a filter pattern, a 'ShowAll'
checkbox (for enabling display of .* files and directories), and three buttons, namely
OK, Rescan, and Cancel.  Note that the labels for all subwidgets (including the text
for the buttons and Checkbox) are configurable for foreign language support.
The Listboxes will respond to characters typed over them with scrolling to
the first line that starts with the given character (or next etc. if this
character is not present).

=head1 SYNOPSIS

=over 4

=head2 Usage Description

To use FileDialog, simply create your FileDialog objects during initialization (or at
least before a Show).  When you wish to display the FileDialog, invoke the 'Show' method
on the FileDialog object;  The method will return either a file name, a path name, or
undef.  undef is returned only if the user pressed the Cancel button.

=head2 Example Code

The following code creates a FileDialog and calls it.  Note that perl5.002gamma is
required.

=over 4

=item

 #!/usr/local/bin/perl -w

 use Tk;
 use Tk::FileDialog;
 use strict;

 my $main  = MainWindow->new;
 my $Horiz = 1;
 my $fname;

 my $LoadDialog = $main->FileDialog(-Title =>'This is my title',
 				                    -Create => 0);

 print "Using FileDialog Version ",$LoadDialog->Version,"\n";

 $LoadDialog->configure(-FPat => '*pl',
 		       -ShowAll => 'NO');

 $main->Entry(-textvariable => \$fname)
 	->pack(-expand => 1,
 	       -fill => 'x');

 $main->Button(-text => 'Kick me!',
 	      -command => sub {
 		  $fname = $LoadDialog->Show(-Horiz => $Horiz);
 		  if (!defined($fname)) {
 		      $fname = "Fine,Cancel, but no Chdir anymore!!!";
 		      $LoadDialog->configure(-Chdir =>'NO');
 		  }
 	      })
 	->pack(-expand => 1,
 	       -fill => 'x');

 $main->Checkbutton(-text => 'Horizontal',
 		   -variable => \$Horiz)
 	->pack(-expand => 1,
 	       -fill => 'x');

 $main->Button(-text => 'Exit',
 	      -command => sub {
 		  $main->destroy;
 	      })
 	->pack(-expand => 1,
 	       -fill => 'x');

 MainLoop;

 print "Exit Stage right!\n";

 exit;


=back

=back

=head1 METHODS

=over 4

=item

The following non-standard methods may be used with a FileDialog object

=item

=head2 Show

=over 4

Displays the file dialog box for the user to operate.  Additional configuration
items may be passed in at Show-time In other words, this code snippet:

  $fd->Show(-Title => 'Ooooh, Preeeeeety!');

is the same as this code snippet:

  $fd->configure(-Title => 'Ooooh, Preeeeeety!');
  $fd->Show;


=back

=item

=head2 Version

Returns the current Version of FileDialog

=back

=head1 CONFIGURATION

Any of the following configuration items may be set via the configure (or Show) method,
or retrieved via the cget method.

=head2 I<Flags>

Flags may be configured with either 1,'true', or 'yes' for 1, or 0, 'false', or 'no'
for 0. Any portion of 'true', 'yes', 'false', or 'no' may be used, and case does not
matter.

=over 4

=item

=head2 -Chdir

=over 8

=item

Enable the user to change directories. The default is 1. If disabled, the directory
list box will not be shown.

=back

=head2 -Create

=over 8

=item

Enable the user to specify a file that does not exist. If not enabled, and the user
specifies a non-existent file, a dialog box will be shown informing the user of the
error (This Dialog Box is configurable via the EDlg* switches, below).

default: 1

=back

=head2 -ShowAll

=over 8

=item

Determines whether hidden files (.*) are displayed in the File and Directory Listboxes.
The default is 0. The Show All Checkbox reflects the setting of this switch.

=back

=head2 -DisableShowAll

=over 8

=item

Disables the ability of the user to change the status of the ShowAll flag. The default
is 0 (the user is by default allowed to change the status).

=back

=head2 -Grab

=over 8

=item

Enables the File Dialog to do an application Grab when displayed. The default is 1.

=back

=head2 -Horiz

=over 8

=item

True sets the File List box to be to the right of the Directory List Box. If 0, the
File List box will be below the Directory List box. The default is 1.

=back

=head2 -SelDir

=over 8

=item

If True, enables selection of a directory rather than a file, and disables the
actions of the File List Box. The default is 0.

=back

=back

=head2 I<Special>

=over 4

=item

=head2 -FPat

=over 8

=item

Sets the default file selection pattern. The default is '*'. Only files matching
this pattern will be displayed in the File List Box.

=back

=head2 -Geometry

=over 8

=item

Sets the geometry of the File Dialog. Setting the size is a dangerous thing to do.
If not configured, or set to '', the File Dialog will be centered.

=back

=head2 -SelHook

=over 8

=item

SelHook is configured with a reference to a routine that will be called when a file
is chosen. The file is called with a sole parameter of the full path and file name
of the file chosen. If the Create flag is disabled (and the user is not allowed
to specify new files), the file will be known to exist at the time that SelHook is
called. Note that SelHook will also be called with directories if the SelDir Flag
is enabled, and that the FileDialog box will still be displayed. The FileDialog box
should B<not> be destroyed from within the SelHook routine, although it may generally
be configured.

SelHook routines return 0 to reject the selection and allow the user to reselect, and
any other value to accept the selection. If a SelHook routine returns non-zero, the
FileDialog will immediately be withdrawn, and the file will be returned to the caller.

There may be only one SelHook routine active at any time. Configuring the SelHook
routine replaces any existing SelHook routine. Configuring the SelHook routine with
0 removes the SelHook routine. The default SelHook routine is undef.

=back

=back

=head2 I<Strings>

The following two switches may be used to set default variables, and to get final
values after the Show method has returned (but has not been explicitly destroyed
by the caller)

=over 4

=item

B<-File>  The file selected, or the default file. The default is ''.

B<-Path>  The path of the selected file, or the initial path. The default is $ENV{'HOME'}.

=back

=head2 I<Labels and Captions>

For support of internationalization, the text on any of the subwidgets may be
changed.

=over 4

=item

B<-Title>  The Title of the dialog box. The default is 'Select File:'.

B<-DirLBCaption>  The Caption above the Directory List Box. The default is 'Directories'.

B<-FileLBCaption>  The Caption above the File List Box. The default is 'Files'.

B<-FileEntryLabel>  The label to the left of the File Entry. The Default is 'Filename:'.

B<-PathEntryLabel>  The label to the left of the Path Entry. The default is 'Pathname:'.

B<-FltEntryLabel>  The label to the left of the Filter entry. The default is 'Filter:'.

B<-ShowAllLabel>  The text of the Show All Checkbutton. The default is 'Show All'.

=back

=head2 I<Button Text>

For support of internationalization, the text on the three buttons may be changed.

=over 4

=item

B<-OKButtonLabel>  The text for the OK button. The default is 'OK'.

B<-RescanButtonLabel>  The text for the Rescan button. The default is 'Rescan'.

B<-CancelButtonLabel>  The text for the Cancel button. The default is 'Cancel'.

=back

=head2 I<Error Dialog Switches>

If the Create switch is set to 0, and the user specifies a file that does not exist,
a dialog box will be displayed informing the user of the error. These switches allow
some configuration of that dialog box.

=over 4

=item

=head2 -EDlgTitle

=over 8

=item

The title of the Error Dialog Box. The default is 'File does not exist!'.

=back

=head2 -EDlgText

=over 8

=item

The message of the Error Dialog Box. The variables $path, $file, and $filename
(the full path and filename of the selected file) are available. The default
is I<"You must specify an existing file.\n(\$filename not found)">

=back

=back

=head1 Author

B<Brent B. Powers, Merrill Lynch (B2Pi)>

powers@ml.com

This code may be distributed under the same conditions as Perl itself.

=cut

package Tk::FileDialog;

require 5.002;
use Tk;
use Tk::Dialog;
use Tk::Adjuster;
use Carp;
use strict;

@Tk::FileDialog::ISA = qw(Tk::Toplevel);

Tk::Widget->Construct('FileDialog');

$Tk::FileDialog::VERSION = '2.0';

### Global Variables (Convenience only)
my @topPack     = (-side => 'top', -anchor => 'center');
my @rightPack   = (-side => 'right', -anchor => 'center');
my @leftPack    = (-side => 'left', -anchor => 'center');
my @xfill       = (-fill => 'x');
my @yfill       = (-fill => 'y');
my @bothFill    = (-fill => 'both');
my @expand      = (-expand => 1);
my @raised      = (-relief => 'raised');
my $labellength = 12; # this should not be fixed, but the longest label
# of (FileEntryLabel, PathEntryLabel, FltEntryLabel) or an option
my $entrybg     = "gray90"; # this should be an option

my @TabOrder = qw (DirList
				   FileList
				   FileEntry
				   DirEntry
				   PatEntry
				   SABox
				   OK
				   Rescan
				   Can
				   DirList);

sub Populate {
    ## File Dialog constructor, inherits new from Toplevel
    my ($FDialog, @args) = @_;

    $FDialog->SUPER::Populate(@args);

    $FDialog->withdraw;

    $FDialog->protocol('WM_DELETE_WINDOW' => sub {
		if (defined($FDialog->{'Can'}) && $FDialog->{'Can'}->IsWidget ) {
			$FDialog->{'Can'}->invoke;
		}
    });
    $FDialog->transient($FDialog->parent->toplevel);

	my $font = $FDialog->Font(-family => "fixed", -size   => 10);
	$FDialog->optionAdd("*font", $font, "userDefault");

    foreach (@TabOrder) {
		$FDialog->{'TabSel'}->{$_} = 1;
    }

    ## Initialize variables that won't be initialized later
    $FDialog->{'Retval'} = -1;
    $FDialog->{'DFFrame'} = 0;

    $FDialog->{Configure}{-Horiz} = 1;

    $FDialog->BuildFDWindow;
    $FDialog->{'activefore'} = $FDialog->{'SABox'}->cget(-foreground);
    $FDialog->{'inactivefore'} = $FDialog->{'SABox'}->cget(-disabledforeground);

    $FDialog->ConfigSpecs(-Chdir		     => ['PASSIVE', undef, undef, 1],
						  -Create		     => ['PASSIVE', undef, undef, 1],
						  -DisableShowAll    => ['PASSIVE', undef, undef, 0],
						  -FPat			     => ['PASSIVE', undef, undef, '*'],
						  -File			     => ['PASSIVE', undef, undef, ''],
						  -Geometry		     => ['PASSIVE', undef, undef, undef],
						  -Grab			     => ['PASSIVE', undef, undef, 1],
						  -Horiz		     => ['PASSIVE', undef, undef, 1],
						  -Path			     => ['PASSIVE', undef, undef, "$ENV{'HOME'}"],
						  -SelDir		     => ['PASSIVE', undef, undef, 0],
						  -DirLBCaption		 => ['PASSIVE', undef, undef, 'Directories'],
						  -FileLBCaption	 => ['PASSIVE', undef, undef, 'Files'],
						  -FileEntryLabel	 => ['METHOD', undef, undef, 'Filename'],
						  -PathEntryLabel	 => ['METHOD', undef, undef, 'Pathname'],
						  -FltEntryLabel	 => ['METHOD', undef, undef, 'Filter'],
						  -ShowAllLabel		 => ['METHOD', undef, undef, 'Show dot files'],
						  -OKButtonLabel	 => ['METHOD', undef, undef, 'OK'],
						  -NewdirButtonLabel => ['METHOD', undef, undef, 'new dir'],
						  -UpButtonLabel	 => ['METHOD', undef, undef, '..'],
						  -RescanButtonLabel => ['METHOD', undef, undef, 'Rescan'],
						  -CancelButtonLabel => ['METHOD', undef, undef, 'Cancel'],
						  -HotDirList        => ['PASSIVE', undef, undef, undef],
						  -HotDirListLabel   => ['METHOD', undef, undef, 'hot directories'],
						  -RecentDirList     => ['PASSIVE', undef, undef, undef],
						  -RecentDirListLabel=> ['METHOD', undef, undef, 'last used'],
						  -SelHook		     => ['PASSIVE', undef, undef, undef],
						  -ShowAll		     => ['PASSIVE', undef, undef, 0],
						  -Title		     => ['PASSIVE', undef, undef, "Select File:"],
						  -EDlgTitle		 => ['PASSIVE', undef, undef,
												'File does not exist!'],
						  -EDlgText		     => ['PASSIVE', undef, undef,
											    "You must specify an existing file.\n"
											  . "(\$filename not found)"]);
}


### A few methods for configuration
sub OKButtonLabel {
    &SetButton('OK',@_);
}
sub NewdirButtonLabel {
    &SetButton('Newdir',@_);
}
sub UpButtonLabel {
    &SetButton('Up',@_);
}
sub HotDirListLabel {
    &SetButton('hot',@_);
}
sub RecentDirListLabel {
    &SetButton('last',@_);
}
sub RescanButtonLabel {
    &SetButton('Rescan',@_);
}
sub CancelButtonLabel {
    &SetButton('Can',@_);
}

sub SetButton {
    my ($widg, $self, $title) = @_;
    if (defined($title)) {
		## This is a configure
		$self->{$widg}->configure(-text => $title);
    }
    ## Return the current value
    $self->{$widg}->cget(-text);
}

sub FileEntryLabel {
    &SetLabel('FEF', @_);
}
sub PathEntryLabel {
    &SetLabel('PEF', @_);
}
sub FltEntryLabel {
    &SetLabel('patFrame', @_);
}
sub ShowAllLabel {
    &SetButton('SABox', @_);
}
sub SetLabel {
    my ($widg, $self, $title) = @_;
    if (defined($title)) {
		## This is a configure
		$self->{$widg}->{'Label'}->configure(-text => $title);
    }
    ## Return the current value
    $self->{$widg}->{'Label'}->cget(-text);
}

sub SetFlag {
    ## Set the given flag to either 1 or 0, as appropriate
    my ($self, $flag, $dflt) = @_;

    $flag = "-$flag";

    ## We know it's defined as there was a ConfigDefault call after the Populate
    ## call.  Therefore, all we have to do is parse the non-numerics
    if (&IsNum($self->{Configure}{$flag})) {
		$self->{Configure}{$flag} = 1 unless $self->{Configure}{$flag} == 0;
    } else {
		my $val = $self->{Configure}{$flag};
		my $fc  = lc(substr($val,0,1));

		if (($fc eq 'y') || ($fc eq 't')) {
			$val = 1;
		} elsif (($fc eq 'n') || ($fc eq 'f')) {
			$val = 0;
		} else {
			## bad value, complain about it
			carp ("\"$val\" is not a valid flag ($flag)!");
			$dflt = 0 if !defined($dflt);
			$val = $dflt;
		}
		$self->{Configure}{$flag} = $val;
    }
    return $self->{Configure}{$flag};
}

sub Version {return $Tk::FileDialog::VERSION;}

sub Show {
    my $self = shift;

    $self->configure(@_);

    ## Clean up flag variables
    $self->SetFlag('Chdir');
    $self->SetFlag('Create');
    $self->SetFlag('ShowAll');
    $self->SetFlag('DisableShowAll');
    $self->SetFlag('Horiz');
    $self->SetFlag('Grab');
    $self->SetFlag('SelDir');

    croak "Can't SelDir and Not ChDir" if $self->{Configure}{-SelDir} &&
	    !$self->{Configure}{-Chdir};

    ## Set up, or remove, the directory box
    &BuildListBoxes($self);

    ## Enable, or disable, the show all box
    if ($self->{Configure}{-DisableShowAll}) {
		$self->{'SABox'}->configure(-state => 'disabled');
		$self->{'TabSel'}->{'SABox'} = 0;
    } else {
		$self->{'SABox'}->configure(-state => 'normal');
		$self->{'TabSel'}->{'SABox'} = 1;
    }

    ## Enable, or disable, the newdir and up button
    if (!$self->{Configure}{-Chdir}) {
		$self->{'Newdir'}->configure(-state => 'disabled');
		$self->{'Up'}->configure(-state => 'disabled');
    } else {
		$self->{'Newdir'}->configure(-state => 'normal');
		$self->{'Up'}->configure(-state => 'normal');
    }

    ## Enable, or disable, the hot dir button
	my @hotdirs;
	if (defined($self->{Configure}{-HotDirList})) {
		@hotdirs = buildDirList($self->{Configure}{-HotDirList});
	}
	if (@hotdirs > 0) {
		$self->{'hot'}->configure(-state => 'normal');
	} else {
		$self->{'hot'}->configure(-state => 'disabled');
	}

    ## Enable, or disable, the last dir button
	my @lastdirs;
	if (defined($self->{Configure}{-RecentDirList})) {
		@lastdirs = buildDirList($self->{Configure}{-RecentDirList});
	}
	if (@lastdirs > 0) {
		$self->{'last'}->configure(-state => 'normal');
	} else {
		$self->{'last'}->configure(-state => 'disabled');
	}

    ## Enable or disable the file entry box
    if ($self->{Configure}{-SelDir}) {
		$self->{Configure}{-File} = '';
		$self->{'FileEntry'}->configure(-state => 'disabled',
										-foreground => $self->{'inactivefore'});
		$self->{'FileList'}->configure(-selectforeground => $self->{'inactivefore'});
		$self->{'FileList'}->configure(-foreground => $self->{'inactivefore'});
		$self->{'TabSel'}->{'FileEntry'} = $self->{'TabSel'}->{'FileList'} = 0;
    } else {
		$self->{'FileEntry'}->configure(-state => 'normal',
										-foreground => $self->{'activefore'});
		$self->{'FileList'}->configure(-selectforeground => $self->{'activefore'});
		$self->{'FileList'}->configure(-foreground => $self->{'activefore'});
		$self->{'TabSel'}->{'FileEntry'} = $self->{'TabSel'}->{'FileList'} = 1;
    }

    ## Set the title
    $self->title($self->{Configure}{-Title});

    ## Create window position (Center unless configured)
    $self->update;
    if (defined($self->{Configure}{-Geometry})) {
		$self->geometry($self->{Configure}{-Geometry});
    } else {
		my ($w,$h);                              # set default window size:
		$w = int(($self->screenwidth)  * 0.7);  # window width  to 70% of screenwidth
		$h = int(($self->screenheight) * 0.8);  # window height to 80% of screenheight
		my ($x,$y);
		$x = int(($self->screenwidth  - $w)/2 - $self->parent->vrootx);
		$y = int(($self->screenheight - $h)/2 - $self->parent->vrooty);
		$self->geometry("${w}x$h+$x+$y");
    }

    ## Set up the tab order
    &SetTabs($self);

    ## Fill the list boxes
    &RescanFiles($self);
    ## Restore the window, and go
    $self->update;
    $self->deiconify;

    ## Set up the grab
    $self->grab if ($self->{Configure}{-Grab});

    ## Initialize status variables
    $self->{'Retval'} = 0;
    $self->{'RetFile'} = "";

    my $i = 0;
    while (!$i) {
		$self->tkwait('variable',\$self->{'Retval'});
		$i = $self->{'Retval'};
		if ($i != -1) {
			## No cancel, so call the hook if it's defined
			if (defined($self->{Configure}{-SelHook})) {
				## The hook returns 0 to ignore the result,
				## non-zero to accept.  Must release the grab before calling
				$self->grab('release') if (defined($self->grab('current')));

				$i = &{$self->{Configure}{-SelHook}}($self->{'RetFile'});

				$self->grab if ($self->{Configure}{-Grab});
			}
		} else {
			$self->{'RetFile'} = undef;
		}
    }

    $self->grab('release') if (defined($self->grab('current')));

    $self->withdraw;

    return $self->{'RetFile'};
}

####  PRIVATE METHODS AND SUBROUTINES ####
sub IsNum {
    my $parm     = @_;
    my $warnSave = $;
    $ = 0;
    my $res      = (($parm + 0) eq $parm);
    $ = $warnSave;
    return $res;
}

sub TabNext {
    my ($self, $inc) = @_;
    my $f            = $self->{'OK'}->focusCurrent;
    return if !defined($f);
    ## Find the object with the matching focus...
    my $i = 0;
    foreach (@TabOrder) {
		if ($self->{$_} eq $f) {
			$i = $#TabOrder if !$i && $inc == -1;

			$i += $inc;

			while (!defined($TabOrder[$i]) ||
				   !ref($self->{$TabOrder[$i]}) ||
				   !$self->{$TabOrder[$i]}->IsWidget ||
				   !($self->{'TabSel'}->{$TabOrder[$i]})) {
# 		   (($TabOrder[$i] == 'FileList') &&
# 		    $self->{Configure}{-SelDir}) ) {
				$i += $inc;
				$i = $#TabOrder if !$i && $inc == -1;
				$i = 0 if $i > $#TabOrder && $inc == 1;
			}
			$self->{$TabOrder[$i]}->focus;
			$self->break;
			return;
		}
		$i++;
    }
}

sub SetTabs {
    my $self = shift;

    foreach (@TabOrder) {
		next if (!defined($self->{$_}) ||
				 !ref $self->{$_} ||
				 !$self->{$_}->IsWidget);

		$self->{$_}->bind("<Tab>", sub {\&TabNext($self, 1);});
		$self->{$_}->bind("<Shift-Tab>", sub {\&TabNext($self, -1);});
    }
}

sub BuildListBox {
    my ($self, $fvar, $flabel, $listvar,$hpack, $vpack) = @_;

    ## Create the subframe
    $self->{"$fvar"} = $self->{'DFFrame'}->Frame
	    ->pack(-side => $self->{Configure}{-Horiz} ? $hpack : $vpack,
			   -anchor => 'center',
			   @bothFill, @expand);

    ## Create the label
    $self->{"$fvar"}->Label(-text => "$flabel")
	    ->pack(@topPack, @xfill);

    ## Create the frame for the list box
    my $fbf = $self->{"$fvar"}->Frame
	    ->pack(@topPack, @bothFill, @expand);

    ## And the scrollbar and listbox in it
    $self->{"$listvar"} = $fbf->Listbox(-exportselection => 0, -bg => $entrybg)
	    ->pack(@leftPack, @expand, @bothFill);

    $fbf->AddScrollbars($self->{"$listvar"});
    $fbf->configure(-scrollbars => 'osoe');
}

sub DirSel {
    my ($self, $lbdir) = @_;

    my $np = $lbdir->curselection;
    return if !defined($np);
    $np = $lbdir->get($np);
    if ($np eq "..") {
		## Moving up one directory
		$_ = $self->{Configure}{-Path};
		chop if m!/$!;
		s!(.*/)[^/]*$!$1!;
		$self->{Configure}{-Path} = $_;
    } else {
		## Going down into a directory
		$self->{Configure}{-Path} .= "/" . "$np/";
    }
    $self->{Configure}{-Path} =~ s!//*!/!g;
    \&RescanFiles($self);
}

sub BindDir {
    ### Set up the bindings for the directory selection list box
    my $self = shift;

    my $lbdir = $self->{'DirList'};
    $lbdir->bind("<Double-1>" => sub {&DirSel($self, $lbdir);});

    # binding to take focus if clicked
    $lbdir->bind("<1>", sub{$self->{'DirList'}->focus;});

    # binding to attract focus if mouse over list
    $lbdir->bind("<Enter>", sub{&listFocus($self, 'DirList');});

    # binding to move to requested line by hitting a key
    $lbdir->bind("<KeyPress>", sub{\&list_see($self,'Dir');});

    # binding to select and rescan if someone hits return
    $lbdir->bind("<Return>", sub {&DirSel($self,$lbdir);});

}


sub FileSel {
    my $self = shift;
    if (!$self->{Configure}{-SelDir}) {
		my $f = $self->{'FileList'}->curselection;
		return if !defined($f);
		$self->{'File'} = $self->{'FileList'}->get($f);

		# through away the file size and date, match (any) (numbers+"kB") (any)
		$self->{'File'} =~ m/(.*)(\s\d+kB)(.*)/;
		$self->{'File'} = $1;
		# cut trailing spaces
		$self->{'File'} =~ s/\s*$//;

		$self->{'OK'}->invoke;
    }
}

sub cleanFileSizeDate {

  my $self  = shift;
  # through away the file size and date, match (any) (numbers+"kB") (any)
  $self->{Configure}{-File} =~ m/(.*)(\s\d+kB)(.*)/;
  $self->{Configure}{-File} = $1;
  # cut trailing spaces
  $self->{Configure}{-File} =~ s/\s*$//;
}

sub BindFile {
    ### Set up the bindings for the file selection list box
    my $self = shift;

    ## A single click selects the file...
    $self->{'FileList'}->bind("<ButtonRelease-1>", sub {
		if (!$self->{Configure}{-SelDir}) {
			my $n;
			return if (!defined($n = $self->{'FileList'}->curselection));

			($self->{Configure}{-File} = $self->{'FileList'}->get($n));

			# through away the file size and date
			cleanFileSizeDate($self);
		}
    });
    ## A double-click selects the file for good
    $self->{'FileList'}->bind("<Double-1>", sub { FileSel($self); } );

    # binding to take focus if clicked
    $self->{'FileList'}->bind("<1>", sub{
		$self->{'FileList'}->focus;
	});

    # binding to attract focus if mouse over list
    $self->{'FileList'}->bind("<Enter>", sub{
		&listFocus($self, 'FileList');
	});

    # binding to select and be done if someone hits return
    $self->{'FileList'}->bind("<Return>", sub {&FileSel($self);});

    # binding to move to requested line by hitting a key
    $self->{'FileList'}->bind("<KeyPress>", sub{&list_see($self,'File');});

    $self->{'FileList'}->configure(-selectforeground => 'blue');
}

sub BuildEntry {
    ### Build the entry, label, and frame indicated.  This is a
    ### convenience routine to avoid duplication of code between
    ### the file and the path entry widgets
    my ($self, $LabelVar, $entry) = @_;
    $LabelVar = "-$LabelVar";

    ## Create the entry frame
    my $eFrame = $self->Frame(@raised)
	    ->pack(@topPack, @xfill);

    ## Now create and pack the title and entry
    $eFrame->{'Label'} = $eFrame->Label(-width => $labellength, -anchor => "e")->pack(@leftPack);

    $self->{"$entry"} = $eFrame->Entry(-textvariable => \$self->{Configure}{$LabelVar},
									   -bg => $entrybg)
	    ->pack(@rightPack, @expand, @xfill);

    $self->{"$entry"}->bind("<Return>",sub {
		&RescanFiles($self);
		$self->{'OK'}->focus;
    });

    return $eFrame;
}

sub BuildListBoxes {
    my $self = shift;

    ## Destroy both, if they're there
    if ($self->{'DFFrame'} && $self->{'DFFrame'}->IsWidget) {
		$self->{'DFFrame'}->destroy;
    }

    $self->{'DFFrame'} = $self->Frame;
    $self->{'DFFrame'}->pack(-before => $self->{'FEF'},
							 @topPack, @bothFill, @expand);

    ## Build the file window before the directory window, even
    ## though the file window is below the directory window, we'll
    ## pack the directory window before.
    &BuildListBox($self, 'FileFrame',
				  $self->{Configure}{-FileLBCaption},
				  'FileList','right','bottom');
    ## Set up the bindings for the file list
    &BindFile($self);

    if ($self->{Configure}{-Chdir}) {
		&BuildListBox($self,'DirFrame',$self->{Configure}{-DirLBCaption},
					  'DirList','left','top');
		&BindDir($self);

		# add an adjuster between the dir an file listbox
		my $dirA   = $self->Adjuster();
		if (!$self->{Configure}{-Horiz}) {
			$dirA->packAfter($self->{"DirFrame"}, -side => "top")
			}
		else {
			$dirA->packAfter($self->{"DirFrame"}, -side => "left")
			}
    }
}

sub BuildFDWindow {
    ### Build the entire file dialog window
    my $self = shift;

    ### the top button frame
	my $topButFrame = $self->Frame(@raised);
	$topButFrame->pack(@topPack, @xfill);

	$self->{'Up'} = $topButFrame->Button(-command => sub {
		\&goUp($self);
	})->pack(@leftPack);

	$self->{'Newdir'} = $topButFrame->Button(-command => sub {
		\&newDir($self);
	})->pack(@leftPack);

	$self->{'hot'} = $topButFrame->Button()->pack(@leftPack);
	$self->{'hot'}->bind("<ButtonPress-1>", sub { hotDirMenu($self); $self->{'hot'}->configure(-state => "normal"); });
	$self->{'hot'}->bind("<ButtonRelease-1>", sub { Tk->break; });

	$self->{'last'} = $topButFrame->Button()->pack(@leftPack);
	$self->{'last'}->bind("<ButtonPress-1>", sub { lastDirMenu($self); $self->{'last'}->configure(-state => "active"); });

    ### Build the filename entry box
    $self->{'FEF'} = &BuildEntry($self, 'File', 'FileEntry');

    ### Build the pathname directory box
    $self->{'PEF'} = &BuildEntry($self, 'Path','DirEntry');

    ### Now comes the multi-part frame
    my $patFrame = $self->Frame(@raised)
	    ->pack(@topPack, @xfill);

    ## Label first...
    $self->{'patFrame'}->{'Label'} = $patFrame->Label(-width => $labellength, -anchor => "e")->pack(@leftPack);

    ## Now the entry...
    $self->{'PatEntry'} = $patFrame->Entry(-textvariable => \$self->{Configure}{-FPat},
										   -bg => $entrybg)
	    ->pack(@leftPack, @expand, @xfill);
    $self->{'PatEntry'}->bind("<Return>",sub {\&RescanFiles($self);});


    ## the clear filter button
    $self->{'ClrFlt'} = $patFrame->Button(-text => "Clear filter",
										  -command => sub { $self->{Configure}{-FPat} = "";
															RescanFiles($self); })->pack(@leftPack);

    ## and the Check box
    $self->{'SABox'} = $patFrame->Checkbutton(-variable => \$self->{Configure}{-ShowAll},
											  -command => sub {\&RescanFiles($self);})->pack(@leftPack);

    ### FINALLY!!! the button frame
    my $butFrame = $self->Frame(@raised);
    $butFrame->pack(@topPack, @xfill);

    $self->{'OK'} = $butFrame->Button(-command => sub {
		\&GetReturn($self);
    })->pack(@leftPack, @expand, @xfill);

    $self->{'Rescan'} = $butFrame->Button(-command => sub {
		\&RescanFiles($self);
    })->pack(@leftPack);

    my $canB = $self->{'Can'} = $butFrame->Button(-command => sub {
		$self->{'Retval'} = -1;
    })->pack(@leftPack, @expand, @xfill);


	# the ESC key invokes the cancel button
	$self->bind('<Key-Escape>', sub { $canB->invoke; } );
}

sub RescanFiles {
    ### Fill the file and directory boxes
    my $self = shift;

    my $fl    = $self->{'FileList'};
    my $dl    = $self->{'DirList'};
    my $path  = $self->{Configure}{-Path};
    my $show  = $self->{Configure}{-ShowAll};
    my $chdir = $self->{Configure}{-Chdir};

    ### Remove a final / if it is there, and add it
    $path = '' if (!defined("$path"));
    if ((length("$path") == 0) || (substr("$path",-1,1) ne '/')) {
		$path .= '/';
		$self->{Configure}{-Path} = $path;
    }
    ### path now has a trailing / no matter what
    if (!-d "$path") {
		carp "$path is NOT a directory\n";
		return 0;
    }

    $self->configure(-cursor => 'watch');
    my $OldGrab = $self->grab('current');
    $self->{'OK'}->grab;
    $self->{'OK'}->configure(-state => 'disabled');
    $self->update;

    opendir(ALLFILES, "$path");
    my(@allfiles) = readdir(ALLFILES);
    closedir(ALLFILES);

    my $direntry;

    ## First, get the directories...
    if ($chdir) {
		$dl->delete(0, 'end');
		my %see; # hold index if first occurrence of first character of direntry
		my $n=0; # number of entry in list
		foreach $direntry (sort { uc($a) cmp uc($b) } @allfiles) {
			next if !-d "$path$direntry";
			next if "$direntry" eq ".";
			if (   !$show
				   && (substr("$direntry", 0, 1) eq ".")
				   && "$direntry" ne "..") {
				next;
			}
			$dl->insert('end', "$direntry");
			if(! exists($see{substr("$direntry" , 0, 1)})){
				$see{substr("$direntry", 0, 1)} = $n;
			}
			$n++;
		}
		$self->{see_Dir} = \%see;
    }

    ## Now, get the files
    $fl->delete(0,'end');

    $_ = $self->{Configure}{-FPat};
    s/^\s*|\s*$//;
    $_ = $self->{Configure}{-FPat} = '*' if ($_ eq '');

    my $pat = $_;

    my %see; # hold index if first occurrence of first character of fileentry
    my $n=0; # number of entry in list
    my $fileentry;
    foreach $fileentry (sort { uc($a) cmp uc($b) } @allfiles) {
		next if ($fileentry !~ m/.$pat$/);
		next if ((substr("$fileentry", 0, 1) eq ".") and !$show);

		if (-f "$path$fileentry") {
			my ($size, $date) = (lstat "$path$fileentry")[7,9];
			$size    = int($size/1024)."kB" if ($size);
			my ($s,$m,$h,$d,$mo,$y) = localtime $date;
			# do some date adjustments
			$y += 1900; $mo++;
			# build up the date time string
			my $datestr = sprintf "%04d:%02d:%02d %02d:%02d:%02d", $y, $mo, $d, $h, $m, $s;
			my $entry = sprintf "%-38s %10s %19s", $fileentry, $size, $datestr;
			$fl->insert('end', "$entry");

			if(! exists($see{substr("$fileentry", 0, 1)})){
				$see{substr("$fileentry", 0, 1)} = $n;
			}
			$n++;
		}
		$self->{see_File}=\%see;
    }
    $self->configure(-cursor => 'top_left_arrow');

    $self->{'OK'}->grab('release') if $self->grab('current') == $self->{'OK'};
    $OldGrab->grab if defined($OldGrab);
    $self->{'OK'}->configure(-state => 'normal');
    $self->update;
    return 1;
}

sub buildDirList {
	my $var = shift;
	my @dirs;
	if (ref($var) eq "ARRAY") {
		# store just the accessible dirs in the list
		foreach (@{$var}) {
			push @dirs, $_ if (-d $_);
		}
	}
	return @dirs;
}

# build and open a menu with hot dirs (favorites)
sub hotDirMenu {
    my $self = shift;

	my  $dirMenu =
		$self->Menu(-title => "Hot Directory Menu");

	# clear dir menu
	$dirMenu->delete(0, "end");

	if (defined($self->{Configure}{-HotDirList})) {
		my @hotdirs = buildDirList($self->{Configure}{-HotDirList});
		foreach my $hot (@hotdirs) {
			$dirMenu->command(-label => "$hot",
							  -command => sub {
								  $self->{Configure}{-Path} = "$hot";
								  RescanFiles($self);
							  });
		}
		$dirMenu->Popup(-popover => "cursor", -popanchor => "nw");
	}
}

# build and open a menu with last recent used dirs (history)
sub lastDirMenu {
    my $self = shift;

	my  $dirMenu =
		$self->Menu(-title => "Last Directory Menu");

	# clear dir menu
	$dirMenu->delete(0, "end");

	if (defined($self->{Configure}{-RecentDirList})) {
		my @lastdirs = buildDirList($self->{Configure}{-RecentDirList});
		foreach my $last (@lastdirs) {
			$dirMenu->command(-label => "$last",
							  -command => sub {
								  $self->{Configure}{-Path} = "$last";
								  RescanFiles($self);
							  });
		}
		$dirMenu->Popup(-popover => "cursor", -popanchor => "nw");
	}
}

# do a chdir("..")
sub goUp {
    my $self = shift;
	## Moving up one directory
	$_ = $self->{Configure}{-Path};
	chop if m!/$!;
	s!(.*/)[^/]*$!$1!;
	$self->{Configure}{-Path} = $_;
    RescanFiles($self);
}

# create a new directory in the actual path
sub newDir {
    my $self = shift;
    my $path = $self->{Configure}{-Path};

	# open dialog
	my $myDiag = $self->Toplevel();
	$myDiag->title("Create new directory");

	my $f = $myDiag->Frame()->pack;

	$myDiag->Label(-text => "Please enter the new directory name\nto create in $path:")->pack();

	my $OKB;
	my $rc = 0;
	my $newdir = "newdir";
	my $entry = $myDiag->Entry(-textvariable => \$newdir,
							   -width => 40,
							   )->pack(-fill => 'x', -padx => 3, -pady => 3);

	# select the complete dir name suggestion and put the cursor at the end
	$entry->selectionRange(0,"end");
	$entry->icursor("end");
	$entry->xview("end");

	$entry->bind('<Return>', sub { $OKB->invoke; } );
	$entry->focus;

	my $ButF = $myDiag->Frame()->pack(-fill =>'x', -padx => 3, -pady => 3);

	$OKB = $ButF->Button(-text => "OK",
						 -command => sub {
							 $rc = 1;
						 })->pack(-side => 'left', -expand => 1, -fill => 'x',
								  -padx => 3, -pady => 3);

	my $XBut = $ButF->Button(-text => "Cancel",
							 -command => sub {
								 $rc = 0;
							 }
							 )->pack(-side => 'left', -expand => 1, -fill => 'x',
									 -padx => 3, -pady => 3);

	$myDiag->bind('<Key-Escape>', sub { $XBut->invoke; });
	$myDiag->Popup();
	$myDiag->waitVariable(\$rc);
	$myDiag->withdraw();
	$myDiag->destroy();

	return unless ($rc);

	if (-d "$path/$newdir") { 
			$self->messageBox(-icon => 'warning', -message => "Sorry, but directory $newdir already exists!",
							 -title   => "Error", -type => "OK");
			return;
		}

	if ( !mkdir "$path/$newdir", 0755 ) {
		$self->messageBox(-icon => 'warning', -message => "make directory: can not create $newdir: $!",
						  -title   => "Error", -type => "OK");
		return;
	}

	# show the new directory
    RescanFiles($self);
}

sub GetReturn {
    my $self = shift;

    ## Construct the filename
    my $path = $self->{Configure}{-Path};
    my $fname;

    $path .= "/" if (substr("$path", -1, 1) ne '/');

    if ($self->{Configure}{-SelDir}) {
		$fname = $self->{'DirList'};

		if (defined($fname->curselection)) {
			$fname = $fname->get($fname->curselection);
		} else {
			$fname = '';
		}
		$fname = "$path" . $fname;
		$fname =~ s/\/$//;
    } else {
		$fname = "$path" . $self->{Configure}{-File};
		## Make sure that the file exists, if the user is not allowed
		## to create
		if (!$self->{Configure}{-Create} && !(-f $fname)) {
			## Put up no create dialog
			my $path     = $self->{Configure}{-Path};
			my $file     = $self->{Configure}{-File};
			my $filename = $fname;
			eval "\$fname = \"$self->{Configure}{-EDlgText}\"";
			$self->Dialog(-title => $self->{Configure}{-EDlgTitle},
						  -text => $fname,
						  -bitmap => 'error')
				->Show;
			## And return
			return;
		}
    }

    $self->{'RetFile'} = $fname;

    $self->{'Retval'} = 1;

}

sub listFocus {
    ## Change focus ONLY if current focus is not an entry...
    my ($self, $lb) = @_;

    my $f = $self->{$lb}->focusCurrent;
    if (defined($f) &&
		$f ne $self->{'FileEntry'} &&
		$f ne $self->{'DirEntry'} &&
		$f ne $self->{'PatEntry'}) {
		$self->{$lb}->focus;
    }
}

sub list_see{
    my ($self, $what) = @_; # $what is dir or file

    my $list = $self->{"${what}List"}; # Dir or File
    my $see  = $self->{"see_$what"};   # index hash
    my $char = $list->XEvent->A;       # key pressed
    if (exists($see->{$char})) {       # line with char there?
		## Yes, it is...
		my $ndx = $see->{$char};

		## Is it already selected?
		my $cs = $list->curselection;
		if (defined($cs)) {

			if (($cs == $ndx) ||
				(substr($list->get($cs),0,1) eq $char)) {
				## does the next in the list start with the same char?
				if (defined($list->get($cs + 1)) &&
					(substr($list->get($cs + 1),0,1) eq $char)) {
					$ndx = ++$cs;
				}
			}
		}
		$list->see($ndx);    # yes, so show it.
		$list->selection('clear',0,'end');
		return if $self->{Configure}{-SelDir};
		$list->selection('set', $ndx);
		if ($what eq 'File') {
		  $self->{Configure}{-File} = $list->get($ndx);
		  # through away the file size and date
		  cleanFileSizeDate($self);
		}
    } else {                          # search next line in sequence
		while(!exists($see->{$char}) && length($char) == 1) {
			$char++;
		}
		if(exists($see->{$char})){
			$char = $see->{$char};
			$list->see($char-1) if $char;    # Show the one before
			$list->see($char);    # and show this one...
# 	} else {
# 	    $list->bell;
		}
    }
}


### Return 1 to the calling use statement ###
1;
### End of file FileDialog.pm ###
__END__
