#' Calculate Proportions of Hauntings by Location
#'
#' This function takes a data frame of haunted locations and, optionally, a specified city,
#' then calculates the proportion of hauntings for each location. If no city is specified,
#' it calculates proportions for all cities.
#'
#' @param data A data frame containing haunted location information, with columns for `city` and `location`.
#' @param city (Optional) A character string specifying the city for which to calculate haunting proportions.
#' If NULL, it calculates proportions across all cities.
#'
#' @return A data frame with columns:
#'   \describe{
#'     \item{location}{The haunted location}
#'     \item{city}{The specified city (if provided)}
#'     \item{proportion}{The proportion of hauntings at each location, summing to 1 within each city}
#'   }
#'
#' @examples
#' # Simple example data
#' haunted_data <- data.frame(
#'   city = c("New York", "New York", "Boston", "Boston", "Boston"),
#'   location = c("Castle", "Mansion", "Cemetery", "Old House", "Tunnel")
#' )
#'
#' # Calculate proportions for all cities
#' location_proportions(haunted_data)
#'
#' # Calculate proportions for a specific city
#' location_proportions(haunted_data, city = "Boston")
#'
#' @export
location_proportions <- function(data, city = NULL) {
  if (!"city" %in% colnames(data) || !"location" %in% colnames(data)) {
    stop("Data frame must contain 'city' and 'location' columns.")
  }

  if (!is.null(city)) {
    if (!city %in% data$city) stop("Specified city not found in data.")
    data <- data %>% filter(city == city)
  }

  data %>%
    count(city, location) %>%
    group_by(city) %>%
    mutate(proportion = n / sum(n)) %>%
    select(city, location, proportion)
}

