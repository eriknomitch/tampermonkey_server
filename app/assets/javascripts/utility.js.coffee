#= require jquery

@trace = (message) ->
  try
    console.log message
  catch error
    alert message

@hideElements = (selectors) ->
  $(selectors.join(",")).hide()

@hide = (selectors...) ->
  hideElements selectors

@hideImportant = (selectors...) ->
  $(selectors.join(",")).css
    display: "none !important"

