complete <- function(directory, id = 1:332) {
  data <- data.frame()
  for (i in id) {
    file_name <- str_pad(i, 3, side='left', pad='0')
    file <- read.csv(str_interp("${directory}/${file_name}.csv"))
    obs <- subset(file, !is.na(file$sulfate) & !is.na(file$nitrate))
    data <- rbind(data, c(i, nrow(obs)))
  }
  colnames(data) <- c('id', 'nobs')
  data
}
