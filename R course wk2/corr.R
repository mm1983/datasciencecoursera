corr <- function(dir,threshold=0) {
  id <- 1:332
  cr <- c()
  df <- data.frame( matrix(nrow = length(id), ncol = 2 ) )
  names(df) <- c("id","nobs")
  for (i in id) {
    filename <- if (i<10) {paste0("0","0",i)} else if (i <100) {paste0("0",i)} else {as.character(i)}
    filename <- paste0(dir,"/",filename,".csv")
    data <- read.csv(filename,header=TRUE)
    data_red <- data[(!is.na(data$nitrate) & !is.na(data$sulfate)),c("sulfate","nitrate")]
    if (nrow(data_red) > threshold) {
      cr <- append(cr,cor(data_red[,"sulfate"],data_red[,"nitrate"]))
    }
  }
  cr
}