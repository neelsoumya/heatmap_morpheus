#################################################
# Example code to plot
#	  heatmaps using
#	  morpheus in R
# 
# Adapted from:
#   https://github.com/cmap/morpheus.R
#
# Installation:
#   devtools::install_github('cmap/morpheus.R')
#
#################################################


##########################
# Load library
##########################
library(morpheus)
library(shiny)

##########################
# Load synthetic data
##########################
x <- t(mtcars)

##########################
# column annotations
# with bar on top
##########################
columnAnnotations <- data.frame(annotation1=1:32, annotation2=sample(LETTERS[1:3], ncol(x),
  replace = TRUE))

##########################
# Plot heatmap
##########################
morpheus(x,
  colorScheme=list(scalingMode="relative", colors=heat.colors(3)),
  columnAnnotations=columnAnnotations,
  columns=list(list(field='id', display=list('text')), list(field='annotation2',
   highlightMatchingValues=TRUE, display=list('color'))))



##########################
# Shiny interface
##########################

ui <- fluidPage(
  titlePanel(h3("Example")),
  mainPanel(
    morpheusOutput("heatmap")
  )
)

server <- function(input, output) {
  output$heatmap <- renderMorpheus({
    x <- matrix(rnorm(200), 20)
    y <- data.frame(a=letters[1:10], b=rep(c("g","h"),5), stringsAsFactors = F)
    morpheus(x, columnAnnotations = y)
  })
}

shinyApp(ui, server)

