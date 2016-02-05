library(dplyr)
library(tidyr)
library(shiny)

options(stringsAsFactors = F)

setwd('C:/Users/B1GRU/Documents/Booz/Bahlmer/Flash Drive/Flash Drive/Data')

myplclust <- function(hclust, lab = hclust$labels, lab.col = rep(1, length(hclust$labels)), 
                      hang = 0.1, ...) {
    ## 
    y <- rep(hclust$height, 2)
    x <- as.numeric(hclust$merge)
    y <- y[which(x < 0)]
    x <- x[which(x < 0)]
    x <- abs(x)
    y <- y[order(x)]
    x <- x[order(x)]
    plot(hclust, labels = FALSE, hang = hang, ...)
    text(x = x, y = y[hclust$order] - (max(hclust$height) * hang), labels = lab[hclust$order], 
         col = lab.col[hclust$order], srt = 90, adj = c(1, 0.5), xpd = NA, ...)
    
}

pitch <- read.csv('Pitchfx.csv')
pitch_splits <- read.csv('Pitching_Splits.csv')
pitcher_id_name <- pitch_splits %>% 
    select(pitcher_id, Name) %>% #, org) %>% 
    unique

fav_pitches <- pitch %>% 
    mutate(pitch_type = ifelse(pitch_type == '', 'blank', pitch_type)) %>% 
    group_by(pitcher_id, pitch_type) %>%
    summarise(count = n()) %>% 
    group_by(pitcher_id) %>% 
    mutate(Total = sum(count)) %>% 
    spread(pitch_type, count, fill = 0) %>% 
    mutate_each(funs(. / Total), -c(pitcher_id, Total)) %>% 
    left_join(pitcher_id_name, by = 'pitcher_id') %>% 
    select(Name, everything())