ready = ->
  
  'use strict'
  
  # SUBMIT USER FORM ON CLICK
  $('#signInDiv .submit-form').click ->
    # toggle loading state
    $(this).button('loading')
    
$(document).ready(ready)
$(document).on('page:load', ready)