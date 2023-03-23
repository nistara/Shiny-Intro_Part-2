


server = function(input, output) {

  # Initialize animal count reactive values
  # ----------------------------------------------------------------------------
  votes = reactiveValues(sealionCount = 0, puffinCount = 0, lambCount = 0, horseCount = 0 )


  # Tally votes for individual animals
  # ----------------------------------------------------------------------------
  observeEvent(input$sealion, {
    votes$sealionCount = votes$sealionCount + 1
    # message("sealion: ", votes$sealionCount)
  })
  
  observeEvent(input$puffin, {
    votes$puffinCount = votes$puffinCount + 1
  })
  
  observeEvent(input$lamb, {
    votes$lambCount = votes$lambCount + 1
  })
  
  observeEvent(input$horse, {
    votes$horseCount = votes$horseCount + 1
  })


  # Update previously created animal vote data frame
  # ----------------------------------------------------------------------------
  vote_vals = reactive({
    vals = unlist(reactiveValuesToList(votes))
    names(vals) = gsub("Count", "", names(votes))
    animals$count = vals[ match(names(vals), animals$animal) ]
    dplyr::arrange(animals, -count)
  })
  

  # Initialize winner reactiveVal
  # ----------------------------------------------------------------------------
  winner = reactiveVal()


  # Update value of winner() when actionButton "submit" (Reveal votes) is clicked
  # ----------------------------------------------------------------------------
  observeEvent(input$submit, {
    max_count = max(vote_vals()$count)
    new_winner = vote_vals()[ vote_vals()$count == max_count, ]
    winner(new_winner)
    print(winner())
  })


  # Images for display: all animals vs winner vs tie
  # ----------------------------------------------------------------------------
  output$images = renderUI({

    if( is.null(winner()) ) {
      HTML(paste0('<img src = "', animals$img_src, '" height = "300px" />'))
    } else {
      validate(
        need((nrow(winner()) == 1), {
          tie_animals = paste0(winner()$label, collapse = " and ")
          paste0("It was a tie between ", tie_animals, "!")
        })
      )

        HTML(paste0('<img src = "', winner()$img_src, '" height = "300px" />'))
    }
  })


  # Generate results html code
  # ----------------------------------------------------------------------------
  results = reactive({
    # message(paste0("<p>", vote_vals()$label, ": ", vote_vals()$count, "</p>"))
    HTML(paste0("<p>", vote_vals()$label, ": ", vote_vals()$count, "</p>"))
  })


  # Update  live results output when action buttons for animals are clicked
  # ----------------------------------------------------------------------------
  output$liveDisplay = renderUI({
    results()
  })
  

  # Update total votes output when submit (Reveal votes) or reset buttons are clicked
  # ----------------------------------------------------------------------------
  totalVotes = eventReactive(list(input$submit, input$reset),{
    results()
  })

  output$finalDisplay = renderUI({
    totalVotes()
  })


  # Generate bar plot for output
  # ----------------------------------------------------------------------------
  output$plotResults = renderUI({
    renderPlot({
      max_val = max(vote_vals()$count)
      df = vote_vals()
      df = df[order(df$count, decreasing = FALSE), ]
      par(mar = c(0, 1, 0, 2))
      p = barplot(df$count, axes = FALSE, horiz = TRUE, las = 1, xlim = c(0, max_val + 5))
      text(y = p, x = df$count + 2, labels = df$label)
      p
    },
    height = 200)
  })

  
  # Reset counts and winner data when reset button is clicked
  # ----------------------------------------------------------------------------
  observeEvent(input$reset, {
    votes$sealionCount = 0
    votes$puffinCount = 0
    votes$lambCount = 0
    votes$horseCount = 0
    winner(NULL)
    print(winner())
  }, priority = 1)
  
}



# Miscellaneous references for future look up
# ------------------------------------------------------------------------------
# https://stackoverflow.com/a/42509959/5443003
# https://stackoverflow.com/a/63419246/5443003
# https://shiny.rstudio.com/articles/images.html
# https://unleash-shiny.rinterface.com/custom-templates-testing.html
# https://stackoverflow.com/a/37481077/5443003
# https://mastering-shiny.org/reactivity-objects.html

