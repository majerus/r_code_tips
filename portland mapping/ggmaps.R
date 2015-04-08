# open street map of reed 

gps <- read.csv("/Users/majerus/Desktop/2014 projects/portland mapping/elwyn.csv", 
                header = TRUE)

library(ggmap)

## Google Maps 

# satelite 
mapImageData <- get_map(location = c(lon = mean(gps$Longitude), 
                                     lat = 33.824),
                        color = "color", # or bw
                        source = "google",
                        maptype = "satellite",
                        zoom = 17)


# terrain 
mapImageData <- get_map(location = c(lon = mean(gps$Longitude), 
                                     lat = 33.824),
                        color = "color", # or bw
                        source = "google",
                        maptype = "terrain",
                        zoom = 17)


# roadmap 
mapImageData <- get_map(location = c(lon = mean(gps$Longitude), 
                                     lat = 33.824),
                        color = "color", # or bw
                        source = "google",
                        maptype = "roadmap",
                        zoom = 17)

# hybrid 
mapImageData <- get_map(location = c(lon = mean(gps$Longitude), 
                                     lat = 33.824),
                        color = "color", # or bw
                        source = "google",
                        maptype = "hybrid",
                        zoom = 17)

## open street map
mapImageData <- get_map(location = c(lon = mean(gps$Longitude), 
                                     lat = 33.824),
                        color = "color", # or bw
                        source = "osm",
                        zoom = 17)


## stamen

# terrain 
mapImageData <- get_map(location = c(lon = mean(gps$Longitude), 
                                     lat = 33.824),
                        color = "color", # or bw
                        source = "stamen",
                        maptype = "terrain",
                        zoom = 17)



pathcolor <- "#F8971F"

ggmap(mapImageData,
      extent = "device", # "panel" keeps in axes, etc.
      ylab = "Latitude",
      xlab = "Longitude",
      legend = "right") + 
  
  geom_path(aes(x = Longitude, # path outline
                y = Latitude),
            data = gps,
            colour = "black",
            size = 2) +
  
  geom_path(aes(x = Longitude, # path
                y = Latitude),
            colour = pathcolor,
            data = gps,
            size = 1.4) # +
# labs(x = "Longitude",
#   y = "Latitude") # if you do extent = "panel"


mapImageData <- get_map(location = c(lon = -122.630091, 
                                     lat = 45.480740),
                        color = "color", # or bw
                        source = "google",
                        maptype = "satellite",
                        zoom = 17)


ls(data)
attach(mydata)
plot(x, y) # scatterplot
identify(x, y, labels=row.names(mydata)) # identify points 
coords <- locator(type="l") # add lines
coords # display list

ls(data)
attach(mydata)
plot(data$admit_rate, data$grad_rate) # scatterplot
identify(data$admit_rate, data$grad_rate, labels=row.names(data)) # identify points 
coords <- locator(type="l") # add lines
coords # display list


