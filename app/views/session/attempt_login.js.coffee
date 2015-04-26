'use strict'

$('#error_message').css('opacity', '0');

<% if !@user_authentication_successful %>
$('#signInDiv .submit-form').button("reset")
$('#error_message').animate({ opacity: 1 }, 500)
<% elsif @redirect_path.present? %>
window.location.href = "<%= @redirect_path %>"
<% end %>