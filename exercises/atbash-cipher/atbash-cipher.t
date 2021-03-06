#!/usr/bin/env perl6
use v6;
use Test;
use JSON::Fast;
use lib $?FILE.IO.dirname;
use AtbashCipher;
plan 12;

my Version:D $version = v2;

if AtbashCipher.^ver !~~ $version {
  warn "\nExercise version mismatch. Further tests may fail!"
    ~ "\nAtbashCipher is {AtbashCipher.^ver.gist}. "
    ~ "Test is {$version.gist}.\n";
}

my $c-data = from-json $=pod.pop.contents;
is .<input><phrase>.&::(.<property>), |.<expected description> for $c-data<cases>»<cases>».Array.flat;

=head2 Canonical Data
=begin code
{
  "exercise": "atbash-cipher",
  "version": "1.1.0",
  "comments": [
    "The tests are divided into two groups: ",
    "* Encoding from English to atbash cipher",
    "* Decoding from atbash cipher to all-lowercase-mashed-together English"
  ],
  "cases": [
    {
      "description": "encode",
      "comments": [ "Test encoding from English to atbash" ],
      "cases": [
        {
          "description": "encode yes",
          "property": "encode",
          "input": {
            "phrase": "yes"
          },
          "expected": "bvh"
        },
        {
          "description": "encode no",
          "property": "encode",
          "input": {
            "phrase": "no"
          },
          "expected": "ml"
        },
        {
          "description": "encode OMG",
          "property": "encode",
          "input": {
            "phrase": "OMG"
          },
          "expected": "lnt"
        },
        {
          "description": "encode spaces",
          "property": "encode",
          "input": {
            "phrase": "O M G"
          },
          "expected": "lnt"
        },
        {
          "description": "encode mindblowingly",
          "property": "encode",
          "input": {
            "phrase": "mindblowingly"
          },
          "expected": "nrmwy oldrm tob"
        },
        {
          "description": "encode numbers",
          "property": "encode",
          "input": {
            "phrase": "Testing,1 2 3, testing."
          },
          "expected": "gvhgr mt123 gvhgr mt"
        },
        {
          "description": "encode deep thought",
          "property": "encode",
          "input": {
            "phrase": "Truth is fiction."
          },
          "expected": "gifgs rhurx grlm"
        },
        {
          "description": "encode all the letters",
          "property": "encode",
          "input": {
            "phrase": "The quick brown fox jumps over the lazy dog."
          },
          "expected": "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"
        }
      ]
    },
    {
      "description": "decode",
      "comments": [ "Test decoding from atbash to English" ],
      "cases": [
        {
          "description": "decode exercism",
          "property": "decode",
          "input": {
            "phrase": "vcvix rhn"
          },
          "expected": "exercism"
        },
        {
          "description": "decode a sentence",
          "property": "decode",
          "input": {
            "phrase": "zmlyh gzxov rhlug vmzhg vkkrm thglm v"
          },
          "expected": "anobstacleisoftenasteppingstone"
        },
        {
          "description": "decode numbers",
          "property": "decode",
          "input": {
            "phrase": "gvhgr mt123 gvhgr mt"
          },
          "expected": "testing123testing"
        },
        {
          "description": "decode all the letters",
          "property": "decode",
          "input": {
            "phrase": "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"
          },
          "expected": "thequickbrownfoxjumpsoverthelazydog"
        }
      ]
    }
  ]
}
=end code
