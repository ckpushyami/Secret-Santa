library(tidyverse)
library(gmailr)
library(ponyexpress)
library(tibble)

#Input needed include columns titled: santa_firstnames, santa_lastnames, santa_email, santa_address in a file entitled santaprep.csv
testdf <- read.csv(file="santaprep.csv",header = TRUE)
#Create a repeat loop that will continue to go over this list until there are no issues (1. No person has themselves. 2. No person has their partner.)
repeat {
  #Create the Secret Santa pair!
  newdf <- testdf %>%
    mutate(receiver_firstnames = sample(santa_firstnames))
  #Create a partner data frame to merge partner variables into it!
  partnerdf <- testdf %>%
    transmute(receiver_firstnames = santa_firstnames,
              receiver_lastnames = santa_lastnames,
              receiver_email = santa_email,
              receiver_address = santa_address)
  #Now join the data frames!
  newdf <- dplyr::inner_join(newdf,partnerdf, by = "receiver_firstnames") 
  #Check if there are problems!
    #Check problems within the family!
  newdf$fam_eval <- ifelse(newdf$receiver_lastnames == newdf$santa_lastnames, "Problems!", "No problem here!")
    #Check problems if a person has themself!
  newdf$self_eval <- ifelse(newdf$receiver_firstnames == newdf$santa_firstnames, ifelse(newdf$receiver_lastnames == newdf$santa_lastnames, "Problems", "No Problems!"), "No problem here!")
    #Final problem check!
  newdf$finaleval <- ifelse(newdf$fam_eval == "Problems!" | newdf$self_eval == "Problems!",print("Stop, there are issues!"),print("Ain't no issues here!"));
  #Drop superflous columns and create output dataframe!
  SecretSanta <- newdf %>% select(-c(receiver_email,santa_address,fam_eval,self_eval,finaleval))
  if (all(newdf$finaleval == "Ain't no issues here!")) { #Are there issues? If so, repeat loop.
    print("We are all finished with divvying up the presents!");
    break
  }
}
#Save Email for reference
write.csv(SecretSanta, file = "secretsanta.csv")
#Email out results and master list

#Recreate Parcel Function - I removed the check email if function. It seems to work now.
parcel_create <- function(df,
                          sender_name = NULL,
                          sender_email = NULL,
                          subject = NULL,
                          bcc = NULL,
                          template = NULL) {
  emails <- NULL
  if (is.null(df) || is.null(sender_name) || is.null(sender_email) || is.null(template)) {
    stop("You must supply a value for: df, sender_name, sender_email, and template")
  }
  
  email <- df
  email$To <- glue::glue_data(df,"{santa_firstnames} <{santa_email}>")
  email$Bcc <- bcc
  email$From <- glue::glue("{sender_name} <{sender_email}>")
  email$Subject <- subject
  email$body <- glue::glue_data(df, template)
  email <- email[, names(email) %in% c("To", "Bcc", "From", "Subject", "body")]
  structure(email, class = c("parcel", "data.frame"))
}


body <- "Merry Christmas Elf {santa_firstnames}!

In the spirit of Santa, you will be getting a gift for {receiver_firstnames}. 

Make sure to get it to {receiver_address}. 

Please try to have it there by Dec 25! The gift should be around be around $50!

Please post photos of your gifts so that we know for sure you got them!

<img src = 'https://media.giphy.com/media/zhPXoVIBMtnUs/giphy.gif'> </img>

Merry Christmas, Elf!

Santa R Bot"

our_template <- glue::glue(glitter_template)

parcel <- parcel_create(SecretSanta,
                        sender_name = "Santa R Bot",
                        sender_email = "INSERT HOST EMAIL HERE",
                        subject = "CONFIDENTIAL: SECRET SANTA",
                        template = our_template)

parcel_send(parcel)
