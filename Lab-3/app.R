# app.R

# Detect and install missing packages before loading them
if (!require('pacman')) install.packages('pacman')
# Install and load packages
pacman::p_load('ibmdbR', 'shiny', 'shinythemes', 'plyr', 'DT', 'plotly')

# Get connection details
source('connection.R', local = TRUE)

# Named colors for the pie graph
darkred <- rgb(139, 0, 0, maxColorValue = 255)
darkgreen <- rgb(0, 100, 0, maxColorValue = 255)
coral <- rgb(255, 127, 80, maxColorValue = 255)
gray <- rgb(128, 128, 128, maxColorValue = 255)
brown2 <- rgb(238, 59, 59, maxColorValue = 255)
darkgoldenrod4 <- rgb(139, 101, 9, maxColorValue = 255)
darkolivegreen4 <- rgb(110, 139, 61, maxColorValue = 255)

# Vetting categories as strings
category.as.string <- function(catnum) {
  i <- as.integer(catnum)
  if(!is.na(i)) {
    if (i == 10) return('HIGH')
    if (i == 20) return('MEDIUM')
    if (i == 30) return('LOW')
  }
  'Pending'
}

shinyApp(
  ################################################################################
  # UI                                                                           #
  ################################################################################
  ui = fluidPage(
    #shinythemes::themeSelector(),
    tags$head(tags$style('body {background-color: #FFFFEF; }')),
    theme = shinythemes::shinytheme('yeti'),
    # Application title
    titlePanel('Human Trafficking'),
    sidebarLayout(
      sidebarPanel(
        width = 3,
        plotlyOutput('vettingPie', height = 450),
        conditionalPanel(
          condition="(typeof input.tbl_rows_selected !== 'undefined' && input.tbl_rows_selected.length > 0)", hr(),
          verbatimTextOutput('selectionDetails'),
          wellPanel(
            fluidRow(
              column(
                width=6, radioButtons(
                  'vetting', label='Vetting Level',
                  choices=c('Pending' = 100, 'HIGH' = 10, 'MEDIUM' = 20, 'LOW' = 30)
                )
              )
            )
          ),
          actionButton('saveVetting', label = 'Save', icon = icon('save', lib = 'glyphicon')),
          actionButton('entityProfile', label='Entity Profile', icon=icon('id-card-o'))
        )
      ),
      mainPanel(
        width = 9,
        DT::dataTableOutput('tbl')
      )
    )
  ),
  
  ################################################################################
  # SERVER                                                                       #
  ################################################################################
  server = function(input, output, session) {
    # Connect to using a odbc Driver Connection string to a remote database
    conn <- idaConnect(
      paste0(
        dsn.database,
        ";DATABASE=", dsn.database,
        ";HOSTNAME=", dsn.hostname,
        ";PORT=", dsn.port,
        ";PROTOCOL=", dsn.protocol,
        ";UID=", dsn.uid,
        ";PWD=", dsn.pwd
      )
    )
    
    # Initialize the analytics package
    idaInit(conn)
    
    # Close the DB connection when the session ends
    cancel.onSessionEnded <- session$onSessionEnded(function() { idaClose(conn) })
    
    # Query to update the vetting
    updateVetting <- function(id, vetting) {
      idaQuery(
        paste0('UPDATE ', vetting.table, ' SET "VETTING_LEVEL" = ', vetting, ' WHERE "UUID" = \'', id, '\'')
      )
    }
    
    # Server-side observable values
    v <- reactiveValues(
      data = {
         df <- idaQuery(
            paste0(
            'SELECT * FROM ', vetting.table, ' T1 INNER JOIN ', vetting.table, '_ML_RESULTS T2 USING (UUID)',
            ' ORDER BY VETTING_LEVEL, NAME'
          )
        )
        df
      }, data.selected = NULL
    )
    
    # When rows are selected, update the data.selected reactive value
    observe({v$data.selected <- input$tbl_rows_selected})
    
    # When the data or the selection changes, update the radio button and the selection details
    output$selectionDetails <- reactive({
      df <- v$data
      selected <- v$data.selected
      shiny::validate(need(!is.null(df) && !is.null(selected), 'Nothing selected.'))
      updateRadioButtons(session, 'vetting', selected = df$VETTING_LEVEL[[selected]])
      paste0(
        'Name: ', df$NAME[[selected]],
        '\nGender: ', {switch(toupper(df$GENDER[[selected]]), F = 'Female', M = 'Male', 'Unknown')},
        '\nAge: ', df$AGE[[selected]],
        '\nBirth Country: ', df$BIRTH_COUNTRY[[selected]],
        '\nPassport Country: ', df$PASSPORT_COUNTRY[[selected]],
        '\nOccupation: ', df$OCCUPATION[[selected]],
        '\nOccupation Category: ', df$Category[[selected]],
        '\nCountries Visited: ', df$COUNTRIES_VISITED_COUNT[[selected]], ' (', df$COUNTRIES_VISITED[[selected]], ')',
        '\nCurrent Vetting: ', category.as.string(df$VETTING_LEVEL[[selected]]),
        '\nVetting Prediction: ', category.as.string(df$predCategory[[selected]])
      )
    })
    
    profileModal <- function(df, selected) {
      showModal(
        modalDialog(
          title=paste0('Profile for ', df$NAME[[selected]]),
          size='l',
          easyClose=TRUE,
          fluidRow(
            column(
              width=4,
              shiny::img(
                src=ifelse(df$GENDER[[selected]] == 'F', 'avatar_female.jpg', 'avatar_male.jpg'),height=240, width=240
              )
            ),
            column(
              width=8,
              HTML({
                result <- '<h4>'
                result <- paste0(result, 'Address: ', df$ADDRESS[[selected]], br())
                result <- paste0(result, 'National ID: ', df$SSN[[selected]], br())
                result <- paste0(result, 'Occupation: ', df$OCCUPATION[[selected]], br())
                result <- paste0(result, 'Birth Date: ', df$BIRTH_DATE[[selected]], ' (', df$AGE[[selected]], ')', br())
                paste0(result, '</h4>')
              })
            )
          )
        )
      )
    }
    
    observeEvent(input$entityProfile, {
      isolate({
        df <- v$data
        selected <- v$data.selected
        shiny::validate(need(!is.null(df) && !is.null(selected), 'Nothing selected.'))
        profileModal(df, selected)
      })
    })
    
    # When the data changes, update the vetting pie graph
    output$vettingPie <- renderPlotly({
      df <- v$data
      shiny::validate(need(is.data.frame(df) && nrow(df) > 0, 'No results.'))
      withProgress(
        message = 'Rendering pie graph',  {
          colors <- c(darkred, coral, darkgreen, brown2, darkgoldenrod4, darkolivegreen4, gray)
          plot_ly(
            {
              df <- rbind({
                # Vetted
                vettedDf <- df[df$VETTING_LEVEL != 100,]
                vettedDf <- as.data.frame(table(vettedDf$VETTING_LEVEL))
                vettedDf$Var1 <- plyr::revalue(
                  warn_missing = FALSE, as.character(vettedDf$Var1),
                  c('10' = 'HIGH VETTED', '20' = 'MEDIUM VETTED', '30' = 'LOW VETTED')
                )
                vettedDf
              }, {
                # Predicted
                predictedDf <- df[df$VETTING_LEVEL == 100,]
                predictedDf <- as.data.frame(table(as.integer(predictedDf$predCategory)))
                predictedDf$Var1 <- plyr::revalue(
                  warn_missing = FALSE, as.character(predictedDf$Var1),
                  c('10' = 'HIGH PREDICTED', '20' = 'MEDIUM PREDICTED', '30' = 'LOW PREDICTED', '100' = 'Pending')
                )
                predictedDf
              })
              names(df)[names(df) == 'Var1'] <- 'Vetting'
              df$Vetting <- factor(
                df$Vetting,
                c('HIGH VETTED', 'MEDIUM VETTED', 'LOW VETTED', 'HIGH PREDICTED', 'MEDIUM PREDICTED', 'LOW PREDICTED', 'Pending')
              )
              df
            }, labels = ~Vetting, values = ~Freq, type = 'pie',
            textposition = 'inside',
            textinfo = 'label+percent',
            insidetextfont = list(color = '#FFFFFF'),
            hoverinfo = 'label+text+percent',
            source = 'vettingPie',
            text = ~paste(Freq),
            marker = list(colors = colors, line = list(color = '#FFFFFF', width = 1))
          ) %>% plotly::config(displaylogo = FALSE, collaborate = FALSE) %>%
            layout(
              showlegend = TRUE, legend = list(orientation = 'h'),
              xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
              yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
        })
    })
    
    observeEvent(input$saveVetting, {
      vetting <- as.integer(isolate(input$vetting))
      id <- isolate(v$data$UUID[v$data.selected[1]])
      if (!is.na(id)) {
        withProgress(
          message = 'Saving vetting', detail = category.as.string(vetting), {
            v$data$VETTING_LEVEL[v$data.selected[1]] <- vetting
            updateVetting(id, vetting)
          }
        )
      }
    })
    
    output$tbl <- DT::renderDataTable(
      {
        shiny::validate(need(is.data.frame(v$data) && nrow(v$data) > 0, 'No results.'))
        v$data
      }, 
      server = FALSE,
      class = 'cell-border stripe',
      filter = 'top',
      colnames = c('ROW_ID'=1),
      extensions = c('Buttons', 'Scroller'),
      selection = 'single',
      options = list(
        dom = 'Bfrtip',
        buttons=list(
          list(extend='colvis'),
          'copy', 'csv', 'excel', 'pdf', 'print'
        ),
        scrollX = TRUE,
        scrollY = 600,
        scroller = TRUE,
        searchHighlight = TRUE,
        autoWidth = TRUE
      )
    )
  }
)
