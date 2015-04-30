'use strict'

$('#helpAccountDiv .error_message').css('opacity', '0');

# user could be found
<% if not @has_user_already_registered %>
$('#helpAccountDiv form').slideUp()
$('#helpAccountDiv .error_message .text').html("")
$('#helpAccountDiv .alert-success .email').html("<%= @user.email %>")
$('#helpAccountDiv .alert-success').slideDown()
  
# user could not be found
<% else %>
$('#helpAccountDiv .submit-form').button('reset')
<% if !@user %>
$('#helpAccountDiv .error_message .text').html("No one with this email address has joined Neonia")
<% elsif @has_user_already_registered %>
$('#helpAccountDiv .error_message .text').html("You have already signed up for an account. If you forgot your username and/or password, please click \"I forgot my password\" on the login page")
<% end %>
$('#helpAccountDiv .error_message').animate({ opacity: 1 }, 500)
<% end %>