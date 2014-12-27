# ================================================
# COFFEE->
# ================================================

# ------------------------------------------------
# GM->BOOTSTRAP ----------------------------------
# ------------------------------------------------
@GM_on_documentReady = () ->
  trace "GM_on_documentReady"

  # Inject Script
  s = document.createElement("script")
  
  s.type = "text/javascript"
  s.src  = GM.remote.script
  
  $("head").append s

  # Inject Stylesheet
  ss = document.createElement("link")

  ss.rel  = "stylesheet"
  ss.href = GM.remote.stylesheet
  ss.type = "text/css"

  $("head").append ss
  
  # Call script-defined GM_main
  GM_main()

  # Then generic GM_post
  GM_post()

# ------------------------------------------------
# GM->BOOTSTRAP ----------------------------------
# ------------------------------------------------
@GM_bootstrap = () ->
  trace "GM_bootstrap"
  
  $.extend GM, GM_config

  div = document.createElement("div")

  div.id = "GM_load_block"

  css =
    position: "fixed"
    top: "0px"
    right: "0px"
    bottom: "0px"
    left: "0px"
    background: "#ffffff"
    "z-index": "999999"

  for prop of css
    div.style[prop] = css[prop]

  document.getElementsByTagName("html")[0].appendChild div
  
  (GM_initializeWhenjQueryReady = ->

    # jQuery is not ready
    # --------------------------------------------
    return setTimeout(GM_initializeWhenjQueryReady, 1) unless unsafeWindow.$

    # jQuery is ready
    # --------------------------------------------
    $.extend GM.remote,
      urlNoProtocol: "//#{GM.domain}#{GM.remote.suffix}"
    
    $.extend GM.remote,
      url: "#{GM.remote.protocol}:#{GM.remote.urlNoProtocol}"
    
    $.extend GM.remote,
      stylesheet:    "#{GM.remote.urlNoProtocol}/#{GM.name.system}.css"
      script:        "#{GM.remote.urlNoProtocol}/#{GM.name.system}.js"

    $(document).ready GM_on_documentReady

    true

  )()

# ------------------------------------------------
# GM->START --------------------------------------
# ------------------------------------------------
@GM_start = () ->
  trace "GM_start"

  GM_bootstrap.call this

# ------------------------------------------------
# GM->POST ---------------------------------------
# ------------------------------------------------
@GM_post = () ->
  trace "GM_post"

  $("body").show()
  $("#GM_load_block").remove()

