use LibUI ':all';
use LibUI::Window;
use LibUI::Button;
Init( { Size => 1024 } ) && die;
my $window = LibUI::Window->new( 'Hi', 320, 100, 0 );
my $btn    = LibUI::Button->new('Click me!');
$btn->onClicked(
    sub {
        $_[0]->setText( sprintf 'Clicked %d times', ++$_[1] );
    },
    my $i = 0
);
$window->setChild($btn);
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