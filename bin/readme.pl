#!/usr/bin/env perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Template;
use Path::Class qw( file dir );

my %param = get_param( );

my $file = file( "template/readme.tmpl" );
my $tmpl = Template->new;
$tmpl->process( "$file", \%param, \my $output )
    or die $tmpl->error;

say $output;

exit;

sub get_param {
    my $dir = dir( "image/" );
    my @files = map { $_->[1] }
                sort { $a->[0] cmp $b->[0] }
                map {
                    my @terms = split m{[.]}, $_->basename;
                    if ( @terms == 2 ) {
                        @terms = ( $terms[0], 1, $terms[1] );
                    }
                    [ join( q{.}, @terms ), $_ ];
                }
                $dir->children;
    return (
        files => [
            map { { title => $_->basename, link => $_ } }
            @files
        ],
    );
}
