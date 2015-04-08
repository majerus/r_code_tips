
# libraries ---------------------------------------------------------------

# install irr library if not already installed 
if( !is.element("irr", installed.packages()[,1]) )
  install.packages("irr")

#Load the irr library 
library(irr)  

# read in data and clean dataframe ----------------------------------------

# read in full data file (update file path to match data location on your computer)
original.data <- read.csv('/Users/majerus/Desktop/linguistics_data.csv')

# drop summary statistics that are included in orginal file 
data <- subset(original.data, !is.na(original.data$Test.Number))
data$Average.Score..RA   <- NULL
data$Average.Score..Participants	<- NULL
data$Difference..RA...Participants.	<- NULL
data$X <- NULL

# drop extra vars 
data$Speaker <- NULL
data$Speaker.From <- NULL
data$Bows..Horizon <- NULL
data$Test.Number  <- NULL

# make File name variable the rownames so that it is preserved as columns names once df is transposed
rownames(data) <- data$File.Name
data$File.Name <- NULL

# calculate inter-rater reliability between Molly and Dean using Cohen's Kappa----------------

ratings <- as.data.frame(cbind(Dean = data$RA..Dean, Molly = data$RA..Molly))

# kappa2(ratings, weight = c("unweighted", "equal", "squared"), sort.levels = FALSE)
kappa2(ratings)



# calculate inter-rater reliability between all raters  -------------------

# transpose df 
data.t <- as.data.frame(t(data))

# check class of each variable 
sapply(data.t, class)

# convert df.t to matrix 
matrix <- data.matrix(data.t)


# Krippendorff ’s alpha

# kripp.alpha(x, method=c("nominal","ordinal","interval","ratio"))  (need to select right data level for method)
kripp.alpha(matrix, method=c("ratio"))
kripp.alpha(matrix, method=c("nominal"))


# Light’s Kappa 

# transform data to factors for s Light’s Kappa which requires categorical data 
sapply(data, class)
data.factors <- as.data.frame(sapply(data, as.factor))
kappam.light(data.factors)


# Fleiss’ Kappa 

# Fleiss’ Kappa for m raters with categorical data 
kappam.fleiss(data.factors, detail = TRUE, exact = FALSE)
kappam.fleiss(data.factors, detail = TRUE)


