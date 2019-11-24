best <- function(state,outcome) {
  df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  df.filtered <- df[df$State == state,]   # filter the outcome dataframe by State == state 
  if (nrow(df.filtered) == 0) {
    stop("Invalid state")
    }

  df.filtered <- df.filtered[order(df.filtered$Hospital.Name),]
  
  # for each outcome “heart attack”, “heart failure”, or “pneumonia” find the hospital with minumum 30-day death rate
  if (outcome == "heart attack") {
    df.filtered[which.min(as.numeric(df.filtered[,11])),2]
  }
  else if (outcome == "heart failure") {
    df.filtered[which.min(as.numeric(df.filtered[,17])),2]
  }
  else if (outcome == "pneumonia") {
    df.filtered[which.min(as.numeric(df.filtered[,23])),2]
  }
  else {
    stop("Invalid Outcome")
  }
}