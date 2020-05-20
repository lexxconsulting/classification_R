# Calculating the Confusion Matrix in R (there are other ways)

# Obs: If you have problems with the accentuation, see this link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configuring the working directory
# Quote the working directory you are using on your computer
# Do not use directories with a space in the name

setwd("C:/Users/leand/Desktop/dscience_proj/PROJECT_Credit_Analyse_Azure_ML")
getwd()

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
confMat <- matrix(unlist(Map(function(x, y){sum(ifelse(previsoes[, 1] == x & previsoes[, 2] == y, 1, 0) )},
                               c(2, 1, 2, 1), c(2, 2, 1, 1))), nrow = 2)


# Creating a dataframe with test statistics
df_mat <- data.frame(Category = c("Credito Ruim", "Credito Bom"),
                     Classificado_como_ruim = c(confMat[1,1], confMat[2,1]),
                     Classificado_como_bom = c(confMat[1,2], confMat[2,2]),
                     Accuracy_Recall = c(Accuracy(confMat), Recall(confMat)),
                     Precision_WAcc = c(Precision(confMat), W_Accuracy(confMat)))

print(df_mat)

# Generating a ROC curve in R
install.packages("ROCR")
library("ROCR")

# Gerando as classes de dados
class1 <- predict(modelo, newdata = dados_teste, type = 'prob')
class2 <- dados_teste$CreditStatus

# Generating the ROC curve
?prediction
?performance
pred <- prediction(class1[,2], class2)
perf <- performance(pred, "tpr","fpr") 
plot(perf, col = rainbow(10))

# Generating Confusion Matrix with Caret
library(caret)
?confusionMatrix
confusionMatrix(previsoes$observado, previsoes$previsto)











