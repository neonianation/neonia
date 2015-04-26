'use strict'

$('#helpAccountDiv .error_message').css('opacity', '0');

# user could be found
<% if @user %>
$('#helpAccountDiv form').slideUp()
$('#helpAccountDiv .alert-success .email').html("<%= @user.email %>")
$('#helpAccountDiv .alert-success').slideDown()
  
# user could not be found
<% else %>
$('#helpAccountDiv .submit-form').button('reset')
$('#helpAccountDiv .error_message').animate({ opacity: 1 }, 500)
<% end %>