#!/usr/bin/perl

BEGIN {
	unshift(@INC,"/datapool/bioinfo/dupc/bin/SVG_script/");
}

use Svg::File;
use Svg::Graphics;

if (@ARGV!=6) {
	print "perl $0 <start> <end> <scale> <list1> <list2> <result svg file>\n";
	exit;
}
my ($str, $end, $scale, $list1, $list2, $svg_file)=@ARGV;

my $svg = Svg::File->new("$svg_file",\*OUT);
my $g = $svg->beginGraphics();
$svg->open(encoding, "iso-8859-1");
$svg->open(silent);
$g->b(svg,viewBox,"0,0,1200,800",width,1200,height,800);
$g->setFontSize(10);
$g->setFontColor(black);
$g->setFontFamily("Helvetica-Bold");

my ($x0, $y0)=(100,100);


drawXRuler($x0,$y0,1,$end-$str+1,$scale,10000,10000,"+","black");

open (IN, $list1) || die;
while (<IN>) {
	my $pos=(split /\s+/, $_)[1];
	$g->d("line","x1",$x0+($pos-$str)/$scale,"y1",$y0-30,"x2",$x0+($pos-$str)/$scale,"y2",$y0-20,style,"stroke:black;stroke-width:1");
}
close IN;

open (IN, $list2) || die;
while (<IN>) {
	my $pos=(split /\s+/, $_)[1];
	$g->d("line","x1",$x0+($pos-$str)/$scale,"y1",$y0+20,"x2",$x0+($pos-$str)/$scale,"y2",$y0+30,style,"stroke:black;stroke-width:1");
}
close IN;

#########################################################
$g->e();
$svg->close($g);

sub drawXRuler{
	my ($x,$y,$start,$end,$scale,$min_scale,$label_position,$direction,$color)=@_;

	#���������
	my $line_length=8;
	my $stroke_width=2;
	$g->d("line","x1",$x,"y1",$y,"x2",$x+($end-$start+1)/$scale,"y2",$y,style,"stroke:$color;stroke-width:$stroke_width");
	$g->d("line","x1",$x,"y1",$y,"x2",$x,"y2",$y-$line_length,style,"stroke:$color;stroke-width:$stroke_width");
	$g->d("line","x1",$x+($end-$start+1)/$scale,"y1",$y,"x2",$x+($end-$start+1)/$scale,"y2",$y-$line_length,style,"stroke:$color;stroke-width:$stroke_width");

	#�ж��Ƿ���Ҫ��ת
	my $reverse_flag;
	if ($direction eq "+") {
		$reverse_flag=1;
	}else {
		$x+=($end-$start+1)/$scale;
		$reverse_flag=-1;
	}

	for (my $i=$start; $i<$end; $i+=$min_scale) {
		if ($i==$start or $i%$label_position == 0) {
			$line_length=8;
			$stroke_width=2;
			$g->d("line","x1",$x+$reverse_flag*($i-$start)/$scale,"y1",$y-$line_length,"x2",$x+$reverse_flag*($i-$start)/$scale,"y2",$y,style,"stroke:$color;stroke-width:$stroke_width");

			if ($i==0) {
				$g->d(txtCM,$i+1,xval,$x+$reverse_flag*($i-$start)/$scale,yval,$y-$line_length-10);
			}
			elsif ($i==$start and $start%abs($min_scale)!=0) {
				$g->d(txtCM,$start,xval,$x+$reverse_flag*($i-$start)/$scale,yval,$y-$line_length-10);
				$i=int($start/abs($min_scale))*$min_scale;
			}
			else {
				my $value_k=($i/1000)."k";
				$g->d(txtCM,$value_k,xval,$x+$reverse_flag*($i-$start)/$scale,yval,$y-$line_length-10);
			}
		}
		else {
			$line_length=4;
			$stroke_width=1;
			$g->b("line","x1",$x+$reverse_flag*($i-$start)/$scale,"y1",$y-$line_length,"x2",$x+$reverse_flag*($i-$start)/$scale,"y2",$y,style,"stroke:$color;stroke-width:$stroke_width");
			$g->e();
		}
	}

	if ($end%$label_position != 0) {
		$line_length=8;
		$stroke_width=2;
		$g->b("line","x1",$x+$reverse_flag*($end-$start)/$scale,"y1",$y-$line_length,"x2",$x+$reverse_flag*($end-$start)/$scale,"y2",$y,style,"stroke:$color;stroke-width:$stroke_width");
		$g->e();
		if ($end%$min_scale != 0) {
			$g->d(txtCM,$end,xval,$x+$reverse_flag*($end-$start)/$scale,yval,$y-$line_length-10);
		} else {
			my $value_k=($end/1000)."k";
			$g->d(txtCM,$value_k,xval,$x+$reverse_flag*($end-$start)/$scale,yval,$y-$line_length-10);
		}
	}
}
