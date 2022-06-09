## ----setup, echo=FALSE, results="hide"-----------------------------------
knitr::opts_chunk$set(tidy=FALSE, cache=FALSE,
                      dev="png",
                      message=FALSE, error=FALSE, warning=FALSE)

## ----install_depend, eval = FALSE----------------------------------------
#  if (!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  
#  BiocManager::install("ROC")

## ----test----------------------------------------------------------------
library(classpredict)
res <- test.classPredict("Brca",outputName = "ClassPrediction", generateHTML = FALSE)

## ----misc----------------------------------------------------------------
names(res)

## ------------------------------------------------------------------------
res$performClass[1:11,]

## ------------------------------------------------------------------------
res$percentCorrectClass

## ------------------------------------------------------------------------
res$predNewSamples[1:4,]

## ------------------------------------------------------------------------
res$probNew[1:4,]

## ---- fig.show='hold'----------------------------------------------------
library(classpredict)
res <- test.classPredict("Brca",outputName = "ClassPrediction")
plotROCCurve(res,"ccp")
plotROCCurve(res,"dlda")
plotROCCurve(res,"bcc")

## ------------------------------------------------------------------------
dataset<-"Brca"
# gene IDs
geneId <- read.delim(system.file("extdata", paste0(dataset, "_GENEID.txt"), package = "classpredict"), as.is = TRUE, colClasses = "character") 
# expression data
x <- read.delim(system.file("extdata", paste0(dataset, "_LOGRAT.TXT"), package = "classpredict"), header = FALSE)
# filter information, 1 - pass the filter, 0 - filtered
filter <- scan(system.file("extdata", paste0(dataset, "_FILTER.TXT"), package = "classpredict"), quiet = TRUE)
# class information
expdesign <- read.delim(system.file("extdata", paste0(dataset, "_EXPDESIGN.txt"), package = "classpredict"), as.is = TRUE)
# training/test information
testSet <- expdesign[, 10]
trainingInd <- which(testSet == "training")
predictInd <- which(testSet == "predict")
ind1 <- which(expdesign[trainingInd, 4] == "BRCA1")
ind2 <- which(expdesign[trainingInd, 4] == "BRCA2")
ind <- c(ind1, ind2)
exprTrain <- x[, ind]
colnames(exprTrain) <- expdesign[ind, 1]
exprTest <- x[, predictInd]
colnames(exprTest) <- expdesign[predictInd, 1]


## ------------------------------------------------------------------------
exprTrain[1:5,]

## ------------------------------------------------------------------------
exprTest[1:5,]

## ----sessionInfo---------------------------------------------------------
sessionInfo()

