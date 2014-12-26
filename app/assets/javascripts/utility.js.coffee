#= require jquery

@hideElements = (elements) ->
  $(elements.join(",")).hide()

@hidden = (selectors...) ->
  hideElements selectors
