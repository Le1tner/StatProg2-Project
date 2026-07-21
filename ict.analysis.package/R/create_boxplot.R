#' Create Standardized Boxplots for ICT Data
#'
#' Generates a ggplot boxplot comparing a chosen categorical variable against
#' the observed values (`OBS_VALUE`) of a selected ICT indicator.
#' Optionally facets the plot by another grouping variable.
#'
#' @details
#' **Note on Dataset Preparation:** The input dataset should be filtered to a specific
#' indicator (e.g., via `MEASURE`) and unit of measurement (e.g., `UNIT_MEASURE == "PT_POP"`)
#' beforehand so that `OBS_VALUE` correctly represents percentages (0-100\%) or the
#' intended target metric.
#'
#' @param data A data frame containing `OBS_VALUE` and the target columns.
#' @param x_value Character string specifying the column name to place on the x-axis (e.g., "EDUCATION_LEVEL").
#' @param title Character string for the main plot title.
#' @param subtitle Optional character string for the plot subtitle.
#' @param facet_var Optional character string specifying a column name to facet by (e.g., "AGE"). Defaults to `NULL` (no faceting).
#' @param source Optional character string for the plot caption/source note. Defaults to the OECD reference.
#'
#' @return A `ggplot` object.
#' @export

create_boxplot = function(data,
                               x_value,
                               title,
                               subtitle = NULL,
                               facet_var = NULL,
                               source = "Source: OECD ICT Access and Usage by Individuals") {

  boxplot = ggplot2::ggplot(
    data,
    ggplot2::aes(x = factor(.data[[x_value]]), y = .data[["OBS_VALUE"]])
  ) +
    ggplot2::geom_boxplot() +
    ggplot2::theme_bw() +
    ggplot2::labs(
      x = x_value,
      y = "Part of the population",
      title = title,
      subtitle = subtitle,
      caption = source
    ) +
    ggplot2::scale_y_continuous(labels = scales::label_number(suffix = "%"))

  if (!is.null(facet_var)) {
    boxplot <- boxplot + ggplot2::facet_wrap(ggplot2::vars(.data[[facet_var]]))
  }

  return(boxplot)
}
