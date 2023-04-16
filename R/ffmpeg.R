#' Convert to MP3
#' @export
#' @param path path to the file to convert
#' @param ... currently ignored
#' @examples
#' \dontrun{
#' if (require(fs) & require(dplyr)) {
#'   music <- dir_info("~/Music", recurse = TRUE, type = "file", regexp = ".m4a")
#'   refl <- music %>%
#'     filter(grepl("Reflections", path))
#'   convert2mp3(refl$path)
#'   
#' }
#' }
# ffmpeg -i $name.m4a -acodec copy $name.aac

convert2mp3 <- function(path, ...) {
  cmd <- paste0("ffmpeg -i '", path, "' -acodec libmp3lame -ab 128k '", str_replace(path, ".m4a", ".mp3"), "'")
  purrr::map_chr(cmd, system)
}
