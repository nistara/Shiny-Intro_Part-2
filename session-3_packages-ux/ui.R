library(shiny)
library(shinyjs)
library(shiny.router)
library(DT)


shinyUI(fluidPage(
  useShinyjs(),
  tags$h1(uiOutput("page_name")),
    tags$ul(
        tags$li(a(href = "#!/", "Home")),
        tags$li(a(href = "#!/radio", "Radio")),
        tags$li(a(href = "#!/button", "Button")),
        tags$li(a(href = "#!/image", "Image")),
        tags$li(a(href = "#!/table", "Table")),
    ),
    routes

))
