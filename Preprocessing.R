# Read the data
data <- read.csv("project-2018-BRFSS-arthritis.csv", header = TRUE, stringsAsFactors = FALSE

# Which attributes have missing features?
for (i in 1:ncol(data)) 
  {if(length(which(data[,i] == "?")) > 0)    { print(colnames(data)[i])}
  }
  
# Missing values in numerical variables can be replaced with the mean value.
round(mean(as.numeric(data[which(data[,4] != "?"),4])))
round(mean(as.numeric(data[which(data[,5] != "?"),5])))

data[which(data[,4] == "?"),4] <- rep("671", nrow(data[which(data[,4] == "?"),]))
data[which(data[,5] == "?"),5] <- rep("740", nrow(data[which(data[,5] == "?"),]))

data[,4] <- as.numeric(data[,4])
data[,5] <- as.numeric(data[,5])

round(mean(as.numeric(data[which(data[,57] != "?"),57])))
round(mean(as.numeric(data[which(data[,58] != "?"),58])))
round(mean(as.numeric(data[which(data[,59] != "?"),59])))

data[which(data[,57] == "?"),57] <- rep("67", nrow(data[which(data[,57] == "?"),]))
data[which(data[,58] == "?"),58] <- rep("8199", nrow(data[which(data[,58] == "?"),]))
data[which(data[,59] == "?"),59] <- rep("2827", nrow(data[which(data[,59] == "?"),]))

data[,57] <- as.numeric(data[,57])
data[,58] <- as.numeric(data[,58])
data[,59] <- as.numeric(data[,59])

round(mean(as.numeric(data[which(data[,61] != "?"),61])))

data[which(data[,61] == "?"),61] <- rep("170", nrow(data[which(data[,61] == "?"),]))

data[,61] <- as.numeric(data[,61])

# Which attributes with missing values are left?
missing.attributes <- c()
for (i in 1:ncol(data)) 
  {if(length(which(data[,i] == "?")) > 0)    { missing.attributes[i] <- colnames(data)[i]}
}

missing.attributes <- missing.attributes[!is.na(missing.attributes)]
missing.attributes

# The question marks can be replaced with zeros, as these variables are in fact, categorical. The variables can be later transformed into numerical if a particular classification algorithm requires such an input.
data[data=="?"] <- "0"

# Variables with a finite sets of values are factors and will be converted. Also integers will be converted to numeric
data[,1:3] <- lapply(data[,1:3], factor)
data[,6:29] <- lapply(data[,6:29], factor)
data[,31:56] <- lapply(data[,31:56], factor)
data[,60] <- as.factor(data[,60])
data[,62:63] <- lapply(data[,62:63], factor)
data[,64] <- as.numeric(data[,64])
data[,65:84] <- lapply(data[,65:84], factor)
data[,87:90] <- lapply(data[,87:90], factor)
data[,92] <- as.numeric(data[,92])
data[,95:108] <- lapply(data[95:108], factor)

# Some variables do not contain any valuable information. These can be removed outright
data <- data[,-30]
