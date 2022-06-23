
setwd("~/mnt/p/userdata/ekaterinap85/data/Publikation/deBruine")
setwd("//p.psy.univie.ac.at/storage/userdata/ekaterinap85/data/Publikation/deBruine")

################################################################################
# load stuff into r ------------------------------------------------------------
################################################################################
library("readxl")
library(ngram)
library("stringr")

# Import raw data
raw_data <- read_excel("Code Check Survey.xlsx") 
################################################################################
# data cleaning  --------------------------------------------
################################################################################
#Q1
myvars <- c("What is your research discipline?")
newdata <- raw_data[myvars]
prop<- as.data.frame(prop.table(table(newdata$"What is your research discipline?")))

#Q2
myvars <- c("What are your usual roles relevant to code check?")
newdata <- toString(raw_data[myvars])
str_count(newdata, pattern = "I write research code")
str_count(newdata, pattern = "I supervise students/postdocs who write code")
str_count(newdata, pattern = "I use research code written by collaborators")
str_count(newdata, pattern = "I assess research code as a reviewer")
str_count(newdata, pattern = "I assess research code as an editor")
str_count(newdata, pattern = "I teach others about research code")

#Q3
myvars <- c("What coding languages would you be interested in seeing specific examples of code check for?")
newdata <- toString(raw_data[myvars])
str_count(newdata, pattern = "R")
str_count(newdata, pattern = "Python")
str_count(newdata, pattern = "MatLab")
str_count(newdata, pattern = "Stata")

#Q4
myvars <- c("How do you check your own code?")
newdata <- toString(raw_data[myvars])
str_count(newdata, pattern = "I don't code")
str_count(newdata, pattern = "I code, but don't check it")
str_count(newdata, pattern = "I review it in an informal, unstructured way before sharing/submission")
str_count(newdata, pattern = "I have a structured way to review it")
str_count(newdata, pattern = "I use an automated workflow")
str_count(newdata, pattern = "I have others")

#Q5
myvars <- c("Have you ever reviewed someone else’s code?")
newdata <- toString(raw_data[myvars])
str_count(newdata, pattern = "Yes")
str_count(newdata, pattern = "No")

#Q6
myvars <- c("How often do you do code check for projects you are involved in?")
newdata <- toString(raw_data[myvars])
str_count(newdata, pattern = "Never")
str_count(newdata, pattern = "Less than I ought to")
str_count(newdata, pattern = "About as much as I ought to")
str_count(newdata, pattern = "More than I ought to")


