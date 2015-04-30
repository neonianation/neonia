'use strict'

$('#helpPasswordDiv .error_message').css('opacity', '0');

# user could be found
<% if @user %>
$('#helpPasswordDiv form').slideUp()
#$('#helpPasswordDiv .alert-success .email').html("<%= @user.email %>")
$('#helpPasswordDiv .alert-success').slideDown()
  
# user could not be found
<% else %>
$('#helpAccountDiv .submit-form').button('reset')
$('#helpAccountDiv .error_message').animate({ opacity: 1 }, 500)
<% end %>