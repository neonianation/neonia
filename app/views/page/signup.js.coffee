'use strict'

window.clearErrors()

<% if @user.errors.any?
  @user.errors.full_messages.each do |error| %>

# reset submit button
$('#user-form .submit-form').button("reset")
window.addError("<%= error %>")

<% end
else %>
$("#user-form").next().html("Thanks, <%= @user.name %>, for joining us! You opted <%= @user.subscribe %> <%= @user.subscribe ? 'in' : 'out' %>.<br/><%= @user.photo.url %>")
$("#user-form").slideUp()
<% end %>