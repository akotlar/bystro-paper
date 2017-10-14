#! /usr/bin/perl
use 5.10.0;
use strict;
use warnings;

use DDP;
use Scalar::Util qw/looks_like_number/;

if(@ARGV < 1) {
  die "annotationFile ; Will do manual search for cadd > 15 on variants with a single cadd value (all SNP-like fields)";
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

  my $caddVal = $fields[$caddIdx];

  if(!looks_like_number($caddVal)) {
    # Either missing or an array
    next;
  }

  if ($caddVal > 15) {
    say $_;
    $countOk++;
  }
}

say STDERR "Kept $countOk values that were cadd > 15 in scalar CADD fields";
