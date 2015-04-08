# survey url: https://docs.google.com/forms/d/1zLVTb8dix0tiWr0sVuRQAGsfjdMfQ5A5PmK_wDn9e7U/viewform?usp=send_form 

library(XML)
library(httr)

url <- "https://docs.google.com/spreadsheets/d/1CVQqfIEkbt9KUi3oxgE8_iQQnbN7CBIDqXqtNYSfsiw/pubhtml?gid=594213668&single=true"

readSpreadsheet <- function(url, sheet = 1){
  library(httr)
  r <- GET(url)
  html <- content(r)
  sheets <- readHTMLTable(html, header=FALSE, stringsAsFactors=FALSE)
  df <- sheets[[sheet]]
  dfClean <- function(df){
    nms <- t(df[1,])
    names(df) <- nms
    df <- df[-1,-1] 
    df <- df[df[,1] != "",]   ## only select rows with time stamps
    row.names(df) <- seq(1,nrow(df))
    df
  }
  dfClean(df)
}

df <- readSpreadsheet(url)




