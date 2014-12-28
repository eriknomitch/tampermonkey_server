# ================================================
# COFFEE->
# ================================================

# ------------------------------------------------
# UM->ON->DOCUMENT-READY -------------------------
# ------------------------------------------------
@UM_on_documentReady = () ->
  trace "UM_on_documentReady"

  # Inject Script
  UM_injectStylesheet()

  # Inject Stylesheet
  link = document.createElement("link")

  link.rel  = "stylesheet"
  link.href = UM.remote.stylesheet
  link.type = "text/css"

  $("head").append link
  
  # Call script-defined UM_main
  UM_main()

  # Then generic UM_post
  UM_post()

@UM_injectStylesheet = () ->
  return unless UM.use.stylesheet

  trace "injecting"
  
  script = document.createElement("script")
  
  script.type = "text/javascript"
  script.src  = UM.remote.script
  
  $("head").append script

# ------------------------------------------------
# UM->BOOTSTRAP ----------------------------------
# ------------------------------------------------
@UM_bootstrap = () ->
  trace "UM_bootstrap"
  
  # Extend the UM config with the user-supplied config
  # ----------------------------------------------
  $.extend UM, UM_config

  # Create/inject Load Block div
  # ----------------------------------------------
  div = document.createElement("div")

  div.id = "UM_load_block"

  css =
    position:  "fixed"
    top:        "0px"
    right:      "0px"
    bottom:     "0px"
    left:       "0px"
    background: "#ffffff"
    "z-index":  "999999"

  for prop of css
    div.style[prop] = css[prop]

  document.getElementsByTagName("html")[0].appendChild div
 
  # Initialize UberMonkey when jQuery is ready
  # ----------------------------------------------
  (UM_initializeWhenjQueryReady = ->

    # jQuery is not ready
    # --------------------------------------------
    return setTimeout(UM_initializeWhenjQueryReady, 1) unless unsafeWindow.$

    # jQuery is ready
    # --------------------------------------------
    $.extend UM.remote,
      urlNoProtocol: "//#{UM.domain}#{UM.remote.suffix}"
    
    $.extend UM.remote,
      url: "#{UM.remote.protocol}:#{UM.remote.urlNoProtocol}"
    
    $.extend UM.remote,
      stylesheet:    "#{UM.remote.url}/#{UM.name.system}.css"
      script:        "#{UM.remote.url}/#{UM.name.system}.js"

    $(document).ready UM_on_documentReady

    true

  )()

# ------------------------------------------------
# UM->START --------------------------------------
# ------------------------------------------------
@UM_start = () ->
  trace "UM_start"

  UM_bootstrap.call this

# ------------------------------------------------
# UM->POST ---------------------------------------
# ------------------------------------------------
@UM_post = () ->
  trace "UM_post"

  $("body").show()
  $("#UM_load_block").remove()

#@UM_hideWhenReady = (selector, options={}) ->
  #for selector in selectors
    #$(selector).ready () ->
      #$(selector).hide().css
        #display: "none !important"

@UM_hideWhenReady = (selector, options={}) ->

  $(selector).ready () ->

    $(selector).hide().css
      display: "none !important"

    options.ready() if options.ready

