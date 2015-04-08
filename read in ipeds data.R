install.packages(“devtools”)

require(devtools)
install_github('ipeds','jbryer')

library(ipeds)

ls('package:ipeds')

data(surveys)
names(surveys)

downloadAllSurveys(2013)

