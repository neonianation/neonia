'use strict'

$('#signInDiv .submit-form').button("reset")
$('#error_message').css('opacity', '0');

<% if @user_is_already_registered %>
# password reset option
alert "You are registered!!"
<% else %>
# welcome user
$("#user-returned .photo").css('background-image', 'url(<%= @user.photo.url %>)')
$("#user-returned span.name").html("<%= @user.name %>")

$("#emailCheckDiv").slideUp()
$("#user-returned").slideDown()
<% end %>