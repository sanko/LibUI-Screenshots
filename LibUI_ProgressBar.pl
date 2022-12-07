use LibUI ':all';
use LibUI::VBox;
use LibUI::Window;
use LibUI::ProgressBar;
Init( { Size => 1024 } ) && die;
my $window   = LibUI::Window->new( 'Hang on a tick...', 320, 100, 0 );
my $box      = LibUI::VBox->new();
my $progress = LibUI::ProgressBar->new();
$progress->setValue(-1);
$box->append( $progress, 1 );
$window->setChild($box);
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