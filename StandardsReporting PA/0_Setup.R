################################################################################
# Set here all necessary definitions                                        ####
################################################################################
# Set data location dir
dataLoc <- "Users/mecoffee/Documents/GitHub/AutoReport-Standards-Reporting/StandardsReporting"

# Set state 2-letter abbreviation
stateAbbr <- 'KY'

# Set assets definition file name
assetsFile <- "Assets_Definitions.xlsx"

################################################################################
# DO NOT EDIT BELOW THIS POINT, LEST YOU REALLY KNOW WHAT YOU ARE DOING!!!  ####
################################################################################
# List needed packages
pkgs <- c('flextable', 'here', 'kableExtra',
          'knitr', 'markdown', 'readxl','rprojroot')

# Install whatever is not installed
instPkgs <- installed.packages()
notInst  <- !pkgs %in% instPkgs[,"Package"]
notInst  <- pkgs[notInst]

if(length(notInst) >= 1){
  sapply(notInst, FUN = function(x) install.packages(x, dependencies = TRUE))
}

# Now load them
lapply(pkgs, require, character.only = TRUE)
rm(instPkgs, notInst, pkgs)

# Source supporting functions
source(file.path(here(), "supportFuncs.R"))

# List data input files
dataFiles <- list.files(path = dataLoc,
                        pattern = paste0(stateAbbr, "_.+xlsx"))

# Set name of sheets that can be imported. Each sheet matches a sub-domain,
# such as "ESS1"
sheetsToKeep <- c("ESS1", "ESS2", "ESS3")

# Set name of columns to keep. We are keeping only the columns that are
# necessary for the final reporting table.
colstoKeep <- c("Level", "Domain", "Number", "PE",
                "CS", "AB", "SEP", "DCI", "CCC")

# Load assets definition
assetsDefs <- as.data.frame(read_xlsx(file.path(here(), assetsFile)))
assetsDefs$merge_to <- as.numeric(assetsDefs$merge_to)
