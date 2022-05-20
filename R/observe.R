r <- reactiveValues(submit1 = FALSE)

observeEvent(input$submit1, {
  r$submit1 <- TRUE
  })

observeEvent(input$submit1, {
  shinyjs::reset("identifier")
  })

observe({
  user <- result_auth$user
  if (!is.null(user)) {
    #RSQLite::dbWriteTable(con, "logs", data.frame(event = "login", user = user, timestamp = format(Sys.time(), "%Y-%m-%d %H:%M:%S %Z"), text = paste0(user, " logged in at ", format(Sys.time(), "%Y-%m-%d %H:%M:%S %Z"))), append = TRUE)
    output$loggedin1 <- renderUI(p(paste0("Logged in as ", result_auth$user), align = "center", style = "font-size:10px"))
    output$loggedin2 <- renderUI(p(paste0("Logged in as ", result_auth$user), align = "center", style = "font-size:10px"))
  }
  if (isTRUE(r$submit1)) {
    mydb <- RSQLite::dbReadTable(con, "allocation")
    if (nchar(input$identifier) > 0) {
      if (!(input$identifier %in% mydb$Identifier)) {
        if (sum(is.na(mydb$Identifier)) > 0) {
          mydb[min(which(is.na(mydb$Identifier))),]$Identifier <- isolate(input$identifier)
          RSQLite::dbWriteTable(con, "allocation", mydb, overwrite = TRUE)
          RSQLite::dbWriteTable(con, "logs", data.frame(event = "allocation", user = user, timestamp = format(Sys.time(), "%Y-%m-%d %H:%M:%S %Z"), text = paste0(user, " allocated subject with identifier ", input$identifier, " to ", mydb[which(mydb$Identifier %in% input$identifier),]$Allocation, " at ", format(Sys.time(), "%Y-%m-%d %H:%M:%S %Z"))), append = TRUE)
          output$list <- renderText({paste0("Subject with identifier ", mydb[max(which(!is.na(mydb$Identifier))),]$Identifier, " has been allocated to ", mydb[max(which(!is.na(mydb$Identifier))),]$Allocation, ".")})
          r$submit1 <- FALSE
          }
        else {
          output$list <- renderText("")
          showNotification("Maximum number of allocation reached. Please contact the Statistical Consultant.", duration = NULL, type = "error")
          r$submit1 <- FALSE
          }
        }
      else {
        output$list <- renderText("")
        showNotification(paste0("Subject with identifier ", input$identifier, " has already been allocated to ", mydb[which(mydb$Identifier %in% input$identifier),]$Allocation, "."), duration = NULL, type = "error")
        r$submit1 <- FALSE
        }
      }
  else {
    output$list <- renderText("")
    showNotification("Identifier must be at least one character long.", duration = NULL, type = "error")
    r$submit1 <- FALSE
    }
  }
})