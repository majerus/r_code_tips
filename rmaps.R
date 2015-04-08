# http://rmaps.github.io/blog/posts/animated-choropleths/ 
#require(devtools)
#install_github('ramnathv/rCharts@dev')
#install_github('ramnathv/rMaps')

library(rMaps)
library(rCharts)
library(reshape2)

# change file path to match location on your machine
folder <- '/Users/majerus/Desktop/2014 projects/blog/post1_logs/'

# change file name to match name on your machine 
file <- 'state_enrollment_reed.csv'

# read in enrollment data 
state <- read.csv(paste(folder, file, sep=''))

# rename columns for reshape
colnames(state) <- c('State', '2007', '2008', '2009', '2010', '2011', '2012', '2013')

# reshape data from wide to long 
state_long <- melt(state)

# rename columns
colnames(state_long) <- c('State', 'Year', 'Students')

# check class of each variable
sapply(state_long, class)

# convert year to numeric 
state_long$Year <- as.integer(as.character(state_long$Year))

# convert state to character 
state_long$State <- as.character(state_long$State)

# convert students to numeric 
state_long$Students <- as.numeric(state_long$Students)

# change stage names to abbr. 
state_long$abr <- state.abb[match(as.character(state_long$State), state.name)]

# log 
state_long$Students_log <- ifelse(state_long$Students==0, 0, log(state_long$Students))




# no students from 
map <- 
ichoropleth(Students ~ abr,
            data = state_long,
            ncuts = 1,
            animate = 'Year', 
            play = TRUE, 
            legend = FALSE
)

map$save('/Users/majerus/Desktop/2014 projects/blog/post1_logs/rmaps/no_students.html', cdn = TRUE)



ichoropleth(Students ~ abr,
            data = state_long,
            ncuts = 5,
            animate = 'Year', 
            play = TRUE, 
            legend = FALSE
)

slider <- 
MYchoropleth(Students ~ abr,
            data = state_long,
            animate = 'Year', 
            legend = TRUE
)
slider$save('/Users/majerus/Desktop/2014 projects/blog/post1_logs/rmaps/slider.html', cdn = TRUE)


play <- 
  MYchoropleth(Students ~ abr,
               data = state_long,
               animate = 'Year', 
               legend = FALSE, 
               play=TRUE
  )
play$save('/Users/majerus/Desktop/2014 projects/blog/post1_logs/rmaps/play.html', cdn = TRUE)





hist(state_long$Students_log)







MYchoropleth <- function(x, data, pal = "Blues", ncuts = 5, animate = NULL, play = F, map = 'usa', legend = TRUE, labels = TRUE, ...){
  d <- Datamaps$new()
  fml = lattice::latticeParseFormula(x, data = data)
  data = transform(data, 
                   fillKey = cut(
                     fml$left, 
                     c(-1,0, 5,10,25,50,100),
                     ordered_result = TRUE
                   )
  )
  fillColors =  c('white', RColorBrewer::brewer.pal(5, 'YlOrRd'))
  d$set(
    scope = map, 
    fills = as.list(setNames(fillColors, levels(data$fillKey))), 
    legend = legend,
    labels = labels,
    ...
  )
  if (!is.null(animate)){
    range_ = summary(data[[animate]])
    data = dlply(data, animate, function(x){
      y = toJSONArray2(x, json = F)
      names(y) = lapply(y, '[[', fml$right.name)
      return(y)
    })
    d$set(
      bodyattrs = "ng-app ng-controller='rChartsCtrl'"  
    )
    d$addAssets(
      jshead = "http://cdnjs.cloudflare.com/ajax/libs/angular.js/1.2.1/angular.min.js"
    )
    if (play == T){
      d$setTemplate(chartDiv = sprintf("
                                       <div class='container'>
                                       <button ng-click='animateMap()'>Play</button>
                                       <div id='{{chartId}}' class='rChart datamaps'></div>  
                                       </div>
                                       <script>
                                       function rChartsCtrl($scope, $timeout){
                                       $scope.year = %s;
                                       $scope.animateMap = function(){
                                       if ($scope.year > %s){
                                       return;
                                       }
                                       map{{chartId}}.updateChoropleth(chartParams.newData[$scope.year]);
                                       $scope.year += 1
                                       $timeout($scope.animateMap, 1000)
                                       }
                                       }
                                       </script>", range_[1], range_[6])
      )
      
    } else {
      d$setTemplate(chartDiv = sprintf("
                                       <div class='container'>
                                       <input id='slider' type='range' min=%s max=%s ng-model='year' width=200>
                                       <div id='{{chartId}}' class='rChart datamaps'></div>  
                                       </div>
                                       <script>
                                       function rChartsCtrl($scope){
                                       $scope.year = %s;
                                       $scope.$watch('year', function(newYear){
                                       map{{chartId}}.updateChoropleth(chartParams.newData[newYear]);
                                       })
                                       }
                                       </script>", range_[1], range_[6], range_[1])
      )
    }
    d$set(newData = data, data = data[[1]])
    
  } else {
    d$set(data = dlply(data, fml$right.name))
  }
  return(d)
}




