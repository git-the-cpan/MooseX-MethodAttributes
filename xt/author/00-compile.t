use 5.006;
use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::Compile 2.054

use Test::More 0.94;

plan tests => 14;

my @module_files = (
    'MooseX/MethodAttributes.pm',
    'MooseX/MethodAttributes/Inheritable.pm',
    'MooseX/MethodAttributes/Role.pm',
    'MooseX/MethodAttributes/Role/AttrContainer.pm',
    'MooseX/MethodAttributes/Role/AttrContainer/Inheritable.pm',
    'MooseX/MethodAttributes/Role/Meta/Class.pm',
    'MooseX/MethodAttributes/Role/Meta/Map.pm',
    'MooseX/MethodAttributes/Role/Meta/Method.pm',
    'MooseX/MethodAttributes/Role/Meta/Method/MaybeWrapped.pm',
    'MooseX/MethodAttributes/Role/Meta/Method/Wrapped.pm',
    'MooseX/MethodAttributes/Role/Meta/Role.pm',
    'MooseX/MethodAttributes/Role/Meta/Role/Application.pm',
    'MooseX/MethodAttributes/Role/Meta/Role/Application/Summation.pm'
);



# no fake home requested

my $inc_switch = -d 'blib' ? '-Mblib' : '-Ilib';

use File::Spec;
use IPC::Open3;
use IO::Handle;

open my $stdin, '<', File::Spec->devnull or die "can't open devnull: $!";

my @warnings;
for my $lib (@module_files)
{
    # see L<perlfaq8/How can I capture STDERR from an external command?>
    my $stderr = IO::Handle->new;

    my $pid = open3($stdin, '>&STDERR', $stderr, $^X, $inc_switch, '-e', "require q[$lib]");
    binmode $stderr, ':crlf' if $^O eq 'MSWin32';
    my @_warnings = <$stderr>;
    waitpid($pid, 0);
    is($?, 0, "$lib loaded ok");

    shift @_warnings if @_warnings and $_warnings[0] =~ /^Using .*\bblib/
        and not eval { require blib; blib->VERSION('1.01') };

    if (@_warnings)
    {
        warn @_warnings;
        push @warnings, @_warnings;
    }
}



is(scalar(@warnings), 0, 'no warnings found')
    or diag 'got warnings: ', explain(\@warnings);

BAIL_OUT("Compilation problems") if !Test::More->builder->is_passing;