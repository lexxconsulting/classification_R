# Applying Attribute Engineering to Numeric Variables

# This code was created to run on both Azure and RStudio.
# To run on Azure, change the value of the Azure variable to TRUE.
# If the value is FALSE, the code will be executed in RStudio

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
}else{
  source("src/ClassTools.R")
  Credit <- read.csv("credito.csv", header = F, stringsAsFactors = F )
  metaFrame <- data.frame(colNames, isOrdered, I(factOrder))   # converting some variable to factors
  Credit <- fact.set(Credit, metaFrame)
  
  # Balance the number of positive and negative cases
  Credit <- equ.Frame(Credit, 2)
}


# Transforming numeric variables in categorical varaibles
# We are appling the quantize funcions, preserving the original variables and creatin 3 new categorical variable
toFactors <- c("Duration", "CreditAmount", "Age")
maxVals <- c(100, 1000000, 100) # defining the variable maximum values 
facNames <- unlist(lapply(toFactors, function(x) paste(x, "_f", sep = ""))) #  "paste" and "tofactor" to create new variables 
Credit[, facNames] <- Map(function(x, y) quantize.num(Credit[, x], maxval = y), toFactors, maxVals)

 str(Credit) # now we can see 3 new categorical variables ( Duration_f ,CreditAmount_f, Age_f )
# and the priginal 3 variables still in the dataset ( Duration ,CreditAmount, Age )
 
 
 # Output 
if(Azure) maml.mapOutputPort('Credit')