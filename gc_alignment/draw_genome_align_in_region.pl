#!/usr/bin/perl

=head1 Description
		draw linear schema of alignment in a selected region between two genomes (both complete and draft sequence are accepted)

=head1 Usage
		perl draw_genome_align_in_region.pl [options]
			-ref      <file>             reference sequence file; necessary
			-ref_pos  <ID,start,end,strand>
			-ref_cds  <file>             reference cds sequence
			-qry      <file>             query sequence file; necessary
			-qry_pos  <ID,start,end,strand>
			-qry_cds  <file>             query cds sequence
			-mark_cds <file>             list of marked cds
			-scale    <number>           scale for draw figure, default 2000
			-len_cut  <number>           blast length cutoff; default 1000
			-o        <dir>              output dir; default current
			-help                        show help

=head1 Example

=head1 Version
		Author: Du Pengcheng, dupengcheng@icdc.cn
		Date: 2017-11-1

=cut

use strict;
use warnings;
use File::Basename;
use Getopt::Long;

my ($ref_file,$ref_pos,$ref_cds,$qry_file,$qry_pos,$qry_cds,$mark_cds,$scale,$filt,$od,$help);

GetOptions (
	"ref:s"=>\$ref_file,
	"ref_pos:s"=>\$ref_pos,
	"ref_cds:s"=>\$ref_cds,
	"qry:s"=>\$qry_file,
	"qry_pos:s"=>\$qry_pos,
	"qry_cds:s"=>\$qry_cds,
	"mark_cds:s"=>\$mark_cds,
	"scale:s"=>\$scale,
	"len_cut:s"=>\$filt,
	"o:s"=>\$od,
	"help"=>\$help,
);

die `pod2text $0` if ($help || ! $ref_file || ! $qry_file);

$scale=2000 unless ($scale);
$filt=1000 unless ($filt);
$od="./" unless ($od);
unless (-e $od) {
	mkdir $od;
}

unless (-e $ref_file) {
	die "No $ref_file\n";
}

unless (-e $qry_file) {
	die "No $qry_file\n";
}


open (LOG, ">>$od/draw_alignment.sh") || die;

#prepare sequence data
my $ref_tag=(split /\./, basename($ref_file))[0];
if ($ref_pos) {
	`perl /datapool/bioinfo/dupc/bin/Sequence/cut_seq_from_fa_file.pl -f $ref_file -p $ref_pos > $od/$ref_tag.fas`;
	print LOG "perl /datapool/bioinfo/dupc/bin/Sequence/cut_seq_from_fa_file.pl -f $ref_file -p $ref_pos > $od/$ref_tag.fas\n";
	if ($ref_cds) {
		my ($an, $str, $end, $tag)=split /\,/, $ref_pos;
		if ($tag eq "-") {
			$tag=1;
		}
		else {
			$tag=0;
		}
		`perl /datapool/bioinfo/dupc/bin/SVG_script/genome_align/trim_cds_list.pl $ref_cds $an $str $end $tag > $od/$ref_tag.cds`;
		print LOG "perl /datapool/bioinfo/dupc/bin/SVG_script/genome_align/trim_cds_list.pl $ref_cds $an $str $end $tag > $od/$ref_tag.cds\n";
	}
}
else {
	`ln -s $ref_file $od/$ref_tag.fas`;
	print LOG "ln -s $ref_file $od/$ref_tag.fas\n";
	if ($ref_cds) {
		`ln -s $ref_cds $od/$ref_tag.cds`;
		print LOG "ln -s $ref_cds $od/$ref_tag.cds\n";
	}
}

my $qry_tag=(split /\./, basename($qry_file))[0];
if ($qry_pos) {
	`perl /datapool/bioinfo/dupc/bin/Sequence/cut_seq_from_fa_file.pl -f $qry_file -p $qry_pos > $od/$qry_tag.fas`;
	print LOG "perl /datapool/bioinfo/dupc/bin/Sequence/cut_seq_from_fa_file.pl -f $qry_file -p $qry_pos > $od/$qry_tag.fas\n";
	if ($qry_cds) {
		my ($an, $str, $end, $tag)=split /\,/, $qry_pos;
		if ($tag eq "-") {
			$tag=1;
		}
		else {
			$tag=0;
		}
		`perl /datapool/bioinfo/dupc/bin/SVG_script/genome_align/trim_cds_list.pl $qry_cds $an $str $end $tag > $od/$qry_tag.cds`;
		print LOG "perl /datapool/bioinfo/dupc/bin/SVG_script/genome_align/trim_cds_list.pl $qry_cds $an $str $end $tag > $od/$qry_tag.cds\n";
	}
}
else {
	`ln -s $qry_file $od/$qry_tag.fas`;
	print LOG "ln -s $qry_file $od/$qry_tag.fas\n";
	if ($qry_cds) {
		`ln -s $qry_cds $od/$qry_tag.cds`;
		print LOG "ln -s $qry_cds $od/$qry_tag.cds\n";
	}
}

`formatdb -i $od/$ref_tag.fas -p F`;
`blastall -i $od/$qry_tag.fas -d $od/$ref_tag.fas -o $od/$qry_tag.$ref_tag.blast -e 1e-5 -F F -p blastn`;
`perl /datapool/bioinfo/dupc/bin/blast/blast_parser.pl -nohead $od/$qry_tag.$ref_tag.blast > $od/$qry_tag.$ref_tag.blast.p`;
print LOG "formatdb -i $od/$ref_tag.fas -p F\n";
print LOG "blastall -i $od/$qry_tag.fas -d $od/$ref_tag.fas -o $od/$qry_tag.$ref_tag.blast -e 1e-5 -F F -p blastn\n";
print LOG "perl /datapool/bioinfo/dupc/bin/blast/blast_parser.pl -nohead $od/$qry_tag.$ref_tag.blast > $od/$qry_tag.$ref_tag.blast.p\n";

if ($ref_cds and $qry_cds and $mark_cds) {
	`perl /datapool/bioinfo/dupc/bin/SVG_script/genome_align/draw_genome_align_linear.pl -ref $od/$ref_tag.fas -qry $od/$qry_tag.fas -ref_cds $od/$ref_tag.cds -qry_cds $od/$qry_tag.cds -blast $od/$qry_tag.$ref_tag.blast.p -mark_cds $mark_cds -scale $scale -len_cut $filt -svg $od/$qry_tag.$ref_tag.svg`;
	print LOG "perl /datapool/bioinfo/dupc/bin/SVG_script/genome_align/draw_genome_align_linear.pl -ref $od/$ref_tag.fas -qry $od/$qry_tag.fas -ref_cds $od/$ref_tag.cds -qry_cds $od/$qry_tag.cds -blast $od/$qry_tag.$ref_tag.blast.p -mark_cds $mark_cds -scale $scale -len_cut $filt -svg $od/$qry_tag.$ref_tag.svg\n";
}
elsif ($ref_cds and !$qry_cds and $mark_cds) {
	`perl /datapool/bioinfo/dupc/bin/SVG_script/genome_align/draw_genome_align_linear.pl -ref $od/$ref_tag.fas -qry $od/$qry_tag.fas -ref_cds $od/$ref_tag.cds -blast $od/$qry_tag.$ref_tag.blast.p -mark_cds $mark_cds -scale $scale -len_cut $filt -svg $od/$qry_tag.$ref_tag.svg`;
	print LOG "perl /datapool/bioinfo/dupc/bin/SVG_script/genome_align/draw_genome_align_linear.pl -ref $od/$ref_tag.fas -qry $od/$qry_tag.fas -ref_cds $od/$ref_tag.cds -blast $od/$qry_tag.$ref_tag.blast.p -mark_cds $mark_cds -scale $scale -len_cut $filt -svg $od/$qry_tag.$ref_tag.svg\n";
}
elsif (!$ref_cds and $qry_cds and $mark_cds) {
	`perl /datapool/bioinfo/dupc/bin/SVG_script/genome_align/draw_genome_align_linear.pl -ref $od/$ref_tag.fas -qry $od/$qry_tag.fas -qry_cds $od/$qry_tag.cds -blast $od/$qry_tag.$ref_tag.blast.p -mark_cds $mark_cds -scale $scale -len_cut $filt -svg $od/$qry_tag.$ref_tag.svg`;
	print LOG "perl /datapool/bioinfo/dupc/bin/SVG_script/genome_align/draw_genome_align_linear.pl -ref $od/$ref_tag.fas -qry $od/$qry_tag.fas -qry_cds $od/$qry_tag.cds -blast $od/$qry_tag.$ref_tag.blast.p -mark_cds $mark_cds -scale $scale -len_cut $filt -svg $od/$qry_tag.$ref_tag.svg\n";
}
elsif ($ref_cds and $qry_cds and !$mark_cds) {
	`perl /datapool/bioinfo/dupc/bin/SVG_script/genome_align/draw_genome_align_linear.pl -ref $od/$ref_tag.fas -qry $od/$qry_tag.fas -ref_cds $od/$ref_tag.cds -qry_cds $od/$qry_tag.cds -blast $od/$qry_tag.$ref_tag.blast.p -scale $scale -len_cut $filt -svg $od/$qry_tag.$ref_tag.svg`;
	print LOG "perl /datapool/bioinfo/dupc/bin/SVG_script/genome_align/draw_genome_align_linear.pl -ref $od/$ref_tag.fas -qry $od/$qry_tag.fas -ref_cds $od/$ref_tag.cds -qry_cds $od/$qry_tag.cds -blast $od/$qry_tag.$ref_tag.blast.p -scale $scale -len_cut $filt -svg $od/$qry_tag.$ref_tag.svg\n";
}
elsif (!$ref_cds and !$qry_cds) {
	`perl /datapool/bioinfo/dupc/bin/SVG_script/genome_align/draw_genome_align_linear.pl -ref $od/$ref_tag.fas -qry $od/$qry_tag.fas -blast $od/$qry_tag.$ref_tag.blast.p -scale $scale -len_cut $filt -svg $od/$qry_tag.$ref_tag.svg`;
	print LOG "perl /datapool/bioinfo/dupc/bin/SVG_script/genome_align/draw_genome_align_linear.pl -ref $od/$ref_tag.fas -qry $od/$qry_tag.fas -blast $od/$qry_tag.$ref_tag.blast.p -scale $scale -len_cut $filt -svg $od/$qry_tag.$ref_tag.svg\n";
}