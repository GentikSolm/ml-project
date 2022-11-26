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
dim(Orig)# 10059

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
train.size <- 8500            # num of rows for training set
test.size <- 1960             # num of rows for testing set
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
