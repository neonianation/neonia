ready = ->
  
  'use strict'
  
  $('#signInDiv .submit-form').button('reset')
  $('#signInDiv .submit-form').prop('disabled', false)
  $('#error_message').css('opacity', '0');
  
  # SUBMIT USER FORM ON CLICK
  $('#signInDiv .submit-form').click ->
    # toggle loading state
    $(this).button('loading')
    
$(document).ready(ready)
$(document).on('page:load', ready)