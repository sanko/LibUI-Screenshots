use LibUI ':all';
use LibUI::VBox;
use LibUI::Window;
use LibUI::EditableCombobox;
Init( { Size => 1024 } ) && die;
my $window = LibUI::Window->new( 'Hi', 320, 100, 0 );
my $box    = LibUI::VBox->new();
my $combo  = LibUI::EditableCombobox->new();
my @langs  = ( qw[English French Klingon German Japanese], 'Ubbi dubbi' );
$combo->append($_) for @langs;
$box->append( $combo, 0 );
$combo->onChanged( sub { warn 'Language: ' . shift->text }, undef );
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