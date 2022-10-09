#!/usr/bin/perl
use strict;
use warnings;

if (@ARGV<4) {
	print "perl $0 <cds fasta> <accesssion number> <start> <end> <reverse tag, 1 if reverse>\n";
	exit;
}

my ($cds_file, $an, $str, $end, $r)=@ARGV;
unless ($r) {
	$r=0;
}

$/="\>";
open (IN, $cds_file) || die;
<IN>;
while (<IN>) {
	my ($id, $seq)=split /\n/,$_,2;
	$id=~s/\S+\=//;
	#print $id."\n";
	$seq=~s/\>//g;
	if ($id=~/(\S+)\s+.*?(\S+)\:(\d+)\:(\d+)\:([+-])/) {
		my ($id, $cds_an, $cds_str, $cds_end, $dir)=($1, $2, $3, $4, $5, $6);
		if ($cds_an=~/:/) {
			$cds_an=(split /\:/, $cds_an)[1];
		}
		#print $id."\t".$cds_an."\t".$cds_str."\t".$cds_end."\t".$dir."\n";
		if ($cds_an eq $an and $cds_str>=$str and $cds_end<=$end) {
			my $tmp=$cds_str;
			$cds_str = $r==1? abs($cds_end-$end)+1 : $cds_str-$str+1;
			$cds_end = $r==1? abs($tmp-$end)+1 : $cds_end-$str+1;
			$cds_an = $r==1? $cds_an."\_".$str."\_".$end."\_r" : $cds_an."\_".$str."\_".$end;
			if ($r==1 and $dir eq "+") {
				$dir="-";
			}
			elsif ($r==1 and $dir eq "-") {
				$dir="+";
			}

			print ">".$id." sequence:".$cds_an.":".$cds_str.":".$cds_end.":".$dir."\n".$seq;
		}
	}
}
close IN;
