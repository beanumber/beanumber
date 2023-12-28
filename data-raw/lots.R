## code to prepare `DATASET` dataset goes here

library(tidyverse)

# http://northamptonma.gov/DocumentCenter/View/13270/lots_20190816

library(sf)

northampton_lots <- read_sf(here::here("data-raw/lots_20190816/"))

baumer <- northampton_lots %>%
  filter(str_detect(Owner1, "(BAUMER|VANN |FREEDENFELD)")) %>%
  st_transform(4326)

baumer %>%
  group_by(PARCEL_ID) %>%
  summarize(lot_size = st_area(geometry) / 4046.86)

library(leaflet)
leaflet() %>%
  addTiles() %>% 
  addProviderTiles(providers$Esri.WorldImagery) %>%
  addPolygons(data = baumer)
  


usethis::use_data(northampton_lots, overwrite = TRUE, compress = "xz")



###################

download.file("https://docs.digital.mass.gov/node/1782331/download", "/tmp/lots.xlsx")
towns <- readxl::read_excel("/tmp/lots.xlsx") %>%
  janitor::clean_names()


usethis::use_data(towns, overwrite = TRUE)

cummington <- towns %>%
  filter(town_name == "CUMMINGTON")

download.file(cummington$shapefile_download_url, "lots.zip")
unzip("lots.zip")

library(sf)
st_layers("L3_SHP_M069_Cummington/")

ctown <- read_sf("L3_SHP_M069_Cummington/M069TaxPar.shp") %>%
  st_transform(4326)

# plot(ctown)

###############################

my_towns <- beanumber::read_town_lots(cache_dir = here::here("data-large"))

usethis::use_data(my_towns, overwrite = TRUE, compress = "xz")

