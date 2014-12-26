#= require pre
#= require_self

# ------------------------------------------------
# BOOTSTRAP --------------------------------------
# ------------------------------------------------
@GM_start = (unsafeWindow) ->
  GM_bootstrap unsafeWindow,
    name:
      system: "font_awesome_cheatsheet"
    remote:
      domain: "localhost:3000",
      suffix: "/assets/"

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

performPost()
 
