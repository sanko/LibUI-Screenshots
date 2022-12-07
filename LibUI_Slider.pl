use LibUI ':all';
use LibUI::VBox;
use LibUI::Window;
use LibUI::Slider;
Init( { Size => 1024 } ) && die;
my $window = LibUI::Window->new( 'Hi', 320, 100, 0 );
my $box    = LibUI::VBox->new();
my $slider = LibUI::Slider->new( 1, 100 );
$box->append( $slider, 0 );
$slider->onChanged( sub { warn 'Sliding to ' . shift->value }, undef );
$slider->onReleased( sub { warn 'Stopped at ' . shift->value }, undef );
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