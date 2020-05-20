# Analyzing the result through graphics (extra bonus)

# Obs: If you have problems with the accentuation, see this link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configuring the working directory
# Quote the working directory you are using on your computer
# Do not use directories with a space in the name

setwd("C:/Users/leand/Desktop/dscience_proj/PROJECT_Credit_Analyse_Azure_ML")
getwd()

Azure <- FALSE

# Changing compFrame variable assignment
if(Azure){
  source("src/ClassTools.R")
  compFrame <- maml.mapInputPort(1)
} else {
  compFrame <- result_previsto_v2 #outFrame
}

# Using dplyr to filter lines with incorrect classification
require(dplyr)
creditTest <- cbind(dados_teste, scored = compFrame[ ,2] )
creditTest <- creditTest %>% filter(CreditStatus != scored)

# Plot of waste for the levels of each factor
require(ggplot2)
colNames <- c("CheckingAcctStat", "Duration_f", "Purpose",
              "CreditHistory", "SavingsBonds", "Employment",
              "CreditAmount_f", "Employment")

lapply(colNames, function(x){
  if(is.factor(creditTest[,x])) {
    ggplot(creditTest, aes_string(x)) +
      geom_bar() + 
      facet_grid(. ~ CreditStatus) + 
      ggtitle(paste("Bad / good number of credits per",x))}})


# Plot of conditioned waste in CreditStatus vs. CheckingAcctStat variables
lapply(colNames, function(x){
  if(is.factor(creditTest[,x]) & x != "CheckingAcctStat") {
    ggplot(creditTest, aes(CheckingAcctStat)) +
      geom_bar() + 
      facet_grid(paste(x, " ~ CreditStatus"))+ 
      ggtitle(paste("Number of good / bad credits for CheckingAcctStat and ",x))
  }})


