#' Generate a Formatted Regression Table
#'
#' Takes a fitted linear model object and formats its summary into a clean gt table
#' with confidence intervals and formatted numeric values.
#'
#' @param model A fitted linear model (`lm`) object.
#' @param title Optional character string for the table title.
#' @param subtitle Optional character string for the table subtitle.
#' @param source Optional character string for the table source note.
#'
#' @return A `gt_tbl` object.
#' @export

make_table = function(model,
                       title = "Linear Regression Results",
                       subtitle = "Coefficient table",
                       source = "Source: OECD ICT Access and Usage by Individuals") {

  broom::tidy(model, conf.int = TRUE) |>
    gt::gt() |>
    gt::fmt_number(decimals = 2) |>
    gt::fmt_number(columns = gt::matches("p.value"), decimals = 3) |>
    gt::cols_label(
      term = "Term",
      estimate = "Estimate",
      std.error = "Std. Error",
      statistic = "Statistic",
      p.value = "P-Value",
      conf.low = "Conf. Low",
      conf.high = "Conf. High"
    ) |>
    gt::cols_align(align = "right", columns = gt::where(is.numeric)) |>
    gt::tab_header(title = title, subtitle = subtitle) |>
    gt::tab_source_note(source)
}
