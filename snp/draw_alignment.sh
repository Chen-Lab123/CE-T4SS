perl ./cut_seq_from_fa_file.pl -f ../seq_trim/DT-Efs5165.contig.1k.link -p 5165.link,1588955,1887858,+ > ./5165.fas
perl ../gc_alignment/trim_cds_list.pl ./gene_prediction/Result/5165.contig.1k.link.glimmer.cds 5165.link 1588955 1887858 0 > ./5165.cds
perl ./cut_seq_from_fa_file.pl -f ../seq_trim/DT-Efs1875.contig.1k.link -p 1875.link,1451547,1748747,+ > ./1875.fas
perl ../gc_alignment/trim_cds_list.pl ./gene_prediction/Result/1875.contig.1k.link.glimmer.cds 1875.link 1451547 1748747 0 > ./1875.cds
formatdb -i ./5165.fas -p F
blastall -i ./1875.fas -d ./5165.fas -o ./1875.5165.blast -e 1e-5 -F F -p blastn
perl ../gc_alignment/blast_parser.pl -nohead ./1875.5165.blast > ./1875.5165.blast.p
perl ../gc_alignment/draw_genome_align_linear.pl -ref ./5165.fas -qry ./1875.fas -ref_cds ./5165.cds -qry_cds ./1875.cds -blast ./1875.5165.blast.p -mark_cds ./mark.cds -scale 300 -len_cut 1000 -svg ./1875.5165.svg
perl ./cut_seq_from_fa_file.pl -f ../seq_trim/DT-Efs5316.contig.1k.link -p 5316.link,1451750,1757110,+ > ./5316.fas
perl ../gc_alignment/trim_cds_list.pl ./gene_prediction/Result/5316.contig.1k.link.glimmer.cds 5316.link 1451750 1757110 0 > ./5316.cds
perl ./cut_seq_from_fa_file.pl -f ../seq_trim/DT-Efs1883.contig.1k.link -p 1883.link,1452276,1750631,+ > ./1883.fas
perl ../gc_alignment/trim_cds_list.pl ./gene_prediction/Result/1883.contig.1k.link.glimmer.cds 1883.link 1452276 1750631 0 > ./1883.cds
formatdb -i ./5316.fas -p F
blastall -i ./1883.fas -d ./5316.fas -o ./1883.5316.blast -e 1e-5 -F F -p blastn
perl ../gc_alignment/blast_parser.pl -nohead ./1883.5316.blast > ./1883.5316.blast.p
perl ../gc_alignment/draw_genome_align_linear.pl -ref ./5316.fas -qry ./1883.fas -ref_cds ./5316.cds -qry_cds ./1883.cds -blast ./1883.5316.blast.p -mark_cds ./mark.cds -scale 300 -len_cut 1000 -svg ./1883.5316.svg
perl ./cut_seq_from_fa_file.pl -f ../seq_trim/DT-Efs5165.contig.1k.link -p 5165.link,1588955,1887858,+ > ./5165.fas
perl ../gc_alignment/trim_cds_list.pl ./gene_prediction/Result/5165.contig.1k.link.glimmer.cds 5165.link 1588955 1887858 0 > ./5165.cds
perl ./cut_seq_from_fa_file.pl -f ../seq_trim/DT-Efs1883.contig.1k.link -p 1883.link,1452276,1750631,+ > ./1883.fas
perl ../gc_alignment/trim_cds_list.pl ./gene_prediction/Result/1883.contig.1k.link.glimmer.cds 1883.link 1452276 1750631 0 > ./1883.cds
formatdb -i ./5165.fas -p F
blastall -i ./1883.fas -d ./5165.fas -o ./1883.5165.blast -e 1e-5 -F F -p blastn
perl ../gc_alignment/blast_parser.pl -nohead ./1883.5165.blast > ./1883.5165.blast.p
perl ../gc_alignment/draw_genome_align_linear.pl -ref ./5165.fas -qry ./1883.fas -ref_cds ./5165.cds -qry_cds ./1883.cds -blast ./1883.5165.blast.p -mark_cds ./mark.cds -scale 300 -len_cut 1000 -svg ./1883.5165.svg
perl ./cut_seq_from_fa_file.pl -f ../seq_trim/DT-Efs5316.contig.1k.link -p 5316.link,1451750,1757110,+ > ./5316.fas
perl ../gc_alignment/trim_cds_list.pl ./gene_prediction/Result/5316.contig.1k.link.glimmer.cds 5316.link 1451750 1757110 0 > ./5316.cds
perl ./cut_seq_from_fa_file.pl -f ../seq_trim/DT-Efs1875.contig.1k.link -p 1875.link,1451547,1748747,+ > ./1875.fas
perl ../gc_alignment/trim_cds_list.pl ./gene_prediction/Result/1875.contig.1k.link.glimmer.cds 1875.link 1451547 1748747 0 > ./1875.cds
formatdb -i ./5316.fas -p F
blastall -i ./1875.fas -d ./5316.fas -o ./1875.5316.blast -e 1e-5 -F F -p blastn
perl ../gc_alignment/blast_parser.pl -nohead ./1875.5316.blast > ./1875.5316.blast.p
perl ../gc_alignment/draw_genome_align_linear.pl -ref ./5316.fas -qry ./1875.fas -ref_cds ./5316.cds -qry_cds ./1875.cds -blast ./1875.5316.blast.p -mark_cds ./mark.cds -scale 300 -len_cut 1000 -svg ./1875.5316.svg
