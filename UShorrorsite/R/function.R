
#' Calculate Proportions of Hauntings by Location
#'
#' @description This function takes a data frame of haunted locations
#' and optionally a specified city, then calculates the proportion of hauntings
#' for each location. If no city is specified, it calculates proportions for all cities.
#'
#' @param data A data frame containing haunted location information, with columns for `city` and `location`.
#' @param city (Optional) A character string specifying the city for which to calculate haunting proportions.
#' If NULL, it calculates proportions across all cities.
#' @examples
#' haunted_data <- data.frame(
#'   city = c("New York", "New York", "Boston", "Boston", "Boston"),
#'   location = c("Castle", "Mansion", "Cemetery", "Old House", "Tunnel")
#' )
#' location_proportions(haunted_data, city = "Boston")
#' location_proportions(haunted_data)
#'
#' @return A data frame with the `location`, `city`, and `proportion` of hauntings.
#' The proportions add up to 1 within each city.
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


