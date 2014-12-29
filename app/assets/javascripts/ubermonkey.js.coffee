# ================================================
# COFFEE->
# ================================================

# ------------------------------------------------
# UM->ON->DOCUMENT-READY -------------------------
# ------------------------------------------------
$.extend UM,
  
  # ----------------------------------------------
  # UM->PREPARATION ------------------------------
  # ----------------------------------------------
  onDocumentReady: () ->
    trace "UM.onDocumentReady"

    $.extend UM.deferreds,
      script:          $.Deferred()
      stylesheet:      $.Deferred()
      main:            $.Deferred()
      windowPushState: $.Deferred()

    # FIX: Define/use Object.values
    $.when(UM.deferreds.script, UM.deferreds.stylesheet, UM.deferreds.main, UM.deferreds.windowPushState).done () ->
      UM.post()

    # Injections
    UM.injectUMScript()
    UM.injectUMStylesheet()

    # Handle push state
    UM.prepareWindowOnPushState()

    # This is Ubermonkey script's defined UM.main
    UM.main()

    UM.deferreds.main.resolve()

  prepareWindowOnPushState: () ->

    unless UM.restartOn.pushState
      UM.deferreds.windowPushState.resolve()
      return

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
        UM.start()

      UM.deferreds.windowPushState.resolve()

  injectUMScript: () ->
    script = document.createElement("script")
    
    script.type = "text/javascript"
    script.src  = UM.remote.script
  
    # This will call the user-defined UM.main
    $("head").append script

    # FIX: Have a real check...
    UM.deferreds.script.resolve()

  injectUMStylesheet: () ->
    return unless UM.use.stylesheet
    
    trace "UM.injectUMStylesheet"
    
    # http://www.phpied.com/when-is-a-stylesheet-really-loaded/
    style = document.createElement("style")
    style.textContent = "@import \"#{UM.remote.stylesheet}\""

    fi = setInterval(->
      try
        style.sheet.cssRules # <--- MAGIC: only populated when file is loaded

        UM.deferreds.stylesheet.resolve()

        clearInterval fi
      return
    , 10)

    $("head").append style

    #link = document.createElement("link")

    #link.id   = "um_stylesheet"
    #link.rel  = "stylesheet"
    #link.type = "text/css"
    #link.href = UM.remote.stylesheet

    #$("head").append link

  # ----------------------------------------------
  # UM->BOOTSTRAP --------------------------------
  # ----------------------------------------------
  bootstrap: () ->

    return if UM.state.bootstrapped

    trace "UM.bootstrap"
    
    # Extend the UM config with the user-supplied config
    # ----------------------------------------------
    $.extend true, UM, UM.script.config

    # Since we have the name, we can now define the paths
    # --------------------------------------------
    $.extend UM.remote,
      stylesheet:    "#{UM.remote.url}/#{UM.name.system}.css"
      script:        "#{UM.remote.url}/#{UM.name.system}.js"

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
      $(document).ready UM.onDocumentReady

      true

    )()

    UM.state.bootstrapped = true

    this

  # ------------------------------------------------
  # UM->POST ---------------------------------------
  # ------------------------------------------------
  post: () ->
    trace "UM.post"

    $("body").show()
    $("#UM_load_block").remove()
  
  # ----------------------------------------------
  # UM->START ------------------------------------
  # ----------------------------------------------
  start: () ->
    trace "UM.start"

    UM.bootstrap.call this

  # ------------------------------------------------
  # ELEMENTS->MODIFICATION -------------------------
  # ------------------------------------------------
  hideWhenReady: (selector, options={}) ->

    $(selector).ready () ->

      $(selector).hide().css
        display: "none !important"

      options.ready() if options.ready

