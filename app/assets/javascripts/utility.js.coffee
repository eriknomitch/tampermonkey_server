#= require jquery

@trace = (message) ->
  try
    console.log message
  catch error
    alert message

@performPost = () ->
  console.log "post"
  $("body").show()
  $("#GM_load_block").remove()

@hideElements = (elements) ->
  $(elements.join(",")).hide()

@hide = (selectors...) ->
  hideElements selectors
