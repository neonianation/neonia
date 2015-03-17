$ ->
  
  'use strict'

  initSkrollr = ->
    if !(/Android|iPhone|iPad|iPod|BlackBerry|Windows Phone/i).test(navigator.userAgent or navigator.vendor or  window.opera)
      s = skrollr.init({
      forceHeight: false
      })

      #$(document).on 'page:load', ->
      #  skrollr.init().refresh(); 

      #The options (second parameter) are all optional. The values shown are the default values.
      skrollr.menu.init(s, {
      #skrollr will smoothly animate to the new position using `animateTo`.
      animate: true,

      #The easing function to use.
      easing: 'sqrt',

      #Multiply your data-[offset] values so they match those set in skrollr.init
      scale: 2,

      #How long the animation should take in ms.
      duration: (currentTop, targetTop) ->
      #By default, the duration is hardcoded at 500ms.
          return 500;

          #But you could calculate a value based on the current scroll position (`currentTop`) and the target scroll position (`targetTop`).
          #return Math.abs(currentTop - targetTop) * 10;
      ,

      #By default skrollr-menu will only react to links whose href attribute contains a hash and nothing more, e.g. `href="#foo"`.
      #If you enable `complexLinks`, skrollr-menu also reacts to absolute and relative URLs which have a hash part.
      #The following will all work (if the user is on the correct page):
      #http://example.com/currentPage/#foo
      #http://example.com/currentDir/currentPage.html?foo=bar#foo
      #/?foo=bar#foo
      complexLinks: false,

      #This event is triggered right before we jump/animate to a new hash.
      #change: (newHash, newTopPosition) ->
      })
  
  
  #homeResize function makes sure home bg image is same height as dark overlay
  homeResize = ->
    if $("#home > .overlay").height() < $(window).height()
      $("#home > .overlay").height($(window).height())    
    $("#home").height($("#home > .overlay").height())
    initSkrollr()
    $('[data-spy="scroll"]').each ->
      $spy = $(this).scrollspy('refresh')
  
  $(window).resize(homeResize).triggerHandler "resize"
  homeResize()
  
  # close mobile menu on click. adapted from: http://stackoverflow.com/questions/16680543/hide-twitter-bootstrap-nav-collapse-on-click
  $('.nav a').on 'click', ->
    $(".navbar-toggle:visible").click() #bootstrap 3.x by Richard

  $('.hover-icon').click ->
    $('.hover-icon.active').removeClass("active")
    $(this).addClass("active")
    
