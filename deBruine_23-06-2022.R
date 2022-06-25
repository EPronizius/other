
setwd("~/mnt/p/userdata/ekaterinap85/data/Publikation/deBruine")
setwd("//p.psy.univie.ac.at/storage/userdata/ekaterinap85/data/Publikation/deBruine")

################################################################################
# load stuff into r ------------------------------------------------------------
################################################################################
library("readxl")
library(ngram)
library("stringr")
library("tm") #text mining quealitative
library(reshape)

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

#QUALITATIVE DATA ANALYSIS.
#Q7.
myvars <- c("If you don't do code check as much as you want/ought to, what is preventing you?")
#Q8.
myvars <- c("What’s the most intimidating part of doing code checks (as a code checker)?")
newdata <- raw_data[myvars]
newdata <-newdata %>% rename("What’s the most intimidating part of doing code checks (as a code checker)?" = Q1)

#Q9.
myvars <- c("What techniques or tools did you find most helpful when checking code?")
newdata <- raw_data[myvars]
newdata <-newdata %>% rename("What techniques or tools did you find most helpful when checking code?" = Q1)

#Q10.
myvars <- c("What are the biggest challenges you've faced when checking code?")
newdata <- raw_data[myvars]
newdata <-newdata %>% rename("What are the biggest challenges you've faced when checking code?" = Q1)

#Q11.
myvars <- c("What topics would you like covered in a code check guide, from either or both the perspective of a code reviewer or a person preparing their code to be reviewed?")
newdata <- raw_data[myvars]
newdata <-newdata %>% rename("What topics would you like covered in a code check guide, from either or both the perspective of a code reviewer or a person preparing their code to be reviewed?" = Q1)

#Q13.
myvars <- c("If you don't get your own code checked as much as you want/ought to, what is preventing you?")
newdata <- raw_data[myvars]
newdata <-newdata %>% rename("If you don't get your own code checked as much as you want/ought to, what is preventing you?" = Q1)

#Q14.
myvars <- c("What are the biggest challenges you've faced when getting your own code checked?")
newdata <- raw_data[myvars]
newdata <-newdata %>% rename("What are the biggest challenges you've faced when getting your own code checked?" = Q1)

## Clean up the text for analysis
# Function to remove leading and trailing whitespace
trim <- function (x) gsub("^\\s+|\\s+$", "", x)
newdata$Q1<-trim (newdata$Q1)
# Replace carriage returns with space
newdata$Q1 <- gsub("[\r\n]", " ", newdata$Q1)
newdata$Q1<- gsub("[,]", " ", gsub("[-]", " ", gsub("[.]", " ", gsub("[.]", " ", gsub("[']", " ", gsub("[!]", " ", gsub("[?]", " ",
             gsub("[&]", " ", gsub("[/]", " ", gsub("[(]", " ", gsub("[)]", " ", gsub("[;]", " ", newdata$Q1))))))))))))

# Convert all upper case to lower case
newdata$Q1 <- tolower(newdata$Q1)

# Create a corpus for text mining
OR1.corpus <- Corpus(VectorSource (newdata$Q1))
#makes all lower case
OR1.corpus <- tm_map (OR1.corpus, tolower)
#Removes Punctuation
OR1.corpus <- tm_map (OR1.corpus, removePunctuation)

# build a term-document matrix
OR1.dtm <- TermDocumentMatrix(OR1.corpus, control =
list(stopwords=TRUE,wordLengths = c(1,30)))

# inspect most popular words
findFreqTerms(OR1.dtm, lowfreq=5) ##Terms that appear 5 times

# Counts for top words
freqwrds <- sort (rowSums (as.matrix(OR1.dtm)),decreasing=TRUE) #time, code, dont, lack, check, collaborators

# Associations of word "climate" with other terms
findAssocs(OR1.dtm, "time", 0.20)



