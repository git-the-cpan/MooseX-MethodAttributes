use strict;
use warnings;

package SubClass;
our $VERSION = '0.16_01';


use Moose;
BEGIN { extends 'BaseClass'; }

sub bar : Bar {}

{
    my $no_calls_to_affe = 0;

    before affe => sub {
        $no_calls_to_affe++;
    };

    sub no_calls_to_affe {
        $no_calls_to_affe;
    }
}
no Moose;

1;
