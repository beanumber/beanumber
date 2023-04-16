
library(tidyverse)

files <- list.files("~/Images/100MEDIA/", full.names = TRUE)
meta <- exifr::read_exif(files)

data <- meta |>
  mutate(the_date = lubridate::as_datetime(DateTimeOriginal)) |>
  filter(the_date > '2022-01-01')

ggplot(data, aes(x = the_date)) +
  geom_histogram()
