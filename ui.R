shinyUI(navbarPage(
    title = div(img(src = 'oriolesLogo.png', height = 50, width = 50),
                'Baltimore Orioles Hackathon'),
    windowTitle = 'saBAHmetrics',
    tabPanel('Pitcher Comparison Tool',
             fluidPage(
                fluidRow(column(12,
                                h1("Booz Allen's Pitcher Comparison Tool"),
                                p("This tool allows you to compare a specific pitcher's pitch attributes to those of other pitchers in the league. The tool allows you to filter on specific pitch type and throwing hand, as well as sort by various metrics, including salary."))),
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
                                 p('Similar Pitchers'))),
                 fluidRow(column(12,
                                 tableOutput('table')#,
                                 # plotOutput('dendrogram')
                                 )
                 )
             ), includeCSS("styles.css"))
    
))