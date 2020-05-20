# Exploratory Data Analysis

# This code was created to run on both Azure and RStudio.
# To run on Azure, change the value of the Azure variable to TRUE. If the value is FALSE, the code will be executed in RStudio

# Obs: If you have problems with the accentuation, see this link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configuring the working directory
# Quote the working directory you are using on your computer
# Do not use directories with a space in the name

setwd("C:/Users/leand/Desktop/dscience_proj/PROJECT_Credit_Analyse_Azure_ML")
getwd()

# Variable that controls the execution of the script
Azure <- FALSE

if(Azure){
  source("src/ClassTools.R")
  Credit <- maml.mapInputPort(1)
}



# Beloow we are going to create 2 scripts to create to plots to compare the variables with 
# the target variable in 2 blocks 


# Plots usando ggplot2
# The columns is the original list of orginal variables and 
# the colNames2 is the list created, remember when we created 3 new columns before?
# we call this list to avoid to write all columns at the same time
# we can find this list in the "classtools,R" file

library(ggplot2)
lapply(colNames2, function(x){
  if(is.factor(Credit[,x])) {
    ggplot(Credit, aes_string(x)) +
      geom_bar() + # graficos de barra
      facet_grid(. ~ CreditStatus) + # the function " facet_grid" inserting all graphs in the same plot place
      # the dot "." before "~" in "(. ~ CreditStatus)" refer to all predict variables
      # and after "~" refer to the target variable.
      ggtitle(paste("Total de Credito Bom/Ruim por",x))}}) 


# Plots CreditStatus vs CheckingAcctStat

lapply(colNames2, function(x){
  if(is.factor(Credit[,x]) & x != "CheckingAcctStat") {
    ggplot(Credit, aes(CheckingAcctStat)) +
      geom_bar() + 
      facet_grid(paste(x, " ~ CreditStatus"))+  # the function paste, paste 2 commands
      # "x" is the function variable 
      # the string " ~ CreditStatus" is part of the formula and represent the variable "CreditStatus"
      # vamos colar para cada variavel "x", with the variable "CreditStatus"
      # whe we compare this function with the last one where we have "(. ~ CreditStatus)"
      ggtitle(paste("Total de Credito Bom/Ruim CheckingAcctStat e",x))
  }})
