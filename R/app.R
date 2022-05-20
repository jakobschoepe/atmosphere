library(htmltools)
library(bsplus)
library(rmarkdown)
library(RSQLite)
library(shiny)
library(shinyjs)
library(shinymanager)
library(shinythemes)
library(shinyalert)

options(shiny.maxRequestSize=30*1024^2) 
set_labels(
  language = "en",
  "Please authenticate" = "Authentification",
  "Username:" = "Username",
  "Password:" = "Password",
  "Please change your password" = "Change Password",
  "New password:" = "New Password",
  "Confirm password:" = "Confirm Password",
  "Update new password" = "Submit"
)

ui <- secure_app(fluidPage(theme = bslib::bs_theme(bootswatch = "flatly", secondary = "#2c3e50", success = "#7EBC18"),
                tags$head(HTML("<title>ATMOSPHERE</title> <link rel='icon' type='image/gif/png' href='Favicon.png'>")),
                shinyjs::useShinyjs(),
                navbarPage(strong("ATMOSPHERE"),
                           source("./source/00_About.R", local = TRUE)$value,
                           source("./source/01_Randomization.R", local = TRUE)$value,
                           )
                ))

server <- function(input, output, session) {
  result_auth <- secure_server(check_credentials = check_credentials("./users.sqlite", passphrase = "iebmi"))
  output$res_auth <- renderPrint({
    reactiveValuesToList(result_auth)
  })
  con <- RSQLite::dbConnect(RSQLite::SQLite(), dbname = "data.sqlite")
  #shinyalert::shinyalert("ATMOSPHERE PLATFORM", "Welcome to the ATMOSPHERE PLATFORM", type = "info")
  source("./source/observe.R", local = TRUE)$value
  source("./source/output.R", local = TRUE)$value
  onStop(function() {RSQLite::dbDisconnect(con)})
}

suppressPackageStartupMessages(shinyApp(ui, server))