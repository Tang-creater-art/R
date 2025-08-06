#### --- R learn code ####
## ----- Created By WoLin @2019.03 --- ##


#### 教程主要内容 ####
#1. R语言基础介绍
#2. R语言包管理
#3. 数据类型
#4. 基本数据结构
#5. 数据读写与存储
#6. R函数
#7. 练习题

####  1. R语言基础介绍(见PPT内容) ####
####  2. R语言包及帮助系统 ####
# R包是R语言最强大的武器，因其多种多样的功能包，帮助R语言便捷、高效的实现多种多样的功能，当前R支持的功能包已超过17000个。

#### 2.1 安装及加载 ####
#常见的R包安装有两种路径：
#1. 通过CRAN源
#先运行该命令选择一个合适的资源，随便选择一个国内的；不运行该命令也可以，安装时会给出提示
chooseCRANmirror()
install.packages("ggplot2") #必须包含双引号

#2. 通过bioconductor
BiocManager::install("limma")
##也可以先选定bioconductor的数据源
chooseBioCmirror()

#3. 其他安装路径：github
library(devtools)
install_github("packagePath")

#加载包
library(limma)
#没有报错信息即加载成功

#### 2.2 管理及使用 ####
#获取已经安装的包
library()

#获取当前环境中加载的包
search()

#加载使用
library(dplyr)
require(dplyr) #一般在程序中用require，遇到加载错误会返回信息，但不会终止程序

#查看包的帮助信息
help(package="dplyr")

#卸载包
remove.packages("dplyr")

#### 2.3 R语言帮助系统 ####
#查看包的帮助信息
help(package = "dplyr")
#查看函数的帮助信息
?library
?install.packages
?example
example("plot")

#### 3. 数据类型 ####
# R语言最常见数据类型包括：数值、字符串、逻辑

#### 3.1 数值 ####
#赋值: <-, ->, =
a <- 150
3e-2 -> b
c = -10
a
b
print(c)

#+,-,*,/,%%,%/%,^,log分别代表加减乘除，取余数，商，乘方，对数
10 %% 3 #10除以3的余数
10 %/% 3 #10除以3的商
2^3 # 2的3次方
log(10) # 10的对数
log10(10) # 以10为底的对数
log2(10) # 以2为底的对数

#### 3.2 字符串 ####
# assign a string "Professor" to variable title
title <- "Professor"
title
# assign a string "Hello World" to variable hello
hello <- "Hello World"
hello

#字符串长度
nchar(hello)

#大小写转换
toupper(hello)
tolower(hello)

#字符串连接
paste(title,hello)

#### 3.3 逻辑 ####
#直接赋值
is_female <- TRUE
is_female

is_male <- FALSE
is_male

#判断赋值
age <- 20
is_adult <- age > 18
is_adult

#### 3.4 常见操作函数 ####
#查看变量类型
class(is_female)

#检查是否为某种类型
is.numeric(hello)
is.numeric(a)
is.character(hello)

#数据类型转换
as.numeric(is_female)
as.numeric(is_male)
as.character(b)

#### 4. 数据结构 ####
# R语言常用数据结构包括：向量，因子，矩阵，数据框，列表

#### 4.1 向量vector ####
#数值型向量
#这里的函数c，用于生成一个基本的向量类型
friend_ages <- c(21, 27, 26, 32)
friend_ages

#字符型向量
friend_names <- c("Mina", "Ella", "Anna", "Cora")
friend_names

#带名字的向量
names(friend_ages) <- c("Mina", "Ella", "Anna", "Carla")
friend_ages

names(friend_ages) <- friend_names
friend_ages

friend_ages <- c(Mina=21, Ella=27, Anna=26, Cora=32)
friend_ages

#向量长度
length(friend_ages)

#获取向量中的某个元素
friend_ages[2]
friend_ages["Ella"]
friend_ages[c(1,3)]
friend_ages[c("Mina", "Anna")]

#去除某个元素
friend_ages[-4]

#改变某个向量
friend_ages[2]
friend_ages[2] <- 20
friend_ages[2]

#通过逻辑判断的方式获取元素
my_friends <- c("Mina", "Ella", "Anna", "Cora")
my_friends
has_child <- c("TRUE", "TRUE", "FALSE", "TRUE")
has_child
my_friends[has_child == "TRUE"]
my_friends[which(has_child == "TRUE")]

#其他生成向量的函数
#1. rep：重复生成函数
rep(2,3) #重复生成2，总共3次
# ?rep #查看rep的帮助系统，获取rep命令可以支持的参数，注意?后面的函数不带括号
rep(2,times = 3)
rep(c(1:2),3) #重复生成的数据既可以是单变量又可以是向量

#2. seq: 序列生成函数
?seq
seq(1,10,by = 2)
seq(1,10,length.out = 5)

#3. 简单的序列生成（:）
1:10
10:1
10:-1

#### 4.2 因子向量factor ####
# 使用factor函数生成因子
friend_groups <- factor(c(1,2,1,2))
friend_groups

# 因子在R中会被存储成数值，但是此处因子数值不等同于数值型
friend_genders <- factor(c("Male","Female","Male","Female"))
as.numeric(friend_genders)

friend_groups <- factor(c(0,1,0,1))
friend_groups
as.numeric(friend_groups)

# 因子类型中的数据叫level，可通过levels获取
levels(friend_groups)
levels(friend_genders)

# 变更因中的level
levels(friend_groups) <- c("best_friend", "not_best_friend")
friend_groups

# 变更level的排序
levels(friend_groups) <- c("not_best_friend", "best_friend")
friend_groups

# 创建有排序的因子
friend_groups <- factor(c("not_best_friend", "best_friend",
                          "not_best_friend", "best_friend"), 
                        levels=c("not_best_friend", "best_friend"))
friend_groups
factor(friend_groups,levels = c("not_best_friend", "best_friend"),ordered = T)

# 统计不同因子数量（同样适用于普通向量）
summary(friend_groups)
table(friend_groups)

#### 4.3 矩阵matrix ####
col1 <- c(1,3,8,9)
col2 <- c(2,18,27,10)
col3 <- c(8,37,267,19)
#生成矩阵
#矩阵只能是多个数值型向量的集合
my_matrix <- cbind(col1, col2, col3)
my_matrix

#生成矩阵
exam_matrix <- matrix(rnorm(20),nrow = 4)
exam_matrix

#矩阵增加行名
rownames(my_matrix) <- c("row1", "row2", "row3", "row4")
my_matrix

#获取列名
colnames(my_friends)

#矩阵转置
t(my_matrix)

#矩阵的行列维度
ncol(my_matrix)
nrow(my_matrix)
dim(my_matrix)

#获取矩阵中对应行列的数据
my_matrix[1,3]
my_matrix["row1", "col3"]
my_matrix[1,]
my_matrix[,3]

#带逻辑判断
my_matrix[col3 > 20,]

#矩阵相关计算
my_matrix * 3
log10(my_matrix)

#行列的总和
rowSums(my_matrix)
colSums(my_matrix)

#另一种方式计算行列之和：apply函数及变体（强大的矩阵操作行数）
#计算每行的均值，中位值，和
apply(my_matrix, 1, mean)
apply(my_matrix, 1, median)
apply(my_matrix, 1, sum)
apply(my_matrix, 1, function(x)sum(x))

#计算每列的均值
apply(my_matrix, 2, mean)

#总结生成矩阵的常见方式
#matrix直接生成,rbind,cbind,as.matrix

#### 4.4 数据框data.frame ####
# 用data.frame函数生成
# 数据框每列数据类型需一致，但不同的列数据类型可以不同（区别于矩阵）
# 矩阵 ≈ 数值型data.frame
friends <- data.frame(name=friend_names, age=friend_ages, child=has_child)
friends
is.data.frame(friends)

#从矩阵转换
class(my_matrix)
my_data <- as.data.frame(my_matrix)
class(my_data)
is.data.frame(my_matrix)

#查看数据的前后几行
head(friends)
tail(friends)

# 数据库信息内容概览
str(friends)
summary(friends) # summary 会根据每一列不同的类型统计不同的结果

# 获取数据框中的数据
rownames(friends)
friends["Mina",]
friends$age
friends[friends$age > 26,]
friends[friends$child == "TRUE",]

# 如果带有NA值需要额外注意
friends2 <- friends
friends2$age[2] <- NA
friends2$age > 26
friends2[which(friends2$age > 26),]

# 同样可以用subset获取数据框中的数据
subset(friends, age > 26)
subset(friends2, age > 26)
subset(friends, select=age)

# 给数据框增加列
friends$married <- c("YES", "YES", "NO", "YES")
friends

# 用cbind来增加列
cbind(friends, salary=c(4000, 8000, 2000, 6000))

# 用cbind来增加列
cbind(friends, salary=c(4000, 8000, 2000, 6000))

#### 4.5 列表list ####
#使用list函数生成列表
my_list <- list(mother="Sophia", father="John", sisters=c("Anna", "Emma"), sister_age=c(5, 10))
my_list

# 查看列表中的名称
names(my_list)

# 列表中总共的元素数量
length(my_list)

#获取元素中的数据
my_list$mother
my_list[["mother"]]
my_list[[1]]
my_list[[3]]
my_list[[3]][2]

# 列表判断
is.list(friends)
friends[[1]]

#### 4.6 其他常用函数 ####
#自带数据
data()
data("iris")
#查看数据基本信息
class(iris)
str(iris)
summary(iris)

#排序
friend_ages
sort(friend_ages)
sort(friend_ages,decreasing = T)
order(friend_ages)
order(friend_ages,decreasing = T)

#常用统计
quantile(iris$Sepal.Length)
range(iris$Sepal.Length)

#向量对比
unique()
setdiff(a,b)
intersect(a,b)
union(a,b)

#环境变量
ls()
rm()

#### 5. 数据读取与存储 ####
# R 语言课支持大部分格式化的数据文件读写txt,csv,xlsx;以及来自其他数据源的数据，比如web，json，sql等

#### 5.1 文件读写相关 ####
# 文件路径
getwd() #获取当前工作路径
setwd("./data") #更换工作路径
list.files() #列出当前路径下的所有文件

# 使用read.table 读入txt文件
?read.table # 有非常多的参数可调整帮助数据读入
data <- read.table(file="G:/单细胞数据挖掘v3-莫速乎/Day1课程资料/data/raw_counts.txt", 
                   sep="\t", header=T, stringsAsFactors=F)
#遇到较大的数据也可以先读几行看看
# data <- read.table(file="raw_counts.txt", sep="\t", header=T, stringsAsFactors=F,nrows = 10)

#检查读入的数据内容（前几行head，后几行tail）
head(data) #可自行查看head,tail支持什么参数
tail(data)
str(data)
summary(data)
#写出到文件
write.table(data[1:20,], file="output.txt", sep="\t", quote=F, row.names=T, col.names=T)

#read.csv() #读入逗号分隔的csv文件
data.csv <- read.csv("./raw_counts.csv")
dim(data.csv)
write.csv(data.csv[1:20,],file = "output.csv")

#read.xlsx #读入excel数据，需要调用openxlsx包
library(openxlsx)
data.xlsx <- read.xlsx("./raw_counts.xlsx",sheet = 1)
write.xlsx(data[1:10,],file = "./output.xlsx",rowNames = T,sheetName = "output1")


#### 5.2 R数据读写 ####
#R环境中的数据一般保存为RData
#保存为RData占空间较小，且便于数据传输读取及上下游稳定分析
save(data,file = "./testdata.RData")
#读入RData数据
rm(data) #先从环境中移除data变量
load("testdata.RData")
View(data[1:10,])

#保存全部环境变量
save.image(file = "all.RData")

#### 6. R函数 ####
# 函数是一组组合在一起以执行特定任务的语句。 R语言具有大量内置函数，用户可以创建自己的函数。
# 在R语言中，函数是一个对象，因此R语言解释器能够将控制传递给函数，以及函数完成动作所需的参数。
# 该函数依次执行其任务并将控制返回到解释器以及可以存储在其他对象中的任何结果。

#### 6.1 基本函数定义及构成 ####
# - 函数名称 - 这是函数的实际名称。它作为具有此名称的对象存储在R环境中。
# - 参数 - 参数是一个占位符。当函数被调用时，你传递一个值到参数。 参数是可选的; 也就是说，一个函数可能不包含参数。参数也可以有默认值。
# - 函数体 - 函数体包含定义函数的功能的语句集合。
# - 返回值 -函数的返回值是要评估的函数体中的最后一个表达式。

# R语言有许多内置函数，可以在程序中直接调用而无需先定义它们，比如seq，sum，max，paste等。我们还可以创建和使用我们自己的函数，称为用户定义的函数。

# 函数主要结构构成
function_name <- function(arg_1, arg_2, ...) {
  Function body
}
# 定义函数
function
# 参数设置
括号中填入相应的参数名称，可带上默认值
# 函数主题
{}内部编写函数的主体代码
# 函数的返回值
可有可无，如果要返回结果，可以使用return(变量名)


#### 6.2 函数示例 ####
#定义一个函数，将向量中的每一个数减去均值，先分步骤执行
#生成一个向量
a <- 1:10
#均值计算
a.mean <- mean(a)
#减均值
a - a.mean
#包装成函数
minusMean <- function(x) {
  a.mean <- mean(x)
  x - a.mean
}
#调用函数
minusMean(a)
b <- rnorm(10)
b
minusMean(b)

##两个参数或者多个参数
new.function <- function(a = 13, b = 4) {
  result <- a %% b
  result
}
new.function()
new.function(a = 10)
new.function(10)
new.function(b = 5)
new.function(a = 7,b = 2)

#### 6.3 循环函数 ####
编程中经常要用到重复执行一段语句的情况，这时候就可以写循环函数来完成重复执行的命令。

- for：给定循环的条件并依次执行
- while：给定判断条件，判断为真则持续执行

循环控制语句
- break：终止循环程序
- next：跳出该循环，重新执行下一个

#for 循环:计算1-100的和
i.sum <- 0
for(i in 1:100){
  i.sum = i.sum + i
}
i.sum

#while 循环
i.sum <- 0
i = i
while (i <= 100) {
  i.sum = i.sum + i
  i = i + 1
}
i.sum

#直接使用内置函数
sum(1:100)

#### 6.4 逻辑判断 ####

给定判断条件，条件为真（TRUE）则执行语句，条件为FALSE则不执行
- if...else
- ifelse
```{r eval=FALSE}
#if...else循环（其中else也可以为空也可以多个，多个else则中间的需要写成else if）
a <- 1:10
for(i in a){
  if(i <= 5){
    print(i^2)
  }else{
    print(i/2)
  }
}

#ifelse，单行语句完成
ifelse(a <= 5,a^2,a/2)

#### 7. R语言基础练习题 ####
练习题数据来自raw_counts.txt

#### 7.1 基因表达矩阵处理 ####
#提取表达量在至少一半样本中超过100且平均表达量超过200的基因，统计基因的数量，并将其表达矩阵并写入到文件中

#### 7.2 多矩阵查询 ####
#找出每个样本中表达量最高的10个基因