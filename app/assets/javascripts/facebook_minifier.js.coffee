#= require pre

# ------------------------------------------------
# UM->CONFIG -------------------------------------
# ------------------------------------------------
@UM_config =
  name:
    system: "facebook_minifier"
  use:
    stylesheet: false

# ------------------------------------------------
# UM->MAIN ---------------------------------------
# ------------------------------------------------
@UM_main = () ->

  trace "UM_main"

  UM_hideWhenReady "#mainContainer",
    ready: () ->

      $("#mainContainer").parent().html """
      <div id="um_links">
        <a href="/events">Events</a>
        <span>&bull;</span>
        <a href="/messages">Messages</a>
      </div>
      """

      $("#um_links").css
        margin: "30px"
        "margin-top": "60px"
        "text-align": "center"
      
      $("#um_links a").css
        "font-size": "30px"
      
      $("#um_links span").css
        color: "#3b5998"
        "font-size": "30px"
        "padding-left": "10px"
        "padding-right": "10px"

  UM_hideWhenReady "#pagelet_dock"
  UM_hideWhenReady "#pagelet_sidebar"

  this

