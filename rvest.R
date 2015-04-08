# Libraries ---------------------------------------------------------------

if( !is.element("rvest", installed.packages()[,1]) )
  install.packages("rvest")

library(rvest)
library(stringr)

# read in data ------------------------------------------------------------

# read in list of ids and seasons 
list <- read.csv('/Users/majerus/Desktop/thesis_projects/theather/Shabab/LORTdata_tcgR.csv')

# create list of ids 
ids <- unique(list$MemberID)

ids <- ids[5:6]


# create function to read in data-----------
  
read.t.data <- function(id){
  seasons = c(17:22)
  
  results <-  do.call(rbind, lapply(1:length(seasons), function(i){
    
    url <- html(paste("http://www.tcg.org/tools/profiles/member_profiles/profile_detail.cfm?MemberID=", id, '&SeasonID=', seasons[i], sep=''))
    
    rankings <-
      url %>%
      html_nodes(".productions , #ProductionTitleRow td") %>%
      html_text() 
    
    rankings <- as.data.frame(rankings)
    
    if(nrow(rankings)>0) {
      rankings <- cbind(rankings, Season = seasons[i])
    } 
    
    return(rankings)
  }
  ))
  
  if(nrow(results)>0) {
    results <- cbind(id=id, results)
  } 
  
  return(results) 
  
}


# create function to scrape seating capacity in data-----------

capacity.pull <- function(id){
  seasons = c(17:22)
  
  results <-  do.call(rbind, lapply(1:length(seasons), function(i){
    
    url <- html(paste("http://www.tcg.org/tools/profiles/member_profiles/profile_detail.cfm?MemberID=", id, '&SeasonID=', seasons[i], sep=''))
    
    rankings <-
      url %>%
      html_nodes("tr:nth-child(10) td") %>%
      html_text() 
    
    rankings <- as.data.frame(rankings)
    
    if(nrow(rankings)>0) {
      rankings <- cbind(rankings, Season = seasons[i])
    } 
    
    return(rankings)
  }
  ))
  
  if(nrow(results)>0) {
    results <- cbind(id=id, results)
  } 
  
  return(results) 
  
}



# apply scraping function to list of ids 
data <- do.call(rbind, lapply(ids, read.t.data))

# pull capacity d
capacity <- do.call(rbind, lapply(ids, capacity.pull))

capacity <- subset(capacity, str_detect(capacity$rankings, 'Seating Capacity:')==TRUE)
capacity <- subset(capacity, str_detect(capacity$rankings, 'Facility Name:')==TRUE)

temp <- sub(".*\r\n", "", capacity$rankings)
tidy <- cbind(tidy, t(as.data.frame(str_split(tidy$extra, 'Facility & Venue:'))))


temp <- str_split(capacity$rankings, '\r\n')


Facility Name:
# write out data ----------------------------------------------------------

write.csv(data, '/Users/majerus/Desktop/thesis_projects/theather/Shabab/data.csv')




# read in scraped data ----------------------------------------------------

messy <- read.csv('/Users/majerus/Desktop/thesis_projects/theather/Shabab/data.csv', row.names=1)

colnames(messy) <- c('id', 'Rankings', 'Season')

# pull out dates 
row3 <- messy[seq(1, nrow(messy), 3), ]
colnames(row3) <- c('id',  'dates',	'Season')

messy <- messy[-seq(1, NROW(messy), by = 3),]
messy$Season <- NULL


# pull out play names
row2 <- messy[seq(1, nrow(messy), 2), ]
row2$id <- NULL
colnames(row2) <- c('play')

messy <- messy[-seq(1, NROW(messy), by = 2),]

# pull out extra info
row1 <- messy
row1$id <- NULL
colnames(row1) <- c('extra')

# cbind data together 
tidy <- cbind(row3, row2, row1)

tidy <- cbind(tidy, t(as.data.frame(str_split(tidy$dates, '-'))))
colnames(tidy) <- c("id",  "dates",    "Season", "play",   "extra",  "start", "end" )
tidy$end <- str_sub(tidy$end, start = 1, end = 9)

tidy$dates <- NULL
tidy$start <- as.Date(tidy$start, "%m/%d/%y")
tidy$end <- as.Date(tidy$end, "%m/%d/%y")

tidy$days <- tidy$end - tidy$start

tidy$extra <- as.character(tidy$extra)

tidy$extra <- str_replace_all(tidy$extra, "[\r\n]", '')
tidy <- cbind(tidy, t(as.data.frame(str_split(tidy$extra, 'Facility & Venue:'))))

tidy$extra <- NULL

colnames(tidy) <- c('id',  'season',	'play',	'start',	'end',	'days',	'drop', 'venue')
tidy$drop <- NULL

write.csv(tidy, '/Users/majerus/Desktop/thesis_projects/theather/Shabab/tidy_data.csv')


tidy <- read.csv('/Users/majerus/Desktop/thesis_projects/theather/Shabab/tidy_data.csv')














tidy$extra <- str_replace_all(tidy$extra, "[^[:alnum:]]", " ")
tidy$extra <- str_replace_all(tidy$extra, "Playwright s", '')
tidy$extra <- str_trim(tidy$extra)




temp <- cbind(tidy, t(as.data.frame(str_split_fixed(tidy$extra, '  ', 2))))



str_split_fixed(tidy$extra, '  ', 2)



gsub( ".*$", "", tidy$extra)
sub("  *$","", tidy$extra, perl=T)

temp <- cbind(tidy, t(as.data.frame(str_split(tidy$extra, '  '))))

str_split_fixed(tidy$extra, '  ', 2)



tidy$extra <- str_replace_all(tidy$extra, ' ', '')




temp <- cbind(tidy, t(as.data.frame(str_split(tidy$extra, 'Lyricist'))))






tidy$extra <- NULL

colnames(tidy) <- c('id',	'Season',	'play',	'start',	'end',	'days',	'drop', 'venue')
tidy$drop <- NULL



Facility & Venue:


y=unlist(strsplit(tidy$extra,'[\r\n]'))
sub('Facility & Venue:',y)


Stage Director(s):




temp <- cbind(tidy, t(as.data.frame(str_split(tidy$extra, 'Playwright'))))


Lyricist(s):


str_replace_all(x, "[\r\n]" , "")


str_replace_all(string=a, pattern=" ", repl="")

temp <- as.data.frame(str_split(tidy$extra, '"[\r\n]"'))


  
  
sapply(tidy, class)



k <- function(dataframe, n)dataframe[seq(n,to=nrow(dataframe),by=n),]




row3 <- messy[seq(1, length(messy), 3)]







messy$element <- rep(c('date', 'play', 'extra'))
messy$count <- rep(1:3)


tidier <- messy %>%
  gather(key, time, -id, -Season)
tidier %>% head(8)

messy$id.unique <- paste(messy$id, messy$Season, messy$count, sep='')

tidy <- 
  messy %>%
  spread(id.unique, Rankings, fill = NA, convert = FALSE, drop = TRUE)


Season
count 


temp <- dcast(messy, id + Season + count~element, value.var="Rankings")

duplicated(messy$id.unique)


, value.var="Rankings"

ls(messy)



temp <- 
reshape(messy, direction = 'wide', idvar = c('id', 'Season', 'count'), timevar = 'element', 
        v.names = 'test_result', sep = "_")




