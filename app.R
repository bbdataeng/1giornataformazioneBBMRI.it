library(leaflet)
library(mapview)
library(shiny)
if (!require(rsconnect)) {
  install.packages("rsconnect")
}
library(rsconnect)


# User Interface ----------------------------------------------------------
ui <- fluidPage(
  titlePanel(tags$b('1^ giornata di formazione del progetto PNRR Strengthening BBMRI.it: indicazioni')),
  tabsetPanel(
    tabPanel(tags$b('A piedi o con i mezzi'),
             fluidRow(
               column(12,leafletOutput("piedi_o_mezzi", height = "80vh", width = "100%"))
             )),	  
    tabPanel(tags$b('Con automobile'),  
             fluidRow(
               column(12,leafletOutput("auto", height = "80vh", width = "100%"))
             ))
  )
)

# Server ------------------------------------------------------------------

server <- function(input, output) {
  output$auto <- renderLeaflet({
    leaflet() %>%      
      addProviderTiles(providers$OpenStreetMap, group="Mappa stradale") %>%
      addProviderTiles(providers$Esri.WorldImagery, group="Satellite") %>% 
      addMarkers(lng=14.222205,  lat=40.869342, label="Ingresso auto (previa registrazione)", group="Ingresso auto(previa registrazione)") %>% 
      addMarkers(lng=14.220945,  lat=40.869597, label="Parcheggio vetture", group="Parcheggio vetture") %>% 
      addMarkers(lng=14.221081,  lat=40.874015, label="Aula Beguinot Edificio 4, II piano", group="Aula Beguinot Edificio 4, II piano") %>% 
      addPolylines(lng = c(14.222205,14.22182997,14.22137527,14.22094563,14.22053031,14.21983931,14.21976412,14.21977487,14.21942041,14.22094205,14.22116045,14.22110316,14.22130366,14.22121415,14.221081,14.221081),
                   lat = c(40.869342,40.86924801,40.86934818,40.86959727,40.8694998,40.86960539,40.86984094,40.87006295,40.87054487,40.87112966,40.87150328,40.872616,40.87404815,40.87414291,40.874015,40.874015)) %>%
      addLayersControl(baseGroups=c("Mappa stradale","Satellite"), 
                       overlayGroups=c("Ingresso auto (previa registrazione)","Parcheggio vetture","Aula Beguinot Edificio 4, II piano"), 
                       options=layersControlOptions(collapsed=FALSE)) 
  })
  
  output$piedi_o_mezzi <- renderLeaflet({
    leaflet() %>% 
      addProviderTiles(providers$OpenStreetMap, group="Mappa stradale") %>%
      addProviderTiles(providers$Esri.WorldImagery, group="Satellite") %>% 
      addMarkers(lng=14.221849, lat=40.866004, label= "Uscita metro Policlinico", group="Uscita metro Policlinico") %>% 
      addMarkers(lng=14.222154, lat=40.866855, label= "Stazionamento bus", group="Stazionamento bus") %>% 
      addMarkers(lng=14.221081, lat=40.874015, label="Aula Beguinot Edificio 4, II piano", group="Aula Beguinot Edificio 4, II piano") %>% 
      addPolylines(lng = c(14.221849,14.2223093,14.22238708,14.22215105,14.22186673,14.22139198,14.22105402,14.21881974,14.21841741,14.2179668,14.21808214,14.22080289,14.22115158,14.22113817,14.22107061,14.22132607,14.22122131,14.221081), 
                   lat = c(40.866004,40.86724284,40.86762822,40.86771342,40.86760794,40.86711708,40.86702377,40.86765865,40.86795884,40.86981272,40.87007437,40.87107236,40.8714699,40.87209053,40.87267734,40.87399806,40.87414883,40.874015),color="blue",weight=6) %>%
      addLayersControl(baseGroups=c("Mappa stradale","Satellite"), 
                       overlayGroups=c("Uscita metro Policlinico", "Stazionamento bus", "Aula Beguinot Edificio 4, II piano"), 
                       options=layersControlOptions(collapsed=FALSE)) 
  })
}

# Run Shiny App -----------------------------------------------------------
shinyApp(ui = ui, server = server)



