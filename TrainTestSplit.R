# Partition the data into training and test sets
library(caret)
set.seed(123)
inTrain <- createDataPartition(y = data$havarth3,p = 0.66,list = FALSE)
training <- data[inTrain,]
testing <- data[-inTrain,]

# Check distribution in training and test sets to compare with initial dataset.
table(training$havarth3)
table(testing$havarth3)
table(data$havarth3)

2658/nrow(training)
1369/nrow(testing)
4027/nrow(data)
