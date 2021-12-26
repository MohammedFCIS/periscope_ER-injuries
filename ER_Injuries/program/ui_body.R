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
  title       = "diagnosis",
  width       = 4,
  collapsible = TRUE,
  collapsed   = FALSE,
  fluidRow(tableOutput("diag_table")))

body_part <- box(
  id          = "body_part_box",
  title       = "Body Part",
  width       = 4,
  collapsible = TRUE,
  collapsed   = FALSE,
  fluidRow(tableOutput("body_part_table")))

location <- box(
  id          = "location_box",
  title       = "Location",
  width       = 4,
  collapsible = TRUE,
  collapsed   = FALSE,
  fluidRow(tableOutput("location_table")))

age_sex <- box(
  id          = "age_sex_box",
  title       = "Age/Sex",
  width       = 12,
  collapsible = TRUE,
  collapsed   = FALSE,
  fluidRow(tableOutput("age_sex_table")))

# -- Register Elements in the ORDER SHOWN in the UI
add_ui_body(list(diag, body_part, location, age_sex))
