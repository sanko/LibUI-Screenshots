use LibUI ':all';
use LibUI::VBox;
use LibUI::Window;
use LibUI::FontButton;
Init( { Size => 1024 } ) && die;
my $window = LibUI::Window->new( 'Font Picker', 320, 100, 0 );
my $box    = LibUI::VBox->new();
my $text   = LibUI::FontButton->new();
$box->append( $text, 1 );
$text->onChanged(
    sub {
        my $f = shift->font;

        # Some enum values don't have a 1:1 equiv with CSS but...
        printf <<'', $f->{weight}, $f->{italic}, $f->{size}, $f->{family};
            html {
                font: %s %s %spt "%s";
            }

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