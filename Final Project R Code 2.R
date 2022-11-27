###
###
###  484/584 ML Project
###     By Josh Brown, Brandon Lynch, and Jacob Stys
###
############################################

#Data analysis report is to be written using PowerPoint (or equivalent).
#The slides should follow the format listed below.
#Use figures and tables effectively to show more information with less space.

# For Section 1 and 2, see README.MD

# Load Data
library(tidyverse) # install.packages("tidyverse")
products <- read_csv("https://ml.brunuslabs.com")
products <- as_tibble(products)
products

# Rename roi to resp
products <- products %>% rename(resp=roi)
attach(products)
# Check NA
Orig <- products
print("Summary:")
summary(Orig)
print("Total NA")
sum(is.na(Orig))
Orig <- Orig %>% na.omit()

# Remove outliers that could corrupt model
Q <- quantile(Orig$resp, probs=c(.25, .75), na.rm = FALSE)
iqr <- IQR(Orig$resp)
up <-  Q[2]+1.5*iqr # Upper Range
low<- Q[1]-1.5*iqr # Lower Range
Orig<- subset(Orig, Orig$resp > (Q[1] - 1.5*iqr) & Orig$resp < (Q[2]+1.5*iqr))

print("Final Dimensions of data")
dim(Orig)

#  - Give summary statistic for response variable. (Table or Histogram).
boxplot(Orig$resp)
hist(Orig$resp)
summary(Orig)

# Split Data and use AAA to BBB chunk
Orig <- Orig                 # Entire Data set (have to be data.frame)
train.size <- 8000            # num of rows for training set
test.size <- 2523             # num of rows for testing set
my.seed <- 1234              # give a seed

source('https://nmimoto.github.io/R/ML-00.txt')

#  - Show selected scatter plots of (X_i vs Y).
fold = 2
par(mfrow=c(3,3))
plot(CV.train[[fold]]$fbaFees,  CV.train[[fold]]$resp, xlab="fbaFees", ylab="Response (roi)")
lines(CV.valid[[fold]]$fbaFees, CV.valid[[fold]]$resp, type="p", col="red", pch=19)

plot(CV.train[[fold]]$new,  CV.train[[fold]]$resp, xlab="new", ylab="Response (roi)")
lines(CV.valid[[fold]]$new, CV.valid[[fold]]$resp, type="p", col="red", pch=19)

plot(CV.train[[fold]]$oosamazon,  CV.train[[fold]]$resp, xlab="oosamazon", ylab="Response (roi)")
lines(CV.valid[[fold]]$oosamazon, CV.valid[[fold]]$resp, type="p", col="red", pch=19)

plot(CV.train[[fold]]$ooslistprice,  CV.train[[fold]]$resp, xlab="ooslistprice", ylab="Response (roi)")
lines(CV.valid[[fold]]$ooslistprice, CV.valid[[fold]]$resp, type="p", col="red", pch=19)

plot(CV.train[[fold]]$avgamazon,  CV.train[[fold]]$resp, xlab="avgamazon", ylab="Response (roi)")
lines(CV.valid[[fold]]$avgamazon, CV.valid[[fold]]$resp, type="p", col="red", pch=19)

plot(CV.train[[fold]]$avglistprice,  CV.train[[fold]]$resp, xlab="avglistprice", ylab="Response (roi)")
lines(CV.valid[[fold]]$avglistprice, CV.valid[[fold]]$resp, type="p", col="red", pch=19)

plot(CV.train[[fold]]$productType,  CV.train[[fold]]$resp, xlab="productType", ylab="Response (roi)")
lines(CV.valid[[fold]]$productType, CV.valid[[fold]]$resp, type="p", col="red", pch=19)

plot(CV.train[[fold]]$avgOfferCount,  CV.train[[fold]]$resp, xlab="avgOfferCount", ylab="Response (roi)")
lines(CV.valid[[fold]]$avgOfferCount, CV.valid[[fold]]$resp, type="p", col="red", pch=19)

#  - Result of Chi-square association test.

#Section 3. Base Model Fit (1-2slide)
#  - Base model is multiple regression for a regression problem,
#    and Logistic regression for binary classification problem.
#  - Apply base model to the data.
#  - Summary of final fit. (Training/Test fit)
#  - List Model Parameters and Fit metrics (RMSE, R-square, or AUC)
#  - Did you look for better fit by omitting some variables?
#    (if applicable)

layout(matrix(1:6, 2, 3, byrow=TRUE))
CVFitDiagnosis <- numeric(0)
for (k in 1:5){
  Reg01 <- lm(resp ~., data=CV.train[[k]])
  summary(Reg01)
  
  Train.fitted = predict(Reg01, newdata=CV.train[[k]])
  Valid.pred = predict(Reg01, newdata=CV.valid[[k]])
  
  plot(Train.fitted, as.matrix(CV.train.resp[[k]]), xlab='Fitted', ylab='Actual')
  lines(Valid.pred, as.matrix(CV.valid.resp[[k]]), type='p', xlab='Fitted', 
        ylab='Actual', col='red', pch=20)
  abline(0,1)
  
  CVFitDiagnosis1 <- data.frame(
    tr.RMSE = caret::RMSE(Train.fitted, as.matrix(CV.train.resp[[k]])),
    tr.Rsquare = caret::R2(Train.fitted, CV.train.resp[[k]]),
    val.RMSE = caret::RMSE(Valid.pred, as.matrix(CV.valid.resp[[k]])),
    val.Rsquare = caret::R2(Valid.pred, CV.valid.resp[[k]])
  )
  CVFitDiagnosis <- rbind(CVFitDiagnosis, CVFitDiagnosis1)
}
layout(1)

CVFitDiagnosis


Fit1 <- lm(resp ~., data = Train.set)
summary(Fit1)

Train.fitted = predict(Fit1, newdata = Train.set)
Test.pred = predict(Fit1, newdata = Test.set)

plot( Train.fitted, as.matrix(Train.resp), xlab="Fitted", ylab="Actual",main="Final Test.set fit")
lines(Test.pred, as.matrix(Test.resp), type="p", xlab="Fitted", ylab="Actual", col="red", pch=20)
abline(0,1)

library(caret)
OLS <- data.frame(
  tr.RMSE = caret::RMSE(Train.fitted, as.matrix(Train.resp)),
  tr.Rsquare = caret::R2(Train.fitted, Train.resp),
  test.RMSE = caret::RMSE(Test.pred, as.matrix(Test.resp)),
  test.Rsquare = caret::R2(Test.pred, Test.resp)
)
OLS

#Section 4. ML Model (1-2slide)
#  - Apply ML models that you learned in this course.
#    State what method was used to select hyper-parameter. (Grid search? Built-in function?)
#  - List of actual hyper-parameter values that was used. 
#  - Plot hyper-parameter (X-axis) vs valid.RMSE and train.RMSE (Y-axis) for regression. 
#  - CV fit summary, and final Test set fit summary.
#  - Was there any improvement over the base model?
#  - How many parameter does this model have?
#  - Any sign of over-fitting?
#  - How you chose the 'best' model within this section.
#  - Present your 'best' model with all the parameter values.
#    (may be summarized if the model is large.)

#Lasso Regression

library(glmnet)

set.seed(my.seed)
x <- model.matrix(resp ~. , Train.set)[,-1]
x.train <- model.matrix(resp ~., Train.set)[,-1]
x.test  <- model.matrix(resp ~., Test.set)[,-1]
y <- Train.set$resp

CV.for.lambda <- cv.glmnet(x, y, alpha = 1, nfolds=5)
CV.for.lambda$lambda.min
FitLasso <- glmnet(x, y, alpha = 1, lambda = CV.for.lambda$lambda.min)
coef(FitLasso)
summary(Fit1)

cbind(coef(Fit1), coef(FitLasso))

# Get training / validation fit
Train.fitted <- as.vector(predict(FitLasso, x.train))
Test.pred   <- as.vector(predict(FitLasso, x.test))

plot( Train.fitted, as.matrix(Train.resp), xlab="Fitted", ylab="Actual",main="Final Test.set fit")
lines(Test.pred, as.matrix(Test.resp), type="p", xlab="Fitted", ylab="Actual", col="red", pch=20)
abline(0,1)


Lasso <- data.frame(
  tr.RMSE      = caret::RMSE(Train.fitted, as.matrix(Train.resp)),
  tr.Rsquare   = caret::R2(  Train.fitted,           Train.resp),
  test.RMSE    = caret::RMSE(Test.pred,    as.matrix(Test.resp)),
  test.Rsquare = caret::R2(  Test.pred,              Test.resp)
)
Lasso

OLS

#Decision Tree

library(tree)  
layout(matrix(1:6, 2, 3, byrow = TRUE))
CVFitDiagnosis <- numeric(0)
for (k in 1:5){
tree0 <- tree(resp ~., CV.train[[k]])
summary(tree0)

plot(tree0)
text(tree0, pretty=1, cex=.7)
}
#Decision Tree Growing the Model
install.packages('rpart.plot')
library(rpart)
library(rpart.plot)

tree1 <- rpart(resp ~., data = Train.set)
summary(tree1)

rpart.plot(tree1)

plot(tree1)
text(tree1)

#Growing and Pruning the tree

tree2 = tree(resp ~., Train.set)
summary(tree2)
tree2

Train.fitted = predict(tree2, type='vector')
Test.pred = predict(tree2, Test.set, type='vector')

plot(Train.fitted, as.matrix(Train.resp), xlab="Fitted", ylab="Actual")
lines(Test.pred, as.matrix(Test.resp), type="p", col="red", pch=19)
abline(0,1, col="red")

GrowingOnly <- data.frame(
  tr.RMSE      = caret::RMSE(Train.fitted, as.matrix(Train.resp)),
  tr.Rsquare   = caret::R2(Train.fitted, Train.resp),
  test.RMSE    = caret::RMSE(Test.pred, as.matrix(Test.resp)),
  test.Rsquare = caret::R2(Test.pred, Test.resp)
)
GrowingOnly

#Random Forest

install.packages('randomForest')
library(randomForest)
set.seed(my.seed)

treeRF1 = randomForest(resp ~., data=Train.set, mtry=6, ntree=25,importance=TRUE)
treeRF1

importance(treeRF1)
varImpPlot(treeRF1)

Train.fitted = predict(treeRF1, type='response')
Test.pred = predict(treeRF1, Test.set, type='response')

plot(Train.fitted, as.matrix(Train.resp), xlab="Fitted", ylab="Actual")
lines(Test.pred, as.matrix(Test.resp), type="p", col="red", pch=19)
abline(0,1, col="red")

library(caret)          # install.packages("caret")
RandomForest <- data.frame(
  tr.RMSE      = caret::RMSE(Train.fitted, as.matrix(Train.resp)),
  tr.Rsquare   = caret::R2(Train.fitted, Train.resp),
  test.RMSE    = caret::RMSE(Test.pred, as.matrix(Test.resp)),
  test.Rsquare = caret::R2(Test.pred, Test.resp)
)
RandomForest

#Boosting
install.packages('gbm')
library(gbm)
set.seed(my.seed)
treeBT1 = gbm::gbm(resp ~., data=Train.set, distribution='gaussian', n.trees=5000,
                   interaction.depth=4)
summary(treeBT1)

plot(treeBT1, i='productType')

Train.fitted = predict(treeBT1, type='response')
Test.pred = predict(treeBT1, Test.set, type='response')

plot(Train.fitted, as.matrix(Train.resp), xlab="Fitted", ylab="Actual")
lines(Test.pred, as.matrix(Test.resp), type="p", col="red", pch=19)
abline(0,1, col="red")

library(caret)          # install.packages("caret")
Boosting <- data.frame(
  tr.RMSE      = caret::RMSE(Train.fitted, as.matrix(Train.resp)),
  tr.Rsquare   = caret::R2(Train.fitted, Train.resp),
  test.RMSE    = caret::RMSE(Test.pred, as.matrix(Test.resp)),
  test.Rsquare = caret::R2(Test.pred, Test.resp)
)
Boosting

#Comparisons
OLS
GrowingOnly
RandomForest
Boosting

#Scalling the Dataset

products2 <- products %>% na.omit()

# Remove outliers that could corrupt model
Q <- quantile(products2$resp, probs=c(.25, .75), na.rm = FALSE)
iqr <- IQR(products2$resp)
up <-  Q[2]+1.5*iqr # Upper Range
low<- Q[1]-1.5*iqr # Lower Range
products2 <- subset(products2, products2$resp > (Q[1] - 1.5*iqr) & products2$resp < (Q[2]+1.5*iqr))

print("Final Dimensions of data")
dim(products2)

products3 <- products2 %>% mutate_each(base::scale)
products3

products.means <- products2 %>% mutate_each(mean)
products.means
products.SDs <- products2 %>% mutate_each(sd)
products.SDs

products4 <- tibble((products2 - products.means)/ products.SDs)
products4

Orig <- products4 
train.size <- 8000            # num of rows for training set
test.size <- 2523             # num of rows for testing set
my.seed <- 1234              # give a seed

source('https://nmimoto.github.io/R/ML-00.txt')

library(neuralnet)
sigmoid <- function(x) 1 / (1 + exp(-x))


set.seed(my.seed)
Fit01 = neuralnet::neuralnet(resp ~.,
                             Train.set,
                             hidden=3,
                             learningrate=1e-2,
                             act.fct=sigmoid,
                             linear.output=TRUE)
# linear.output FALSE means activation function is applied to output node

summary(Fit01)
#Section 4b. Model Improvement (Optional. 0-2 slide)
#  - Can you improve the prediction accuracy of the above model?
#  - Tweaking of the model parameter
#  - Variable Selection
#  - Other methods
#  - Are you sure you are not over-fitting the test set?
#  - This section may be repeated if you try different models


#Section 5. Cost Analysis and Threshold Selection (0-1 slide)
#  (For a classification problem only)
#  - Come up with cost function for (True Negative), (False Negative),
#    (True Positive), (False Positive), and select best threshold based on your cost function.


#Section 6. Conclusion (1 slide)
#  - What do you think about your final model? Are you satisfied?
#  - How much did it improve over the base model?
#  - Is the model still interpretable?  or did it loose all of the interpretability?
#  - If you are to spend more time trying to improve the prediction accuracy,
#    what would you try next?