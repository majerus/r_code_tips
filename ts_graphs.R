library(ggplot2)
library(dplyr)
library(lubridate)
library(xts)
library(stringr)
library(reshape2)
library(plyr)
library(grid)


data <- read.csv('/Users/majerus/Desktop/thesis_projects/makoto/data.csv')
data$X <- NULL
data$Carus.Spangler.Rd. <- NULL
#data[is.na(data)] <- 0

data <- dplyr::rename(data, time = Date...Time)

# id 
# data$id <- id(data[c("time")])
data <- mutate(data, id = rownames(data))              
 


data$time <- str_replace(data$time, 'AM', '')
data$time <- str_replace(data$time, 'PM', '')
data$time <- str_trim(data$time, 'both')
data$time <- str_replace(data$time, '2013', '13')
data$time <- str_replace(data$time, '2014', '13')
data$time <- str_replace(data$time, '2015', '13')
#data$time <- str_replace(data$time, '2013', '13')
#data$time <- str_replace(data$time, '24:00', '23:59')

#data$time <- strptime(data$time, '%m/%d/%y  %H:%M')

data$Albany.Calapooia.School  <- as.numeric(data$Albany.Calapooia.School )
data$Beaverton.Highland.Park	<- as.numeric(data$Beaverton.Highland.Park)
data$Corvallis.Circle.Blvd	<- as.numeric(data$Corvallis.Circle.Blvd)
data$Hillsboro.Hare.Field	<- as.numeric(data$Hillsboro.Hare.Field)
data$Portland.SE.Lafayette <- as.numeric(data$Portland.SE.Lafayette)
data$Salem.State.Hospital	<- as.numeric(data$Salem.State.Hospital)
data$Sauvie.Island	<- as.numeric(data$Sauvie.Island)
data$Sweet.Home.Fire.Department <- as.numeric(data$Sauvie.Island)

long_data <- melt(data, id=c("id", "time"), na.rm=TRUE)

long_data$time <- strptime(long_data$time, '%m/%d/%y  %H:%M')

long_data$log <- log(long_data$value)


long_data$Date<-with(long_data,as.Date(time, format = "%Y/%m/%d"))
graph <- ddply(long_data,.(variable, Date),summarise, ave=mean(value))

p <- 
ggplot(aes(Date, ave, colour = variable), data = graph) + 
  geom_line()  +
  ggtitle("Average by Day")

p <- 
p + annotate("text", x = as.Date(Inf), y = -Inf, label = "Created by Rich Majerus",
             hjust=1.1, vjust=-1.1, col="white", cex=6,
             fontface = "bold", alpha = 0.8) +
  facet_wrap( ~  variable, ncol=3) 

ggsave(p, file="/Users/majerus/Desktop/thesis_projects/makoto/ts.pdf", scale=2)
