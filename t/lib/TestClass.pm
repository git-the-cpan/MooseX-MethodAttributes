package TestClass;
our $VERSION = '0.05';


use Moose;
use MooseX::MethodAttributes;

sub foo : SomeAttribute AnotherAttribute('with argument') {}

after foo => sub {};

package SubClass;
our $VERSION = '0.05';


use Moose;
use MooseX::MethodAttributes;

extends qw/TestClass/;

sub foo : Attributes Attributes Attributes {}

1;
