library('stringr')

pollutantmean <- function(directory, pollutant, id=1:332) {
  data <- data.frame()
  for (i in id) {
    file_name <- str_pad(i, 3, side='left', pad='0')
    file <- read.csv(str_interp("${directory}/${file_name}.csv"))
    data <- rbind(data, file)
  }
  mean(data[, pollutant], na.rm=T)
}
