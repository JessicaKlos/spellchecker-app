#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(hunspell)
library(stringr)


shinyServer(function(input, output) {
  
  # create vector of any words that are not part of dictionary (misspelled words)
  misspelled <- reactive({
    # reduce to letters and numbers
    text <- str_replace_all(input$text, "[^[:alnum:]]", " ")
    text <- gsub("\\s+", " ", str_trim(text))
    # split up words by spaces
    wordvec <- unlist(strsplit(text," "))
    # create boolean indicating if word exists in dictionary
    is_word <- hunspell_check(words = toupper(wordvec))
    # return misspelled words
    misspelled <- wordvec[is_word==FALSE]
    return(misspelled)
  })
  
  # display misspelled words as character in message
  output$message_misspelled <- renderText({
      # return misspelled words
      misspelled <- paste(misspelled(),collapse = ", ")
      message <- ifelse(test = misspelled == "",yes = "All words are correct",
                        no = paste("Unknown / misspelled words:",misspelled))
      return(message)
  })
  
  output$message_suggestions <- renderPrint({
      # return misspelled words
      suggest <- hunspell_suggest(misspelled())
      names(suggest) <- misspelled()
      return(suggest)
  })
  
})
