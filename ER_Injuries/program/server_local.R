# ----------------------------------------
# --       PROGRAM server_local.R       --
# ----------------------------------------
# USE: Session-specific variables and
#      functions for the main reactive
#      shiny server functionality.  All
#      code in this file will be put into
#      the framework inside the call to
#      shinyServer(function(input, output, session)
#      in server.R
#
# NOTEs:
#   - All variables/functions here are
#     SESSION scoped and are ONLY
#     available to a single session and
#     not to the UI
#
#   - For globally scoped session items
#     put var/fxns in server_global.R
#
# FRAMEWORK VARIABLES
#     input, output, session - Shiny
#     ss_userAction.Log - Reactive Logger S4 object
# ----------------------------------------

# -- IMPORTS --
library(dplyr)
library(forcats)
library(tidyr)
library(vroom)
source("./program/data/app_data.R", local = TRUE)

# -- FUNCTIONS --
count_top <- function(df, var, n = 5) {
  df %>%
    mutate({{var}} := fct_lump(fct_infreq(.data[[var]]), n = n)) %>%
    group_by(.data[[var]]) %>%
    summarise(n = as.integer(sum(weight)))
}

# -- REACTIVE VARIABLES --
code_data <- reactive({
  req(input$product_code)
  injuries %>%
    filter(prod_code == as.numeric(input$product_code))
})

age_sex_summary <- reactive({
  code_data() %>%
    count(age, sex, wt = weight) %>%
    left_join(population, by = c("age", "sex")) %>%
    mutate(rate = n / population * 1e4)
})

diagnosis_data <- reactive({
  count_top(code_data(), "diag")
})

body_part_data <- reactive({
  count_top(code_data(), "body_part")
})

location_data <- reactive({
  count_top(code_data(), "location")
})

narrative_sample <- eventReactive(
  list(input$story, code_data()),
  code_data() %>% pull(narrative) %>% sample(1)
)


# ----------------------------------------
# --          SHINY SERVER CODE         --
# ----------------------------------------
updateSelectInput(session,
                  "product_code",
                  selected = character(0),
                  choices  = prod_codes)

observeEvent(input$product_code, {
  req(input$product_code)
  downloadableTable("diag_table",
                    ss_userAction.Log,
                    "diag_table",
                    list(csv = diagnosis_data, tsv = diagnosis_data),
                    diagnosis_data,
                    rownames = FALSE)

  downloadableTable("body_part_table",
                    ss_userAction.Log,
                    "body_part_table",
                    list(csv = body_part_data, tsv = body_part_data),
                    body_part_data,
                    rownames = FALSE)

  downloadableTable("location_table",
                    ss_userAction.Log,
                    "location_table",
                    list(csv = location_data, tsv = location_data),
                    location_data,
                    rownames = FALSE)
})

output$age_sex_plot <- renderCanvasXpress({
  if(NROW(age_sex_summary()) == 0) {
    return(NULL)
  }

  selected_dist <- input$plot_option
  cx.data <- age_sex_summary() %>%
    select(sex, age, selected_dist) %>%
    pivot_wider(names_from = age, values_from = selected_dist) %>%
    as.data.frame()
  row.names(cx.data) <- cx.data$sex
  cx.data$sex <- NULL

  canvasXpress(
    data = cx.data,
    graphOrientation="vertical",
    graphType="Line",
    xAxisTitle = "Estimated number of injuries"
  )
})

output$narrative_txt <- renderText(narrative_sample())
