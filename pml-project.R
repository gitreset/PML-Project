# Practical Machine Learning - Course Project

# Just barebones R code. See the Rmd file for details.

trainSet <- read.csv("pml-training.csv")
testSet <- read.csv("pml-testing.csv")

dim(testSet)
dim(trainSet)
names(testSet)[(names(testSet) != names(trainSet))]
names(trainSet)[(names(testSet) != names(trainSet))]

head(testSet$problem_id)
head(trainSet$classe)

testSet2 <- testSet[,-(1:7)]
trainSet2 <- trainSet[, -(1:7)]

testSet3 <- testSet2[, sapply(testSet2, is.numeric)]
trainSet3 <- trainSet2[, sapply(trainSet2, is.numeric)]

testSetGood <- testSet3[, colSums(is.na(testSet3)) == 0]
trainSetGood <- trainSet3[, colSums(is.na(trainSet3)) == 0]
trainSetGood$classe <- trainSet$classe # restore the classe column.
dim(testSetGood)
dim(trainSetGood)

invisible(library(rpart))
invisible(library(caret))

set.seed(55555)
training_data <- createDataPartition(trainSetGood$classe, p = 0.60, list=FALSE)

validationData <- trainSetGood[-training_data,]
trainingData <- trainSetGood[training_data,]

invisible(library(randomForest))
predictRF <- train(classe ~ ., data=trainingData, method="rf", trControl=trainControl(method="cv", 7)) # Leave rest of the options at default values.
predictRF

validationResult <- predict(predictRF, validationData)
cmat <- confusionMatrix(validationData$classe, validationResult)

acc <- postResample(validationResult, validationData$classe)
acc
ooserr <- 1 - as.numeric(cmat$overall[1])
ooserr

finalResult <- predict(predictRF, testSetGood)
finalResult