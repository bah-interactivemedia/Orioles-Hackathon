shinyUI(navbarPage(
    title = div(img(src = 'oriolesLogo.png', height = 50, width = 50),
                'Baltimore Orioles'),
    windowTitle = 'saBAHmetrics',
    tabPanel('Pitcher Comparison',
             fluidPage(
                 fluidRow(column(12,
                                 wellPanel(
                                     selectInput('pitcher', 'Select a pitcher to compare:',
                                                 unique(fav_pitches$Name)),
                                     selectInput('pitchtype', 'Pitch Type',
                                                 c('All', 'CH', 'CU', 'EP', 'FC', 'FF', 
                                                   'FS', 'FT', 'IN', 'KC', 'KN', 'SI', 'SL')),
                                     selectInput('arm', 'Throwing arm',
                                                 c('L/R', 'R', 'L'))
                                 ))
                 ),
                 fluidRow(column(12,
                                 tableOutput('table')#,
                                 # plotOutput('dendrogram')
                                 )
                 )
             ))
    
))