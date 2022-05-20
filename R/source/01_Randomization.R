tabPanel("Randomization",
         textInput("identifier", "Please enter a new subject identifier:") %>%
         shinyInput_label_embed(shiny::icon("info-circle") %>% bs_embed_popover(title = "Please enter a new subject identifier with at least four characters.", content = "Please enter a new subject identifier.", placement = "left")),
         actionButton("submit1", "Submit"),
         br(),
         h4(strong("Allocation Statement")),
         textOutput("list"),
         br(),
         br(),
         h4(strong("Generate Allocation Report")),
         downloadButton("generate", "Generate Allocation Report"),
         br(),
         br(),
         img(src = "Logo.png", style = "display: block; margin-left: auto; margin-right: auto;", height = 50, width = 225),
         br(),
         br(),
         p(HTML("&#169;"), "2022 Institute for Medical Biometry, Epidemiology and Medical Informatics (Saarland University)", align = "center"),
         uiOutput("loggedin2")
)
