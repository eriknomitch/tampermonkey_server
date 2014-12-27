#= require pre

# ------------------------------------------------
# GM->CONFIG -------------------------------------
# ------------------------------------------------
@GM_config =
  name:
    system: "facebook_minifier"

# ------------------------------------------------
# GM->MAIN ---------------------------------------
# ------------------------------------------------
@GM_main = () ->

  $("#mainContainer").ready () ->

    trace "READY"

    $("#mainContainer").hide().css
      display: "none !important"

  #trace document
  #trace unsafeWindow

  this

