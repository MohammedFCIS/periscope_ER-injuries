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
library(neiss)
source("./program/data/app_data.R", local = TRUE)

# -- FUNCTIONS --
count_data <- function(data, count_field) {
  code_data() %>%
    count(.data[[count_field]], wt = weight, sort = TRUE)
}

# -- REACTIVE VARIABLES --
code_data <- reactive({
  req(input$product_code)
  injuries %>%
    filter(prod1 == as.numeric(input$product_code))
})

diagnosis_data <- reactive({
  count_data(code_data(), "diag")
})

body_part_data <- reactive({
  count_data(code_data(), "body_part")
})

location_data <- reactive({
  count_data(code_data(), "location")
})

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
