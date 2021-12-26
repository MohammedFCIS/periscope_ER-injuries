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
source("./program/data/app_data.R", local = TRUE)

# -- VARIABLES --


# -- FUNCTIONS --


# ----------------------------------------
# --          SHINY SERVER CODE         --
# ----------------------------------------
updateSelectInput(session,
                  "product_code",
                  selected = character(0),
                  choices  = prod_codes)
