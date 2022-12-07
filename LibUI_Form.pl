use LibUI ':all';
use LibUI::Form;
use LibUI::Window;
use LibUI::ColorButton;
Init( { Size => 1024 } ) && die;
my $window = LibUI::Window->new( 'Hi', 320, 100, 0 );
my $form   = LibUI::Form->new();
my $cbtn_l = LibUI::ColorButton->new();
my $cbtn_r = LibUI::ColorButton->new();

sub colorChanged {
    warn sprintf '%5s #%02X%02X%02X%02X', pop, map { $_ * 255 } shift->color();
}
$cbtn_l->onChanged( \&colorChanged, 'Left' );
$cbtn_r->onChanged( \&colorChanged, 'Right' );
$form->append( 'Left',  $cbtn_l, 0 );
$form->append( 'Right', $cbtn_r, 0 );
$form->setPadded(1);
$window->setChild($form);
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