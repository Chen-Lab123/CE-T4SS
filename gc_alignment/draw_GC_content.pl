#!/usr/bin/perl

BEGIN {
	unshift(@INC,"/datapool/bioinfo/dupc/bin/SVG_script/");
}

use Svg::File;
use Svg::Graphics;


if (@ARGV!=6) {
	print "perl $0 <genome sequence> <start position> <end position> <window> <x scale> <result file>\n";
	exit;
}

my ($seq_file,$start,$end,$window,$x_scale,$svg_file) = @ARGV;
my ($x0,$y0)=(20,300);
my $step=0.5*$window;
my $y_scale=0.5;

my $svg = Svg::File->new("$svg_file",\*OUT);

my $g = $svg->beginGraphics();
$svg->open(encoding, "iso-8859-1");
$svg->open(silent);

$g->b(svg,viewBox,"0,0,1200,800",width,1200,height,800);
$g->setFontSize(10);
$g->setFontColor(black);
$g->setFontFamily("Helvetica-Bold");


#########################################
#get genome sequence
my ($AN,$gen_seq,$seq);
open (G,$seq_file) || die;
while (<G>) {
	chomp;
	if (/>(.+)/) {
		$AN=$1;
	}
	else {
		s/\W//g;
		$gen_seq.=uc($_);
	}
}
close G;

#print length($gen_seq);
#print "\n";

my $seq=substr($gen_seq,$start-1,$end-$start+1);
#print $seq."\n";
my $len=length($seq);
#print $len;
my $mark_GC=sprintf "%.2f",(countNT("G",$gen_seq)+countNT("C",$gen_seq))/length($gen_seq)*100;
$start = $start==1?0:$start;

###################################################
#��������
##################################################
#x axis
$g->d(line,x1,$x0,y1,$y0,x2,$x0+$len/$x_scale,y2,$y0,style,"stroke:black;stroke-width:2");
$g->d(line,x1,$x0,y1,$y0-$mark_GC/$y_scale,x2,$x0+$len/$x_scale,y2,$y0-$mark_GC/$y_scale,style,"stroke:black;stroke-width:2");
$g->d(txtRM,$mark_GC,xval,$x0,yval,$y0-$mark_GC/$y_scale);

for (my $i=0; $i<$len; $i+=10000) {
	$g->d(line,x1,$x0+$i/$x_scale,y1,$y0,x2,$x0+$i/$x_scale,y2,$y0-3,style,"stroke:black;stroke-width:2");
	my $mark=($i+$start)/1000;
	$mark.="k";
	$g->d(txtCM,$mark,xval,$x0+$i/$x_scale,yval,$y0+10);
}
$g->d(line,x1,$x0+$len/$x_scale,y1,$y0,x2,$x0+$len/$x_scale,y2,$y0-3,style,"stroke:black;stroke-width:2");
my $x_end=($start+$len-1)/1000;
$g->d(txtCM,$x_end."k",xval,$x0+$len/$x_scale,yval,$y0+10);

#y axis
$g->d(line,x1,$x0,y1,$y0,x2,$x0,y2,$y0-200,style,"stroke:black;stroke-width:2");
for (my $i=0; $i<=100; $i+=25) {
	$g->d(line,x1,$x0,y1,$y0-$i/$y_scale,x2,$x0+5,y2,$y0-$i/$y_scale,style,"stroke:black;stroke-width:2");
	$g->d(txtRM,$i,xval,$x0-10,yval,$y0-$i/$y_scale);
}
$g->d(txtLM,$AN,xval,$x0-10,yval,$y0-100/$y_scale-20);

###########################################
#count GC by step
my ($cur_x,$cur_y,$pre_x,$pre_y)=(0,0,0,0);
for (my $i=0; $i<length($seq)-0.5*$step; $i+=$step) {
	my $seq_window=substr($seq,$i,$window);

	my $GC=(countNT("G",$seq_window)+countNT("C",$seq_window))/$window*100;
	$cur_x=$x0+$i/$x_scale;
	$cur_y=$y0-$GC/$y_scale;
	if ($pre_x==0 and $pre_y==0) {
		($pre_x,$pre_y)=($cur_x,$cur_y);
	}
	else {
		$g->d(line,x1,$pre_x,y1,$pre_y,x2,$cur_x,y2,$cur_y,style,"stroke:green;stroke-width:2");
		($pre_x,$pre_y)=($cur_x,$cur_y);
	}
}


#########################################################
#�������
$g->e();

$svg->close($g);

###################################
#����������ĳ�����Ậ��
#Usage: contNT($seq,$nt) ���������У����
###################################
sub countNT {
	my ($nt,$seq)=@_;
	return $seq=~s/$nt/$nt/gi;
}
