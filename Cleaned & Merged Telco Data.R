library(data.table)
library(tidyverse)
library(dplyr)

customer <- fread("C:/Users/bluec/Desktop/CustData.csv", data.table = FALSE)
name <- fread("C:/Users/bluec/Desktop/Firstname.csv", data.table = FALSE)
transaction <- fread("C:/Users/bluec/Desktop/Transaction Data.csv", data.table = FALSE)

new <- name %>%
  full_join(customer, by = intersect(colnames(customer), colnames(name))) %>%
  group_by(Firstname) %>%
  summarize_all(na.omit)

write.csv(new, file = "Merged Customer data.csv")

new2 <- transaction %>%
  full_join(new, by = intersect(colnames(transaction), colnames(new))) %>%
  group_by(CustomerId) %>%
  summarize_all(na.omit)

write.csv(new2, file = "Merged Customer data (transaction).csv")

merge <- fread("C:/Users/bluec/Desktop/Merge2.csv", data.table = FALSE)
terminate <- fread("C:/Users/bluec/Desktop/TerminationData.csv", data.table = FALSE)
churn <- fread("C:/Users/bluec/Desktop/Churn Data.csv", data.table = FALSE)

new3 <- merge %>%
  full_join(terminate, by = intersect(colnames(merge), colnames(terminate))) %>%
  group_by(CustomerId) 

new4 <- new3 %>%
  full_join(churn, by = intersect(colnames(new3), colnames(churn))) %>%
  group_by(CustomerId) 

write.csv(new4, file = "Full Merge.csv")