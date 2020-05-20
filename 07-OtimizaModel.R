# Optimizing the predictive model

# Obs: If you have problems with the accentuation, see this link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configuring the working directory
# Quote the working directory you are using on your computer
# Do not use directories with a space in the name

setwd("C:/Users/leand/Desktop/dscience_proj/PROJECT_Credit_Analyse_Azure_ML")
getwd()

# Weighted randomForest model
# The C50 package allows you to give weight to errors, thus building a weighted result
install.packages("C50")
library(C50)

# Creating a Cost Function
Cost_func <- matrix(c(0, 1.5, 1, 0), nrow = 2, dimnames = list(c("1", "2"), c("1", "2")))


# Creating the Model
?randomForest
?C5.0


# Create the model
modelo_v2  <- C5.0(CreditStatus ~ CheckingAcctStat
                   + Purpose
                   + CreditHistory
                   + SavingsBonds
                   + Employment,
                   data = dados_treino,  
                   trials = 100,
                   cost = Cost_func)

print(modelo_v2)


# Dataframes with observed and predicted values
previsoes_v2 <- data.frame(observado = dados_teste$CreditStatus,
                           previsto = predict(object = modelo_v2, newdata = dados_teste))

# Calculating the Confusion Matrix in R (there are other ways).

# Label 1 - Bad Credit
# Label 2 - Good Credit

# Formulas
Accuracy <- function(x){
  (x[1,1] + x[2,2]) / (x[1,1] + x[1,2] + x[2,1] + x[2,2])
}

Recall <- function(x){  
  x[1,1] / (x[1,1] + x[1,2])
}

Precision <- function(x){
  x[1,1] / (x[1,1] + x[2,1])
}

W_Accuracy  <- function(x){
  (x[1,1] + x[2,2]) / (x[1,1] + 5 * x[1,2] + x[2,1] + x[2,2])
}

F1 <- function(x){
  2 * x[1,1] / (2 * x[1,1] + x[1,2] + x[2,1])
}

# Creating the confusion matrix.
confMat_v2 <- matrix(unlist(Map(function(x, y){sum(ifelse(previsoes_v2[, 1] == x & previsoes_v2[, 2] == y, 1, 0) )},
                             c(2, 1, 2, 1), c(2, 2, 1, 1))), nrow = 2)


# Creating a dataframe with test statistics
df_mat <- data.frame(Category = c("Credito Ruim", "Credito Bom"),
                     Classificado_como_ruim = c(confMat_v2[1,1], confMat_v2[2,1]),
                     Classificado_como_bom = c(confMat_v2[1,2], confMat_v2[2,2]),
                     Accuracy_Recall = c(Accuracy(confMat_v2), Recall(confMat_v2)),
                     Precision_WAcc = c(Precision(confMat_v2), W_Accuracy(confMat_v2)))

print(df_mat)


# Generating Confusion Matrix with Caret
library(caret)
confusionMatrix(previsoes_v2$observado, previsoes_v2$previsto)



