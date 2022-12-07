use LibUI ':all';
use LibUI::VBox;
use LibUI::Window;
use LibUI::MultilineEntry;
use LibUI::VerticalSeparator;
Init( { Size => 1024 } ) && die;
my $window = LibUI::Window->new( 'Top and Bottom', 320, 100, 0 );
my $box    = LibUI::VBox->new();
my $top    = LibUI::MultilineEntry->new();
my $bot    = LibUI::MultilineEntry->new();
$box->append( $top,                            1 );
$box->append( LibUI::VerticalSeparator->new(), 0 );
$box->append( $bot,                            1 );
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