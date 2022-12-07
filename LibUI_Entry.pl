use LibUI ':all';
use LibUI::VBox;
use LibUI::Window;
use LibUI::Entry;
Init( { Size => 1024 } ) && die;
my $window = LibUI::Window->new( 'Hi', 320, 100, 0 );
my $box    = LibUI::VBox->new();
my $entry  = LibUI::Entry->new;
$box->append( $entry, 0 );
$entry->onChanged( sub { warn shift->text }, undef );
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
        $img->write( file => __FILE__ . '.png' ) or die $img->errstr;
        Quit;
    },
    undef
);

Main();