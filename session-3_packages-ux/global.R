library(shiny.router)
library(DT)

checkbox_page <- fluidPage(checkboxInput("checkbox", "Hide/Disable"))
radio_page <- fluidPage( uiOutput("radioContainer"))
button_page <- fluidPage(  uiOutput("buttonContainer"),
                           textOutput("text"))
image_page <- fluidPage( uiOutput("imageContainer"))
table_page <- fluidPage( dataTableOutput("dtTable"))

routes <- router_ui(
  route("/", checkbox_page),
  route("radio", radio_page),
  route("button", button_page),
  route("image", image_page),
  route("table", table_page),
  page_404 = page404(message404 = "YOU'VE MADE A WRONG TURN, GO BACK")
)

# router <- make_router(routes)

# References
# ------------------------------------------------------------------------------
# https://appsilon.github.io/shiny.router/index.html
# https://stackoverflow.com/a/48891070/5443003
# https://stackoverflow.com/a/41746169/5443003
# https://stackoverflow.com/a/37197458/5443003
