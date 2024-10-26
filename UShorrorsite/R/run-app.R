#' @export
run_app <- function() {
  app_dir <- system.file("haunted-app", package = "UShorrorsite")
  shiny::runApp(app_dir, display.mode = "normal")
}
