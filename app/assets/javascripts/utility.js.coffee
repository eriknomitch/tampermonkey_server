#= require jquery

@trace = (message) ->
  try
    console.log message
  catch error
    alert message

@GM_post = () ->
  $("body").show()
  $("#GM_load_block").remove()

@hideElements = (elements) ->
  $(elements.join(",")).hide()

@hide = (selectors...) ->
  hideElements selectors
