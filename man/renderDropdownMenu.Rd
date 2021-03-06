% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/menuOutput.R
\name{renderDropdownMenu}
\alias{renderDropdownMenu}
\title{Create a dropdown menu output (server side)}
\usage{
renderDropdownMenu(expr, env = parent.frame(), quoted = FALSE,
  func = NULL)
}
\arguments{
\item{expr}{An expression that returns a Shiny tag object, \code{\link{HTML}},
or a list of such objects.}

\item{env}{The environment in which to evaluate \code{expr}.}

\item{quoted}{Is \code{expr} a quoted expression (with \code{quote()})? This
is useful if you want to save an expression in a variable.}

\item{func}{A function that returns a Shiny tag object, \code{\link{HTML}},
  or a list of such objects (deprecated; use \code{expr} instead).}
}
\description{
This is the server-side function for creating a dynamic dropdown menu.
}
\examples{
## Only run this example in interactive R sessions
if (interactive()) {
library(shiny)

# Example message data in a data frame
messageData <- data.frame(
  from = c("Admininstrator", "New User", "Support"),
  message = c(
    "Sales are steady this month.",
    "How do I register?",
    "The new server is ready."
  ),
  stringsAsFactors = FALSE
)

ui <- dashboardPage(
  dashboardHeader(
    title = "Dynamic menus",
    dropdownMenuOutput("messageMenu")
  ),
  dashboardSidebar(),
  dashboardBody(
    fluidRow(
      box(
        title = "Controls",
        sliderInput("slider", "Number of observations:", 1, 100, 50)
      )
    )
  )
)

server <- function(input, output) {
  output$messageMenu <- renderUI({
    # Code to generate each of the messageItems here, in a list. messageData
    # is a data frame with two columns, 'from' and 'message'.
    # Also add on slider value to the message content, so that messages update.
    msgs <- apply(messageData, 1, function(row) {
      messageItem(
        from = row[["from"]],
        message = paste(row[["message"]], input$slider)
      )
    })

    dropdownMenu(type = "messages", .list = msgs)
  })
}

shinyApp(ui, server)
}
}
\seealso{
\code{\link{dropdownMenuOutput}} for the corresponding UI-side
  function, and \code{\link{dropdownMenu}} for the corresponding function for
  generating static menus.
}

