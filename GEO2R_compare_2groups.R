##### ---- Written By Wolin at 2020.03.27 ---- #####

# 检查相应的package是否完成安装
if(!require(dplyr)){install.packages("dplyr")}
if(!require(openxlsx)){install.packages("openxlsx")}
if(!require(data.table)){install.packages("data.table")}
if(!require(VennDiagram)){install.packages("VennDiagram")}

library(dplyr)
library(openxlsx)
library(VennDiagram)

#定义两组对比的结果文件名
sam1 <- "./ReadData/Normal_vs_Cirrhosis.txt"
sam2 <- "./ReadData/Normal_vs_HCC.txt"
outVenn <- "HCC_Cirrhosis.png"
outXlsx <- "./Out/GSE14323_HCC_Cirrhosis.xlsx"
fc.cutoff <- 2
fdr.cutoff <- 0.05

#1. 分别读入并进行简单的过滤，实际分析中需要增强R语言技能进行深度的基因过滤
#包括1. 调整logFC阈值；2. 调整adj.p阈值；3. 没有特定意义的基因滤除（例如LOC开头的基因MIR/MT-开头的基因等）
tb.1 <- data.table::fread(sam1) %>% as.data.frame() %>%
  filter(Gene.symbol != "") %>% 
  mutate(Disease = ifelse(logFC > 0, "Up","Down")) %>%
  filter(adj.P.Val <= fdr.cutoff) %>%
  filter(logFC >= log2(fc.cutoff) | logFC <= -log2(fc.cutoff)) %>%
  filter(!grepl("^MT-|^LOC",Gene.symbol)) %>%
  mutate(Label = paste(Gene.symbol,Disease,sep = "_"))

tb.2 <- data.table::fread(sam2) %>% as.data.frame() %>%
  filter(Gene.symbol != "") %>%
  mutate(Disease = ifelse(logFC > 0, "Up","Down")) %>%
  filter(adj.P.Val <= fdr.cutoff) %>%
  filter(logFC >= log2(fc.cutoff) | logFC <= -log2(fc.cutoff)) %>%
  filter(!grepl("^MT-|^LOC",Gene.symbol)) %>%
  mutate(Label = paste(Gene.symbol,Disease,sep = "_"))

#2. 同高或者同低的重复基因的只保留一个
tb.1 <- tb.1 %>% distinct(Label,.keep_all = T)
tb.2 <- tb.2 %>% distinct(Label,.keep_all = T)

#3. 一个基因既高表达又低表达直接剔除
dup1 <- unique(tb.1$Gene.symbol[duplicated(tb.1$Gene.symbol)])
dup2 <- unique(tb.2$Gene.symbol[duplicated(tb.2$Gene.symbol)])

tb.1 <- tb.1 %>% filter(!Gene.symbol %in% dup1)
tb.2 <- tb.2 %>% filter(!Gene.symbol %in% dup2)

#4. 计算两者的overlap并画韦恩图
g1up <- tb.1$Gene.symbol[tb.1$Disease == "Up"]
g1down <- tb.1$Gene.symbol[tb.1$Disease == "Down"]
g2up <- tb.2$Gene.symbol[tb.2$Disease == "Up"]
g2down <- tb.2$Gene.symbol[tb.2$Disease == "Down"]

venn.diagram(x= list(G1up = g1up,G1down = g1down,G2up = g2up,G2down = g2down), 
             filename = outVenn, height = 450, width = 450,resolution =300, 
             imagetype="png", col ="transparent", 
             fill =c("cornflowerblue","green","yellow","darkorchid1"),
             alpha = 0.5, 
             cex = 0.45,fontface = "bold",
             cat.col =c("darkblue", "darkgreen", "orange","darkorchid4"), 
             cat.cex = 0.45, cat.dist = 0.07)

#5. 写出到excel中
bothUp <- intersect(tb.1$Gene.symbol[tb.1$Disease == "Up"],
                    tb.2$Gene.symbol[tb.2$Disease == "Up"])

bothDown <- intersect(tb.1$Gene.symbol[tb.1$Disease == "Down"],
                      tb.2$Gene.symbol[tb.2$Disease == "Down"])

out.data <- list(G1data = tb.1,G2data = tb.2,
                 BothUP = bothUp,BothDown = bothDown)
write.xlsx(out.data,file = outXlsx)
