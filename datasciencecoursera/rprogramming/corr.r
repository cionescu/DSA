corr <- function(directory, threshold = 0) {
  correlations <- c()
  for (file in list.files(directory, full.names=TRUE)) {
    file <- read.csv(file)
    complete_cases <- file[complete.cases(file),]
    if (nrow(complete_cases) > threshold) {
      correlations <- c(correlations, cor(complete_cases$sulfate, complete_cases$nitrate))
    }
  }
  correlations
}
