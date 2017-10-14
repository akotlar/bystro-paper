#! /usr/bin/perl
use 5.10.0;
use strict;
use warnings;

use DDP;

# Search for  alt:(A || C || T || G)

if(@ARGV < 1) {
  die "annotationFile ; Will do manual search alt:(A || C || T || G)";
}


# open(my $bedFh, '<', $ARGV[0]);

my $snpFh;
if($ARGV[0] =~ /\.gz$/) {
  open($snpFh, '-|', "pigz -d -c $ARGV[0]");
} else {
  open($snpFh, '<', $ARGV[0]);
}

my $altIdx;
my $countOk = 0;
while(<$snpFh>) {
  chomp;

  # gzip \$_ => \$compressed or die "wtf";

  my @fields = split '\t', $_;

  if($. == 1) {
    my $i = 0;
    for my $field(@fields) {
      if ($field eq 'alt') {
        $altIdx = $i;
        last;
      }

      $i++;
    }

    say $_;
    next;
  }

  my $alt = $fields[$altIdx];
  if ($alt eq "A" || $alt eq "C" || $alt eq "T" || $alt eq "G") {
    say $_;
    $countOk++;
  }
}

say STDERR "Kept $countOk values that were alt:(A || C || T || G)";
