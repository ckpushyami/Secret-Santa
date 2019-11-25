library(tidyverse)
library(ponyexpress)

#Create a test data
firstnames <- c("Jack", "Jill", "Lyle", "Lilly", "Bill", "Dan", "Deloris", "Emily")
lastnames <- c("Smith", "Smith", "Lewis", "Lewis", "Buttes", "Deznada", "Deznada", "Richardson")
email <- c("jacks@test.com", "jills@test.com", "lylel@test.com", "lillyl@test.com", "billb@test.com",
           "dand@test.com","delorisd@test.com", "emilyr@test.com")
testdf <- as.data.frame(cbind(firstnames,lastnames,email))

colnames(testdf) <- c("Name", "Family", "Email")


#Secret Santa Assigner - Select someone who does not have the same family name and make sure everyone is chosen without a closed loop.

