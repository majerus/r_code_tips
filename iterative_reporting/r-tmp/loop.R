# load libraries
library(tidyverse)
library(rmarkdown)
library(randomNames)

# create sample data
tmp <- tibble(
  doc = c(rep("doc1", 5), 
          rep("doc2", 5)),
  name = randomNames(10)
)


for (i in unique(tmp$doc)){
  
  rmarkdown::render(input = paste0(getwd(), "/report.rmd"),
                    output_file = paste0("test_report_", i, "_", Sys.Date(), ".docx", sep=''),
                    output_dir = paste0(getwd(), "/reports/")
  )
  
}

