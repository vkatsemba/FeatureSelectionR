# The Random Forest method for feature selection can be used to measure how each attribute decreases the impurity if the split, ie the attribute with the highest decrease is selected for the internal node. The measure of impurity is either gini impurity or information gain/entropy in the case of classification.
library(party)
library(varImp)
cf <- cforest(havarth3 ~ . , data= training, control=cforest_unbiased(mtry=2,ntree=50))
features.imp <- varimp(cf)[order(varimp(cf), decreasing = TRUE)][1:10]
features.rf <- names(features.imp)
