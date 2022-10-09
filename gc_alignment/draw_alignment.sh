perl ./cut_seq_from_fa_file.pl -f ./NC_004668.gbk.seq -p NC_004668,1753724,1854644,+ > ./NC_004668.fas
perl ./trim_cds_list.pl ./NC_004668.gbk.cds NC_004668 1753724 1854644 0 > ./NC_004668.cds
perl ./cut_seq_from_fa_file.pl -f ./NC_018221.gbk.seq -p NC_018221,1604982,1640759,+ > ./NC_018221.fas
perl ./trim_cds_list.pl ./NC_018221.gbk.cds NC_018221 1604982 1640759 0 > ./NC_018221.cds
formatdb -i ./NC_004668.fas -p F
blastall -i ./NC_018221.fas -d ./NC_004668.fas -o ./NC_018221.NC_004668.blast -e 1e-5 -F F -p blastn
perl ./blast_parser.pl -nohead ./NC_018221.NC_004668.blast > ./NC_018221.NC_004668.blast.p
perl ./draw_genome_align_linear.pl -ref ./NC_004668.fas -qry ./NC_018221.fas -ref_cds ./NC_004668.cds -qry_cds ./NC_018221.cds -blast ./NC_018221.NC_004668.blast.p -mark_cds ./mark.cds -scale 100 -len_cut 1000 -svg ./NC_018221.NC_004668.svg
perl ./cut_seq_from_fa_file.pl -f ./NC_004668.gbk.seq -p NC_004668,1753724,1854644,+ > ./NC_004668.fas
perl ./trim_cds_list.pl ./NC_004668.gbk.cds NC_004668 1753724 1854644 0 > ./NC_004668.cds
perl ./cut_seq_from_fa_file.pl -f ./NC_017316.gbk.seq -p NC_017316,1578274,1642247,+ > ./NC_017316.fas
perl ./trim_cds_list.pl /NC_017316.gbk.cds NC_017316 1578274 1642247 0 > ./NC_017316.cds
formatdb -i ./NC_004668.fas -p F
blastall -i ./NC_017316.fas -d ./NC_004668.fas -o ./NC_017316.NC_004668.blast -e 1e-5 -F F -p blastn
perl ./blast_parser.pl -nohead ./NC_017316.NC_004668.blast > ./NC_017316.NC_004668.blast.p
perl ./draw_genome_align_linear.pl -ref ./NC_004668.fas -qry ./NC_017316.fas -ref_cds ./NC_004668.cds -qry_cds ./NC_017316.cds -blast ./NC_017316.NC_004668.blast.p -mark_cds ./mark.cds -scale 100 -len_cut 1000 -svg ./NC_017316.NC_004668.svg
