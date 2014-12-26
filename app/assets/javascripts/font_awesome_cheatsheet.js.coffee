#= require pre
#= require_self
#= require post

# ------------------------------------------------
# SELECTORS->HIDDEN ------------------------------
# ------------------------------------------------
hide ".jumbotron", ".hidden-print", ".page-header"

# ------------------------------------------------
# MODIFICATIONS ----------------------------------
# ------------------------------------------------
$("span.muted").each (index, element) ->
  $(element).html (htmlIndex, html) ->
    html =  html.replace /\[/, " - "
    html =  html.replace /\]/, ""
