######Video source: https://ke.biowolf.cn
######生信自学网: https://www.biowolf.cn/
######微信公众号：biowolf_cn
######合作邮箱：biowolf@foxmail.com
######答疑微信: 18520221056

#install.packages("ggplot2")
#install.packages("ggrepel")

#引用包
library(dplyr)
library(ggplot2)
library(ggrepel)


logFCfilter=2               #logFC过滤条件
adj.P.Val.Filter=0.05       #矫正后的p值过滤条件
inputFile="all.txt"         #输入文件
setwd("C:\\biowolf\\Diagnostic\\07.vol")       #设置工作目录

#读取输入文件
rt = read.table(inputFile, header=T, sep="\t", check.names=F)
#定义显著性
Sig=ifelse((rt$adj.P.Val<adj.P.Val.Filter) & (abs(rt$logFC)>logFCfilter), ifelse(rt$logFC>logFCfilter,"Up","Down"), "Not")

#绘制火山图
rt = mutate(rt, Sig=Sig)
p = ggplot(rt, aes(logFC, -log10(adj.P.Val)))+
    geom_point(aes(col=Sig))+
    scale_color_manual(values=c("green", "black","red"))+
    labs(title = " ")+
    theme(plot.title = element_text(size = 16, hjust = 0.5, face = "bold"))
#对于差异显著的基因，标注基因的名称
p1=p+geom_label_repel(data=filter(rt, ((rt$adj.P.Val<adj.P.Val.Filter) & (abs(rt$logFC)>logFCfilter))),
                    box.padding=0.1, point.padding=0.1, min.segment.length=0.05,
                    size=1.8, aes(label=id)) + theme_bw()
#输出火山图
pdf(file="vol.pdf", width=7, height=6.1)
print(p1)
dev.off()


######Video source: https://ke.biowolf.cn
######生信自学网: https://www.biowolf.cn/
######微信公众号：biowolf_cn
######合作邮箱：biowolf@foxmail.com
######答疑微信: 18520221056

