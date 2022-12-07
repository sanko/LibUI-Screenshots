use LibUI ':all';
use LibUI::Window;
use LibUI::Menu;
Init( { Size => 1024 } ) && die;
my $mnuTest  = LibUI::Menu->new('Test');
my $mnuCheck = $mnuTest->appendCheckItem('Target');
$mnuTest->appendSeparator;
$mnuTest->appendItem('Enable')->onClicked( sub { $mnuCheck->enable }, undef );
$mnuTest->appendItem('Disable')->onClicked( sub { $mnuCheck->disable }, undef );
$mnuTest->appendItem('Check')->onClicked( sub { $mnuCheck->setChecked(1) }, undef );
$mnuTest->appendItem('Uncheck')->onClicked( sub { $mnuCheck->setChecked(0) }, undef );
my $window = LibUI::Window->new( 'Hi', 320, 100, 1 );
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