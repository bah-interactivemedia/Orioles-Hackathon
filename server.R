shinyServer(function(input, output, session) {
    
    

#     output$dendrogram <- renderPlot({
#         myplclust(pitch_type_hc, lab.col = unclass(as.factor(pitch_type$throws)))
#     })
    
    output$table <- renderTable({
        pitch_type <- pitch %>% 
            filter(pitch_type %in% c('CH', 'CU', 'EP', 'FC', 'FF', 
                                     'FS', 'FT', 'IN', 'KC', 'KN', 'SI', 'SL'))
        
        if (input$pitchtype != 'All') {
            pitch_type <- pitch_type %>% 
                left_join(pitcher_id_name, by = 'pitcher_id') %>% 
                filter(pitch_type == input$pitchtype | Name == input$pitcher)
        }
        
        if (input$arm != 'L/R') {
            pitch_type <- pitch_type %>% 
                filter(throws == input$arm)
        }
        
        pitch_type <- pitch_type %>% 
            group_by(pitcher_id, throws) %>% 
            summarise_each(funs(mean(.)), initial_speed:plate_speed, break_x:init_accel_z) %>% 
            select(Name, everything(), -init_pos_y) %>% 
            ungroup %>% 
            mutate_each(funs((. - mean(.)) / sd(.)), initial_speed:plate_speed, break_x:init_accel_z)
        
        if (input$pitchtype != 'All') {
            pitch_type <- pitch_type %>% 
                left_join(fav_pitches %>% select_('pitcher_id', input$pitchtype), by = 'pitcher_id') %>% 
                rename_('Frequency' = input$pitchtype) %>% 
                mutate(Frequency = (Frequency - mean(Frequency)) / sd(Frequency))
                
            # pitch_type$Frequency <- (pitch_type[, input$pitchtype] - mean(pitch_type[, input$pitchtype])) / sd(pitch_type[, input$pitchtype])
        }
        
        else (
            pitch_type <- pitch_type %>% 
                left_join(fav_pitches %>% select_('pitcher_id'), by = 'pitcher_id')
        )        
        
        rownames(pitch_type) <- pitch_type$pitcher_id
        
        pitch_type_dist <- dist(pitch_type %>% select(-c(Name, pitcher_id, throws)))
        pitch_type_hc <- hclust(pitch_type_dist)
        groups <- cutree(pitch_type_hc, k = nrow(pitch_type) / 20)
        
        ids <- names(groups[groups == groups[as.character(pitcher_id_name$pitcher_id[pitcher_id_name$Name == input$pitcher])]])
        
        pitch_type %>% 
            filter(pitcher_id %in% ids)
    })
    
})