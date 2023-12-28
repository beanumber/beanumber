# Android Music sync

/run/user/1000/gvfs/mtp:=Google_Pixel_4a_09261JEC223237/Internal shared storage/Music/Beck$ rsync -navz /home/bbaumer/Music/Beck/ .

# https://askubuntu.com/questions/1164971/rsync-to-mtp-mounted-android-does-not-work

## This works!
# rsync -vrh --size-only /home/bbaumer/Music/The\ Eagles .

library(tidyverse)

# Files to transfer

library(fs)
music <- dir_info("~/Music", recurse = TRUE, type = "file") %>%
  mutate(ext = path_ext(path))

music %>%
  group_by(ext) %>%
  count() %>%
  arrange(desc(n))

music %>%
  filter(ext == "MP3") %>%
  pull(path)

phone <- dir_info("/run/user/1000/gvfs/mtp:host=%5Busb%3A002%2C023%5D/Internal shared storage/Music/", recurse = TRUE, type = "file") %>%
  mutate(ext = path_ext(path))

### Conversion

# ffmpeg -i $name.m4a -acodec copy $name.aac

old <- music %>%
  filter(str_detect(path, "Death To The Pixies")) %>%
  mutate(
    cmd = paste0("ffmpeg -i '", path, "' -acodec copy '", str_replace(path, ".m4a", ".aac"), "'")
  )

map(old$cmd, system)


# Playlists
# https://gist.github.com/kellertobias/7610b954f437d99fc0ddcc5584b15f44