library(magicaxis)

shinyServer(function(input, output, session) {

  # Filter the movies, returning a data frame
  baaddat <- reactive({
    
    minht <- input$minht
    vegetation <- input$vegetation
    growingCondition <- input$growingCondition
    studyName <- input$studyName
    
    # Apply filters
    if(minht > 0)baad <- baad[baad$h.t > minht,]
    
    if(vegetation != "All")baad <- baad[baad$vegetation %in% vegetation,]
    baad <- baad[baad$growingCondition %in% growingCondition,]
    if(studyName != "")baad <- baad[baad$studyName == studyName,]
    
    baad <- as.data.frame(baad)

  baad
  })
  
  baadplot_fun <- function(input){
    #xvar_name <- names(axis_vars)[axis_vars == input$xvar]
    #yvar_name <- names(axis_vars)[axis_vars == input$yvar]
    
    b <- baaddat()
    if(nrow(b) == 0)return(NULL)
    X <- b[,input$xvar]
    Y <- b[,input$yvar]
    if(input$logxvar && is.numeric(X))X <- log10(X)
    if(input$logyvar && is.numeric(Y))Y <- log10(Y)
    
    x_lab <- dictio$label[dictio$variable == input$xvar]
    y_lab <- dictio$label[dictio$variable == input$yvar]
    
    plot(X,Y, axes=FALSE, xlab=x_lab, ylab=y_lab)
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
