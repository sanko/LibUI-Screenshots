use LibUI ':all';
use LibUI::Tab;
use LibUI::Window;
use LibUI::Label;
Init( { Size => 1024 } ) && die;
my $window = LibUI::Window->new( 'Hi', 320, 100, 0 );
my $tabs   = LibUI::Tab->new;
$tabs->append( $_, LibUI::Label->new($_) ) for qw[First Second Third Fourth];
$tabs->setMargined( $_ - 1, 1 ) for 1 .. $tabs->numPages;
$window->setChild($tabs);
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
        $img->write( file => __FILE__ . '.png' ) or die $img->errstr;
        Quit;
    },
    undef
);

Main();