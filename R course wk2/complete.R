complete <- function(dir,id) {
  count <- 1
  df <- data.frame( matrix(nrow = length(id), ncol = 2 ) )
  names(df) <- c("id","nobs")
  for (i in id) {
    filename <- if (i<10) {paste0("0","0",i)} else if (i <100) {paste0("0",i)} else {as.character(i)}
    filename <- paste0(dir,"/",filename,".csv")
    data <- read.csv(filename,header=TRUE)
    df[count,1] <- i
    df[count,2] <- sum(!is.na(data$nitrate) & !is.na(data$sulfate))
    count <- count+1
  }
  df
}