# Script to check the dataset columns

# Obs: If you have problems with the accentuation, see this link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configuring the working directory
# Quote the working directory you are using on your computer
# Do not use directories with a space in the name



setwd("C:/Users/leand/Desktop/dscience_proj/PROJECT_Credit_Analyse_Azure_ML")
getwd()

# Load the dataset before transformation
df <- read.csv("credito.csv")
View(df)
str(df)
summary(df)


# Name of variables
# CheckingAcctStat, Duration, CreditHistory, Purpose, CreditAmount, SavingsBonds, Employment, InstallmentRatePecnt, SexAndStatus, OtherDetorsGuarantors, PresentResidenceTime, Property, Age, OtherInstallments, Housing, ExistingCreditsAtBank, Job, NumberDependents, Telephone, ForeignWorker, CreditStatus

