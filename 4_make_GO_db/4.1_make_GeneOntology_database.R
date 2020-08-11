
## Makes an organism package for Glycine max data.frames:

library(RSQLite)
library(AnnotationForge)

## Now prepare some data.frames
fGO <- read.table("../3_final-result/GMA_GO_TERM.txt", sep="\t", head=TRUE)

## remove duplication in the table
go_df <- fGO[!duplicated(fGO),]

## only tree coloums are needed: GID, GO, EVIDENCE
go_df <- go_df[,c(1,2,4)]

## Making Organism packages 
makeOrgPackage(go=go_df,
    version = "0.0.1",
    maintainer = "FENG Lei <fengleiluck@gmail.com>",
    author = "FENG Lei <fengleiluck@gmail.com>",
    outputDir = "./",
    tax_id = "3847",
    genus = "Glycine",
    species = "max",
    goTable = "go"
    )

## then you can call install.packages based on the return value
install.packages("./org.Gmax.eg.db", repos = NULL, type="source")
library(org.Gmax.eg.db)
org <- org.Gmax.eg.db

## A demo for using the database
# BiocManager::install("Rgraphviz")
# BiocManager::install("topGO")
library()
geneTable = read.table("./Gmax_ABA_exp.xls", head=T)
geneList=geneTable[,5]
geneList=geneList[!duplicated(geneList)]
# Biology process
ego_up <-enrichGO(gene = geneList, OrgDb = org, keyType = "GID", ont = "BP")
pdf("up_GO_BP_barplot.pdf", height=10, width=15)
barplot(ego_up, drop=TRUE, showCategory=12)
dev.off()
pdf("up_GO_BP_dotPlot.pdf", height=10, width=15)
dotplot(ego_up)
dev.off()
pdf("up_GO_BP_tree.pdf")
plotGOgraph(ego_up)
dev.off()
write.csv(as.data.frame( ego_up@result ), file="up_GO_BP.csv")
