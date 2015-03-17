$ ->
  
  'use strict'
  
  #homeResize function makes sure home bg image is same height as dark overlay
  homeResize = ->
    if $("#home > .overlay").height() < $(window).height()
      $("#home > .overlay").height($(window).height())
      $("#home").height($("#home > .overlay").height())
    skrollr.init().refresh()
    $('[data-spy="scroll"]').each ->
      $spy = $(this).scrollspy('refresh')
  
  $(window).resize(homeResize).triggerHandler "resize"
  homeResize
  
  # close mobile menu on click. adapted from: http://stackoverflow.com/questions/16680543/hide-twitter-bootstrap-nav-collapse-on-click
  $('.nav a').on 'click', ->
    $(".navbar-toggle:visible").click() #bootstrap 3.x by Richard

  $('.hover-icon').click ->
    $('.hover-icon.active').removeClass("active")
    $(this).addClass("active")
    
