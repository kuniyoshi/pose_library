#!/usr/bin/perl
use 5.10.0;
use utf8;
use strict;
use warnings;
use open qw( :utf8 :std );
use Data::Dumper;
use Path::Class qw( file dir );
use File::Copy ( );
use Time::Piece qw( localtime );

my $original = file( "$ENV{HOME}/Downloads/clip.png" );

die "No copy source found"
    unless -e $original;

my $filename = get_new_filename( );

File::Copy::copy( $original, $filename )
    or die "Could not copy from $original to $filename, $!";

exit;

sub get_new_filename {
    my $dir = dir( "image" );
    my $date = localtime->date;
    my $suffix = 1;

    while ( 1 ) {
        my $basename = join q{.}, ( localtime->date, $suffix != 1 ? ( $suffix ) : ( ), q{png} );
        my $file = $dir->file( $basename );
        return $file
            if ! -e $file;
        $suffix++;
        die "Too many retries: $suffix"
            if $suffix > 10;
    }
}

