# ----------------------------------------
# --       PROGRAM ui_sidebar.R         --
# ----------------------------------------
# USE: Create UI elements for the
#      application sidebar (left side on
#      the desktop; contains options) and
#      ATTACH them to the UI by calling
#      add_ui_sidebar_basic() or
#      add_ui_sidebar_advanced()
#
# NOTEs:
#   - All variables/functions here are
#     not available to the UI or Server
#     scopes - this is isolated
# ----------------------------------------

# -- IMPORTS --


# ----------------------------------------
# --     SIDEBAR ELEMENT CREATION       --
# ----------------------------------------

# -- Create Basic Elements
prod_codes_input <- selectizeInput(inputId  = "product_code",
                                   label    = "Product",
                                   choices  = NULL,
                                   multiple = FALSE,
                                   selected = character(0),
                                   options  = list(placeholder = "Type/Click then Select"))
plot_option      <- selectizeInput(inputId  = "plot_option",
                                   label    = "Distribution",
                                   choices  = c("Rate" = "rate", "Count" = "n"),
                                   multiple = FALSE,
                                   selected = "rate")

# -- Register Basic Elements in the ORDER SHOWN in the UI
add_ui_sidebar_basic(list(prod_codes_input, plot_option), tabname = "Setup")



# -- Create Advanced Elements


# -- Register Advanced Elements in the ORDER SHOWN in the UI
add_ui_sidebar_advanced()
