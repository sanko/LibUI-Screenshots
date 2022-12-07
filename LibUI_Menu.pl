use LibUI ':all';
use LibUI::Window;
use LibUI::Menu;
Init( { Size => 1024 } ) && die;
my $mnuFile = LibUI::Menu->new('File');
$mnuFile->appendItem('New')->onClicked( sub { warn 'File>New' }, undef );
$mnuFile->appendItem('Open');
$mnuFile->appendItem('Save');
$mnuFile->appendItem('Save As...');
$mnuFile->appendSeparator;
$mnuFile->appendItem(__FILE__);    # reopen
my $mnuFileQuit = $mnuFile->appendQuitItem;
LibUI::onShouldQuit(
    sub {
        return 1;
    },
    undef
);
my $mnuEdit = LibUI::Menu->new('Edit');
my $mnuHelp = LibUI::Menu->new('Help');
my $window  = LibUI::Window->new( 'Hi', 320, 100, 1 );
$window->onClosing(
    sub {
        Quit();
        return 1;
    },
    undef
);
$window->show;
use Imager;
use Imager::Screenshot 'screenshot';
Timer(
    1000,
    sub {
        # take a picture, including the border and title bar
        my $img = screenshot() or die Imager->errstr;

        # and save it
        $img->write( file => 'screenshot.png' ) or die $img->errstr;
        Quit;
    },
    undef
);

Main();