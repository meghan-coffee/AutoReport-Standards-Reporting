# Get the data, clean it up, reshape it

# First figure out what sheets are present in the workbook
# Get rid of sheets without actual data

# ADD HERE LOOP OVER EACH FILE                                              ####
workBookSheets <- excel_sheets(dataFiles)
workBookSheets <- workBookSheets[workBookSheets %in% sheetsToKeep]

# Create empty data.frame that will hold reshaped and ready to go data
readyData <- data.frame(col1 = character(),
                        col2 = character(),
                        col3 = character())

# Loop over each worksheet, reshape the data, and put in a table ready to
# format. Save each sheet inside the 'processedWorkBook' list

processedWorkBook <- list()

for(sheet in workBookSheets){
  tempData <- read_xlsx(dataFiles, sheet = sheet)
  tempData <- tempData[, colstoKeep]

  # Redo the PE to get it ready for use on the table
  tempData$PE_redone <- paste0(tempData$Level, ".",
                               substr(tempData$Domain, 1 , nchar(tempData$Domain) -1 ), ".",
                               substr(tempData$Domain, nchar(tempData$Domain),
                                      nchar(tempData$Domain) ), ".",
                               tempData$Number, " ",
                               tempData$PE)

  # Now turn each row to a set of five rows, that can then easily be reformatted
  # using kableExtra
  out <- do.call(rbind, apply(tempData, 1, recastRow, simplify = FALSE))
  row.names(out) <- NULL

  # Put it back on the workBook sheet
  processedWorkBook[[sheet]] <- out
  rm(tempData, out)
}
rm(sheet)
