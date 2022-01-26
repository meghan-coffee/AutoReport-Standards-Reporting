# Recast each standard row to a mini data frame
recastRow <- function(someRow){
  row1 <- as.character(c(someRow["PE_redone"], rep(NA_character_, 2), use.names = FALSE))
  row2 <- as.character(someRow["CS"], rep(NA_character_, 2))
  row3 <- as.character(someRow["AB"], rep(NA_character_, 2))
  row4 <- c("Science and Engineering Practice", "Disciplinary Core Ideas",
            "Crosscutting Concepts")
  row5 <- as.character(c(someRow["SEP"], someRow["DCI"], someRow["CCC"]))

  out <- as.data.frame(rbind(row1, row2, row3, row4, row5))
  rownames(out) <- NULL
  return(out)
}

# Format row 1
