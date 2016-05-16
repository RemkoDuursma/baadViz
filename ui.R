shinyUI(fluidPage(
  titlePanel("BAAD Viz"),
  fluidRow(
    column(3,
      wellPanel(
        h4("Filter"),
        sliderInput("minht", "Minimum tree height",
          0, 120, 0, step = 10),
        selectInput("vegetation", "Vegetation Type",
          c("All","BorF","TropRF","TempF","Sh","TropSF","Wo","TempRF","Sav","Gr")
        ),
        checkboxGroupInput("growingCondition", "Growing Environment:",
                           c("Plantation, managed" = "PM",
                             "Field, wild" = "FW",
                             "Glasshouse / grow house" = "GH",
                             "Field, experimental" = "FE",
                             "Plantation, unmanaged" = "PU",
                             "Common garden" = "CG",
                             "Unclassified" = ""),
                           selected=c("PM","FW","GH","FE","PU","CG","")),
        
        textInput("studyName", "Name of study (e.g. Burger1953)")
      ),
      wellPanel(
        selectInput("xvar", "X-axis variable", dictio$variable, selected = "h.t"),
        checkboxInput("logxvar","Log-transform X variable",TRUE),
        selectInput("yvar", "Y-axis variable", dictio$variable, selected = "m.lf"),
        checkboxInput("logyvar","Log-transform Y variable",TRUE)
      )
    ),
    mainPanel(
      plotOutput("baadplot"),
      textOutput("text1")
    )
    
    
  )
))
