use LibUI ':all';
use LibUI::Window;
use LibUI::ColorButton;
Init( { Size => 1024 } ) && die;
my $window = LibUI::Window->new( 'Hi', 320, 100, 0 );
my $cbtn   = LibUI::ColorButton->new();
$cbtn->onChanged(
    sub {
        warn sprintf 'RGBA: #%02X%02X%02X%02X', map { $_ * 255 } $cbtn->color();
    },
    undef
);
$window->setChild($cbtn);
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