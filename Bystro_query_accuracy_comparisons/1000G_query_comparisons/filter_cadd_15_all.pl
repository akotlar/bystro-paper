#! /usr/bin/perl
use 5.10.0;
use strict;
use warnings;

use DDP;

# Any CADD scores > 15; whether or not in snp

if(@ARGV < 1) {
  die "annotationFile ; Will do manual search for cadd > 15 on any kind of variant)";
}

my $snpFh;
if($ARGV[0] =~ /\.gz$/) {
  open($snpFh, '-|', "pigz -d -c $ARGV[0]");
} else {
  open($snpFh, '<', $ARGV[0]);
}

my $caddIdx;
my $countOk = 0;
while(<$snpFh>) {
  chomp;

  # gzip \$_ => \$compressed or die "wtf";

  my @fields = split '\t', $_;

  if($. == 1) {
    my $i = 0;
    for my $field(@fields) {
      if ($field eq 'cadd') {
        $caddIdx = $i;
        last;
      }

      $i++;
    }

    say $_;
    next;
  }

  my @caddVals = map { split ";" } split /\|/, $fields[$caddIdx];

  for my $cadd (@caddVals) {
    if ($cadd > 15) {
      say $_;
      $countOk++;
      last;
    }
  }
}

say STDERR "Kept $countOk values that were cadd > 15 in scalar CADD fields";
