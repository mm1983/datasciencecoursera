rankall <- function(outcome, num="best") {
  df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  if (outcome == "heart attack") { outcome.int = 11 }
  else if (outcome == "heart failure") { outcome.int = 17 }
  else if (outcome == "pneumonia") { outcome.int = 23 }
  else { stop("Invalid Outcome") }      
  
  if (num=="best") { num <- 1 }
  
  StateList <- unique(df$State)
  StateList <- sort(StateList)
  FinalList = data.frame(matrix(ncol=2, nrow=0))
  colnames(FinalList) <- c("hospital","state")
  for (i in StateList) {
    df.filtered <- df[df$State == i,]   # filter the outcome dataframe by State == state 
    df.filtered.ranked <- df.filtered[order(as.numeric(df.filtered[,outcome.int]),df.filtered[,2]),]
    if (num=="worst") {
      FinalList[nrow(FinalList) + 1,] <- c(df.filtered[which.max(as.numeric(df.filtered[,outcome.int])),2],i)
    }
    else {
      FinalList[nrow(FinalList) + 1,] <- c(df.filtered.ranked[num,2],i)
    }
  }
  FinalList
}