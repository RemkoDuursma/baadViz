library(magicaxis)
library(scales)

shinyServer(function(input, output, session) {

  # Filter the movies, returning a data frame
  baaddat <- reactive({
    
    vegetation <- input$vegetation
    growingCondition <- input$growingCondition
    studyName <- input$studyName
    studyName2 <- input$studyName2
    colorby <- input$colorby
    baad$pft <- as.factor(baad$pft)

    # Do PFT here, because we want specific colours    
    if(input$colorby == "Plant functional type"){
      pftpal <- c("#01ABE9","chartreuse","#1B346C","#F34B1A")
      baad$Colour <- alpha(pftpal,0.7)[baad$pft]
    }

        
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
    #xvar_name <- names(axis_vars)[axis_vars == input$xvar]
    #yvar_name <- names(axis_vars)[axis_vars == input$yvar]
    
    b <- baaddat()
    
    X <- b[,input$xvar]
    Y <- b[,input$yvar]
    b <- b[!is.na(X)&!is.na(Y),]
    if(nrow(b) == 0)return(NULL)

    if(input$colorby == "Study Name"){
      b$studyName <- as.factor(b$studyName)
      b$Colour <- rainbow(nlevels(b$studyName))[b$studyName]
    }
    if(input$colorby == "Vegetation"){
      b$Vegetation <- as.factor(b$Vegetation)
      b$Colour <- rainbow(nlevels(b$Vegetation))[n$Vegetation]
    }
    
    if(input$colorby == "None"){
      b$Colour <- alpha("black", 0.5)
    }
    
    
    if(input$logxvar && is.numeric(X))X <- log10(X)
    if(input$logyvar && is.numeric(Y))Y <- log10(Y)
    
    x_lab <- dictio$label[dictio$variable == input$xvar]
    y_lab <- dictio$label[dictio$variable == input$yvar]
    
    plot(X,Y, axes=FALSE, xlab=x_lab, ylab=y_lab, pch=19, col=b$Colour)
    if(input$logxvar)magaxis(1,unlog=1) else axis(1)
    if(input$logyvar)magaxis(2,unlog=2) else axis(2)
  }

  output$text1 <- renderText({ 
    paste("You have selected", nrow(baaddat()), "data points.")
  })
  
  output$baadplot <- renderPlot(
    baadplot_fun(input)
  )
  
  
})
