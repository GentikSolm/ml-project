###
###
###  484/584 ML Project Report Outline
###
###
############################################
Data analysis report is to be written using PowerPoint (or equivalent).
The slides should follow the format listed below.
Use figures and tables effectively to show more information with less space.


Section 1. Introduction (1slide)
  - Brief introduction of the project's objective.
    dataset name, 
    Regression vs Classification,
    Inference vs Prediction, etc. 
  - Brief list of models you used. 


Section 2. Dataset and Preliminary Analysis (1-2 slide)
  - Specify where you obtained your data (R package, UCI, Kaggle, etc.)
    If URL is available, it should be shown. 
  - Table explaining the variables in the dataset.
    List out each variable in the data, and its class (numeric, categorical, etc.)
    If it's categorical, list number of levels.
    If number of variable is large, the table may have to be summarized.
  - Show selected scatter plots of (X_i vs Y).
  - Give summary statistic for response variable. (Table or Histogram).
  - Result of Chi-square association test.


Section 3. Base Model Fit (1-2slide)
  - Base model is multiple regression for a regression problem,
    and Logistic regression for binary classification problem.
  - Apply base model to the data.
  - Summary of final fit. (Training/Test fit)
  - List Model Parameters and Fit metrics (RMSE, R-square, or AUC)
  - Did you look for better fit by omitting some variables?
    (if applicable)


Section 4. ML Model (1-2slide)
  - Apply ML models that you learned in this course.
    State what method was used to select hyper-parameter. (Grid search? Built-in function?)
  - List of actual hyper-parameter values that was used. 
  - Plot hyper-parameter (X-axis) vs valid.RMSE and train.RMSE (Y-axis) for regression. 
  - CV fit summary, and final Test set fit summary.
  - Was there any improvement over the base model?
  - How many parameter does this model have?
  - Any sign of over-fitting?
  - How you chose the 'best' model within this section.
  - Present your 'best' model with all the parameter values.
    (may be summarized if the model is large.)


Section 4b. Model Improvement (Optional. 0-2 slide)
  - Can you improve the prediction accuracy of the above model?
  - Tweaking of the model parameter
  - Variable Selection
  - Other methods
  - Are you sure you are not over-fitting the test set?
  - This section may be repeated if you try different models


Section 5. Cost Analysis and Threshold Selection (0-1 slide)
  (For a classification problem only)
  - Come up with cost function for (True Negative), (False Negative),
    (True Positive), (False Positive), and select best threshold based on your cost function.


Section 6. Conclusion (1 slide)
  - What do you think about your final model? Are you satisfied?
  - How much did it improve over the base model?
  - Is the model still interpretable?  or did it loose all of the interpretability?
  - If you are to spend more time trying to improve the prediction accuracy,
    what would you try next?


Appendix
  Submit R code as separate .R file. 
  Your code must have clear section header.
