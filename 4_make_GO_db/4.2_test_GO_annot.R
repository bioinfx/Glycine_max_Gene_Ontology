library(org.Gmax.eg.db)
org <- org.Gmax.eg.db

## A demo for using the database
# BiocManager::install("Rgraphviz")
# BiocManager::install("topGO")
library(topGO)
library(clusterProfiler)
geneTable = read.table("./gene_table.txt", head=T, sep="\t")
#geneTable = geneTable[!apply(geneTable == "", 1, all),]
geneList=geneTable[,5]

geneList=geneList[!duplicated(geneList)]
# Biology process
b=geneList

# biological progress
ego_up <-enrichGO(
                  gene = b, 
                  OrgDb = org, 
                  keyType = "GID", 
                  ont = "BP"
                  )
pdf("test_GO_BP_barplot.pdf", height=10, width=15)
barplot(ego_up, drop=TRUE, showCategory=12)
dev.off()
pdf("test_GO_BP_dotPlot.pdf", height=10, width=15)
dotplot(ego_up)
dev.off()
#pdf("up_GO_BP_tree.pdf")
#plotGOgraph(ego_up)
#dev.off()
write.csv(as.data.frame( ego_up@result ), file="test_GO_BP.csv")


# molecular function
ego_down <-enrichGO(
                    gene = b,
                    OrgDb = org,
                    keyType = "GID",
                    ont = "MF"
                    )
pdf("test_GO_MF_barplot.pdf", height=10, width=15)
barplot(ego_down, drop=TRUE, showCategory=12)
dev.off()
pdf("test_GO_MF_dotPlot.pdf", height=10, width=15)
dotplot(ego_down)
dev.off()
#pdf("test_GO_MF_tree.pdf")
#plotGOgraph(ego_down)
#dev.off()
write.csv(as.data.frame( ego_down@result), file="test_GO_MF.csv")

# cellular component
ego_down <-enrichGO(
                    gene = b,
                    OrgDb = org,
                    keyType = "GID",
                    ont = "CC"
                    )
pdf("test_GO_CC_barplot.pdf", height=10, width=15)
barplot(ego_down, drop=TRUE, showCategory=12)
dev.off()
pdf("test_GO_CC_dotPlot.pdf", height=10, width=15)
dotplot(ego_down)
dev.off()
#pdf("test_GO_CC_tree.pdf")
#plotGOgraph(ego_down)
#dev.off()
write.csv(as.data.frame( ego_down@result), file="test_GO_CC.csv")


