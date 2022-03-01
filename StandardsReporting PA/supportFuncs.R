# Recast each standard row to a mini data frame
recastRow <- function(someRow){
  row1 <- as.character(c(someRow["Domain"], rep(NA_character_, 2), use.names = FALSE))
  row2 <- as.character(someRow["Core Idea"], rep(NA_character_, 2))
  row3 <- as.character(someRow["PE"], rep(NA_character_, 2))
  row4 <- as.character(someRow["CS"], rep(NA_character_, 2))
  row5 <- as.character(someRow["AB"], rep(NA_character_, 2))
  # row6 <- c("Science and Engineering Practice", "Disciplinary Core Ideas",
  #           "Crosscutting Concepts")
  row6 <- as.character(c(someRow["SEP"], someRow["DCI"], someRow["CCC"]))
  row7 <- as.character(c(someRow["PA Context"], rep(NA_character_, 2), use.names = FALSE))
  row8 <- as.character(someRow["PA Career Ready Skills"], rep(NA_character_, 2))
  row9 <- as.character(c(someRow["AFNR"], someRow["ISTE"], someRow["ELA"], someRow["NAAEE"],
                         someRow["Math"], someRow["Social Studies"], someRow["ITEEA"]))


  out <- as.data.frame(rbind(row1, row2, row3, row4, row5, row6, row7, row8, row9))
  rownames(out) <- NULL
  return(out)
}

# Format row 1
