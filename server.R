
shinyServer(function(input, output, session) {

  # Filter the movies, returning a data frame
  baaddat <- reactive({
    
    vegetation <- input$vegetation
    growingCondition <- input$growingCondition
    studyName <- input$studyName
    studyName2 <- input$studyName2
    colorby <- input$colorby
    baad$pft <- as.factor(baad$pft) # Factor here; want to keep empties for PFT

    if(vegetation != "All")baad <- baad[baad$vegetation %in% vegetation,]
    baad <- baad[baad$growingCondition %in% growingCondition,]
    if(studyName != "All" && studyName2 == "None"){
      baad <- baad[baad$studyName == studyName,]
    }
    if(studyName != "All" && studyName2 != "None"){
      baad <- baad[baad$studyName %in% c(studyName,studyName2),]
    }

  baad
  })
  
  baadplot_fun <- function(input){
    
    b <- baaddat()
    b$X <- b[,input$xvar]
    b$Y <- b[,input$yvar]
    b <- b[!is.na(b$X) & !is.na(b$Y),]
    
    palfun <- get(input$pchpalette)
    
    if(nrow(b) == 0)return(NULL)

    if(input$colorby == "Study Name"){
      b$studyName <- as.factor(b$studyName)
      pal <- palfun(nlevels(b$studyName))
      b$Colour <- pal[b$studyName]
      legendfun <- function()legend("topleft", levels(b$studyName), col=pal, pch=19, cex=0.8)
    }
    if(input$colorby == "Vegetation"){
      b$vegetation <- as.factor(b$vegetation)
      pal <- palfun(nlevels(b$vegetation))
      legendfun <- function()legend("topleft", levels(b$vegetation), col=pal, pch=19, cex=0.8)
      b$Colour <- pal[b$vegetation]
    }
    if(input$colorby == "Species"){
      b$speciesMatched <- as.factor(b$speciesMatched)
      pal <- palfun(nlevels(b$speciesMatched))
      legendfun <- function()legend("topleft", levels(b$speciesMatched), col=pal, pch=19, cex=0.8)
      b$Colour <- pal[b$speciesMatched]
    }
    if(input$colorby == "Plant functional type"){
      
      pftpal <- alpha(c("#01ABE9","chartreuse","#1B346C","#F34B1A"),0.7)
      b$Colour <- pftpal[b$pft]
      legendfun <- function()legend("topleft", 
                                    c("Decid. Angio.","Decid. Gymno.","Evergr. Angio.","Evergr. Gymno."), 
                                    col=c("#01ABE9","chartreuse","#1B346C","#F34B1A"), pch=19, cex=0.8)
    }
    if(input$colorby == "None"){
      b$Colour <- alpha("black", 0.5)
    }
    
    
    if(input$logxvar && is.numeric(b$X))b$X <- log10(b$X)
    if(input$logyvar && is.numeric(b$Y))b$Y <- log10(b$Y)
    
    x_lab <- baad_vars_axis_label[baad_vars == input$xvar]
    y_lab <- baad_vars_axis_label[baad_vars == input$yvar]
    
    plot(b$X,b$Y, axes=FALSE, xlab=x_lab, ylab=y_lab, pch=19, col=b$Colour)
    if(exists('legendfun'))legendfun()
    if(input$logxvar)magaxis(1,unlog=1) else axis(1)
    if(input$logyvar)magaxis(2,unlog=2) else axis(2)
  }

  output$text1 <- renderText({ 
    paste("You have selected", nrow(baaddat()), "data points.")
  })
  
  output$baadplot <- renderPlot(
    baadplot_fun(input)
  )
  
  output$downloadplot <- downloadHandler(
    filename = function(){
      "baadplot.png"
    },
    content = function(file) {
      png(file)
      baadplot_fun(input)
      dev.off()
    }
  )
  
  
})
