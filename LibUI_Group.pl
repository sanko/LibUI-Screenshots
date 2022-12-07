use LibUI ':all';
use LibUI::Group;
use LibUI::HBox;
use LibUI::Window;
use LibUI::ColorButton;
use LibUI::Label;
Init( { Size => 1024 } ) && die;
my $window = LibUI::Window->new( 'Hi', 320, 100, 0 );
my $group  = LibUI::Group->new('Color Pickers');
my $box    = LibUI::HBox->new;
my $cbtn_l = LibUI::ColorButton->new();
my $cbtn_r = LibUI::ColorButton->new();
sub colorChanged {
    warn sprintf '#%02X%02X%02X%02X', map { $_ * 255 } shift->color();
}
$cbtn_l->onChanged( \&colorChanged, $cbtn_l );
$cbtn_r->onChanged( \&colorChanged, $cbtn_r );
$box->append( $_, 1 ) for $cbtn_l, $cbtn_r;
$group->setChild($box);
$window->setChild($group);
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