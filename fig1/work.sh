./build_blast_atlas.sh -i ./NC_004668.gbk -p ./V583/
sh ./ln_data.sh
nohup /datapool/bioinfo/dupc/bin/soft/cgview_comparison_tool/scripts/build_blast_atlas.sh -p ./V583/ > ./V583.log
./redraw_maps.sh -p ./V583/ -f svg -m 15000m
