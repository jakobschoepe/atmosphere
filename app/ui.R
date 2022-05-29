library(bsplus)
library(htmltools)
library(RSQLite)
library(shiny)
library(shinyjs)
library(shinymanager)
library(shinythemes)

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
                                      tabPanel("Randomization", 
                                               h5("Last updated: May 23, 2022", align = "center"),
                                               br(),
                                               h4(strong("Randomization")),
                                               textInput("identifier", "Please enter a new subject identifier:"),
                                               actionButton("submit1", "Submit"),
                                               br(),
                                               h4(strong("Allocation Statement")),
                                               textOutput("list"),
                                               br(),
                                               br(),
                                               img(src = "Logo.png", style = "display: block; margin-left: auto; margin-right: auto;", height = 50, width = 225),
                                               br(),
                                               br(),
                                               p(HTML("&#169;"), "2022 Institute for Medical Biometry, Epidemiology and Medical Informatics (Saarland University)", align = "center"),
                                               uiOutput("loggedin1")
                                      )
                           )
))
