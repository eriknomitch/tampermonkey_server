#= require pre

trace "GM_config ="

@GM_config =
  name:
    system: "font_awesome_cheatsheet"

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

