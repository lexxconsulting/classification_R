# Feature Selection (Selection of Variables)

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
}  

# RandomForest model to create a plot of importance of variables
# the varaible "CreditStatus ~" before "~" is the tarhet variable.
# the "." call all variables
# the signam "-" exclude the variable called in the code
# we have decide to exclude these variable because we conclued in the descriptive analysis
# that these variable are not important
library(randomForest)
model <- randomForest( CreditStatus ~ .
                        - Duration
                        - Age
                        - CreditAmount
                        - ForeignWorker
                        - NumberDependents
                        - Telephone
                        - ExistingCreditsAtBank
                        - PresentResidenceTime
                        - Job
                        - Housing
                        - SexAndStatus
                        - InstallmentRatePecnt
                        - OtherDetorsGuarantors
                        - Age_f
                        - OtherInstalments, 
                        data = Credit, 
                        ntree = 100, nodesize = 10, importance = T)
# "importance = T " mean that the model will return only the important instances for the model


varImpPlot(model)

outFrame <- serList(list(credit.model = model))


## Output 
if(Azure) maml.mapOutputPort("outFrame")
