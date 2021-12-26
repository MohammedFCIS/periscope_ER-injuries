# ----------------------------------------
# --          PROGRAM ui_body.R         --
# ----------------------------------------
# USE: Create UI elements for the
#      application body (right side on the
#      desktop; contains output) and
#      ATTACH them to the UI by calling
#      add_ui_body()
#
# NOTEs:
#   - All variables/functions here are
#     not available to the UI or Server
#     scopes - this is isolated
# ----------------------------------------

# -- IMPORTS --



# ----------------------------------------
# --      BODY ELEMENT CREATION         --
# ----------------------------------------

# -- Create Elements
diag <- box(
  id          = "diag_box",
  title       = "Diagnosis",
  width       = 4,
  collapsible = TRUE,
  collapsed   = FALSE,
  fluidRow(column(width = 12,
                  downloadableTableUI("diag_table",
                               list("csv", "tsv"),
                               singleSelect = TRUE,
                               "Download diagnosis data"))))

body_part <- box(
  id          = "body_part_box",
  title       = "Body Part",
  width       = 4,
  collapsible = TRUE,
  collapsed   = FALSE,
  fluidRow(column(width = 12,
                  downloadableTableUI("body_part_table",
                                      list("csv", "tsv"),
                                      singleSelect = TRUE,
                                      "Download body part data"))))

location <- box(
  id          = "location_box",
  title       = "Location",
  width       = 4,
  collapsible = TRUE,
  collapsed   = FALSE,
  fluidRow(column(width = 12,
                  downloadableTableUI("location_table",
                                      list("csv", "tsv"),
                                      singleSelect = TRUE,
                                      "Download location data"))))

age_sex <- box(
  id          = "age_sex_box",
  title       = "Age/Sex",
  width       = 12,
  collapsible = TRUE,
  collapsed   = FALSE,
  fluidRow(canvasXpressOutput("age_sex_table")))

# -- Register Elements in the ORDER SHOWN in the UI
add_ui_body(list(diag, body_part, location, age_sex))
