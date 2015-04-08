# http://www.r-bloggers.com/the-openstreetmap-package-opens-up/
# http://rpubs.com/RobinLovelace/12696 
library(osmar)
library(OpenStreetMap)

src <- osmsource_api()
bb <- center_bbox(-122.688068, 45.521032, 1000, 1000)
ptown <- get_osm(bb, source = src)
plot(ptown)
points(-1.53492, 53.81934, col = "red", lwd = 5)


bikePaths <- find(ptown, way(tags(k == "bicycle" & v == "yes")))
bikePaths <- find_down(ptown, way(bikePaths))
bikePaths <- subset(ptown, ids = bikePaths)
plot(ptown)
plot_ways(bikePaths, add = T, col = "red", lwd = 3)


library(ggmap)

stores <- data.frame(name=c("Commercial","Union","Bedford"),
                     longitude=c(-70.25042295455933,-70.26050806045532,-70.27726650238037),
                     latitude=c(43.657471302616806,43.65663299041943,43.66091757424481))
location = c(-70.2954, 43.64278, -70.2350, 43.68093)

# Fetch the map
portland = get_map(location = location, source = "osm")

# Draw the map
portlandMap = ggmap(portland)

# Add the points layer
portlandMap = portlandMap + geom_point(data = stores, aes(x = longitude, y = latitude), size = 5)

# Add the labels
portlandMap + geom_text(data = stores, aes(label = name, x = longitude+.001, y = latitude), hjust = 0)
