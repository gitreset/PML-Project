# Practical Machine Learning - Project

library(caret)
library(rpart)
library(rpart.plot)
library(randomForest)
library(corrplot)

trainSet <- read.csv("./pml-training.csv")
testSet <- read.csv("./pml-testing.csv")

dim(testSet)
dim(trainSet)
summary(testSet)
summary(trainSet)
names(testSet)
names(trainSet)
# names(testSet)[(names(testSet) == names(trainSet))]
head(trainSet)

sum(complete.cases(trainSet))
sum(complete.cases(testSet))


tst <- testSet[, colSums(is.na(testSet)) == 0]
trn <- trainSet[, colSums(is.na(trainSet)) == 0]


