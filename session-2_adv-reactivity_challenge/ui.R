library(shiny)

shinyUI(
  fluidPage(
    # Title
    h2("Vote for your favourite animal!"),

    # Images
    wellPanel(
     uiOutput("images")
    ),

    # Action buttons for animals
    wellPanel(
      actionButton("sealion", "Sea lion"),
      actionButton("puffin", "Puffin"),
      actionButton("lamb", "Lamb"),
      actionButton("horse", "Horse")
    ),

    # Action buttons for reveal votes & reset
    wellPanel(
      actionButton("submit", "Reveal votes"),
      actionButton("reset", "Reset")
    ),

    # Results row with 3 cols: live display; final results; plot
    wellPanel(
      fluidRow(
        column(2, tags$b("Live results"),
          uiOutput("liveDisplay")
        ),
        column(2, tags$b("Final results"),
          uiOutput("finalDisplay")
        ),
        column(4, uiOutput("plotResults"))
      )
    )
  )
)
