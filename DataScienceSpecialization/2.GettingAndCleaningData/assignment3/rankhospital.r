rankhospital <- function(state, outcome, num = "best") {
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

  valid_states <- unique(data[, "State"])
  valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
  if (!is.element(state, valid_states)) stop("invalid state")
  if (!is.element(outcome, valid_outcomes)) stop("invalid outcome")

  # Keep only the columns we care about
  data <- data[, c(2, 7, 11, 17, 23)]
  colnames(data) <- c("name", "state_name", "heart attack", "heart failure", "pneumonia")
  data_for_state <- subset(data, state_name == state)
  for (possible_outcome in valid_outcomes) {
    data_for_state[, possible_outcome] = as.numeric(gsub("Not Available", "", data_for_state[, possible_outcome]))
  }

  sorted_by_outcome <- data_for_state[order(data_for_state[, outcome], data_for_state[,"name"]),]
  sorted_by_outcome <- subset(sorted_by_outcome, !is.na(sorted_by_outcome[, outcome]))
  results_count <- nrow(sorted_by_outcome)

  if (is.numeric(num) && num > results_count) return(NA)
  if (is.numeric(num)) return(sorted_by_outcome[num, "name"])
  if (is.character(num) && num == "best") return(sorted_by_outcome[1, "name"])
  if (is.character(num) && num == "worst") return(sorted_by_outcome[results_count, "name"])
  stop("Don't know how to handle num = ", num)
}
