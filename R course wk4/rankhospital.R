rankhospital <- function(state, outcome, num="best") {
  df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  df.filtered <- df[df$State == state,]   # filter the outcome dataframe by State == state 
  if (nrow(df.filtered) == 0) {
    stop("Invalid state")
  }
  
  if (num=="best") { num <- 1 }

  if (outcome == "heart attack") {
    df.filtered.ranked <- df.filtered[order(as.numeric(df.filtered[,11]),df.filtered[,2]),]
    if (num=="worst") {
      df.filtered[which.max(as.numeric(df.filtered[,11])),2]
    }
    else {
      df.filtered.ranked[num,2]
    }
  }
  else if (outcome == "heart failure") {
    df.filtered.ranked <- df.filtered[order(as.numeric(df.filtered[,17]),df.filtered[,2]),]
    if (num=="worst") {
      df.filtered[which.max(as.numeric(df.filtered[,17])),2]
    }
    else {
      df.filtered.ranked[num,2]
    }
  }
  else if (outcome == "pneumonia") {
    df.filtered.ranked <- df.filtered[order(as.numeric(df.filtered[,23]),df.filtered[,2]),]
    if (num=="worst") {
      df.filtered[which.max(as.numeric(df.filtered[,23])),2]
    }
    else {
      df.filtered.ranked[num,2]
    }
  }
  else {
    stop("Invalid Outcome")
  }  
}