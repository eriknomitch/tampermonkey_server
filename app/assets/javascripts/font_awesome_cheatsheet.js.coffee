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
  html = $(element).html()

  html =  html.replace /\[/, " - "
  html =  html.replace /\]/, ""

  $(element).html(html)
