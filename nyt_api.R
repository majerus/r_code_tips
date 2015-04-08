
devtools::install_github("ropengov/rtimes")
library(rtimes)
#https://github.com/ropengov/rtimes
#http://developer.nytimes.com/docs/read/article_search_api_v2

options(nytimes_as_key = "9e53c145601542a18b1b74088644c1e9:4:65632398")
out <- as_search(q="college", begin_date = "20150121", end_date = '20150128')
out$data[1:100]


options(nytimes_as_key = "YOURKEYHERE")

getwd()

