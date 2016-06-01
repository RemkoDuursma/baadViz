#' Visualize the Biomass And Allometry Database (BAAD)
#' You must have the baad.data package installed. Go here to install it:
#' https://github.com/traitecoevo/baad.data
#' @export
#' @importFrom shiny runApp
run_baadviz <- function() {
  
  r <- require(baad.data)
  if(!r)stop("Install the baad.data package from github.com/traitecoevo/baad.data", 
             .call=FALSE)
  
  appDir <- system.file("shiny-apps", "plotbaad", package = "baadviz")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `baadviz`.", 
         call. = FALSE)
  }
  
  runApp(appDir, display.mode = "normal", launch.browser=TRUE)
}
