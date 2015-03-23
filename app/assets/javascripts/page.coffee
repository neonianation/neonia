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
#  homeResize = ->
#    if $("#home > .overlay").height() < $(window).height()
#      $("#home > .overlay").height($(window).height())    
#    $("#home").height($("#home > .overlay").height())
#    initSkrollr()
#    $('[data-spy="scroll"]').each ->
#      $spy = $(this).scrollspy('refresh')
#  
#  $(window).resize(homeResize).triggerHandler "resize"
#  homeResize()
  
  # close mobile menu on click. adapted from: http://stackoverflow.com/questions/16680543/hide-twitter-bootstrap-nav-collapse-on-click
  $('.nav a').on 'click', ->
    $(".navbar-toggle:visible").click() #bootstrap 3.x by Richard

    
  # show the correct tab when clicking on the new-world icons
  $('#new-world .hover-icon').click ->
    if !$(this).hasClass("active")
      # make the right button highlighted
      $('#new-world .hover-icon.active').removeClass("active")
      $(this).addClass("active")

      # make the right tab show up
      $('#new-world .tab-pane.activated').removeClass("activated").hide()
      $('#new-world .tab-pane:nth-child('+(parseInt($(this).attr("id").substr("new-world_icon_".length))+1)+')').addClass("activated").fadeIn()
      
  # if checkbox is NOT checked, then hide e-mail field
  if !$('#user-form input[type="checkbox"]').is(':checked')
    $('#user-form .email').hide()
  
  # show e-mail field when checking subscribe checkbox
  $('#user-form input[type="checkbox"]').change ->
    $(this).parent().toggleClass("btn-success")
    $(this).parent().next().slideToggle() # toggle help text
    $('#user-form .email').slideToggle() # toggle email field
    
  # check for focus event
  $('#user-form input[type="file"]').focus ->
    $(this).parent().addClass("active")
    
  $('#user-form input[type="file"]').focusout ->
    $(this).parent().removeClass("active")
    
  # show image preview
  # script from: http://www.munocreative.com/nerd-notes/justpayme
  $('#user-form input[type="file"]').change ->
    readURL(this)
    
  readURL = (input) ->
    
    # validate image
    # from: http://www.sanwebe.com/2013/10/check-input-file-size-before-submit-file-api-jquery
    #get the file size and file type from file input field
    fsize = input.files[0].size
    ftype = input.files[0].type
    fname = input.files[0].name
      
    switch ftype
      when 'image/png', 'image/gif', 'image/jpeg', 'image/pjpeg'
        alert "Acceptable image file!"
      else
        alert 'Unsupported File!'
    
    if input.files && input.files[0]
      reader = new FileReader()

      reader.onload = (e) ->
        $('#user-form .upload-photo').css('background-image', 'url(' + e.target.result + ')')
        $('#user-form .upload-photo').css('background-size', 'cover')
        #$('.photoUpload, #uploadClick').hide();
        
      #$('.deletePhoto').show();
      
      reader.readAsDataURL(input.files[0])
    
  return