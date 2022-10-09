blastall -i ./NC_018221.gbk.cds -d ./NC_004668.gbk.cds -o ./D32.V583.cds.blast -e 1e-5 -F F -p blastn
perl ./blast_parser.pl -nohead ./D32.V583.cds.blast > ./D32.V583.cds.blast.p
perl ./draw_genome_align_in_region.pl -ref ./NC_004668.gbk.seq -ref_pos NC_004668,1753724,1854644,+ -ref_cds ./NC_004668.gbk.cds -qry ./NC_018221.gbk.seq -qry_pos NC_018221,1604982,1640759,+ -qry_cds ./NC_018221.gbk.cds -mark_cds ./mark.cds -scale 100 -o ./
perl ./draw_GC_content.pl ./NC_004668.gbk.seq 1753000 1855000 2000 100 ./V583_1753k_1855k.gc.svg
blastall -i ./NC_017316.gbk.cds -d ./NC_004668.gbk.cds -o ./OG1RF.V583.cds.blast -e 1e-5 -F F -p blastn
perl ./blast_parser.pl -nohead ./OG1RF.V583.cds.blast > ./OG1RF.V583.cds.blast.p
perl ./draw_genome_align_in_region.pl -ref ./NC_004668.gbk.seq -ref_pos NC_004668,1753724,1854644,+ -ref_cds ./NC_004668.gbk.cds -qry ./NC_017316.gbk.seq -qry_pos NC_017316,1578274,1642247,+ -qry_cds ./NC_017316.gbk.cds -mark_cds ./mark.cds -scale 100 -o ./
