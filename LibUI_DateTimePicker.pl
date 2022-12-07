use LibUI ':all';
use LibUI::VBox;
use LibUI::Window;
use LibUI::DateTimePicker;
use Time::Piece;
Init( { Size => 1024 } ) && die;
my $window = LibUI::Window->new( 'Schedule an Event', 320, 100, 0 );
my $box    = LibUI::VBox->new();
my $date   = LibUI::DateTimePicker->new();
$box->append( $date, 0 );
$date->setTime( localtime->add_months(3) );
$date->onChanged(
    sub {
        my $picker = shift;
        my $t      = $picker->time;
        warn sprintf 'Setting an appointment for %s at %s', $t->time, $t->date;
    },
    undef
);
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