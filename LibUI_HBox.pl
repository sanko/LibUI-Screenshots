use LibUI ':all';
use LibUI::HBox;
use LibUI::Window;
use LibUI::ColorButton;
use LibUI::Label;
Init( { Size => 1024 } ) && die;
my $window = LibUI::Window->new( 'Hi', 320, 100, 0 );
my $box    = LibUI::HBox->new;
my $lbl    = LibUI::Label->new('Pick a color');
my $cbtn   = LibUI::ColorButton->new();
$cbtn->onChanged(
    sub {
        my @rgba = $cbtn->color();
        $lbl->setText(
            sprintf "#%02X%02X%02X%02X\nrgba(%d, %d, %d, %.2f)",
            ( map { $_ * 255 } @rgba ),
            ( map { $_ * 255 } @rgba[ 0 .. 2 ] ),
            $rgba[-1]
        );
    },
    undef
);
$box->setPadded(1);
$box->append( $cbtn, 1 );
$box->append( $lbl,  1 );
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