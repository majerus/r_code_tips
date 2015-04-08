# Reference 
# http://www.r-bloggers.com/how-to-source-an-r-script-automatically-on-a-mac-using-automator-and-ical/
# http://www.engadget.com/2013/03/18/triggering-applescripts-from-calendar-alerts-in-mountain-lion/
# http://willchernoff.com/2013/04/23/periodically-run-an-r-script-as-a-background-process-using-launchd-under-osx/

library(knitr)
library(markdown)
library(rmarkdown)
library(stringr)
library(ggmap)

setwd('/Users/majerus/Desktop/R/auto_reporting/test/reports/')

## knitr loop
mtcars <- mtcars[c(1,5),]
rownames(mtcars) <- str_replace_all(rownames(mtcars), ' ', '')

map <-
  get_map(location="United States",
          source= 'google', maptype = 'terrain', color='bw', zoom=4) 
  

for (car in unique(rownames(mtcars))){
  # knit2pdf("testingloops.Rnw", output=paste0('report_', hosp, '.tex'))

  #knit("/Users/majerus/Desktop/R/auto_reporting/test/reports/r_script_pdf.Rmd")
  
  # output folders 
  folder <- 
    if(mtcars$cyl[rownames(mtcars)==car] == 4) {"/Users/majerus/Desktop/R/auto_reporting/test/reports/cyl4/"}
    else if(mtcars$cyl[rownames(mtcars)==car] == 6) {"/Users/majerus/Desktop/R/auto_reporting/test/reports/cyl6/"}
    else {"/Users/majerus/Desktop/R/auto_reporting/test/reports/cyl8/"}
  
  render(input = 'r_script_pdf.Rmd',
         output_file = paste("test_report_", car, Sys.Date(), ".pdf", sep=''),
         output_dir = folder             
         )
  


# rmarkdown::render(input = "/Users/majerus/Desktop/R/auto_reporting/test/r_script_pdf.Rmd", 
#           output_format = "pdf_document",
#           output_file = paste("test_report_", car, Sys.Date(), ".pdf", sep=''),
#           output_dir = "/Users/majerus/Desktop/R/auto_reporting/test/reports")
#   
}



# quit(save="no")

# rmarkdown::render('/Users/majerus/Desktop/R/auto_reporting/test/r_script.Rmd', 
#                   output_file =  paste("report_", Sys.Date(), ".html", sep=''), 
#                   output_dir = '/Users/majerus/Desktop/R/auto_reporting/test/reports')
# 



# 
# knit("/Users/majerus/Desktop/R/auto_reporting/test/r_script.Rmd")
# 
# rmarkdown::render(input = "/Users/majerus/Desktop/R/auto_reporting/test/r_script.Rmd", 
#        output_format = "pdf_document",
#        output_file = paste("test_report_", Sys.Date(), ".pdf", sep=''),
#        output_dir = "/Users/majerus/Desktop/R/auto_reporting/test/")
# 
# 
# # render(input, output_format = NULL, output_file = NULL, output_dir = NULL,
# #        output_options = NULL, intermediates_dir = NULL,
# #        runtime = c("auto", "static", "shiny"),
# #        clean = TRUE, envir = parent.frame(), quiet = FALSE,
# #        encoding = getOption("encoding"))
# 
# 
# 
# ## for html 
# markdownToHTML("r_script.md", 
#                paste("/Users/majerus/Desktop/R/auto_reporting/test/reports/test_report_", Sys.Date(), ".html", sep='')
#                #stylesheet="C:/Users/Rich/Dropbox/tca/Admissions/FM/Project12/yield_model_2014/Dashboard/dashboardcss.css"
# )
