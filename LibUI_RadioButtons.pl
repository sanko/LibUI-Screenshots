use LibUI ':all';
use LibUI::VBox;
use LibUI::Window;
use LibUI::RadioButtons;
Init( { Size => 1024 } ) && die;
my $window = LibUI::Window->new( 'Age range', 320, 100, 0 );
my $box    = LibUI::VBox->new();
my $radio  = LibUI::RadioButtons->new();
my @range  = qw[0-5 6-12 13-18 19-25 26-35 36-45 46-60 60+];
$radio->append($_) for @range;
$box->append( $radio, 0 );
$radio->onSelected( sub { warn 'Aged: ' . $range[ shift->selected ] }, undef );
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