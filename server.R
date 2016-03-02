shinyServer(function(input, output, session) {
    
#     output$dendrogram <- renderPlot({
#         myplclust(pitch_type_hc, lab.col = unclass(as.factor(pitch_type$throws)))
#     })
    
    
    # pitch_sample <- read.csv('Pitchfx.csv') %>% 
# test <- pitch %>% 
#         filter(pitch_type == 'FF') %>% 
#         left_join(pitcher_id_name, by = 'pitcher_id') %>% 
#         # filter(throws == 'L') %>% 
#         group_by(pitcher_id, throws, Name) %>% 
#         summarise_each(funs(mean(.)), initial_speed:plate_speed, break_x:init_accel_z) %>% 
#         select(Name, everything(), -init_pos_y) %>% 
#         ungroup %>% 
#         left_join(fav_pitches %>% select_('pitcher_id', 'FF'), by = 'pitcher_id') %>% 
#         mutate_each(funs((. - mean(.)) / sd(.)), initial_speed:plate_speed, break_x:init_accel_z, FF)
#     
#     write.csv(test, 'sampleData.csv', row.names = F)
    
    output$table <- renderTable({
#         pitchType <- pitch %>% 
#             filter(pitch_type %in% c('CH', 'CU', 'EP', 'FC', 'FF', 
#                                      'FS', 'FT', 'IN', 'KC', 'KN', 'SI', 'SL'))
#         
#         if (input$pitchtype != 'All') {
#             pitchType <- pitchType %>% 
#                 left_join(pitcher_id_name, by = 'pitcher_id') %>% 
#                 filter(pitch_type == 'CH' | Name == input$pitcher)
#         }
#         
#         if (input$arm != 'L/R') {
#             pitchType <- pitchType %>% 
#                 filter(throws == input$arm)
#         }
#         
#         pitchType <- pitchType %>% 
#             group_by(pitcher_id, throws, Name) %>% 
#             summarise_each(funs(mean(.)), initial_speed:plate_speed, break_x:init_accel_z) %>% 
#             select(Name, everything(), -init_pos_y) %>% 
#             ungroup %>% 
#             mutate_each(funs((. - mean(.)) / sd(.)), initial_speed:plate_speed, break_x:init_accel_z)
#         
#         if (input$pitchtype != 'All') {
#             pitchType <- pitchType %>% 
#                 left_join(fav_pitches %>% select_('pitcher_id', input$pitchtype), by = 'pitcher_id')
#             
#             pitchType[, input$pitchtype] <- (pitchType[input$pitchtype][[1]] - mean(pitchType[input$pitchtype][[1]])) / sd(pitchType[input$pitchtype][[1]])
#         }
#         
# 
#         else (
#             pitchType <- pitchType %>% 
#                 left_join(fav_pitches %>% select_('pitcher_id'), by = 'pitcher_id')
#         )        
        
        rownames(pitchType) <- pitchType$pitcher_id
        
        pitch_type_dist <- dist(pitchType %>% select(-c(Name, pitcher_id, throws)))
        pitch_type_hc <- hclust(pitch_type_dist)
        groups <- cutree(pitch_type_hc, k = nrow(pitchType) / 20)
        
        ids <- names(groups[groups == groups[as.character(pitcher_id_name$pitcher_id[pitcher_id_name$Name == input$pitcher])]])
        
        pitchType %>% 
            filter(pitcher_id %in% ids)
    })
    
})