# Reference 
# http://www.r-bloggers.com/how-to-source-an-r-script-automatically-on-a-mac-using-automator-and-ical/
# http://www.engadget.com/2013/03/18/triggering-applescripts-from-calendar-alerts-in-mountain-lion/

library(knitr)
library(markdown)
library(rmarkdown)


## knitr loop

mtcars <- mtcars[1:2,]

map <-
  get_map(location="United States",
          source= 'google', maptype = 'terrain', color='bw', zoom=4) 

for (car in unique(rownames(mtcars))){
  rmarkdown::render('/Users/majerus/Desktop/R/auto_reporting/test/r_script.Rmd', 
                   output_file =  paste("report_", car, '_', Sys.Date(), ".html", sep=''), 
                   output_dir = '/Users/majerus/Desktop/R/auto_reporting/test/reports')
# for pdf reports  
#   rmarkdown::render(input = "/Users/majerus/Desktop/R/auto_reporting/test/r_script_pdf.Rmd", 
#           output_format = "pdf_document",
#           output_file = paste("test_report_", car, Sys.Date(), ".pdf", sep=''),
#           output_dir = "/Users/majerus/Desktop/R/auto_reporting/test/reports")
  
}


