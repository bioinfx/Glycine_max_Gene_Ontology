# Feng Lei  2020-08-11
# In file "3.1_Glycine_max_JGI_Wm82.a4.v1.cleaned.gaf.gz", some lines contain words "NOT", "contributes_to", or "colocalizes_with". We must remove these words, or they will disrupt downstream analysis
# zcat 3.1_Glycine_max_JGI_Wm82.a4.v1.cleaned.gaf.gz | awk 'BEGIN{OFS="\t"; print "GID\tGO\tEVIDENCE"}{if(NR>2){gsub("\.Wm82\.a4\.v1","",$3);print $3,$4,$6}}' > Gmax_goev_GOMAP_for_makeOrgPackage.txt
#zcat 3.1_Glycine_max_JGI_Wm82.a4.v1.cleaned.gaf.gz | \
#    awk '{gsub("NOT","",$0);gsub("contributes_to","",$0);gsub("colocalizes_with","",$0);print}' | \
#    awk '{gsub("|","",$0);print}' | \   ### "|" 竖线不能这么写，要加两个转义符
#    awk 'BEGIN{OFS="\t"; print "GID\tGO\tONTOLOGY\tEVIDENCE"}{if(NR>2){gsub("\.Wm82\.a4\.v1","",$3);print $3,$4,$7,$6}}'    > GMA_GO_TERM.txt

# zcat 3.1_Glycine_max_JGI_Wm82.a4.v1.cleaned.gaf.gz | awk '{gsub("NOT","",$0);gsub("contributes_to","",$0);gsub("colocalizes_with","",$0);print}' |  awk '{gsub("|","",$0);print}' | awk 'BEGIN{OFS="\t"; print "GID\tGO\tONTOLOGY\tEVIDENCE"}{if(NR>2){gsub("\.Wm82\.a4\.v1","",$3);print $3,$4,$7,$6}}' > GMA_GO_TERM.txt
zcat 3.1_Glycine_max_JGI_Wm82.a4.v1.cleaned.gaf.gz | \
    awk '{gsub("NOT","",$0);gsub("contributes_to","",$0);gsub("colocalizes_with","",$0);print}' |  \
    awk '{gsub("\\|","",$0);print}' | \
    awk 'BEGIN{OFS="\t"; print "GID\tGO\tONTOLOGY\tEVIDENCE"}{if(NR>2){gsub("\.Wm82\.a4\.v1","",$3);print $3,$4,$7,$6}}' > GMA_GO_TERM.txt
