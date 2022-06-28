library(randomForest)
set.seed(123)
rf.classifier <- randomForest(x = training[,features.rf], y = training$havarth3)
y_pred <- predict(rf.classifier, newdata = testing[,features.rf])
cm <- table(testing$havarth3, y_pred)
cm

rf.table <- data.frame(matrix(nrow = 3, ncol = 8))
colnames(rf.table) <- c("Class", "TP Rate", "FP Rate", "Precision", "Recall", "F-measure", "ROC Area", "MCC")

TP <- unname(cm)[1,1]
TN <- unname(cm)[2,2]
FP <- unname(cm)[2,1]
FN <- unname(cm)[1,2]

TP <- as.numeric(TP)
TN <- as.numeric(TN)
FP <- as.numeric(FP)
FN <- as.numeric(FN)

rf.table$Class <- c("1", "2", "Weighted")

rf.table[1,2] <- TP/(TP+FN)
rf.table[2,2] <- TN/(TN+FP)
rf.table[1,3] <- FP/(FP+TN)
rf.table[2,3] <- FN/(FN+TP)
rf.table[1,4] <- TP/(TP+FP)
rf.table[2,4] <- TN/(TN+FN)
rf.table[1,5] <- TP/(TP+FN)
rf.table[2,5] <- TN/(TN+FP)
rf.table[1,6] <- (2*rf.table[1,4]*rf.table[1,5])/(rf.table[1,4]+rf.table[1,5])
rf.table[2,6] <- (2*rf.table[2,4]*rf.table[2,5])/(rf.table[2,4]+rf.table[2,5])
rf.table[1:2,8] <- (TP*TN-FP*FN)/sqrt((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN))

library(pROC)
test_prob <- predict(rf.classifier, testing[,features.rf], type = "response")

rf.table[1,7] <- as.numeric(roc(testing$havarth3 ~ as.numeric(test_prob), levels = c("1","2"))$auc)
rf.table[2,7] <- as.numeric(roc(testing$havarth3 ~ as.numeric(test_prob), levels = c("2","1"))$auc)

for (i in 2:8) {
  rf.table[3,i] <- mean(rf.table[1:2,i]) 
}

library(knitr)
library(kableExtra)
kable(rf.table, caption = "Random Forest with Random Forest Feature Selection") %>% kable_styling(full_width = TRUE)
