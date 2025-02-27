#' Create project folder
#'
#' Create a project folder with Makefile and sub-folders: data-raw, data,
#' scripts, docs, eda, and reports.
#' Available from RStudio: File > New Project... > New Directory > DCL project
#'
#' @param path Path for project folder.
#'
#' @export
#'
make_project <- function(path) {
  folders <-
    c(
      "Raw data" = "data-raw",
      "Processed data" = "data",
      "Scripts" = "scripts",
      "Docs" = "docs",
      "EDA" = "eda",
      "Reports" = "reports"
    )
  create_readme <- function(path, title, ...) {
    path_readme <- file.path(path, "README.md")
    file.create(path_readme, showWarnings = FALSE)
    writeLines(text = paste0("# ", title, "\n", ...), con = path_readme)
  }

  dir.create(path = path, showWarnings = FALSE, recursive = TRUE)
  create_readme(
    path = path,
    title = "Project",
    "\nFor explanation of how to use see ",
    "[example project](https://github.com/dcl-docs/project-example).\n"
  )
  file.copy(
    from = system.file("resources/project/.gitignore", package = "dcl"),
    to = path
  )
  file.copy(
    from = system.file("resources/project/Makefile", package = "dcl"),
    to = path
  )

  for (i in seq_along(folders)) {
    path_folder <- file.path(path, folders[[i]])
    dir.create(path = path_folder, showWarnings = FALSE, recursive = TRUE)
    create_readme(path = path_folder, title = names(folders)[[i]])
  }
}
