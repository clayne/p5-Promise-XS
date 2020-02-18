#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

use Promise::XS;

my $def = Promise::XS::deferred();

$def->resolve(234, 567);

my $p = $def->promise();

my ($args, $wantarray);

my $finally = $p->finally( sub {
    $args = \@_;
    $wantarray = wantarray;
} );

is_deeply( $args, [], 'no args given to finally() callback' );
is( $wantarray, undef, 'finally() callback is called in void context' );

my $got;
$finally->then( sub { $got = \@_ } );

is_deeply( $got, [234, 567], 'args to then() after a finally()' );

done_testing;

1;
