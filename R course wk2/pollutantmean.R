pollutantmean <- function (dir, pol, id=1:332) {
  ss <- c()
  for (i in id) {
    filename <- if (i<10) {paste0("0","0",i)} else if (i <100) {paste0("0",i)} else {as.character(i)}
    filename <- paste0(dir,"/",filename,".csv")
    data <- read.csv(filename,header=TRUE)
    ss <- append(ss,data[,pol])
  }
  mean(ss,na.rm=TRUE)
}