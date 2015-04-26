ready = ->
  
  'use strict'
  

  
  # LOGIN PAGE
  # reset button on page reload
  $('.submit-form').button('reset') 
  $('.submit-form').prop('disabled', false)
  # hide error message
  $('.error_message').css('opacity', '0')
  # hide alerts
  $('.alert-success').hide(0)
  
  # hide helpDivs
  $('#helpAccountDiv').hide(0)
  $('#helpPasswordDiv').hide(0)
  
  #on click on helpAccountButton, show helpAccountDiv
  $('#helpAccountButton').click ->
    $('#signInDiv').slideUp()
    $('#helpAccountDiv').slideDown()
    
  #on click on helpPasswordButton, show helpPasswordDiv
  $('#helpPasswordButton').click ->
    $('#signInDiv').slideUp()
    $('#helpPasswordDiv').slideDown()
  
  #on close button, hide helpDivs and show signInDiv
  $('.close-button').click ->
    $('#helpAccountDiv').slideUp()
    $('#helpPasswordDiv').slideUp()
    $('#signInDiv').slideDown()
  
  # SUBMIT USER FORM ON CLICK
  $('.submit-form').click ->
    # toggle loading state
    $(this).button('loading')
    
$(document).ready(ready)
$(document).on('page:load', ready)