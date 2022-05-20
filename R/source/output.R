output$generate <- downloadHandler("AR54885202201H.pdf",
                                   content = function(file) {
                                     tempdf <- RSQLite::dbReadTable(con, "allocation")
                                     colnames(tempdf) <- c("Identifier", "Allocation")
                                     tempA <- tempdf[!is.na(tempdf$Identifier) & tempdf$Allocation == "A",]
                                     tempB <- tempdf[!is.na(tempdf$Identifier) & tempdf$Allocation == "B",]
                                     temp <- file.path(tempdir(), "AR54885202201H.Rmd")
                                     file.copy("./www/AR54885202201H.Rmd", temp, overwrite = TRUE)
                                     params <- list("A" = tempA, "B" = tempB)
                                     rmarkdown::render(temp[1], output_file = file, params = params, envir = new.env(parent = globalenv()))
                                   })
