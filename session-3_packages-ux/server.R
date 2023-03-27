library(shiny)
library(shinyjs)
library(shiny.router)
library(DT)
library(dplyr)
library(stringr)

shinyServer(function(input, output, session) {
  output$radioContainer <- renderUI({
    radioButtons("radio", "Flip a coin:", c("Heads", "Tails"))
  })
  
  output$buttonContainer <- renderUI({
    actionButton("button", "Click me!")
  })
  
  output$imageContainer <- renderUI({
    img(id ="image",src="https://www.rstudio.com/wp-content/uploads/2018/10/RStudio-Logo-Flat.png", height = 100)
  })
  
  observeEvent(input$checkbox, {
    toggleState("radio")
    toggleState("button")
    toggle("image")
  })
  
  observeEvent(input$button, {
    runjs("Shiny.setInputValue('jsEvent', Math.random());")
  })
  
  output$text <- renderPrint({
    input$jsEvent
  })
  
  output$dtTable <- DT::renderDataTable({
    datatable(iris,
      rownames = F,
      colnames = sprintf("<i>%s</i>", gsub("\\.", " ", names(iris))),
      escape = FALSE,
      options = list(searching = F,
                              order = list(list(1, 'asc'))
              )
    ) %>% 
      formatStyle(
        'Species',
        target = 'row',
        backgroundColor = styleEqual(c('setosa'), c('yellow'))
      )
  })

  output$page_name <- renderUI({
    page = stringr::str_to_title(get_page(session = shiny::getDefaultReactiveDomain()))
    page = ifelse(page %in% "/", "Home", page)
    page = ifelse(page %in% "404", "", page)
    message("page: ", page)
    page
  })

  router_server()
  
})
