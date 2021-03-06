#!/usr/bin/env perl6
use v6;
use YAML::Parser::LibYAML;
use lib (my $base-dir = $?FILE.IO.resolve.parent.parent).add('lib');
use Exercism::Generator;

my %*SUB-MAIN-OPTS = :named-anywhere;

given $base-dir {
  if .add('problem-specifications') !~~ :d {
    note 'problem-specifications directory not found; exercise(s) may generate incorrectly.';
  }
  if .add('bin/configlet') !~~ :f {
    note 'configlet not found; README.md file(s) will not be generated.';
  }
}

multi sub MAIN (Bool:D :$all where *.so) {
  generate .basename for $base-dir.add('exercises').dir;
}

multi sub MAIN (*@exercises) {
  @exercises».&generate;
}

multi sub MAIN {
  say 'No args given; working in current directory.';
  if '.meta/exercise-data.yaml'.IO ~~ :f {
    generate $*CWD.IO.basename;
  } else {
    say 'exercise-data.yaml not found in .meta of current directory; exiting.';
    exit;
  }
}

sub generate ($exercise) {
  state (@dir-not-found, @yaml-not-found);
  END {
    if @dir-not-found  {note 'exercise directory does not exist for: ' ~ join ' ', @dir-not-found}
    if @yaml-not-found {note '.meta/exercise-data.yaml not found for: ' ~ join ' ', @yaml-not-found}
  }
  if (my $exercise-dir = $base-dir.add("exercises/$exercise")) !~~ :d {
    push @dir-not-found, $exercise;
    return;
  }
  if (my $yaml-file = $exercise-dir.add('.meta/exercise-data.yaml')) !~~ :f {
    push @yaml-not-found, $exercise;
    return;
  }

  print "Generating $exercise... ";

  given Exercism::Generator.new: :$exercise, data => yaml-parse $yaml-file.absolute {
    given $exercise-dir.add("$exercise.t") -> $testfile {
      $testfile.spurt: .test;
      $testfile.chmod: 0o755;
    }
    $exercise-dir.add("{.data<exercise>}.pm6").spurt: .stub;
    $exercise-dir.add('.meta/solutions').mkdir;
    $exercise-dir.add(".meta/solutions/{.data<exercise>}.pm6").spurt: .example;
  }

  given $base-dir.add('bin/configlet') {
    if $_ ~~ :f {
      run .absolute, 'generate', $base-dir, '--only', $exercise;
    }
  }

  say 'Generated.';
}
