#!/usr/bin/env perl6
use v6;
use Test;
use JSON::Fast;
use lib $?FILE.IO.dirname;
use Raindrops;
plan 18;

my Version:D $version = v2;

if Raindrops.^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\nRaindrops is {Raindrops.^ver.gist}. "
    ~ "Test is {$version.gist}.\n";
}

my $c-data = from-json $=pod.pop.contents;
for @($c-data<cases>) {
  subtest {
    plan 2;
    is .<number>.&convert, |.<expected description>;
    isa-ok .<number>.&convert, Str;
  }
}

=head2 Canonical Data
=begin code
{
  "exercise": "raindrops",
  "version": "1.0.0",
  "cases": [
    {
      "description": "the sound for 1 is 1",
      "property": "convert",
      "number": 1,
      "expected": "1"
    },
    {
      "description": "the sound for 3 is Pling",
      "property": "convert",
      "number": 3,
      "expected": "Pling"
    },
    {
      "description": "the sound for 5 is Plang",
      "property": "convert",
      "number": 5,
      "expected": "Plang"
    },
    {
      "description": "the sound for 7 is Plong",
      "property": "convert",
      "number": 7,
      "expected": "Plong"
    },
    {
      "description": "the sound for 6 is Pling as it has a factor 3",
      "property": "convert",
      "number": 6,
      "expected": "Pling"
    },
    {
      "description": "2 to the power 3 does not make a raindrop sound as 3 is the exponent not the base",
      "property": "convert",
      "number": 8,
      "expected": "8"
    },
    {
      "description": "the sound for 9 is Pling as it has a factor 3",
      "property": "convert",
      "number": 9,
      "expected": "Pling"
    },
    {
      "description": "the sound for 10 is Plang as it has a factor 5",
      "property": "convert",
      "number": 10,
      "expected": "Plang"
    },
    {
      "description": "the sound for 14 is Plong as it has a factor of 7",
      "property": "convert",
      "number": 14,
      "expected": "Plong"
    },
    {
      "description": "the sound for 15 is PlingPlang as it has factors 3 and 5",
      "property": "convert",
      "number": 15,
      "expected": "PlingPlang"
    },
    {
      "description": "the sound for 21 is PlingPlong as it has factors 3 and 7",
      "property": "convert",
      "number": 21,
      "expected": "PlingPlong"
    },
    {
      "description": "the sound for 25 is Plang as it has a factor 5",
      "property": "convert",
      "number": 25,
      "expected": "Plang"
    },
    {
      "description": "the sound for 27 is Pling as it has a factor 3",
      "property": "convert",
      "number": 27,
      "expected": "Pling"
    },
    {
      "description": "the sound for 35 is PlangPlong as it has factors 5 and 7",
      "property": "convert",
      "number": 35,
      "expected": "PlangPlong"
    },
    {
      "description": "the sound for 49 is Plong as it has a factor 7",
      "property": "convert",
      "number": 49,
      "expected": "Plong"
    },
    {
      "description": "the sound for 52 is 52",
      "property": "convert",
      "number": 52,
      "expected": "52"
    },
    {
      "description": "the sound for 105 is PlingPlangPlong as it has factors 3, 5 and 7",
      "property": "convert",
      "number": 105,
      "expected": "PlingPlangPlong"
    },
    {
      "description": "the sound for 3125 is Plang as it has a factor 5",
      "property": "convert",
      "number": 3125,
      "expected": "Plang"
    }
  ]
}
=end code
