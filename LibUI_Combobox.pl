use LibUI ':all';
use LibUI::VBox;
use LibUI::Window;
use LibUI::Combobox;
Init( { Size => 1024 } ) && die;
my $window = LibUI::Window->new( 'Hi', 320, 100, 0 );
my $box    = LibUI::VBox->new();
my $combo  = LibUI::Combobox->new();
my @langs  = ( qw[English French Klingon German Japanese], 'Ubbi dubbi' );
$combo->append($_) for @langs;
$box->append( $combo, 0 );
$combo->onSelected( sub { warn 'Language: ' . $langs[ shift->selected ] }, undef );
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