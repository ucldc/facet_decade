#!/usr/bin/env perl
package facet_decade;

use Time::Piece;
use List::MoreUtils qw( minmax );
use POSIX qw( floor );

use strict;
use warnings;
use utf8;
use JSON qw( to_json );

sub facet_decade {
  # process string and return array reference of decades
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
    print('usage: facet_decade.pm: "date string" ["date string" ...]'."\n");
    exit();
    }
  for my $string (@args) {
    print to_json(facet_decade($string));
    }
  }

# modulino
__PACKAGE__->run( @ARGV ) unless caller;

1;

=begin license
Copyright © 2015, Regents of the University of California
All rights reserved.
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
- Redistributions of source code must retain the above copyright notice,
  this list of conditions and the following disclaimer.
- Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.
- Neither the name of the University of California nor the names of its
  contributors may be used to endorse or promote products derived from this
  software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
=end license
=cut
