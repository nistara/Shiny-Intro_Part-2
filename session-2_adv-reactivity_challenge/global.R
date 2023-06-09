library(shiny)
library(dplyr)
library(stringr)

# Data frame for working with vote counts
# ==============================================================================
animals = data.frame(
  img_src = c(
    "sea_lion.jpg",
    "puffin.jpg",
    "lamb.jpg",
    "horses.jpg"
  ),
  animal = c(
    "sealion",
    "puffin",
    "lamb",
    "horse"
  ),
  count = rep(0, 4)
)

animals$label = stringr::str_to_title(animals$animal)
