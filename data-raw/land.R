zws_id <- "X1-ZWz1i4ks3yp8gb_23up5"

library(tidyverse)
library(ZillowR)
set_zillow_web_service_id(zws_id)

GetSearchResults("48 Lexington Ave", "01062")


###############

library(realtR)
library(sf)
land <- listings(
    locations = c("Cummington, MA"),
    property_type = "land"
  ) 
land <- land %>%
  st_as_sf(coords = c("longitudeProperty", "latitudeProperty")) %>%
  st_set_crs(4326)

usethis::use_data(land, overwrite = TRUE)
