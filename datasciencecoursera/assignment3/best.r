best = function(state, outcome = c("heart attack", "heart failure", "pneumonia")) {
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
  best_outcome <- data_for_state[order(data_for_state[, outcome], data_for_state[,"name"])[1],]
  best_outcome[1, "name"]
}
