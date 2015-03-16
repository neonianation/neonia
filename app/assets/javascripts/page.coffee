$ ->
  #homeResize function makes sure home bg image is same height as dark overlay
  homeResize = ->
    $("#home").height($("#home > .overlay").outerHeight())
  
  $(window).resize(homeResize).triggerHandler "resize"
    