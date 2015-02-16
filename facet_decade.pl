#!/usr/bin/env perl

use Time::Piece;
use Data::Dumper;
use List::MoreUtils qw( minmax );
use POSIX qw( floor );

use strict;
use warnings;
use utf8;
use 5.010;
use feature qw( say );
use JSON qw( to_json );

sub facet_decade {
  my ($string) = @_;
  my ($year, @matches, @decades);
  $year = Time::Piece->new()->year;
  @matches = ($string =~ m/(?<!\d)(\d{4})(?!\d)/g);
  @matches = grep( $_ >= 1000, @matches);
  @matches = grep( $_ <= $year, @matches);
  unless (@matches) {
    return \@decades;
    }
  my ($start, $end) = minmax @matches;
  $start = floor($start / 10) * 10;
  for (my $x = $start; $x <= $end; $x = $x + 10) {
    push @decades, $x . 's';
    }
  return \@decades;
  }

sub run {
  my( $class, @args ) = @_;
  if (!@args) {
    say('usage: facet_decade.pl: "date string" ["date string" ...]');
    exit();
    }
  for my $string (@args) {
    print to_json(facet_decade($string));
    }
  }

# modulino
__PACKAGE__->run( @ARGV ) unless caller;

1;
