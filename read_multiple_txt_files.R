
# install, update and load packages -----------------------------------------------

pkg <- c("stringr", "reshape2",  "dplyr", "ggplot2",  "magrittr")

new.pkg <- pkg[!(pkg %in% installed.packages())]

if (length(new.pkg)) {
  install.packages(new.pkg)
}

library(stringr)
library(reshape2)
library(dplyr)
library(ggplot2)


# Read in data ------------------------------------------------------------
          # update this file path to point toward appropriate folder on your computer
folder <- "/Users/majerus/Desktop/thesis_projects/linguistics/Yevgeniy/exp1/"      # path to folder that holds multiple .csv files
file_list <- list.files(path=folder, pattern="*.txt")                              # create list of all .csv files in folder

# read in each .csv file in file_list and rbind them into a data frame called data 
data <- 
  do.call("rbind", 
          lapply(file_list, 
                 function(x) 
                 cbind(file = x, read.table(paste(folder, x, sep=''), 
                            header = TRUE, 
                            stringsAsFactors = FALSE))))


# Clean data --------------------------------------------------------------

clean.data <- function(df){
  df <- cbind(df, colsplit(df$stimulus, ',', names =  c('s1','s2', 's3')))
  df$answer <- ifelse(str_count(df$stimulus, 'A') == 2, 'A', 'B')
  df$correct <- ifelse(df$response == df$answer, 1, 0)
  df$reactionTime <- as.numeric(df$reactionTime)
  return(df)
}

data <- clean.data(data)


# Write out data ----------------------------------------------------------

write.csv(data, paste(folder,'cleaned_data.csv', sep = ''), row.names = FALSE)


# Create data frame of summary statistics ---------------------------------

summary_stats <- 
  data %>%
  group_by(subject, correct, answer) %>%
  summarise(count = n(),
            mean_reactionTime = mean(reactionTime, na.rm = TRUE),
            sd_reactionTime = sd(reactionTime, na.rm = TRUE),
            min_reactionTime= min(reactionTime, na.rm = TRUE),
            max_reactionTime = max(reactionTime, na.rm = TRUE))



# Write out data frame of summary statistics ------------------------------

write.csv(summary_stats, paste(folder,'summary_stats.csv', sep = ''), row.names = FALSE)


