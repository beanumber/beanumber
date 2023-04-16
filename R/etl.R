#' My ETL functions
#' @import etl
#' @inheritParams etl::etl_extract
#' @export
#' @examples
#' \dontrun{
#' if (require(dplyr)) {
#'   obj <- etl("beanumber") %>%
#'     etl_create()
#' }
#' }

etl_extract.etl_beanumber <- function(obj, pattern = "hampton", ...) {
  # Specify the URLs that you want to download
  src <- beanumber::towns %>%
    dplyr::filter(stringr::str_detect(tolower(town_name), pattern)) %>%
    dplyr::pull(shapefile_download_url)
  
  # Use the smart_download() function for convenience
  etl::smart_download(obj, src, ...)

  # Always return obj invisibly to ensure pipeability!
  invisible(obj)
}
