# ================================================
# COFFEE->
# ================================================

# ------------------------------------------------
# UM->ON->DOCUMENT-READY -------------------------
# ------------------------------------------------
@UM_on_documentReady = () ->
  trace "UM_on_documentReady"

  UM_prepareWindowOnPushState()
  UM_injectStylesheet()

  UM_main() # This is Ubermonkey script's defined UM_main

  UM_post()

@UM_prepareWindowOnPushState = () ->
  return unless UM.restartOn.pushState

    # http://stackoverflow.com/questions/4570093/how-to-get-notified-about-changes-of-the-history-via-history-pushstate 
    ((history) ->
      pushState = history.pushState
      history.pushState = (state) ->
        history.onpushstate state: state  if typeof history.onpushstate is "function"

        # ... whatever else you want to do
        # maybe call onhashchange e.handler
        pushState.apply history, arguments

      return
    ) window.history

    window.onpopstate = history.onpushstate = (newState) ->
      UM_start()

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

