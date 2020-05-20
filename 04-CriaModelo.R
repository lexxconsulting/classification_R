# Creating the Predictive Model in R

# Obs: If you have problems with the accentuation, see this link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configuring the working directory
# Quote the working directory you are using on your computer
# Do not use directories with a space in the name

setwd("C:/Users/leand/Desktop/dscience_proj/PROJECT_Credit_Analyse_Azure_ML")
getwd()

# Create a classification model based on randomForest
library(randomForest)

# Cross Tabulation
?table
table(Credit$CreditStatus)

# Function to generate training data and test data
splitData <- function(dataframe, seed = NULL) {
  if (!is.null(seed)) set.seed(seed)
  index <- 1:nrow(dataframe)
  trainindex <- sample(index, trunc(length(index)/2))
  trainset <- dataframe[trainindex, ]
  testset <- dataframe[-trainindex, ]
  list(trainset = trainset, testset = testset)
}

# Generating training and test data
splits <- splitData(Credit, seed = 808)

# Separating the data
dados_treino <- splits$trainset
dados_teste <- splits$testset

# Checking the number of lines
nrow(dados_treino)
nrow(dados_teste)
  
# Building the model, see that we delete the "Duration, CreditAmount" columns because we replace them
# by the columns created "Duration_f, CreditAmount_f", as they are collinear variables, that is,
# represent the same information and if it stayed, it would leave the model biased
modelo <- randomForest( CreditStatus ~ CheckingAcctStat
                       + Duration_f
                       + Purpose
                       + CreditHistory
                       + SavingsBonds
                       + Employment
                       + CreditAmount_f, 
                       data = dados_treino, 
                       ntree = 100, 
                       nodesize = 10)

# Printing the result
print(modelo)



