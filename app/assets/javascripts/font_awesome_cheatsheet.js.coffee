#= require pre
#= require_self

# ------------------------------------------------
# BOOTSTRAP --------------------------------------
# ------------------------------------------------
@GM_start = () ->
  GM_bootstrap.call this,
    name:
      system: "font_awesome_cheatsheet"
    remote:
      domain: "localhost:3000",
      suffix: "/assets/"

@GM_main = () ->

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

