#!/usr/bin/perl
use strict;
use warnings;
use Cwd qw/abs_path/;
use File::Basename;

if (@ARGV<2) {
	print "perl $0 <fasta file> <keyname> <outdir>\n";
	exit;
}

my ($infile, $key, $od)=@ARGV;

$infile = abs_path($infile);
my $basename = basename($infile);

unless ($od) {
	$od = `pwd`;
	chomp $od;
}
$od = abs_path($od);

unless (-e $od) {
	mkdir $od;
}

unless (-e "$od/00.seqdir") {
	mkdir "$od/00.seqdir";
}

`cp -a $infile "$od/00.seqdir/$basename"`;
`perl /datapool/bioinfo/dupc/bin/GACP/GACP-6.0/01.gene-finding/denovo-predict/bin/denovo-predict.pl --glimmer --run multi $od/00.seqdir/$basename --outdir $od `;

unless (-e "$od/Result") {
	mkdir "$od/Result";
}


$key .= "_";
open (CDS, ">$od/Result/$basename.glimmer.cds") || die;
open (PEP, ">$od/Result/$basename.glimmer.pep") || die;

open (IN, "$od/$basename.glimmer.cds") || die;
while (<IN>) {
	if (/^>/) {
		s/>/>$key/;
	}
	print CDS $_;
}
close IN;

open (IN, "$od/$basename.glimmer.pep") || die;
while (<IN>) {
	if (/^>/) {
		s/>/>$key/;
	}
	print PEP $_;
}
close IN;

`cp -a $od/$basename.glimmer.gff $od/Result/`;
`cp -a $od/$basename.glimmer.tab $od/Result/`;

unless (-e "$od/tmp") {
	mkdir "$od/tmp";
}

`mv $od/$basename.* $od/tmp/`;