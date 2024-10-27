# UShorrorsite - Haunted Places in the U.S.

UShorrorsite is an R package that includes data and tools to explore haunted locations across the United States. This dataset contains information about haunted places in various cities, with details such as descriptions, coordinates, and other attributes. The package also includes an interactive Shiny app to visualize and explore the most haunted locations in selected cities.

## Installation

You can install the development version of UShorrorsite from GitHub with the following commands:

```
# If you don't have devtools installed, first install it:
install.packages("devtools")

# Then install UShorrorsite from GitHub
devtools::install_github("nsal0017/UShorrorsite")

```
## Shiny App Overview

The package includes a Shiny app (haunted-app) that allows users to interactively explore the most haunted locations in a selected city. The app provides:

- **City Selection**: Users can select a city from a dropdown menu, powered by server-side processing to handle large datasets efficiently.

- **Haunted Locations Plot**: For the selected city, the app displays a plot showing the most haunted locations based on the number of hauntings.

- **Summary Statistics**: Below the plot, the app provides a summary of the most haunted location, the total number of hauntings, and the average number of hauntings per location in the selected city.

```
library(UShorrorsite)
app_dir <- system.file("haunted-app", package = "UShorrorsite")
shiny::runApp(app_dir)
```


