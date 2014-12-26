#= require jquery

@hideElements = (elements) ->
  $(elements.join(",")).hide()

@hide = (selectors...) ->
  hideElements selectors
