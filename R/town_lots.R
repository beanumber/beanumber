#' Read town lots
#' @export
#' @importFrom dplyr %>%
#' @param pattern regular expression matching town names
#' @param cache_dir directory where shapefiles are stored
#' @param ... arguments passed to \code{\link[usethis]{use_zip}}
#' @examples 
#' \dontrun{
#' lots <- read_town_lots("ashfield")
#' }
read_town_lots <- function(pattern = "hampton", cache_dir = getwd(), ...) {
  dir <- fs::dir_ls(cache_dir, type = "directory", regexp = pattern, ignore.case = TRUE)
  
  if (length(dir) == 0) {
    dir <- download_town_lots(pattern, cache_dir, ...)
  }
  
  paths <- dir %>%
    purrr::map_chr(fs::dir_ls, regexp = "TaxPar.*\\.shp$")
  
  paths %>%
    purrr::map(sf::read_sf) %>%
    purrr::map(sf::st_transform, 4326) %>%
    dplyr::bind_rows()
}

#' @export
#' @rdname read_town_lots
#' @examples 
#' \dontrun{
#' zip_dir <- download_town_lots("ashfield")
#' }

download_town_lots <- function(pattern = "hampton", cache_dir = getwd(), ...) {
  towns <- beanumber::towns %>%
    dplyr::mutate(cached = file.exists(basename(shapefile_download_url))) %>%
    dplyr::filter(stringr::str_detect(tolower(town_name), pattern)) %>%
    dplyr::pull(shapefile_download_url)
  
  path_to_dir <- tryCatch(
    towns %>%
      purrr::map(usethis::use_zip, ... = ...), 
    error = function(e) e
  )
  
}
