#!/usr/bin/perl

=head1 Description
	cut sequence from fasta file
=head1 Usage
	perl cut_seq_from_fa_file.pl [options]
		--f fasta sequence; must be given
		--l target list file (seq_id start end; if need reversed complementary sequence: seq_id end start)
		--p target list, seq_id1,start1,end1,seq_id2,start2,end2.....
		--i target id, pick whole sequence
		--r rename, use fasta file name
		--h show help
=head1 Example
	perl cut_seq_from_fa_file.pl -f sequence.fasta -l target.list > target.fasta
	perl cut_seq_from_fa_file.pl -f sequence.fasta -p seq_id1,start1,end1,seq_id2,start2,end2 > target.fasta

=head1 Version
	Author: Du Pengcheng dupengcheng@icdc.cn
	Date: 2011-08-19

=cut

use strict;
use warnings;
use Getopt::Long;
use File::Basename;

my ($in_file,$tar_file,$tar_list,$id_list,$help,$rename,@cut,%seq);
GetOptions (
	"f:s"=>\$in_file,
	"l:s"=>\$tar_file,
	"p:s"=>\$tar_list,
	"i:s"=>\$id_list,
	"h"=>\$help,
	"r"=>\$rename,
);
die `pod2text $0` if ($help || !$in_file || (!$tar_file && !$tar_list && !$id_list));

$/="\>";
open (IN,"$in_file") || die "OpenError: $in_file";
<IN>;
while (<IN>) {
	my ($id,$seq)=split /\n/,$_,2;
	$id=(split /\s+/,$id)[0];
	$seq=~s/[\r\n\>]//g;
	$seq{$id}=uc($seq);
}
close IN;
$/="\n";

if ($tar_file) {
	open (IN,$tar_file) || die;
	while (<IN>) {
		chomp;
		my ($id,$start,$end)=split /\s+/,$_;
		push @cut,$id,$start,$end;
	}
	cut();
}
elsif ($tar_list) {
	@cut=split /\,/,$tar_list;
	cut();
}
elsif ($id_list) {
	open (IN,$id_list) || die;
	while (<IN>) {
		chomp;
		my $id=(split /\s+/,$_)[0];
		if (exists $seq{$id}) {
			(my $seq=$seq{$id})=~s/(.{50})/$1\n/g;
			print ">".$id."\n".$seq."\n";
		}
		else {
			#print "No such sequence : $_\n";
		}
	}
}

sub cut {
	for (my $i=0; $i<@cut ;$i+=3) {
		if (!exists $seq{$cut[$i]}) {
			print "No such sequence : $cut[$i]\n";
		}
		else {
			my $start=getMin($cut[$i+1],$cut[$i+2]);
			my $end=getMax($cut[$i+1],$cut[$i+2]);
			my $seq=substr($seq{$cut[$i]},$start-1,$end-$start+1);
			my $tag=(split /\./, basename($in_file))[0];
			if ($cut[$i+1]>$cut[$i+2]) {
				$seq=~tr/ATCG/TAGC/;
				$seq=reverse $seq;
				$seq=~s/(.{50})/$1\n/g;
				if ($rename) {
					print ">".$tag."\n";
				}
				else {
					print ">".$cut[$i]."_".$start."_".$end."\_r\n";
				}
				print $seq."\n";
			}
			else {
				$seq=~s/(.{50})/$1\n/g;
				if ($rename) {
					print ">".$tag."\n";
				}
				else {
					print ">".$cut[$i]."_".$start."_".$end."\n";
				}
				print $seq."\n";
			}
		}
	}
}

sub getMin {
	return $_[0]<$_[1] ? $_[0]:$_[1];
}

sub getMax {
	return $_[0]>$_[1] ? $_[0]:$_[1];
}
