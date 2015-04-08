# install.packages("devtools")
# install_github("ropensci/plotly")

library(devtools)
library(plotly)

set_credentials_file("richmajerus", "kg3334gw0l")


ggiris <- qplot(Petal.Width, Sepal.Length, data = iris, color = Species)
ggiris

py <- plotly()
r <- py$ggplotly(ggiris)

r$response$url


# example 2 
py <- plotly()

data <- list(
  list(
    x = c(0, 2, 4), 
    y = c(0, 4, 2), 
    type = "scatter"
  )
)
response <- py$plotly(data, kwargs=list(filename="privacy-false", world_readable=FALSE, fileopt="overwrite"))
url <- response$url
url


# example 3

mpg <-
  ggplot(mtcars, aes(x=mpg)) + 
  geom_histogram(color="dark blue", size=1, fill="light blue") + # change to geom_density for density plot 
  ggtitle("Kernal Density of MPG") + 
  theme_classic()


py <- plotly()
r <- 
  py$ggplotly(mpg, 
              kwargs=list(filename='same plot',
                               fileopt='overwrite'))
              

r$response$url
