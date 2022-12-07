use LibUI ':all';
use LibUI::HBox;
use LibUI::Window;
use LibUI::MultilineEntry;
use LibUI::HorizontalSeparator;
Init( { Size => 1024 } ) && die;
my $window = LibUI::Window->new( 'Left and Right', 320, 100, 0 );
my $box    = LibUI::HBox->new();
my $left   = LibUI::MultilineEntry->new();
my $right  = LibUI::MultilineEntry->new();
$box->append( $left,                             1 );
$box->append( LibUI::HorizontalSeparator->new(), 0 );
$box->append( $right,                            1 );
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