#= require pre
#= require_self
#= require post

# ------------------------------------------------
# SELECTORS->HIDDEN ------------------------------
# ------------------------------------------------
hide ".jumbotron", ".hidden-print", ".page-header"

# ------------------------------------------------
# STYLING ----------------------------------------
# ------------------------------------------------
$(".container").css
  "padding-top": "20px"

$(".row div").css
  "font-size": "15px"
  "padding-bottom": "20px"
  "color": "#a7a7a7"

$(".row div .muted:hover").css
  "opacity": "0.5"

$("i").css
  "font-size": "26px"
  "color": "#000"

$("#wrap").css
  "margin-bottom": "0x"
  "padding-bottom": "5px"
