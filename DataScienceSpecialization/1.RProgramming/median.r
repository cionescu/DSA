# Calculate median for the weights column for all csv files in dir

wm <- function(dir, day) {
  files <- list.files(dir, full.names = T) # list of files with full path
  data <- data.frame() # empty data frame
  for (file in files) {
    data <- rbind(data, read.csv(file))
  }
  matching_data <- subset(data$Weight, data$Day == day)
  median(matching_data, na.rm = T)
}
