rankall <- function(outcome, num = "best") {
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

  valid_states <- sort(unique(data[, "State"]))
  valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
  if (!is.element(state, valid_states)) stop("invalid state")
  if (!is.element(outcome, valid_outcomes)) stop("invalid outcome")

  # Keep only the columns we care about
  data <- data[, c(2, 7, 11, 17, 23)]
  colnames(data) <- c("name", "state_name", "heart attack", "heart failure", "pneumonia")
  data <- data[!data[,outcome] == "Not Available",]
  data[, outcome] <- as.numeric(data[, outcome])
  data <- data[order(data$state_name, data[, outcome], data$name),]

  result <- data.frame()
  for (state in valid_states) {
    data_for_state <- data[data$state_name == state,]
    count <- nrow(data_for_state)
    if (num == "best") {
      result <- rbind(result, data.frame(data_for_state[1, "name"], state))
    } else if (num == "worst") {
      result <- rbind(result, data.frame(data_for_state[count, "name"], state))
    } else {
      result <- rbind(result, data.frame(data_for_state[num, "name"], state))
    }
  }
  colnames(result) <- c("hospital", "state")
  result
}
