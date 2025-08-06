####关注微信公众号生信狂人团队
###遇到代码报错等不懂的问题可以添加微信scikuangren进行答疑
###作者邮箱：sxkrteam@shengxinkuangren.com

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("remotes")

BiocManager::install("BioinformaticsFMRP/TCGAbiolinksGUI.data")

BiocManager::install("BioinformaticsFMRP/TCGAbiolinks")

BiocManager::install("SummarizedExperiment")

library(SummarizedExperiment)
library(TCGAbiolinks)

setwd("C:\\Users\\77632\\Desktop\\latestTCGA")

query <- GDCquery(project = "TCGA-CHOL",
                  data.category = "Transcriptome Profiling",
                  data.type = "Gene Expression Quantification",   
                  workflow.type = "STAR - Counts", 
                  legacy = FALSE)

GDCdownload(query = query)
mydata=GDCprepare(query = query)
mydata2=as.data.frame(rowRanges(mydata))
geneexp <- assay(mydata,i = "unstranded")#tpm_unstrand fpkm_unstrand
geneexp=as.data.frame(geneexp)
geneexp1=cbind(gene_type=mydata2$gene_type,gene_name=mydata2$gene_name,geneexp)
mRNA=geneexp1[geneexp1$gene_type=="protein_coding",]
mRNA=mRNA[,-1]
write.table(mRNA,"mRNA.txt",quote = F,sep = "\t",row.names = F)
lncRNA=geneexp1[geneexp1$gene_type=="lncRNA",]
lncRNA=lncRNA[,-1]
write.table(lncRNA,"lncRNA.txt",quote = F,sep = "\t",row.names = F)
####关注微信公众号生信狂人团队
###遇到代码报错等不懂的问题可以添加微信scikuangren进行答疑
###作者邮箱：sxkrteam@shengxinkuangren.com
