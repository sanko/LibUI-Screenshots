use LibUI ':all';
use LibUI::Grid;
use LibUI::Window;
use LibUI::Align qw[Center Fill];
use LibUI::At    qw[Bottom];
use LibUI::Label;
Init( { Size => 1024 } ) && die;
my $window = LibUI::Window->new( 'Hi', 320, 100, 0 );
my $grid   = LibUI::Grid->new();
my $lbl    = LibUI::Label->new('Top Left');
$grid->append( $lbl,                           0, 0, 1, 1, 1, Fill, 1, Fill );
$grid->append( LibUI::Label->new('Top Right'), 1, 0, 1, 1, 1, Fill, 1, Fill );
$grid->insertAt( LibUI::Label->new('Bottom Center and Span two cols'),
    $lbl, Bottom, 2, 1, 1, Center, 1, Center );
$window->setChild($grid);
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