#= require jquery

@trace = (message) ->
  try
    console.log message
  catch error
    alert message

@hideElements = (elements) ->
  $(elements.join(",")).hide()

@hide = (selectors...) ->
  hideElements selectors
