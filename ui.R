
library(shiny)

# UI for small spell checking program
shinyUI(fluidPage(
  titlePanel("Spell Checker (US English)"),
  
  
  sidebarLayout(
    # Sidebar has text area and button for execution
    sidebarPanel(
      h5(strong("Documentation")),
      h5("Enter a text in US English in the text box below. You may enter single or multiple words or sentences. Characters other than letters and numbers will be ignored."),
      h5("When you are ready press 'Check spelling'"),
      h5("The app will compare your text against a dictionary and return any unknown/misspelled words with suggestions for corrections."),
      br(),
      fluidRow(textAreaInput(inputId = "text", label = "Enter your text here")),
      fluidRow(submitButton(text = "Check spelling"))
    ),
    # Main panel displays any misspelled words and suggestions for them
    mainPanel(
      conditionalPanel("output.misspelled != 0",
                       h4(textOutput(outputId="message_misspelled"))),
      br(),
      conditionalPanel(condition = "output.message_misspelled != 'All words are correct' & output.message_misspelled != 0",
                       h4("Did you mean:"),
                       verbatimTextOutput(outputId="message_suggestions",placeholder = TRUE))
    )
  )
))

# fluidRow(submitButton(inputId = "execute_analysis", label = "Check spelling", icon = icon("toggle-right"),
#                       style="color: #fff; background-color: #337ab7; border-color: #2e6da4"))
