# Load libraries
library(shiny)
library(dplyr)
library(ggplot2)
library(UShorrorsite)



# UI for the app
ui <- fluidPage(
  br(),
  sidebarLayout(
    sidebarPanel(
      # Dropdown menu to select a state
      selectizeInput("state",
                     "Select a State:",
                     choices = sort(unique(haunted_data$state)),
                     selected = "California")
    ),
    mainPanel(
      # Output plot to show the top haunted locations by city
      plotOutput("location_plot"),

      # Output text summary below the plot
      verbatimTextOutput("summary_text")
    )
  )
)

# Server logic
server <- function(input, output, session) {

  # Plot the top 10 cities with the most haunted locations in the selected state
  output$location_plot <- renderPlot({
    state_data <- haunted_data %>%
      filter(state == input$state) %>%
      count(city, name = "location_count") %>%
      arrange(desc(location_count)) %>%
      slice_head(n = 10)  # Select top 10 cities by haunted location count

    ggplot(state_data, aes(x = reorder(city, location_count), y = location_count)) +
      geom_bar(stat = "identity", fill = "darkred") +
      labs(title = paste("Top 10 Haunted Locations by City in", input$state),
           x = "City",
           y = "Number of Haunted Locations") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })

  # Generate a summary of the most haunted city, total hauntings, and average hauntings
  output$summary_text <- renderText({
    state_data <- haunted_data %>%
      filter(state == input$state) %>%
      count(city, name = "location_count")

    most_haunted_city <- state_data %>%
      slice_max(location_count, n = 1) %>%
      pull(city)

    total_hauntings <- sum(state_data$location_count)  # Total hauntings in the state
    avg_hauntings <- mean(state_data$location_count)  # Average hauntings per city

    # Create the summary text
    paste("Summary for", input$state, ":\n",
          "- Most haunted city:", most_haunted_city, "\n",
          "- Total number of haunted locations:", total_hauntings, "\n",
          "- Average haunted locations per city:", round(avg_hauntings, 2))
  })
}

# Run the app
shinyApp(ui, server)
