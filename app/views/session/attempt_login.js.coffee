'use strict'

$('#signInDiv .error_message').css('opacity', '0');

<% if !@user_authentication_successful %>
$('#signInDiv .submit-form').button("reset")
$('#signInDiv .error_message').animate({ opacity: 1 }, 500)
<% elsif @redirect_path.present? %>
# hack to get the correct de-coded redirect url
div = document.createElement('div')
div.innerHTML = '<%= @redirect_path %>'
decoded_url = div.firstChild.nodeValue
window.location.href = decoded_url
<% end %>