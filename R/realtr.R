#' Retrieve listings
#' @param locations character vectors of locations
#' @param property_type default "land"
#' @param ... arguments passed to \code{\link[realtR]{listings}}
#' @export
#' @examples
#' \dontrun{
#' land <- read_listings()
#' }

read_listings <- function(locations = "Northampton, MA", 
                          property_type = "land", ...) {
  x <- realtR::listings(locations, property_type, ...) 
  y <- x %>%
    sf::st_as_sf(coords = c("longitudeProperty", "latitudeProperty")) %>%
    sf::st_set_crs(4326)
  return(y)
}
