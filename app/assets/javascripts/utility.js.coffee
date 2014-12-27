#= require jquery

# ------------------------------------------------
# UTILITY->JS ------------------------------------
# ------------------------------------------------
@trace = (message) ->
  try
    console.log message
  catch error
    alert message

# ------------------------------------------------
# ELEMENTS->HIDING -------------------------------
# ------------------------------------------------
@hideElements = (selectors) ->
  $(selectors.join(",")).hide()

@hide = (selectors...) ->
  hideElements selectors

@hideImportant = (selectors...) ->
  $(selectors.join(",")).css
    display: "none !important"

