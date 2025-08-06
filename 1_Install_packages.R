#### ---- 课程依赖的包安装 ---- ####

####1. 选择国内的数据源####
chooseCRANmirror()

####2. 安装需要的R包####
install.packages("openxlsx")
install.packages("dplyr")
install.packages("ggsci")
install.packages("BiocManager")


####3. 加载包，测试是否正确安装####
library(openxlsx)
library(dplyr) #会有提示，注意没显示错误或者ERROR则代表加载正常
library(ggsci)
library(BiocManager)
