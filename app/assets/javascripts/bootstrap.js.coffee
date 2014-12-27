# ================================================
# COFFEE->
# ================================================

# ------------------------------------------------
# GM->BOOTSTRAP ----------------------------------
# ------------------------------------------------
@GM_bootstrap = (GM) ->
  trace "GM_bootstrap"

  GM.remote =
    suffix:   "/assets/"
    protocol: "https://"

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
    if unsafeWindow.$

      $.extend GM.remote,
        urlNoProtocol: "//#{GM.domain}#{GM.remote.suffix}"
        url:           "#{GM.remote.protocol}#{GM.remote.urlNoProtocol}"
        stylesheet:    "#{GM.remote.url}/#{GM.name.system}.css"
        script:        "#{GM.remote.url}/#{GM.name.system}.js"
  
      $(document).ready ->

        trace "document ready"

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

        return

      return true

    setTimeout GM_initializeWhenjQueryReady, 1
  )()

# ------------------------------------------------
# GM->START --------------------------------------
# ------------------------------------------------
@GM_start = () ->
  trace "GM_start"
  GM_bootstrap.call this, GM_config

# ------------------------------------------------
# GM->POST ---------------------------------------
# ------------------------------------------------
@GM_post = () ->
  $("body").show()
  $("#GM_load_block").remove()

