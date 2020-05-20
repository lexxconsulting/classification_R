# Making Predictions

# Obs: If you have problems with the accentuation, see this link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configuring the working directory
# Quote the working directory you are using on your computer
# Do not use directories with a space in the name

setwd("C:/Users/leand/Desktop/dscience_proj/PROJECT_Credit_Analyse_Azure_ML")
getwd()

# Forecasts with a classification model based on randomForest
require(randomForest)

# Generating predictions in test data
previsoes <- data.frame(observado = dados_teste$CreditStatus,
                        previsto = predict(modelo, newdata = dados_teste))


# Viewing the result
View(previsoes)
View(dados_teste)





