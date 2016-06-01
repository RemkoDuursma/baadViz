shinyUI(fluidPage(
  titlePanel("Visualize BAAD"),

  plotOutput("baadplot"),
  downloadButton('downloadplot','Save plot (PNG)'),
  hr(),
  textOutput("text1"),
  hr(),
  
    fluidRow(
    column(3,
        selectInput("vegetation", "Vegetation Type",
          c("All", baad_vegetation_types),
          selected="All"
        ),
        checkboxGroupInput("growingCondition", "Growing Environment:",
                           c("Plantation, managed" = "PM",
                             "Field, wild" = "FW",
                             "Glasshouse / grow house" = "GH",
                             "Field, experimental" = "FE",
                             "Plantation, unmanaged" = "PU",
                             "Common garden" = "CG",
                             "Unclassified" = ""),
                           selected=c("PM","FW","GH","FE","PU","CG",""))
      ),
      column(3,
        selectInput("xvar", "X-axis variable", baad_vars_label, selected = "height"),
        checkboxInput("logxvar","Log-transform X variable",TRUE),
        selectInput("yvar", "Y-axis variable", baad_vars_label, selected = "leaf mass"),
        checkboxInput("logyvar","Log-transform Y variable",TRUE)
      ),
    column(3,
           radioButtons("howstudy", "How to use selection:",
                        choices=list("Subset"="subset","Overlay"="overlay"),
                        selected="subset"),
           selectInput("studyName", "Study name:", 
                       c("All",sort(unique(baad$studyName))),
                       selected="All"),
           selectInput("studyName2", "Second study name:", 
                       c("None",sort(unique(baad$studyName))),
                       selected="None")
    ),
    column(3,
           selectInput("colorby", "Set colour by:",
                       c("None","Species","Plant functional type","Vegetation","Study Name"),
                       selected="None"
                       ),
           selectInput("pchpalette", "Palette:",
                       c("rainbow","rich.colors")
                       )
    )
    
    )

    
    
  ))
