sh ref_blast.sh
perl ./cut_seq_from_fa_file.pl -f ./NC_004668.gbk.seq -p NC_004668,1600000,1920000 > V583.1600k-1620k.fa
sh ./V583.1600k-1620k_blast.sh
perl ./draw_genome_align_in_region.pl -ref ../seq_trim/DT-Efs5165.contig.1k.link -ref_cds ./gene_prediction/Result/5165.contig.1k.link.glimmer.cds -ref_pos -ref_pos 5165.link,1588955,1887858,+ -qry ../seq_trim/DT-Efs1875.contig.1k.link -qry_pos 1875.link,1451547,1748747,+ -qry_cds ./gene_prediction/Result/1875.contig.1k.link.glimmer.cds -mark_cds ./mark.cds -scale 300 -o ./
perl ./draw_genome_align_in_region.pl -ref ../seq_trim/DT-Efs5316.contig.1k.link -ref_cds ./gene_prediction/Result/5316.contig.1k.link.glimmer.cds -ref_pos -ref_pos 5316.link,1451750,1757110,+ -qry ../seq_trim/DT-Efs1883.contig.1k.link -qry_pos 1883.link,1452276,1750631,+ -qry_cds ./gene_prediction/Result/1883.contig.1k.link.glimmer.cds -mark_cds ./mark.cds -scale 300 -o ./
perl ./draw_genome_align_in_region.pl -ref ../seq_trim/DT-Efs5165.contig.1k.link -ref_cds ./gene_prediction/Result/5165.contig.1k.link.glimmer.cds -ref_pos -ref_pos 5165.link,1588955,1887858,+ -qry ../seq_trim/DT-Efs1883.contig.1k.link -qry_pos 1883.link,1452276,1750631,+ -qry_cds ./gene_prediction/Result/1883.contig.1k.link.glimmer.cds -mark_cds ./mark.cds -scale 300 -o ./
perl ./draw_genome_align_in_region.pl -ref ../seq_trim/DT-Efs5316.contig.1k.link -ref_cds ./gene_prediction/Result/5316.contig.1k.link.glimmer.cds -ref_pos -ref_pos 5316.link,1451750,1757110,+ -qry ../seq_trim/DT-Efs1875.contig.1k.link -qry_pos 1875.link,1451547,1748747,+ -qry_cds ./gene_prediction/Result/1875.contig.1k.link.glimmer.cds -mark_cds ./mark.cds -scale 300 -o ./
awk '$1>=1452276 && $1<=1750631' ../conjugation2/mummer/5165.1883.nucmer.snp.out.filter > ./5165.1883.nucmer.snp.out.filter.filt
awk '$1>=1452276 && $1<=1750631' ../conjugation2/mummer/5316.1883.nucmer.snp.out.filter > ./5316.1883.nucmer.snp.out.filter.filt
awk '$1>=1451547 && $1<=1748747' ../conjugation2/mummer/5316.1875.nucmer.snp.out.filter > ./5316.1875.nucmer.snp.out.filter.filt
awk '$1>=1451547 && $1<=1748747' ../conjugation2/mummer/5165.1875.nucmer.snp.out.filter > ./5165.1875.nucmer.snp.out.filter.filt
perl ./draw_snp.pl 1451547 1748747 300 ./5165.1875.nucmer.snp.out.filter.filt ./5316.1875.nucmer.snp.out.filter.filt 1875.snp.pos.svg
perl ./draw_snp.pl 1452276 1750631 300 ./5165.1883.nucmer.snp.out.filter.filt ./5316.1883.nucmer.snp.out.filter.filt 1883.snp.pos.svg
