'use strict'

window.clearErrors()

<% if @user and @user.errors.any? %>
  
# reset submit button
$('.submit-form').button("reset")

<% @user.errors.full_messages.each do |error| %>

window.addError("<%= error %>")

<% end %>
<% elsif @user_password_reset_successful %>
$('form').slideUp()
$('#success-div').slideDown()
<% end %>