$ ->
  #homeResize function makes sure home bg image is same height as dark overlay
  homeResize = ->
    $("#home").height($("#home > .overlay").outerHeight())
  
  $(window).resize(homeResize).triggerHandler "resize"
  
  #smooth scrolling from https://css-tricks.com/snippets/jquery/smooth-scrolling/
#  $('a[href*=#]:not([href=#])').bind 'click', (event) ->
#    if location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') and location.hostname == this.hostname
#      target = $(this.hash)
#      target = if target.length then target else $('[name=' + this.hash.slice(1) +']')
#      if target.length
#        $('html,body').animate({
#          scrollTop: target.offset().top
#        }, 1000);
#        return false;
  