######Video source: https://ke.biowolf.cn
######生信自学网: https://www.biowolf.cn/
######微信公众号：biowolf_cn
######合作邮箱：biowolf@foxmail.com
######答疑微信: 18520221056

#install.packages("venn")


library(venn)                   #引用包
outFile="interGenes.txt"        #输出文件名称
setwd("C:\\biowolf\\Diagnostic\\14.venn")    #设置工作目录
geneList=list()

#读取lasso回归的结果文件
rt=read.table("LASSO.gene.txt", header=F, sep="\t", check.names=F)
geneNames=as.vector(rt[,1])       #提取基因名称
uniqGene=unique(geneNames)        #基因取unique
geneList[["LASSO"]]=uniqGene

#读取SVM的结果文件
rt=read.table("SVM-RFE.gene.txt", header=F, sep="\t", check.names=F)
geneNames=as.vector(rt[,1])       #提取基因名称
uniqGene=unique(geneNames)        #基因取unique
geneList[["SVM-RFE"]]=uniqGene

#绘制venn图
mycol=c("blue2","red2")
pdf(file="venn.pdf", width=5, height=5)
venn(geneList,col=mycol[1:length(geneList)],zcolor=mycol[1:length(geneList)],box=F,ilabels=F)
dev.off()

#保存交集基因
intersectGenes=Reduce(intersect,geneList)
write.table(file=outFile, intersectGenes, sep="\t", quote=F, col.names=F, row.names=F)


######Video source: https://ke.biowolf.cn
######生信自学网: https://www.biowolf.cn/
######微信公众号：biowolf_cn
######合作邮箱：biowolf@foxmail.com
######答疑微信: 18520221056

