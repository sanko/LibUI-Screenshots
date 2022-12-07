use LibUI ':all';
use LibUI::VBox;
use LibUI::Window;
use LibUI::Checkbox;
Init( { Size => 1024 } ) && die;
my $window = LibUI::Window->new( 'Hi', 320, 100, 0 );
my $box    = LibUI::VBox->new();

sub checked {
    my ( $ctrl, $data ) = @_;
    printf "%s is %schecked\n", $ctrl->text, $ctrl->checked ? '' : 'un';
}
for my $lang (qw[Perl Rust Java C C++ Python Go COBOL]) {
    my $chk = LibUI::Checkbox->new($lang);
    $chk->onToggled( \&checked, undef );
    $box->append( $chk, 0 );
}
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